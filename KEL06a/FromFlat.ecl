EXPORT FromFlat(d,l,m):=FUNCTIONMACRO
    LOADXML('<xml/>');
    #DECLARE(f) #SET(f,'PROJECT('+#TEXT(d)+',TRANSFORM('+#TEXT(l)+',')
    #DECLARE(prefix) #SET(prefix, '')
    #DECLARE(indataset) #SET(indataset, 0)
    #DECLARE(label)
    #DECLARE(mapped)
    #DECLARE(nullval)
    #DECLARE(found)  #SET(found, 0)
    #DECLARE(ktype)
    #DECLARE(ftype)
    #DECLARE(ctype)
    #DECLARE(caster) 
    #EXPORTXML(fields,RECORDOF(d))
    #FOR(fields)
      #FOR(Field)
        #IF(%{@isRecord}%=1 AND %indataset%=0)
          #SET(prefix, %'prefix'%+%'{@label}'%+'.')
        #ELSEIF(%{@isDataset}%>0)
          #SET(indataset, %indataset%+1)
        #ELSEIF(%{@isEnd}%=1 AND %indataset%>1)
          #SET(indataset, %indataset%-1)
        #ELSEIF(%{@isEnd}%=1)
          #SET(prefix, REGEXFIND('^(.*\\.)?[^.]+\\.', %'prefix'%, 1, NOCASE))
        #ELSEIF(%indataset%)
          // Skip everything in child datasets
        #ELSE
          #SET(label, %'prefix'%+%'{@label}'%)
          #IF(REGEXFIND(':'+%'label'%+'(:[^,]*)?(,|$)', m, NOCASE))
            #SET(found, 1);
            #SET(mapped, REGEXFIND('(^|,)([^:]+):('+%'label'%+')((:)([^,]*))?(,|$)', m, 2, NOCASE))
            #SET(nullval,REGEXFIND('(^|,)([^:]+):('+%'label'%+')((:)([^,]*))?(,|$)', m, 6, NOCASE))
            #APPEND(f,'SELF.'+%'mapped'%+'.v:=')
            // bypass the cast if both the ECL field and the NULL constant are STRINGs
            #SET(kType, #GETDATATYPE((TYPEOF(l.%mapped%.v))''))
            #SET(fType, #GETDATATYPE(d.%label%)) 
            #SET(cType, #GETDATATYPE(%nullval%)) 
            #SET(caster,'')
            #IF(%'fType'%[1..6]<>'string' OR %'cType'%[1..6]<>'string')
                #SET(caster, '(TYPEOF(' + #TEXT(l) + '.' + %'mapped'% + '.v))')
            #END
            // report an error if an integer field is given a string null
            #IF(%'kType'%[1..7]='integer' AND %'fType'%[1..7]='integer' AND %'cType'%[1..6]='string')
                #ERROR('KEL INTEGER property '+%'mapped'%+' (from ECL INTEGER '+%'label'%+') cannot be given a NULL of type STRING (\''+%nullval%+'\'}')
                #SET(nullval,0) 
            #END
            #IF(%'nullval'% != '')
              #APPEND(f,'IF('+%'caster'%+'LEFT.'+%'label'%+'='+%'nullval'%+
                            ',__DefaultFromItem('+#TEXT(l)+'.'+%'mapped'%+'.v),'+
                            '(TYPEOF('+#TEXT(l)+'.'+%'mapped'%+'.v))LEFT.'+%'label'%+');')
            #ELSE
              #APPEND(f,'(TYPEOF('+#TEXT(l)+'.'+%'mapped'%+'.v))LEFT.'+%'label'%+';')
            #END
            #APPEND(f,'SELF.'+%'mapped'%+'.f:=')
            #IF(%'nullval'% != '')
              #APPEND(f,'IF('+%'caster'%+'LEFT.'+%'label'%+'='+%'nullval'%+
                                                        ',__NullFlag,__NotNullFlag);')
            #ELSE
              #APPEND(f,'__NotNullFlag;')
            #END
          #END
        #END
      #END
    #END
    #APPEND(f,'SELF:=[]))')
    #IF(%found%=0)
        #WARNING('KEL program used no fields from this input')
    #END
    //#ERROR(%'f'%);
    RETURN #EXPAND(%'f'%);
ENDMACRO;
