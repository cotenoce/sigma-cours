#!/bin/bash

# Проверка наличия аргументов
if [ $# -eq 0 ]; then
	echo "Использование: $0 <пакет1> [<пакет2> ...]"
	exit 1
fi

# Установка пакетов на Ubuntu
install_on_ubuntu() {
	sudo apt update
	sudo apt install -y "$@"
}


# Установка пакетов на CentOS
install_on_centos() {
	sudo yum update
	sudo yum install -y "$@"
}

# Определение операционной системы и установка пакетов
if [ -f /etc/os-release ]; then
	. /etc/os-release
	case $ID in
	ubuntu)
	    install_on_ubuntu "$@"
	    ;;
	centos | rhel)
	    install_on_centos "$@"
		;;
	*)
echo "Поддерживаемая только Ubuntu и CentOS."
exit 1
;;

esac
else

echo "Не удается определить операционную систему."
exit 1

fi


echo "Установка завершена успешно."



