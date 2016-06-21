export http_proxy=http://172.16.16.1:8000/

echo "*** creando controller: myctrl"
set -x
juju bootstrap myctrl um-cloud --upload-tools --config http-proxy=${http_proxy?}
