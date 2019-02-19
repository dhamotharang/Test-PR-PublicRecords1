/*
  returns a condition( < 1000) parsed out.  operator,value
  '< 1000000' = '<,1000000'

*/
EXPORT mac_parse_Condition(

  pCondition

) :=
functionmacro

import std,_control,tools;

  #UNIQUENAME(trimstring )
  #UNIQUENAME(lregex     )
  #UNIQUENAME(trimstring )
  #UNIQUENAME(ECLPARSE        )
  
  #SET(ECLPARSE          ,'' )
  #SET(trimstring   ,trim(pCondition,left,right));
  #SET(lregex       ,'^([<>!=]+)[ ]+(.*)$');

  #IF(%'trimstring'% != '' and regexfind(%'lregex'%,%'trimstring'%,nocase))
    #APPEND(ECLPARSE ,      regexreplace(%'lregex'%,%'trimstring'%,'$1',nocase))    
    #APPEND(ECLPARSE ,',' + regexreplace(%'lregex'%,%'trimstring'%,'$2',nocase))    
  #ELSE
    #APPEND(ECLPARSE ,'')
  #END

  return %'ECLPARSE'%;
  
endmacro;