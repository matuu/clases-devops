#!/bin/bash
nova list|awk '/c04-.*db/{ print $2 }'|xargs -tl1 nova delete
