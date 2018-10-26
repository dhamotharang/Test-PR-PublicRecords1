EXPORT macPivotLite(d,f):=FUNCTIONMACRO
  LOADXML('<xml/>');
  #DECLARE(o) #SET(o,'')
  #DECLARE(n) #SET(n,0)
  #DECLARE(i) #SET(i,'')
  #EXPORTXML(fields,RECORDOF(d))
  #FOR(fields)
    #FOR(Field)
      #IF(%'{@isDataset}'%='1')
        #SET(i,%'{@label}'%)
      #ELSE
        #IF(%'i'%='')
          #APPEND(o,'+TABLE('+#TEXT(d)+',{'+#TEXT(f)+';STRING field:=\''+%'{@label}'%+'\';STRING200 value:=(STRING)'+%'{@label}'%+';UNSIGNED s:='+%'n'%+'})\n')
          #SET(n,%n%+1)
        #ELSE
          #IF(%'{@isEnd}'%='1')
            #SET(i,'')
          #END
        #END
      #END
    #END
  #END
  #SET(o,'PROJECT(SORT('+%'o'%[2..]+','+#TEXT(f)+',s, skew(1)),{RECORDOF(LEFT)-[s]})');

  RETURN %o%;
ENDMACRO;

