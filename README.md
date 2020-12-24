# Obiettivo

Estrare in Linux e Windows le stringhe User Agent presenti all’indirizzo https://deviceatlas.com/blog/list-of-user-agent-strings

# Bash (Linux)

Per effettuare un parsing semplice e pulito del documento HTML ottenuto con cURL, ho usato il programma pup, scritto da Eric Chiang: https://github.com/ericchiang/pup. Un programma dedicato come pup ci libera dall’impiegare regular expression, poco consigliabili per estrarre dati da tag HTML. Con l’uso di pup il tutto si riduce a un one-liner (comando su una sola riga). Da notare che l’uso di grep con opzione di inversione (-v) è opzionale e usato per filtrare le stringhe usate dai bot. Gli esempi sono nei file simple.sh, interrogazione effettuata senza controllo di errori, e nel file with_error_check.sh, dove è incluso un controllo d'errore essenziale.

# Python (Linux e Windows)

In Python, per ottenere il documento online ho usato la libreria requests (https://requests.readthedocs.io/en/master/) e, per effettuare il parsing del codice HTML, la libreria BeautifulSoup (https://www.crummy.com/software/BeautifulSoup/bs4/doc/). L’uso di queste librerie rende il compito molto semplice e il codice compatto ed essenziale. Di nuovo, la condizione “if” è opzionale ed è presente solo per escludere le stringhe User Agent dei motori di ricerca. Da notare che i messaggi diagnostici sono scritti sullo standard error, in modo tale da escluderne l’output in una eventuale redirezione dell’I/O verso un file, dove possono essere memorizzate le stringhe estrapolate dallo script.

# Powershell (Windows, Powershell >= 3 e < 6)

Il lavoro è svolto principalmente dal cmdlet Invoke-WebRequest, introdotto con PowerShell 3.0. Come nei precedenti esempi, sono filtrati i risultati relativi ai bot. Infine, a titolo di esempio, l’output è mostrato in una tabella grafica.

# PHP

In PHP, per catturare il documento è possibile usare la libreria cURL e, per effettuare il parsing del documento HTML, la classe DOMDocument. Di nuovo la condizione “if” finale è opzionale ed è usata solo per filtrare i bot dal risultato.
