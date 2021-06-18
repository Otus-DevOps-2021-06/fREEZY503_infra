#!/bin/bash
	
yc compute instance create \
	--name reddit-app \
	--create-boot-disk size=10,image-id=fd8af2burmmk5heome9p \
    --zone ru-central1-a \
    --ssh-key ./ssh/appuser.pub \
	--public-ip