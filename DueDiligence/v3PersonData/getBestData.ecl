IMPORT Doxie, DueDiligence, Gateway, Risk_Indicators;

EXPORT getBestData(DueDiligence.DDInterface.iDDRegulatoryCompliance regulatoryAccess) := MODULE

    SHARED inGateways := DATASET([], Gateway.Layouts.Config);
        
    SHARED INTEGER inBSVersion := DueDiligence.ConstantsQuery.DEFAULT_BS_VERSION;
    SHARED UNSIGNED8 inBSOptions := DueDiligence.ConstantsQuery.DEFAULT_BS_OPTIONS + Risk_Indicators.iid_constants.BSOptions.RetainInputDID;
        
    SHARED glbaOK := Risk_Indicators.iid_constants.glb_ok(regulatoryAccess.glba, FALSE );
    SHARED dppaOK := Risk_Indicators.iid_constants.dppa_ok(regulatoryAccess.dppa, FALSE);
        
    SHARED modAccess := DueDiligence.v3Common.General.GetModAccess(regulatoryAccess);
                        
                        
    SHARED fn_getBestData(DATASET(Risk_Indicators.Layout_Input) inData) := FUNCTION
    	
        withDID := risk_indicators.iid_getDID_prepOutput(inData, regulatoryAccess.dppa, regulatoryAccess.glba, 
                                                         BSversion := inBSVersion, DataRestriction := regulatoryAccess.drm, 
                                                         gateways := inGateways, BSOptions := inBSOptions,
                                                         mod_access := modAccess);
        
        //pick the DID with the highest score, 
        //in the event that multiple have the same score, choose the lowest value DID to make this deterministic
        sortDIDs := SORT(UNGROUP(withDID), seq, -score, did);
        highestDIDScore := DEDUP(sortDIDs, seq);
        
        //only populate to get the best data if we have a did
        projData := PROJECT(highestDIDScore(did > 0), TRANSFORM(Doxie.layout_references, SELF.did := LEFT.did;));

        //since bestData will not have seq just DID, lets make sure we have unique DIDs
        uniqueDIDs := DEDUP(SORT(projData, did), did);
        
        Doxie.mac_best_records(uniqueDIDs, did, bestData, dppaOK, glbaOK, , regulatoryAccess.drm);
        

        allBestData := JOIN(highestDIDScore, bestData,
                            LEFT.did = RIGHT.did,
                            TRANSFORM(DueDiligence.v3Layouts.InternalPerson.SlimBestSearch,
                                      //found some information on a person
                                      SELF.seq := LEFT.seq;
                                      SELF.lexID := LEFT.did;
                                      SELF.lexIDScore := LEFT.score;
                                      SELF.firstName := RIGHT.fname;
                                      SELF.middleName := RIGHT.mname;
                                      SELF.lastName := RIGHT.lname;
                                      SELF.suffix := RIGHT.name_suffix;
                                      SELF.fullName := DueDiligence.v3Common.General.CombineNamePartsForFullName(RIGHT.fname, RIGHT.mname, RIGHT.lname, RIGHT.name_suffix);
                                      
                                      SELF.ssn := RIGHT.ssn;
                                      SELF.dob := RIGHT.dob;
                                      SELF.phone := RIGHT.phone;
                                                                            
                                      tempAddress := PROJECT(RIGHT, TRANSFORM(DueDiligence.v3Layouts.Internal.Address,
                                                                              SELF.prim_range := LEFT.prim_range;
                                                                              SELF.predir := LEFT.predir;
                                                                              SELF.prim_name := LEFT.prim_name;
                                                                              SELF.addr_suffix := LEFT.suffix;
                                                                              SELF.postdir := LEFT.postdir;
                                                                              SELF.unit_desig := LEFT.unit_desig;
                                                                              SELF.sec_range := LEFT.sec_range;
                                                                              SELF.city := LEFT.city_name;
                                                                              SELF.state := LEFT.st;
                                                                              SELF.zip := LEFT.zip;
                                                                              SELF.zip4 := LEFT.zip4;
                                                                              SELF := [];));
                                                                                                          
                                      cleanedAddress := DueDiligence.v3Common.Address.GetCleanAddress(tempAddress);
                                                                            
                                      SELF := cleanedAddress;
                                      SELF := [];),
                            LEFT OUTER,
                            ATMOST(1)); 
                            
        getCounty := DueDiligence.v3Common.Address.GetAddressCounty(allBestData);
        
        addCounty := PROJECT(getCounty, TRANSFORM(DueDiligence.v3Layouts.InternalPerson.SlimBestSearch,
                                                  SELF.countyName := LEFT.countyNameText;
                                                  SELF := LEFT;));
                            
         
         
         
        // OUTPUT(withDID, NAMED('withDID'+ outName));
        // OUTPUT(highestDIDScore, NAMED('highestDIDScore'+ outName));
        // OUTPUT(bestData, NAMED('bestData'+ outName));
        // OUTPUT(allBestData, NAMED('allBestData'+ outName));
        
        RETURN addCounty;    
    END;
    
    
    
    EXPORT GetIndividualBestDataWithLexID(DATASET(DueDiligence.v3Layouts.InternalPerson.SlimBestSearch) inData, BOOLEAN useAdditionalData = FALSE) := FUNCTION
        
        uniqueDIDs := DEDUP(SORT(PROJECT(inData, TRANSFORM(doxie.layout_references, SELF.did := (UNSIGNED)LEFT.lexID )), did), did);
        
        //get best info for those that pass in a DID
        didData := Risk_Indicators.collection_shell_mod.getBestCleaned(uniqueDIDs, 
                                                                        regulatoryAccess.drm, 
                                                                        regulatoryAccess.glba, 
                                                                        clean_address := TRUE);  

    
        projData := JOIN(inData, didData,
                          LEFT.lexID = RIGHT.did,
                          TRANSFORM(Risk_Indicators.Layout_Input,
                                    SELF.did := (UNSIGNED)LEFT.lexID;
                                    SELF.historydate := (UNSIGNED)((STRING)LEFT.historyDate)[1..6];
                                    
                                    SELF.fname := IF(useAdditionalData, RIGHT.fname, '');
                                    SELF.mname := IF(useAdditionalData, RIGHT.mname, '');
                                    SELF.lname := IF(useAdditionalData, RIGHT.lname, '');
                                    SELF.suffix := IF(useAdditionalData, RIGHT.name_suffix, '');

                                    SELF.in_streetAddress := IF(useAdditionalData, RIGHT.street_addr, '');
                                    SELF.in_city := IF(useAdditionalData, RIGHT.city_name, '');
                                    SELF.in_state := IF(useAdditionalData, RIGHT.st, '');
                                    SELF.in_zipCode := IF(useAdditionalData, RIGHT.zip, '');

                                    SELF.prim_range := IF(useAdditionalData, RIGHT.prim_range, '');
                                    SELF.predir := IF(useAdditionalData, RIGHT.predir, '');
                                    SELF.prim_name := IF(useAdditionalData, RIGHT.prim_name, '');
                                    SELF.addr_suffix := IF(useAdditionalData, RIGHT.suffix, '');
                                    SELF.postdir := IF(useAdditionalData, RIGHT.postdir, '');
                                    SELF.unit_desig := IF(useAdditionalData, RIGHT.unit_desig, '');
                                    SELF.sec_range := IF(useAdditionalData, RIGHT.sec_range, '');
                                    SELF.p_city_name := IF(useAdditionalData, RIGHT.city_name, '');
                                    SELF.st := IF(useAdditionalData, RIGHT.st, '');
                                    SELF.z5 := IF(useAdditionalData, RIGHT.zip, '');
                                    SELF.zip4 := IF(useAdditionalData, RIGHT.zip4, '');
                                    SELF.county := IF(useAdditionalData, RIGHT.county, '');
                                    SELF.geo_blk := IF(useAdditionalData, RIGHT.geo_blk, '');

                                    SELF.addr_type := IF(useAdditionalData, RIGHT.addr_type, '');
                                    SELF.addr_status := IF(useAdditionalData, RIGHT.addr_status, '');

                                    SELF.ssn := IF(useAdditionalData, RIGHT.ssn, '');
                                    SELF.dob := IF(useAdditionalData, (STRING)RIGHT.dob, '');
                                    SELF.phone10 := IF(useAdditionalData, RIGHT.phone, '');
                                    SELF := [];));
                                    
        //give each lexID a unique identifier
        uniqueID := PROJECT(projData, TRANSFORM(Risk_Indicators.Layout_Input, SELF.seq := COUNTER, SELF := LEFT;));
                
        bestData := fn_getBestData(uniqueID);
        
        populateBest := JOIN(inData, bestData,
                              LEFT.lexID = RIGHT.lexID,
                              TRANSFORM(DueDiligence.v3Layouts.InternalPerson.SlimBestSearch,
                                        SELF := RIGHT;
                                        SELF := LEFT;),
                              LEFT OUTER,
                              ATMOST(1));
        
        
        
        // OUTPUT(didData, NAMED('didData'));
        // OUTPUT(projData, NAMED('projData_lexID'));
        // OUTPUT(uniqueID, NAMED('uniqueID_lexID'));
        // OUTPUT(bestData, NAMED('bestData_lexid'));
        // OUTPUT(populateBest, NAMED('populateBest_lexid'));
        
        RETURN populateBest;
    END;
    
    
    EXPORT GetIndividualBestDataWithPII(DATASET(DueDiligence.v3Layouts.InternalPerson.SlimBestSearch) inData) := FUNCTION
    
        searchForDIDs := PROJECT(inData, TRANSFORM(Risk_Indicators.Layout_Input,
                                                    SELF.seq := LEFT.seq;
                                                    SELF.historydate := (UNSIGNED)((STRING)LEFT.historyDate)[1..6];

                                                    SELF.fname := LEFT.firstName;
                                                    SELF.mname := LEFT.middleName;
                                                    SELF.lname := LEFT.lastName;
                                                    SELF.suffix := LEFT.suffix;

                                                    SELF.in_streetAddress := TRIM(LEFT.streetAddress1 + ' ' + LEFT.streetAddress2, LEFT, RIGHT);
                                                    SELF.in_city := LEFT.city;
                                                    SELF.in_state := LEFT.state;
                                                    SELF.in_zipCode := LEFT.zip;

                                                    SELF.prim_range := LEFT.prim_range;
                                                    SELF.predir := LEFT.predir;
                                                    SELF.prim_name := LEFT.prim_name;
                                                    SELF.addr_suffix := LEFT.addr_suffix;
                                                    SELF.postdir := LEFT.postdir;
                                                    SELF.unit_desig := LEFT.unit_desig;
                                                    SELF.sec_range := LEFT.sec_range;
                                                    SELF.p_city_name := LEFT.city;
                                                    SELF.st := LEFT.state;
                                                    SELF.z5 := LEFT.zip;
                                                    SELF.zip4 := LEFT.zip4;

                                                    SELF.ssn := LEFT.ssn;
                                                    SELF.dob := (STRING)LEFT.dob;
                                                    SELF.phone10 := LEFT.phone;
                                                    
                                                    SELF := [];));


       
        //get the best data from the lexID passed in
        bestData := fn_getBestData(searchForDIDs);
        
        //add best to existing data if best was found
        populateBest := JOIN(inData, bestData,
                            LEFT.seq = RIGHT.seq,
                            TRANSFORM(DueDiligence.v3Layouts.InternalPerson.SlimBestSearch,
                                      SELF := RIGHT;
                                      SELF := LEFT;),
                              LEFT OUTER,
                              ATMOST(1));
                              
        // OUTPUT(searchForDIDs, NAMED('searchForDIDs_pii'));
        // OUTPUT(bestData, NAMED('bestData_pii'));
        // OUTPUT(populateBest, NAMED('populateBest_pii'));
        
        RETURN populateBest;
    END;




END;