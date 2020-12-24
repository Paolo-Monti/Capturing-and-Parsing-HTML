# Obiettivo

Estrare in Linux e Windows le stringhe User Agent presenti all’indirizzo https://deviceatlas.com/blog/list-of-user-agent-strings

# Bash (Linux)

Per effettuare un parsing semplice e pulito del documento HTML ottenuto con cURL, ho usato il programma pup, scritto da Eric Chiang: https://github.com/ericchiang/pup. Un programma dedicato come pup ci libera dall’impiegare regular expression, poco consigliabili per estrarre dati da tag HTML. Con l’uso di pup il tutto si riduce a un one-liner (comando su una sola riga). Da notare che l’uso di grep con opzione di inversione (-v) è opzionale e usato per filtrare le stringhe usate dai bot:

Semplice:
curl -s https://deviceatlas.com/blog/list-of-user-agent-strings | pup 'td text{}' | grep -v bot

Con controllo errori su cURL:
doc=$(curl -s https://deviceatlas.com/blog/list-of-user-agent-strings) && {echo "$doc" | pup 'td text{}' | grep -v bot} || echo Error

# Python (Linux e Windows)

In Python, per ottenere il documento online ho usato la libreria requests (https://requests.readthedocs.io/en/master/) e, per effettuare il parsing del codice HTML, la libreria BeautifulSoup (https://www.crummy.com/software/BeautifulSoup/bs4/doc/). L’uso di queste librerie rende il compito molto semplice e il codice compatto ed essenziale. Di nuovo, la condizione “if” è opzionale ed è presente solo per escludere le stringhe User Agent dei motori di ricerca. Da notare che i messaggi diagnostici sono scritti sullo standard error, in modo tale da escluderne l’output in una eventuale redirezione dell’I/O verso un file, dove possono essere memorizzate le stringhe estrapolate dallo script:

import requests, sys
from bs4 import BeautifulSoup

sys.stderr.write('[+] Performing request and getting result...\n')
r = requests.get('https://deviceatlas.com/blog/list-of-user-agent-strings')
if (r.status_code == requests.codes.ok):
        sys.stderr.write('[+] Document parsing...\n')
        soup = BeautifulSoup(r.text, 'html.parser')
        for td in soup.find_all('td'):
            if not ('bot' in td.contents[0]): print(td.contents[0])
        sys.stderr.write('[+] Operation successfully completed\n')        
else:
        sys.stderr.write('[-] Error retrieving the resource: {}\n'.format(r.status_code))

# Powershell (Windows, Powershel >= 3 e < 6)

Il lavoro è svolto principalmente dal cmdlet Invoke-WebRequest, introdotto con PowerShell 3.0. Come nei precedenti esempi, sono filtrati i risultati relativi ai bot. Infine, a titolo di esempio, l’output è mostrato in una tabella grafica:

try { $html = Invoke-WebRequest "https://deviceatlas.com/blog/list-of-user-agent-strings" } catch { Write-Host "Errore"; Exit }
$data = $html.ParsedHtml.getElementsByTagName('td')
@( ($data | Where-Object { $_.innerText -notmatch 'bot' }).innerText ) | Out-GridView -Title 'User agent' 

# PHP

In PHP, per catturare il documento è possibile usare la libreria cURL e per effettuare il parsing del documento HTML, la classe DOMDocument. Di nuovo la condizione “if” finale è opzionale ed è usata solo per filtrare i bot dal risultato:

<?php
// Get the document by cURL
  $options = array(CURLOPT_URL => 'https://deviceatlas.com/blog/list-of-user-agent-strings', 
                   CURLOPT_RETURNTRANSFER => true,
                   CURLOPT_HEADER => false,
                   CURLOPT_FOLLOWLOCATION => true,
                   CURLOPT_SSL_VERIFYHOST => false,
                   CURLOPT_SSL_VERIFYPEER => false);
  $ch = curl_init();
  curl_setopt_array($ch, $options);
  $html = curl_exec($ch);
  curl_close($ch);
  // Parse the document
  if (false !== $html) {
      libxml_use_internal_errors(true);
      $doc = new DOMDocument();
      $doc->loadHTML($html);
      $tags = $doc->getElementsByTagName('td');
      foreach ($tags as $tag) {
          if (false === strpos($tag->textContent, 'bot')) echo "$tag->textContent\n";
      }
  }
?>
