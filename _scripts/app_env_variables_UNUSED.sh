#!/bin/bash

echo "*------------------------------------------------------------------------------"
echo "* Environment Variables setzten"
echo "*------------------------------------------------------------------------------"

ENV_CONFIG=/etc/profile.d/app_env.sh
echo ""                               >  $ENV_CONFIG
echo "export DB_HOST=$HOST"           >> $ENV_CONFIG
echo "export DB_PORT=$PORT"           >> $ENV_CONFIG
echo "export DB_ROOT_PW=$ROOT_PW"     >> $ENV_CONFIG
echo "export DB_USER=$USER_DB"        >> $ENV_CONFIG
echo "export DB_USER_PW=$USER_DB_PW"  >> $ENV_CONFIG
echo "export DB_PRODUCTION=$PROD_DB"  >> $ENV_CONFIG
echo "export DB_DEVELOPMENT=$DEV_DB"  >> $ENV_CONFIG
echo "export DB_TEST=$TEST_DB"        >> $ENV_CONFIG

chmod 755 $ENV_CONFIG