//--------------------------------------------------------------------------------
// macComputeTransformStatements
//
// FunctionMacro that is to generate transform statements for projecting fields in LEFT or RIGHT dataset to fields in SELF dataset; 
// Can be used before a PROJECT or a JOIN, then expend the statements into the PROJECT/JOIN.
//
//   FromFieldList  : The fields from LEFT or RIGHT dataset, a comma-delimited string.
//   Prefix         : a string to be prepended to each from-field;
//                    If omitted or is empty, next parameter ToFieldList will be used to extract each to-field;
//                    If has a nonempty string value, the next parameter ToFieldList will not be used no matter it's empty or not.
//   ToFieldList    : The fields in SELF dataset, a comma-delimited string. 
//                    If Prefix has a nonempty string value, this parameter will not be used no matter it's empty or not.
//                    IF Prefix is empty and ToFieldList is also empty, each to-field will be assumed to have the same name as the from-field.
//   IsLeft :       : TRUE - "LEFT." will be prefixed to each from-field; FALSE - "RIGHT." will be prefixed to each from-field.
//
//--------------------------------------------------------------------------------

EXPORT macComputeTransformStatements(FromFieldList, Prefix = '\'\'', ToFieldList = '\'\'', IsLeft = FALSE) := FUNCTIONMACRO

IMPORT STD;

#IF(TRIM(FromFieldList, ALL) <> '')

  #UNIQUENAME(C)
  #UNIQUENAME(I)
  #UNIQUENAME(TransformStr)
  #SET(C, STD.Str.CountWords(FromFieldList, ','))
  #SET(I, 1)
  #SET(TransformStr, '')
	
  #LOOP
    #IF(%I% > %C%)
      #APPEND(TransformStr, '; ')
			#BREAK
    #END
    
    #IF(TRIM(Prefix, ALL) = '')
      #APPEND(TransformStr, 
        'SELF.' + 
        IF(TRIM(STD.Str.Extract(ToFieldList, %I%), ALL) <> '', TRIM(STD.Str.Extract(ToFieldList, %I%), ALL), TRIM(STD.Str.Extract(FromFieldList, %I%), ALL)) +
        ' := ' +
        IF(IsLeft, 'LEFT.', 'RIGHT.') +
        TRIM(STD.Str.Extract(FromFieldList, %I%), ALL)
      )
    #ELSE
      #APPEND(TransformStr, 
        'SELF.' + 
        TRIM(Prefix, ALL) + 
        TRIM(STD.Str.Extract(FromFieldList, %I%), ALL) + 
        ' := ' +
        IF(IsLeft, 'LEFT.', 'RIGHT.') +
        TRIM(STD.Str.Extract(FromFieldList, %I%), ALL)
      )
    #END
    
    #IF(%I% < %C%)
      #APPEND(TransformStr, '; ')
    #END
 
    #SET(I ,%I% + 1)
  #END

  RETURN %'TransformStr'%;
  
#ELSE
  RETURN '';
#END  
ENDMACRO;