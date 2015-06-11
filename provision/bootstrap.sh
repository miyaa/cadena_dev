#!/usr/bin/env bash


echo "Disable SELINUX & firewall"
sudo systemctl stop firewalld
sudo systemctl disable firewalld
sudo sed -i -e s/SELINUX=enforcing/SELINUX=disabled/ /etc/selinux/config
sudo setenforce 0
sudo systemctl restart network

date > /etc/bootstrapped
