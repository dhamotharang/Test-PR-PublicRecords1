IMPORT DueDiligence;


EXPORT getInputBestData(DATASET(DueDiligence.v3Layouts.Internal.PersonTemp) inData,
                              DueDiligence.DDInterface.iDDRegulatoryCompliance regulatoryAccess,
                              DueDiligence.DDInterface.iDDPersonOptions ddOptions) := FUNCTION




    mac_dataToUse(inputField, bestField, validPerson) := FUNCTIONMACRO
        RETURN MAP(validPerson = FALSE => inputField,
                   ddOptions.inputUsage = DueDiligence.Constants.USE_INPUT_DATA_ENUM.DD_RULES => bestField,
                   ddOptions.inputUsage = DueDiligence.Constants.USE_INPUT_DATA_ENUM.AS_IS => inputField,
                   ddOptions.inputUsage = DueDiligence.Constants.USE_INPUT_DATA_ENUM.BEST_IF_INPUT_EMPTY AND inputField = DueDiligence.Constants.EMPTY => bestField,
                   ddOptions.inputUsage = DueDiligence.Constants.USE_INPUT_DATA_ENUM.BEST_IF_INPUT_EMPTY AND inputField <> DueDiligence.Constants.EMPTY => inputField,
                   bestField);
    ENDMACRO;
    
    mac_dataToUseUnsigned(inputField, bestField, validPerson) := FUNCTIONMACRO
        RETURN MAP(validPerson = FALSE => inputField,
                   ddOptions.inputUsage = DueDiligence.Constants.USE_INPUT_DATA_ENUM.DD_RULES => bestField,
                   ddOptions.inputUsage = DueDiligence.Constants.USE_INPUT_DATA_ENUM.AS_IS => inputField,
                   ddOptions.inputUsage = DueDiligence.Constants.USE_INPUT_DATA_ENUM.BEST_IF_INPUT_EMPTY AND inputField > DueDiligence.Constants.NUMERIC_ZERO => inputField,
                   ddOptions.inputUsage = DueDiligence.Constants.USE_INPUT_DATA_ENUM.BEST_IF_INPUT_EMPTY AND inputField = DueDiligence.Constants.NUMERIC_ZERO => bestField,
                   bestField);
    ENDMACRO;
    
    mac_addressToUse(inputData, bestData, validPerson, searchByLexID) := FUNCTIONMACRO
        
        inputFullAddress := (inputData.inquired.streetAddress1 <> DueDiligence.Constants.EMPTY OR inputData.inquired.prim_name <> DueDiligence.Constants.EMPTY) AND 
                             inputData.inquired.city <> DueDiligence.Constants.EMPTY AND 
                             inputData.inquired.state <> DueDiligence.Constants.EMPTY AND 
                             inputData.inquired.zip <> DueDiligence.Constants.EMPTY;
                             
        inputAddress := PROJECT(inputData, TRANSFORM(DueDiligence.v3Layouts.Internal.Address,
                                                      SELF.streetAddress1 := LEFT.inquired.streetAddress1;
                                                      SELF.streetAddress2 := LEFT.inquired.streetAddress2;
                                                      SELF.prim_range := LEFT.inquired.prim_range;
                                                      SELF.predir := LEFT.inquired.predir;
                                                      SELF.prim_name := LEFT.inquired.prim_name;
                                                      SELF.addr_suffix := LEFT.inquired.addr_suffix;
                                                      SELF.postdir := LEFT.inquired.postdir;
                                                      SELF.unit_desig := LEFT.inquired.unit_desig;
                                                      SELF.sec_range := LEFT.inquired.sec_range;
                                                      SELF.city := LEFT.inquired.city;
                                                      SELF.state := LEFT.inquired.state;
                                                      SELF.zip := LEFT.inquired.zip;
                                                      SELF.zip4 := LEFT.inquired.zip4;
                                                      SELF.geo_blk := LEFT.inquired.geo_blk;
                                                      SELF.county := LEFT.inquired.county;
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
                                                    SELF := [];));
        
        //if searching by lexID always use best
        //if searching by PII and have full input address, use input address
        //if searching by PII and do not have full input address, use best
        mapDDAddrRules := MAP(searchByLexID => bestAddress,
                              searchByLexID = FALSE AND inputFullAddress => inputAddress,
                              searchByLexID = FALSE AND inputFullAddress = FALSE => bestAddress,
                              bestAddress);
                              
                             
        RETURN MAP(validPerson = FALSE => inputAddress,
                   ddOptions.inputUsage = DueDiligence.Constants.USE_INPUT_DATA_ENUM.DD_RULES => mapDDAddrRules,
                   ddOptions.inputUsage = DueDiligence.Constants.USE_INPUT_DATA_ENUM.AS_IS => inputAddress,
                   ddOptions.inputUsage = DueDiligence.Constants.USE_INPUT_DATA_ENUM.BEST_IF_INPUT_EMPTY AND inputFullAddress => inputAddress,
                   ddOptions.inputUsage = DueDiligence.Constants.USE_INPUT_DATA_ENUM.BEST_IF_INPUT_EMPTY AND inputFullAddress = FALSE => bestAddress,
                   bestAddress);
    ENDMACRO;










    bestData := DueDiligence.v3PersonData.getBestData(regulatoryAccess);
    
    
    //get inquired individuals by lexID
    searchByLexID := inData(inquired.lexID > 0);
    
    //get unique iquireds - no need to get the same data twice
    uniqueInquireds := DEDUP(SORT(searchByLexID, inquired.lexID), inquired.lexID);
    
    transUniqueInquireds := PROJECT(uniqueInquireds, TRANSFORM(DueDiligence.v3Layouts.InternalPerson.SlimBestSearch,
                                                               SELF.lexID := LEFT.inquired.lexID;
                                                               SELF.historyDate := LEFT.historyDate;
                                                               SELF := [];));
    
    
    
    
    
    bestDataByLexID := bestData.GetIndividualBestDataWithLexID(transUniqueInquireds, TRUE);
    
    updateInquiredBest := JOIN(inData, bestDataByLexID,
                               LEFT.inquired.lexID = RIGHT.lexID,
                               TRANSFORM(DueDiligence.v3Layouts.Internal.PersonTemp,
                                         lexIDValid := RIGHT.firstName <> DueDiligence.Constants.EMPTY OR
                                                       RIGHT.middleName <> DueDiligence.Constants.EMPTY OR
                                                       RIGHT.lastName <> DueDiligence.Constants.EMPTY OR
                                                       RIGHT.ssn <> DueDiligence.Constants.EMPTY OR
                                                       RIGHT.phone <> DueDiligence.Constants.EMPTY OR
                                                       RIGHT.dob > DueDiligence.Constants.NUMERIC_ZERO OR
                                                       RIGHT.streetAddress1 <> DueDiligence.Constants.EMPTY OR
                                                       RIGHT.city <> DueDiligence.Constants.EMPTY OR
                                                       RIGHT.state <> DueDiligence.Constants.EMPTY OR
                                                       RIGHT.zip <> DueDiligence.Constants.EMPTY;
                                             
                                         SELF.validPerson := lexIDValid; 
                                         SELF.inquiredDID := IF(lexIDValid, RIGHT.lexID, 0);
                                         SELF.lexIDScore := RIGHT.lexIDScore;
                                         SELF.bestData := IF(lexIDValid AND ddOptions.inputUsage <> DueDiligence.Constants.USE_INPUT_DATA_ENUM.AS_IS, RIGHT);
                                         
                                     
                                         //use best data
                                         SELF.inquired.lexID := mac_dataToUseUnsigned(LEFT.inquired.lexID, RIGHT.lexID, lexIDValid);
                                         SELF.inquired.firstName := mac_dataToUse(LEFT.inquired.firstName, RIGHT.firstName, lexIDValid);
                                         SELF.inquired.middleName := mac_dataToUse(LEFT.inquired.middleName, RIGHT.middleName, lexIDValid);
                                         SELF.inquired.lastName := mac_dataToUse(LEFT.inquired.lastName, RIGHT.lastName, lexIDValid);
                                         SELF.inquired.suffix := mac_dataToUse(LEFT.inquired.suffix, RIGHT.suffix, lexIDValid);
                                         SELF.inquired.fullName := mac_dataToUse(LEFT.inquired.fullName, RIGHT.fullName, lexIDValid);
                                         
                                         SELF.inquired.dob := mac_dataToUseUnsigned(LEFT.inquired.dob, RIGHT.dob, lexIDValid);
                                         SELF.inquired.ssn := mac_dataToUse(LEFT.inquired.ssn, RIGHT.ssn, lexIDValid);
                                         SELF.inquired.phone := mac_dataToUse(LEFT.inquired.phone, RIGHT.phone, lexIDValid);
                                         
                                         //determine which address to use
                                         addressToUse := mac_addressToUse(LEFT, RIGHT, lexIDValid, TRUE);
                                         
                                         SELF.inquired.streetAddress1 := addressToUse.streetAddress1;
                                         SELF.inquired.streetAddress2 := addressToUse.streetAddress2;
                                         SELF.inquired.prim_range := addressToUse.prim_range;
                                         SELF.inquired.predir := addressToUse.predir;
                                         SELF.inquired.prim_name := addressToUse.prim_name;
                                         SELF.inquired.addr_suffix := addressToUse.addr_suffix;
                                         SELF.inquired.postdir := addressToUse.postdir;
                                         SELF.inquired.unit_desig := addressToUse.unit_desig;
                                         SELF.inquired.sec_range := addressToUse.sec_range;
                                         
                                         SELF.inquired.city := addressToUse.city;
                                         SELF.inquired.state := addressToUse.state;
                                         SELF.inquired.zip := addressToUse.zip;
                                         SELF.inquired.zip4 := addressToUse.zip4;
                                         SELF.inquired.geo_blk := addressToUse.geo_blk;
                                         SELF.inquired.county := addressToUse.county;
                                         SELF.inquired.countyName := addressToUse.countyName;
                                         
                                         SELF := LEFT;));
                               
                               

    //if we didn't get a best did/information, see if we can get it via the PII entered
    noLexIDInput := inData(inquired.lexID = 0);
    noValidLexIDInput := updateInquiredBest(validPerson = FALSE AND 
                                            (inquired.firstName <> DueDiligence.Constants.EMPTY OR
                                            inquired.middleName <> DueDiligence.Constants.EMPTY OR
                                            inquired.lastName <> DueDiligence.Constants.EMPTY OR
                                            inquired.ssn <> DueDiligence.Constants.EMPTY OR
                                            inquired.phone <> DueDiligence.Constants.EMPTY OR
                                            inquired.dob > DueDiligence.Constants.NUMERIC_ZERO OR
                                            inquired.streetAddress1 <> DueDiligence.Constants.EMPTY OR
                                            inquired.city <> DueDiligence.Constants.EMPTY OR
                                            inquired.state <> DueDiligence.Constants.EMPTY OR
                                            inquired.zip <> DueDiligence.Constants.EMPTY));
    
    searchByPII := noLexIDInput + noValidLexIDInput;
                                      
                                      
    transPII := PROJECT(searchByPII, TRANSFORM(DueDiligence.v3Layouts.InternalPerson.SlimBestSearch,
                                               SELF.seq := LEFT.seq;
                                               SELF.historyDate := LEFT.historyDate;
                                               
                                               SELF.firstName := LEFT.inquired.firstName;
                                               SELF.middleName := LEFT.inquired.middleName;
                                               SELF.lastName := LEFT.inquired.lastName;
                                               SELF.suffix := LEFT.inquired.suffix;
                                               
                                               SELF.phone := LEFT.inquired.phone;                                               
                                               SELF.ssn := LEFT.inquired.ssn;
                                               SELF.dob := LEFT.inquired.dob;
                                               
                                               SELF.streetAddress1 := LEFT.inquired.streetAddress1;
                                               SELF.streetAddress2 := LEFT.inquired.streetAddress2;
                                               SELF.prim_range := LEFT.inquired.prim_range;
                                               SELF.predir := LEFT.inquired.predir;
                                               SELF.prim_name := LEFT.inquired.prim_name;
                                               SELF.addr_suffix := LEFT.inquired.addr_suffix;
                                               SELF.postdir := LEFT.inquired.postdir;
                                               SELF.unit_desig := LEFT.inquired.unit_desig;
                                               SELF.sec_range := LEFT.inquired.sec_range;
                                               
                                               SELF.city := LEFT.inquired.city;
                                               SELF.state := LEFT.inquired.state;
                                               SELF.zip := LEFT.inquired.zip;
                                                                                               
                                               
                                               SELF := [];));
                                      
                                      
    bestDataByPII := bestData.GetIndividualBestDataWithPII(transPII);
    
    updateInquiredPIIBest := JOIN(inData, bestDataByPII,
                                   LEFT.seq = RIGHT.seq,
                                   TRANSFORM(DueDiligence.v3Layouts.Internal.PersonTemp,
                                             lexIDValid := RIGHT.lexID > 0;
                                             
                                             bestPII := PROJECT(RIGHT, TRANSFORM(DueDiligence.v3Layouts.Internal.SlimPerson, SELF := RIGHT;));
                                             noBest := DATASET([], DueDiligence.v3Layouts.Internal.SlimPerson)[1];
                                             
                                             fullAddrProvided := (LEFT.inquired.streetAddress1 <> DueDiligence.Constants.EMPTY OR LEFT.inquired.prim_name <> DueDiligence.Constants.EMPTY) AND 
                                                                  LEFT.inquired.city <> DueDiligence.Constants.EMPTY AND 
                                                                  LEFT.inquired.state <> DueDiligence.Constants.EMPTY AND 
                                                                  LEFT.inquired.zip <> DueDiligence.Constants.EMPTY;
                                              
                                             SELF.validPerson := lexIDValid;
                                             SELF.inquiredDID := IF(lexIDValid, RIGHT.lexID, 0);
                                             SELF.lexIDScore := RIGHT.lexIDScore;
                                             SELF.bestData := IF(lexIDValid AND ddOptions.inputUsage <> DueDiligence.Constants.USE_INPUT_DATA_ENUM.AS_IS, bestPII, noBest);
                                             
                                             
                                             //use best data
                                             SELF.inquired.lexID := mac_dataToUseUnsigned(LEFT.inquired.lexID, RIGHT.lexID, lexIDValid);
                                             SELF.inquired.firstName := mac_dataToUse(LEFT.inquired.firstName, RIGHT.firstName, lexIDValid);
                                             SELF.inquired.middleName := mac_dataToUse(LEFT.inquired.middleName, RIGHT.middleName, lexIDValid);
                                             SELF.inquired.lastName := mac_dataToUse(LEFT.inquired.lastName, RIGHT.lastName, lexIDValid);
                                             SELF.inquired.suffix := mac_dataToUse(LEFT.inquired.suffix, RIGHT.suffix, lexIDValid);
                                             SELF.inquired.fullName := mac_dataToUse(LEFT.inquired.fullName, RIGHT.fullName, lexIDValid);
                                             
                                             SELF.inquired.dob := mac_dataToUseUnsigned(LEFT.inquired.dob, RIGHT.dob, lexIDValid);
                                             SELF.inquired.ssn := mac_dataToUse(LEFT.inquired.ssn, RIGHT.ssn, lexIDValid);
                                             SELF.inquired.phone := mac_dataToUse(LEFT.inquired.phone, RIGHT.phone, lexIDValid);
                                             
                                             //determine which address to use
                                             addressToUse := mac_addressToUse(LEFT, RIGHT, lexIDValid, FALSE);
                                             
                                             SELF.inquired.streetAddress1 := addressToUse.streetAddress1;
                                             SELF.inquired.streetAddress2 := addressToUse.streetAddress2;
                                             SELF.inquired.prim_range := addressToUse.prim_range;
                                             SELF.inquired.predir := addressToUse.predir;
                                             SELF.inquired.prim_name := addressToUse.prim_name;
                                             SELF.inquired.addr_suffix := addressToUse.addr_suffix;
                                             SELF.inquired.postdir := addressToUse.postdir;
                                             SELF.inquired.unit_desig := addressToUse.unit_desig;
                                             SELF.inquired.sec_range := addressToUse.sec_range;
                                             
                                             SELF.inquired.city := addressToUse.city;
                                             SELF.inquired.state := addressToUse.state;
                                             SELF.inquired.zip := addressToUse.zip;
                                             SELF.inquired.zip4 := addressToUse.zip4;
                                             SELF.inquired.geo_blk := addressToUse.geo_blk;
                                             SELF.inquired.county := addressToUse.county;
                                             SELF.inquired.countyName := addressToUse.countyName;
                                             SELF := LEFT;));
              
              
    //determine how we should use the input for searches going forward   
    allResults := DEDUP(SORT(updateInquiredBest + updateInquiredPIIBest, seq, -validPerson), seq);
    






    // OUTPUT(inData, NAMED('prereq_bestdata_inData'));
    // OUTPUT(searchByLexID, NAMED('searchByLexID'));
    // OUTPUT(uniqueInquireds, NAMED('uniqueInquireds'));
    // OUTPUT(transUniqueInquireds, NAMED('transUniqueInquireds'));
    // OUTPUT(bestDataByLexID, NAMED('bestDataByLexID'));
    // OUTPUT(updateInquiredBest, NAMED('updateInquiredBest'));
    
    // OUTPUT(noLexIDInput, NAMED('noLexIDInput'));
    // OUTPUT(noValidLexIDInput, NAMED('noValidLexIDInput'));
    // OUTPUT(searchByPII, NAMED('searchByPII'));
    // OUTPUT(transPII, NAMED('transPII'));
    // OUTPUT(bestDataByPII, NAMED('bestDataByPII'));
    // OUTPUT(updateInquiredPIIBest, NAMED('updateInquiredPIIBest'));
    // OUTPUT(allResults, NAMED('allResults'));
    
  

    RETURN allResults;
END;