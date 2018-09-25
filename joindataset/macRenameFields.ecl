EXPORT macRenameFields(inData, oldFieldList, newFieldList) := FUNCTIONMACRO  
// Examples:
// oldFieldList - 'id, name'
// newFieldList - 'provider_id, provider_name'

  IMPORT STD;
	
  #UNIQUENAME(OldSubRecStr)
  #UNIQUENAME(NewSubRecStr)
  #UNIQUENAME(TransformStr)
  #UNIQUENAME(C)
  #UNIQUENAME(I)

  #SET(OldSubRecStr, '{')
  #SET(NewSubRecStr, '{')
  #SET(TransformStr, '')
  #SET(C, STD.Str.CountWords(oldFieldList, ','))
  #SET(I, 1)
  #LOOP
    #IF(%I% > %C%)
		  #APPEND(OldSubRecStr, '}')
		  #APPEND(NewSubRecStr, '}')
		  #APPEND(TransformStr, ';')
      #BREAK
    #END
  
    #APPEND(OldSubRecStr, 'old.' + TRIM(STD.Str.Extract(oldFieldList, %I%)))
    #APPEND(NewSubRecStr, TRIM(STD.Str.Extract(newFieldList, %I%)) + ' := old.' + TRIM(STD.Str.Extract(oldFieldList, %I%)))
    #APPEND(TransformStr, 'SELF.' + TRIM(STD.Str.Extract(newFieldList, %I%)) + ' := LEFT.' + TRIM(STD.Str.Extract(oldFieldList, %I%)))
    
    #IF(%I% < %C%)
      #APPEND(OldSubRecStr, ', ')
		  #APPEND(NewSubRecStr, ', ')
		  #APPEND(TransformStr, '; ')
    #END
 
    #SET(I ,%I% + 1)
  #END
	
	LOCAL old := inData;
	LOCAL oldSubRecString := %'OldSubRecStr'%;
  LOCAL oldSubRec := #EXPAND(oldSubRecString);
	LOCAL newSubRecString := %'NewSubRecStr'%;
  LOCAL newSubRec := #EXPAND(newSubRecString);
	LOCAL transformString := %'TransformStr'%;
	
	LOCAL remainRec := RECORDOF(old) - oldSubRec;
	LOCAL newRec := RECORD
	  remainRec;
	  newSubRec;
	END;	
  LOCAL new := PROJECT(old, TRANSFORM(newRec, #EXPAND(transformString) SELF := LEFT;));
	
	RETURN new;
ENDMACRO;