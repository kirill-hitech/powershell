### ���� 13. ������ � REST API

# API ��� Application Programming Interface - ��������� ����������� ����������������

# API ��� �������� �������� (����� �������, ��������, �������, �������� ��� ��������), �������� ���� ������������ ��������� ����� ����������������� � ������ ����������, ������� ������������� �� ����.
# � ����� �������� ����� ��������� 2 ������� - ��������� (� ���� ��� API) � ���������� (��� ������ � HTTP POST ������� � ���).

# ��� ����: 
<#
    1. �������� - �������������� ����� ����� ���������: �������� ������ � ������ ����� ��� ���������� �������� � �������� ������ � ��� �������.  
        ��� ������ ��� �������� - ����������� ������� ����, ������� ���������� � ����� ������� � ����� �������� ���� ���� � ������� ������. (������� ������ �� �����, ��� ���� �������� ������� ����).

    2. HTTP �������� ��� ���������� �������� (7�� ������ OSI). � ��� ������������ ��������� � https://datatracker.ietf.org/doc/html/rfc261
        ���� ���� Method. � ������� ���� �������, ������� ����������, � ��� �����: GET & POST.
        GET ����� ������������� ��� ��� ������ ������� ���������� � URI ������� �������. 
            �������� https://datatracker.ietf.org/doc/html/rfc2616#section-9.3
                ������ ������� ����� #section-9.3
            ��� �������� - GET ������ �� ���������� ������
            https://teams.microsoft.com/dl/launcher/launcher.html?url=%2e&type=meetup-join&deeplinkId=63c84195-efa0-4e17-9973-3bd7333270b7&directDl=true&msLaunch=true&enableMobilePage=true&suppressPrompt=true
                ����� 
                    ? - ����������� ����� ����� �� ������� � ����������
                    & - ����������� ���������� � URI
        POST ����� HTTP ������� ������������� ��� ��� ������ ������� ���������� � ������ ����.

#>

#  �� ����� �������� � �����-���, � ������ ������ ��� ������:
#  REST (�� ����. Representational State Transfer � ��������� ����������������� ���������� ��� ��������� ����������������� ����������) � ������������� ����� �������������� ����������� �������������� ���������� � ����. 
#  ������� �������, REST � ��� ����� ������ ����, ��� ������������ ������������ ��������� ���� ���������� ����������, ����� ��� ������� ����� ������������ ������� �
#  ���������� ����� ���� ��������������.

# � ��������� ���� ��� �����������, ������� ���������� HTTP ������� ���:
Invoke-WebRequest # ������ HTTP ������, �� �� ������ ��� ������ � API
Invoke-RestMethod # ���������� ������ ��� ������ � ����-���

##################

# ������� ������ � REST API:

# 1. ���� �� ���� ������������ � ������� ����� ������ ���� � API � ��� �� ������������, ��������:
    <#
        ����� ��� ������ ������������� ��� ��� �������� ������:
    curl \            # ����� ����� ������� ��� ��������� HTTP �������
    -D-  \            #       
    -u charlie:charlie \
    -X POST \
    --data {see below} \
    -H "Content-Type: application/json" \
    http://localhost:8080/rest/api/2/issue/
    #>

# 2. ������ ����� � ��������� :)

    # ��������� ���������� ����������:
    $JiraProjectKey = "TST"
    $JiraLogin = "teat-api"
    $JiraPass = "Hitech777"
    $JiraApiAddress = "https://jira.hi-tech.org/rest/api/2/issue/"
    
    # ������� ������ ������� �������
    $headers = New-Object "System.Collections.Generic.Dictionary[[String],[String]]" # ��� ������ ����������
    
    # ������� ����� - �������-���� (json)
    $RequestCType     = "application/json"
    $headers.Add('Content-Type',$RequestCType)

    # �� �� ��������� ����� ��������������� �� ���� ������������� ����� ����� ��������� ����� � ������ ����
    $APICreds = $JiraLogin+":"+$JiraPass # ����� ����� � ������ ����� �������
    $pwdbytes          = [System.Text.Encoding]::ASCII.GetBytes($APICreds) # ������������ ������ � � �������� �������� (�������� ������� � ������� ASCII)
    $pwdbase64         = [System.Convert]::ToBase64String($pwdbytes)       # �������� ��� ������ � ������, ��� ������������ ��� � ����� ��������������
        # Base64 � �������� ����������� �������� ������ 
        # https://ru.wikipedia.org/wiki/Base64
        # ��� ����� ����� �� ���������� � �������� ���� ����� � ������

    $pwdbasicAuthValue = "Basic $pwdbase64"                                # ��������� �������� �����-�������� � ��������� ��� ��� � ������ 

    $headers.Add('Authorization',$pwdbasicAuthValue)
    
    # ������� ���������� � ������� ������� ��� ����������� �������� ������� POST
    # ������ ����� ���� �� ������� Jira API �� ������ ����
    # ��� ����: ����� �� ������������ ������ ������� ��������� ����������� ����� @" "@ � ������� �������� ���� �����
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


    # ��������� � ������ � ��������� ������

    $JiraResponse = Invoke-RestMethod -Uri $JiraApiAddress -Method Post -Headers $headers -Body $inpudata


    # �������� ����� ����
    <#
    id    key    self                                           
    --    ---    ----                                           
    67288 TST-74 https://jira.hi-tech.org/rest/api/2/issue/67288
    #>

    # ������������ ����� ��� ������ ������������ ����� �� �������:
    # https://jira.hi-tech.org/browse  + ANSWERKEY
    # https://jira.hi-tech.org/browse/TST-74