# урок 3

# ФУНКЦИИ часть 1
# https://docs.microsoft.com/en-us/powershell/module/microsoft.powershell.core/about/about_functions?view=powershell-7.1

# В математике унарной операцией называется операция, имеющая только один операнд
# Все фукнции возвращают значение.

# функции нужны чтобы сократить код, повторно использовать его, и съэкономить память

# порядок работы с функциями:
# 1. объявление фунукции (вместе с определением). это не является шагом скрипта, лишь выделяется память под нее
# 2. вызов функции. это является шагом скрипта (будет выполнено тело функции)

#  объявления фукнции, и что оно содержит:
# 1. ключевое слово function
# 2. имя функции 
# 2. тело функции заключенное в фигурные скобки
# 4. ключевое слово param и входящие аргументы заключенные в круглые скобки, и их параметры заключенные в квадратные скобки
# 5. тело фукнции если оно возвращает нам значениe отличное от Null должно иметь ключевое слово return
#    можно указать тип возвращаемого значения после слова return, в случае если надо указкать его явно
#    (в случае ветвлений и окончания работы функции в них - return в каждой из ветвтлений).
    
# не обязательно указывать тип и ключевое слово return, интерпретатор подставит их автоматически при запуске кода

# пример объявления фукнции которая возвращает строку ([System.String]):

function Get-String{ param ()
return [System.String]"Hello world!"
}

# пример вызова: обращение к функции по названию.
# в данном случае, не указано что делать с возвращаемым значением дальше, поэтому
# интерпретатор просто выведет его на экран (это действие для него по умолчанию)
Get-String

# если необходимо избежать вывода на экран, нужно использовать специальную функцию Out-Null,
# например :
Out-Null (Get-String) # или оператор конвеера (pipeline operator)
Get-String | Out-Null

# пример вызова и использования возвращаемого значения этой же функции:
Write-Host (Get-String)

###
# пример объявления функции с аргументами, которая выводит аргумент на экран:
function Show-String{ param ([System.String]$Text)
    Write-Host $Text
}

# пример вызова функции с указанием аргумента и нового строкового значения:
Show-String -Text "hello world!"
Show-String -Text "hello world again!!"
Show-String -Text "hello world!!!"
Show-String -Text "hello world!!!!"

# переменные обладают областями видимости:
# 1. глобальные - видны из дальнеших вложенных блоков внутри скрипта. они должны объявляться не в каком-то блоке, а теле самого скрипта
# 2. локальные - видны внутри лишь тела исполняемого блока или вложенных в это тело блоков
<#
{глобальные переменные скрипта
    { локальные переменные блока->>>>
     
        { локальные переменные блока->>>>

        }

    }
}

#>

{ # верхняя граница основного блока скрипта для наглядности

cls
    # пример объявления функции с аргументами, которая выводит аргумент на экран:
    function Show-String{ 
            param ()
        $Text = "Hello world!" # объявление и определение локальной переменной
        Write-Host $Text       # вывод работает!
        Write-Host $GlobalText # вывод работает!
        }

# объявление и определение глобальнйо переменной:
$GlobalText = "hello i'm global text!!"

# вызов фукнции:
Show-String

# пытаемся вывести локальную переменную функции на экран:
write-host $Text       # не работает! переменная локальная для функции!
write-host $GlobalText # работает! переменная глобальная и видна в любой части скрипта

####
# переменные можно делать для мультифайлового или удаленного использования используюя ключевое слово $global:[имя_переменной], например
# $global:SomeVar = "i'm from other script!"
####

} # нижняя граница основного блока скрипта для наглядности


#### 
# из практики программирования складывается, что
# часто возникает необходимость фукнию переобъявить, или добавить что то в нее, например новый аргумент:

#### ТАК ДЕЛАТЬ НЕ РЕКОМЕНДУЕТСЯ - ПЕРЕГРУЖАТЬ ФУКНЦИИ НЕЛЬЗЯ В ПАВЕРШЕЛЛ(function overload0 переобъявлять функцию с одним именем #### 
function Get-String{ param ($arg1)
return [System.String]"Hello world!"
}

