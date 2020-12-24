
try { $html = Invoke-WebRequest "https://deviceatlas.com/blog/list-of-user-agent-strings" } catch { Write-Host "Errore"; Exit }
$data = $html.ParsedHtml.getElementsByTagName('td')
@( ($data | Where-Object { $_.innerText -notmatch 'bot' }).innerText ) | Out-GridView -Title 'User agents'
