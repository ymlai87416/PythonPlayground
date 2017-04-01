text = "X-DSPAM-Confidence:    0.8475";
start = text.find("0")
print float(text[start:])
