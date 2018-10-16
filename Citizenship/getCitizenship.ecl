IMPORT Citizenship, DueDiligence, Gateway, Models, Risk_Indicators;

EXPORT getCitizenship(DATASET(DueDiligence.Layouts.Input) validInput,
                      UNSIGNED6 inGLBA, 
                      UNSIGNED6 inDPPA, 
                      STRING50 inDataRestriction,
                      STRING50 inDataPermission,
                      STRING15 in_modelName,
                      BOOLEAN modelValidation,
                      BOOLEAN debug) := FUNCTION
                      
                      

    //defaults for citizenship
    defaultGateway := DATASET([], Gateway.Layouts.Config);
    defaultBSVersion := DueDiligence.CitDDShared.DEFAULT_BS_VERSION;
    defaultBSOptions := DueDiligence.CitDDShared.DEFAULT_BS_OPTIONS;
    defaultLNBranded := FALSE;

    //clean the data
    cleanedCitizenshipData := Citizenship.Common.CleanData(validInput);
    
    //convert cleaned data into a usable layout for IID
    iid_ready := PROJECT(cleanedCitizenshipData, TRANSFORM(Risk_Indicators.layout_input,
                                                SELF.seq := LEFT.cleanedInput.seq;
                                                SELF.historydate := (UNSIGNED3)((STRING)LEFT.cleanedInput.historyDateYYYYMMDD)[..6];
                                                SELF.DID := (UNSIGNED6)LEFT.cleanedInput.individual.lexID;
                                                
                                                SELF.fname := LEFT.cleanedInput.individual.name.firstName;
                                                SELF.mname := LEFT.cleanedInput.individual.name.middleName;
                                                SELF.lname := LEFT.cleanedInput.individual.name.lastName;
                                                SELF.suffix := LEFT.cleanedInput.individual.name.suffix;
                                                
                                                SELF.in_streetAddress := LEFT.inputEcho.individual.address.streetAddress1;
                                                SELF.in_city := LEFT.inputEcho.individual.address.city;
                                                SELF.in_state := LEFT.inputEcho.individual.address.state;
                                                SELF.in_zipCode := LEFT.inputEcho.individual.address.zip5;
                                                
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
    
    //call instantID
    iid := risk_indicators.InstantID_Function(iid_ready, defaultGateway, inDPPA, inGLBA, in_ln_branded := defaultLNBranded, in_BSversion := defaultBSVersion, 
                                              in_BSOptions := defaultBSOptions, in_DataRestriction := inDataRestriction, in_DataPermission := inDataPermission);
                    
    //call Boca Shell
    bocaShell := risk_indicators.Boca_Shell_Function(iid, defaultGateway, inDPPA, inGLBA, BSversion := defaultBSVersion, BSOptions := defaultBSOptions,
                                                      DataRestriction := inDataRestriction, DataPermission := inDataPermission);
                                                      
    ungroupBS := UNGROUP(bocaShell);
                                                      
                                                      
    //retrieve the indicators
    indicators := Citizenship.fn_indicators(cleanedCitizenshipData, ungroupBS);


    //call model
    modelResults := Models.cit1808_0_0(ungroupBS);    //expecting to return everything (basically running as debug TRUE, only care about seq and score
    
    
    citizenshipResults := JOIN(indicators, modelResults, 
                                LEFT.seq = RIGHT.seq, 
                                TRANSFORM({UNSIGNED4 seq, Citizenship.Layouts.LayoutScoreAndIndicators},  
                                          SELF.seq := LEFT.inputSeq;
                                          SELF.citizenshipScore := RIGHT.citizenshipScore;
                                          SELF := LEFT;
                                          SELF := [];));
            
            
            
            
    // IF(debug, output(iid, NAMED('iid')));
    // IF(debug, output(bocaShell, NAMED('bocaShell')));
    IF(modelValidation, output(Citizenship.fn_modelValidation(indicators, modelResults), NAMED('modelValidationResults')));
    
    
            
    // OUTPUT(cleanedCitizenshipData, NAMED('cit_cleanedData'));
    // OUTPUT(iid_ready, NAMED('iid_ready'));
    // OUTPUT(iid, NAMED('iid'));
    // OUTPUT(bocaShell, NAMED('bocaShell'));
    // OUTPUT(indicators, NAMED('indicators'));
    // OUTPUT(modelResults, NAMED('modelResults'));        
                                          
    RETURN citizenshipResults;
END;