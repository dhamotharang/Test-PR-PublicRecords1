IMPORT DueDiligence, Header, Relationship, RelationshipIdentifier_Services, RiskWise;

EXPORT getIndRelatives(DATASET(DueDiligence.Layouts.Indv_Internal) inData,
																							UNSIGNED1 dppa,
																							UNSIGNED1 glba,
																							BOOLEAN includeReport = FALSE) := FUNCTION
												
												

	
		getRelations(DATASET(Relationship.Layout_GetRelationship.DIDs_layout) listOfDIDs) := FUNCTION
			
			relativeIDs := Relationship.proc_GetRelationship(listOfDIDs, TopNCount:=100, RelativeFlag := TRUE, AssociateFlag := TRUE, 
																												doAtmost := TRUE, MaxCount := RiskWise.max_atmost).Result;
																												
			filtRelatives := relativeIDs(TYPE = RelationshipIdentifier_Services.Constants.RELTYPE_PERSONAL and CONFIDENCE = RelationshipIdentifier_Services.Constants.HIGH);
			
			RETURN filtRelatives;
		END;
		
		
		justDIDs := PROJECT(inData, TRANSFORM(Relationship.Layout_GetRelationship.DIDs_layout, SELF.DID := LEFT.inquiredDID;));									 

		firstDegreeRelationships := getRelations(justDIDs);
		
		spouse := firstDegreeRelationships(title IN Header.relative_titles.set_Spouse);
		parents := firstDegreeRelationships(title IN Header.relative_titles.set_Parent);
		
		//temp code
		cntSpouse := PROJECT(spouse, TRANSFORM({UNSIGNED4 spouseCnt, RECORDOF(LEFT)}, SELF.spouseCnt := 1; SELF := LEFT;));
		
		rollSpouseCnt := ROLLUP(SORT(cntSpouse, did1),
																											LEFT.did1 = RIGHT.did1,
																											TRANSFORM(RECORDOF(LEFT),
																																						SELF.spouseCnt := LEFT.spouseCnt + RIGHT.spouseCnt;
																																						SELF := LEFT;));
																																						
																																						
			addSpouseCnt := JOIN(inData, rollSpouseCnt,
																				LEFT.inquiredDID = RIGHT.did1,
																				TRANSFORM(DueDiligence.Layouts.Indv_Internal,
																														SELF.numberOfSpouses := RIGHT.spouseCnt;
																														SELF := LEFT;),
																				LEFT OUTER);																																			
																																						
		//end temp code																																				
		
		//only want 1 spouse
		topSpouse := DEDUP(SORT(spouse, did1, did2), did1); 
		
		spouseAndParents := parents + topSpouse;
		
		relatives := JOIN(inData, spouseAndParents,
																				LEFT.inquiredDID = RIGHT.did1,
																				TRANSFORM(DueDiligence.Layouts.Indv_Internal,
																														SELF.seq := LEFT.seq;
																														SELF.inquiredDID := LEFT.inquiredDID;
																														SELF.individual.did := RIGHT.did2;
																														SELF.indvType := IF(RIGHT.title IN Header.relative_titles.set_Spouse, DueDiligence.Constants.INQUIRED_INDIVIDUAL_SPOUSE, DueDiligence.Constants.INQUIRED_INDIVIDUAL_PARENT);
																														SELF := [];));
		
		relativeData := DueDiligence.getIndBestData(relatives, dppa, glba, FALSE);
		
		slimRelative := PROJECT(relativeData, TRANSFORM({UNSIGNED4 seq, UNSIGNED6 inquiredExecDID, STRING2 indvType, DueDiligence.Layouts.SlimIndividual individual},
																																																				SELF.inquiredExecDID := LEFT.inquiredDID;
																																																				SELF.seq := LEFT.seq;
																																																				SELF.individual := LEFT.individual;
																																																				SELF := LEFT;
																																																				SELF := [];));
		
		addSpouse := JOIN(addSpouseCnt, slimRelative(indvType = DueDiligence.Constants.INQUIRED_INDIVIDUAL_SPOUSE),
																				LEFT.seq = RIGHT.seq AND
																				LEFT.inquiredDID = RIGHT.inquiredExecDID,
																				TRANSFORM(DueDiligence.Layouts.Indv_Internal,
																														SELF.spouse := RIGHT.individual;
																														SELF := LEFT;),
																				LEFT OUTER);
																				
		addParents := DENORMALIZE(addSpouse, slimRelative(indvType = DueDiligence.Constants.INQUIRED_INDIVIDUAL_PARENT),
																												LEFT.seq = RIGHT.seq AND
																												LEFT.inquiredDID = RIGHT.inquiredExecDID,
																												TRANSFORM(DueDiligence.Layouts.Indv_Internal,
																																	SELF.parents := LEFT.parents + RIGHT.individual;
																																	SELF.hasParent := LEFT.hasParent OR RIGHT.individual.did <> 0;
																																	SELF := LEFT;),
																												LEFT OUTER);
		
			
				
				
		// OUTPUT(inData, NAMED('relativeInData'));
		// OUTPUT(firstDegreeRelationships, NAMED('firstDegreeRelationships'));
		// OUTPUT(spouse, NAMED('spouse'));
		// OUTPUT(parents, NAMED('parents'));
		// OUTPUT(topSpouse, NAMED('topSpouse'));
		// OUTPUT(spouseAndParents, NAMED('spouseAndParents'));
		// OUTPUT(relatives, NAMED('relatives'));
		// OUTPUT(relativeData, NAMED('relativeData'));
		// OUTPUT(slimRelative, NAMED('slimRelative'));
		// OUTPUT(addSpouse, NAMED('addSpouse'));
		// OUTPUT(addParents, NAMED('addParents'));
		
		
		// OUTPUT(rollSpouseCnt, NAMED('rollSpouseCnt'));
	
	
		RETURN addParents;
												
END;