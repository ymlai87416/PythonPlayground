fname = raw_input("Enter file name: ")
fh = open(fname)
lst = list()
for line in fh:
    sublist=line.rstrip().split()
    for word in sublist:
        try:
            idx = lst.index(word)
        except:
            lst.append(word)
lst.sort()
print lst
