import urllib.request
import urllib.parse
import xml.etree.ElementTree as ET

url = 'http://python-data.dr-chuck.net/comments_337689.xml'

print ('Retrieving', url)
uh = urllib.request.urlopen(url)
data = uh.read()
print ('Retrieved',len(data),'characters')
#print (data)
tree = ET.fromstring(data)

count = 0
sum = 0
results = tree.findall('.//comment')
for result in results:
    #print (result.find('count'))
    sum = sum + int(result.find('count').text)
    count = count+1

print("Count: ", count)
print("Sum: ", sum)
