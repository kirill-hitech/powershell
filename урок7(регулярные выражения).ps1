### УРОК 7
### Подстановочные знаки и регулярные выражения (регэксп)
### wildcard templates & regular expressions (regexp templates)


### часть 1: подстановочные знаки (wildcard templates)


# есть такой оператор сравнения, который использует эту технологию.
# у него два аргумента - один слева, другой справа от него.
# тип обоих - по умолчанию System.String (или может быть массив Strings[])
# тип возвращаемого значения - [Bool]

# пример работы, когда аргумент слева - строка:
# тип возвращаемого значения - [Bool]
"car" -like "*r"  # true
"car" -like "c*"  # true


# пример работы, когда аргумент слева - массив строк [String[]]:
# тип возвращемого значения  [String[]]
"foo","car","bar" -like "*r" 


<# https://docs.microsoft.com/ru-ru/powershell/module/microsoft.powershell.core/about/about_wildcards?view=powershell-7.2
*	Совпадение с нулевым количеством или несколькими символами в любой позициии
?	Совпадение с одним символом в этой позиции
[ ]	Совпадение с диапазоном символов	[a-l]
[ ]	Совпадение с конкретными символами	[BC]
#>

# *
"foo","car","bar" -like "*???"
"foo","car","bar" -like "???*"  
"foo","car","bar" -like "?????*"  # не соответствует кол-ву символов.
# ?
"tfar","car","bars" -like "??r?"  # bars
"tfar","car","bars" -like "????"  # bars, tfar
"tfar","car","bars" -like "b???"  # bars

# [a-c] совпадение с диапазоном
"birs","car","bars" -like "[a-c]*"  
"birs","car","bars" -like "?[a-c]*" 

# [i] совпадение с одной буквой
"birs","car","bars" -like "?[a]*" 
"birs","car","bars" -like "?[a]?"


##### есть и обратная проверка, на НЕ совпадение с шаблоном
"birs","car","bars" -notlike "[b]*"  # car

######################################################
# https://docs.microsoft.com/ru-ru/powershell/module/microsoft.powershell.core/about/about_regular_expressions?view=powershell-7.2
# часть 2 регулярные выражения 
# Регулярное выражение — это шаблон, используемый для сопоставления текста. Он может состоять из литеральных символов, операторов и других конструкций.
#
# их можно использовать в операторах: match, коммандлете select-object, ветвлении Switch, методах класса String - Replace() & Split()

# на входе оператора match слева может быть и массив строк, как в -like
### 1. Категории знаков:
#      1.1 Группы символов
# [character group] позволяет сопоставить любое число символов один раз, в то время как [^character group] только символы, не находящиеся в группе.

# This statement returns true because book contains the string "oo"
'book' -match 'oo'

# This expression returns true if the pattern matches big, bog, or bug.
"big","bog","bug" -match 'b[iou]g'

#     1.2 Диапазоны символов
#   Шаблон также может быть диапазоном символов. Символы могут быть алфавитными [A-Z] , числовыми [0-9] или даже основанными на ASCII [ -~] (все печатные символы).

# This expression returns true if the pattern matches any 2 digit number.
42 -match '[0-9][0-9]'


#     1.3 Числа
#   \d это эвкивалент [0-9]любая цифра в позиции из указанного диапазона
#   \D эквивалент этого отрицания [^0-9] в этой позиции не число

# This expression returns true if it matches a server name.
# (Server-01 - Server-99).
'Server-01' -match 'Server-\d\d'     # true
'Server-11' -notmatch 'Server-\D\D'  # true
'Server-a1' -match 'Server-\D\d'     # true
 
 # тип данных system.char имеет числовое значение, и они сопоставляются с символами через таблицу ASCII https://en.wikipedia.org/wiki/ASCII
 [char]$a=163 # фунт 

 #     1.4 Символы слов (word)
 # \w cоответствует [a-zA-Z_0-9] . 
 # \W сответствует [^a-zA-Z_0-9] . (отрицание)

 # This expression returns true.
