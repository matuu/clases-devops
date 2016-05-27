# github.com/umcloud/clases-devops/c06/p02/Makefile
all:

deploy: edit-user
	@test -n "$(vol_id)" || { echo "*** use:\n\nmake $@ vol_id=UUID\n"; exit 1;}
	nova list|grep -q -- -fe && exit 0; ./fe-create.sh
	nova list|grep -q -- -web && exit 0; ./web-create.sh
	nova list|grep -q -- -db && exit 0; ./db-create.sh $(vol_id)

destroy: unedit-user
	nova list|awk '/-db/ { print $$2 }' | xargs -rtl1 nova delete
	nova list|awk '/-web/ { print $$2 }' | xargs -rtl1 nova delete
	nova list|awk '/-fe/ { print $$2 }' | xargs -rtl1 nova delete

verify:
	@echo "*** WEB:"
	curl -m2 -sL http://web-$(USER).node.cloud.um.edu.ar/php-mysql | grep Sample.App && echo PASS. || echo FAIL.
	@echo "*** FE:"
	curl -m2 -sL http://fe-$(USER).node.cloud.um.edu.ar/php-mysql | grep Sample.App && echo PASS. || echo FAIL.

console-log:
	nova list|awk '/-db/ { print $$2 }' | xargs -rtl1 nova console-log | tail
	nova list|awk '/-web/ { print $$2 }' | xargs -rtl1 nova console-log | tail
	nova list|awk '/-fe/ { print $$2 }' | xargs -rtl1 nova console-log | tail
	

edit-user:
	sed -i "s/EDITAR_USUARIO/$(USER)/" *.yaml
	
unedit-user:
	sed -i "s/$(USER)/EDITAR_USUARIO/" *.yaml
