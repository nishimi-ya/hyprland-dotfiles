#!/bin/bash

# Метод для получения списка доступных сетей Wi-Fi
get_networks() {
   nmcli -t -f SSID dev wifi | sed 's/^/SSID: /'
}

# Метод для подключения к сети
connect() {
   local network=$1
   local password=$2
   nmcli device wifi connect "$network" password "$password"
}

# Метод для отключения от сети
disconnect() {
   local interface=$1
   nmcli device disconnect "$interface"
}

# Метод для переключения Wi-Fi
toggle_wifi() {
   if [ $(nmcli radio wifi) == "enabled" ]; then
       nmcli radio wifi off
   else
       nmcli radio wifi on
   fi
}

# Получить список доступных сетей Wi-Fi
networks=$(get_networks)

# Использовать wofi для выбора действия
action=$(echo -e "Connect\nDisconnect\nToggle Wi-Fi" | wofi --dmenu -i -p "Select action")

# Проверить, был ли выбран какой-либо вариант
if [ -z "$action" ]; then
   echo "No action selected"
   exit 1
fi

if [ "$action" == "Connect" ]; then
   # Использовать wofi для выбора сети
   selected_network=$(echo "$networks" | wofi --dmenu -i -p "Select network")

   # Проверить, был ли выбран какой-либо вариант
   if [ -z "$selected_network" ]; then
       echo "No network selected"
       exit 1
   fi

   # Удалить префикс "SSID: "
   selected_network=${selected_network#SSID: }

   # Запросить пароль от пользователя с помощью wofi
   password=$(echo "" | wofi --dmenu -i -p "Enter password for $selected_network: " -password)

   # Подключиться к выбранной сети
   connect "$selected_network" "$password"
elif [ "$action" == "Disconnect" ]; then
   # Получить список активных интерфейсов
   interfaces=$(nmcli device status | tail -n +2 | awk '{print $1}' )

   # Использовать wofi для выбора интерфейса
   selected_interface=$(echo "$interfaces" | wofi --dmenu -i -p "Select interface")

   # Проверить, был ли выбран какой-либо вариант
   if [ -z "$selected_interface" ]; then
       echo "No interface selected"
       exit 1
   fi

   # Отключиться от сети
   disconnect "$selected_interface"
elif [ "$action" == "Toggle Wi-Fi" ]; then
   # Переключить Wi-Fi
   toggle_wifi
fi

