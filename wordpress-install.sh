#!/bin/sh

if [ -z "$1" ]
    then
        echo -e "\e[32menter the full path for your wordpress installation ... \e[39m"
        read INSTALL_PATH
        echo -e "\e[32mconfirm  wordpress installation in ${INSTALL_PATH}, Do you want to continue? [Y/n] \e[39m"
        read CONFIRM_INSTALL_LOCATION
    else
    INSTALL_PATH=${1}
    CONFIRM_INSTALL_LOCATION="y"
fi

INSTALL_PATH=$(realpath -s --canonicalize-missing $INSTALL_PATH)

if [ "$CONFIRM_INSTALL_LOCATION" != "${CONFIRM_INSTALL_LOCATION#[Yy]}" ] ;then
    rm ${INSTALL_PATH}/index.html
    wget "https://wordpress.org/latest.zip" -P ${INSTALL_PATH}
    unzip ${INSTALL_PATH}/latest.zip -d ${INSTALL_PATH}
    mv ${INSTALL_PATH}/wordpress/* ${INSTALL_PATH}
    rm -R ${INSTALL_PATH}/wordpress ${INSTALL_PATH}/latest.zip
    chmod 775 -R ${INSTALL_PATH}
    chown -R  www-data:www-data ${INSTALL_PATH}
    echo "updating apache2 default virtual host for directory ${INSTALL_PATH} ..."
    sed -i "s#/var/www/html#${NEW_INSTALL_PATH}#" /etc/apache2/sites-available/000-default.conf
    echo "restarting apache2 ..."
    systemctl restart apache2
    echo "success: wordpress installed ..."
else
    echo "notice: the wordpress installer was skipped by user..."
fi

#SELF DELETE AND EXIT
rm -- "$0"
exit
