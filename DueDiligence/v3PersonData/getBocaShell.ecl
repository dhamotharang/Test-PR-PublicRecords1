IMPORT DueDiligence, Gateway, Risk_Indicators, STD;


EXPORT getBocaShell(DATASET(DueDiligence.v3Layouts.DDInput.PersonSearch) inData,
                    DueDiligence.DDInterface.iDDRegulatoryCompliance regulatoryAccess) := FUNCTION



    iid_ready := PROJECT(inData, TRANSFORM(Risk_Indicators.layout_input,
                                            
                                            histDate := IF(LEFT.historyDateRaw = 0 OR LEFT.historyDateRaw = STD.Date.Today(), DueDiligence.Constants.date8Nines, LEFT.historyDateRaw);
    
                                            SELF.seq := LEFT.seq;
                                            SELF.historydate := (UNSIGNED3)((STRING)histDate)[..6];
                                            SELF.DID := (UNSIGNED6)LEFT.searchBy.lexID;
                                            
                                            SELF.fname := LEFT.searchBy.firstName;
                                            SELF.mname := LEFT.searchBy.middleName;
                                            SELF.lname := LEFT.searchBy.lastName;
                                            SELF.suffix := LEFT.searchBy.suffix;
                                            
                                            SELF.in_streetAddress := LEFT.searchBy.streetAddress1;
                                            SELF.in_city := LEFT.searchBy.city;
                                            SELF.in_state := LEFT.searchBy.state;
                                            SELF.in_zipCode := LEFT.searchBy.zip;
                                            
                                            //add the cleaned address fields
                                            SELF.prim_range := LEFT.searchBy.prim_range;
                                            SELF.predir := LEFT.searchBy.predir;
                                            SELF.prim_name := LEFT.searchBy.prim_name;
                                            SELF.addr_suffix := LEFT.searchBy.addr_suffix;
                                            SELF.postdir := LEFT.searchBy.postdir;
                                            SELF.unit_desig := LEFT.searchBy.unit_desig;
                                            SELF.sec_range := LEFT.searchBy.sec_range;
                                            SELF.p_city_name := LEFT.searchBy.city;
                                            SELF.st := LEFT.searchBy.state;
                                            SELF.z5 := LEFT.searchBy.zip;
                                            SELF.zip4 := LEFT.searchBy.zip4;
                                            SELF.county := LEFT.searchBy.county;
                                            SELF.geo_blk := LEFT.searchBy.geo_blk;
                                            
                                            SELF.ssn := LEFT.searchBy.ssn;
                                            SELF.dob := (STRING8)LEFT.searchBy.dob;
                                            
                                            SELF.phone10 := LEFT.searchBy.phone;
                                            SELF.wphone10 := LEFT.searchBy.phone2;
                                            
                                            SELF.dl_number := LEFT.searchBy.dlNumber;
                                            SELF.dl_state := LEFT.searchBy.dlState;
                                            
                                            SELF := [];));

                                                 

    //defaults for citizenship and due diligence
    defaultGateway := DATASET([], Gateway.Layouts.Config);
    defaultBSVersion := DueDiligence.ConstantsQuery.DEFAULT_BS_VERSION;
    defaultBSOptions := DueDiligence.ConstantsQuery.DEFAULT_BS_OPTIONS;
    defaultLNBranded := FALSE;
    
    //call instantID
    iid := Risk_Indicators.InstantID_Function(iid_ready, defaultGateway, 
                                              regulatoryAccess.dppa, regulatoryAccess.glba, 
                                              in_ln_branded := defaultLNBranded, in_BSversion := defaultBSVersion, 
                                              in_BSOptions := defaultBSOptions, in_DataRestriction := regulatoryAccess.drm, 
                                              in_DataPermission := regulatoryAccess.dpm, LexIdSourceOptout := regulatoryAccess.lexIDSourceOptOut, 
                                              TransactionID := regulatoryAccess.transactionID, BatchUID := regulatoryAccess.batchUID, 
                                              GlobalCompanyID := regulatoryAccess.globalCompanyID);
                    
    //call Boca Shell
    bocaShell := Risk_Indicators.Boca_Shell_Function(iid, defaultGateway, 
                                                      regulatoryAccess.dppa, regulatoryAccess.glba, 
                                                      BSversion := defaultBSVersion, BSOptions := defaultBSOptions,
                                                      DataRestriction := regulatoryAccess.drm, DataPermission := regulatoryAccess.dpm,
																											includeVehInfo := FALSE, LexIdSourceOptout := regulatoryAccess.lexIDSourceOptOut, 
                                                      TransactionID := regulatoryAccess.transactionID, BatchUID := regulatoryAccess.batchUID, 
                                                      GlobalCompanyID := regulatoryAccess.globalCompanyID);
                                                      

    
    // OUTPUT(iid_ready, NAMED('iid_ready'));
    // OUTPUT(iid, NAMED('iid'));
    // OUTPUT(bocaShell, NAMED('bocaShell'));
    
    
    RETURN UNGROUP(bocaShell);
END;