name = raw_input("Enter file:")
if len(name) < 1 : name = "mbox-short.txt"
handle = open(name)
hist =  dict()

for line in handle.readlines():
    if line.startswith("From "):
        hour = line.split(" ")[6].split(":")[0]
        hist[hour] = hist.get(hour, 0)+1

items = hist.items()
items.sort()
for k, v in items:
    print k, v
        
