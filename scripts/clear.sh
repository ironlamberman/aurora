#! /bin/bash

cd /etc/ceph

i=1
count=$[$i+5]
dev="/dev/rbd"
directory="/mnt/rbd_test"
log="/root/log"

while [ $i -ne $count ]
do

umount $directory$i
rm -r $directory$i
rm -rf $log"/"rbd_test$i
rbd unmap "/dev/"rbd$i
rbd rm rbd_test$i

i=$[$i+1]
done
