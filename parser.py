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
