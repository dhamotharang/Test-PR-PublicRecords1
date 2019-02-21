IMPORT BIPV2, Business_Risk_BIP, DueDiligence;


/*
	Following Keys being used:
			BIPV2.IdAppendRoxie
			Business_Risk_BIP.BIP_Best_Append
*/
EXPORT getBusInfo(DATASET(DueDiligence.Layouts.CleanedData) indata, 
                  Business_Risk_BIP.LIB_Business_Shell_LIBIN options,
                  BIPV2.mod_sources.iParams linkingOptions) := FUNCTION
 
 
   linkLayout := PROJECT(indata, TRANSFORM(BIPV2.IdAppendLayouts.AppendInput,
                                            //get the cleaned business data
                                            cleanData := LEFT.cleanedInput.business;
                                            //get the cleaned business address data
                                            cleanAddress := cleanData.address;

                                            SELF.request_id := LEFT.inputecho.seq;
                                            SELF.seleid := cleanData.BIP_IDs.SeleID.LinkID;
                                            SELF.company_name := cleanData.companyName;

                                            SELF.prim_range := cleanAddress.prim_range;
                                            SELF.prim_name := cleanAddress.prim_name;
                                            SELF.city := cleanAddress.city;
                                            SELF.zip5 := cleanAddress.zip5;
                                            SELF.state := cleanAddress.state;

                                            SELF.fein := cleanData.fein;
                                            SELF.phone10 := cleanData.phone;
                                            SELF := [];));
                                                  
                                                  
    append := BIPV2.IdAppendRoxie(linkLayout,
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
                                                                                                      
                                                                cleanedAddress := DueDiligence.CitDDShared.cleanAddress(tempAddress);

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
		tempOptions := MODULE(Business_Risk_BIP.LIB_Business_Shell_LIBIN)
			EXPORT UNSIGNED1	DPPA_Purpose 				:= options.DPPA_Purpose;
			EXPORT UNSIGNED1	GLBA_Purpose 				:= options.GLBA_Purpose;
			EXPORT STRING50		DataRestrictionMask	:= options.DataRestrictionMask;
			EXPORT STRING50		DataPermissionMask	:= options.DataPermissionMask;
			EXPORT STRING10		IndustryClass				:= options.IndustryClass;
			EXPORT UNSIGNED1	LinkSearchLevel			:= options.LinkSearchLevel;
			EXPORT UNSIGNED1	BusShellVersion			:= options.BusShellVersion;
			EXPORT UNSIGNED1	MarketingMode				:= options.MarketingMode;
			EXPORT STRING50		AllowedSources			:= options.AllowedSources;
			EXPORT UNSIGNED1	BIPBestAppend	 			:= Business_Risk_BIP.Constants.BIPBestAppend.OverwriteWithBest;  //Get whatever we think is the best data
		END;
			
		//append "Best" company information
		bestAttempt2 := Business_Risk_BIP.BIP_Best_Append(withBIP, tempOptions, linkingOptions, allowedSourcesSet);
		
		
    finalBest := JOIN(bestWithCleanAddress, bestAttempt2,
                      LEFT.request_id = RIGHT.seq AND
                      LEFT.seleID = RIGHT.BIP_IDs.SeleID.LinkID,
                      TRANSFORM(RECORDOF(LEFT),
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
                                                   
                                clean2 := DueDiligence.CitDDShared.cleanAddress(tempAddress);
                                clean1 := LEFT.cleanedAddress;

                                //try to populate the cleaned address from the 1st best if exists, else the 2nd best
                                SELF.cleanedAddress := IF(LEFT.addressFound, clean1, clean2);

                                SELF.company_phone := IF(LEFT.company_phone = DueDiligence.Constants.EMPTY, RIGHT.input_echo.phone10, LEFT.company_phone);
                                SELF.company_fein := IF(LEFT.company_fein = DueDiligence.Constants.EMPTY, RIGHT.input_echo.fein, LEFT.company_fein);
                                SELF.company_name := IF(LEFT.company_name = DueDiligence.Constants.EMPTY, RIGHT.input_echo.companyName, LEFT.company_name);
                                SELF := LEFT;),
                      LEFT OUTER,
                      ATMOST(DueDiligence.Constants.MAX_ATMOST_1));



    final := JOIN(indata, finalBest,
                  LEFT.inputecho.seq = RIGHT.request_id,
                  TRANSFORM(DueDiligence.Layouts.Busn_Internal,
                            SELF.seq := LEFT.cleanedInput.seq;
                            
                            SELF.busn_info.BIP_IDs.UltID.LinkID := RIGHT.UltID;
                            SELF.busn_info.BIP_IDs.OrgID.LinkID := RIGHT.OrgID;
                            SELF.busn_info.BIP_IDs.SeleID.LinkID := RIGHT.SeleID;
                            SELF.busn_info.BIP_IDs.ProxID.LinkID := RIGHT.ProxID;
                            SELF.busn_info.BIP_IDs.PowID.LinkID := RIGHT.PowID;
                            
                            SELF.score := RIGHT.seleScore;
                            
                            SELF.busn_info.lexID := (STRING)RIGHT.SeleID;
                            SELF.historyDate := LEFT.cleanedInput.historyDateYYYYMMDD;
                            
                            addressProvided := LEFT.cleanedInput.addressProvided;
                            fullAddressProvided := LEFT.cleanedInput.fullAddressProvided;
                            cleanBusInput := LEFT.cleanedInput.business;
                            
                            SELF.inputaddressprovided := addressProvided;
                            SELF.fullinputaddressprovided := fullAddressProvided;
                            SELF.relatedDegree := DueDiligence.Constants.INQUIRED_BUSINESS_DEGREE;
                                                      
                            SELF.busn_info.companyName := IF(cleanBusInput.companyName = DueDiligence.Constants.EMPTY, RIGHT.company_name, cleanBusInput.companyName); 
                            SELF.busn_info.altCompanyName := IF(cleanBusInput.altCompanyName = DueDiligence.Constants.EMPTY, DueDiligence.Constants.EMPTY, cleanBusInput.altCompanyName);
                            SELF.busn_info.fein := IF(cleanBusInput.fein = DueDiligence.Constants.EMPTY, RIGHT.company_fein, cleanBusInput.fein);
                            SELF.busn_info.phone := IF(cleanBusInput.phone = DueDiligence.Constants.EMPTY, RIGHT.company_phone, cleanBusInput.phone);
                              
                            SELF.busn_info.address := IF(fullAddressProvided, cleanBusInput.address, RIGHT.cleanedAddress);
														
                            SELF.bestBusInfo.companyName := RIGHT.company_name;
                            SELF.bestBusInfo.address := RIGHT.cleanedAddress;
                            SELF.bestBusInfo.phone := RIGHT.company_phone;
                            SELF.bestBusInfo.fein := RIGHT.company_fein;
                            
                            SELF.busn_info := LEFT.cleanedInput.business;
                            SELF.busn_input := LEFT.inputEcho.business;
                            
                            SELF := [];),
                  LEFT OUTER,
                  ATMOST(DueDiligence.Constants.MAX_ATMOST_1));
									
									
									
									
	
														
		
		
		
    
    
    // OUTPUT(indata, NAMED('indata'));
    // OUTPUT(linkLayout, NAMED('linkLayout'));
    // OUTPUT(withBest, NAMED('withBest'));
    // OUTPUT(bestScoreAndData, NAMED('bestScoreAndData'));
    // OUTPUT(bestWithCleanAddress, NAMED('bestWithCleanAddress'));
    // OUTPUT(withBIP, NAMED('withBIP'));
    // OUTPUT(bestAttempt2, NAMED('bestAttempt2'));
    // OUTPUT(finalBest, NAMED('finalBest'));
    // OUTPUT(final, NAMED('final'));
		

    
    RETURN final;
END;