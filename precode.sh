#!/bin/bash

# Создаем временный каталог
tmp_dir=$(mktemp -d)

# 1. Создаем каталог task с вложенными директориями
mkdir -p "$tmp_dir/task/dir1" "$tmp_dir/task/dir2" "$tmp_dir/task/dir3/dir4"

# 2. Изменяем текущую директорию на task
cd "$tmp_dir/task"

# 3. Создаем пустой файл task/dir2/empty
touch dir2/empty

# 4. Создаем файл task/dir2/hello.sh с указанным содержанием
echo -e '#!/bin/bash\n\necho "$1, привет!"' > dir2/hello.sh

# 5. Устанавливаем права rwxrw-r-- для task/dir2/hello.sh
chmod 764 dir2/hello.sh

# 6. Сохраняем список файлов task/dir2 в task/dir2/list.txt
ls dir2 > dir2/list.txt

# 7. Копируем содержимое каталога task/dir2 в каталог task/dir3/dir4
cp -r dir2/* dir3/dir4/

# 8. Записываем в task/dir1/summary.txt список файлов с расширением *.txt
# находящихся в task, включая поддиректории
find . -name "*.txt" > dir1/summary.txt

# 9. Дописываем в task/dir1/summary.txt содержимое task/dir2/list.txt
cat dir2/list.txt >> dir1/summary.txt

# 10. Определяем переменную окружения NAME со значением "Всем студентам"
export NAME="Всем студентам"

# 11. Запускаем task/dir2/hello.sh с переменной окружения NAME в качестве аргумента
# и вывод дописываем в файл task/dir1/summary.txt
./dir2/hello.sh "$NAME" >> dir1/summary.txt

# 12. Перемещаем с переименованием task/dir1/summary.txt в task/Практическое задание
mv dir1/summary.txt "Практическое задание"

# 13. Выводим на консоль содержимое файла task/Практическое задание
cat "Практическое задание"

# 14. Ищем в файле "Практическое задание" строки, которые содержат слово "dir"
# и затем сортируем их
grep "dir" "Практическое задание" | sort

# 15. Удаляем временный каталог
cd ..
rm -rf "$tmp_dir"