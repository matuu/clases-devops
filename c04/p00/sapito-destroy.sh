#!/bin/bash
nova list|awk '/sapito/{ print $2 }'|xargs -rtl1 nova delete
