oc process -f ./roles/openshift_hosted_templates/files/v1.4/origin/metrics-deployer.yaml    -v HAWKULAR_METRICS_HOSTNAME=hawkular-metrics-openshift-infra.apps.140.86.55.167.xip.io -v CASSANDRA_PV_SIZE=10Gi -v MASTER_URL=https://10.1.1.101:8443 -v IMAGE_VERSION=v1.4.1 | oc create -f -
