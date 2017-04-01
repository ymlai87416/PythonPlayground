# Use words.txt as the file name
fname = raw_input("Enter file name: ")
fh = open(fname)
fh_str = fh.read()
fh_str = fh_str.rstrip()
print fh_str.upper()