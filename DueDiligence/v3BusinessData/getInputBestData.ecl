IMPORT DueDiligence;


EXPORT getInputBestData(DATASET(DueDiligence.v3Layouts.Internal.BusinessTemp) inData,
                        DueDiligence.DDInterface.iDDRegulatoryCompliance regulatoryAccess,
                        DueDiligence.DDInterface.iDDBusinessOptions ddOptions) := FUNCTION



    mac_dataToUse(inputField, bestField, validBusiness) := FUNCTIONMACRO
        RETURN MAP(validBusiness = FALSE => inputField,
                   ddOptions.inputUsage = DueDiligence.Constants.USE_INPUT_DATA_ENUM.DD_RULES => bestField,
                   ddOptions.inputUsage = DueDiligence.Constants.USE_INPUT_DATA_ENUM.AS_IS => inputField,
                   ddOptions.inputUsage = DueDiligence.Constants.USE_INPUT_DATA_ENUM.BEST_IF_INPUT_EMPTY AND inputField = DueDiligence.Constants.EMPTY => bestField,
                   ddOptions.inputUsage = DueDiligence.Constants.USE_INPUT_DATA_ENUM.BEST_IF_INPUT_EMPTY AND inputField <> DueDiligence.Constants.EMPTY => inputField,
                   bestField);
    ENDMACRO;
    
    mac_bipsToUse(inputData, bestData, validBusiness) := FUNCTIONMACRO
        
        useInputBIPs := inputData.inquiredBusiness.seleID > 0;
        
        inputBus := PROJECT(inputData, TRANSFORM(DueDiligence.v3Layouts.Internal.SlimBusiness,
                                                 SELF.ultID := LEFT.inquiredBusiness.ultID;
                                                 SELF.orgID := LEFT.inquiredBusiness.orgID;
                                                 SELF.seleID := LEFT.inquiredBusiness.seleID;
                                                 SELF.proxID := LEFT.inquiredBusiness.proxID;
                                                 SELF.powID := LEFT.inquiredBusiness.powID;
                                                 SELF := [];));
                                                 
        bestBus := PROJECT(bestData, TRANSFORM(DueDiligence.v3Layouts.Internal.SlimBusiness,
                                               SELF.ultID := LEFT.ultID;
                                               SELF.orgID := LEFT.orgID;
                                               SELF.seleID := LEFT.seleID;
                                               SELF.proxID := LEFT.proxID;
                                               SELF.powID := LEFT.powID;
                                               SELF := [];));

        
        RETURN MAP(validBusiness = FALSE => inputBus,
                   ddOptions.inputUsage = DueDiligence.Constants.USE_INPUT_DATA_ENUM.DD_RULES => bestBus,
                   ddOptions.inputUsage = DueDiligence.Constants.USE_INPUT_DATA_ENUM.AS_IS => inputBus,
                   ddOptions.inputUsage = DueDiligence.Constants.USE_INPUT_DATA_ENUM.BEST_IF_INPUT_EMPTY AND useInputBIPs => inputBus,
                   ddOptions.inputUsage = DueDiligence.Constants.USE_INPUT_DATA_ENUM.BEST_IF_INPUT_EMPTY AND useInputBIPs = FALSE => bestBus,
                   bestBus);
    ENDMACRO;
    
    mac_addressToUse(inputData, bestData, validBusiness, searchByLexID) := FUNCTIONMACRO
        
        inputFullAddress := (inputData.inquiredBusiness.streetAddress1 <> DueDiligence.Constants.EMPTY OR inputData.inquiredBusiness.prim_name <> DueDiligence.Constants.EMPTY) AND 
                             inputData.inquiredBusiness.city <> DueDiligence.Constants.EMPTY AND 
                             inputData.inquiredBusiness.state <> DueDiligence.Constants.EMPTY AND 
                             inputData.inquiredBusiness.zip <> DueDiligence.Constants.EMPTY;
                             
        inputAddress := PROJECT(inputData, TRANSFORM(DueDiligence.v3Layouts.Internal.Address,
                                                      SELF.streetAddress1 := LEFT.inquiredBusiness.streetAddress1;
                                                      SELF.streetAddress2 := LEFT.inquiredBusiness.streetAddress2;
                                                      SELF.prim_range := LEFT.inquiredBusiness.prim_range;
                                                      SELF.predir := LEFT.inquiredBusiness.predir;
                                                      SELF.prim_name := LEFT.inquiredBusiness.prim_name;
                                                      SELF.addr_suffix := LEFT.inquiredBusiness.addr_suffix;
                                                      SELF.postdir := LEFT.inquiredBusiness.postdir;
                                                      SELF.unit_desig := LEFT.inquiredBusiness.unit_desig;
                                                      SELF.sec_range := LEFT.inquiredBusiness.sec_range;
                                                      SELF.city := LEFT.inquiredBusiness.city;
                                                      SELF.state := LEFT.inquiredBusiness.state;
                                                      SELF.zip := LEFT.inquiredBusiness.zip;
                                                      SELF.zip4 := LEFT.inquiredBusiness.zip4;
                                                      SELF.geo_blk := LEFT.inquiredBusiness.geo_blk;
                                                      SELF.county := LEFT.inquiredBusiness.county;
                                                      SELF.countyName := LEFT.inquiredBusiness.countyName;
                                                      SELF := [];));  
                                                      
        bestAddress := PROJECT(bestData, TRANSFORM(DueDiligence.v3Layouts.Internal.Address,
                                                    SELF.streetAddress1 := LEFT.streetAddress1;
                                                    SELF.streetAddress2 := LEFT.streetAddress2;
                                                    SELF.prim_range := LEFT.prim_range;
                                                    SELF.predir := LEFT.predir;
                                                    SELF.prim_name := LEFT.prim_name;
                                                    SELF.addr_suffix := LEFT.addr_suffix;
                                                    SELF.postdir := LEFT.postdir;
                                                    SELF.unit_desig := LEFT.unit_desig;
                                                    SELF.sec_range := LEFT.sec_range;
                                                    SELF.city := LEFT.city;
                                                    SELF.state := LEFT.state;
                                                    SELF.zip := LEFT.zip;
                                                    SELF.zip4 := LEFT.zip4;
                                                    SELF.geo_blk := LEFT.geo_blk;
                                                    SELF.county := LEFT.county;
                                                    SELF.countyName := LEFT.countyName;
                                                    SELF := [];));
                                               
        //if searching by lexID always use best
        //if searching by PII and have full input address, use input address
        //if searching by PII and do not have full input address, use best
        mapDDAddrRules := MAP(searchByLexID => bestAddress,
                              searchByLexID = FALSE AND inputFullAddress => inputAddress,
                              searchByLexID = FALSE AND inputFullAddress = FALSE => bestAddress,
                              bestAddress);
                              
        RETURN MAP(validBusiness = FALSE => inputAddress,
                   ddOptions.inputUsage = DueDiligence.Constants.USE_INPUT_DATA_ENUM.DD_RULES => mapDDAddrRules,
                   ddOptions.inputUsage = DueDiligence.Constants.USE_INPUT_DATA_ENUM.AS_IS => inputAddress,
                   ddOptions.inputUsage = DueDiligence.Constants.USE_INPUT_DATA_ENUM.BEST_IF_INPUT_EMPTY AND inputFullAddress => inputAddress,
                   ddOptions.inputUsage = DueDiligence.Constants.USE_INPUT_DATA_ENUM.BEST_IF_INPUT_EMPTY AND inputFullAddress = FALSE => bestAddress,
                   bestAddress);
    ENDMACRO;










    bestData := DueDiligence.v3BusinessData.getBestData(regulatoryAccess);
    
    //get inquired individuals by lexID
    searchByLexID := inData(inquiredBusiness.seleID > 0);
        
    //get unique iquireds - no need to get the same data twice
    uniqueBusinesses := DEDUP(SORT(searchByLexID, inquiredBusiness.seleID), inquiredBusiness.seleID);
    
    transUniqueBusinesses := PROJECT(uniqueBusinesses, TRANSFORM(DueDiligence.v3Layouts.InternalBusiness.SlimBestSearch,
                                                                 SELF.seq := LEFT.seq;
                                                                 SELF.seleID := LEFT.inquiredBusiness.seleID;
                                                                 SELF.historyDate := LEFT.historyDate;
                                                                 SELF := [];));



    bestDataByLexID := bestData.SearchWithLexID(transUniqueBusinesses);
    
    updateInquiredBest := JOIN(inData, bestDataByLexID,
                               LEFT.seq = RIGHT.seq,
                               TRANSFORM(DueDiligence.v3Layouts.Internal.BusinessTemp,
                                         SELF.seq := LEFT.seq;
                                         
                                         lexIDValid := RIGHT.companyName <> DueDiligence.Constants.EMPTY OR
                                                       RIGHT.fein <> DueDiligence.Constants.EMPTY OR
                                                       RIGHT.phone <> DueDiligence.Constants.EMPTY OR
                                                       RIGHT.streetAddress1 <> DueDiligence.Constants.EMPTY OR
                                                       RIGHT.city <> DueDiligence.Constants.EMPTY OR
                                                       RIGHT.state <> DueDiligence.Constants.EMPTY OR
                                                       RIGHT.zip <> DueDiligence.Constants.EMPTY;
                                                         
                                         
                                         SELF.validBusiness := lexIDValid;
                                         SELF.lexIDScore := RIGHT.lexIDScore;
                                         SELF.bestData := IF(lexIDValid AND ddOptions.inputUsage <> DueDiligence.Constants.USE_INPUT_DATA_ENUM.AS_IS, RIGHT);
                                                          
                                         bipsToUse := mac_bipsToUse(LEFT, RIGHT, lexIDValid);
                                                          
                                         SELF.inquiredBusiness.ultID := bipsToUse.ultID;
                                         SELF.inquiredBusiness.orgID := bipsToUse.orgID;
                                         SELF.inquiredBusiness.seleID := bipsToUse.seleID;
                                         SELF.inquiredBusiness.proxID := bipsToUse.proxID;
                                         SELF.inquiredBusiness.powID := bipsToUse.powID;
                                         
                                         SELF.inquiredBusiness.companyName := mac_dataToUse(LEFT.inquiredBusiness.companyName, RIGHT.companyName, lexIDValid);
                                         SELF.inquiredBusiness.fein := mac_dataToUse(LEFT.inquiredBusiness.fein, RIGHT.fein, lexIDValid);
                                         SELF.inquiredBusiness.phone := mac_dataToUse(LEFT.inquiredBusiness.phone, RIGHT.phone, lexIDValid);
                                         
                                         
                                         
                                         //determine which address to use
                                         addressToUse := mac_addressToUse(LEFT, RIGHT, lexIDValid, TRUE);
                                         
                                         SELF.inquiredBusiness.streetAddress1 := addressToUse.streetAddress1;
                                         SELF.inquiredBusiness.streetAddress2 := addressToUse.streetAddress2;
                                         SELF.inquiredBusiness.prim_range := addressToUse.prim_range;
                                         SELF.inquiredBusiness.predir := addressToUse.predir;
                                         SELF.inquiredBusiness.prim_name := addressToUse.prim_name;
                                         SELF.inquiredBusiness.addr_suffix := addressToUse.addr_suffix;
                                         SELF.inquiredBusiness.postdir := addressToUse.postdir;
                                         SELF.inquiredBusiness.unit_desig := addressToUse.unit_desig;
                                         SELF.inquiredBusiness.sec_range := addressToUse.sec_range;
                                         
                                         SELF.inquiredBusiness.city := addressToUse.city;
                                         SELF.inquiredBusiness.state := addressToUse.state;
                                         SELF.inquiredBusiness.zip := addressToUse.zip;
                                         SELF.inquiredBusiness.zip4 := addressToUse.zip4;
                                         SELF.inquiredBusiness.geo_blk := addressToUse.geo_blk;
                                         SELF.inquiredBusiness.county := addressToUse.county;
                                         SELF.inquiredBusiness.countyName := addressToUse.countyName;
                                         
                                         SELF := LEFT;));


    
    
    //if we didn't get a best lexID/information, see if we can get it via the BII entered
    noLexIDInput := inData(inquiredBusiness.seleID = 0);
    noValidLexIDInput := updateInquiredBest(validBusiness = FALSE AND
                                            (inquiredBusiness.companyName <> DueDiligence.Constants.EMPTY OR
                                            inquiredBusiness.fein <> DueDiligence.Constants.EMPTY OR
                                            inquiredBusiness.phone <> DueDiligence.Constants.EMPTY OR
                                            inquiredBusiness.streetAddress1 <> DueDiligence.Constants.EMPTY OR
                                            inquiredBusiness.city <> DueDiligence.Constants.EMPTY OR
                                            inquiredBusiness.state <> DueDiligence.Constants.EMPTY OR
                                            inquiredBusiness.zip <> DueDiligence.Constants.EMPTY));
    
    searchByBII := noLexIDInput + noValidLexIDInput;
    
    
    transBII := PROJECT(searchByBII, TRANSFORM(DueDiligence.v3Layouts.InternalBusiness.SlimBestSearch,
                                               SELF.seq := LEFT.seq;
                                               SELF.companyName := LEFT.inquiredBusiness.companyName;
                                               SELF.fein := LEFT.inquiredBusiness.fein;
                                               SELF.phone := LEFT.inquiredBusiness.phone;
                                               
                                               SELF.streetaddress1 := LEFT.inquiredBusiness.streetaddress1;
                                               SELF.streetaddress2 := LEFT.inquiredBusiness.streetaddress2;
                                               SELF.prim_range := LEFT.inquiredBusiness.prim_range;
                                               SELF.predir := LEFT.inquiredBusiness.predir;
                                               SELF.prim_name := LEFT.inquiredBusiness.prim_name;
                                               SELF.addr_suffix := LEFT.inquiredBusiness.addr_suffix;
                                               SELF.postdir := LEFT.inquiredBusiness.postdir;
                                               SELF.unit_desig := LEFT.inquiredBusiness.unit_desig;
                                               SELF.sec_range := LEFT.inquiredBusiness.sec_range;
                                               
                                               SELF.city := LEFT.inquiredBusiness.city;
                                               SELF.state := LEFT.inquiredBusiness.state;
                                               SELF.zip := LEFT.inquiredBusiness.zip;
                                               
                                               SELF := [];));
                                               
    bestDataByBII := bestData.SearchWithBII(transBII);
    
    updateInquiredBIIBest := JOIN(inData, bestDataByBII,
                                   LEFT.seq = RIGHT.seq,
                                   TRANSFORM(DueDiligence.v3Layouts.Internal.BusinessTemp,
                                             SELF.seq := LEFT.seq;
                                             
                                             lexIDValid := RIGHT.seleID > 0; 
                                                             
                                             SELF.validBusiness := lexIDValid;
                                             SELF.lexIDScore := RIGHT.lexIDScore;
                                             SELF.bestData := IF(lexIDValid AND ddOptions.inputUsage <> DueDiligence.Constants.USE_INPUT_DATA_ENUM.AS_IS, RIGHT);
                                                              
                                             bipsToUse := mac_bipsToUse(LEFT, RIGHT, lexIDValid);
                                                              
                                             SELF.inquiredBusiness.ultID := bipsToUse.ultID;
                                             SELF.inquiredBusiness.orgID := bipsToUse.orgID;
                                             SELF.inquiredBusiness.seleID := bipsToUse.seleID;
                                             SELF.inquiredBusiness.proxID := bipsToUse.proxID;
                                             SELF.inquiredBusiness.powID := bipsToUse.powID;
                                             
                                             SELF.inquiredBusiness.companyName := mac_dataToUse(LEFT.inquiredBusiness.companyName, RIGHT.companyName, lexIDValid);
                                             SELF.inquiredBusiness.fein := mac_dataToUse(LEFT.inquiredBusiness.fein, RIGHT.fein, lexIDValid);
                                             SELF.inquiredBusiness.phone := mac_dataToUse(LEFT.inquiredBusiness.phone, RIGHT.phone, lexIDValid);
                                             
                                             
                                             
                                             //determine which address to use
                                             addressToUse := mac_addressToUse(LEFT, RIGHT, lexIDValid, FALSE);
                                             
                                             SELF.inquiredBusiness.streetAddress1 := addressToUse.streetAddress1;
                                             SELF.inquiredBusiness.streetAddress2 := addressToUse.streetAddress2;
                                             SELF.inquiredBusiness.prim_range := addressToUse.prim_range;
                                             SELF.inquiredBusiness.predir := addressToUse.predir;
                                             SELF.inquiredBusiness.prim_name := addressToUse.prim_name;
                                             SELF.inquiredBusiness.addr_suffix := addressToUse.addr_suffix;
                                             SELF.inquiredBusiness.postdir := addressToUse.postdir;
                                             SELF.inquiredBusiness.unit_desig := addressToUse.unit_desig;
                                             SELF.inquiredBusiness.sec_range := addressToUse.sec_range;
                                             
                                             SELF.inquiredBusiness.city := addressToUse.city;
                                             SELF.inquiredBusiness.state := addressToUse.state;
                                             SELF.inquiredBusiness.zip := addressToUse.zip;
                                             SELF.inquiredBusiness.zip4 := addressToUse.zip4;
                                             SELF.inquiredBusiness.geo_blk := addressToUse.geo_blk;
                                             SELF.inquiredBusiness.county := addressToUse.county;
                                             SELF.inquiredBusiness.countyName := addressToUse.countyName;
                                             
                                             SELF := LEFT;));
                                      
    
    //determine how we should use the input for searches going forward
    allResults := DEDUP(SORT(updateInquiredBest + updateInquiredBIIBest, seq, -validBusiness), seq);





    // OUTPUT(searchByLexID, NAMED('searchByLexID'));
    // OUTPUT(uniqueBusinesses, NAMED('uniqueBusinesses'));
    // OUTPUT(transUniqueBusinesses, NAMED('transUniqueBusinesses'));
    // OUTPUT(bestDataByLexID, NAMED('bestDataByLexID'));
    // OUTPUT(updateInquiredBest, NAMED('updateInquiredBest'));
    // OUTPUT(noLexIDInput, NAMED('noLexIDInput'));
    // OUTPUT(noValidLexIDInput, NAMED('noValidLexIDInput'));
    // OUTPUT(searchByBII, NAMED('searchByBII'));
    // OUTPUT(transBII, NAMED('transBII'));
    // OUTPUT(bestDataByBII, NAMED('bestDataByBII'));
    // OUTPUT(updateInquiredBIIBest, NAMED('updateInquiredBIIBest'));
    // OUTPUT(allResults, NAMED('allResults'));


    RETURN allResults;
END;