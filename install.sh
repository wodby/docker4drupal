#!/bin/sh
cd web
accountName=''
accountPass=''
if [ -n $PROJECT_ADMIN_PASS ]; then
    accountName="--account-name=${PROJECT_ADMIN_NAME}"
fi
if [ -n $PROJECT_ADMIN_PASS ]; then
    accountPass="--account-pass=${PROJECT_ADMIN_PASS}"
fi
drush si --db-url=mysql://$DB_USER:$DB_PASSWORD@mariadb:$DB_PORT/$DB_NAME $accountName $accountPass -y
