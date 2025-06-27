#!/bin/bash




# шлях до лог-файлу
LOG_DIR="/var/log/scripts"
LOG_FILE="$LOG_DIR/script.log"

if [ "$1" == "-t" ]; then
  echo "Поточний час: $(date)"
  exit 0
fi

if [ "$1" == "-u" ]; then
  echo "користувач: $USER"
  exit 0
fi

if [ "$1" == "-h" ]; then
  echo "  -t  показати тільки час"
  echo "  -u  показати користувача"
  echo "  -h  допомога"
  exit 0
fi




# Перевірка, чи є права sudo
if [ "$EUID" -ne 0 ]; then
  echo "❌ цей скріпт потрібно запустити з правами root (через sudo)"
  exit 1
fi

# Створення дерикторій логів
mkdir -p "$LOG_DIR"
chmod 755 "$LOG_DIR"

# Запис в лог
{
  echo "============================"
  echo "Дата запуску: $(date)"
  echo "Користувач: $SUDO_USER"
  echo "Хост: $(hostname)"
  echo "Поточна директория: $(pwd)"
  echo "Запуск скрипта: $0"
  echo "Виконую команду: ls -la"
  ls -la
  echo "Скрипт закінчено: $(date)"
  echo ""
} >> "$LOG_FILE" 2>&1

cat "$LOG_FILE" >> "/home/sysadmin/bash_scripts/logscripts.txt"
