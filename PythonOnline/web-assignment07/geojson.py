import urllib.request
import urllib.parse
import json

# serviceurl = 'http://maps.googleapis.com/maps/api/geocode/json?'
serviceurl = 'http://python-data.dr-chuck.net/geojson?'

while True:
    address = input('Enter location: ')
    if len(address) < 1 : break

    url = serviceurl + urllib.parse.urlencode({'sensor':'false', 'address': address})
    print ('Retrieving', url)
    uh = urllib.request.urlopen(url)
    data = uh.read()
    print ('Retrieved',len(data),'characters')

    try: js = json.loads(data.decode("utf-8"))
    except: js = None
    if 'status' not in js or js['status'] != 'OK':
        print ('==== Failure To Retrieve ====')
        print (data)
        continue

    print (json.dumps(js, indent=4))

    lat = js["results"][0]["geometry"]["location"]["lat"]
    lng = js["results"][0]["geometry"]["location"]["lng"]
    print ('lat',lat,'lng',lng)
    location = js['results'][0]['formatted_address']
    print (location)
