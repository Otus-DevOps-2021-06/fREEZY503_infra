#!/bin/bash
####################################
##       List of arguments        ##
## $1 = --environment             ##
## $2 = <stage/prod>              ##
## $3 = --list or --host          ##
## $4 = if --host then <hostname> ##
####################################

#Poisk external ips
appserver=$(yc compute instance list | grep "reddit-app" | awk '{print $10}')
dbserver=$(yc compute instance list | grep "reddit-db" | awk '{print $10}')

cat << EOF > environments/$2/inventory
[app]
appserver ansible_host=$appserver

[db]
dbserver ansible_host=$dbserver
EOF

if [ "$1" == "--environment" ]; then

  if [ "$2" == "stage" ]; then

    if [ "$3" == "--host" ]; then
      if [ "$4" == "db" ]; then
        count=$(sed -n '/[db]/,/ /p' environments/$2/inventory | wc -l)
        count=$(($count-2))
        cat environments/$2/inventory | grep --after-context=$count "\[db\]" 
      fi
  
      if [ "$4" == "app" ]; then
        count=$(sed -n '/[app]/,/ /p' environments/$2/inventory | wc -l)
        count=$(($count-2))
        cat environments/$2/inventory | grep --after-context=$count "\[app\]" 
      fi 
    fi

    if [ "$3" == "--list" ]; then
      cat environments/$2/inventory
    fi
  fi

  if [ "$2" == "prod" ]; then

    if [ "$3" == "--host" ]; then
      if [ "$4" == "db" ]; then
        count=$(sed -n '/[db]/,/ /p' environments/$2/inventory | wc -l)
        count=$(($count-2))
        cat environments/$1/inventory | grep --after-context=$count "\[db\]" 
      fi
  
      if [ "$4" == "app" ]; then
        count=$(sed -n '/[app]/,/ /p' environments/$2/inventory | wc -l)
        count=$(($count-2))
        cat environments/$2/inventory | grep --after-context=$count "\[app\]" 
      fi 
    fi

    if [ "$3" == "--list" ]; then
      cat environments/$2/inventory
    fi
  fi
fi