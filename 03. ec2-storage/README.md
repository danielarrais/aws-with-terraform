## EC2 Storage

We can connect different storages types on our ec2 instances: EBS (elastic block store) ans EFS (elastic file system).
They are useful in some scenarios.

### EBS Volumes

An EBS (elastic Block Store) Volume is a network drive can attach to your instances while they run. Its allow our
instances to persist data, even after their termination. 

- An EBS volume can be mounted to one instance at a time
- We can attach one or more volumes by instance
- EBS Volumes is like a network USB
- When the connection occur by network we might a bit of latency
- An EBS volume can be detached from a EC2 volume and attached to another one quickly
- They are bound to a specific availability zone, so a volume on "us-east-1-a" cannot be attached to "us-east-1-a". 
- To move a volume across zones we can use snapshots
- We can increase the size of a created volume
- We 