IMPORT R, ut, python3;
EXPORT string test(Recordof(Kel_Shell_QA.Layouts.AC_Lay) data_row,string cond, string def_par, set of string lay_set):= embed(python3)
from __future__ import division
from decimal import Decimal
import re
import time
time1 = time.time()
str_list = lay_set
str_list = ' '.join(str_list).split() 
str_list = '\n'.join(str_list).split() 
layout_string_new=['']+str_list
#return str(layout_string_new)
#layout_string_new = [''] +['integer8', 'inputuidappend', 'string65', 'inputaccountecho', 'integer7', 'inputlexidecho', 'string78', 'inputfirstnameecho', 'string120', 'inputstreetecho', 'string50', 'inputcityecho', 'string25', 'inputstateecho', 'string10', 'inputzipecho', 'string16', 'inputhomephoneecho', 'string16', 'inputworkphoneecho', 'string54', 'inputemailecho', 'string20', 'inputarchivedateecho', 'string1', 'inputaccountechopop', 'string1', 'inputlexidechopop', 'string1', 'inputfirstnameechopop', 'string1', 'inputstreetechopop', 'string1', 'inputcityechopop', 'string1', 'inputstateechopop', 'string1', 'inputzipechopop', 'string1', 'inputhomephoneechopop', 'string1', 'inputworkphoneechopop', 'string1', 'inputemailechopop', 'string1', 'inputarchivedateechopop', 'integer7', 'lexidappend', 'integer2', 'lexidscoreappend', 'string5', 'inputprefixclean', 'string20', 'inputfirstnameclean', 'string5', 'inputsuffixclean', 'string10', 'inputprimaryrangeclean', 'string3', 'inputpredirectionclean', 'string28', 'inputprimarynameclean', 'string4', 'inputaddresssuffixclean', 'string3', 'inputpostdirectionclean', 'string10', 'inputunitdesigclean', 'string8', 'inputsecondaryrangeclean', 'string25', 'inputcityclean', 'string3', 'inputstateclean', 'string5', 'inputzip5clean', 'string4', 'inputzip4clean', 'string10', 'inputlatitudeclean', 'string11', 'inputlongitudeclean', 'string3', 'inputcountyclean', 'string7', 'inputgeoblockclean', 'string3', 'inputaddresstypeclean', 'string4', 'inputaddressstatusclean', 'string54', 'inputemailclean', 'string10', 'inputhomephoneclean', 'string10', 'inputworkphoneclean', 'string20', 'inputarchivedateclean', 'string3', 'inputprefixcleanpop', 'string3', 'inputfirstnamecleanpop', 'string3', 'inputsuffixcleanpop', 'string3', 'inputprimaryrangecleanpop', 'string3', 'inputpredirectioncleanpop', 'string3', 'inputprimarynamecleanpop', 'string3', 'inputaddresssuffixcleanpop', 'string3', 'inputpostdirectioncleanpop', 'string3', 'inputunitdesigcleanpop', 'string3', 'inputsecondaryrangecleanpop', 'string3', 'inputcitycleanpop', 'string3', 'inputstatecleanpop', 'string3', 'inputzip5cleanpop', 'string3', 'inputzip4cleanpop', 'string3', 'inputlatitudecleanpop', 'string3', 'inputlongitudecleanpop', 'string3', 'inputcountycleanpop', 'string3', 'inputgeoblockcleanpop', 'string3', 'inputaddresstypecleanpop', 'string3', 'inputaddressstatuscleanpop', 'string3', 'inputemailcleanpop', 'string3', 'inputhomephonecleanpop', 'string3', 'inputworkphonecleanpop', 'string3', 'inputarchivedatecleanpop', 'integer2', 'arrestcnt1y', 'integer2', 'arrestcnt7y', 'string10', 'arrestnew1y', 'string10', 'arrestold1y', 'string10', 'arrestnew7y', 'string10', 'arrestold7y', 'integer1', 'monsincenewestarrestcnt1y', 'integer1', 'monsinceoldestarrestcnt1y', 'integer1', 'monsincenewestarrestcnt7y', 'integer1', 'monsinceoldestarrestcnt7y', 'integer2', 'crimcnt1y', 'integer2', 'crimcnt7y', 'string10', 'crimnew1y', 'string10', 'crimold1y', 'string10', 'crimnew7y', 'string10', 'crimold7y', 'integer1', 'monsincenewestcrimcnt1y', 'integer1', 'monsinceoldestcrimcnt1y', 'integer1', 'monsincenewestcrimcnt7y', 'integer1', 'monsinceoldestcrimcnt7y', 'integer2', 'felonycnt1y', 'integer2', 'felonycnt7y', 'string10', 'felonynew1y', 'string10', 'felonyold1y', 'string10', 'felonynew7y', 'string10', 'felonyold7y', 'integer1', 'monsincenewestfelonycnt1y', 'integer1', 'monsinceoldestfelonycnt1y', 'integer1', 'monsincenewestfelonycnt7y', 'integer1', 'monsinceoldestfelonycnt7y', 'integer2', 'nonfelonycnt1y', 'integer2', 'nonfelonycnt7y', 'string10', 'nonfelonynew1y', 'string10', 'nonfelonyold1y', 'string10', 'nonfelonynew7y', 'string10', 'nonfelonyold7y', 'integer1', 'monsincenewestnonfelonycnt1y', 'integer1', 'monsinceoldestnonfelonycnt1y', 'integer1', 'monsincenewestnonfelonycnt7y', 'integer1', 'monsinceoldestnonfelonycnt7y', 'string5', 'crimseverityindex7y', 'string3', 'crimbehaviorindex7y']
#data_row= '98','80'
#def_vals=['-99' ,'-97',  '-98']
#when CrimCnt1Y>0, then CrimNew1Y=CrimNew7Y and MonSinceNewestCrimCnt1Y=MonSinceNewestCrimCnt7Y
#Check when CrimCnt7Y=0, then CrimNew7Y=CrimOld7Y=MonSinceNewestCrimCnt7Y=MonSinceOldestCrimCnt7Y=-98
#cond  = ['inputhomephoneecho' ,'<=' ,'0', 'or', 'inputhomephoneecho' ,'>' ,'0',
#         'and', 'inputhomephoneecho','>','2', 'and', 'inputhomephoneecho','<','7']
#cond  = ['inputhomephoneecho' ,'<' ,'0', 'or', 'inputhomephoneecho' ,'>' ,'0',
 #       'and', 'inputhomephoneecho','==','inputworkphoneecho', 'and', 'inputworkphoneecho','==','inputhomephoneecho']

#cond  = ['inputhomephoneecho' ,'<>' ,'0', 'or', 'inputhomephoneecho' ,'==' ,'0',
   #     'and', 'inputhomephoneecho','==','inputworkphoneecho', '==','0']

#cond  = ['(','inputhomephoneecho' ,'<>' ,'0',')', 'or','(', 'inputhomephoneecho' ,'==' ,'0',')',
#        'and','(', 'inputhomephoneecho','==','inputworkphoneecho', '==','0'')']
   # Check MonSinceNewestArrestCnt1Y and MonSinceOldestArrestCnt1Y range 0~12 (except for -99, -98) 
   #Check ArrestNew1Y >= ArrestOld1Y (except for -99, -98)
  # Check ArrestNew7Y >= ArrestOld7Y (except for -99, -98) 
#cond_str='( inputhomephoneecho in [-99,-98]) or ( inputworkphoneecho in [-99,-98] ) or ( inputhomephoneecho >= inputworkphoneecho )'
def_vals =  def_par.split(',') 
#cond_repl=cond.replace(u'\xa0', '')
#cond_repl=unicode(cond, "UTF-8")
#cond_repl =  cond.replace(' ', '')
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