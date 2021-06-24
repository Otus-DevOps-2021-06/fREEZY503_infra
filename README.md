# fREEZY503_infra
fREEZY503 Infra repository

## ProxyJump
The ProxyJump, or the -J flag, was introduced in ssh version 7.3. To use it, specify the bastion host to connect through after the -J flag, plus the remote host:
~~~ bash
$ ssh -J <bastion-host> <remote-host>
~~~
You can also set specific usernames and ports if they differ between the hosts:
~~~ bash
ssh -J user@<bastion:port> <user@remote:port>
~~~
The ssh man (or manual) page (man ssh) notes that multiple, comma-separated hostnames can be specified to jump through a series of hosts:
~~~ bash
ssh -J <bastion1>,<bastion2> <remote>
~~~
This feature is useful if there are multiple levels of separation between a bastion and the final remote host. For example, a public bastion host giving access to a "web tier" set of hosts, within which is a further protected "database tier" group might be accessed.

## Pritunl

bastion_IP = 178.154.226.20 
someinternalhost_IP = 10.128.0.27

## Test App

testapp_IP = 130.193.37.198
testapp_port = 9292

## Packer
В процессе сделано:
 - Основное задание (создание образа с помощью шаблона)
 ~~~bash
 packer build -var-file=./packer/variables.json ./packer/ubuntu16.json
 ~~~
 - Дополнительное задание (Построение bake-образа)
 ~~~
 packer build -var-file=./packer/variables.json ./packer/immutable.json
 ~~~
 - Дополнительное задание (Автоматизация создания ВМ)
 ~~~
 config-scripts/create-reddit-vm.sh
 ~~~

## Terrafrom 
При добавлении второго русурса в код терраформа, код становится слишком большим для двух одинаковых приложений из-за копирования больших кусков кода.
Чтобы этого избежать, можно использовать count для ресурсов.
В процессе сделано:
 - Основное задание (Создание инстанса с помощью terraform)
 - Самостоятельное задание (Определение переменных для приватного SSH ключа и задания зоны)
 - Задание с ** (Создание балансировщика с помощью terraform)
 ~~~
 lb.tf
 ~~~
 - Задание с ** (Создание второго инстанса с помощью terraform и проверка балансировщика)
 - Задание с ** (Реализован подход с заданием количества инстансов через параметр ресурса count)

## Terraform-2
В процессе сделано:
 - Основное задание (Разделение на модули, создание stage и prod)
 - Самостоятельное задание (Удалил из основной директории main.tf, outputs.tf,terraform.tfvars, variables.tf, так как они теперь перенесены в stage и prod)
 - Задание с * (Настройка хранения стейт файла в удаленном бекенде)
 ~~~
 storage-bucket.tf
 ~~~
 
## Ansible-1
После удаления директории с приложением (~/reddit) с помощью команды 'rm -rf ~/reddit', запустив плейбук, плейбук используя модуль git, клонирует репозиторий в директорию ~/reddit и отражает это действие в итоге, как changed=1. <br>
В процессе сделано:
 - Основное задание (Созданы inventory файлы, ansible.cfg, плейбук clone.yml)
 - Задание с * (Создан inventory.json и скрипт dynamic.sh для работы с ним) 
 ~~~bash
 #Вывод всех хостов из inventory.json файла
 sh dynamic.sh --list
 
 #Вывод переменных для определенного хоста из inventory.json файла
 sh dynamic.sh --host db
 sh dynamic.sh --host app
 ~~~

 ## Ansible-2
В процессе сделано:
 - Основное задание:
	- Использование плейбуков, хендлеров и шаблонов для конфигурации окружения и деплоя тестового приложения. Подход одинплейбук, один сценарий (play);
	- Один плейбук, но много сценариев;
	- Много плейбуков;
	- Изменение провижн образов Packer на Ansible-плейбуки);
 - Задание с *:
	- Использовал свой скрипт dynamic inventory
 - Дополнительное задание:
	- Описал с помощью модулей Ansible в плейбуках ansible/packer_app.yml и ansible/packer_db.yml действия, аналогичные bash-скриптам, которые сейчас используются в конфигурации Packer;
	- Выполнил билд образов с использованием нового провиженера, на основе полученных образов, запустил stage окружение, проверил с помощью плейбука site.yml конфигурацию окружения и деплой приложения.

 ## Ansible-3
В процессе сделано:
 - Основное задание:
	- Перенос созданных плейбуков в раздельные роли
	- Описания двух окружений
	- Использование коммьюнити роли nginx
	- Использование Ansible Vault для окружений
 - Задание с *:
	- Настройка использования динамического инвентори для окружений stage и prod
~~~bash
Вызов создания и вывода списка хостов для stage окружения
sh dynamic.sh --environment stage --list

Вызов создания и вывода списка хостов для prod окружения
sh dynamic.sh --environment prod --list

Вывод данных хоста app из окружения prod
sh dynamic.sh --environment prod --host app
~~~

 ## Ansible-4
В процессе сделано:
 - Основное задание:
	- Локальная разработка при помощи Vagrant, доработка ролей для провижининга в Vagrant
	- Тестирование ролей при помощи Molecule и Testinfra
	- Переключение сбора образов пакером на использование ролей
 - Самостоятельное задание:
	- Написал тест к роли db для проверки того, что БД слушает по нужному порту (27017). Использовал для этого один из модулей Testinfra
	- Собрал пакером новые образы db и app, использую роли в шаблонах
