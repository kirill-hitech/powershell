Class JiraTicket{
[String]$Fields
[String]$project
[String]$summary
[String]$description
}

$obj1 = new-object -TypeName JiraTicket
$obj2 = new-object -TypeName JiraTicket

$obj1.description = "some descr"
$obj1.Fields = "some fields"
$obj1.summary = "some summary"


$obj1serialized = $obj1 | ConvertTo-Json

# получим данные в объект из JSON формата
$temp = $obj1serialized | ConvertFrom-Json