IMPORT Business_Risk_BIP, DueDiligence, Gateway, Risk_Indicators;


EXPORT fn_getIndBSAndRI(DATASET(DueDiligence.Layouts.CleanedData) cleanData,
                        Business_Risk_BIP.LIB_Business_Shell_LIBIN options,
                        unsigned1 LexIdSourceOptout = 1,
                        string TransactionID = '',
                        string BatchUID = '',
                        unsigned6 GlobalCompanyId = 0) := FUNCTION
    
    //for only person requests of Due Diligence and Citizenship call the BS and Indicators - use cleaned input vs the new pii/lexID just calc'd
    //convert cleaned data into a usable layout for IID
    iid_ready := PROJECT(cleanData, TRANSFORM(Risk_Indicators.layout_input,
                                                SELF.seq := LEFT.cleanedInput.seq;
                                                SELF.historydate := (UNSIGNED3)((STRING)LEFT.cleanedInput.historyDateYYYYMMDD)[..6];
                                                SELF.DID := (UNSIGNED6)LEFT.cleanedInput.individual.lexID;
                                                
                                                SELF.fname := LEFT.cleanedInput.individual.name.firstName;
                                                SELF.mname := LEFT.cleanedInput.individual.name.middleName;
                                                SELF.lname := LEFT.cleanedInput.individual.name.lastName;
                                                SELF.suffix := LEFT.cleanedInput.individual.name.suffix;
                                                
                                                SELF.in_streetAddress := LEFT.cleanedInput.individual.address.streetAddress1;
                                                SELF.in_city := LEFT.cleanedInput.individual.address.city;
                                                SELF.in_state := LEFT.cleanedInput.individual.address.state;
                                                SELF.in_zipCode := LEFT.cleanedInput.individual.address.zip5;
                                                
                                                //add the cleaned address fields
                                                SELF.prim_range := LEFT.cleanedInput.individual.address.prim_range;
                                                SELF.predir := LEFT.cleanedInput.individual.address.predir;
                                                SELF.prim_name := LEFT.cleanedInput.individual.address.prim_name;
                                                SELF.addr_suffix := LEFT.cleanedInput.individual.address.addr_suffix;
                                                SELF.postdir := LEFT.cleanedInput.individual.address.postdir;
                                                SELF.unit_desig := LEFT.cleanedInput.individual.address.unit_desig;
                                                SELF.sec_range := LEFT.cleanedInput.individual.address.sec_range;
                                                SELF.p_city_name := LEFT.cleanedInput.individual.address.city;
                                                SELF.st := LEFT.cleanedInput.individual.address.state;
                                                SELF.z5 := LEFT.cleanedInput.individual.address.zip5;
                                                SELF.zip4 := LEFT.cleanedInput.individual.address.zip4;
                                                SELF.lat := LEFT.cleanedInput.individual.address.geo_lat;
                                                SELF.long := LEFT.cleanedInput.individual.address.geo_long;
                                                SELF.county := LEFT.cleanedInput.individual.address.county;
                                                SELF.geo_blk := LEFT.cleanedInput.individual.address.geo_blk;
                                                
                                                SELF.ssn := LEFT.cleanedInput.individual.ssn;
                                                SELF.dob := LEFT.cleanedInput.individual.dob;
                                                
                                                SELF.phone10 := LEFT.cleanedInput.individual.phone;
                                                SELF.wphone10 := LEFT.cleanedInput.phone2;
                                                
                                                SELF.dl_number := LEFT.cleanedInput.dlNumber;
                                                SELF.dl_state := LEFT.cleanedInput.dlState;
                                                
                                                SELF := [];));
 


    //defaults for citizenship and due diligence
    defaultGateway := DATASET([], Gateway.Layouts.Config);
    defaultBSVersion := DueDiligence.CitDDShared.DEFAULT_BS_VERSION;
    defaultBSOptions := DueDiligence.CitDDShared.DEFAULT_BS_OPTIONS;
    defaultLNBranded := FALSE;
    
    //call instantID
    iid := Risk_Indicators.InstantID_Function(iid_ready, defaultGateway, options.DPPA_Purpose, options.GLBA_Purpose, in_ln_branded := defaultLNBranded, in_BSversion := defaultBSVersion, 
                                              in_BSOptions := defaultBSOptions, in_DataRestriction := options.DataRestrictionMask, in_DataPermission := options.DataPermissionMask,
                                              LexIdSourceOptout := LexIdSourceOptout, 
                                              TransactionID := TransactionID, 
                                              BatchUID := BatchUID, 
                                              GlobalCompanyID := GlobalCompanyID);
                    
    //call Boca Shell
    bocaShell := Risk_Indicators.Boca_Shell_Function(iid, defaultGateway, options.DPPA_Purpose, options.GLBA_Purpose, BSversion := defaultBSVersion, BSOptions := defaultBSOptions,
                                                      DataRestriction := options.DataRestrictionMask, DataPermission := options.DataPermissionMask,
																											includeVehInfo := false,
                                                      LexIdSourceOptout := LexIdSourceOptout, 
                                                      TransactionID := TransactionID, 
                                                      BatchUID := BatchUID, 
                                                      GlobalCompanyID := GlobalCompanyID);
                                                      
    ungroupBS := UNGROUP(bocaShell);


    addBS := JOIN(cleanData, ungroupBS,
                  LEFT.cleanedInput.seq = RIGHT.seq,
                  TRANSFORM(DueDiligence.LayoutsInternal.SharedInput,
                            SELF.bs := RIGHT;
                            SELF := LEFT;
                            SELF := [];),
                  LEFT OUTER,
                  ATMOST(DueDiligence.Constants.MAX_ATMOST_1));
                                          
                                          
    
    //get the risk indicators used by citizenship and the due diligence identity attribute
    riskIndicators := DueDiligence.Citizenship.getRiskIndicators(cleanData, ungroupBS);
    
    addRI := JOIN(addBS, riskIndicators,
                  LEFT.bs.seq = RIGHT.seq,
                  TRANSFORM(DueDiligence.LayoutsInternal.SharedInput,
                            SELF.riskIndicators := RIGHT;
                            SELF := LEFT;),
                  LEFT OUTER,
                  ATMOST(DueDiligence.Constants.MAX_ATMOST_1));



    // OUTPUT(iid_ready, NAMED('iid_ready'));
    // OUTPUT(iid, NAMED('iid'));
    // OUTPUT(bocaShell, NAMED('bocaShell'));
    // OUTPUT(addBS, NAMED('addBS'));
    // OUTPUT(riskIndicators, NAMED('riskIndicators'));
    // OUTPUT(addRI, NAMED('addRI'));

    RETURN addRI;
END;