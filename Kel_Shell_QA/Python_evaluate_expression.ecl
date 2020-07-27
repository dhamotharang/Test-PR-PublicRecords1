IMPORT R, ut, python3;
EXPORT string Python_evaluate_expression(set of string layout_string, Recordof(Kel_Shell_QA.Layouts.AC_Lay) data_row, set of string cond, set of integer def_vals):= embed(python3)
#import operator
#layout_string = 'integer8,personid,string15,firstname,string25,lastname, '

#skip_val=[-97,-98,-99]

#data_row='-99' ,'10',  '10';
layout_list  = []
field0 = layout_string[0]
for field in layout_string :
    if field!=field0:
        layout_list.append(field)
   
layout_datatype = layout_list

layout = []

for j in range(1,len(layout_datatype),2):
    
    
    layout.append(layout_datatype[j])

#print(layout)

#cond  = ['firstname' ,'<=','lastname','and','firstname' ,'>=','lastname']

#layout  = ['a', 'b' ,'c','d']
# = [1,2,3,4]

data_dict = dict(zip (layout, data_row))

#symbs = {'<=' : operator.le , '=': operator.eq, '>=' :operator.ge,'>' :operator.gt,'<' :operator.lt} 
#check=symbs[cond[1]](data_dict[cond[0]],data_dict[cond[2]])
#print(data_dict)

cond = [ data_dict.get(item,item) for item in cond ]
#print cond
data_dict = dict(zip (layout, data_row))

#symbs = {'<=' : operator.le , '=': operator.eq, '>=' :operator.ge,'>' :operator.gt,'<' :operator.lt} 
#check=symbs[cond[1]](data_dict[cond[0]],data_dict[cond[2]])
#print(data_dict)

condition_values = []
for item in cond:
    data_item = data_dict.get(item,item)
    if isinstance(data_item , str):
        if data_item == '':
            return 'FAIL'
        else:
            condition_values.append(str(data_item))
    elif isinstance(data_item, int):
        
        condition_values.append(data_item)
            
    
    
#cond = [ data_dict.get(item,item) for item in cond ]
#print cond

cond_transform= ', '.join(condition_values)

#if (cond[0] in "") or (cond[2] in ""):
#    result ='FAIL'
#    return result

cond_transform2= cond_transform.replace(",", "")
evalu=eval(cond_transform2)


if(evalu== True):
    result ='PASS'
else:
    result ='FAIL'
		
return result
endembed;