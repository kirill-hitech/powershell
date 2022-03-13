# урок 9: интерфейсы, наследование и перегрузка операций

# интерфейс - набор методов, которые объект класса должен реализовать.
# в павершелл мы создавать их не можем. но они есть уже готовые, описанные в дотнет фреймворке

# все интерфейсы в дотнете начинаются с буквы I   (от слова Inteface)


# также есть именованные функции для перегрузки операторов
##### полный список назвнания функций операторов:
# https://docs.microsoft.com/en-us/dotnet/standard/design-guidelines/operator-overloads

<# выдержка из списка:
+   op_Addition 
-   op_Subtraction
*   op_Multiply
/   op_Division
%   op_Modulus
-bxor   op_ExclusiveOr
-band   op_BitwiseAnd
-bor    op_BitwiseOr
-shl    op_LeftShift
-shr    op_RightShift
-bnot   op_OnesComplement
#>

# рассмотрим использование интерфейса на примере сравнения пользовательского типа данных

# есть класс - координата, вот его объявление

# класс наследует интерфейс IComparable и реализует метод CompareTo, который сравнивает данный экземпляр с заданным объектом
class Coordinate : System.IComparable
{
    [int] $X
    [int] $Y

    # конструктор по умолчанию
    Coordinate() { $this.X = 0;$this.y = 0}

    # конструктор с двумя параметрами
    Coordinate([int] $x,[int]$Y) { $this.X = $x;$this.y = $y }


    # перегрузка оператора: собственная логика оператора +
    # Note: должен быть статичным, возвращаемый тип должен быть тот же, 
    #       и оба операнда (аргумента) должны быть того же типа.
    static [Coordinate] op_Addition([Coordinate] $a, [Coordinate] $b) { return [Coordinate]::new(($a.x + $b.x),($a.y + $b.y)) }
    
    # Custom-define -lt / -le and -gt / -ge, via the System.IComparable interface.
    [int] CompareTo([object] $other) {
      # Simply perform (case-insensitive) lexical comparison on the .Kind
      # property values.
      if ($this.x -eq $other.x -and $this.y -eq $other.y) {return 0 } # -eq
      if ($this.x -lt $other.x -and $this.y -lt $other.y) {return -1 } # -lt
      return 1 # -gt
    }

    # Custom-define -eq / -ne, by overriding Object.Equals()
    # Note that this also requires overriding Object.GetHashCode(),
    # because any two instances that compare the same must report the same
    # hash code.
    [bool] Equals([object] $other) {
      # Two [Coordinate] instance, though distinct reference-type instances,
      # should be considered equal if their .Kind property is equal, case-insensitively.
      return ($this.x -eq $other.x -and $this.y -eq $other.y)
    }
    # Since [Coordinate] instances are compared by their .Kind property value (a [string]),
    # we defer to the latter's .GetHashCode() value, which seemingly is invariant 
    # for a given string. However, we normalize to *lowercase* first, given that 
    # PowerShell's string comparisons are case-insensitive by default.
    [int] GetHashCode() {
      return ($this.x.ToLowerInvariant().GetHashCode()+$this.x.ToLowerInvariant().GetHashCode().GetHashCode())
    }

}
##### ВАЖНО: логика не совсем верная тк надо сравнивать длину вектора ########
# cоздаем 2 объекта класса Coordinate
$obj1 = [Coordinate]::new(5,3)
$obj2 = [Coordinate]::new(6,4)
$obj3 = [Coordinate]::new(6,4)
# складываем их и выводим результат на экран
$obj4 = $obj1+$obj2 ; $obj4

# сравниваем два объекта используя перегруженный метод
$obj2.Equals($obj1)
$obj1 -le $obj2
$obj4 -eq $obj4     # то же самое
# так как оператор сложения - статический метод
# он может быть вызван явно и он вернет результат
[Coordinate]::op_Addition($obj1,$obj2)


