EXPORT FromFlat(d,l,m):=FUNCTIONMACRO
  LOADXML('<xml/>');
  #DECLARE(dest_field_list) #SET(dest_field_list,'')
  #EXPORTXML(dest_fields,l)
  #FOR(dest_fields)
    #FOR(Field)
      #IF(REGEXFIND('(^|,)'+%'{@label}'%+':',m,NOCASE))
        #APPEND(dest_field_list,','+REGEXFIND('(^|,)('+%'{@label}'%+':[^,]+)($|,)',m,2,NOCASE))
      #ELSE
        #APPEND(dest_field_list,','+%'{@label}'%+':'+%'{@label}'%)
      #END
      #APPEND(dest_field_list,';'+IF(%'{@type}'%[..3]='set','~'+%'{@type}'%[8..],%'{@type}'%)+',')
    #END
  #END
  
  #DECLARE(r) #SET(r,'')
  #DECLARE(transformation) #SET(transformation,'PROJECT('+#TEXT(d)+',TRANSFORM('+#TEXT(l)+',\n')
  #EXPORTXML(orig_fields,RECORDOF(d))
  #FOR(orig_fields)
    #FOR(Field)
      #IF(%'{@isRecord}'%='1')
        #SET(r,%'{@name}'%+'.')
      #ELSE
        #IF(%'{@isend}'%='1')
          #SET(r,'')
        #ELSE
          #IF(REGEXFIND(':'+%'r'%+%'{@label}'%+';',%'dest_field_list'%,NOCASE))
            #APPEND(transformation,'  SELF.'+REGEXFIND(',([^,:]+)(:'+%'r'%+%'{@label}'%+';)',%'dest_field_list'%,1,NOCASE)+':=')
            #APPEND(transformation,IF(REGEXFIND(%'r'%+%'{@label}'%+';~',%'dest_field_list'%,NOCASE),'[',''))
            #APPEND(transformation,'('+REGEXFIND(',([^,:]+)(:'+%'r'%+%'{@label}'%+';)([~]*)([^,:]+)',%'dest_field_list'%,4,NOCASE))
            #APPEND(transformation,')LEFT.'+%'r'%+%'{@label}'%+IF(REGEXFIND(%'r'%+%'{@label}'%+';~',%'dest_field_list'%,NOCASE),']','')+';\n')
          #END
        #END
      #END
    #END
  #END
  #APPEND(transformation,'  SELF:=[];\n))')
  // RETURN %'transformation'%;
  RETURN #EXPAND(%'transformation'%);
ENDMACRO;
