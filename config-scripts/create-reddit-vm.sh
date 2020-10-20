#!/bin/bash
cd "$(dirname "$0")"

. ../secrets/variables.config

yc compute instance create \
    --name $name \
    --zone $zone \
    --network-interface subnet-name=$subnet,nat-ip-version=ipv4 \
    --create-boot-disk image-id=$image_id,type=$disk_type,size=$disk_size_gb \
    --ssh-key $ssh_key \
    --preemptible
