IMPORT DueDiligence, SexOffender, SexOffender_Services;

/*
	Following Keys being used:
			SexOffender.Key_SexOffender_DID
      SexOffender.Key_SexOffender_SPK
*/
EXPORT getIndCriminalSexOffender(DATASET(DueDiligence.LayoutsInternal.RelatedParty) individuals) := FUNCTION


    //get the SO ids
    soID := JOIN(individuals, SexOffender.Key_SexOffender_DID(), 
                  KEYED(LEFT.did = RIGHT.did),
                  TRANSFORM({UNSIGNED6 did, STRING spk, UNSIGNED4 historyDate},
                              SELF.did := LEFT.did;
                              SELF.historyDate := LEFT.historyDate;
                              SELF.spk := RIGHT.seisint_primary_key;),
                  ATMOST(SexOffender_Services.Constants.MAX_RECS_PERDID));
                  
                  

    soData := JOIN(soID, SexOffender.Key_SexOffender_SPK(),
                   KEYED(LEFT.spk = RIGHT.sspk) AND
                   (UNSIGNED4)RIGHT.dt_first_reported < LEFT.historyDate,
                   TRANSFORM({UNSIGNED6 did, BOOLEAN potentialSO},
                              SELF.did := LEFT.did;
                              SELF.potentialSO := (UNSIGNED)RIGHT.did <> 0;),
                   ATMOST(KEYED(LEFT.spk = RIGHT.sspk), DueDiligence.Constants.MAX_ATMOST_1000), 
                   KEEP(1)); 
                   
                   
    addSOData := JOIN(individuals, soData,
                      LEFT.did = RIGHT.did,
                      TRANSFORM(DueDiligence.LayoutsInternal.RelatedParty,
                                SELF.potentialSO := RIGHT.potentialSO;
                                SELF := LEFT;),
                      LEFT OUTER,
                      ATMOST(1));
                   

             
                        
    // OUTPUT(uniqueIndividuals, NAMED('uniqueIndividuals'));                    
    // OUTPUT(soID, NAMED('soID'));  
    // OUTPUT(soData, NAMED('soData'));  
    // OUTPUT(addSOData, NAMED('addSOData'));  




    RETURN addSOData;                  

END;