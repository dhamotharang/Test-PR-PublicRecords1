IMPORT R, ut, python3;
Layout_Person := RECORD
  integer PersonID;
  STRING  FirstName;
  STRING  LastName;
END;

EXPORT string getpSet2(string layout_string, Recordof(Layout_Person) data_row,set of string cond):= embed(python3)
import operator

result = ''
#layout_string = 'integer8,personid,string15,firstname,string25,lastname, '

#data='-99' ,'10',  '10';

layout_datatype = layout_string.split()

layout = []

for j in range(1,len(layout_datatype),2):
    
    
    layout.append(layout_datatype[j])

#print(layout)

#cond  = ['firstname' ,'<=','lastname', 'and','firstname' ,'<=','personid',]

#layout  = ['a', 'b' ,'c','d']
# = [1,2,3,4]

data_dict = dict(zip (layout, data_row))

symbs = {'<=' : operator.le , '=': operator.eq, '>=' :operator.ge,'>' :operator.gt,'<' :operator.lt} 

check=symbs[cond[1]](data_dict[cond[0]],data_dict[cond[2]])


#print(data_dict[cond[0]])
if(check== True):
 result ='PASS'
else:
 result ='FAIL'            
return result 
  
endembed;

