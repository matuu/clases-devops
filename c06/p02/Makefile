# github.com/umcloud/clases-devops/c06/p02/Makefile
all:

deploy: edit-user deploy-db-with-vol_id deploy-web deploy-fe
destroy: destroy-db destroy-web destroy-fe unedit-user

deploy-%:
	nova list|grep -q -w -- '$(*)' && exit 0; ./nova-boot.sh $(*)-$(USER) $(*).yaml $(extra); sleep $$((RANDOM%5))

deploy-db-with-vol_id:
	@test -n "$(vol_id)" || { echo "*** use:\n\nmake deploy vol_id=UUID\n"; exit 1;}
	make deploy-db extra="--block-device-mapping vdb=$(vol_id):::0"

destroy-%:
	@nova list|awk '/\<$(*)\>/ { print $$2 }' | xargs -rtl1 nova delete

verify:
	@echo "*** WEB:"
	curl -m2 -sL http://web-$(USER).node.cloud.um.edu.ar/php-mysql | grep Sample.App && echo PASS. || echo FAIL.
	@echo "*** FE:"
	curl -m2 -sL http://fe-$(USER).node.cloud.um.edu.ar/php-mysql | grep Sample.App && echo PASS. || echo FAIL.

console-log: console-log-db console-log-web console-log-fe

console-log-%:
	@echo "*** $(*) ***:"
	@nova list|awk '/\<$(*)\>/  { print $$2 }' | xargs -rtl1 nova console-log --length 10 

edit-user:
	sed -i "s/-EDITAR_USUARIO/-$(USER)/" *.yaml
	
unedit-user:
	sed -i "s/-$(USER)/-EDITAR_USUARIO/" *.yaml
