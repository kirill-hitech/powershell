# урок 1 

# комментарии в павершеле бывают однострочные и многострочныеf

# однострочные комментарии метятся знаком шарп #

<#
многострочные комментарии метятся как указано в этом блоке
#>

# существуют еще инструкции для среды разработки, например:
#region test
for ($i = 1; $i -lt 99; $i++)
{ 

write-host $i

 }
#endregion

# регион инструкция используется например для разметки кода

# у среды разработки (Windows Powershell Integrated Scripting\Development\ Environment) есть отладчик. он работает лишь на сохраненные на диске скрипты и скрипт должен выполняться целиком.
# размечаются точки останова и отладчик остановит скрипт в указанных точках. можно внести изменения в переменные или посмотреть их значения, потом продолжить работу скрипта.

# $ доллар знаком начинаются имена переменных

# точка - это операция доступа к члену типа или области имен (.)
# Оператор разыменования свойства (.) указывает, что выражение слева от символа точки представляет собой объект, а выражение справа — член объекта (свойство или метод).
# Например, $file.Name ссылается на свойство Name объекта в переменной $file.
# двойное двоеточие - операция доступа к статическим членам класса (::)
# Сослаться на статический класс можно, заключив его имя в квадратные скобки, пример:
[System.Environment]::OSVersion # роверить версию операционной системы, отобразите свойство OSVersion

# использование переменных сводится к 
# 1. объявление переменной: при этом выделяется под нее оперативную память, при этом значения внутри выделенной памяти сама переменная не имеет или имеет значение по умолчанию для ее типа
$variable13423423
$variable1

# 2. определение переменной: при этом в выделенную часть памяти под переменную записывается какое то значение
$variable1 = 123
$variable2 = 123.5

# 3. удаление из памяти после использования. например это происходит при выходе из блока цикла или ветвления.

# память измеряетяс в байтах или битах. байт = 8 бит

# павершелл работает на фреймворке дотнет. из себя фреймворк представляет библиотеку, в которой есть типы данных, классы и иные объекты.
# типы данных нужны для того, чтобы компилятор знал сколько под этот тип данных памяти выделять.

# типы данных в дотнет бывают: 
# 1. числовые 
#    - целые (могут содержать только целые числа, без точки)
#       - знаковые 
#       - беззнаковые
#    - десятичные (могут содержать целые числа и десятичные)
#       - знаковые 
#       - беззнаковые
# 2. ссылочные


# ПРЕДОПРЕДЕЛЕННЫЕ ЧИСЛОВЫЕ ТИПЫ ДАННЫХ .net framework:


# - ЦЕЛЫЕ
# byte , 8 bit, 0-255 или 2^8, БЕЗЗНАКОВЫЙ тип ПРИМЕР
[System.Byte]$bytevar
[System.Byte]::MinValue
[System.Byte]::MaxValue
[System.SByte]  # SIGNED byte - знаковый тип данных, 8 бит, -128 до +127, или 2^7 всего чисел
[System.Int16]  # Int16 (short) - знаковый тип, 16 бит, -32768 - 32767, или 2^15
[System.UInt16] # UNSIGNED short - беззнаковый тип, 16 бит, 0-65535 или 2^16


[System.Int32] # знаковый тип, 32 бита, -2147483648 - 2147483647, всего чисел 2^31
[System.Int64] # знаковый тип, 64 бита, -9223372036854775808 - 9223372036854775807, всего чисел 2^63
[System.Decimal] # знаковый тип, 128 bit, -79228162514264337593543950335 - 79228162514264337593543950335, всего чисел 2^127

# - ДЕСЯТИЧНЫЕ (вещественные в математике)

[System.Single] # ДОПИСАТЬ САМОМУ, знаковый тип, 32 бита -3.402823E+38 - 3.402823E+38, всего числа
[System.Double] # знаковый тип, 64 бита, -1,79769313486232E+308 - 1,79769313486232E+308, всего чисел 

# - ДАТАВРЕМЕННОЙ тип, используется для быстрой записи дат
[System.DateTime]

