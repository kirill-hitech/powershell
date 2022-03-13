### Урок 13. Работа с REST API

# API это Application Programming Interface - интерфейс прикладного программирования

# API это описание способов (набор классов, процедур, функций, структур или констант), которыми одна компьютерная программа может взаимодействовать с другой программой, заранее договорившись об этом.
# В наших примерах будут выступать 2 стороны - серверная (в виде веб API) и клиентская (наш скрипт и HTTP POST запросы в нем).

# доп инфо: 
<#
    1. Протокол - договоренность между двумя сторонами: например клиент и сервер знают как стурктурно отсылать и получать данные в обе стороны.  
        это значит что протокол - расписанный побитно файл, который показывает в каком порядке и каких размеров поля есть у каждого пакета. (немного похоже на класс, где есть свойства разного типа).

    2. HTTP протокол это прикладной протокол (7го уровня OSI). В его спецификации описанной в https://datatracker.ietf.org/doc/html/rfc261
        есть поле Method. И описаны типы методов, которые существуют, в том числе: GET & POST.
        GET метод подразумевает что все данные запроса передаются в URI каждого запроса. 
            Например https://datatracker.ietf.org/doc/html/rfc2616#section-9.3
                Данные запроса здесь #section-9.3
            или например - GET запрос со множеством данных
            https://teams.microsoft.com/dl/launcher/launcher.html?url=%2e&type=meetup-join&deeplinkId=63c84195-efa0-4e17-9973-3bd7333270b7&directDl=true&msLaunch=true&enableMobilePage=true&suppressPrompt=true
                здесь 
                    ? - разделитель имени файла на сервере и аргументов
                    & - разделитель аргументов в URI
        POST метод HTTP запроса подразумевает что все данные запроса включаются в особое поле.

#>

#  мы будем работать с реста-апи, в данном случае это значит:
#  REST (от англ. Representational State Transfer — «передача репрезентативного состояния» или «передача „самоописываемого“ состояния») — архитектурный стиль взаимодействия компонентов распределённого приложения в сети. 
#  Другими словами, REST — это набор правил того, как программисту организовать написание кода серверного приложения, чтобы все системы легко обменивались данными и
#  приложение можно было масштабировать.

# в павершеле есть два коммандлета, которые генерируют HTTP запросы это:
Invoke-WebRequest # делает HTTP запрос, но не удобен для работы с API
Invoke-RestMethod # специально создан для работы с рест-апи

##################

# порядок работы с REST API:

# 1. идем на сайт разработчика и смотрим какие методы есть у API и как их использовать, например:
    <#
        Видим там пример использования апи для создания тикета:
    curl \            # вызов юникс утилиты для генерации HTTP запроса
    -D-  \            #       
    -u charlie:charlie \
    -X POST \
    --data {see below} \
    -H "Content-Type: application/json" \
    http://localhost:8080/rest/api/2/issue/
    #>

# 2. делаем также в павершеле :)

    # указываем глобальные переменные:
    $JiraProjectKey = "TST"
    $JiraLogin = "teat-api"
    $JiraPass = "Hitech777"
    $JiraApiAddress = "https://jira.hi-tech.org/rest/api/2/issue/"
    
    # заводим пустую таблицу хедеров
    $headers = New-Object "System.Collections.Generic.Dictionary[[String],[String]]" # или просто хештаблицу
    
    # заводим хедер - контент-тайп (json)
    $RequestCType     = "application/json"
    $headers.Add('Content-Type',$RequestCType)

    # тк мы испльзуем базик аутентифифкацию то надо сгенерировать базик токен используя логин и пароль наши
    $APICreds = $JiraLogin+":"+$JiraPass # берем логин и пароль через запятую
    $pwdbytes          = [System.Text.Encoding]::ASCII.GetBytes($APICreds) # конвертируем строку в её числовые значение (значения символа в таблице ASCII)
    $pwdbase64         = [System.Convert]::ToBase64String($pwdbytes)       # получаем хеш логина и пароля, что использовать его в базик аутентификации
        # Base64 — стандарт кодирования двоичных данных 
        # https://ru.wikipedia.org/wiki/Base64
        # это нужно чтобы не передавать в открытом виде логин и пароль

    $pwdbasicAuthValue = "Basic $pwdbase64"                                # добавляем значение хедер-значение и добавляем уже его в массив 

    $headers.Add('Authorization',$pwdbasicAuthValue)
    
    # создаем переменную с данными запроса для последующей отправки методом POST
    # правим инпут дата из справки Jira API по ссылке выше
    # доп инфо: чтобы не экранировать каждые кавычки спользуем специальный токен @" "@ в который поместим весь текст
    $inpudata = @"
    {
    "fields": {
       "project":
       {
          "key": "TST"
       },
       "summary": "My test ticket",
       "description": "Creating of an issue using project keys and issue type names using the REST API",
       "issuetype": {
          "name": "Task"
       }
   }
}
"@


    # переходим к вызову и обработке ответа

    $JiraResponse = Invoke-RestMethod -Uri $JiraApiAddress -Method Post -Headers $headers -Body $inpudata


    # получаем ответ типа
    <#
    id    key    self                                           
    --    ---    ----                                           
    67288 TST-74 https://jira.hi-tech.org/rest/api/2/issue/67288
    #>

    # сформировать тикет для работы пользователя можно по формуле:
    # https://jira.hi-tech.org/browse  + ANSWERKEY
    # https://jira.hi-tech.org/browse/TST-74