# Use the file name mbox-short.txt as the file name
fname = raw_input("Enter file name: ")
average = 0
cnt = 0
fh = open(fname)
for line in fh:
    if not line.startswith("X-DSPAM-Confidence:") : continue
    v = float(line[line.find("0"):])
    average = average + v
    cnt = cnt + 1

print "Average spam confidence:",average/cnt
