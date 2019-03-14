#!/bin/bash
sleep 9
brctl addbr vbr

sleep 1
brctl stp vbr on

sleep 1
ip link add vxa type vxlan id 63 remote 192.168.10.65 dstport 4789 dev eth0
sleep 1
ip link set vxa up
sleep 1
brctl addif vbr vxa

sleep 1
ip link add vxb type vxlan id 62 remote 192.168.10.62 dstport 4789 dev eth0
sleep 1
ip link set vxb up
sleep 1
brctl addif vbr vxb

sleep 1
ifconfig vbr 10.11.12.63/24 up


