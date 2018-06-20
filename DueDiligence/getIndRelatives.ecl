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
    
    getListOfRelations(relationData, filterRelativesBy) := FUNCTIONMACRO
      
      filteredRelations := relationData(indvType = filterRelativesBy);
      
      //make sure we only have 1 relationship with a given DID
      uniqueDIDs := DEDUP(SORT(filteredRelations, seq, inquiredDID, individual.did), seq, inquiredDID, individual.did);
      
      reformatRelations := PROJECT(uniqueDIDs, TRANSFORM({DueDiligence.LayoutsInternal.InternalSeqAndIdentifiersLayout, DATASET(DueDiligence.Layouts.SlimIndividual) relations},
                                                          SELF.seq := LEFT.seq;
                                                          SELF.did := LEFT.inquiredDID;
                                                          SELF.relations := DATASET([TRANSFORM(DueDiligence.Layouts.SlimIndividual, SELF := LEFT.individual;)]);
                                                          SELF := [];));
                                                          
      sortReformatted := SORT(reformatRelations, seq, did);
      rollReformatted := ROLLUP(sortReformatted,
                                LEFT.seq = RIGHT.seq AND
                                LEFT.did = RIGHT.did,
                                TRANSFORM(RECORDOF(LEFT),
                                          SELF.relations := LEFT.relations + RIGHT.relations;
                                          SELF := LEFT;));
                                          
      RETURN rollReformatted;
    ENDMACRO;
		
	
	
  
  
  
  
  
  
		justDIDs := PROJECT(inData, TRANSFORM(Relationship.Layout_GetRelationship.DIDs_layout, SELF.DID := LEFT.inquiredDID;));									 

		firstDegreeRelationships := getRelations(justDIDs);
		
		spouse := firstDegreeRelationships(title IN Header.relative_titles.set_Spouse);
		parents := firstDegreeRelationships(title IN Header.relative_titles.set_Parent);

    spouseAndParents := parents + spouse;
    
    relatives := JOIN(inData, spouseAndParents,
                      LEFT.inquiredDID = RIGHT.did1,
                      TRANSFORM(DueDiligence.Layouts.Indv_Internal,
                                SELF.seq := LEFT.seq;
                                SELF.inquiredDID := LEFT.inquiredDID;
                                SELF.individual.did := RIGHT.did2;
                                SELF.indvType := IF(RIGHT.title IN Header.relative_titles.set_Spouse, DueDiligence.Constants.INQUIRED_INDIVIDUAL_SPOUSE, DueDiligence.Constants.INQUIRED_INDIVIDUAL_PARENT);
                                SELF := [];));
    
    bestRelativeData := DueDiligence.getIndBestData(relatives, dppa, glba, FALSE);
    
  
    slimmedRolledSpouseData := getListOfRelations(bestRelativeData, DueDiligence.Constants.INQUIRED_INDIVIDUAL_SPOUSE);
    slimmedRolledParentData := getListOfRelations(bestRelativeData, DueDiligence.Constants.INQUIRED_INDIVIDUAL_PARENT);
    
    addSpouse := JOIN(inData, slimmedRolledSpouseData,
                       LEFT.seq = RIGHT.seq AND
                       LEFT.inquiredDID = RIGHT.did,
                       TRANSFORM(DueDiligence.Layouts.Indv_Internal,
                                 SELF.spouses := RIGHT.relations;
                                 SELF.numberOfSpouses := COUNT(RIGHT.relations);
                                 SELF := LEFT;),
                       LEFT OUTER,
                       ATMOST(1));
      																				
    addParents := JOIN(addSpouse, slimmedRolledParentData,
                        LEFT.seq = RIGHT.seq AND
                        LEFT.inquiredDID = RIGHT.did,
                        TRANSFORM(DueDiligence.Layouts.Indv_Internal,
                                  SELF.parents := RIGHT.relations;
                                  SELF.hasParent := COUNT(RIGHT.relations) > 0;
                                  SELF := LEFT;),
                        LEFT OUTER,
                        ATMOST(1));


		
			
				
				
		// OUTPUT(inData, NAMED('relativeInData'));
		// OUTPUT(firstDegreeRelationships, NAMED('firstDegreeRelationships'));
		// OUTPUT(spouse, NAMED('spouse'));
		// OUTPUT(parents, NAMED('parents'));
		// OUTPUT(spouseAndParents, NAMED('spouseAndParents'));
		// OUTPUT(relatives, NAMED('relatives'));
		// OUTPUT(bestRelativeData, NAMED('bestRelativeData'));
		// OUTPUT(slimmedRolledSpouseData, NAMED('slimmedRolledSpouseData'));
		// OUTPUT(slimmedRolledParentData, NAMED('slimmedRolledParentData'));
		// OUTPUT(addSpouse, NAMED('addSpouse'));
		// OUTPUT(addParents, NAMED('addParents'));
		
	
	
		RETURN addParents;
												
END;