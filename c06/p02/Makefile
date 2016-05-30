# github.com/umcloud/clases-devops/c06/p02/Makefile
all:

deploy: edit-user
	@test -n "$(vol_id)" || { echo "*** use:\n\nmake $@ vol_id=UUID\n"; exit 1;}
	@nova list|grep -q -- '-db\b' && exit 0; ./db-create.sh $(vol_id); sleep $$((RANDOM%5))
	@nova list|grep -q -- '-web\b' && exit 0; ./web-create.sh; sleep $$((RANDOM%5))
	@nova list|grep -q -- '-fe\b' && exit 0; ./fe-create.sh; sleep $$((RANDOM%5))

destroy: unedit-user
	@nova list|awk '/-db\>/  { print $$2 }' | xargs -rtl1 nova delete
	@nova list|awk '/-web\>/ { print $$2 }' | xargs -rtl1 nova delete
	@nova list|awk '/-fe\>/  { print $$2 }' | xargs -rtl1 nova delete

verify:
	@echo "*** WEB:"
	curl -m2 -sL http://web-$(USER).node.cloud.um.edu.ar/php-mysql | grep Sample.App && echo PASS. || echo FAIL.
	@echo "*** FE:"
	curl -m2 -sL http://fe-$(USER).node.cloud.um.edu.ar/php-mysql | grep Sample.App && echo PASS. || echo FAIL.

console-log:
	@echo "*** DB:"
	@nova list|awk '/-db\>/  { print $$2 }' | xargs -rtl1 nova console-log --length 10 
	@echo "*** WEB:"
	@nova list|awk '/-web\>/ { print $$2 }' | xargs -rtl1 nova console-log --length 10
	@echo "*** FE:"
	@nova list|awk '/-fe\>/  { print $$2 }' | xargs -rtl1 nova console-log --length 10
	

edit-user:
	sed -i "s/-EDITAR_USUARIO/-$(USER)/" *.yaml
	
unedit-user:
	sed -i "s/-$(USER)/-EDITAR_USUARIO/" *.yaml
