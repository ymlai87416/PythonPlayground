import json
import urllib.request

url = input("Enter location: ")
if len(url) < 1 :
    url = 'http://python-data.dr-chuck.net/comments_337693.json'
	
print ('Retrieving', url)
uh = urllib.request.urlopen(url)
data = uh.read()
print ('Retrieved',len(data),'characters')

count = 0
sum = 0

print (data.decode("utf-8"))
info = json.loads(data.decode("utf-8"))

for item in info['comments']:
    count = count +1
    sum = sum + item['count']

print ("Count:", count)
print ("Sum:", sum) 