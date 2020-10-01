#!/bin/sh

#WORDPRESS INSTALL
echo "Enter the full path for your wordpress installation ..."
read INSTALL_PATH
echo "Confirm  wordpress installation in ${INSTALL_PATH}, Do you want to continue? [Y/n]"
read CONFIRM_INSTALL_LOCATION
if [ "$CONFIRM_INSTALL_LOCATION" != "${CONFIRM_INSTALL_LOCATION#[Yy]}" ] ;then
    rm ${INSTALL_PATH}/index.html
    wget "https://wordpress.org/latest.zip" -P ${INSTALL_PATH}
    unzip ${INSTALL_PATH}/latest.zip -d ${INSTALL_PATH}
    mv ${INSTALL_PATH}/wordpress/* ${INSTALL_PATH}
    rm -R ${INSTALL_PATH}/wordpress latest.zip
    chmod 775 -R ${INSTALL_PATH}
    chown -R  www-data:www-data ${INSTALL_PATH}
    echo "Success: Wordpress installed ..."
else
    echo "Error: the WordPress installer was skipped ..."
fi

rm -- "$0"
exit
