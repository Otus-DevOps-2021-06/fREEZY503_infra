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
  cat << EOF
  {
    "ansible_host": "$dbserver"
  }
EOF
  fi
  
  if [ "$2" == "app" ]; then
  cat << EOF
  {
    "ansible_host": "$appserver"
  }
EOF
  fi 
fi