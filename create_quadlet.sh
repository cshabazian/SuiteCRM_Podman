#!/bin/bash
source ./pod_variables

mkdir -p ${HOME}/.config/containers/systemd/
cp suite_crm_db.container suite_crm_pod.pod suite_crm_web.container ${HOME}/.config/containers/systemd/
systemctl --user daemon-reload
podman stop ${CRM_DB_NAME} ${suite_crm_application_container}
podman rm ${CRM_DB_NAME} ${suite_crm_application_container}
podman pod rm ${POD}
systemctl --user start suite_crm_db
systemctl --user start suite_crm_web