function Get-String{ param ($arg1,$arg2)
return [System.String]"Hello world!"
}
function Get-String{ param ($arg1,$arg2,$arg3)
return [System.String]"Hello world!"
}
#### ТАК ДЕЛАТЬ НЕ РЕКОМЕНДУЕТСЯ #### 

# вместо этого нужно использовать перегрузку аргументов и\или значения по умолчанию и\или делать их не обязательными:

### пример задания значения аргумента по умолчанию, через оператор присваивания:

function show-arguments{ param 
    (
    $arg1,
    $arg2=234234, # это значение аргумента по умолчанию - оно будет использовано если аргумент при вызове не указан
    $arg3="some string value!" # это значение аргумента по умолчанию - оно будет использовано если аргумент при вызове не указан
    )
    Write-Host $arg1 $arg2 $arg3
}

# пример вызова с указанием аргументов всех трех:
show-arguments -arg1 "hello world" -arg2 "i'm arg2" -arg3 "arg3!!!"

# пример вызова с указанием двух аргументов, для 3го аргумента будет использовано значение по умолчанию (см. объявление функции) :
show-arguments -arg1 "hello world" -arg2 "i'm arg2" 

# пример вызова с одним аргументом, для 2 и 3 аргументов будут использованы их значени по умолчанию (см. объявление функции):
show-arguments -arg1 "i'm so lonely!"


####
# переменные объявленные в циклах считаются глобальными - это действие интерпретатора по умолчанию

for ($i = 1; $i -eq 1; $i++)
{ 
    $var1 = 10
}

$var1 # ДОСТУПНА тк интерпретатор сделал при выполнении ее глобальной прозрачно для нас

###
# как создать глобальную переменную с указанием области ее видимости: 
New-Variable -Name a -Value 1 -Scope Global

# как посмотреть все глобальные переменные?
Get-Variable

# как очистить значение переменной?
Clear-Variable -Name var1

# как удалить переменную (и её значение) из памяти?
Remove-Variable -Name var1
###
# аргументы в функцию могут быть переданы по
# 1. значению (by value). в таком случае создается копия этой переменной в теле функции
    function do-test($var){ # в данном случае создается копия в памяти этой переменной
        $Global:var = 15   # переопределение переменной (копии). Тип глобальности используется для вывода значения для наглядности ниже по тексту (строка 174)

    }
    $var1 = 3 # это первый шаг скрипта
    do-test $var1 # это 2
    $var1 # = 3 # несмотря на то что в функции мы установили значение 15, значение var1 не изменилось, т.к. в функции была создана её копия.
    $var # значение аргумента var не изменилось после добавления аргумента var1 в функцию.

# 2. по ссылке (by reference). в таком значении
    function do-test([ref]$var){ # в данном случае создается переменная, содержащая ту же ссылку что и внешняя
        $var.value = 15   # переопределение переменной по ссылке
    }

    $var1 = [ref]3
    do-test $var1 
    $var1 # = 15! # значение передавалось по ссылке, соответственно $var1 приняла значение = 15. преобразованике произошло тк пользовательский тип всегда ссылочный!

# 2.1 второй пример по ссылке (by reference)
class test {
$testfield}

function do-test($var){ # в данном случае создается переменная, содержащая ту же ссылку что и внешняя
        $var.testfield = 15   # переопределение переменной по ссылке
    }

$var1 = [test]::new()
$var1.testfield = 3

do-test -var  $var1
$var1  # = 15 !!! преобразованике произошло тк пользовательский тип всегда ссылочный!


# все числовые типы передаются по значению, если в функции не указано иное

