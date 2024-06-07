#!/bin/bash

# Функция для создания пользователя
create_user() {
	local username=$1
	local password=$2

# Проверка, существует ли пользователь
if id "$username" &>/dev/null; then
	echo "Користувач з іменем $username вже існує."
	return
fi

#Создание пользователя
sudo useradd -m "$username"
echo "$username:$password" | sudo chpasswd
echo "Пользователь $username  успешно создан."
}

# Основной цикл
while true; do
	read -p "Введите имя пользователя: " username

# Проверка, что имя пользователя не пусто
if [[ -z "$username" ]]; then
	echo "Имя пользователя не может быть пустым."
	continue
fi

# Проверка, что имя пользователя не содержит запрещенные символы

if ! [[ "$username" =~ ^[a-zA-Z0-9._-]+$ ]]; then
echo "Имя пользователя может содержать только буквы, цифры, точки, подчеркивание и тире."
continue
fi

# Запрос пароля
read -sp "Введите пароль: " password
echo

# Проверка, что пароль не пустой
if [[ -z "$password" ]]; then
	echo "Пароль не может быть пустым."
	continue

fi

# Повторный ввод пароля для проверки
read -sp "Повторить пароль: " password_confirm
echo

# Проверка, что пароли совпадают
if [[ "$password" != "$password_confirm" ]]; then
	echo "Пароли не совпадают."
	continue
fi

# Создание пользователя
create_user "$username" "$password" 

# Запрос на продолжение или завершение
read -p "Желаете создать еще одного пользователя? (y/n): " continue_choice
if [[ "$continue_choice" != "y" ]]; then
break
fi
done

echo "Процесс создания пользователя завершено."
