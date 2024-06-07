#!/bin/bash

# Функция для проверки ввода пользователя на цифры
validate_input() {
   input=$1
   if ! [[ $input =~ ^[0-9]+$ ]]; then
        echo "Пожалуйста, введите только цифры."
        exit 1
   fi
}

# Функция для вывода сообщения о времени
display_time() {
    local seconds=$1
    printf "%02d:%02d:%02d" $((seconds / 3600)) $(( (seconds % 3600) / 60 )) $((seconds % 60))
}

# Функция для запуска обратного таймера
start_timer() {
    local seconds=$1
    while [ $seconds -gt 0 ]; do
        echo -ne "Оставшееся время: $(display_time $seconds)\r"
        sleep 1
        ((seconds--))
    done
    echo -e "\nВремя вышло!"
}

# Запрос ввода пользователя и проверка на цифры
read -p "Введите количество секунд:" input
validate_input $input

# Запуск обратного таймера
start_timer $input

