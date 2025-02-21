#!/bin/bash

URL="https://www.tooplate.com/zip-templates/2106_soft_landing.zip"
NAME="2106_soft_landing"
TEMPDIR="/tmp/webfiles"

yum --help &> /dev/null

if [[ $? -eq 0 ]]; then
	PACKAGES="httpd wget unzip"
	SVC="httpd"
	echo "Running Setup on CentOS"
   	# Installing Dependencies
   	echo "########################################"
   	echo "Installing packages."
   	echo "########################################"
	sudo yum install ${PACKAGES} -y > /dev/null
	
	echo "########################################"
        echo "Enabling Services"
        echo "########################################"
	sudo systemctl start $SVC
	sudo systemctl enable $SVC
	
	echo "########################################"
        echo "ARTIFACT DEPLOYMENT."
        echo "########################################"
	mkdir -p $TEMPDIR
	cd $TEMPDIR

	wget $URL > /dev/null
	unzip ${NAME}.zip > /dev/null
	sudo cp -r $NAME/* /var/www/html/

	echo "########################################"
        echo "RESTARTING SERVICE."
        echo "########################################"
	sudo systemctl restart $SVC

	rm -rf $TEMPDIR

	sudo systemctl status $SVC
	ls /var/www/html

else
        PACKAGES="apache2 wget unzip"
        SVC="apache2"
        echo "Running Setup on Ubuntu"
        # Installing Dependencies
        echo "########################################"
        echo "Installing packages."
        echo "########################################"
	sudo apt update 
        sudo apt install ${PACKAGES} -y > /dev/null

        echo "########################################"
        echo "Enabling Services"
        echo "########################################"
        sudo systemctl start $SVC
        sudo systemctl enable $SVC

        echo "########################################"
        echo "ARTIFACT DEPLOYMENT."
        echo "########################################"
        mkdir -p $TEMPDIR
        cd $TEMPDIR

        wget $URL > /dev/null
        unzip ${NAME}.zip > /dev/null
        sudo cp -r $NAME/* /var/www/html/

        echo "########################################"
        echo "RESTARTING SERVICE."
        echo "########################################"
        sudo systemctl restart $SVC

        rm -rf $TEMPDIR

        sudo systemctl status $SVC
        ls /var/www/html
fi