# - БУКВЕННЫЙ тип, 16 бит, беззнаковый, для юникод символов
[System.Char]

# логический тип - правда или ложь
[System.Boolean]  # 8 БИТ, где 0 - ложь($false), а остальные значения - правда ($true)



##########################
# в случае сложения типа целого и десятичного происходит операция по конвертации типа целого в десятичный
# принцип: более короткий по битам тип конвертируется в более длинный

[Byte]$bytevar = 3
[Single]$singlevar = 3.5

$bytevar = $bytevar + 1.5       # приводит к ошибке вычисления без предупреждения - десятичная часть будет отсечена

$newvar = $bytevar + $singlevar # новая переменная будет создана длинного типа, чтобы вписать десятичное значение


# ПРЕДОПРЕДЕЛЕННЫЕ ЧИСЛОВЫЕ типы можно конвертировать друг в друга, с ограничениями

[Byte]$bytevar = 3; [Double]::ToDouble(); $bytevar.GetType()


# ССЫЛОЧНЫЙ ПРЕДОПРЕДЕЛЕННЫЙ ТИП ДАННЫХ: СТРОКА
[System.String]$str = "hello world!"


# ССЫЛОЧНЫЙ ПОЛЬЗОВАТЕЛЬСКИЙ ТИП ДАННЫХ: классы, структуры, кортежи, интерфейсы

# объявление пользовательского типа данных: память не выделяется, но описываем в каком объеме ее выделять в дальнейшем
class Coordinate {
[Double]$X
[Double]$Y

}

# определяем переменную нашего класcа - вызываем конструктор класса, - выделяется память
$cord1 = [Coordinate]::new()

# записываем значения наших полей в выделенную память
$cord1.X = 15;
$cord1.y = 35;

# выводим на экран:
$cord1.Y


###########################################################################################


# ФУНЦИИ: они нужны для многократного повтороного использования одного и того же участка кода
# 1 объявление фукнции: ключевое слово, имя функции, аргументы в круглых скобках, тело функции в фигурных скобках
# память выделяется на этом этапе под нее сразу.

function do-test ($StringToShow)
{
Get-Service $StringToShow
}

# 2 вызов функции по ее имени с указанием аргумента
do-test -StringToShow "spooler"

####################################
# https://docs.microsoft.com/ru-ru/powershell/module/microsoft.powershell.core/about/about_assignment_operators?view=powershell-7.2
# операции инкремента увеличивают или уменьшают значение переменной на единицу. или декремента могут быть:
# пост - значение сначала  передается в функцию далее, а затем увеличивается/уменьшается
$i++ ; $i = $i + 1
$i-- ; $i = $i - 1
$i = 5; Write-Host ($i++);Write-Host ($i--)

# Постинкремент: y присваивается значение x, затем x увеличивается на 1 
$x  =  1 ; 
$у  =  $х++ ;     # y равно 1, x теперь равно 2

# Пост-декремент: y присваивается значение x, затем x уменьшается на 1 
$x = 1 ; 
$у = $х-- ;     # y равно 1, x теперь равно 0

# пред - значение сначала увеличивается/уменьшается, затем передается в функцию
++$i
--$i
$i = 5; Write-Host (++$i);Write-Host (--$i)

# Предварительное приращение: x увеличивается на 1, затем y присваивается значение x 
$x = 1; 
$у = ++$х;     # x теперь 2, y тоже 2

# Предварительный декремент: x уменьшается на 1, затем y присваивается значение x 
$x = 1; 
$у = --$х ;     # x теперь 0, y тоже 0

######################################

# ЦИКЛЫ: это вызов какой то функции множество раз. Каждый цикл имеет условия выполения и тело цикла.

# 1. Цикл с пред условием: в круглых скобках в условии в нем три блока - инициализация, условие выполнения, инкрементирующее выражение
for ($i = 1; $i -lt 99; $i = $i + 1)
{ 
   Write-Host $i
}

# 2. цикл с пост условием -  тело цикла в любом случае будет выполнено 1 раз
do
{
    
}
until ($x -gt 0)
# или
do
{

}while ($x -gt 0)

