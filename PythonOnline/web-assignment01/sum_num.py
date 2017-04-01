import re

name = input("Enter file:")
handle = open(name)
sum=0
for line in handle.readlines():
	nums = re.findall("[0-9]+" ,line)
	for num in nums:
		sum = sum + int(num) 
		
print(sum)