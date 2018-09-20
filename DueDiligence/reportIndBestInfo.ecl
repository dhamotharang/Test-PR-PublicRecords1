IMPORT advo, DueDiligence, iesp, STD, Suppress;

EXPORT reportIndBestInfo(DATASET(DueDiligence.layouts.Indv_Internal) inData, 
                         STRING6 ssnMask) := FUNCTION
                         
                         
    //mask best ssn for the report    
    Suppress.MAC_Mask(inData, maskedBestData, bestSSN, '', TRUE, FALSE,,,, ssnMask);
                                                                                        
    formatInquiredInfo := PROJECT(maskedBestData, TRANSFORM({DueDiligence.LayoutsInternal.InternalSeqAndIdentifiersLayout, iesp.duediligencepersonreport.t_DDRPersonInformation personalInfo},
                                                    SELF.seq := LEFT.seq;
                                                    SELF.did := LEFT.inquiredDID;
                                                    SELF.personalInfo.LexID := (STRING)LEFT.inquiredDID;
                                                    
                                                    inputName := LEFT.indvRawInput.name;
                                                    bestName := LEFT.bestName;
                                                    
                                                    SELF.personalInfo.InputName := iesp.ECL2ESP.SetName(inputName.firstName, inputName.middleName, inputName.lastName, inputName.suffix, DueDiligence.Constants.EMPTY);
                                                    SELF.personalInfo.BestName := iesp.ECL2ESP.SetName(bestName.firstName, bestName.middleName, bestName.lastName, bestName.suffix, DueDiligence.Constants.EMPTY);
                                                    
                                                    inputAddr := LEFT.indvRawInput.address;
                                                    bestAddr := LEFT.bestAddress;
                                                    
                                                    SELF.personalInfo.InputAddress := iesp.ECL2ESP.SetAddress(inputAddr.prim_name, inputAddr.prim_range, inputAddr.predir,
                                                                                                              inputAddr.postdir, inputAddr.addr_suffix, inputAddr.unit_desig,
                                                                                                              inputAddr.sec_range, inputAddr.city, inputAddr.state, inputAddr.zip5,
                                                                                                              inputAddr.zip4, inputAddr.county, DueDiligence.Constants.EMPTY,
                                                                                                              inputAddr.streetAddress1, inputAddr.streetAddress2);
                                                    SELF.personalInfo.BestAddress := iesp.ECL2ESP.SetAddress(bestAddr.prim_name, bestAddr.prim_range, bestAddr.predir,
                                                                                                              bestAddr.postdir, bestAddr.addr_suffix, bestAddr.unit_desig,
                                                                                                              bestAddr.sec_range, bestAddr.city, bestAddr.state, bestAddr.zip5,
                                                                                                              bestAddr.zip4, bestAddr.county, DueDiligence.Constants.EMPTY,
                                                                                                              bestAddr.streetAddress1, bestAddr.streetAddress2,
                                                                                                              TRIM(bestAddr.state) + TRIM(bestAddr.city) + TRIM(bestAddr.zip5));
                                                    
                                                    SELF.personalInfo.inputAddressType := advo.Lookup_Descriptions.Record_Type_Description_lookup(LEFT.indvCleanInput.address.rec_type);
                                                    
                                                    //get the address type from best
                                                    cleanAddr := DueDiligence.CitDDShared.cleanAddress(bestAddr);
                                                    SELF.personalInfo.bestAddressType := advo.Lookup_Descriptions.Record_Type_Description_lookup(cleanAddr.rec_type);
                                                    
                                                    SELF.personalInfo.InputSSN := LEFT.inputSSN;
                                                    SELF.personalInfo.BestSSN := LEFT.bestSSN;
                                                    SELF.personalInfo.InputDOB := iesp.ECL2ESP.toDatestring8(LEFT.indvRawInput.dob);
                                                    SELF.personalInfo.BestDOB := iesp.ECL2ESP.toDate(LEFT.bestDOB);;
                                                    SELF.personalInfo.InputPhone := LEFT.indvRawInput.phone;
                                                    SELF.personalInfo.BestPhone := LEFT.bestPhone;
                                                    
                                                    inputDOB := (UNSIGNED4)LEFT.indvRawInput.dob;
                                                    
                                                    validInputDOB := STD.Date.IsValidDate(inputDOB);
                                                    validHistDate := STD.Date.IsValidDate(LEFT.historyDate);
                                                    
                                                    SELF.personalInfo.InputAge := IF(validInputDOB AND validHistDate, STD.Date.YearsBetween(inputDOB, LEFT.historyDate), 0);
                                                    SELF.personalInfo.BestAge := LEFT.estimatedAge;
                                                    SELF := [];));



    addInquiredInfo := JOIN(inData, formatInquiredInfo,
                            LEFT.seq = RIGHT.seq AND
                            LEFT.inquiredDID = RIGHT.did,
                            TRANSFORM(RECORDOF(LEFT),
                                      SELF.personReport.PersonInformation := RIGHT.personalInfo;
                                      SELF := LEFT;),
                            LEFT OUTER,
                            ATMOST(1));    
        
    
    
    
    
    // OUTPUT(maskedBestData, NAMED('maskedBestData'));
    // OUTPUT(formatInquiredInfo, NAMED('formatInquiredInfo'));
    // OUTPUT(addInquiredInfo, NAMED('addInquiredInfo'));
    
    
    RETURN addInquiredInfo;
                         
END;                         