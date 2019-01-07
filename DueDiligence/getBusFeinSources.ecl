IMPORT BIPV2, BIPV2_Best, Business_Risk_BIP, DueDiligence, Suppress;

/*
	Following Keys being used:
			BIPV2_Best.Key_LinkIds.kFetch2
*/
EXPORT getBusFeinSources(DATASET(DueDiligence.Layouts.Busn_Internal) inData,
												 Business_Risk_BIP.LIB_Business_Shell_LIBIN options,
												 BIPV2.mod_sources.iParams linkingOptions,
                         STRING ssnMask) := FUNCTION


    bestInfoRaw := BIPV2_Best.Key_LinkIds.kFetch2(DueDiligence.CommonBusiness.GetLinkIDs(inData),
                                                  Business_Risk_BIP.Common.SetLinkSearchLevel(options.LinkSearchLevel),
                                                  0, //ScoreThreshold --> 0 = Give me everything
                                                  linkingOptions,
                                                  Business_Risk_BIP.Constants.Limit_Default,
                                                  options.KeepLargeBusinesses);
    
    //add back our seq numbers
    bestWithSeq := DueDiligence.CommonBusiness.AppendSeq(bestInfoRaw, inData, TRUE);
    
    bestInformation := ROLLUP(SORT(bestWithSeq, seq), 
                              LEFT.seq = RIGHT.seq, 
                              TRANSFORM(RECORDOF(LEFT),
                                        SELF.Company_FEIN := LEFT.Company_FEIN + RIGHT.Company_FEIN;
                                        SELF := LEFT));
                                          
                                          
    feinSources := NORMALIZE(bestInformation, LEFT.Company_FEIN, TRANSFORM(DueDiligence.LayoutsInternal.FeinSources,  																														
                                                                            SELF.seq := LEFT.seq;
                                                                            SELF.ultID := LEFT.UltID;
                                                                            SELF.orgID := LEFT.OrgID;
                                                                            SELF.seleID := LEFT.SeleID;
                                                                            //sources is a DATASET
                                                                            SELF.FEINSourceContainsE5 := IF(COUNT(RIGHT.Sources(source = DueDiligence.Constants.FEIN_SOURCE_EXPERIAN_RESTRICTED)) > 0, TRUE, FALSE);
                                                                            SELF.companyFEIN := RIGHT.company_fein;
                                                                            SELF.maskedFEIN := RIGHT.company_fein;
                                                                            SELF.mask := ssnMask; 
                                                                            SELF := RIGHT;
                                                                            SELF  := [];));
   

    //pass the input file and the name of the output file
    Suppress.MAC_Mask(feinSources, maskListFEINSources, maskedFEIN, DueDiligence.Constants.EMPTY, TRUE, FALSE,,,, ssnMask);
   
    addFeinSources := JOIN(inData, maskListFEINSources, 
                            LEFT.seq = RIGHT.seq AND
                            LEFT.Busn_info.BIP_IDS.UltID.LinkID = RIGHT.UltID AND
                            LEFT.Busn_info.BIP_IDS.OrgID.LinkID = RIGHT.OrgID AND
                            LEFT.Busn_info.BIP_IDS.SeleID.LinkID = RIGHT.SeleID AND
                            LEFT.busn_info.fein = RIGHT.companyfein,		
                            TRANSFORM(DueDiligence.Layouts.Busn_Internal,		
                                       //Masking of the FEIN occurs when at least 1 FEIN Source comes from E5 - Equifax Restricted
                                       //Don't mask the FEIN that reside within the Bus_info.fein - because other logic uses fein to search by  
                                       SELF.FEINSourceContainsE5 := RIGHT.FEINSourceContainsE5;
                                       SELF.FEINSourcesCnt := COUNT(RIGHT.sources);
                                       SELF.FEIN_Masked_For_Report := RIGHT.maskedFEIN;
                                       SELF.FEINSources := RIGHT.Sources;
                                       SELF := LEFT;),
                            ATMOST(DueDiligence.Constants.MAX_ATMOST_1000),
                            LEFT OUTER,
                            ATMOST(1)); 
    
    
    
    
    
    
    // OUTPUT(bestWithSeq, NAMED('bestWithSeq'));
    // OUTPUT(bestInformation, NAMED('bestInformation'));
    // OUTPUT(feinSources, NAMED('feinSources'));
    // OUTPUT(addFeinSources, NAMED('addFeinSources'));
    
    
                            
    RETURN addFeinSources;
END;