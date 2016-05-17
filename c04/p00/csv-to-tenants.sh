#!/bin/bash
file=umcloud-accounts.csv
test -f ${file} || { echo "ERROR: missing file=${file}"; exit 1 ;}
awk -v FS=, 'NR==1{next}{ printf("  - { name: %s, gecos: \"%s\", ssh-import-id: [\"%s\"], shell: /bin/bash, primary-group: umcloud }\n", $3, $2, $4) }' $file
