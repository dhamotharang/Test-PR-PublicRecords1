IMPORT Address, BIPV2, BIPV2_Best, Business_Risk_BIP, Doxie, AutoStandardI, Address;

// Will need to pass in some additional input params
EXPORT V31_InputCopy (DATASET(Business_Risk_BIP.Layouts.Input) Input,
															 Business_Risk_BIP.LIB_Business_Shell_LIBIN Options,
                               BIPV2.mod_sources.iParams linkingOptions
                               ) := FUNCTION

    ds_SearchInput := PROJECT(Input(SeleID <> 0), TRANSFORM(BIPV2.IDFunctions.rec_SearchInput, 
        SELF.inSeleid      := (STRING)LEFT.SeleID,
        SELF.acctno        := (STRING)LEFT.seq,
        SELF               := []));

    ds_linkIDs := BIPV2.IDfunctions.fn_IndexedSearchForXLinkIDs(ds_SearchInput).Data2_;		

    ds_linkIDs_deduped := DEDUP(SORT(ds_linkIDs, AcctNo, -weight, UltID, OrgID, SeleID, ProxID, PowID), AcctNo);

    // By fulling populating the linkIDs here, we will search by these in the business shell. The combined service does not fully populate these, so 
    // behavior here will be slightly different than in the combined service.
    Input_with_LinkIDs := JOIN(Input, ds_linkIDs_deduped, LEFT.Seq = (UNSIGNED)RIGHT.AcctNo, TRANSFORM(RECORDOF(LEFT),
                              SELF.UltID := IF(LEFT.UltID > 0, LEFT.UltID, RIGHT.UltID);
                              SELF.OrgID := IF(LEFT.OrgID > 0, LEFT.OrgID, RIGHT.OrgID);
                              SELF.SeleID := IF(LEFT.SeleID > 0, LEFT.SeleID, RIGHT.SeleID);
                              SELF.ProxID := IF(LEFT.ProxID > 0, LEFT.ProxID, RIGHT.ProxID),
                              SELF.PowID := IF(LEFT.PowID > 0, LEFT.PowID, RIGHT.PowID);
                              SELF := LEFT),
                           LEFT OUTER, KEEP(1), ATMOST(100), FEW);

    ds_in_ids := PROJECT(Input_with_LinkIDs(SeleID <> 0), TRANSFORM(BIPV2.IDlayouts.l_xlink_ids2, SELF.uniqueid := (UNSIGNED)LEFT.Seq, SELF := LEFT));

    ds_best := IF(Options.MarketingMode = 1,
                  BIPV2_Best.Key_LinkIds.KFetch2Marketing( ds_in_ids,
                        BIPV2.IDconstants.Fetch_Level_SELEID,
                          ScoreThreshold := 0, // ScoreThreshold --> 0 = Give me everything
                          in_mod := linkingOptions,
                          IncludeStatus := TRUE,
                          JoinLimit := Business_Risk_BIP.Constants.Limit_Default,
                          JoinType := Options.KeepLargeBusinesses
                          )(proxid = 0),
                  BIPV2_Best.Key_LinkIds.KFetch2( ds_in_ids,
                          BIPV2.IDconstants.Fetch_Level_SELEID,
                          in_mod := linkingOptions,
                          ScoreThreshold := 0, // ScoreThreshold --> 0 = Give me everything
                          IncludeStatus := TRUE,
                          JoinLimit := Business_Risk_BIP.Constants.Limit_Default,
                          JoinType := Options.KeepLargeBusinesses
                          )(proxid = 0));	
        
      ds_SBA_InputFromSeleID := JOIN(Input_with_LinkIDs, ds_best, LEFT.seq=RIGHT.uniqueid, 
          TRANSFORM( Business_Risk_BIP.Layouts.Input,
                  
                  UseBest := LEFT.SeleID <> 0 AND (LEFT.Companyname = '' 
                                                AND LEFT.StreetAddress1 = ''
																								AND LEFT.City = ''
																								AND LEFT.State = ''
																								AND LEFT.Zip = '');
                                                
                  prim_range :=  IF(UseBest, RIGHT.company_address[1].company_prim_range, LEFT.prim_range);
                  prim_name := IF(UseBest, RIGHT.company_address[1].company_prim_name, LEFT.prim_name);    
                  Predir := IF(UseBest, RIGHT.company_address[1].Company_Predir, LEFT.Predir);
                  Addr_Suffix := IF(UseBest, RIGHT.company_address[1].Company_Addr_Suffix, LEFT.Addr_Suffix);
                  Postdir := IF(UseBest, RIGHT.company_address[1].Company_Postdir, LEFT.PostDir);
                  Unit_Desig := IF(UseBest, RIGHT.company_address[1].Company_Unit_Desig, LEFT.Unit_Desig);
                  Sec_Range := IF(UseBest, RIGHT.company_address[1].Company_Sec_Range, LEFT.Sec_Range);
                  
                  SELF.CompanyName := IF(UseBest,RIGHT.Company_name[1].Company_Name, LEFT.CompanyName);
                  SELF.StreetAddress1 := IF(UseBest, Address.Addr1FromComponents(prim_range, Predir, prim_name, Addr_Suffix, Postdir, Unit_Desig, Sec_Range), LEFT.StreetAddress1);

                  SELF.FEIN := IF(UseBest, RIGHT.Company_FEIN[1].company_fein, LEFT.FEIN);

                  SELF.prim_range :=  prim_range;
                  SELF.prim_name := prim_name;
                  SELF.city := IF(UseBest,RIGHT.company_address[1].company_p_city_name, LEFT.City);
                  SELF.state := IF(UseBest,RIGHT.company_address[1].company_st, LEFT.State);
                  SELF.zip5 := IF(UseBest,RIGHT.company_address[1].company_zip5, LEFT.Zip);
                  SELF.phone10 := IF(UseBest,(STRING10)RIGHT.Company_phone[1].company_phone, LEFT.Phone10);
                  SELF := LEFT),
					LEFT OUTER, KEEP(1), ATMOST(100), FEW);
    // OUTPUT(ds_best,NAMED('ds_best'));
    // OUTPUT(Input_with_LinkIDs,NAMED('Input_with_LinkIDs'));
    // OUTPUT(ds_SBA_InputFromSeleID,NAMED('ds_SBA_InputFromSeleID'));
   
    RETURN  ds_SBA_InputFromSeleID;
    
  END;
