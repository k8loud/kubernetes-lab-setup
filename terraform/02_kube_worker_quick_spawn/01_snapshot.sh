#!/bin/bash

TMP_SERVER_NAME="kube-worker-quick-spawn-tmp"
TARGET_SNAPSHOT_NAME="kube-worker-quick-spawn"
SERVER_LIST_RES_WAIT_S=1

echo "Stopping server $TMP_SERVER_NAME"
openstack server stop $TMP_SERVER_NAME

while : ; do
    server_list_res=$(openstack server list --name $TMP_SERVER_NAME --status SHUTOFF)
    [ -z "$server_list_res" ] || break
    echo "The server's status is not SHUTOFF yet, retry in $SERVER_LIST_RES_WAIT_S seconds"
    sleep $SERVER_LIST_RES_WAIT_S
done

echo "Creating snapshot with name $TARGET_SNAPSHOT_NAME"
openstack server image create $TMP_SERVER_NAME --name $TARGET_SNAPSHOT_NAME

echo "Verifying..."
image_list_res=$(openstack image list --status active --name $TARGET_SNAPSHOT_NAME)

if [ -z "$image_list_res" ]; then
  echo "SUCCESS"
else
  echo "FAILURE"
fi
