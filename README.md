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
