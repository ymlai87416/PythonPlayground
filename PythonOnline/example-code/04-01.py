def computepay(h,r):
    x = h * r
    h = h-40
    if h > 0:
        x = x + h * r * 0.5
    
    return x

hrs = raw_input("Enter Hours:")
rate = raw_input("Enter Rate:")
p = computepay(float(hrs),float(rate))
print p