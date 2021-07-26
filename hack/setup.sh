#!/bin/bash
source ./env.sh
if [[ $(oc project ${TEST_NAMESPACE} -q) != ${TEST_NAMESPACE} ]]
then 
  echo "Project does NOT exist"
  oc new-project ${TEST_NAMESPACE}

else
  echo "Project exist. Skip creation"
fi

echo "
apiVersion: v1
kind: ServiceAccount
metadata:
  name: ${MANIFESTS_NAME}-sa
  namespace: ${TEST_NAMESPACE}" | oc create -f -

oc adm policy add-cluster-role-to-user cluster-admin -z ${MANIFESTS_NAME}-sa -n ${TEST_NAMESPACE}
