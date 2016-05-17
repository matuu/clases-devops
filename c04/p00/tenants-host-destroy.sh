#!/bin/bash
nova list|awk '/tenants-host/{ print $2 }'|xargs -rtl1 nova delete
