IMPORT BIPV2, Business_Risk_BIP, DueDiligence, Risk_Indicators;


EXPORT getBestData(DueDiligence.DDInterface.iDDRegulatoryCompliance regulatoryAccess) := MODULE


    SHARED options := DueDiligence.v3Common.DDBusiness.GetBusinessShellOptions(regulatoryAccess);   
    SHARED linkingOptions := DueDiligence.v3Common.DDBusiness.GetLinkingOptions(regulatoryAccess);
    
    SHARED allowedSourcesSet := SET(DATASET([], Business_Risk_BIP.Layout_AllowedSources), Source); //as of 5/26/17 not used in BIP_Best_Append



    SHARED fn_getBestData(DATASET(BIPV2.IdAppendLayouts.AppendInput) inData, STRING inName = '') := FUNCTION
         
        append := BIPV2.IdAppendRoxie(inData,
                                      scoreThreshold := 51, // 75 is the default, valid values are >= 51 and <= 100
                                      weightThreshold := 0, // default is 0. Can be set higher to ensure a stronger match
                                      primForce := FALSE, // Set to true to enforce that prim_range match unless not specified in input
                                      reAppend := FALSE); //do not re-append so can retrieve best info
                                    
                                  
        withBest := append.WithBest(fetchLevel := BIPV2.IdConstants.fetch_level_seleid);
        
        //if we have multiple rows for a given seq, sort by sele score to grab the highest score
        bestScoreAndData := DEDUP(SORT(withBest, request_id, -seleScore), request_id);
        
        //clean the address
        bestWithCleanAddress := PROJECT(bestScoreAndData, TRANSFORM(DueDiligence.v3Layouts.InternalBusiness.SlimBestSearch,
                                                                    SELF.seq := LEFT.request_id;
                                                                    SELF.lexIDScore := LEFT.seleScore;
                                                                    
                                                                    SELF.ultID := LEFT.ultID;
                                                                    SELF.orgID := LEFT.orgID;
                                                                    SELF.seleID := LEFT.seleID;
                                                                    SELF.proxID := LEFT.proxID;
                                                                    SELF.powID := LEFT.powID;
                                                                    
                                                                    SELF.companyName := LEFT.company_name;
                                                                    SELF.fein := LEFT.company_fein;
                                                                    SELF.phone := LEFT.company_phone;
                                                                                                                                       
                                                                    tempAddress := PROJECT(LEFT, TRANSFORM(DueDiligence.v3Layouts.Internal.Address,
                                                                                                            SELF.prim_range := LEFT.prim_range;
                                                                                                            SELF.predir := LEFT.predir;
                                                                                                            SELF.prim_name := LEFT.prim_name;
                                                                                                            SELF.addr_suffix := LEFT.addr_suffix;
                                                                                                            SELF.postdir := LEFT.postdir;
                                                                                                            SELF.unit_desig := LEFT.unit_desig;
                                                                                                            SELF.sec_range := LEFT.sec_range;
                                                                                                            SELF.city := LEFT.v_city_name;
                                                                                                            SELF.state := LEFT.st;
                                                                                                            SELF.zip := LEFT.zip;
                                                                                                            SELF.zip4 := LEFT.zip4;
                                                                                                            SELF := [];));
                                                                                                          
                                                                    cleanedAddress := DueDiligence.v3Common.Address.GetCleanAddress(tempAddress);
                                                                                       
                                                                    SELF := cleanedAddress;
                                                                    
                                                                    SELF := [];));
                                                                    
        //in off chance we did not get anything back, lets make 1 more call to verify we don't have a did
        withBIP := PROJECT(bestWithCleanAddress, TRANSFORM(Business_Risk_BIP.Layouts.Shell,
                                              SELF.seq := LEFT.seq;
                                              SELF.BIP_IDs.SeleID.LinkID := LEFT.seleID;
                                              SELF := [];));
        
        
        //append "Best" company information
        bestAttempt2 := Business_Risk_BIP.BIP_Best_Append(withBIP, options, linkingOptions, allowedSourcesSet);
        
        
        finalBest := JOIN(bestWithCleanAddress, bestAttempt2,
                          LEFT.seq = RIGHT.seq AND
                          LEFT.seleID = RIGHT.BIP_IDs.SeleID.LinkID,
                          TRANSFORM(DueDiligence.v3Layouts.InternalBusiness.SlimBestSearch,
                                    tempAddress := PROJECT(RIGHT, TRANSFORM(DueDiligence.v3Layouts.Internal.Address,
                                                                            SELF.prim_range := RIGHT.input_echo.prim_range;
                                                                            SELF.predir := RIGHT.input_echo.predir;
                                                                            SELF.prim_name := RIGHT.input_echo.prim_name;
                                                                            SELF.addr_suffix := RIGHT.input_echo.addr_suffix;
                                                                            SELF.postdir := RIGHT.input_echo.postdir;
                                                                            SELF.unit_desig := RIGHT.input_echo.unit_desig;
                                                                            SELF.sec_range := RIGHT.input_echo.sec_range;
                                                                            SELF.city := RIGHT.input_echo.city;
                                                                            SELF.state := RIGHT.input_echo.state;
                                                                            SELF.zip := RIGHT.input_echo.zip5;
                                                                            SELF.zip4 := RIGHT.input_echo.zip4;
                                                                            SELF := [];));
                                                       
                                    rightAddr := DueDiligence.v3Common.Address.GetCleanAddress(tempAddress);
                                    leftAddr := PROJECT(LEFT, TRANSFORM(DueDiligence.v3Layouts.Internal.Address, SELF := LEFT));
                                    
                                    SELF.seq := LEFT.seq;
                                    SELF.ultID := LEFT.ultID;
                                    SELF.orgID := LEFT.orgID;
                                    SELF.seleID := LEFT.seleID;
                                    SELF.proxID := LEFT.proxID;
                                    SELF.powID := LEFT.powID;
                                    
                                    SELF.lexIDScore := LEFT.lexIDScore;
                                    
                                    SELF.companyName := IF(LEFT.companyName = DueDiligence.Constants.EMPTY, RIGHT.clean_input.companyName, LEFT.companyName);
                                    SELF.fein := IF(LEFT.fein = DueDiligence.Constants.EMPTY, RIGHT.clean_input.fein, LEFT.fein);
                                    SELF.phone := IF(LEFT.phone = DueDiligence.Constants.EMPTY, RIGHT.clean_input.phone10, LEFT.phone);
                                    
                                    SELF := IF(LEFT.streetAddress1 = DueDiligence.Constants.EMPTY, rightAddr, leftAddr);
                                    
                                    SELF := [];),
                          LEFT OUTER,
                          ATMOST(1));
                          
        getCounty := DueDiligence.v3Common.Address.GetAddressCounty(finalBest);
        
        addCounty := PROJECT(getCounty, TRANSFORM(DueDiligence.v3Layouts.InternalBusiness.SlimBestSearch,
                                                  SELF.countyName := LEFT.countyNameText;
                                                  SELF := LEFT;));

        
        
        // OUTPUT(withBest, NAMED('withBest' + inName));
        // OUTPUT(bestScoreAndData, NAMED('bestScoreAndData' + inName));
        // OUTPUT(bestWithCleanAddress, NAMED('bestWithCleanAddress' + inName));
        // OUTPUT(withBIP, NAMED('withBIP' + inName));
        // OUTPUT(bestAttempt2, NAMED('bestAttempt2' + inName));
        // OUTPUT(finalBest, NAMED('finalBest' + inName));


        RETURN addCounty;
    END;
    
    
    
    EXPORT SearchWithLexID(DATASET(DueDiligence.v3Layouts.InternalBusiness.SlimBestSearch) inData) := FUNCTION
        
        linkLayout := PROJECT(inData, TRANSFORM(BIPV2.IdAppendLayouts.AppendInput,
                                                SELF.request_id := LEFT.seq;
                                                SELF.seleID := LEFT.seleID;
                                                
                                                SELF := [];));
                                                    
        bestData := fn_getBestData(linkLayout);
        
        updateData := JOIN(inData, bestData,
                            LEFT.seq = RIGHT.seq,
                            TRANSFORM(DueDiligence.v3Layouts.InternalBusiness.SlimBestSearch,
                                      SELF := RIGHT;
                                      SELF := LEFT;),
                            LEFT OUTER,
                            ATMOST(1));
                            
                            
        // OUTPUT(bestData, NAMED('lexID_bestData'));
        // OUTPUT(updateData, NAMED('lexID_updateData'));
        
        RETURN updateData;
    END;
    
    
    EXPORT SearchWithBII(DATASET(DueDiligence.v3Layouts.InternalBusiness.SlimBestSearch) inData) := FUNCTION
        
        linkLayout := PROJECT(inData, TRANSFORM(BIPV2.IdAppendLayouts.AppendInput,
                                                SELF.request_id := LEFT.seq;
                                                SELF.company_name := LEFT.companyName;
                                                
                                                SELF.prim_range := LEFT.prim_range;
                                                SELF.prim_name := LEFT.prim_name;
                                                SELF.city := LEFT.city;
                                                SELF.state := LEFT.state;
                                                SELF.zip5 := LEFT.zip;

                                                SELF.fein := LEFT.fein;
                                                SELF.phone10 := LEFT.phone;
                                                SELF := [];));
                                                            
        bestData := fn_getBestData(linkLayout);
        
        updateData := JOIN(inData, bestData,
                            LEFT.seq = RIGHT.seq,
                            TRANSFORM(DueDiligence.v3Layouts.InternalBusiness.SlimBestSearch,
                                      SELF := RIGHT;),
                                      // SELF := LEFT;),
                            LEFT OUTER,
                            ATMOST(1));
                            
                            
        // OUTPUT(bestData, NAMED('bii_bestData'));
        // OUTPUT(updateData, NAMED('bii_updateData'));
        
        RETURN updateData;
    END;

END;