# The pattern matches the first word character 'B'.
'Book' -match '\w\w\w\w' # true
'Book' -match '\w\w\w\w\w' # false
"Hello world!" -match '\w' # false
"Hello world!" -match '\w\w\w\w\w\W\w\w\w\w\w\W' # True

#     1.5 Подстановочные знаки
#     Точка ( . ) является символом-шаблоном (wildcard) в регулярных выражениях. Он будет соответствовать любому символу, кроме новой строки ( \n )

# This expression returns true.
# The pattern matches any 4 characters except the newline.
'a1\ ' -match '.'     # true
'a1\ ' -match '....'  # true

#     1.6 Пробелы
#     Пробелы сопоставляются с помощью \s класса символов. Все символы, отличные от пробельных, сопоставляются с помощью \S . Также можно использовать символы пространства литерала ' ' .

# This expression returns true.
# The pattern uses both methods to match the space.
' - ' -match '\s- '
' - ' -match '\s\S '

# 2. Квантификаторы
# Кванторы контролируют, сколько экземпляров каждого элемента должно присутствовать во входной строке.
# Ниже перечислены некоторые кванторы, доступные в PowerShell.

# они показывают количественно совпадения, сколько их должно быть

# Квантификаторы бывают:
# *	Ноль или более раз.
# +	Один или несколько раз.
# ?	Ноль или один раз.
# {n,m}	Как минимум n , но не более m раз. запятая и m здесь не обязательные.

# This returns true for all account name strings even if the name is absent.
'ACCOUNT NAME:    Administrator' -match 'ACCOUNT NAME:\s*\w*'
'ACCOUNT NAME    Administrator' -match '\w*\s\w\s*\w*'

# This returns true if it matches any server name.
'DC-01' -match '[A-Z]+-\d\d'
'DC-01' -match '\w+-\d\d'

# This returns true for any server name, even server names without dashes.
'SERVER01' -match '[A-Z]+-?\d\d'
'SERVER-01' -match '[A-Z]+-?\d\d' # -? значит может дефис быть или не быть

# {n, m}Квантификатор можно использовать несколькими различными способами, чтобы обеспечить детальный контроль над квантификатором. Второй элемент m и запятая , являются необязательными.
# This returns true if it matches any phone number.
'111-222-3333' -match '\d{3}-?\d{3}-?\d{4}'



# нельзя путать операторы для работы для вилкард шаблонов и регулярных выражений
# Это связано с тем, что в дотнете они представлены разными классами System.Text.RegularExpressions.Regex (для регурных выражений)
#  и парсеры при их посимвольной обработке выдают ошибки:
"car" -match "?[a]*"  # false 
'111-222-3333' -like '\d{3}-?\d{3}-?\d{4}' # false


# Привязки
# Привязки позволяют вызвать успешное или неудачное выполнение соответствия в зависимости от того, где находится строка во входной строке.

# Двумя часто используемыми привязками являются ^ и $ . Курсор ^ соответствует началу строки и $ , который соответствует концу строки. 
# Привязки позволяют сопоставлять текст в определенной позиции, одновременно удаляя ненужные символы.

# The pattern expects the string 'fish' to be the only thing on the line.
# This returns FALSE.
"fish   and fishing" -match '^fish$'




###########################
# у нас есть такой массив из трех чисел:
$array = 30000, 56798, 12432 

# как поделить массив?
# например так: делим каждый элемент массива (при этом не создавая новый массив, куда бы записали резуальтат)


# вот пример вывода на экран деления массива по алгоритму выше:
 $array | %  {$_ / 10}   # используем пайплайн оператор, чтобы передать массив направо, и используем 
 # оператор % (аналог ForEach при использовании с пайплайном) и скриптблок {} код которого выполняется для каждого элемента массива
 # (не путать с мат оператором - остаток от деления 15 % 3 = 0)

foreach($element in $array){

$element / 10  # $_   то же что  в текущем примере выше
}  




