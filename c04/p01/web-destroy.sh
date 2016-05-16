#!/bin/bash
nova list|awk '/c04-.*web/{ print $2 }'|xargs -tl1 nova delete
