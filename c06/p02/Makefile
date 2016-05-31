# github.com/umcloud/clases-devops/c06/p02/Makefile
help:
	@echo "Use:"
	@echo "make deploy vol_id=UUID   # UUID: volume id"
	@echo "make console-log"
	@echo "make verify"
	@echo
	@echo "make destroy"

deploy:       deploy-db-with-vol_id  deploy-web       deploy-fe
destroy:      destroy-db             destroy-web      destroy-fe
console-log:  console-log-db         console-log-web  console-log-fe
verify:                              verify-web       verify-fe

deploy-%: %.tmp.yaml
	@echo "*** $(@) ***:"
	@nova list|grep -q -w -- '$(*)' && exit 0; \
	    set -x;./nova-boot.sh $(*)-$(USER) $(*).tmp.yaml $(extra); sleep 2

deploy-db-with-vol_id:
	@test -n "$(vol_id)" || { echo "*** use:\n\nmake deploy vol_id=UUID\n"; exit 1;}
	make deploy-db extra="--block-device-mapping vdb=$(vol_id):::0"

destroy-%:
	@nova list|awk '/\<$(*)\>/ { print $$2 }' | xargs -rtl1 nova delete

verify-%:
	@echo "*** $(@) ***:"
	curl -m2 -sL http://$(*)-$(USER).node.cloud.um.edu.ar/php-mysql | grep Sample.App && echo PASS. || echo FAIL.

console-log-%:
	@echo "*** $(@) ***:"
	@nova list|awk '/\<$(*)\>/  { print $$2 }' | xargs -rtl1 nova console-log --length 40 ; sleep 2

LP_USER:=$(shell sed -n 1s/.*ssh-import-id.//p  ~/.ssh/authorized_keys)
%.tmp.yaml: %.yaml
	@echo "EDITAR_USUARIO=$(USER) EDITAR_LP=$(LP_USER)"
	@sed -e "s/EDITAR_USUARIO/$(USER)/" -e "s/EDITAR_LP/$(LP_USER)/" $^ > $@
