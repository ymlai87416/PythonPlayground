# Note - this code must run in Python 2.x and you must download
# http://www.pythonlearn.com/code/BeautifulSoup.py
# Into the same folder as this program

import urllib.request
from bs4 import BeautifulSoup

url = input('Enter - ')
if len(url) < 1 : url = "http://python-data.dr-chuck.net/comments_337692.html"
html = urllib.request.urlopen(url).read()

soup = BeautifulSoup(html)
count = 0
sum = 0
# Retrieve all of the anchor tags
tags = soup('span')
for tag in tags:
    count = count + 1
    sum = sum + int(tag.contents[0])
	
print("Count", count)
print("Sum", sum)