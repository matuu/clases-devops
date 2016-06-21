export http_proxy=http://172.16.16.1:8000/
set -x
juju add-model --config http-proxy=${http_proxy} wp-prod
