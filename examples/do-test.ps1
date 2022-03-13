# этот файл принимает аргументы и возрващает значения

[CmdletBinding()]  # для поддержки get-help
param(
  [Parameter(Mandatory=$true)]
  [String]$aMandatoryParameter,

  [String]$nonMandatoryParameter,

  [Parameter(Mandatory=$true)]
  [String]$anotherMandatoryParameter

)


# здесь код файла

return 0;