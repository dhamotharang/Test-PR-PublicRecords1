
IMPORT R, ut, python3;
EXPORT string Python_evaluate_expression_except_vals(set of string layout_string, Recordof(Kel_Shell_QA.Layouts.AC_Lay) data_row, set of string cond, set of integer def_vals):= embed(python3)

import operator
#layout_string = 				[' ', 'string', 'sno', ' ', 'string', 'arrestcnt7y', ' ', 'string', 'arrestnew1y', ' ', 'string', 'arrestold1y', ' ', 'string', 'arrestnew7y', ' ', 'string', 'arrestold7y', ' ', 'string', 'monsincenewestarrestcnt1y', ' ', 'string', 'monsinceoldestarrestcnt1y', ' ', 'string', 'monsincenewestarrestcnt7y', ' ', 'string', 'monsinceoldestarrestcnt7y', ' ', 'string', 'crimcnt1y', ' ', 'string', 'crimcnt7y', ' ', 'string', 'crimnew1y', ' ', 'string', 'crimold1y', ' ', 'string', 'crimnew7y', ' ', 'string', 'crimold7y', ' ', 'string', 'monsincenewestcrimcnt1y', ' ', 'string', 'monsinceoldestcrimcnt1y', ' ', 'string', 'monsincenewestcrimcnt7y', ' ', 'string', 'monsinceoldestcrimcnt7y', ' ', 'string', 'felonycnt1y', ' ', 'string', 'felonycnt7y', ' ', 'string', 'felonynew1y', ' ', 'string', 'felonyold1y', ' ', 'string', 'felonynew7y', ' ', 'string', 'felonyold7y', ' ', 'string', 'monsincenewestfelonycnt1y', ' ', 'string', 'monsinceoldestfelonycnt1y', ' ', 'string', 'monsincenewestfelonycnt7y', ' ', 'string', 'monsinceoldestfelonycnt7y', ' ', 'string', 'nonfelonycnt1y', ' ', 'string', 'nonfelonycnt7y', ' ', 'string', 'nonfelonynew1y', ' ', 'string', 'nonfelonyold1y', ' ', 'string', 'nonfelonynew7y', ' ', 'string', 'nonfelonyold7y', ' ', 'string', 'monsincenewestnonfelonycnt1y', ' ', 'string', 'monsinceoldestnonfelonycnt1y', ' ', 'string', 'monsincenewestnonfelonycnt7y', ' ', 'string', 'monsinceoldestnonfelonycnt7y', ' ', 'string', 'crimseverityindex7y', ' ', 'string', 'crimbehaviorindex7y', ' ', ' ']

#data='1','17'	,'997','-99'	,'98'	,'31'	,'90'	,'60'	,'88'	,'15'	,'10'	,'27'	,'20'	,'54'	,'5'	,'57'	,'22'	,'50'	,'86'	,'99'	,'19'	,'19'	,'53'	,'60'	,'5'	,'85'	,'68'	,'56'	,'94'	,'61'	,'60'	,'88'	,'26'	,'32'	,'1'	,'69'	,'26'	,'69'	,'57'	,'56'	,'41','2';

#def_vals2=['-99' ,'-97',  '-98']
#cond  = ['arrestnew1y' ,'>=','arrestold1y']

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
for item in cond:
    data_item = data_dict.get(item,item)
    if isinstance(data_item , str):
        if data_item == '':
            return 'FAIL'
        else:
            condition_values.append(data_item)
    elif isinstance(data_item, int):
        
        condition_values.append(str(data_item))
            
    
cond_transform= ', '.join(condition_values)

cond_transform2= cond_transform.replace(",", "")
evalu=eval(cond_transform2)

if (int(condition_values[0]) in def_vals) or  (int(condition_values[2]) in def_vals):
 return 'PASS'
elif(evalu== True):
 result ='PASS'
else:
 result ='FAIL'
 
#print result
return result

endembed;