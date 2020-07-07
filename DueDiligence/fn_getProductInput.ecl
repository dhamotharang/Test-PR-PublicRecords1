IMPORT BIPV2, Business_Risk_BIP, DueDiligence, Doxie;

EXPORT fn_getProductInput(UNSIGNED1 productRequested,
                          DATASET(DueDiligence.Layouts.CleanedData) cleanData,
                          Business_Risk_BIP.LIB_Business_Shell_LIBIN options,
                          BIPV2.mod_sources.iParams linkingOptions,
                          unsigned1 LexIdSourceOptout = 1,
                          string TransactionID = '',
                          string BatchUID = '',
                          unsigned6 GlobalCompanyId = 0) := FUNCTION

    mod_access := MODULE(Doxie.IDataAccess)
      EXPORT glb := options.GLBA_Purpose;
      EXPORT dppa := options.DPPA_Purpose;
      EXPORT unsigned1 lexid_source_optout := LexIdSourceOptout;
      EXPORT string transaction_id := TransactionID; // esp transaction id or batch uid
      EXPORT unsigned6 global_company_id := GlobalCompanyId; // mbs gcid
    END;

    processInd := cleanData(cleanedInput.containsPersonReq);
    processBus := cleanData(cleanedInput.containsPersonReq = FALSE);
    
    


    //====================================
    //        process businesses
    //====================================
    businessInformation := DueDiligence.getBusInformation(options, linkingOptions);
    

    //LexID input (DueDiligence.LayoutsInternal.BestData)
    processBusLexID := processBus(cleanedInput.lexIDPopulated);
    busLexIDInput := businessInformation.SearchByInputLexID(processBusLexID);
    
    //PII input (DueDiligence.LayoutsInternal.BestData)
    processBusPII := processBus(cleanedInput.piiPopulated AND cleanedInput.seq NOT IN SET(busLexIDInput(lexIDValid), seq));
    busPIIInput := businessInformation.SearchByInputPII(processBusPII);
   
    //both valid LexID and PII
    allValidBusSearches := busLexIDInput(lexIDValid) + busPIIInput(piiValid);
    
    


    
    //====================================
    //        process individuals
    //====================================
    personInformation := DueDiligence.getIndInformation(options, mod_access);
    
    //LexID input (DueDiligence.LayoutsInternal.BestData)
    processIndLexID := processInd(cleanedInput.lexIDPopulated);
    indLexIDInput := personInformation.SearchByInputLexID(processIndLexID);

    //PII input (DueDiligence.LayoutsInternal.BestData)
    processIndPII := processInd(cleanedInput.piiPopulated AND cleanedInput.seq NOT IN SET(indLexIDInput(lexIDValid), seq));
    indPIIInput := personInformation.SearchByInputPII(processIndPII);

    //both valid LexID and PII
    allValidIndSearches := indLexIDInput(lexIDValid) + indPIIInput(piiValid);

    //combine both business and person the the shared input layout (DueDiligence.LayoutsInternal.SharedInput)
    validSearches := allValidBusSearches + allValidIndSearches;





    piiLexID := JOIN(cleanData, validSearches,
                      LEFT.cleanedInput.seq = RIGHT.seq,
                      TRANSFORM(DueDiligence.LayoutsInternal.SharedInput,
                                  SELF.dataToUse.lexIDInput := LEFT.cleanedInput.lexIDPopulated;
                                  SELF.dataToUse.piiInput := LEFT.cleanedInput.piiPopulated;
                                  SELF.dataToUse.seq := LEFT.cleanedInput.seq;
                                  SELF.dataToUse := RIGHT;
                                  SELF := LEFT;
                                  SELF := [];),
                      LEFT OUTER,
                      ATMOST(DueDiligence.Constants.MAX_ATMOST_1));
                
                
    bsAndRI := DueDiligence.fn_getIndBSAndRI(processInd, options,
                                                                                  LexIdSourceOptout := LexIdSourceOptout, 
                                                                                  TransactionID := TransactionID, 
                                                                                  BatchUID := BatchUID, 
                                                                                  GlobalCompanyID := GlobalCompanyID);
    
    piiLexIDAndBSAndRI := JOIN(piiLexID, bsAndRI,
                               LEFT.dataToUse.seq = RIGHT.bs.seq,
                               TRANSFORM(DueDiligence.LayoutsInternal.SharedInput,
                                         SELF.dataToUse := LEFT;
                                         SELF.bs := RIGHT.bs;
                                         SELF.riskIndicators := RIGHT.riskIndicators;
                                         SELF := LEFT;),
                               LEFT OUTER,
                               ATMOST(DueDiligence.Constants.MAX_ATMOST_1));
    
   
   
   
    

    final := MAP(productRequested = DueDiligence.CitDDShared.PRODUCT_REQUESTED_ENUM.CITIZENSHIP_ONLY => bsAndRI,  //Citizenship only requested
                 productRequested = DueDiligence.CitDDShared.PRODUCT_REQUESTED_ENUM.BOTH => piiLexIDAndBSAndRI,   //Citizenship and Due Diligence requested
                 productRequested = DueDiligence.CitDDShared.PRODUCT_REQUESTED_ENUM.DUEDILIGENCE_ONLY AND NOT EXISTS(processInd) => piiLexID, //Due Diligence Business Only Requested
                 piiLexIDAndBSAndRI); //Due Diligence Individual or Due Diligence Individual and Business
                 






    // OUTPUT(processInd, NAMED('processInd'));
    // OUTPUT(processBus, NAMED('processBus'));

    // OUTPUT(processBusLexID, NAMED('processBusLexID'));
    // OUTPUT(processBusPII, NAMED('processBusPII'));
    // OUTPUT(busLexIDInput, NAMED('busLexIDInput'));
    // OUTPUT(busPIIInput, NAMED('busPIIInput'));
    // OUTPUT(allValidBusSearches, NAMED('allValidBusSearches'));

    // OUTPUT(processIndLexID, NAMED('processIndLexID'));
    // OUTPUT(indLexIDInput, NAMED('indLexIDInput'));
    // OUTPUT(processIndPII, NAMED('processIndPII'));
    // OUTPUT(indPIIInput, NAMED('indPIIInput'));
    // OUTPUT(allValidIndSearches, NAMED('allValidIndSearches'));
    // OUTPUT(validSearches, NAMED('validSearches'));
    // OUTPUT(piiLexID, NAMED('piiLexID'));

    // OUTPUT(bsAndRI, NAMED('bsAndRI'));
    // OUTPUT(piiLexIDAndBSAndRI, NAMED('piiLexIDAndBSAndRI'));
    // OUTPUT(final, NAMED('final'));
    

    RETURN final;
END;