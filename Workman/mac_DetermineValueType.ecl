EXPORT mac_DetermineValueType(

  pValue

) :=
functionmacro

  #uniquename(lvalue)
  #uniquename(returnvalue)
  #SET(lvalue,pValue)
  
  #IF(regexfind('^[[:digit:]]+$',trim(%'lvalue'%),nocase) = true)
    #SET(returnvalue  ,'unsigned')
  #ELSEIF(regexfind('^[-][[:digit:]]+$',trim(%'lvalue'%),nocase) = true)
    #SET(returnvalue  ,'integer')
  #ELSEIF(regexfind('^[-]?[[:digit:]]+?[.][[:digit:]]+$',trim(%'lvalue'%),nocase) = true)
    #SET(returnvalue  ,'real8')
  #ELSE
    #SET(returnvalue  ,'string')
  #END

  return %'returnvalue'%;
  
endmacro;