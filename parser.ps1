$html = wget -Uri "http://useragentstring.com/pages/useragentstring.php?typ=Browser"
@( ($html.Links | where { $_.href.Contains('index.php') }).innerText ) | ogv -Title 'User agents'
