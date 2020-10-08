IMPORT R, ut, Python3;
EXPORT string SetToString(set of string par):= embed(Python3)

result=','.join(par)

#print result
return result

endembed;