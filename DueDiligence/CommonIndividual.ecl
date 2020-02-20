IMPORT doxie, DueDiligence, Risk_Indicators;

EXPORT CommonIndividual := MODULE

	
	EXPORT GetRelationshipAsInquired(inquiredInd, dsNameFromInquiredInd, relationToInquired) := FUNCTIONMACRO
  
    relationship := NORMALIZE(inquiredInd, LEFT.dsNameFromInquiredInd, 
                              TRANSFORM(DueDiligence.Layouts.Indv_Internal,
                                        SELF.seq := LEFT.seq;
                                        SELF.inquiredDID := LEFT.individual.did;
                                        SELF.historyDate := LEFT.historyDate;
                                        SELF.historyDateRaw := LEFT.historyDateRaw;
                                        SELF.individual := RIGHT;
                                        SELF.indvType := relationToInquired;
                                        SELF := [];));

    RETURN relationship;
	ENDMACRO;
    


  EXPORT CreateRelatedPartyDataset(DATASET(DueDiligence.Layouts.Indv_Internal) inData) := FUNCTION
    //Need to convert the inquuired individual into a dataset in order to re-use modules created for indivuals and Business executives
    indivRelatedParty := PROJECT(inData, TRANSFORM({DATASET(DueDiligence.LayoutsInternal.RelatedParty) inquiredDS},
                                                    SELF.inquiredDS := PROJECT(LEFT, TRANSFORM(DueDiligence.LayoutsInternal.RelatedParty, 
                                                                                             SELF.seq := LEFT.seq;
                                                                                             SELF.did := LEFT.individual.did;
                                                                                             SELF.party := LEFT.individual;
                                                                                             SELF := LEFT;
                                                                                             SELF := [];));
                                                    SELF := [];));

    RETURN indivRelatedParty.inquiredDS;
  END;
  
  EXPORT GetIIDSSNFlags(DATASET(DueDiligence.Layouts.Indv_Internal) inData, STRING dataRestrictionMask,
                        UNSIGNED1 dppa, UNSIGNED1 glba, INTEGER bsVersion, UNSIGNED8 bsOptions, BOOLEAN isFCRA,
                        doxie.IDataAccess mod_access = MODULE (doxie.IDataAccess) END) := FUNCTION
      
      
      exactMatchLevel := risk_indicators.iid_constants.default_ExactMatchLevel;
      
      ssnFlagsPrepSeq := PROJECT(inData, TRANSFORM(Risk_Indicators.Layout_output,
                                                    stringDate := (STRING)LEFT.historyDate;
                                                    SELF.seq := COUNTER;
                                                    SELF.account := (STRING)LEFT.seq;
                                                    SELF.historyDate := (UNSIGNED)stringDate[1..6];
                                                    SELF.did := LEFT.individual.did;
                                                    SELF.fname := LEFT.individual.firstName;
                                                    SELF.mname := LEFT.individual.middleName;
                                                    SELF.lname := LEFT.individual.lastName;
                                                    SELF.suffix := LEFT.individual.suffix;
                                                    SELF.dob := (STRING)LEFT.individual.dob;
                                                    SELF.phone10 := LEFT.individual.phone;
                                                    SELF.p_city_name := LEFT.individual.city;
                                                    SELF.st := LEFT.individual.state;
                                                    SELF.z5 := LEFT.individual.zip5;
                                                    SELF.lat := LEFT.individual.geo_lat;
                                                    SELF.long := LEFT.individual.geo_long;
                                                    SELF.addr_type := LEFT.individual.rec_type;
                                                    SELF.addr_status := LEFT.individual.err_stat;
                                                    SELF := LEFT.individual;
                                                    SELF := [];));	

      withSSNFlags := risk_indicators.iid_getSSNFlags(GROUP(ssnFlagsPrepseq, seq), dppa, glba, isFCRA, TRUE, exactMatchLevel, dataRestrictionMask, bsVersion, bsOptions,
                                                                                              mod_access := mod_access);	
		
      RETURN withSSNFlags;
  END;
  
  
  EXPORT GetAllRelationships(DATASET(DueDiligence.Layouts.Indv_Internal) inquiredData) := FUNCTION
  
      NormalizeRelationships(dsNameFromInquiredInd, relationshipToInquired) := FUNCTIONMACRO
          RETURN NORMALIZE(inquiredData, LEFT.dsNameFromInquiredInd, 
                            TRANSFORM(DueDiligence.LayoutsInternal.SlimRelationWithHistoryDate,
                                              SELF.seq := LEFT.seq;
                                              SELF.inquiredDID := LEFT.inquiredDID;
                                              SELF.relationToInquired := relationshipToInquired;
                                              SELF.historyDate := LEFT.historyDate;
                                              SELF := RIGHT;
                                              SELF := [];));
      ENDMACRO;
  
      parents := NormalizeRelationships(parents, DueDiligence.Constants.INQUIRED_INDIVIDUAL_PARENT);
      spouses := NormalizeRelationships(spouses, DueDiligence.Constants.INQUIRED_INDIVIDUAL_SPOUSE);
      associates := NormalizeRelationships(associates, DueDiligence.Constants.INQUIRED_INDIVIDUAL_OTHER_RELATION);
      
      allInd := parents + spouses + associates;


      //make sure there are no spouses or parents in the associates list      
      filtAssoc := DEDUP(SORT(allInd, seq, did, -relationToInquired), seq, did);

      
      RETURN filtAssoc;
  END;  
  
  
  EXPORT UpdateRelationships(DATASET(DueDiligence.Layouts.Indv_Internal) inquiredData, DATASET(DueDiligence.LayoutsInternal.RelatedParty) relatedPartyResults, DueDiligence.DataInterface.iAttributePerAssoc dataOptions) := FUNCTION
  
      getRelationInfo := GetAllRelationships(inquiredData);                               
                                              
                                              
      updateRelationInfo := JOIN(getRelationInfo, relatedPartyResults,
                                  LEFT.seq = RIGHT.seq AND
                                  LEFT.did = RIGHT.did,
                                  TRANSFORM({RECORDOF(LEFT), DATASET(DueDiligence.Layouts.SlimRelation) spouses, DATASET(DueDiligence.Layouts.SlimRelation) parents, DATASET(DueDiligence.Layouts.SlimRelation) associates},
                                            //roll data to inquired level - will limit if we use the data on the join to the inquired
                                            SELF.currentlyIncarcerated := RIGHT.currIncar AND LEFT.amlrelationshipdegree NOT IN DueDiligence.Constants.AML_PARENT_DEFINITION;
                                            SELF.everIncarcerated := (RIGHT.currIncar OR RIGHT.prevIncar) AND LEFT.amlrelationshipdegree NOT IN DueDiligence.Constants.AML_PARENT_DEFINITION;
                                            SELF.potentialSexOffender := RIGHT.potentialSO AND LEFT.amlrelationshipdegree NOT IN DueDiligence.Constants.AML_PARENT_DEFINITION;
                                            SELF.currentlyParoleOrProbation := (RIGHT.currProbation OR RIGHT.currParole) AND LEFT.amlrelationshipdegree NOT IN DueDiligence.Constants.AML_PARENT_DEFINITION;
                                            SELF.felonyPast3Yrs := RIGHT.felonyPast3Years AND LEFT.amlrelationshipdegree NOT IN DueDiligence.Constants.AML_PARENT_DEFINITION;
                                            
                                            relly := DATASET([TRANSFORM(DueDiligence.Layouts.SlimRelation,
                                                                                  SELF.currentlyIncarcerated := IF(dataOptions.includeLegalData, RIGHT.currIncar, LEFT.currentlyIncarcerated);
                                                                                  SELF.everIncarcerated := IF(dataOptions.includeLegalData, RIGHT.currIncar OR RIGHT.prevIncar, LEFT.everIncarcerated);
                                                                                  SELF.potentialSexOffender := IF(dataOptions.includeLegalData, RIGHT.potentialSO, LEFT.potentialSexOffender);
                                                                                  SELF.currentlyParoleOrProbation := IF(dataOptions.includeLegalData, RIGHT.currProbation OR RIGHT.currParole, LEFT.currentlyParoleOrProbation);
                                                                                  SELF.felonyPast3Yrs := IF(dataOptions.includeLegalData, RIGHT.felonyPast3Years, LEFT.felonyPast3Yrs);
                                                                                  
                                                                                  SELF.headerFirstSeenDate := IF(dataOptions.includeHeaderData, RIGHT.headerFirstSeen, LEFT.headerFirstSeenDate);
                                                                                  
                                                                                  SELF.validSSN := IF(dataOptions.includeSSNData, RIGHT.validSSN, LEFT.validSSN);
                                                                                  SELF.ssnLowIssueDate := IF(dataOptions.includeSSNData, RIGHT.ssnLowIssue, LEFT.ssnLowIssueDate);
                                                                                  SELF.ssnMultiIdentities := IF(dataOptions.includeSSNData, RIGHT.ssnMultiIdentities, LEFT.ssnMultiIdentities);
                                                                                  SELF.ssnPerADL := IF(dataOptions.includeSSNData, RIGHT.ssnPerADL, LEFT.ssnPerADL);
                                                                                  SELF.hasSSN := IF(dataOptions.includeSSNData, RIGHT.hasSSN, LEFT.hasSSN);
                                                                                  SELF.ssnRisk := IF(dataOptions.includeSSNData, RIGHT.ssnRisk, LEFT.ssnRisk);
                                                                                  
                                                                                  SELF := LEFT;)]);
                                            
                                            SELF.spouses := IF(LEFT.relationToInquired = DueDiligence.Constants.INQUIRED_INDIVIDUAL_SPOUSE, relly);
                                            SELF.parents := IF(LEFT.relationToInquired = DueDiligence.Constants.INQUIRED_INDIVIDUAL_PARENT, relly);
                                            SELF.associates := IF(LEFT.relationToInquired = DueDiligence.Constants.INQUIRED_INDIVIDUAL_OTHER_RELATION, relly);
                                                                                  
                                            SELF := LEFT;),
                                  LEFT OUTER);
                                
      
      sortRelation := SORT(updateRelationInfo, seq, inquiredDID, relationToInquired);
      
      rollRelation := ROLLUP(sortRelation,
                              LEFT.seq = RIGHT.seq AND
                              LEFT.inquiredDID = RIGHT.inquiredDID,
                              TRANSFORM(RECORDOF(LEFT),
                                        SELF.currentlyIncarcerated := LEFT.currentlyIncarcerated OR RIGHT.currentlyIncarcerated;
                                        SELF.everIncarcerated := LEFT.everIncarcerated OR RIGHT.everIncarcerated;
                                        SELF.potentialSexOffender := LEFT.potentialSexOffender OR RIGHT.potentialSexOffender;
                                        SELF.currentlyParoleOrProbation := LEFT.currentlyParoleOrProbation OR RIGHT.currentlyParoleOrProbation;
                                        SELF.felonyPast3Yrs := LEFT.felonyPast3Yrs OR RIGHT.felonyPast3Yrs;
                                        
                                        SELF.spouses := LEFT.spouses + RIGHT.spouses;
                                        SELF.parents := LEFT.parents + RIGHT.parents;
                                        SELF.associates := LEFT.associates + RIGHT.associates;
                                        SELF := LEFT;));
      
      
      
      updateInquired := JOIN(inquiredData, rollRelation,
                              LEFT.seq = RIGHT.seq AND
                              LEFT.inquiredDID = RIGHT.inquiredDID,
                              TRANSFORM(DueDiligence.Layouts.Indv_Internal,
                                        
                                        SELF.spouses := RIGHT.spouses;
                                        SELF.parents := RIGHT.parents;
                                        SELF.associates := RIGHT.associates;
                                        
                                        SELF.numberOfSpouses := COUNT(RIGHT.spouses);
                                        SELF.numberOfParents := COUNT(RIGHT.parents);
                                        SELF.numberOfAssociates := COUNT(RIGHT.associates);
                                        
                                        SELF.relationCurrentlyIncarcerated := IF(dataOptions.includeLegalData, RIGHT.currentlyIncarcerated, LEFT.relationCurrentlyIncarcerated);
                                        SELF.relationEverIncarcerated := IF(dataOptions.includeLegalData, RIGHT.everIncarcerated, LEFT.relationEverIncarcerated);
                                        SELF.relationPotentialSexOffender := IF(dataOptions.includeLegalData, RIGHT.potentialSexOffender, LEFT.relationPotentialSexOffender);
                                        SELF.relationCurrentlyParoleOrProbation := IF(dataOptions.includeLegalData, RIGHT.currentlyParoleOrProbation, LEFT.relationCurrentlyParoleOrProbation);
                                        SELF.relationFelonyPast3Years := IF(dataOptions.includeLegalData, RIGHT.felonyPast3Yrs, LEFT.relationFelonyPast3Years);
                                        
                                        SELF := LEFT;),
                              LEFT OUTER,
                              ATMOST(1));
      
      RETURN updateInquired;
  END;
  
  


END;  //END OF MODULE