set -ux 

OS_PROJECT_NAME="bob"
: ${CLOUD_NAME:="${OS_PROJECT_NAME}"}
: ${CONTROLLER_NAME:="${OS_PROJECT_NAME}-${CLOUD_NAME}"}
: ${MODEL_NAME:="${OS_PROJECT_NAME:0:12}-${CLOUD_NAME}"}

echo juju switch $CONTROLLER_NAME ||\
    echo time juju bootstrap ${OPENSTACK_PUBLIC_IP} \
                        --auto-upgrade=false \
                        --model-default=juju-configs/model-default.yaml \
                        --config=juju-configs/controller-default.yaml \
                        $CLOUD_NAME $CONTROLLER_NAME arch=s390x

echo juju switch $CONTROLLER_NAME ||\
      echo time juju bootstrap --bootstrap-constraints "$BOOTSTRAP_CONSTRAINTS" \
                          --constraints "$MODEL_CONSTRAINTS" \
                          --auto-upgrade=false \
                          --model-default=juju-configs/model-default.yaml \
                          --config=juju-configs/controller-default.yaml \
                          $BOOTSTRAP_PLACEMENT \
                          $CLOUD_NAME $CONTROLLER_NAME