# цикл с пред условием - тело цикла может быть вообще не выполнено - если условие не будет выполнено заранее, например при заранее заданном $x = -1

while ($x -gt 0)
{
    
}

# цикл для итерации по всем элементам массива от первого к последнему
foreach($element in $array)
{

}


#####################################
# ВЕТВЛЕНИЯ

# блоки кода, исполнляющиеся в зависимости от условий и результат выполнения логической операции
 
 # выполняется блок кода если логическая операция вернула TRUE
 if(3 -gt 2)
{
    
}


# выполняется блок кода если логическая операция вернула TRUE
if ($x -lt $y)
{
        # ветвления могут быть вложенные, например:
         if(3 -gt 2)
            {
                if(3 -gt 2)
                    {
    
                    }   
            }   
    }
    else # выполняется блок кода если логическая операция вернула FALSE
    {
    
    }

# Чтобы проверить несколько условий, используйте Switch оператор. Switch оператор эквивалентен ряду If операторов, но проще.
# оператор принимает аргумент, далее сравнивает его со значениями, и выполняет тот блок, где значение совпадает.
# внутри происходит логическое сравнение аргумента со значениями, и блок исполняется если результат TRUE (когда значение соответствует условию, то выполняется действие).

$x = 2
switch ($x)
{
    3 { Write-Host "X = 3" }
    4 { Write-Host "X = 4" }
    5 { Write-Host "X = 5" }
    Default { Write-Host "значение не совпало с описанными"  } # всегда исполняется, если не одно значение не совпало! Этот оператор эквивалентен Else.
}

switch (3)
{
    1 {"It is one."}
    2 {"It is two."}
    3 {"It is three."}
    4 {"It is four."}
    3 {"Three again."}
}

#######################################
# МАССИВ (Array)
# массив это ссылочный тип данных, наследуемый от типа [System.Array]

# массивы могут одномерные или многомерные. нумерация членов массива начинается с нуля. ЭТО ВАЖНО!
# массивы могут быть разны типов - числовых, или ссылочных (пользовательских или встроенных)

# порядок работы с массивом:

# 1. объявление массива и указания типа Int32 данных в нем
[Int32[]]$array = (134,1341,13442,4141343,1341344,1345) # объявляем одномерный массив

# 2. далее с ним можно работать:
write-host $array      # вывести весь массив на экран
write-host $array[2]   # вывести элемент массива номер 2 на экран. в квадратных скобках указывается индекс элемента в массиве.

$array.Count   # получить значение свойства System.Array.Count  - быстро посмотреть сколько в массиве элементов

