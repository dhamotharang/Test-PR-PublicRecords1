EXPORT macComputeAppendFieldsRecord(inString, inPrefix) := FUNCTIONMACRO 
  IMPORT STD;
  #UNIQUENAME(CNTR     )
  #UNIQUENAME(CNTR_MAX )
  #UNIQUENAME(APPENDFIELDSRECORD)

  #SET(APPENDFIELDSRECORD  ,'')
  #SET(CNTR       ,1 )
  #SET(CNTR_MAX   ,STD.Str.CountWords(inString,',') )

  #LOOP
   #IF(%CNTR% > %CNTR_MAX%)
     #BREAK
   #ELSEIF(%CNTR% >= 1)
     #APPEND(APPENDFIELDSRECORD ,'TYPEOF(LEFT.')
   #END
   
   #APPEND(APPENDFIELDSRECORD , STD.Str.FindReplace(TRIM(STD.Str.Extract( inString, %CNTR% ),ALL), ',', '), TYPEOF(LEFT.') + ') '+ inPrefix + TRIM(STD.Str.Extract( inString, %CNTR% ),ALL) + '; ')
   
   #SET(CNTR ,%CNTR% + 1)

  #END
  
  RETURN %'APPENDFIELDSRECORD'%;
ENDMACRO;
  