#!/bin/bash
source ./pod_variables

podman pod create --name ${POD} -p ${EXT_PORT}:80
mkdir -p ${CONTAINER_ROOT}/{${DB_DIRECTORY},${WEB_DIRECTORY}}
chmod 777 ${CONTAINER_ROOT}/${WEB_DIRECTORY}
# For SuiteCRM7:
#mkdir ./temp
#unzip ${SOURCE_FILE} -d ./temp
#SUBDIR=$(ls ./temp)
#mv ./temp/${SUBDIR}/* ${CONTAINER_ROOT}/${WEB_DIRECTORY}
#rm -rf ./temp
# For SuiteCRM8
unzip ${SOURCE_FILE} -d ${CONTAINER_ROOT}/${WEB_DIRECTORY}
# SuiteCRM7:
#chmod 766 ${CONTAINER_ROOT}/${WEB_DIRECTORY}/custom
#chmod 777 ${CONTAINER_ROOT}/${WEB_DIRECTORY}/cache
#chmod 777 ${CONTAINER_ROOT}/${WEB_DIRECTORY}/cache/include/javascript
#chmod -R 777 ${CONTAINER_ROOT}/${WEB_DIRECTORY}/modules/
#chmod 777 ${CONTAINER_ROOT}/${WEB_DIRECTORY}/upload/
# SuiteCRM8:
chmod -R 777 ${CONTAINER_ROOT}/${WEB_DIRECTORY}/logs
chmod -R 777 ${CONTAINER_ROOT}/${WEB_DIRECTORY}/public/legacy/upload
chmod -R 777 ${CONTAINER_ROOT}/${WEB_DIRECTORY}/public/legacy/custom
chmod -R 777 ${CONTAINER_ROOT}/${WEB_DIRECTORY}/public/legacy/cache
chmod -R 777 ${CONTAINER_ROOT}/${WEB_DIRECTORY}/public/legacy/modules
chmod -R 777 ${CONTAINER_ROOT}/${WEB_DIRECTORY}/extensions
chmod -R 777 ${CONTAINER_ROOT}/${WEB_DIRECTORY}/.env
chmod -R 777 ${CONTAINER_ROOT}/${WEB_DIRECTORY}/cache
chmod 777 ${CONTAINER_ROOT}/${WEB_DIRECTORY}/public/legacy
chmod -R 777 ${CONTAINER_ROOT}/${WEB_DIRECTORY}/public/legacy/install

podman run -d --name ${CRM_DB_NAME} --pod ${POD} \
 -e MYSQL_ROOT_PASSWORD=${DB_ROOT_PASS} \
 -e MYSQL_DATABASE=${CRM_DB} \
 -e MYSQL_USER=${DB_USER} \
 -e MYSQL_PASSWORD=${DB_USER_PASS} \
 -v ${CONTAINER_ROOT}/${DB_DIRECTORY}:/var/lib/mysql:Z \
docker.io/library/mariadb:11.8 \
--sql_mode="STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION" 

podman run -d --name ${CRM_WEB_NAME} --pod ${POD} \
 -v ${CONTAINER_ROOT}/${WEB_DIRECTORY}:/var/www/html:Z \
localhost/web4crm:latest

echo "Finish setup using these values:"
echo "Database Name: ${CRM_DB_NAME}"
echo "Host Name: 127.0.0.1"
echo "User: ${DB_USER}"
echo "Password: ${DB_USER_PASS}"
echo -e "\nIf running on a non-standard port, you must enable SELinux to serve web requests on that port with the following:"
echo "sudo semanage port -a -t http_port_t -p tcp <port>"
echo -e "This is even necessary if using a proxy to redirect to a port such as 8080\n"
