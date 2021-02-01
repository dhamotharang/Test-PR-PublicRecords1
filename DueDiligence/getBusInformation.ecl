IMPORT BIPV2, Business_Risk_BIP, DueDiligence;



EXPORT getBusInformation(Business_Risk_BIP.LIB_Business_Shell_LIBIN options,
                          BIPV2.mod_sources.iParams linkingOptions) := MODULE



    SHARED GetBestData(DATASET(BIPV2.IdAppendLayouts.AppendInput) inData) := FUNCTION

         append := BIPV2.IdAppendRoxie(inData,
                                        scoreThreshold := 51, // 75 is the default, valid values are >= 51 and <= 100
                                        weightThreshold := 0, // default is 0. Can be set higher to ensure a stronger match
                                        primForce := FALSE, // Set to true to enforce that prim_range match unless not specified in input
                                        reAppend := FALSE); //do not re-append so can retrieve best info


        withBest := append.WithBest(fetchLevel := BIPV2.IdConstants.fetch_level_seleid);

        //if we have multiple rows for a given seq, sort by sele score to grab the highest score
        bestScoreAndData := DEDUP(SORT(withBest, request_id, -seleScore), request_id);

        //clean the address
        bestWithCleanAddress := PROJECT(bestScoreAndData, TRANSFORM({RECORDOF(LEFT), DueDiligence.Layouts.Address cleanedAddress, BOOLEAN addressFound},
                                                                    tempAddress := PROJECT(LEFT, TRANSFORM(DueDiligence.Layouts.Address,
                                                                                                            SELF.prim_range := LEFT.prim_range;
                                                                                                            SELF.predir := LEFT.predir;
                                                                                                            SELF.prim_name := LEFT.prim_name;
                                                                                                            SELF.addr_suffix := LEFT.addr_suffix;
                                                                                                            SELF.postdir := LEFT.postdir;
                                                                                                            SELF.unit_desig := LEFT.unit_desig;
                                                                                                            SELF.sec_range := LEFT.sec_range;
                                                                                                            SELF.city := LEFT.v_city_name;
                                                                                                            SELF.state := LEFT.st;
                                                                                                            SELF.zip5 := LEFT.zip;
                                                                                                            SELF.zip4 := LEFT.zip4;
                                                                                                            SELF := [];));

                                                                    cleanedAddress := DueDiligence.CommonAddress.GetCleanAddress(tempAddress);

                                                                    SELF.addressFound := cleanedAddress.streetAddress1 <> DueDiligence.Constants.EMPTY AND
                                                                                         cleanedAddress.city <> DueDiligence.Constants.EMPTY AND
                                                                                         cleanedAddress.zip5 <> DueDiligence.Constants.EMPTY;

                                                                    SELF.cleanedAddress := cleanedAddress;
                                                                    SELF := LEFT;));

        //in off chance we did not get anything back, lets make 1 more call to verify we don't have a did
        withBIP := PROJECT(bestWithCleanAddress, TRANSFORM(Business_Risk_BIP.Layouts.Shell,
                                                            SELF.seq := LEFT.request_id;
                                                            SELF.BIP_IDs.SeleID.LinkID := LEFT.seleID;
                                                            SELF := [];));


        allowedSourcesSet := SET(DATASET([], Business_Risk_BIP.Layout_AllowedSources), Source); //as of 5/26/17 not used in BIP_Best_Append

        //creating a new options to pass into the BIP_Best_Append to overwite the BIPBestAppend passed in
        tempOptions := MODULE(PROJECT(options, Business_Risk_BIP.LIB_Business_Shell_LIBIN))
          EXPORT UNSIGNED1	BIPBestAppend	 			:= Business_Risk_BIP.Constants.BIPBestAppend.OverwriteWithBest;  //Get whatever we think is the best data
        END;

        //append "Best" company information
        bestAttempt2 := Business_Risk_BIP.BIP_Best_Append(withBIP, tempOptions, linkingOptions, allowedSourcesSet);


        finalBest := JOIN(bestWithCleanAddress, bestAttempt2,
                          LEFT.request_id = RIGHT.seq AND
                          LEFT.seleID = RIGHT.BIP_IDs.SeleID.LinkID,
                          TRANSFORM(DueDiligence.LayoutsInternal.BestData,
                                    tempAddress := PROJECT(LEFT, TRANSFORM(DueDiligence.Layouts.Address,
                                                                            SELF.prim_range := RIGHT.input_echo.prim_range;
                                                                            SELF.predir := RIGHT.input_echo.predir;
                                                                            SELF.prim_name := RIGHT.input_echo.prim_name;
                                                                            SELF.addr_suffix := RIGHT.input_echo.addr_suffix;
                                                                            SELF.postdir := RIGHT.input_echo.postdir;
                                                                            SELF.unit_desig := RIGHT.input_echo.unit_desig;
                                                                            SELF.sec_range := RIGHT.input_echo.sec_range;
                                                                            SELF.city := RIGHT.input_echo.city;
                                                                            SELF.state := RIGHT.input_echo.state;
                                                                            SELF.zip5 := RIGHT.input_echo.zip5;
                                                                            SELF.zip4 := RIGHT.input_echo.zip4;
                                                                            SELF := [];));

                                    clean2 := DueDiligence.CommonAddress.GetCleanAddress(tempAddress);
                                    clean1 := LEFT.cleanedAddress;

                                    SELF.seq := LEFT.request_id;
                                    SELF.ultID := LEFT.ultID;
                                    SELF.orgID := LEFT.orgID;
                                    SELF.seleID := LEFT.seleID;
                                    SELF.proxID := LEFT.proxID;
                                    SELF.powID := LEFT.powID;

                                    SELF.lexIDScore := LEFT.seleScore;

                                    SELF.companyName := IF(LEFT.company_name = DueDiligence.Constants.EMPTY, RIGHT.clean_input.companyName, LEFT.company_name);
                                    // SELF.altCompanyName :=
                                    SELF.fein := IF(LEFT.company_fein = DueDiligence.Constants.EMPTY, RIGHT.clean_input.fein, LEFT.company_fein);
                                    SELF.phone := IF(LEFT.company_phone = DueDiligence.Constants.EMPTY, RIGHT.clean_input.phone10, LEFT.company_phone);
                                    SELF.address := IF(LEFT.addressFound, clean1, clean2);

                                    SELF := [];),
                          LEFT OUTER,
                          ATMOST(DueDiligence.Constants.MAX_ATMOST_1));


        RETURN finalBest;
    END;








    EXPORT SearchByInputLexID(DATASET(DueDiligence.Layouts.CleanedData) cleanedData) := FUNCTION

        linkLayout := PROJECT(cleanedData, TRANSFORM(BIPV2.IdAppendLayouts.AppendInput,
                                                      //get the cleaned business data
                                                      cleanData := LEFT.cleanedInput.business;

                                                      SELF.request_id := LEFT.cleanedInput.seq;
                                                      SELF.seleid := cleanData.BIP_IDs.SeleID.LinkID;
                                                      SELF := [];));

        bestData := GetBestData(linkLayout);

        updateData := JOIN(cleanedData, bestData,
                            LEFT.cleanedInput.seq = RIGHT.seq,
                            TRANSFORM(DueDiligence.LayoutsInternal.BestData,
                                      //found some information on a business
                                      SELF.lexIDValid := RIGHT.companyName <> DueDiligence.Constants.EMPTY OR
                                                         RIGHT.fein <> DueDiligence.Constants.EMPTY OR
                                                         RIGHT.phone <> DueDiligence.Constants.EMPTY OR
                                                         RIGHT.address.streetAddress1 <> DueDiligence.Constants.EMPTY OR
                                                         RIGHT.address.city <> DueDiligence.Constants.EMPTY OR
                                                         RIGHT.address.state <> DueDiligence.Constants.EMPTY OR
                                                         RIGHT.address.zip5 <> DueDiligence.Constants.EMPTY;
                                      SELF.bestAddressUsed := TRUE;
                                      SELF.bestAddress := RIGHT.address;
                                      SELF := RIGHT;),
                            LEFT OUTER,
                            ATMOST(DueDiligence.Constants.MAX_ATMOST_1));


        // OUTPUT(bestData, NAMED('bestDataLexID'));
        // OUTPUT(updateData, NAMED('updateDataLexID'));
        RETURN updateData;
    END;



    EXPORT SearchByInputPII(DATASET(DueDiligence.Layouts.CleanedData) cleanedData) := FUNCTION

        linkLayoutPrimaryName := PROJECT(cleanedData, TRANSFORM(BIPV2.IdAppendLayouts.AppendInput,
                                          //get the cleaned business data
                                          cleanData := LEFT.cleanedInput.business;
                                          //get the cleaned business address data
                                          cleanAddress := cleanData.address;

                                          SELF.request_id := LEFT.inputecho.seq;
                                          SELF.company_name := cleanData.companyName;

                                          SELF.prim_range := cleanAddress.prim_range;
                                          SELF.prim_name := cleanAddress.prim_name;
                                          SELF.city := cleanAddress.city;
                                          SELF.zip5 := cleanAddress.zip5;
                                          SELF.state := cleanAddress.state;

                                          SELF.fein := cleanData.fein;
                                          SELF.phone10 := cleanData.phone;
                                          SELF := [];));

        bestData := GetBestData(linkLayoutPrimaryName);

        updateData := JOIN(cleanedData, bestData,
                            LEFT.cleanedInput.seq = RIGHT.seq,
                            TRANSFORM(DueDiligence.LayoutsInternal.BestData,
                                      SELF.piiValid := RIGHT.seleID > 0; //we found a business with PII

                                      useInputAddress := LEFT.cleanedInput.addressProvided AND LEFT.cleanedInput.fullCleanAddressExists;

                                      SELF.inputAddressUsed := useInputAddress;
                                      SELF.bestAddressUsed := (LEFT.cleanedInput.addressProvided = FALSE OR LEFT.cleanedInput.fullCleanAddressExists = FALSE) AND RIGHT.seleID > 0;

                                      SELF.address := IF(useInputAddress, LEFT.cleanedInput.business.address, RIGHT.address);

                                      SELF.bestAddress := RIGHT.address;

                                      SELF := RIGHT;),
                            LEFT OUTER,
                            ATMOST(DueDiligence.Constants.MAX_ATMOST_1));


        // OUTPUT(bestData, NAMED('bestDataPII'));
        // OUTPUT(updateData, NAMED('updateDataPII'));
        RETURN updateData;
    END;



    EXPORT GetBusinessBestDataWithPII(DATASET(DueDiligence.Layouts.CleanedData) cleanedData) := FUNCTION

        bestData := SearchByInputPII(cleanedData);

        businessData := PROJECT(bestData, TRANSFORM(DueDiligence.Layouts.Busn_Internal,
                                                    SELF.seq := LEFT.seq;
                                                    SELF.busn_info.BIP_IDs.UltID.LinkID := LEFT.UltID;
                                                    SELF.busn_info.BIP_IDs.OrgID.LinkID := LEFT.OrgID;
                                                    SELF.busn_info.BIP_IDs.SeleID.LinkID := LEFT.SeleID;
                                                    SELF.busn_info.BIP_IDs.ProxID.LinkID := LEFT.ProxID;
                                                    SELF.busn_info.BIP_IDs.PowID.LinkID := LEFT.PowID;

                                                    SELF.score := LEFT.lexIDScore;

                                                    SELF.busn_info.lexID := (STRING)LEFT.SeleID;
                                                    SELF.busn_info.companyName := LEFT.companyName;
                                                    SELF.busn_info.altCompanyName := LEFT.altCompanyName;
                                                    SELF.busn_info.fein := LEFT.fein;
                                                    SELF.busn_info.phone := LEFT.phone;
                                                    SELF.busn_info.address := LEFT.address;

                                                    SELF := [];));

        RETURN businessData;
    END;


    EXPORT GetBusinessBestDataWithLexID(DATASET(DueDiligence.Layouts.Busn_Internal) inputData) := FUNCTION

        linkLayout := PROJECT(inputData, TRANSFORM(BIPV2.IdAppendLayouts.AppendInput,
                                                    SELF.request_id := LEFT.seq;
                                                    SELF.seleid := LEFT.Busn_Info.BIP_IDs.SeleID.LinkID;
                                                    SELF := [];));

        bestData := GetBestData(linkLayout);

        businessData := PROJECT(bestData, TRANSFORM(DueDiligence.Layouts.Busn_Internal,
                                                    SELF.seq := LEFT.seq;
                                                    SELF.busn_info.BIP_IDs.UltID.LinkID := LEFT.UltID;
                                                    SELF.busn_info.BIP_IDs.OrgID.LinkID := LEFT.OrgID;
                                                    SELF.busn_info.BIP_IDs.SeleID.LinkID := LEFT.SeleID;
                                                    SELF.busn_info.BIP_IDs.ProxID.LinkID := LEFT.ProxID;
                                                    SELF.busn_info.BIP_IDs.PowID.LinkID := LEFT.PowID;

                                                    SELF.score := LEFT.lexIDScore;

                                                    SELF.busn_info.lexID := (STRING)LEFT.SeleID;
                                                    SELF.busn_info.companyName := LEFT.companyName;
                                                    SELF.busn_info.altCompanyName := LEFT.altCompanyName;
                                                    SELF.busn_info.fein := LEFT.fein;
                                                    SELF.busn_info.phone := LEFT.phone;
                                                    SELF.busn_info.address := LEFT.address;

                                                    SELF := [];));

        RETURN businessData;
    END;
END;
