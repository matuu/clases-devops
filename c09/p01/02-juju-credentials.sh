echo "*** agregando credentials"
: ${OS_USERNAME?} ${OS_PASSWORD?}
set -x
juju autoload-credentials
