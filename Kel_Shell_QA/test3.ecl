IMPORT R, ut, python3;
EXPORT string test3(Recordof(Kel_Shell_QA.Layouts.AC_Lay) data_row,string cond, string def_par, set of string lay_set):= embed(python3)
import re
str_list = lay_set
layout_string_new = ['']
layout_string_new.extend([word.strip() for word in str_list])


def_vals =  def_par.split(',') 

cond_repl =re.sub("^\s+|\s+$", "", cond)
cond_str=cond_repl.strip()
cond_sub= re.sub(' +',' ',cond)
cond_strip = cond_sub.strip(' \t\n\r')
cond_split = cond_strip.split(' ') 

field0 = layout_string_new[0] 
layout_list  = [ field for field in layout_string_new if field!=field0 ]
   
layout_datatype = layout_list

layout = []

layout = {layout_list[j] : j//2  for j in range(1,len(layout_list),2) }


#return ','.join(layout)
condition_values = []

for item in cond_split:
    data_item = data_row[layout[item]] if layout.get(item, False) else item
    
    if isinstance(data_item , str):
        if data_item =='false':
            data_item =='False'
            
       
        if data_item.strip() == '':
            return 'FAIL'
        else:
            condition_values.append(data_item.strip(' \t\n\r')   )
    else:
        
        condition_values.append(str(data_item).strip(' \t\n\r') )
				
sent_str = " ".join(condition_values)

try:
    evalu=eval(sent_str)
except:
    return 'NA'
if(evalu== True):
 result ='PASS'
else:
 result ='FAIL'
 
#print result
return result

endembed;