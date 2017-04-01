import socket

mysock = socket.socket(socket.AF_INET, socket.SOCK_STREAM)
mysock.connect(('www.py4inf.com', 80))
mysock.send('GET http://data.pr4e.org/intro-short.txt HTTP/1.0\n\n'.encode('utf-8'))

while True:
    data = mysock.recv(512)
    if ( len(data) < 1 ) :
        break
    print (data);

mysock.close()
