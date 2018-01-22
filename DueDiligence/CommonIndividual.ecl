IMPORT DueDiligence, iesp;

EXPORT CommonIndividual := MODULE

	// EXPORT IndividualJoin(joinTo, didFieldName, keyName, whereClause, joinType, maxRecords = 5) := FUNCTIONMACRO

		// LOCAL atmostMax := IF(maxRecords > 0, 'ATMOST(' + maxRecords + ')', DueDiligence.Constants.EMPTY);
		// LOCAL addJoinType := IF(joinType = DueDiligence.Constants.EMPTY, joinType, joinType + ',');
		// LOCAL didField := 'LEFT.' + didFieldName;
		
		// LOCAL joinResult := JOIN(joinTo, #EXPAND(keyName), 
																											// #EXPAND(whereClause), 
																											// TRANSFORM({UNSIGNED4 seq, UNSIGNED6 inDid, UNSIGNED4 historyDate, RECORDOF(RIGHT)},
																																// SELF.seq := LEFT.seq;
																																// SELF.inDid := #EXPAND(didField);
																																// SELF.historyDate := LEFT.historyDate;
																																// SELF := RIGHT), 
																											// #EXPAND(addJoinType)					
																											// #EXPAND(atmostMax)); 
												
		// RETURN joinResult;

	// ENDMACRO;
	
	EXPORT getParents(DATASET(DueDiligence.Layouts.Indv_Internal) inquiredInd) := FUNCTION
		
		parents := NORMALIZE(inquiredInd, LEFT.parents, TRANSFORM(DueDiligence.Layouts.Indv_Internal,
																																																												SELF.seq := LEFT.seq;
																																																												SELF.historyDate := LEFT.historyDate;
																																																												SELF.individual := RIGHT;
																																																												SELF.indvType := DueDiligence.Constants.INQUIRED_INDIVIDUAL_PARENT;
																																																												SELF := [];));
		
		RETURN parents;
	END;

	
	//routine to set fields where at least one parent did/has something
	//assuming the datatset passed in has a field named indvType and seq that ties the parents together populated
	//dsNVPairs = dataset of name value pairs, name = ds name field to populate (assuming boolean), value = field and condition from ds passed in want to check
	//currently coded to take in a max of 5 name/value pairs
	//sameple LEFT.name := LEFT.name OR RIGHT.value --> LEFT.atLeastOneParentHasSSN := LEFT.atLeastOneParentHasSSN OR RIGHT.ssnExists
	EXPORT atleastOneParent(ds, dsNVPairs) := FUNCTIONMACRO


/* 		getDSFields(CONST STRING leftName, CONST STRING rightValue) := FUNCTION
   		
   				// leftName := TRIM(z[num].name);
   				// rightValue := TRIM(z[num].value);
   		
   				STRING fieldDataString := 'SELF.' + leftName + ' := LEFT.' + leftName + ' OR RIGHT.' + rightValue + ';';
   				
   				RETURN fieldDataString;
   		END;
   	
   
   		numberOfPairs := COUNT(dsNVPairs);
   		field1 := IF(numberOfPairs >= 1, getDSFields(dsNVPairs[1].name, dsNVPairs[1].value), DueDiligence.Constants.EMPTY);
   		// field2 := IF(numberOfPairs >= 2, getDSFields(dsNVPairs[2]), DueDiligence.Constants.EMPTY);
   		// field3 := IF(numberOfPairs >= 3, getDSFields(dsNVPairs[3]), DueDiligence.Constants.EMPTY);
   		// field4 := IF(numberOfPairs >= 4, getDSFields(dsNVPairs[4]), DueDiligence.Constants.EMPTY);
   		// field5 := IF(numberOfPairs >= 5, getDSFields(dsNVPairs[5]), DueDiligence.Constants.EMPTY);
   		
   
   		
   		
   		parentData := ds(indvType = DueDiligence.Constants.INQUIRED_INDIVIDUAL_PARENT);
   		
   		// sort parent data to rollup to
   		sortParents := SORT(parentData, seq);
   
   		
   		// roll parent info to the fields
   		rollValidatedParents := ROLLUP(sortParents, 
   																																	LEFT.seq = RIGHT.seq,
   																																	TRANSFORM({RECORDOF(sortParents)},
   																																	
   																																												#EXPAND(IF(numberOfPairs >= 1, field1, DueDiligence.Constants.EMPTY))
   																																												
   																																												SELF := LEFT;));
   		
   		
   						
   						
   		OUTPUT(numberOfPairs, NAMED('numberOfPairs'));
   		OUTPUT(field1, NAMED('field1'));
   		// OUTPUT(field2, NAMED('field2'));
   		// OUTPUT(field3, NAMED('field3'));
   		// OUTPUT(field4, NAMED('field4'));
   		// OUTPUT(field5, NAMED('field5'));
   		OUTPUT(parentData, NAMED('parentData'));
   		OUTPUT(sortParents, NAMED('sortParents'));
   		OUTPUT(rollValidatedParents, NAMED('rollValidatedParents'));
*/


						
		RETURN '';

	ENDMACRO;

END;