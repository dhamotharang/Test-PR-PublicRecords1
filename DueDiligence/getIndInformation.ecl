IMPORT Business_Risk_BIP, doxie, DueDiligence, Gateway, risk_indicators;


EXPORT getIndInformation(Business_Risk_BIP.LIB_Business_Shell_LIBIN options) := MODULE

    SHARED GetBestData(DATASET(Risk_Indicators.Layout_Input) inData) := FUNCTION
        mod_access := PROJECT(options, doxie.IDataAccess);

        UNSIGNED1 appendBest := 0;
        gateways := DATASET([], Gateway.Layouts.Config);

        INTEGER bsVersion := DueDiligence.ConstantsQuery.DEFAULT_BS_VERSION;
        UNSIGNED8 bsOptions := DueDiligence.ConstantsQuery.DEFAULT_BS_OPTIONS;

        glbaOK := mod_access.isValidGlb();
        dppaOK := mod_access.isValidDppa();



        withDID := risk_indicators.iid_getDID_prepOutput(inData, mod_access.dppa, mod_access.glb, FALSE, bsVersion, mod_access.DataRestrictionMask, appendBest, gateways, bsOptions,
                                                                                              mod_access := mod_access);

        //pick the DID with the highest score,
        //in the event that multiple have the same score, choose the lowest value DID to make this deterministic
        sortDIDs := SORT(UNGROUP(withDID), seq, -score, did);
        highestDIDScore := DEDUP(sortDIDs, seq);

        //only populate to get the best data if we have a did
        projData := PROJECT(highestDIDScore(did > 0), TRANSFORM(doxie.layout_references, SELF.did := LEFT.did;));

        //since bestData will not have seq just DID, lets make sure we have unique DIDs
        uniqueDIDs := DEDUP(SORT(projData, did), did);

        doxie.mac_best_records(uniqueDIDs, did, bestData, dppaOK, glbaOK, , options.DataRestrictionMask);


        allBestData := JOIN(highestDIDScore, bestData,
                            LEFT.did = RIGHT.did,
                            TRANSFORM(DueDiligence.LayoutsInternal.BestData,
                                      //found some information on a person
                                      SELF.seq := LEFT.seq;
                                      SELF.did := LEFT.did;
                                      SELF.lexIDScore := LEFT.score;
                                      SELF.name := PROJECT(RIGHT, TRANSFORM(DueDiligence.Layouts.Name,
                                                                            SELF.firstName := LEFT.fname;
                                                                            SELF.middleName := LEFT.mname;
                                                                            SELF.lastName := LEFT.lname;
                                                                            SELF.suffix := LEFT.name_suffix;
                                                                            SELF.fullName := '';));

                                       tempAddress := PROJECT(RIGHT, TRANSFORM(DueDiligence.Layouts.Address,
                                                                                SELF.prim_range := RIGHT.prim_range;
                                                                                SELF.predir := RIGHT.predir;
                                                                                SELF.prim_name := RIGHT.prim_name;
                                                                                SELF.addr_suffix := RIGHT.suffix;
                                                                                SELF.postdir := RIGHT.postdir;
                                                                                SELF.unit_desig := RIGHT.unit_desig;
                                                                                SELF.sec_range := RIGHT.sec_range;
                                                                                SELF.city := RIGHT.city_name;
                                                                                SELF.state := RIGHT.st;
                                                                                SELF.zip5 := RIGHT.zip;
                                                                                SELF.zip4 := RIGHT.zip4;
                                                                                SELF := [];));

                                      cleanedAddress := DueDiligence.CommonAddress.GetCleanAddress(tempAddress);

                                      SELF.address := cleanedAddress;
                                      SELF.ssn := RIGHT.ssn;
                                      SELF.dob := (STRING8)RIGHT.dob;
                                      SELF.phone := RIGHT.phone;
                                      SELF := [];),
                            LEFT OUTER,
                            ATMOST(DueDiligence.Constants.MAX_ATMOST_1));

        RETURN allBestData;
    END;





    //This function is assuming that the cleanedData coming in is already filtered to have lexID populated
    EXPORT SearchByInputLexID(DATASET(DueDiligence.Layouts.CleanedData) cleanedData) := FUNCTION

        uniqueDIDs := DEDUP(SORT(PROJECT(cleanedData, TRANSFORM(doxie.layout_references, SELF.did := (UNSIGNED)LEFT.cleanedInput.individual.lexID )), did), did);

        //get best info for those that pass in a DID
        didData := risk_indicators.collection_shell_mod.getBestCleaned(uniqueDIDs,
                                                                        options.DataRestrictionMask,
                                                                        options.glb,
                                                                        clean_address:=true);


        searchForDIDs := JOIN(cleanedData, didData,
                              (UNSIGNED)LEFT.cleanedInput.individual.lexID = RIGHT.did,
                              TRANSFORM(Risk_Indicators.Layout_Input,
                                        SELF.seq := LEFT.cleanedInput.seq;
                                        SELF.did := (UNSIGNED)LEFT.cleanedInput.individual.lexID;
                                        SELF.historydate := (UNSIGNED)((STRING)LEFT.cleanedInput.historyDateYYYYMMDD)[1..6];

                                        SELF.fname := RIGHT.fname;
                                        SELF.mname := RIGHT.mname;
                                        SELF.lname := RIGHT.lname;
                                        SELF.suffix := RIGHT.name_suffix;

                                        SELF.in_streetAddress := RIGHT.street_addr;
                                        SELF.in_city := RIGHT.city_name;
                                        SELF.in_state := RIGHT.st;
                                        SELF.in_zipCode := RIGHT.zip;

                                        SELF.prim_range := RIGHT.prim_range;
                                        SELF.predir := RIGHT.predir;
                                        SELF.prim_name := RIGHT.prim_name;
                                        SELF.addr_suffix := RIGHT.suffix;
                                        SELF.postdir := RIGHT.postdir;
                                        SELF.unit_desig := RIGHT.unit_desig;
                                        SELF.sec_range := RIGHT.sec_range;
                                        SELF.p_city_name := RIGHT.city_name;
                                        SELF.st := RIGHT.st;
                                        SELF.z5 := RIGHT.zip;
                                        SELF.zip4 := RIGHT.zip4;
                                        SELF.county := RIGHT.county;
                                        SELF.geo_blk := RIGHT.geo_blk;

                                        SELF.addr_type := RIGHT.addr_type;
                                        SELF.addr_status := RIGHT.addr_status;

                                        SELF.ssn := RIGHT.ssn;
                                        SELF.dob := (STRING)RIGHT.dob;
                                        SELF.phone10 := RIGHT.phone;
                                        SELF := [];));

        //get the best data from the lexID passed in
        bestData := GetBestData(searchForDIDs);


        updateData := JOIN(cleanedData, bestData,
                            (UNSIGNED)LEFT.cleanedInput.individual.lexID = RIGHT.did,
                            TRANSFORM(DueDiligence.LayoutsInternal.BestData,
                                      SELF.seq := LEFT.cleanedInput.seq;
                                      SELF.lexIDValid := RIGHT.name.firstName <> DueDiligence.Constants.EMPTY OR
                                                         RIGHT.name.middleName <> DueDiligence.Constants.EMPTY OR
                                                         RIGHT.name.lastName <> DueDiligence.Constants.EMPTY OR
                                                         RIGHT.ssn <> DueDiligence.Constants.EMPTY OR
                                                         RIGHT.phone <> DueDiligence.Constants.EMPTY OR
                                                         (UNSIGNED)RIGHT.dob > DueDiligence.Constants.NUMERIC_ZERO OR
                                                         RIGHT.address.streetAddress1 <> DueDiligence.Constants.EMPTY OR
                                                         RIGHT.address.city <> DueDiligence.Constants.EMPTY OR
                                                         RIGHT.address.state <> DueDiligence.Constants.EMPTY OR
                                                         RIGHT.address.zip5 <> DueDiligence.Constants.EMPTY;
                                      SELF.bestAddressUsed := TRUE;
                                      SELF.bestAddress := RIGHT.address;
                                      SELF := RIGHT;),
                            LEFT OUTER,
                            ATMOST(DueDiligence.Constants.MAX_ATMOST_1));


        // OUTPUT(cleanedData, NAMED('cleanedData_lexID'));
        // OUTPUT(uniqueDIDs, NAMED('uniqueDIDs_lexID'));
        // OUTPUT(didData, NAMED('didData_lexID'));
        // OUTPUT(searchForDIDs, NAMED('searchForDIDs_lexID'));
        // OUTPUT(bestData, NAMED('bestData_lexID'));
        // OUTPUT(updateData, NAMED('updateData_lexID'));

        RETURN updateData;
    END;


    EXPORT SearchByInputPII(DATASET(DueDiligence.Layouts.CleanedData) cleanedData) := FUNCTION

        searchForDIDs := PROJECT(cleanedData, TRANSFORM(Risk_Indicators.Layout_Input,

                                                        cleaned := LEFT.cleanedInput;
                                                        indv := cleaned.individual;
                                                        name := indv.name;
                                                        addr := indv.address;

                                                        fullAddressProvided := cleaned.fullCleanAddressExists;

                                                        SELF.seq := cleaned.seq;
                                                        SELF.historydate := (UNSIGNED)((STRING)cleaned.historyDateYYYYMMDD)[1..6];

                                                        SELF.fname := name.firstName;
                                                        SELF.mname := name.middleName;
                                                        SELF.lname := name.lastName;
                                                        SELF.suffix := name.suffix;

                                                        SELF.in_streetAddress := TRIM(addr.streetAddress1 + ' ' + addr.streetAddress2, LEFT, RIGHT);
                                                        SELF.in_city := addr.city;
                                                        SELF.in_state := addr.state;
                                                        SELF.in_zipCode := addr.zip5;

                                                        SELF.prim_range := addr.prim_range;
                                                        SELF.predir := addr.predir;
                                                        SELF.prim_name := addr.prim_name;
                                                        SELF.addr_suffix := addr.addr_suffix;
                                                        SELF.postdir := addr.postdir;
                                                        SELF.unit_desig := addr.unit_desig;
                                                        SELF.sec_range := addr.sec_range;
                                                        SELF.p_city_name := addr.city;
                                                        SELF.st := addr.state;
                                                        SELF.z5 := addr.zip5;
                                                        SELF.zip4 := addr.zip4;
                                                        SELF.county := addr.county;
                                                        SELF.geo_blk := addr.geo_blk;

                                                        SELF.addr_type := addr.rec_type;
                                                        SELF.addr_status := addr.err_stat;

                                                        SELF.ssn := indv.ssn;
                                                        SELF.dob := indv.dob;
                                                        SELF.phone10 := indv.phone;
                                                        SELF := [];));



        //get the best data from the lexID passed in
        bestData := GetBestData(searchForDIDs);

        //add best to existing data if best was found
        updateData := JOIN(cleanedData, bestData,
                            (UNSIGNED)LEFT.cleanedInput.seq = RIGHT.seq,
                            TRANSFORM(DueDiligence.LayoutsInternal.BestData,
                                      SELF.piiInput := LEFT.cleanedInput.piiPopulated;
                                      SELF.piiValid := RIGHT.did > 0; //we found a person with PII

                                      useInputAddress := LEFT.cleanedInput.addressProvided AND LEFT.cleanedInput.fullCleanAddressExists;

                                      SELF.inputAddressUsed := useInputAddress;
                                      SELF.bestAddressUsed := (LEFT.cleanedInput.addressProvided = FALSE OR LEFT.cleanedInput.fullCleanAddressExists = FALSE) AND RIGHT.did > 0;

                                      SELF.address := IF(useInputAddress, LEFT.cleanedInput.individual.address, RIGHT.address);
                                      SELF.bestAddress := RIGHT.address;
                                      SELF := RIGHT;),
                            LEFT OUTER,
                            ATMOST(DueDiligence.Constants.MAX_ATMOST_1));




        // OUTPUT(cleanedData, NAMED('cleanedData_pii'));
        // OUTPUT(searchForDIDs, NAMED('searchForDIDs_pii'));
        // OUTPUT(bestData, NAMED('bestData_pii'));
        // OUTPUT(updateData, NAMED('updateData_pii'));

        RETURN updateData;
    END;


    //assuming inData has the did populated
    EXPORT GetIndividualBestDataWithLexID(DATASET(DueDiligence.Layouts.Indv_Internal) inData) := FUNCTION

        //only populate to get the best data if we have a did
        projData := PROJECT(inData, TRANSFORM(Risk_Indicators.Layout_Input,
                                              SELF.seq := COUNTER;
                                              SELF.did := (UNSIGNED)LEFT.individual.did;
                                              SELF.historydate := (UNSIGNED)((STRING)LEFT.historyDate)[1..6];
                                              SELF := [];));

        bestData := GetBestData(projData);

        populateBest := JOIN(inData, bestData,
                              LEFT.individual.did = RIGHT.did,
                              TRANSFORM(DueDiligence.Layouts.Indv_Internal,
                                        SELF.individual.ssn := RIGHT.ssn;
                                        SELF.individual.dob := (UNSIGNED)RIGHT.dob;
                                        SELF.individual.phone := RIGHT.phone;
                                        SELF.individual := RIGHT.name;
                                        SELF.individual := RIGHT.address;

                                        SELF := LEFT;),
                              LEFT OUTER,
                              ATMOST(DueDiligence.Constants.MAX_ATMOST_1));



        // OUTPUT(projData, NAMED('projData_lexID'));
        // OUTPUT(bestData, NAMED('bestData_lexid'));
        // OUTPUT(populateBest, NAMED('populateBest_lexid'));

        RETURN populateBest;
    END;


    EXPORT GetIndividualBestDataWithPII(DATASET(DueDiligence.Layouts.CleanedData) cleanData) := FUNCTION

        bestData := SearchByInputPII(cleanData);

        populateBest := PROJECT(bestData, TRANSFORM(DueDiligence.Layouts.Indv_Internal,
                                                    SELF.seq := LEFT.seq;

                                                    SELF.individual.did := LEFT.did;
                                                    SELF.individual.score := LEFT.lexIDScore;
                                                    SELF.individual.ssn := LEFT.ssn;
                                                    SELF.individual.dob := (UNSIGNED4)LEFT.dob;
                                                    SELF.individual.phone := LEFT.phone;

                                                    SELF.individual := LEFT.name;
                                                    SELF.individual := LEFT.bestAddress;

                                                    SELF.inquiredDID := LEFT.did;

                                                    SELF := [];));

        RETURN populateBest;
    END;


END;
