﻿IMPORT DueDiligence, iesp;

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
																																																												SELF.inquiredDID := LEFT.individual.did;
																																																												SELF.historyDate := LEFT.historyDate;
																																																												SELF.individual := RIGHT;
																																																												SELF.indvType := DueDiligence.Constants.INQUIRED_INDIVIDUAL_PARENT;
																																																												SELF := [];));
		
		RETURN parents;
	END;


END;