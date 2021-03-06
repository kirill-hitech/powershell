# урок 2 Циклы и ветвления

# циклы нужны для повторения одной операции множество раз.
# циклов в павершеле несколько, как выбрать подходящий: 
# - если мы знаем заранее, сколько раз цикл будет выполнен -                        выбираем FOR
# - если не знаем, но нужно выполнить хотя бы один раз тело цикла -                 выбираем DO-WHILE & DO-UNTIL
# - если нужно пройти по всему массиву, выполнив операцию над элементами -          выбираем FOREACH


# FOR в деталях:
# в начале идет ключевое слово for, 
# затем идет блок из трех частей в круглых скобках разделенных точкой с запятой:
# - инициализирующее выражение: здесь можно объявлять и определять переменные.
# - условие выполнения цикла: логическая операция, которая выполняется каждый раз до блока {} - если она TRUE то блок выполняется, если FALSE - цикл завершается.
# - инкрементирующее выражение: оно исполняется каждый раз после блока {}.
for ($i = 1; $i -lt 99; $i++)
{ 
    #
        Write-Host $i
    #
}

############# ПРИМЕР цикла FOR с вынесенными отдельно ИВ, УВ, ИВ
# ЗАДАЧА: вывести лишь четные числа на экран
# все эти три части могут быть пустые или вынесены в другие части кода, например for (;;)

    # - инициализирующее выражение
$i = 1

for (;;)
{ 
    
    # остаток от деления $i на 2 равен нулю - переходим к следующей итерации
    
    # ветвление выполняется если десятичная часть от деления на 2 НЕ РАВНА 0
    if($i % 2 -ne 0 ){ # число не четное  - переходим на следующую итерацию, без вывода на экран
    
        $i++
        continue; # будет осуществлен переход сразу на последнюю скобку текущей итерации цикла for "}"(строка 40), и начата следующая итерация.
    }
    Write-Host $i # число четное, выводим на экран
        
    # - условие выполнения цикла - через операто break
    if($i -gt 99)
    {
        break; # данный оператор немедленно завершает работу цикла. далее итераций не будет и скрипт продолжится
    }

    # - инкрементирующее выражение:
    $i++
}


# WHILE в деталях:
# ключевое слово, затем условие выполнения
# если условие не свопадет, то цикл ни разу не будет выполнен.
while ($x -gt 0)
{
    
}


# DO-WHILE в деталях:
# ключевое слово, тело цикла, и условие выполнения в конце
# даже если условие не совпало, цикла будет выполнено минимум один раз
# Цикл do-while — это множество различных While циклов. В цикле do-while условие вычисляется после выполнения блока script. 
# Как и в цикле while, блок скрипта повторяется, пока условие принимает значение true.

$x = 1

do
{
   Write-Host $x
   
   $x++ 
}
while ($x -le 25) # цикл выполняется пока условие TRUE (25 раз)

# DO-UNTIL в деталях:
# Как и цикл do-while , цикл Do-Until всегда запускается по крайней мере один раз перед вычислением условия. 
# Однако блок скрипта выполняется только тогда, когда условие имеет значение false.
$x =25

do
{
   Write-Host $x
   
   $x-- 
}
until ($x -le 20) # цикл выполнится пока условие не будет TRUE хотя бы один раз (1)

