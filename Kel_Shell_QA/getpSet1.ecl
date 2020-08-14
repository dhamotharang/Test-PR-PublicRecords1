IMPORT R, ut, python3;
EXPORT string80 getpSet1(string Attr1,string plist,string Attr2):= embed(python3)
import operator
result = ''
symbs = {'<=' : operator.le , '=': operator.eq, '>=' :operator.ge,'>' :operator.gt,'<' :operator.lt} 

check = symbs[plist](Attr1,Attr2)
 
if(check== True):
 result = 'PASS'
else:
  result ='FAIL'
                 
return Attr1   
endembed;

