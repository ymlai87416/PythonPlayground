name = raw_input("Enter file:")
if len(name) < 1 : name = "mbox-short.txt"
handle = open(name)
freq = dict()
for line in handle.readlines():
    if line.startswith("From "):
        word = line.split(" ")[1]
        freq[word] = freq.get(word, 0)+1

max_cnt = -1
max_word = ""

for k, v in freq.items():
    if v > max_cnt:
        max_cnt = v;
        max_word = k;

print max_word, max_cnt