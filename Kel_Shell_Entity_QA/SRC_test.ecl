IMPORT R, ut, Python;
EXPORT string SRC_test(Recordof(Kel_Shell_Entity_QA.Layouts.SRC_Lay) data_row,string cond, set of string lay_set):= embed(Python)

import re
import time
time1 = time.time()
str_list = lay_set
str_list = ' '.join(str_list).split() 
str_list = '\n'.join(str_list).split() 
layout_string_new=['']+str_list


cond_repl =re.sub("^\s+|\s+$", "", cond)
cond_str=cond_repl.strip()
cond_sub= re.sub(' +',' ',cond)
cond_strip = cond_sub.strip(' \t\n\r')
cond_split = cond_strip.split(' ') 

layout_list  = []
field0 = layout_string_new[0] 
for field in layout_string_new :
    if field!=field0:
        layout_list.append(field)
   
layout_datatype = layout_list

layout = []

for j in range(1,len(layout_datatype),2):
    
    
    layout.append(layout_datatype[j])


data_dict = dict(zip (layout, data_row))


#return ','.join(layout)
condition_values = []

for item in cond_split:
    data_item = data_dict.get(item,item)
    #return str(item)+ '-->' + str(data_item)

    if isinstance(data_item , str):
        #return 'value is string' 
        if data_item.strip() == '':
            return 'FAIL'
        else:
            condition_values.append(str(data_item))
    else:# isinstance(data_item, int):
        
        condition_values.append(data_item)

#return 'date check not done here'       
sent_str = ""
for i in condition_values:
    sent_str += str(i).strip(' \t\n\r') + " "
sent_str = sent_str[:-1]
sent_str=sent_str.replace('false','False')
#return sent_str

return str(sent_str)

endembed;