# пример тч сокращенного синтаксиса объявления функции:
function do-test($var){
    # += это оператор увеличения с присвоением. он складывает значение переменной с числом и присваивает сумму этой же переменной.
    # https://docs.microsoft.com/ru-ru/powershell/module/microsoft.powershell.core/about/about_assignment_operators?view=powershell-7.2
    $var += 15  # то же что и $var = $var + 15

    # аналогии есть уменьшение с присвоением:
    $var -= 3

    # значения функция не возращает (возвращает Null)
}

# запишем функцию, используя полный синтаксис и массив в качестве входного аргумента:
# функция считает сумму чисел массива
Function Test-ScriptBlock
{
    [CmdletBinding()] # этот специальный аттрибут , который дает возможность работать фунукции как коммандлету
    Param
    ( # идет список входящих аргументов:
        [Parameter(ValueFromPipeline)] # этот аргумент, отмечен этим аттрибутом, который перет в аргумент то занчение, которе будет передано в функцию через оператор конвеера
        [int[]]$Number
    )
    BEGIN
    {
        $total = 0 # устанавливает значение переменной куда сохранится результат суммы
    }
    PROCESS
    {
        foreach ($num in $Number)
        {
            $total += $num   # то же что и $total = $total + $num
        }
    }
    END
    {
        Write-Host "Final Total: $total" # выводим сумму на экран
    }
} #END Function Test-ScriptBlock


# пример вызова 1 - в агумент передается массив: будет выполнен один раз блок begin, один раз блок process (аргумент - массив), один раз блок end
Test-ScriptBlock -Number 1, 2, 3
 

# пример вызова 2 - через оператор конвеера передается массив в функцию
# будет выполнен 1 раз блок begin, 3 раза выполнен блок Process (аргумент - значение элемента массива поочередно), один раз блок end
1, 2, 3 | Test-ScriptBlock



<#
# ПАРАМЕТРЫ АРГУМЕНТОВ!

Урок 4: Функции часть 2
############
параметры аргументов


############
синтаксис бегин процесс энд


function [<scope:>]<name>
{
  param([type]$parameter1 [,[type]$parameter2])
  dynamicparam {<statement list>}
  begin {<statement list>}
  process {<statement list>}
  end {<statement list>}
}

Компилятор — программа или техническое средство, выполняющее компиляцию.
Компиляция — трансляция программы, составленной на исходном языке высокого уровня, 
в эквивалентную программу на низкоуровневом языке, близком машинному коду (абсолютный код, объектный модуль, иногда на язык ассемблера). 

Интерпретатор — программа (разновидность транслятора), выполняющая интерпретацию.
Интерпретация — пооператорный (покомандный, построчный) анализ, обработка и тут же выполнение исходной программы или запроса (в отличие от компиляции, при которой программа транслируется без её выполнения).
#>

Function do-summarize
{
    [CmdletBinding()] # этот специальный аттрибут , который дает возможность работать фунукции как коммандлету
    Param
    ( # идет список входящих аргументов:
        [Parameter(ValueFromPipeline)] # этот аргумент, отмечен этим аттрибутом, который перет в аргумент то занчение, которе будет передано в функцию через оператор конвеера
        [int[]]$Number
    )
    BEGIN
    {
        $total = 0 # устанавливает значение переменной куда сохранится результат суммы
    }
    PROCESS
    {
        foreach ($num in $Number)
        {
            $total += $num   # то же что и $total = $total + $num
        }
     }
    END
    {
       Write-Host "Final Total: $total" # выводим сумму на экран
    }
} #END Function Test-ScriptBlock


# пример вызова 1 - в агумент передается массив: будет выполнен один раз блок begin, один раз блок process (аргумент - массив), один раз блок end
do-summarize -Number 1, 2, 3
 
# пример вызова 2 - через оператор конвеера передается массив в функцию
# будет выполнен 1 раз блок begin, 3 раза выполнен блок Process (аргумент - значение элемента массива поочередно), один раз блок end
1, 2, 3 | do-summarize

# https://docs.microsoft.com/ru-ru/powershell/module/microsoft.powershell.core/about/about_functions_advanced_methods?view=powershell-7.2
