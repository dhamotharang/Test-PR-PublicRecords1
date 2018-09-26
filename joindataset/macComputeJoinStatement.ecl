EXPORT macComputeJoinStatement(inString1, inString2) := FUNCTIONMACRO 
  IMPORT STD;
  #UNIQUENAME(CNTR     )
  #UNIQUENAME(CNTR_MAX )
  #UNIQUENAME(CONDITION)

  #SET(CONDITION  ,'')
  #SET(CNTR       ,1 )
  #SET(CNTR_MAX   ,STD.Str.CountWords(inString1,',') )

  #LOOP
    #IF(%CNTR% > %CNTR_MAX%)
      #BREAK
    #ELSEIF(%CNTR% > 1)
      #APPEND(CONDITION ,' AND ')
    #END
    
    #APPEND(CONDITION ,'LEFT.' + STD.Str.Extract( inString1, %cntr% ) + '=' + '(TYPEOF(LEFT.'+ STD.Str.Extract( inString1, %cntr% ) + '))'+ 'RIGHT.' + STD.Str.Extract( inString2, %cntr% )  )
    
    #SET(CNTR ,%CNTR% + 1)

  #end
  
  RETURN %'CONDITION'%;
ENDMACRO;
  