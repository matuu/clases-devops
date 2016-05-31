# github.com/umcloud/clases-devops/c06/p02/Makefile
help:
	@echo "Use:"
	@echo "make deploy VOL_ID=UUID   # UUID: volume id"
	@echo "make console-log"
	@echo "make verify"
	@echo
	@echo "make destroy"

ifndef VOL_ID
$(error Falta: export VOL_ID=...)
endif

deploy:       deploy-db       deploy-web       deploy-fe
destroy:      destroy-db      destroy-web      destroy-fe
console-log:  console-log-db  console-log-web  console-log-fe

deploy-db:
	make do-deploy-db  EXTRA="--block-device-mapping vdb=$(VOL_ID):::0"

deploy-web:
	make do-deploy-web # EXTRA="..."

deploy-fe:
	make do-deploy-fe  # EXTRA="..."

do-deploy-%: %.tmp.yaml
	@echo "*** $(@) ***:"
	@nova list|grep -q -w -- '$(*)' && exit 0; \
	    set -x;sleep 2;./nova-boot.sh $(*)-$(USER) $(*).tmp.yaml $(EXTRA)

destroy-%:
	@nova list|awk '/\<$(*)\>/ { print $$2 }' | xargs -rtl1 nova delete

verify:
	@echo "*** DB ***:"
	ssh -l ubuntu db-$(USER).node.cloud.um.edu.ar 'sudo mysql -uroot webapp_db -e "show tables from webapp_db;"' && echo PASS. || echo FAIL.
	@echo "*** WEB ***:"
	curl -m2 -sL http://web-$(USER).node.cloud.um.edu.ar/php-mysql | grep Sample.App && echo PASS. || echo FAIL.
	@echo "*** FE ***:"
	curl -m2 -sL http://fe-$(USER).node.cloud.um.edu.ar/php-mysql | grep Sample.App && echo PASS. || echo FAIL.

bench:
	ab -c10 -n 1000 http://fe-$(USER).node.cloud.um.edu.ar/php-mysql

console-log-%:
	@echo "*** $(@) ***:"
	@nova list|awk '/\<$(*)\>/  { print $$2 }' | xargs -rtl1 nova console-log --length 40; sleep 2

LP_USER:=$(shell sed -n 1s/.*ssh-import-id.//p  ~/.ssh/authorized_keys)

%.tmp.yaml: %.yaml
	@echo "EDITAR_USUARIO=$(USER) EDITAR_LP=$(LP_USER)"
	@sed -e "s/EDITAR_USUARIO/$(USER)/" -e "s/EDITAR_LP/$(LP_USER)/" $^ > $@
