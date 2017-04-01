# Note - this code must run in Python 2.x and you must download
# http://www.pythonlearn.com/code/BeautifulSoup.py
# Into the same folder as this program

import urllib.request
from bs4 import BeautifulSoup

url = input('Enter - ')
count = int(input("Enter count:"))
position = int(input("Enter count:"))
if len(url) < 1 : url = "http://python-data.dr-chuck.net/known_by_Talorcan.html "

# Retrieve all of the anchor tags
for x in range(0, count):
    print("Retrieving: ", url)
    html = urllib.request.urlopen(url).read()
    soup = BeautifulSoup(html)
    tags = soup('a')
    cc = 0
    for tag in tags:
        #print (tag.get('href', None))
        cc = cc+1
        if cc == position:
            url = tag.get('href', None)
            break
print("Retrieving: ", url)
