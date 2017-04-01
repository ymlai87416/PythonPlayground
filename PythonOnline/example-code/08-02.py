fname = raw_input("Enter file name: ")
if len(fname) < 1 : fname = "mbox-short.txt"
cnt = 0
fh = open(fname)
for line in fh.readlines() :
    if line.find("From ") == 0 :
        print line.split()[1]
        cnt = cnt + 1
print "There were", cnt , "lines in the file with From as the first word"