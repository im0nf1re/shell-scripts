#!/bin/bash
sudo rm -r /var/www/$1
sudo a2dissite $1
sudo rm /etc/apache2/sites-available/$1.conf

sudo sed -i "/$1.loc/d" /etc/hosts

sudo service apache2 restart

echo -e "\nVirtual Host Deleted Successfully!"
