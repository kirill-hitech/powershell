# урок 6: наследование и интерфейсы

###############
function do-test ()
{
        do-test # функция может вызывать сама себя: это называется рекурсивным вызовом функции, или рекурсией
        # чтобы функция не зацикливалась, нужно обязательно иметь аргумент входящий при рекурсии и внутри тела функции
        # условие выхода из фукнции, и рекурсивная функция обязательно должна возвращать значение
}

# пример рекурсивного вызова - посчитает факториала числа:
function Get-Factorial ($x) {
    if ($x -eq 0) {
        return 1
    }
    return $x * (Get-Factorial (--$x))
}

get-factorial -x 5



<# при рекурсивном вызове все тела функций присутствуют одновременно в памяти по кол-ву вызванных штук:
 120 <-- get-factorial 5
    24 <-- get-factorial 4
       6 <-- get-factorial 3
            2 <--- get-factorial 2
               1 <-- get-factorial 1
                   1 <--- get-factorial 0

при этом когда сработает условие они начинают возвращать значение от последей вызванной:
последняя вызванная первой возвратит значение
#>

###########

class coordinate # базовый класс (родительский класс)
{
$x
$y
coordinate(){
$this.x = 0
$this.y = 0
}
 ShowCoordinate(){
 Write-Host "Coordinates are: " $this.x $this.y 
 }
}

$coord1 = [coordinate]::new()
$coord1.ShowCoordinate()


# дочерний класс - представляет из себя какой-то город, есть поле имя
# чтобы наследовать класс - при объявлении нужно указать родительский класс

class city : coordinate  # другой класс, наследующий поля и методы базового
{
$name
city ($CityName){$this.name = $CityName}
ShowCoordinate(){
Write-Host "Coordinates" + $this.name + " are: " + $this.x + $this.y 
}
}


$city1 = [city]::new("Moscow")

$city1.ShowCoordinate()