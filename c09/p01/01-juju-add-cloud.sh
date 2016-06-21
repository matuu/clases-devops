echo "*** agregando cloud: um-cloud"
cat > um-cloud.yaml <<EOF
clouds:
  um-cloud:
    type: openstack
    auth-types: [ userpass ]
    regions:
      $OS_REGION_NAME:
        endpoint: "$OS_AUTH_URL"
EOF
set -x
juju add-cloud um-cloud um-cloud.yaml
