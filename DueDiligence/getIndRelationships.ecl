IMPORT Business_Risk_BIP, Doxie, DueDiligence, Header, Relationship, RelationshipIdentifier_Services;

EXPORT getIndRelationships(DATASET(DueDiligence.Layouts.Indv_Internal) inData,
                           Business_Risk_BIP.LIB_Business_Shell_LIBIN options,
                           doxie.IDataAccess mod_access = MODULE (doxie.IDataAccess) END) := FUNCTION
												
		
    
    UNSIGNED1 dppa := options.DPPA_Purpose;
    UNSIGNED1 glba := options.GLBA_Purpose;										

	
    getRelations(DATASET(Relationship.Layout_GetRelationship.DIDs_layout) listOfDIDs) := FUNCTION
      
        relativeIDs := Relationship.proc_GetRelationshipNeutral(listOfDIDs, TopNCount := 100, RelativeFlag := TRUE, AssociateFlag := TRUE, 
                                                         doAtmost := TRUE, MaxCount := DueDiligence.Constants.MAX_ATMOST_1000).Result;
                                                          
        RETURN relativeIDs;
    END;
    
    
    getListOfRelations(relationData, filterRelativesBy) := FUNCTIONMACRO
      
        filteredRelations := relationData(indvType IN filterRelativesBy);
        
        //make sure we only have 1 relationship with a given DID
        uniqueDIDs := DEDUP(SORT(filteredRelations, seq, inquiredDID, individual.did), seq, inquiredDID, individual.did);
        
        reformatRelations := PROJECT(uniqueDIDs, TRANSFORM({DueDiligence.LayoutsInternal.InternalSeqAndIdentifiersLayout, DATASET(DueDiligence.Layouts.SlimRelation) relations},
                                                            SELF.seq := LEFT.seq;
                                                            SELF.did := LEFT.inquiredDID;
                                                            SELF.relations := DATASET([TRANSFORM(DueDiligence.Layouts.SlimRelation, 
                                                                                                  SELF.relationToInquired := MAP(LEFT.indvType IN [DueDiligence.Constants.INQUIRED_INDIVIDUAL_SPOUSE] => DueDiligence.Constants.INQUIRED_INDIVIDUAL_SPOUSE,
                                                                                                                                 LEFT.indvType IN [DueDiligence.Constants.INQUIRED_INDIVIDUAL_PARENT] => DueDiligence.Constants.INQUIRED_INDIVIDUAL_PARENT,
                                                                                                                                 DueDiligence.Constants.INQUIRED_INDIVIDUAL_OTHER_RELATION);
                                                                                                                                 
                                                                                                  amlDegree := IF(LEFT.indvType IN [DueDiligence.Constants.INQUIRED_INDIVIDUAL_SPOUSE, 
                                                                                                                                    DueDiligence.Constants.INQUIRED_INDIVIDUAL_PARENT,
                                                                                                                                    DueDiligence.Constants.INQUIRED_INDIVIDUAL_FIRST_DEGREE], 1, 10);
                                                                                                                                       
                                                                                                                                 
                                                                                                  SELF.amlRelationshipDegree := IF(LEFT.individual.relationship IN Header.relative_titles.set_Parent, 10, amlDegree);
                                                                                                  SELF.rawRelationshipType := LEFT.indvType;
                                                                                                  SELF := LEFT.individual; 
                                                                                                  SELF := [];)]);
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
    uniqueJustDIDs := DEDUP(SORT(justDIDs, did), did);

    firstDegreeRelationships := getRelations(uniqueJustDIDs);

    spouse := firstDegreeRelationships(title IN Header.relative_titles.set_Spouse AND TYPE = RelationshipIdentifier_Services.Constants.RELTYPE_PERSONAL AND CONFIDENCE = RelationshipIdentifier_Services.Constants.HIGH);
    parents := firstDegreeRelationships(title IN Header.relative_titles.set_Parent AND TYPE = RelationshipIdentifier_Services.Constants.RELTYPE_PERSONAL AND CONFIDENCE = RelationshipIdentifier_Services.Constants.HIGH);

    spouseAndParents := parents + spouse;
    
    otherFirstDegreeRelationships := firstDegreeRelationships(did2 NOT IN SET(spouseAndParents, did2));

    relatives := JOIN(inData, otherFirstDegreeRelationships + spouseAndParents,
                      LEFT.inquiredDID = RIGHT.did1,
                      TRANSFORM(DueDiligence.Layouts.Indv_Internal,
                                SELF.seq := LEFT.seq;
                                SELF.historyDate := LEFT.historyDate;
                                SELF.inquiredDID := LEFT.inquiredDID;
                                SELF.individual.did := RIGHT.did2;
                                SELF.indvType := MAP(RIGHT.title IN Header.relative_titles.set_Spouse => DueDiligence.Constants.INQUIRED_INDIVIDUAL_SPOUSE, 
                                                     RIGHT.title IN Header.relative_titles.set_Parent => DueDiligence.Constants.INQUIRED_INDIVIDUAL_PARENT,
                                                     DueDiligence.Constants.INQUIRED_INDIVIDUAL_FIRST_DEGREE);
                                SELF.individual.relationship := RIGHT.title;
                                SELF := [];));
	

    //get the parents of the first degree relationships
    firstDegreeJustDIDs := PROJECT(spouseAndParents + otherFirstDegreeRelationships, TRANSFORM(Relationship.Layout_GetRelationship.DIDs_layout, SELF.DID := LEFT.did2;));
    uniqueFirstDegreeDIDs := DEDUP(SORT(firstDegreeJustDIDs, did), did);
    
    secondDegreeRelationships := getRelations(uniqueFirstDegreeDIDs);
    firstDegreeParents := secondDegreeRelationships(title in Header.relative_titles.set_Parent AND did2 NOT IN SET(justDIDs, did));

    parentsOfFirstDegree := JOIN(relatives, firstDegreeParents,
                                  LEFT.individual.did = RIGHT.did1,
                                  TRANSFORM(DueDiligence.Layouts.Indv_Internal,
                                            SELF.seq := LEFT.seq;
                                            SELF.historyDate := LEFT.historyDate;
                                            SELF.inquiredDID := LEFT.inquiredDID;
                                            SELF.individual.did := RIGHT.did2;
                                            SELF.indvType := DueDiligence.Constants.INQUIRED_INDIVIDUAL_SECOND_DEGREE;
                                            
                                            SELF.individual.relationship := RIGHT.title;
                                            SELF := [];));
		
    //get unique relationships per inquired and unique relationships
    allUniqueRelationships := DEDUP(SORT(parentsOfFirstDegree + relatives, seq, inquiredDID, individual.did, indvType, individual.relationship), seq, inquiredDID, individual.did);
    uniqueRelationshipDIDs := DEDUP(SORT(parentsOfFirstDegree + relatives, individual.did), individual.did);

    bestRelativeData := DueDiligence.getIndInformation(options, mod_access).GetIndividualBestDataWithLexID(uniqueRelationshipDIDs);
    
    addBestDataToUniqueRelationships := JOIN(allUniqueRelationships, bestRelativeData,
                                             LEFT.individual.did = RIGHT.individual.did,
                                             TRANSFORM(DueDiligence.Layouts.Indv_Internal,
                                                        SELF.seq := LEFT.seq;
                                                        SELF.historyDate := LEFT.historyDate;
                                                        SELF.inquiredDID := LEFT.inquiredDID;
                                                        SELF.indvType := LEFT.indvType;
                                                        SELF.individual.relationship := LEFT.individual.relationship;
                                                        SELF := RIGHT;),
                                             LEFT OUTER);


    slimmedRolledSpouseData := getListOfRelations(addBestDataToUniqueRelationships, [DueDiligence.Constants.INQUIRED_INDIVIDUAL_SPOUSE]);
    slimmedRolledParentData := getListOfRelations(addBestDataToUniqueRelationships, [DueDiligence.Constants.INQUIRED_INDIVIDUAL_PARENT]);
    slimmedRolledRelationData := getListOfRelations(addBestDataToUniqueRelationships, [DueDiligence.Constants.INQUIRED_INDIVIDUAL_FIRST_DEGREE, DueDiligence.Constants.INQUIRED_INDIVIDUAL_SECOND_DEGREE]);

    addSpouse := JOIN(inData, slimmedRolledSpouseData,
                      LEFT.seq = RIGHT.seq AND
                      LEFT.inquiredDID = RIGHT.did,
                      TRANSFORM(DueDiligence.Layouts.Indv_Internal,
                                SELF.spouses := LEFT.spouses + RIGHT.relations;
                                SELF := LEFT;),
                      LEFT OUTER,
                      ATMOST(DueDiligence.Constants.MAX_ATMOST_1));
                
    addParents := JOIN(addSpouse, slimmedRolledParentData,
                        LEFT.seq = RIGHT.seq AND
                        LEFT.inquiredDID = RIGHT.did,
                        TRANSFORM(DueDiligence.Layouts.Indv_Internal,
                                  SELF.parents := LEFT.parents + RIGHT.relations;
                                  SELF.hasParent := COUNT(RIGHT.relations) > 0;
                                  SELF := LEFT;),
                        LEFT OUTER,
                        ATMOST(DueDiligence.Constants.MAX_ATMOST_1));
						
    addOtherRelations := JOIN(addParents, slimmedRolledRelationData,
                              LEFT.seq = RIGHT.seq AND
                              LEFT.inquiredDID = RIGHT.did,
                              TRANSFORM(DueDiligence.Layouts.Indv_Internal,
                                        SELF.associates := LEFT.associates + RIGHT.relations;
                                        SELF := LEFT;),
                              LEFT OUTER,
                              ATMOST(DueDiligence.Constants.MAX_ATMOST_1));


		
			
				
				
    // OUTPUT(inData, NAMED('relativeInData'));
    // OUTPUT(firstDegreeRelationships, NAMED('firstDegreeRelationships'));
    // OUTPUT(spouse, NAMED('spouse'));
    // OUTPUT(parents, NAMED('parents'));
    // OUTPUT(spouseAndParents, NAMED('spouseAndParents'));
    // OUTPUT(otherFirstDegreeRelationships, NAMED('otherFirstDegreeRelationships'));
    // OUTPUT(relatives, NAMED('relatives'));

    // OUTPUT(firstDegreeJustDIDs, NAMED('firstDegreeJustDIDs'));
    // OUTPUT(uniqueFirstDegreeDIDs, NAMED('uniqueFirstDegreeDIDs'));
    // OUTPUT(secondDegreeRelationships, NAMED('secondDegreeRelationships'));
    // OUTPUT(firstDegreeParents, NAMED('firstDegreeParents'));

    // OUTPUT(parentsOfFirstDegree, NAMED('parentsOfFirstDegree'));
    // OUTPUT(allUniqueRelationships, NAMED('allUniqueRelationships'));
    // OUTPUT(uniqueRelationshipDIDs, NAMED('uniqueRelationshipDIDs'));
    // OUTPUT(bestRelativeData, NAMED('bestRelativeData'));
    // OUTPUT(addBestDataToUniqueRelationships, NAMED('addBestDataToUniqueRelationships'));

    // OUTPUT(slimmedRolledSpouseData, NAMED('slimmedRolledSpouseData'));
    // OUTPUT(slimmedRolledParentData, NAMED('slimmedRolledParentData'));    
    // OUTPUT(slimmedRolledRelationData, NAMED('slimmedRolledRelationData'));

    // OUTPUT(addSpouse, NAMED('addSpouse'));
    // OUTPUT(addParents, NAMED('addParents'));
    // OUTPUT(addOtherRelations, NAMED('addOtherRelations'));



    RETURN addOtherRelations;
												
END;