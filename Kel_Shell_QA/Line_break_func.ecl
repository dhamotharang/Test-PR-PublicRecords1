IMPORT R, ut, Python3;
EXPORT string Line_break_func(string Attr1):= embed(Python3)
import re
result = ''

result=Attr1.replace("\n", "") 
return result;   
endembed;