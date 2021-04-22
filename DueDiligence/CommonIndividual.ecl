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

  EXPORT GetIIDSSNFlags(DATASET(DueDiligence.Layouts.Indv_Internal) inData,
                        doxie.IDataAccess mod_access,
                        INTEGER bsVersion, UNSIGNED8 bsOptions, BOOLEAN isFCRA) := FUNCTION


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

      withSSNFlags := risk_indicators.iid_getSSNFlags(GROUP(ssnFlagsPrepseq, seq),
                                                      mod_access, isFCRA, TRUE, exactMatchLevel, bsVersion, bsOptions);

      RETURN withSSNFlags;
  END;


  EXPORT GetAllRelationships(DATASET(DueDiligence.Layouts.Indv_Internal) inquiredData, BOOLEAN doNotUseFilterdData = FALSE) := FUNCTION

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


      RETURN IF(doNotUseFilterdData, allInd, filtAssoc);
  END;


  EXPORT UpdateRelationships(DATASET(DueDiligence.Layouts.Indv_Internal) inquiredData, DATASET(DueDiligence.LayoutsInternal.RelatedParty) relatedPartyResults, DueDiligence.DataInterface.iAttributePerAssoc dataOptions) := FUNCTION

      getRelationInfo := GetAllRelationships(inquiredData, TRUE);

      rollRelatedPartyInput := ROLLUP(SORT(relatedPartyResults, seq, did),
                                      LEFT.seq = RIGHT.seq AND
                                      LEFT.did = RIGHT.did,
                                      TRANSFORM(DueDiligence.LayoutsInternal.RelatedParty,
                                                SELF.currIncar := LEFT.currIncar OR RIGHT.currIncar;
                                                SELF.prevIncar := LEFT.prevIncar OR RIGHT.prevIncar;
                                                SELF.potentialSO := LEFT.potentialSO OR RIGHT.potentialSO;
                                                SELF.currProbation := LEFT.currProbation OR RIGHT.currProbation;
                                                SELF.currParole := LEFT.currParole OR RIGHT.currParole;
                                                SELF.felonyPast3Years := LEFT.felonyPast3Years OR RIGHT.felonyPast3Years;
                                                SELF := LEFT;));


      updateRelationInfo := JOIN(getRelationInfo, rollRelatedPartyInput,
                                  LEFT.seq = RIGHT.seq AND
                                  LEFT.did = RIGHT.did,
                                  TRANSFORM({RECORDOF(LEFT), DATASET(DueDiligence.Layouts.SlimRelation) spouses, DATASET(DueDiligence.Layouts.SlimRelation) parents, DATASET(DueDiligence.Layouts.SlimRelation) associates},
                                            //roll data to inquired level - will limit if we use the data on the join to the inquired
                                            SELF.currentlyIncarcerated := RIGHT.currIncar OR LEFT.currentlyIncarcerated;
                                            SELF.everIncarcerated := RIGHT.currIncar OR RIGHT.prevIncar OR LEFT.everIncarcerated;
                                            SELF.potentialSexOffender := RIGHT.potentialSO OR LEFT.potentialSexOffender;
                                            SELF.currentlyParoleOrProbation := RIGHT.currProbation OR RIGHT.currParole OR LEFT.currentlyParoleOrProbation;
                                            SELF.felonyPast3Yrs := RIGHT.felonyPast3Years OR LEFT.felonyPast3Yrs;

                                            relly := DATASET([TRANSFORM(DueDiligence.Layouts.SlimRelation,
                                                                                  SELF.currentlyIncarcerated := RIGHT.currIncar OR LEFT.currentlyIncarcerated;
                                                                                  SELF.everIncarcerated := RIGHT.currIncar OR RIGHT.prevIncar OR LEFT.everIncarcerated;
                                                                                  SELF.potentialSexOffender := RIGHT.potentialSO OR LEFT.potentialSexOffender;
                                                                                  SELF.currentlyParoleOrProbation := RIGHT.currProbation OR RIGHT.currParole OR LEFT.currentlyParoleOrProbation;
                                                                                  SELF.felonyPast3Yrs := RIGHT.felonyPast3Years OR LEFT.felonyPast3Yrs;

                                                                                  SELF.offenseTrafficRelated := RIGHT.trafficOffenseFound OR LEFT.offenseTrafficRelated;
                                                                                  SELF.otherCriminalOffense := RIGHT.otherOffenseFound OR RIGHT.potentialSO OR LEFT.otherCriminalOffense;


                                                                                  SELF.headerFirstSeenDate := IF(dataOptions.includeHeaderData, RIGHT.headerFirstSeen, LEFT.headerFirstSeenDate);

                                                                                  SELF.validSSN := RIGHT.validSSN OR LEFT.validSSN;
                                                                                  SELF.ssnLowIssueDate := IF(dataOptions.includeSSNData, RIGHT.ssnLowIssue, LEFT.ssnLowIssueDate);
                                                                                  SELF.ssnMultiIdentities := IF(dataOptions.includeSSNData, RIGHT.ssnMultiIdentities, LEFT.ssnMultiIdentities);
                                                                                  SELF.ssnPerADL := IF(dataOptions.includeSSNData, RIGHT.ssnPerADL, LEFT.ssnPerADL);
                                                                                  SELF.hasSSN := RIGHT.hasSSN OR LEFT.hasSSN;
                                                                                  SELF.ssnRisk := RIGHT.ssnRisk OR LEFT.ssnRisk;

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

                                        SELF.relationCurrentlyIncarcerated := RIGHT.currentlyIncarcerated OR LEFT.relationCurrentlyIncarcerated;
                                        SELF.relationEverIncarcerated := RIGHT.everIncarcerated OR LEFT.relationEverIncarcerated;
                                        SELF.relationPotentialSexOffender := RIGHT.potentialSexOffender OR LEFT.relationPotentialSexOffender;
                                        SELF.relationCurrentlyParoleOrProbation := RIGHT.currentlyParoleOrProbation OR LEFT.relationCurrentlyParoleOrProbation;
                                        SELF.relationFelonyPast3Years := RIGHT.felonyPast3Yrs OR LEFT.relationFelonyPast3Years;

                                        SELF := LEFT;),
                              LEFT OUTER,
                              ATMOST(1));


      RETURN updateInquired;
  END;




END;  //END OF MODULE
