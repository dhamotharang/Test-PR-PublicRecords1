IMPORT R, ut, Kel_Shell_QA;

IMPORT Python3;
EXPORT string Months_between_python_func4(Recordof(Kel_Shell_QA.Layouts.AC_Lay) data_row,string cond, string def_par, set of string lay_set):= EMBED(Python3)
import re
result =''
str_list = lay_set
str_list = ' '.join(str_list).split() 
str_list = '\n'.join(str_list).split() 
layout_string_new=['']+str_list
#return str(layout_string_new)
#layout_string_new = [''] +['integer8', 'inputuidappend', 'string65', 'inputaccountecho', 'integer7', 'inputlexidecho', 'string78', 'inputfirstnameecho', 'string120', 'inputstreetecho', 'string50', 'inputcityecho', 'string25', 'inputstateecho', 'string10', 'inputzipecho', 'string16', 'inputhomephoneecho', 'string16', 'inputworkphoneecho', 'string54', 'inputemailecho', 'string20', 'inputarchivedateecho', 'string1', 'inputaccountechopop', 'string1', 'inputlexidechopop', 'string1', 'inputfirstnameechopop', 'string1', 'inputstreetechopop', 'string1', 'inputcityechopop', 'string1', 'inputstateechopop', 'string1', 'inputzipechopop', 'string1', 'inputhomephoneechopop', 'string1', 'inputworkphoneechopop', 'string1', 'inputemailechopop', 'string1', 'inputarchivedateechopop', 'integer7', 'lexidappend', 'integer2', 'lexidscoreappend', 'string5', 'inputprefixclean', 'string20', 'inputfirstnameclean', 'string5', 'inputsuffixclean', 'string10', 'inputprimaryrangeclean', 'string3', 'inputpredirectionclean', 'string28', 'inputprimarynameclean', 'string4', 'inputaddresssuffixclean', 'string3', 'inputpostdirectionclean', 'string10', 'inputunitdesigclean', 'string8', 'inputsecondaryrangeclean', 'string25', 'inputcityclean', 'string3', 'inputstateclean', 'string5', 'inputzip5clean', 'string4', 'inputzip4clean', 'string10', 'inputlatitudeclean', 'string11', 'inputlongitudeclean', 'string3', 'inputcountyclean', 'string7', 'inputgeoblockclean', 'string3', 'inputaddresstypeclean', 'string4', 'inputaddressstatusclean', 'string54', 'inputemailclean', 'string10', 'inputhomephoneclean', 'string10', 'inputworkphoneclean', 'string20', 'inputarchivedateclean', 'string3', 'inputprefixcleanpop', 'string3', 'inputfirstnamecleanpop', 'string3', 'inputsuffixcleanpop', 'string3', 'inputprimaryrangecleanpop', 'string3', 'inputpredirectioncleanpop', 'string3', 'inputprimarynamecleanpop', 'string3', 'inputaddresssuffixcleanpop', 'string3', 'inputpostdirectioncleanpop', 'string3', 'inputunitdesigcleanpop', 'string3', 'inputsecondaryrangecleanpop', 'string3', 'inputcitycleanpop', 'string3', 'inputstatecleanpop', 'string3', 'inputzip5cleanpop', 'string3', 'inputzip4cleanpop', 'string3', 'inputlatitudecleanpop', 'string3', 'inputlongitudecleanpop', 'string3', 'inputcountycleanpop', 'string3', 'inputgeoblockcleanpop', 'string3', 'inputaddresstypecleanpop', 'string3', 'inputaddressstatuscleanpop', 'string3', 'inputemailcleanpop', 'string3', 'inputhomephonecleanpop', 'string3', 'inputworkphonecleanpop', 'string3', 'inputarchivedatecleanpop', 'integer2', 'arrestcnt1y', 'integer2', 'arrestcnt7y', 'string10', 'arrestnew1y', 'string10', 'arrestold1y', 'string10', 'arrestnew7y', 'string10', 'arrestold7y', 'integer1', 'monsincenewestarrestcnt1y', 'integer1', 'monsinceoldestarrestcnt1y', 'integer1', 'monsincenewestarrestcnt7y', 'integer1', 'monsinceoldestarrestcnt7y', 'integer2', 'crimcnt1y', 'integer2', 'crimcnt7y', 'string10', 'crimnew1y', 'string10', 'crimold1y', 'string10', 'crimnew7y', 'string10', 'crimold7y', 'integer1', 'monsincenewestcrimcnt1y', 'integer1', 'monsinceoldestcrimcnt1y', 'integer1', 'monsincenewestcrimcnt7y', 'integer1', 'monsinceoldestcrimcnt7y', 'integer2', 'felonycnt1y', 'integer2', 'felonycnt7y', 'string10', 'felonynew1y', 'string10', 'felonyold1y', 'string10', 'felonynew7y', 'string10', 'felonyold7y', 'integer1', 'monsincenewestfelonycnt1y', 'integer1', 'monsinceoldestfelonycnt1y', 'integer1', 'monsincenewestfelonycnt7y', 'integer1', 'monsinceoldestfelonycnt7y', 'integer2', 'nonfelonycnt1y', 'integer2', 'nonfelonycnt7y', 'string10', 'nonfelonynew1y', 'string10', 'nonfelonyold1y', 'string10', 'nonfelonynew7y', 'string10', 'nonfelonyold7y', 'integer1', 'monsincenewestnonfelonycnt1y', 'integer1', 'monsinceoldestnonfelonycnt1y', 'integer1', 'monsincenewestnonfelonycnt7y', 'integer1', 'monsinceoldestnonfelonycnt7y', 'string5', 'crimseverityindex7y', 'string3', 'crimbehaviorindex7y']
cond_str=cond
cond_sub= re.sub(' +',' ',cond)
cond_strip = cond_sub.strip(' \t\n\r')
cond_split = cond_strip.split(' ') 

def_vals =  def_par.split(',') 

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
        #return str(len(str(data_item))) + '-->' +str(data_item) + '<--'
        condition_values.append(data_item)

            
sent_str = ""
for i in condition_values:
    sent_str += str(i).strip(' \t\n\r') + " "
sent_str = sent_str[:-1]
#return sent_str

#return 'this is date check marco'
dts= sent_str.split(' ') 
#print str(dts)
for word in dts:
    try:
        float(word.split('|')[0])
    except:
        return 'NA'    
if (dts[0] in def_vals) or (dts[1] in def_vals)  or (dts[2] in def_vals)  or (dts[3] in def_vals):
    return 'PASS'
elif (len(dts[0]) <= 7) or (len(dts[1]) <= 7) or (len(dts[2]) <= 7):
    return 'FAIL'		
else: 
    from datetime import datetime
    #from dateutil import relativedelta
    
    dt=min(dts[0].split('|')[-1],dts[1].split('|')[-1])
    dt2=dts[2].split('|')[-1]
    
    date_1 = datetime(int(dt[0:4]), int(dt[4:6]), int(dt[6:8]))
    
    ##Dec 5 1990 5:20 am
    date_2 = datetime(int(dt2[0:4]), int(dt2[4:6]), int(dt2[6:8]))
    
    #This will find the difference between the two dates
    #difference = relativedelta.relativedelta(date_2, date_1)
    
    #mths=abs(difference.months + (difference.years * 12 ))
    
    #print mths
    #evalu=eval(mths == dts[2])
    #expr= str(mths) + ' == '+ str(dts[3])
    #evalu=eval(expr)
    #return str(date_1 +','+ date_2 +','+dts[3])
#print result
return str(dt +','+ dt2 +','+dts[3])
endembed;