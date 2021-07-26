
#!/bin/bash
source ./env.sh

oc project ${TEST_NAMESPACE}

if [[ $1 == create ]]
then
echo "Create OperatorGroup"
cat <<EOF | oc apply -f -
apiVersion: operators.coreos.com/v1
kind: OperatorGroup
metadata:
  annotations:
    olm.providedAPIs: NFSProvisioner.v1alpha1.cache.jhouse.com
  name: nfsprovisioner-operator
spec:
  targetNamespaces:
  - ${TEST_NAMESPACE}
EOF
  
else
  oc delete OperatorGroup nfsprovisioner-operator --ignore-not-found
fi



