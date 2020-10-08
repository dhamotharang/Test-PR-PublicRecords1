IMPORT R, ut, python3;
EXPORT string Python_range_func(set of string layout_string, Recordof(Kel_Shell_QA.Layouts.AC_Lay) data_row,string cond, string def_par):= embed(python3)
import re
result =''
cond_str=cond
cond_sub= re.sub(' +',' ',cond)
cond_strip = cond_sub.strip(' \t\n\r')
cond_split = cond_strip.split(' ') 

def_vals =  def_par.split(',') 

layout_list  = []
field0 = layout_string[0] 
for field in layout_string :
    if field!=field0:
        layout_list.append(field)
   
layout_datatype = layout_list

layout = []

for j in range(1,len(layout_datatype),2):
    
    
    layout.append(layout_datatype[j])


data_dict = dict(zip (layout, data_row))


condition_values = []
for item in cond_split:
    data_item = data_dict.get(item,item)
    if isinstance(data_item , str):
        if data_item == '':
            return 'FAIL'
        else:
            condition_values.append(str(data_item))
    elif isinstance(data_item, int):
        
        condition_values.append(data_item)
        

sent_str = ""
for i in condition_values:
    sent_str += str(i) + " "
sent_str = sent_str[:-1]
#print sent_str
dts= sent_str.split(' ') 


evalu=eval(sent_str)

if int(dts[0]) in def_vals:
 print 'PASS'
elif(evalu== True):
 result ='PASS'
else:
 result ='FAIL'
 
#print cond_split
return result

endembed;
