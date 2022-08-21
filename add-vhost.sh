#!/bin/bash

mkdir /var/www/$1
sudo chown -R $USER:$USER /var/www/$1
echo "<VirtualHost *:80>
    ServerName $1.loc
    ServerAlias www.$1.loc 
    ServerAdmin webmaster@localhost" | sudo tee /etc/apache2/sites-available/$1.conf
if [ -z ${2+x} ]
then
    echo "    DocumentRoot /var/www/$1" | sudo tee -a /etc/apache2/sites-available/$1.conf
else
    echo "    DocumentRoot /var/www/$1/public

    <Directory /var/www/$1/public>
       Options +FollowSymlinks
       AllowOverride All
       Require all granted
    </Directory>" | sudo tee -a /etc/apache2/sites-available/$1.conf
fi

echo '    ErrorLog ${APACHE_LOG_DIR}/error.log
    CustomLog ${APACHE_LOG_DIR}/access.log combined
</VirtualHost>' | sudo tee -a /etc/apache2/sites-available/$1.conf

echo -e "127.0.0.1\t$1.loc" | sudo tee -a /etc/hosts

sudo a2ensite $1
sudo service apache2 restart

echo -e "\n Virtual Host Created Successfully!"
