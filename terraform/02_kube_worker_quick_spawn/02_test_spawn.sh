#!/bin/bash

FLAVOR="h2.medium"
SNAPSHOT_NAME="kube_worker-quick-spawn"
USER_DATA_PATH="../../scripts/kube_setup/05w_setup_join_cluster_service.sh"
KEY_NAME="default"

instance_id=$(echo $RANDOM | md5sum | head -c 8)
openstack server create --flavor $FLAVOR --image $SNAPSHOT_NAME --user-data $USER_DATA_PATH \
 --key-name $KEY_NAME "$SNAPSHOT_NAME-test-$instance_id"
