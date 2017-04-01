hrs = raw_input("Enter Hours:")
rate = raw_input("Enter Rate:")
h = float(hrs) * float(rate)
if float(hrs) > 40:
    h = h+(float(hrs)-40)*0.5*float(rate)
    
print h