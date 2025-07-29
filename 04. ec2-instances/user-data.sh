#!/bin/bash
set -euxo pipefail

function format_ebs_volumes() {
    DEVICE="/dev/xvdf"
    MOUNT_POINT="/mnt/ebs_vol"

    echo "[INFO] Waiting for EBS volume $DEVICE to be available..."
    for i in {1..60}; do
        if [ -e "$DEVICE" ]; then break; fi
        sleep 1
    done

    if [ ! -e "$DEVICE" ]; then
        echo "[ERROR] EBS device not found: $DEVICE"
        exit 1
    fi

    echo "[INFO] Formatting EBS volume if needed..."
    if ! file -s "$DEVICE" | grep -q "ext4"; then
        mkfs.ext4 "$DEVICE"
    fi

    echo "[INFO] Mounting EBS volume to $MOUNT_POINT"
    mkdir -p "$MOUNT_POINT"
    mount "$DEVICE" "$MOUNT_POINT"
    echo "$DEVICE $MOUNT_POINT ext4 defaults,nofail 0 2" >> /etc/fstab
}

function mount_efs() {
    EFS_DNS="${efs_dns}"
    MOUNT_POINT="/mnt/efs"

    echo "[INFO] Waiting for EFS DNS to resolve and port 2049 to respond..."
    for i in {1..30}; do
        if getent hosts "$EFS_DNS" > /dev/null && timeout 2 bash -c "</dev/tcp/$EFS_DNS/2049" &>/dev/null; then
            echo "[INFO] EFS is accessible at $EFS_DNS:2049"
            break
        fi
        echo "[WAIT] EFS not ready yet... retrying in 2s"
        sleep 2
    done

    if ! timeout 2 bash -c "</dev/tcp/$EFS_DNS/2049" &>/dev/null; then
        echo "[ERROR] EFS is not reachable on port 2049: $EFS_DNS"
        exit 1
    fi

    echo "[INFO] Installing NFS utilities if needed..."
    if ! command -v mount.nfs4 &>/dev/null; then
        if command -v apt &>/dev/null; then
            apt update -y
            apt install -y nfs-common
        elif command -v dnf &>/dev/null; then
            dnf install -y nfs-utils
        fi
    fi

    echo "[INFO] Mounting EFS to $MOUNT_POINT"
    mkdir -p "$MOUNT_POINT"
    mount -t nfs4 -o nfsvers=4.1 "$EFS_DNS:/" "$MOUNT_POINT"
    echo "$EFS_DNS:/ $MOUNT_POINT nfs4 defaults,_netdev 0 0" >> /etc/fstab
}

format_ebs_volumes
mount_efs

echo "[INFO] Installing Docker..."
dnf update -y
dnf install -y docker

echo "[INFO] Enabling and starting Docker..."
systemctl enable --now docker
usermod -aG docker ec2-user

echo "[INFO] Waiting for Docker to be ready..."
for i in {1..30}; do
    if docker info &>/dev/null; then break; fi
    echo "[WAIT] Docker not ready yet... retrying in 2s"
    sleep 2
done

echo "[INFO] Creating sample HTML file..."
mkdir -p /usr/share/nginx/html
echo "<h1>Hello World from $(hostname -f)</h1>" > /usr/share/nginx/html/index.html

echo "[INFO] Starting nginx container on port 80..."
docker run -d \
  --name nginx-hello \
  -p 80:80 \
  -v /usr/share/nginx/html:/usr/share/nginx/html:ro \
  nginx

echo "[DONE] Initialization complete."
