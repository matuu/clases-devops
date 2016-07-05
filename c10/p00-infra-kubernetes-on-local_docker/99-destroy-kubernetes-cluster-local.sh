echo "*** WARNING ***: this will destroy your local kuberentes cluster *** (Ctrl-C) cancel"
sleep 10
docker ps|awk '/gcr.io/{ print $1 }'|xargs -rtl1 docker rm -f
docker ps|awk '/gcr.io/{ print $1 }'|xargs -rtl1 docker rm -f
