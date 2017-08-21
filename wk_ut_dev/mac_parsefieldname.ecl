/*
  returns a field parsed out.  fieldname,datasetname,indexed field
*/
EXPORT mac_parsefieldname(

  pFieldString

) :=
functionmacro

import std,_control,tools;

  #UNIQUENAME(trimstring )
  #UNIQUENAME(lregex     )
  #UNIQUENAME(trimstring )
  #UNIQUENAME(ECLPARSE        )
  
  #SET(ECLPARSE          ,'' )
  #SET(trimstring   ,trim(pFieldString,left,right));
  #SET(lregex       ,'^(.*?)(\\[[[:digit:]]+\\][.].+)$');

  #IF(STD.Str.WordCount(%'trimstring'%) = 1 and not regexfind(%'lregex'%,%'trimstring'%,nocase))
    #APPEND(ECLPARSE ,%'trimstring'%)
    #APPEND(ECLPARSE ,',' + %'trimstring'%)
    #APPEND(ECLPARSE ,',')
  #ELSEIF(STD.Str.WordCount(%'trimstring'%)  = 1 and     regexfind(%'lregex'%,%'trimstring'%,nocase))
    #APPEND(ECLPARSE ,      regexreplace(%'lregex'%,%'trimstring'%,'$1',nocase))    
    #APPEND(ECLPARSE ,',' + regexreplace(%'lregex'%,%'trimstring'%,'$1',nocase))    
    #APPEND(ECLPARSE ,',' + regexreplace(%'lregex'%,%'trimstring'%,'$2',nocase))    
  #ELSEIF(STD.Str.WordCount(%'trimstring'%)  = 2 and not regexfind(%'lregex'%,STD.Str.GetNthWord(%'trimstring'%,2),nocase))
    #APPEND(ECLPARSE ,STD.Str.GetNthWord(%'trimstring'%,1))    
    #APPEND(ECLPARSE ,',' + STD.Str.GetNthWord(%'trimstring'%,2))
    #APPEND(ECLPARSE ,',')
  #ELSEIF(STD.Str.WordCount(%'trimstring'%)  = 2 and     regexfind(%'lregex'%,STD.Str.GetNthWord(%'trimstring'%,2),nocase))
    #APPEND(ECLPARSE ,STD.Str.GetNthWord(%'trimstring'%,1))    
    #APPEND(ECLPARSE ,',' + regexreplace(%'lregex'%,STD.Str.GetNthWord(%'trimstring'%,2),'$1',nocase))    
    #APPEND(ECLPARSE ,',' + regexreplace(%'lregex'%,STD.Str.GetNthWord(%'trimstring'%,2),'$2',nocase))    
  #ELSE
    #APPEND(ECLPARSE ,'')
  #END
/*  
  #IF(STD.Str.WordCount(%'trimstring'%) = 1 and not regexfind(%'lregex'%,%'trimstring'%,nocase))
    #APPEND(ECL ,%'trimstring'%)
  #ELSEIF(STD.Str.WordCount(%'trimstring'%)  = 1 and     regexfind(%'lregex'%,%'trimstring'%,nocase))
    #APPEND(ECL ,regexreplace(%'lregex'%,%'trimstring'%,'$1',nocase))    
  #ELSEIF(STD.Str.WordCount(%'trimstring'%)  = 2)
    #APPEND(ECL ,STD.Str.GetNthWord(%'trimstring'%,1))    
  #ELSE
    #APPEND(ECL ,'')
  #END
*/
/*  
  myfieldname   := map(STD.Str.WordCount(trimstring)  = 1 and not regexfind(lregex,trimstring,nocase) => trimstring
                      ,STD.Str.WordCount(trimstring)  = 1 and     regexfind(lregex,trimstring,nocase) => regexreplace(lregex,trimstring,'$1',nocase)
                      ,STD.Str.WordCount(trimstring)  = 2                                             => STD.Str.GetNthWord(trimstring,1)
                      ,'');

  mydatasetname := map(STD.Str.WordCount(trimstring)  = 1 and not regexfind(lregex,trimstring,nocase) => ''
                      ,STD.Str.WordCount(trimstring)  = 1 and     regexfind(lregex,trimstring,nocase) => regexreplace(lregex,trimstring,'$1',nocase)
                      ,STD.Str.WordCount(trimstring)  = 2 and not regexfind(lregex,STD.Str.GetNthWord(trimstring,2),nocase) => ''
                      ,STD.Str.WordCount(trimstring)  = 2 and     regexfind(lregex,STD.Str.GetNthWord(trimstring,2),nocase) => regexreplace(lregex,STD.Str.GetNthWord(trimstring,2),'$1',nocase)
                      ,'');
  indexDsField  := map(STD.Str.WordCount(trimstring)  = 1 and not regexfind(lregex,trimstring,nocase) => ''
                      ,STD.Str.WordCount(trimstring)  = 1 and     regexfind(lregex,trimstring,nocase) => regexreplace(lregex,trimstring,'$2',nocase)
                      ,STD.Str.WordCount(trimstring)  = 2 and not regexfind(lregex,STD.Str.GetNthWord(trimstring,2),nocase) => ''
                      ,STD.Str.WordCount(trimstring)  = 2 and     regexfind(lregex,STD.Str.GetNthWord(trimstring,2),nocase) => regexreplace(lregex,STD.Str.GetNthWord(trimstring,2),'$2',nocase)
                      ,'');

*/

  return %'ECLPARSE'%;
  
endmacro;