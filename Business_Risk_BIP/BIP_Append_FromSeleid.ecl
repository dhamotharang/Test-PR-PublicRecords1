IMPORT Address, BIPV2, BIPV2_Best, Business_Risk_BIP, Doxie, AutoStandardI;

// Will need to pass in some additional input params
EXPORT BIP_Append_FromSeleid(DATASET(Business_Risk_BIP.Layouts.Input) Input,
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
                                                
                  SELF.CompanyName := IF(UseBest,RIGHT.Company_name[1].Company_Name, LEFT.CompanyName);
                  SELF.prim_range :=  IF(UseBest,RIGHT.company_address[1].company_prim_range, LEFT.prim_range);
                  SELF.prim_name := IF(UseBest,RIGHT.company_address[1].company_prim_name, LEFT.prim_name);
                  SELF.city := IF(UseBest,RIGHT.company_address[1].company_p_city_name, LEFT.City);
                  SELF.state := IF(UseBest,RIGHT.company_address[1].company_st, LEFT.State);
                  SELF.zip5 := IF(UseBest,RIGHT.company_address[1].company_zip5, LEFT.Zip);
                  SELF.phone10 := IF(UseBest,(STRING10)RIGHT.Company_phone[1].company_phone, LEFT.Phone10);
                  SELF := LEFT),
					LEFT OUTER, KEEP(1), ATMOST(100), FEW);

      bipv2.idappendlayouts.AppendInput prepBIPInput(Business_Risk_BIP.Layouts.Input le) := TRANSFORM
        SELF.request_id := le.Seq;
        SELF.company_name := le.CompanyName;
        SELF.prim_range := le.Prim_Range;
        SELF.prim_name := le.Prim_Name;
        SELF.sec_range := le.Sec_Range;
        SELF.city := le.City;
        SELF.state := le.State;
        SELF.zip5 := le.Zip5;
        SELF.zip_radius_miles := 0;
        SELF.phone10 := le.Phone10;
        SELF.fein := le.FEIN;
        SELF.url := le.CompanyURL;
        SELF.email := le.Rep_Email;
        SELF.contact_fname := IF( Options.DoNotUseAuthRepInBIPAppend, '', le.Rep_FirstName );
        SELF.contact_mname := IF( Options.DoNotUseAuthRepInBIPAppend, '', le.Rep_MiddleName );
        SELF.contact_lname := IF( Options.DoNotUseAuthRepInBIPAppend, '', le.Rep_LastName );
        SELF.contact_ssn := IF( Options.DoNotUseAuthRepInBIPAppend, '', le.Rep_SSN );
        SELF.contact_did := IF( Options.DoNotUseAuthRepInBIPAppend, 0, le.Rep_LexID );
        // SELF.sic_code := ;
        // SELF.source := ;
        // SELF.source_record_id := ;
        SELF.proxid := le.ProxID;
        SELF.seleid := le.SeleID;
        SELF := [];  
    END; 
 
    ds_return := PROJECT(ds_SBA_InputFromSeleID, prepBIPInput(LEFT));
    
    // OUTPUT(Input_with_LinkIDs,NAMED('Input_with_LinkIDs'));
    // OUTPUT(ds_SBA_InputFromSeleID,NAMED('ds_SBA_InputFromSeleID'));
    // OUTPUT(ds_return,NAMED('SeleID_Input_Return'));
    // OUTPUT(ds_best,NAMED('ds_best'));
    // OUTPUT(ds_SearchInput, NAMED('ds_SearchInput'));
    // OUTPUT(ds_best_records, NAMED('ds_best_records_Seleid'));
    
    RETURN ds_return;
    
  END;