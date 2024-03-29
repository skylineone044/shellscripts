#!/bin/bash


id $1

if [ $? -eq 0 ]
then
    echo "error: user $1 exists"
    exit 1
fi


sudo useradd -m $1
sudo usermod -aG sftp_users $1
echo "created user $1 and added to sftp_users"
echo ""

sudo -u $1 mkdir /home/$1/.ssh
sudo -u $1 touch /home/$1/.ssh/authorized_keys
echo "created file /home/$1/.ssh/authorized_keys"
echo ""

sudo -u $1 ssh-keygen -f "/home/$1/.ssh/$1_sftp_rsa" -t rsa
echo "key generated"
echo ""

#copy contents of the pub file into authorized_keys abd then remove it
sudo -u $1 cat "/home/$1/.ssh/$1_sftp_rsa.pub" | sudo -u $1 tee /home/$1/.ssh/authorized_keys
sudo rm "/home/$1/.ssh/$1_sftp_rsa.pub"
#move te private key to desktop
sudo mv "/home/$1/.ssh/$1_sftp_rsa" /home/hostpc/Desktop
sudo chmod 644 /home/$1/.ssh/authorized_keys
echo "authorization set up"
echo ""

sudo mv "/home/$1" "/mnt/mass/sftp"
#linking the home dir to the server's home for the ssh daemon to find the pub key
sudo ln -s /mnt/mass/sftp/$1/ /home/$1
echo "moved home to /mnt/mass/sftp/"
