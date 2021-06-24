#!/bin/bash
#Poisk external ips
appserver=$(yc compute instance list | grep "reddit-app" | awk '{print $10}')
dbserver=$(yc compute instance list | grep "reddit-db" | awk '{print $10}')
cat << EOF > inventory.json
{
  "app": {
    "hosts": {
      "appserver": {
        "ansible_host": "$appserver"
      }
    }
  },
  "db": {
    "hosts": {
      "dbserver": {
        "ansible_host": "$dbserver"
      }
    }
  }
}
EOF
if [ "$1" == "--list" ]; then
cat inventory.json
fi

if [ "$1" == "--host" ]; then
  if [ "$2" == "db" ]; then
	count=$(sed -n '/[app]/,/ /p' environments/stage/inventory | wc -l)
	count=$(($count-1))
	cat inventory.json | grep --after-context=$count "\"db\"" 
  fi
  
  if [ "$2" == "app" ]; then
	count=$(sed -n '/"app":/,/}/p' inventory.json | wc -l)
	count=$((($count-2)*2))
	cat inventory.json | grep --after-context=$count "\"app\"" 
  fi 
fi