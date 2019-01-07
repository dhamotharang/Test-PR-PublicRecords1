IMPORT BIPV2, DueDiligence;


EXPORT getBusInfo(DATASET(DueDiligence.Layouts.CleanedData) indata) := FUNCTION
 
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
    bestWithCleanAddress := PROJECT(bestScoreAndData, TRANSFORM({RECORDOF(LEFT), DueDiligence.Layouts.Address cleanedAddress},
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
                                                                                                      
                                                              SELF.cleanedAddress := DueDiligence.CitDDShared.cleanAddress(tempAddress);
                                                              SELF := LEFT;));


    final := JOIN(indata, bestWithCleanAddress,
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
                            
                            SELF.busn_info := LEFT.cleanedInput.business;
                            SELF.busn_input := LEFT.inputEcho.business;
                            
                            SELF := [];),
                  LEFT OUTER,
                  ATMOST(1));

    
    
    // OUTPUT(indata, NAMED('indata'));
    // OUTPUT(linkLayout, NAMED('linkLayout'));
    // OUTPUT(withBest, NAMED('withBest'));
    // OUTPUT(bestWithCleanAddress, NAMED('bestWithCleanAddress'));
    // OUTPUT(final, NAMED('final'));
    
    
    RETURN final;
END;