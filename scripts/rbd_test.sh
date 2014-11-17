#! /bin/bash

cd /etc/ceph

i=1
count=$[$i+5]
dev="/dev/rbd"
directory="/mnt/rbd_test"
log="/root/log"
while [ $i -ne $count ]
do
rbd -p rbd create --size 20000 rbd_test$i
rbd -p rbd map rbd_test$i
mkfs.ext4 $dev$i
mkdir $directory$i
mkdir $log"/"rbd_test$i
mount $dev$i $directory$i

dd if=/dev/zero of=/mnt/rbd_test$i/deletme bs=4K count=10000 oflag=direct &> $log"/"rbd_test$i/rbd_test_4k$i.log &.
dd if=/dev/zero of=/mnt/rbd_test$i/deletme bs=512K count=1000 oflag=direct &> $log"/"rbd_test$i/rbd_test_512k$i.log &
dd if=/dev/zero of=/mnt/rbd_test$i/deletme bs=1024K count=2000 oflag=direct &> $log"/"rbd_test$i/rbd_test_1024k$i.log &
i=$[$i+1]
done