# SIG # Begin signature block
# MIIU3QYJKoZIhvcNAQcCoIIUzjCCFMoCAQExDzANBglghkgBZQMEAgEFADB5Bgor
# BgEEAYI3AgEEoGswaTA0BgorBgEEAYI3AgEeMCYCAwEAAAQQH8w7YFlLCE63JNLG
# KX7zUQIBAAIBAAIBAAIBAAIBADAxMA0GCWCGSAFlAwQCAQUABCBi1vR5sfnIBW+E
# L+LR7Hupgdw7t91WRhW74jC8U0OQjaCCD+8wggT+MIID5qADAgECAhANQkrgvjqI
# /2BAIc4UAPDdMA0GCSqGSIb3DQEBCwUAMHIxCzAJBgNVBAYTAlVTMRUwEwYDVQQK
# EwxEaWdpQ2VydCBJbmMxGTAXBgNVBAsTEHd3dy5kaWdpY2VydC5jb20xMTAvBgNV
# BAMTKERpZ2lDZXJ0IFNIQTIgQXNzdXJlZCBJRCBUaW1lc3RhbXBpbmcgQ0EwHhcN
# MjEwMTAxMDAwMDAwWhcNMzEwMTA2MDAwMDAwWjBIMQswCQYDVQQGEwJVUzEXMBUG
# A1UEChMORGlnaUNlcnQsIEluYy4xIDAeBgNVBAMTF0RpZ2lDZXJ0IFRpbWVzdGFt
# cCAyMDIxMIIBIjANBgkqhkiG9w0BAQEFAAOCAQ8AMIIBCgKCAQEAwuZhhGfFivUN
# CKRFymNrUdc6EUK9CnV1TZS0DFC1JhD+HchvkWsMlucaXEjvROW/m2HNFZFiWrj/
# ZwucY/02aoH6KfjdK3CF3gIY83htvH35x20JPb5qdofpir34hF0edsnkxnZ2OlPR
# 0dNaNo/Go+EvGzq3YdZz7E5tM4p8XUUtS7FQ5kE6N1aG3JMjjfdQJehk5t3Tjy9X
# tYcg6w6OLNUj2vRNeEbjA4MxKUpcDDGKSoyIxfcwWvkUrxVfbENJCf0mI1P2jWPo
# GqtbsR0wwptpgrTb/FZUvB+hh6u+elsKIC9LCcmVp42y+tZji06lchzun3oBc/gZ
# 1v4NSYS9AQIDAQABo4IBuDCCAbQwDgYDVR0PAQH/BAQDAgeAMAwGA1UdEwEB/wQC
# MAAwFgYDVR0lAQH/BAwwCgYIKwYBBQUHAwgwQQYDVR0gBDowODA2BglghkgBhv1s
# BwEwKTAnBggrBgEFBQcCARYbaHR0cDovL3d3dy5kaWdpY2VydC5jb20vQ1BTMB8G
# A1UdIwQYMBaAFPS24SAd/imu0uRhpbKiJbLIFzVuMB0GA1UdDgQWBBQ2RIaOpLqw
# Zr68KC0dRDbd42p6vDBxBgNVHR8EajBoMDKgMKAuhixodHRwOi8vY3JsMy5kaWdp
# Y2VydC5jb20vc2hhMi1hc3N1cmVkLXRzLmNybDAyoDCgLoYsaHR0cDovL2NybDQu
# ZGlnaWNlcnQuY29tL3NoYTItYXNzdXJlZC10cy5jcmwwgYUGCCsGAQUFBwEBBHkw
# dzAkBggrBgEFBQcwAYYYaHR0cDovL29jc3AuZGlnaWNlcnQuY29tME8GCCsGAQUF
# BzAChkNodHRwOi8vY2FjZXJ0cy5kaWdpY2VydC5jb20vRGlnaUNlcnRTSEEyQXNz
# dXJlZElEVGltZXN0YW1waW5nQ0EuY3J0MA0GCSqGSIb3DQEBCwUAA4IBAQBIHNy1
# 6ZojvOca5yAOjmdG/UJyUXQKI0ejq5LSJcRwWb4UoOUngaVNFBUZB3nw0QTDhtk7
# vf5EAmZN7WmkD/a4cM9i6PVRSnh5Nnont/PnUp+Tp+1DnnvntN1BIon7h6JGA078
# 9P63ZHdjXyNSaYOC+hpT7ZDMjaEXcw3082U5cEvznNZ6e9oMvD0y0BvL9WH8dQgA
# dryBDvjA4VzPxBFy5xtkSdgimnUVQvUtMjiB2vRgorq0Uvtc4GEkJU+y38kpqHND
# Udq9Y9YfW5v3LhtPEx33Sg1xfpe39D+E68Hjo0mh+s6nv1bPull2YYlffqe0jmd4
# +TaY4cso2luHpoovMIIFMTCCBBmgAwIBAgIQCqEl1tYyG35B5AXaNpfCFTANBgkq
# hkiG9w0BAQsFADBlMQswCQYDVQQGEwJVUzEVMBMGA1UEChMMRGlnaUNlcnQgSW5j
# MRkwFwYDVQQLExB3d3cuZGlnaWNlcnQuY29tMSQwIgYDVQQDExtEaWdpQ2VydCBB
# c3N1cmVkIElEIFJvb3QgQ0EwHhcNMTYwMTA3MTIwMDAwWhcNMzEwMTA3MTIwMDAw
# WjByMQswCQYDVQQGEwJVUzEVMBMGA1UEChMMRGlnaUNlcnQgSW5jMRkwFwYDVQQL
# ExB3d3cuZGlnaWNlcnQuY29tMTEwLwYDVQQDEyhEaWdpQ2VydCBTSEEyIEFzc3Vy
# ZWQgSUQgVGltZXN0YW1waW5nIENBMIIBIjANBgkqhkiG9w0BAQEFAAOCAQ8AMIIB
# CgKCAQEAvdAy7kvNj3/dqbqCmcU5VChXtiNKxA4HRTNREH3Q+X1NaH7ntqD0jbOI
# 5Je/YyGQmL8TvFfTw+F+CNZqFAA49y4eO+7MpvYyWf5fZT/gm+vjRkcGGlV+Cyd+
# wKL1oODeIj8O/36V+/OjuiI+GKwR5PCZA207hXwJ0+5dyJoLVOOoCXFr4M8iEA91
# z3FyTgqt30A6XLdR4aF5FMZNJCMwXbzsPGBqrC8HzP3w6kfZiFBe/WZuVmEnKYmE
# UeaC50ZQ/ZQqLKfkdT66mA+Ef58xFNat1fJky3seBdCEGXIX8RcG7z3N1k3vBkL9
# olMqT4UdxB08r8/arBD13ays6Vb/kwIDAQABo4IBzjCCAcowHQYDVR0OBBYEFPS2
# 4SAd/imu0uRhpbKiJbLIFzVuMB8GA1UdIwQYMBaAFEXroq/0ksuCMS1Ri6enIZ3z
# bcgPMBIGA1UdEwEB/wQIMAYBAf8CAQAwDgYDVR0PAQH/BAQDAgGGMBMGA1UdJQQM
# MAoGCCsGAQUFBwMIMHkGCCsGAQUFBwEBBG0wazAkBggrBgEFBQcwAYYYaHR0cDov
# L29jc3AuZGlnaWNlcnQuY29tMEMGCCsGAQUFBzAChjdodHRwOi8vY2FjZXJ0cy5k
# aWdpY2VydC5jb20vRGlnaUNlcnRBc3N1cmVkSURSb290Q0EuY3J0MIGBBgNVHR8E
# ejB4MDqgOKA2hjRodHRwOi8vY3JsNC5kaWdpY2VydC5jb20vRGlnaUNlcnRBc3N1
# cmVkSURSb290Q0EuY3JsMDqgOKA2hjRodHRwOi8vY3JsMy5kaWdpY2VydC5jb20v
# RGlnaUNlcnRBc3N1cmVkSURSb290Q0EuY3JsMFAGA1UdIARJMEcwOAYKYIZIAYb9
# bAACBDAqMCgGCCsGAQUFBwIBFhxodHRwczovL3d3dy5kaWdpY2VydC5jb20vQ1BT
# MAsGCWCGSAGG/WwHATANBgkqhkiG9w0BAQsFAAOCAQEAcZUS6VGHVmnN793afKpj
# erN4zwY3QITvS4S/ys8DAv3Fp8MOIEIsr3fzKx8MIVoqtwU0HWqumfgnoma/Capg
# 33akOpMP+LLR2HwZYuhegiUexLoceywh4tZbLBQ1QwRostt1AuByx5jWPGTlH0gQ
# GF+JOGFNYkYkh2OMkVIsrymJ5Xgf1gsUpYDXEkdws3XVk4WTfraSZ/tTYYmo9WuW
# wPRYaQ18yAGxuSh1t5ljhSKMYcp5lH5Z/IwP42+1ASa2bKXuh1Eh5Fhgm7oMLStt
# osR+u8QlK0cCCHxJrhO24XxCQijGGFbPQTS2Zl22dHv1VjMiLyI2skuiSpXY9aaO
# UjCCBbQwggScoAMCAQICE1UAAAACWqneGG99hrEAAAAAAAIwDQYJKoZIhvcNAQEL
# BQAwRzETMBEGCgmSJomT8ixkARkWA2NvbTEUMBIGCgmSJomT8ixkARkWBGZ1cnkx
# GjAYBgNVBAMTEWZ1cnktV0lOLURDLUNBLUNBMB4XDTIyMDMxMzEwMTU1M1oXDTIz
# MDMxMzEwMTU1M1owUzETMBEGCgmSJomT8ixkARkWA2NvbTEUMBIGCgmSJomT8ixk
# ARkWBGZ1cnkxDjAMBgNVBAMTBVVzZXJzMRYwFAYDVQQDEw1BZG1pbmlzdHJhdG9y
# MIIBIjANBgkqhkiG9w0BAQEFAAOCAQ8AMIIBCgKCAQEAqk+qDES9Y7kQe65vOxJ2
# diF6E8myGmM8s7eY34ihIbGmXA353iQZkmpX7qFlx4zHKztLbxwCpvn1eu2dHoFC
# pIZJBxmZz1/8ihb9bGzfSUx66Meuu/lBUmpZWkxF/traW6t/3QhC00XJdVlt3FUj
# BIWep6pM2VAwmI9Zr44RFcSsFNtMFRYbdbbs/dxAnmPH8qmtlvPT3c3KInX0TQxr
# z+etr2Kl0y8F6UFS+6PLsMUKJx+gia3N47k3o3FE8bi2iD01hU82AXKmrPPr8Qe7
# /0o56kIGdaiOvLl1epyc4ZS+Zn7wSfamcl9aw/c2i58us5xwIS4/jz3U9H1Zz6NM
# 7QIDAQABo4ICizCCAocwPAYJKwYBBAGCNxUHBC8wLQYlKwYBBAGCNxUIgcKYDIG9
# 9geBwYcphcbxF7CyDVyHhd4XhpfkBgIBZAIBAjATBgNVHSUEDDAKBggrBgEFBQcD
# AzAOBgNVHQ8BAf8EBAMCB4AwGwYJKwYBBAGCNxUKBA4wDDAKBggrBgEFBQcDAzAd
# BgNVHQ4EFgQUqEHwEaeMGA0VPpyEwLUsS2i36FwwHwYDVR0jBBgwFoAUoeBLeAiU
# iCcDukstI6Lp9/jqhLIwgc4GA1UdHwSBxjCBwzCBwKCBvaCBuoaBt2xkYXA6Ly8v
# Q049ZnVyeS1XSU4tREMtQ0EtQ0EsQ049V0lOLURDLUNBLENOPUNEUCxDTj1QdWJs
# aWMlMjBLZXklMjBTZXJ2aWNlcyxDTj1TZXJ2aWNlcyxDTj1Db25maWd1cmF0aW9u
# LERDPWZ1cnksREM9Y29tP2NlcnRpZmljYXRlUmV2b2NhdGlvbkxpc3Q/YmFzZT9v
# YmplY3RDbGFzcz1jUkxEaXN0cmlidXRpb25Qb2ludDCBwAYIKwYBBQUHAQEEgbMw
# gbAwga0GCCsGAQUFBzAChoGgbGRhcDovLy9DTj1mdXJ5LVdJTi1EQy1DQS1DQSxD
# Tj1BSUEsQ049UHVibGljJTIwS2V5JTIwU2VydmljZXMsQ049U2VydmljZXMsQ049
# Q29uZmlndXJhdGlvbixEQz1mdXJ5LERDPWNvbT9jQUNlcnRpZmljYXRlP2Jhc2U/
# b2JqZWN0Q2xhc3M9Y2VydGlmaWNhdGlvbkF1dGhvcml0eTAxBgNVHREEKjAooCYG
# CisGAQQBgjcUAgOgGAwWQWRtaW5pc3RyYXRvckBmdXJ5LmNvbTANBgkqhkiG9w0B
# AQsFAAOCAQEAJhWa+bxd/7Geu5o66ahtjZq7XtGjyIVSX8ebnqyRNxFzel1VOlq/
# aBsEvYZrdwLDHiWRNeJT5gf4X/RxkK1BMvWyD82t+wULEWzFa3VETC5VGEfK+07U
# ubiS0ElYlaUWiZKrrLI5tCGKhMvDmrH4NIumhq5fMDi6gcEdgm+849dBEhj4sde+
# k4uqooI/Sz6YqLZav+QJfZNJfH0oAVJqsNJns+0LlIRG/0Ma5fTqkYHEAlxWuPd6
# 3jhWrHsIf4QnXNUF0MIaW2WfF0Rfk0X3lR9sODEHowsaHw+pGkFEBHIrJWhBzPYX
# EJ6YNQYUuL2g4e9ZS0a09LyyFas70ZOz9TGCBEQwggRAAgEBMF4wRzETMBEGCgmS
# JomT8ixkARkWA2NvbTEUMBIGCgmSJomT8ixkARkWBGZ1cnkxGjAYBgNVBAMTEWZ1
# cnktV0lOLURDLUNBLUNBAhNVAAAAAlqp3hhvfYaxAAAAAAACMA0GCWCGSAFlAwQC
# AQUAoIGEMBgGCisGAQQBgjcCAQwxCjAIoAKAAKECgAAwGQYJKoZIhvcNAQkDMQwG
# CisGAQQBgjcCAQQwHAYKKwYBBAGCNwIBCzEOMAwGCisGAQQBgjcCARUwLwYJKoZI
# hvcNAQkEMSIEIHd2ib7TRvW55dBYfV6LkM0CAjUNLLStNRtMPCv2cceRMA0GCSqG
# SIb3DQEBAQUABIIBAIq3pCBKocmZMsaFX5rxuOCNe514qeuYB64U5+Kf8ctqMwDE
# 503Q4perQCmVPGWUXt7SEMPWzyabsvpQ1E7JH0Sv4Ckzn2W/8YGu/91KNYi9LAu7
# UgZUXcct1HrTj8u6Cd1+ifH5g9UXQWjndrn+6tTb1xihc6ay2lrKpoIf4VrMv4Wz
# bYefjkj5wSRjzGulHErw4GwU0EEcYLrAME/y+I0jRkvCBpTmknWv8eljRBxmaPRt
# qk4sxn4zvjUMK6Os2WvN+z+BqfSxjXLjFwlSk/6IrLvqgBQ7sTzBujVjLvfTenej
# yFBz4p0geerabYszZvSI6iBQA3d8U5RsUBL8xAOhggIwMIICLAYJKoZIhvcNAQkG
# MYICHTCCAhkCAQEwgYYwcjELMAkGA1UEBhMCVVMxFTATBgNVBAoTDERpZ2lDZXJ0
# IEluYzEZMBcGA1UECxMQd3d3LmRpZ2ljZXJ0LmNvbTExMC8GA1UEAxMoRGlnaUNl
# cnQgU0hBMiBBc3N1cmVkIElEIFRpbWVzdGFtcGluZyBDQQIQDUJK4L46iP9gQCHO
# FADw3TANBglghkgBZQMEAgEFAKBpMBgGCSqGSIb3DQEJAzELBgkqhkiG9w0BBwEw
# HAYJKoZIhvcNAQkFMQ8XDTIyMDMxMzEwMzYwOVowLwYJKoZIhvcNAQkEMSIEINzC
# 7fFJpzEQogcFh5uHl5n8h3vi4Ai/nflpzv0PV0nXMA0GCSqGSIb3DQEBAQUABIIB
# AH6ojjrCahKD1DS87fClQZQddFlsPldtc7Pdi0sbJKHVATRoed6G6BsnNo1l5xm2
# yHDXjxw9hQTnj9nzNKvzkgGwLGEKsTeKaoZz4sg2DOGXhPjKc79fGYzrW/YHfYn0
# ExcS3Dugjt2kMsV7Q2FB0lofz84cpTvvq+QD7I1gI5H4plXK7Mn2sJXEoY0NNsBw
# qx4sTxvipPfgi+cJBMLMxhv44i500/dFq8kgxXyvGp3t0hMeHQKXDzw0vAvwohAg
# wvcY8fcF4+o9I9cRKXEm7Um+R5VUnqHBHMr5CuoTeKmrkouomqClJCS4ng3cmisk
# D4rdNevOfKvw3ZFh4RHHKwM=
# SIG # End signature block
