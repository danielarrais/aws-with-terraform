#! /bin/bash

function format_ebs_volumes() {
    DEVICE="/dev/xvdf"
    MOUNT_POINT="/mnt/ebs_vol"

    # Espera o volume estar disponível
    while [ ! -e $DEVICE ]; do sleep 1; done

    # Formata (caso ainda não esteja)
    if ! file -s $DEVICE | grep -q "ext4"; then
      mkfs.ext4 $DEVICE
    fi

    mkdir -p $MOUNT_POINT
    mount $DEVICE $MOUNT_POINT

    echo "$DEVICE $MOUNT_POINT ext4 defaults,nofail 0 2" >> /etc/fstab
}

function mount_efs() {
    EFS_DNS="${efs_dns}"
    MOUNT_POINT="/mnt/efs"

    # Espera o DNS responder (útil para inicialização da rede)
    while ! ping -c 1 -W 1 $EFS_DNS &> /dev/null; do sleep 1; done

    # Instala NFS utils se necessário
    if ! command -v mount.nfs4 &> /dev/null; then
        if command -v apt &> /dev/null; then
            sudo apt update -y
            sudo apt install -y nfs-common
        elif command -v dnf &> /dev/null; then
            sudo dnf install -y nfs-utils
        fi
    fi

    mkdir -p $MOUNT_POINT
    mount -t nfs4 -o nfsvers=4.1 $EFS_DNS:/ $MOUNT_POINT
    echo "$EFS_DNS:/ $MOUNT_POINT nfs4 defaults,_netdev 0 0" | sudo tee -a /etc/fstab
}

format_ebs_volumes
mount_efs

# Install Docker
sudo dnf update -y
sudo dnf install docker -y

# Auto start Docker when starting the machine
sudo systemctl start docker
sudo systemctl enable docker

# Start nginx container
sudo docker run -it --rm -d -p 80:80 --name web nginxdemos/hello