######################
# тот же пример, записанный кратко:
# выводит четные значения итератора на экран
# точка с запятой нужна чтобы разделять коммандлеты друг от друга;
# а вслучае переноса на новую строку нужен символ апострофа `
for ($i = 1; $i -lt 99; $i++){if($i % 2 -eq 0 ){Write-`
Host $i}};

# FOREACH - цикл, делает итерацию по всем элементам массива, начиная с нуля
# также есть его аналог-коммандлет, который пишется в одну строку foreach-object

############

# Итерация в математике — повторное применение какой-либо математической операции.
# Итерация в программировании — организация обработки данных, при которой действия повторяются многократно
# пример
    # объявляем одноранговый массив 
    $array = 30000, 56798, 12432 

<# в данном случае, массив представлен в памяти таким образом
index | value
0     | 30000
1     | 56798
2     | 12432
#>

# делаем итерация с помощью коммандлета  foreach в одну строку, 
# символ $_ это автоматическая переменная, то же что и $PSItem.
# представляет из себя текущий объект конвеера (массива) объектов.
# https://docs.microsoft.com/ru-ru/powershell/module/microsoft.powershell.core/about/about_automatic_variables?view=powershell-7.2
# вы можете использовать ее чтобы обращаться к каждому элементу в конвеере (массиве) объектов индивидуально.
 ForEach-Object -InputObject $array -Process {$_ / 1024}

# то же самое, используя оригинальный синтаксис foreach цикла:
foreach($element in $array){

$element / 1024  # $_ не используется, вместо него $element в текущем примере
}  


############# КОНЕЦ ПРИМЕРА цикла FOR с вынесенными отдельно ИВ, УВ, ИВ
# есть ключевые операторы для работы с циклами и ветвлениями:
# 1. break    - завершает цикл немедленно
# 2. continue - начинает немедленно следующую итерацию.

# операции есть арифметические и логические. внутри себя и между собой они имеют различные приоритеты.

# https://docs.microsoft.com/ru-ru/powershell/module/microsoft.powershell.core/about/about_arithmetic_operators
# приоритеты арифметических операций:
<#
PowerShell обрабатывает арифметические операторы в следующем порядке:

ПРИОРИТЕТ ОПЕРАТОРОВ
Приоритет	Оператор	Описание
1	          ()	      Круглые скобки
2	           -	      Для отрицательного числа или унарного оператора
3	          *, /, %	  Для умножения и деления
4	          +, -	      Для сложения и вычитания
5	       -band, -bnot	  Для побитовых операций
5	        -bor, -bxor	  Для побитовых операций
5	         -shr, -shl	  Для побитовых операций
#>

# примеры приоритетов арифметических операций
(2+2*2)    # сначала умножение, затем сложение
((2+2)*2)  # сначала сложение за оператора скобки (), затем умножение 

# -1 это единица и выполненный над ней оператор отрицания
-(3*3+2) 
-(-3*3+2)

# https://docs.microsoft.com/ru-ru/powershell/module/microsoft.powershell.core/about/about_logical_operators?view=powershell-7.1
# логические операторы могут быть:
<# 
PowerShell поддерживает следующие логические операторы.
Оператор	Описание								Пример
-and		Логический оператор AND. TRUE, если оба	(1 -eq 1) -and (1 -eq 2)

-or			Логический оператор OR. TRUE, если либо	(1 -eq 1) -or (1 -eq 2)

-xor		Логическое ИСКЛЮЧАЮЩее или. TRUE, если	(1 -eq 1) -xor (2 -eq 2)

-not		Логическое не. Инвертирует оператор		-not (1 -eq 1)
#>

# в павершелл сразу есть готовые переменны типа [System.Boolean] для облегчения логических операций
# если бы их небыло, вам бы пришлось работать с числовыми их значениями  - нулем($false) и единицей($true)
$true
$false

# от перестановки аргументов местами значения не меняются
# примеры логических операторы
$true -and $true   # = $true
$true -and $false  # = $false
$true -or $true    # = $true
$true -or $false   # = $true

# также есть оператор логического отрицания:
-not $true # = $false
-not $false # = $true
# другой вариант записи:
!($true) # = $false
!($false)# = $true

# ОПЕРАТОРЫ СРАВНЕНИЯ
# https://docs.microsoft.com/ru-ru/powershell/module/microsoft.powershell.core/about/about_comparison_operators?view=powershell-7.1

<#
Операторы сравнения позволяют сравнивать значения или находить значения, соответствующие указанным шаблонам. PowerShell содержит следующие операторы сравнения:

ПОДРОБНОЕ ОПИСАНИЕ
Тип				Оператор		Тест сравнения
Равенство	
-eq				equals 			(равно)
-ne				не равно
-gt				больше чем
-ge				больше или равно
-lt				меньше чем
-le				меньше или равно

Совпадение
-like			строка соответствует шаблону шаблона
-notlike		строка не соответствует шаблону шаблона
-match			строка соответствует шаблону регулярного выражения
-notmatch		строка не соответствует шаблону регулярного выражения

Замена	
-Replace		заменяет строки, соответствующие шаблону регулярного выражения

Содержание
-contains		Коллекция содержит значение
-notcontains	Коллекция не содержит значение
-in				значение находится в коллекции
-notin			значение не находится в коллекции

Тип	
—Is 			Oба объекта имеют одинаковый тип
-IsNot			объекты имеют разные типы
#>


######## арифметические операции имеют приоритет над логическими
######## это значит, что сначала выполняются всегда операции арифметические, а затем логические
(3 % 2 -eq 0 )  # в этом примере сначала, будет остаток от деления, а затем выполнена операция сравнения его с нулем


# арифметические и логически операции имеют понятие ассоциативности
$true -or $true -or $false


######################### РАССМОТРЕТЬ НА СЛЕД УРОКЕ
######### все операторы и операци, рассмотренные выше могут быть применены к пользовательским типам данных

# объявление пользовательского типа данных: память не выделяется, но описываем в каком объеме ее выделять в дальнейшем
class Coordinate : System.IEquatable[Coordinate] {
[Double]$X
[Double]$Y

[Bool] Equals([Coordinate]$var)
{
    return ($this.X -eq $var.X) -and ($this.Y -eq $var.Y)
}
}

# определяем переменную нашего класаа - вызываем конструктор класса, - выделяется память
$cord3 = [Coordinate]::new()
$cord3.x = 15;
$cord3.y = 3;

$cord4 = [Coordinate]::new()
$cord4.x = 6;
$cord4.y = 5;

$cord1 -eq $cord2 # каков будет результат и как его посчитать?????



