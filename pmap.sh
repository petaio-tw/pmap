#!/bin/bash
startAddrStr=$1
offset=$2
step=$3
loop=$4

#echo the vaddr is :   $startAddrStr
#echo the offset is :  $offset
#echo the step is :    $step
#echo the loop is :    $loop

 
pid=$(ps -ef | grep "./vfio.o" | awk 'NR==1{print $2}')
#echo  "the VFIO PID is: " $pid 

#addrRangeStr=$(cat /proc/$pid/maps |grep "/usr/lib64/ld-2.28.so" -A1 | grep rw-p | awk '{print $1}' | sed -n '1p')
#echo $addrRangeStr

let startAddrNum=16#$startAddrStr
#echo $startAddrNum
let vaddr=startAddrNum+offset

#echo the first vaddr is : $vaddr 

vaddr_0x=$(printf "%x" $vaddr)

for ((i=1; i<=loop; i++))
do 
   echo "**************************************************"
   #echo the current vaddr is : $vaddr_0x 
   ./pmap.o $pid $vaddr_0x
   
   vaddr=$[$vaddr+$step]
   vaddr_0x=$(printf "%x" $vaddr)
   
done


