IMPORT R, ut, Python;
EXPORT string test2(string Attr1):= embed(Python)
import re
#par = '  unsigned1 personid, string15 firstname, string25 lastname   '
par = Attr1
step1= re.sub("," , ";,",par)

step2= step1.split(',')

#val= str.replace("," , ";,")


step3= map(str.strip, step2)

step4= ','.join(str(s) for s in step3)

result= re.sub("," , "",step4) + ';'                 
return result   
endembed;