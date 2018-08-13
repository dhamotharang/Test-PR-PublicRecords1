
EXPORT macPivotLiteV2(d,f,g):=FUNCTIONMACRO
  IMPORT Std;
  LOADXML('<xml/>');
  #DECLARE(o) #SET(o,'')
  #DECLARE(n) #SET(n,0)
  #DECLARE(i) #SET(i,'')
  #DECLARE(FieldName) #SET(FieldName, '')
  #EXPORTXML(fields,RECORDOF(d))
  #FOR(fields)
    #FOR(Field)
      #IF(%'{@isDataset}'%='1')
        #SET(i,%'{@label}'%)
      #ELSE
        #SET(FieldName, %'{@label}'%)
        #IF(%'i'%='' AND Std.Str.Find(Std.Str.ToLowerCase(g), %'FieldName'%) > 0)
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
  #SET(o,'PROJECT(SORT(DISTRIBUTE('+%'o'%[2..]+', HASH32(s)),'+#TEXT(f)+',s, skew(1), LOCAL),{RECORDOF(LEFT)-[s]})');

  RETURN %o%;
ENDMACRO;
