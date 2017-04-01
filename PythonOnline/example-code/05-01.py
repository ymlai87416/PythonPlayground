largest = None
smallest = None
while True:
    num = raw_input("Enter a number: ")
    if num == "done" : break
    try:
        num_n = int(num)
        if num_n > largest:
            largest = num_n
        if smallest == None or num_n < smallest:
            smallest = num_n
    except ValueError:
        print "Invalid input"

print "Maximum is", largest
print "Minimum is", smallest