IMPORT R, ut, Python;
EXPORT string Layout_Comparison_Macro(set of string lay_set_src, set of string lay_set_desti):= embed(Python)
dummy=''
lay_set_src = ' '.join(lay_set_src).split() 
lay_set_src = '\n'.join(lay_set_src).split() 

for i in range(len(lay_set_desti)):
    try :
        if lay_set_desti[i] == ' ' and lay_set_desti[i-1] != ' ' and lay_set_desti[i-2] == ' ':
            lay_set_desti.remove(lay_set_desti[i-1])
            #del lay_set_desti[i-1]
            dummy=lay_set_desti[i-1]
    except IndexError:
            dummy ='Index Out of Range'

lay_set_desti = lay_set_desti
lay_set_desti = ' '.join(lay_set_desti).split() 
lay_set_desti = '\n'.join(lay_set_desti).split()

layout_string_source=lay_set_src
layout_string_destination=lay_set_desti

#layout_string_source =['integer8', 'B2bActvTLInOthCnt', 'integer', 'B2bActvTLBalInOthTot', 'integer7', 'inputlexidecho', 'integer7', 'xx']   
#layout_string_destination =['integer7', 'B2bActvTLInOthCnt', 'data2', 'B2bActvTLBalInOthTot', 'string50', 'inputlexidecho']

result =''

layout_string_source_DataTypes = []
layout_string_destination_DataTypes = []

layout_string_source_field = []
layout_string_destination_field = []


for j in range(0,len(layout_string_source),2):
    layout_string_source_DataTypes.append(layout_string_source[j])

for j in range(0,len(layout_string_destination),2):
    layout_string_destination_DataTypes.append(layout_string_destination[j])
    
for j in range(1,len(layout_string_source),2):
    layout_string_source_field.append(layout_string_source[j])

for j in range(1,len(layout_string_destination),2):
    layout_string_destination_field.append(layout_string_destination[j])
    
# =============================================================================
# print(layout_string_source_DataTypes)
# print(layout_string_destination_DataTypes)
# print(layout_string_source_field)
# print(layout_string_destination_field)
# =============================================================================



intersection =[i for i in layout_string_destination if i in layout_string_source]

field=[]
# =============================================================================
# dict_datatpes = {"integer" : ["string","integer","string21"], 
#                  "integer1" : ["string","integer","integer1","string4"], 
#                  "integer2" : ["string","integer","integer2","string6"], 
#                  "integer3" : ["string","integer","integer3","string8"], 
#                  "integer4" : ["string","integer","integer4","string11"], 
#                  "integer5" : ["string","integer","integer5","string13"], 
#                  "integer6" : ["string","integer","integer6","string16"], 
#                  "integer7" : ["string","integer","integer7","string18"], 
#                  "integer8" : ["string","integer","integer8","string21"],
#                  
#                  "unsigned" : ["string","unsigned","string20"],
#                  "unsigned1" : ["string","unsigned","unsigned1","string3"], 
#                  "unsigned2" : ["string","unsigned","unsigned2","string5"], 
#                  "unsigned3" : ["string","unsigned","unsigned3","string8"], 
#                  "unsigned4" : ["string","unsigned","unsigned4","string10"], 
#                  "unsigned5" : ["string","unsigned","unsigned5","string13"], 
#                  "unsigned6" : ["string","unsigned","unsigned6","string15"], 
#                  "unsigned7" : ["string","unsigned","unsigned7","string17"], 
#                  "unsigned8" : ["string","unsigned","unsigned8","string20"]                  
# 
#  }
# =============================================================================

dict_datatpes ={         "integer" : "20", 
                         "integer1" : "4", 
                         "integer2" : "6", 
                         "integer3" : "8", 
                         "integer4" : "11", 
                         "integer5" : "13", 
                         "integer6" : "16", 
                         "integer7" : "18", 
                         "integer8" : "20",
                        
                         "unsigned" : "20",
                         "unsigned1" : "3", 
                         "unsigned2" : "5", 
                         "unsigned3" : "8", 
                         "unsigned4" : "10", 
                         "unsigned5" : "13", 
                         "unsigned6" : "15", 
                         "unsigned7" : "17", 
                         "unsigned8" : "20" ,
                                                 
                         'string'  :''
             }

x=0
if len(layout_string_destination_field) <= len(layout_string_source_field):
    x=len(layout_string_destination_field)
else:
    x=len(layout_string_source_field)  
    
   
mylist = []


# flagging if Data Type is mismatched completely

mylist=mylist + [ '\n'+ ' ************ List of fields DATA TYPES are mismatched ************ ']
for field in range(x):
    if layout_string_destination_field[field] == layout_string_source_field[field]:
        if layout_string_destination_DataTypes[field] != layout_string_source_DataTypes[field]:
            mylist.append(layout_string_destination_DataTypes[field] + ' ' + layout_string_destination_field[field] + ' UNMATCHED with ' + layout_string_source_DataTypes[field] + ' ' + layout_string_source_field[field] )
            
# flagging if Data Type is matched but range is mismatched

mylist=mylist + [ '\n'+ ' ************ DATA TYPES are matched but DATA TYPES range mismatched ************ ']
            
for field in range(x):
    if layout_string_destination_field[field] == layout_string_source_field[field]:
        if layout_string_destination_DataTypes[field] != layout_string_source_DataTypes[field]:
            
            destination_datetype  = ''.join(x for x in layout_string_destination_DataTypes[field] if x.isalpha())
            source_datatype = ''.join(x for x in layout_string_source_DataTypes[field] if x.isalpha())
            
            if source_datatype == destination_datetype :
                if  int(''.join(x for x in layout_string_destination_DataTypes[field] if x.isdigit() ) ) < int(''.join(x for x in layout_string_source_DataTypes[field] if x.isdigit() ) ):  
                    mylist.append(layout_string_source_DataTypes[field] + ' VALUE RANGE IS GREATERTHAN THE ' + layout_string_destination_DataTypes[field])
                    #print(''.join(x for x in layout_string_destination_DataTypes[field] if x.isdigit()))
                else:
                    mylist.append('NA')

# flagging if Data Type is mismatched and casting compatible check

mylist=mylist + [ '\n'+ ' ************  Data Types are mismatched and casting compatible check ************ ']  
                    
for field in range(x):
    if layout_string_destination_field[field] == layout_string_source_field[field]:
        if layout_string_destination_DataTypes[field] != layout_string_source_DataTypes[field]:
            
            destination_datetype  = ''.join(x for x in layout_string_destination_DataTypes[field] if x.isalpha())
            source_datatype = ''.join(x for x in layout_string_source_DataTypes[field] if x.isalpha())                    
            if source_datatype != destination_datetype:
                if dict_datatpes[source_datatype]  < ''.join(x for x in layout_string_destination_DataTypes[field] if x.isdigit() ) :
                    mylist.append(layout_string_source_DataTypes[field] + ' ' + layout_string_source_field[field] + ' and ' + layout_string_destination_DataTypes[field] + ' ' + layout_string_destination_field[field] +' VALUE RANGE is good.')
                else:
                    mylist.append(layout_string_source_DataTypes[field] + ' ' + layout_string_source_field[field] + ' and ' + layout_string_destination_DataTypes[field] + ' ' + layout_string_destination_field[field] + ' are not compatible.')
                
                                
print_val='\n'.join(map(str, mylist))     


return str(print_val)
           
endembed;