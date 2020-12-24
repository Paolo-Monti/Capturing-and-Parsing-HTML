try { $html = Invoke-WebRequest "https://deviceatlas.com/blog/list-of-user-agent-strings" } catch { Write-Host "Errore"; Exit }
$data = $html.ParsedHtml.getElementsByTagName('td')
