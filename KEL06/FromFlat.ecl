EXPORT FromFlat(d,l,m):=FUNCTIONMACRO
    LOADXML('<xml/>');
    #DECLARE(f) #SET(f,'PROJECT('+#TEXT(d)+',TRANSFORM('+#TEXT(l)+',')
    #DECLARE(prefix) #SET(prefix, '')
    #DECLARE(indataset) #SET(indataset, 0)
    #DECLARE(label)
    #DECLARE(mapped)
    #DECLARE(nullval)
    #DECLARE(found)  #SET(found, 0)
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
            #IF(%'nullval'% != '')
              #APPEND(f,'IF((TYPEOF('+#TEXT(l)+'.'+%'mapped'%+'.v))LEFT.'+%'label'%+'='+%'nullval'%+
                                          ',__DefaultFromItem('+#TEXT(l)+'.'+%'mapped'%+'.v),'+
                                          '(TYPEOF('+#TEXT(l)+'.'+%'mapped'%+'.v))LEFT.'+%'label'%+');')
            #ELSE
              #APPEND(f,'(TYPEOF('+#TEXT(l)+'.'+%'mapped'%+'.v))LEFT.'+%'label'%+';')
            #END
            #APPEND(f,'SELF.'+%'mapped'%+'.f:=')
            #IF(%'nullval'% != '')
              #APPEND(f,'IF((TYPEOF('+#TEXT(l)+'.'+%'mapped'%+'.v))LEFT.'+%'label'%+'='+%'nullval'%+
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
    RETURN #EXPAND(%'f'%);
ENDMACRO;
