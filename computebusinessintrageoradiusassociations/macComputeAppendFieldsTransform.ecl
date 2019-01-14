EXPORT macComputeAppendFieldsTransform(inString, inPrefix) := FUNCTIONMACRO 
  IMPORT STD;
  #UNIQUENAME(CNTR     )
  #UNIQUENAME(CNTR_MAX )
  #UNIQUENAME(APPENDFIELDSTRANSFORM)

  #SET(APPENDFIELDSTRANSFORM,'')
  #SET(CNTR       ,1 )
  #SET(CNTR_MAX   ,STD.Str.CountWords(inString,',') )

  #LOOP
   #IF(%CNTR% > %CNTR_MAX%)
     #BREAK
   #ELSEIF(%CNTR% >= 1)
     #APPEND(APPENDFIELDSTRANSFORM ,'SELF.')
   #END
   
   #APPEND(APPENDFIELDSTRANSFORM , inPrefix + TRIM(STD.Str.Extract( inString, %CNTR% ),ALL) + ':= RIGHT.' + TRIM(STD.Str.Extract( inString, %CNTR% ),ALL) + '; ')
   
   #SET(CNTR ,%CNTR% + 1)

  #END
  
  RETURN %'APPENDFIELDSTRANSFORM'%;
ENDMACRO;
  