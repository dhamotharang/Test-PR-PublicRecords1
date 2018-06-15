EXPORT macRemoveKelFlags(d):=FUNCTIONMACRO
  IMPORT Std;
  LOADXML('<xml/>');
  #DECLARE(o) #SET(o,'')
  #DECLARE(n) #SET(n,0)
  #DECLARE(f) #SET(f,'')
  #EXPORTXML(fields,RECORDOF(d))
  #FOR(fields)
    #FOR(Field)
      #SET(f, %'{@label}'%)
      #IF(%'f'%[LENGTH(TRIM(%'f'%))-4 ..] != 'flags' AND %'f'%[LENGTH(TRIM(%'f'%))-11 ..] != '_recordcount')       
        #IF(%n% > 0)
          // It won't let me put in the comma here so will replace the ; with a comma at the end.
          #APPEND(o, '; ')
        #END
        // Ignore certain columns, _flags 
        #APPEND(o, 'LEFT.'+%'f'%)
        #SET(n,%n%+1)
      #END
    #END
  #END
  RETURN PROJECT(d, TRANSFORM({ #EXPAND(REGEXREPLACE(';', %'o'%, ',')) }, SELF := LEFT));
ENDMACRO;