IMPORT BIPV2,BIPV2_Best,BIPV2_Best_SBFE,Business_Credit,Business_Risk_BIP,
       BusinessCredit_Services,Codes,doxie;

EXPORT Batch_Records( DATASET(BusinessCredit_Services.Batch_layouts.Batch_Input_Processed) ds_BatchIn,
															BusinessCredit_Services.Iparam.BatchParams inMod) :=
FUNCTION

  mod_access := PROJECT(inMod, doxie.IDataAccess);
    
	// Seperate bipid input records from search records, records with ultid id will assume no search
	ds_Format2LinkidInput := PROJECT(ds_batchIn(ultid !=0),TRANSFORM(BusinessCredit_Services.Batch_layouts.BipSlim_layout,SELF := LEFT, SELF:=[]));
    
	// Get the linkids from the search criteria
  BIPV2.IdAppendLayouts.appendInput AppendFormat(BusinessCredit_Services.Batch_layouts.Batch_Input_Processed pInput) := TRANSFORM
    SELF.request_id := (unsigned)pInput.acctno;
    SELF.company_name := pInput.comp_name;
    SELF.prim_range := pInput.prim_range;
    SELF.prim_name := pInput.prim_name;
    SELF.sec_range := pInput.sec_range;
    SELF.city := pInput.p_city_name;
    SELF.state := pInput.st;
    SELF.zip5 := pInput.z5;
    SELF.zip_radius_miles := IF ((integer)pInput.mileradius > 10, 10, (integer)pInput.mileradius);
    SELF.phone10 := pInput.workphone;   
    SELF.fein := pInput.fein;
    SELF.seleid := pInput.seleid;
    SELF.proxid := pInput.proxid;
    SELF := [];
  END;

  ds_Format2AppInput := PROJECT(ds_BatchIn, AppendFormat(LEFT));

  BusinessCredit_Services.Batch_layouts.BipSlim_layout xfm_ToBipSlim_Layout (BIPV2.IdAppendLayouts.IdsOnlyOutput inRec) :=
    TRANSFORM
      SELF.acctno := (STRING)inRec.request_id;
      SELF.DotID := inRec.DotID;
      SELF.DotScore := inRec.DotScore;
      SELF.DotWeight := inRec.DotWeight;
      SELF.EmpID := inRec.EmpID;
      SELF.EmpScore := inRec.EmpScore;
      SELF.EmpWeight := inRec.EmpWeight;
      SELF.POWID := inRec.POWID;
      SELF.POWScore := inRec.POWScore;
      SELF.POWWeight := inRec.POWWeight;
      SELF.ProxID := inRec.ProxID;
      SELF.ProxScore := inRec.ProxScore;
      SELF.ProxWeight := inRec.ProxWeight;
      SELF.SELEID := inRec.SELEID;
      SELF.SELEScore := inRec.SELEScore;
      SELF.SELEWeight := inRec.SELEWeight;	
      SELF.OrgID := inRec.OrgID;
      SELF.OrgScore := inRec.OrgScore;
      SELF.OrgWeight := inRec.OrgWeight;
      SELF.UltID := inRec.UltID;
      SELF.UltScore	:= inRec.UltScore;
      SELF.UltWeight := inRec.UltWeight;
      SELF.company_name := ''; 
      SELF.company_name_data_permits := 0;
      SELF.company_name_method := 0;
      SELF.dt_first_seen := 0;
      SELF.dt_last_seen := 0;
      SELF.weight := 0;
      SELF.DNBDMIRecordOnly := FALSE;
    END; 

  // get linking info through idAppendRoxie 
  ds_BusinessCredit_IDs := 
    PROJECT(BIPV2.IdAppendRoxie(ds_Format2AppInput, inMod.Score_Threshold, reAppend := false).IdsOnly(), 
      xfm_ToBipSlim_Layout(LEFT));

	// Mask unneeded bip ids based on fetch level 
	ds_linkidsMasked := PROJECT(ds_BusinessCredit_IDs+ds_Format2LinkidInput,TRANSFORM(BusinessCredit_Services.Batch_layouts.BipSlim_layout,
															 SELF.UltID := LEFT.UltID,
															 SELF.OrgID := IF(inmod.BIPFetchLevel IN BIPV2.IDconstants.Set_Fetch_Level_OrgID_And_Down,  LEFT.OrgID, 0),
															 SELF.SeleID := IF(inmod.BIPFetchLevel IN BIPV2.IDconstants.Set_Fetch_Level_SELEID_And_Down, LEFT.SeleID, 0),
															 SELF.ProxID := IF(inmod.BIPFetchLevel IN BIPV2.IDconstants.Set_Fetch_Level_ProxID_And_Down, LEFT.ProxID, 0),
															 SELF.EmpID := 0,  // Not used/needed
															 SELF.POWID := 0,  // Not used/needed
															 SELF.DotID := 0,	 // Not used/needed
															 SELF := LEFT));
	
	// Dedup within acctno
	ds_linkidsMaskedDedup := DEDUP(SORT(ds_linkidsMasked,acctno,#expand(BIPV2.IDmacros.mac_ListAllLinkids())),acctno,#expand(BIPV2.IDmacros.mac_ListAllLinkids()));
	
	// Project to xlink_ids2 format and dedup accross all acctno
  ds_linkidsCombined := DEDUP(PROJECT(ds_linkidsMaskedDedup,TRANSFORM(BIPV2.IDlayouts.l_xlink_ids2,SELF := LEFT)),ALL);

	// Get SBFE Best Info, The best has records with proxid of zero which is used when fetch level is u,o or S. 
	// It also contains non zero proxid records which will be used when p(proxid) fetch level is set.
	ds_SBFEBestRecs	:= PROJECT(BIPV2_Best_SBFE.Key_LinkIds().kFetch2(ds_linkidsCombined, inmod.BIPFetchLevel,,inmod.DataPermissionMask)(proxid=0 OR inmod.BIPFetchLevel = BIPV2.IDconstants.Fetch_Level_ProxID),
														TRANSFORM(BusinessCredit_Services.Batch_layouts.BestKeyComb,SELF := LEFT,SELF.source := BusinessCredit_Services.Constants.SBFESrc));
														
	// Get Best Header Info, The best has records with proxid of zero which is used when fetch level is u,o or S. 
	// It also contains non zero proxid records which will be used when p(proxid) fetch level is set.
	ds_BusHeaderRecs_all := PROJECT(BIPV2_Best.Key_LinkIds.kFetch2(ds_linkidsCombined, inmod.BIPFetchLevel)(proxid=0 OR inmod.BIPFetchLevel = BIPV2.IDconstants.Fetch_Level_ProxID),
															    TRANSFORM(BusinessCredit_Services.Batch_layouts.BestKeyComb,SELF := LEFT,SELF.source := BusinessCredit_Services.Constants.HeaderSrc, SELF := []));
	
	// JIRA RR-10621: Conditionallly remove Experian only records 
  ds_BusHeaderRecs := 
    Business_Risk_BIP.fnMac_ExcludeExperian_ChildDataset(ds_BusHeaderRecs_all, 
                                                         company_name[1].sources, 
                                                         source);
    
  // Combine/keep header records needed.
	// If header_included set to true, combine header and sbfe records, dedup on linkids, keep sbfe over header
	// If no header_included, only use sbfe header records.
	ds_BestRecs := IF (inmod.IncludeBusHeader,
											DEDUP(
													SORT(ds_SBFEBestRecs+ds_BusHeaderRecs,#expand(BIPV2.IDmacros.mac_ListAllLinkids()),source)
													,#expand(BIPV2.IDmacros.mac_ListAllLinkids())),
											ds_SBFEBestRecs);
											
  ds_BestRecs_Mask := PROJECT(ds_BestRecs,TRANSFORM(BusinessCredit_Services.Batch_layouts.Batch_Output,
															SELF.UltID := LEFT.UltID,
															SELF.OrgID := IF(inmod.BIPFetchLevel IN BIPV2.IDconstants.Set_Fetch_Level_OrgID_And_Down,  LEFT.OrgID, 0),
															SELF.SeleID := IF(inmod.BIPFetchLevel IN BIPV2.IDconstants.Set_Fetch_Level_SELEID_And_Down, LEFT.SeleID, 0),
															SELF.ProxID := IF(inmod.BIPFetchLevel IN BIPV2.IDconstants.Set_Fetch_Level_ProxID_And_Down, LEFT.ProxID, 0),
															SELF.EmpID := 0,  // Not used/needed
															SELF.POWID := 0,  // Not used/needed
															SELF.DotID := 0,  // Not used/needed
															SELF.best_company_name := LEFT.company_name[1].company_name;
															SELF.best_dt_first_seen := LEFT.company_name[1].dt_first_seen;
															SELF.best_dt_last_seen := LEFT.company_name[1].dt_last_seen;
															SELF.best_prim_range := LEFT.company_address[1].company_prim_range;
															SELF.best_predir := LEFT.company_address[1].company_predir;
															SELF.best_prim_name := LEFT.company_address[1].company_prim_name;
															SELF.best_addr_suffix := LEFT.company_address[1].company_addr_suffix;
															SELF.best_postdir := LEFT.company_address[1].company_postdir;
															SELF.best_unit_desig := LEFT.company_address[1].company_unit_desig;
															SELF.best_sec_range := LEFT.company_address[1].company_sec_range;
															SELF.best_city := LEFT.company_address[1].company_p_city_name;
															SELF.best_state := LEFT.company_address[1].company_st;
															SELF.best_zip := LEFT.company_address[1].company_zip5;
															SELF.best_zip4 := LEFT.company_address[1].company_zip4;
															SELF.best_County := LEFT.company_address[1].county_name;
															SELF.best_phone := LEFT.company_phone[1].company_phone;
															SELF.best_fein := LEFT.company_fein[1].company_fein;
															SELF.best_sic_code := LEFT.sic_code[1].company_sic_code1;
															SELF.best_SIC_Description := Codes.Key_SIC(KEYED(Code = LEFT.sic_code[1].company_sic_code1))[1].Desc;
															SELF.best_naics_code := LEFT.naics_code[1].company_naics_code1;
															SELF.best_NAICS_DESCRIPTION := Codes.Key_NAICS(KEYED(naics_code = LEFT.naics_code[1].company_naics_code1))[1].naics_description;
															SELF.url := LEFT.company_url[1].company_url;
															SELF.orig_Ultid := LEFT.ultid; // Transfer orig ids into output
															SELF.orig_Orgid := LEFT.orgid; 
															SELF.orig_Seleid := LEFT.seleid;
															SELF.orig_proxid := LEFT.proxid;
															SELF := LEFT,
															SELF := []));
	
		// Join to input ids to attach acctno
  ds_final_best := JOIN(ds_linkidsMaskedDedup,ds_BestRecs_Mask,
												BIPV2.IDmacros.mac_JoinAllLinkids(),
												TRANSFORM(BusinessCredit_Services.Batch_layouts.Batch_Output,
																	SELF := LEFT,
																	SELF := RIGHT));
	
	// Restrict max records from search per acctno
	ds_bestLinkidsPerAcct := UNGROUP(TOPN(GROUP(SORT(ds_final_best,acctno,source,-weight,RECORD),acctno),inMod.MaxSearchResultsPerAcct,acctno));
	
  // TOPN recs to kfetch layout for gleaning sbfe data
  ds_bestLinkidsPerAcct_kfetchLayout := PROJECT(ds_bestLinkidsPerAcct,TRANSFORM(BIPV2.IDlayouts.l_xlink_ids2,SELF := LEFT)); 
  
  //Get SBFE Header Records, NOTE only keep Account Base Records
	ds_SBFEAcctRecs	:= Business_Credit.Key_LinkIds().kFetch2(ds_bestLinkidsPerAcct_kfetchLayout, mod_access, inmod.BIPFetchLevel)(record_type='AB');

	ds_TradeRecs := BusinessCredit_Services.Batch_Functions.getTradelineInfo(ds_SBFEAcctRecs,inMod);
	
	ds_CreditScore := BusinessCredit_Services.Batch_Functions.getCreditScore(ds_bestLinkidsPerAcct_kfetchLayout,inMod);
	
  // Add trade info to output
  ds_final_trade := JOIN(ds_bestLinkidsPerAcct,ds_TradeRecs,
												BIPV2.IDmacros.mac_JoinAllLinkids(),
												TRANSFORM(BusinessCredit_Services.Batch_layouts.Batch_Output,
															SELF := RIGHT,
															SELF := LEFT,
															SELF := []),
												LEFT OUTER);
	
	// Add historical credit scores to output
	ds_final_score := JOIN(ds_final_trade,ds_CreditScore,
												BIPV2.IDmacros.mac_JoinAllLinkids(),
												TRANSFORM(BusinessCredit_Services.Batch_layouts.Batch_Output,
															SELF := RIGHT,
															SELF := LEFT,
															SELF := []),
												LEFT OUTER);
	
	ds_final := PROJECT(ds_final_score,TRANSFORM(BusinessCredit_Services.Batch_layouts.Batch_Output_Final,
															SELF.Ultid := LEFT.orig_ultid,   // Transfer orig ids into output
															SELF.Orgid := LEFT.orig_orgid,   
															SELF.Seleid := LEFT.orig_seleid,
															SELF.proxid := LEFT.orig_proxid,
															SELF := LEFT,
															SELF := []));
															
	// Restrict max records per acctno
	ds_final_results := UNGROUP(TOPN(GROUP(SORT(ds_final,acctno,-weight,-cycle_end_date,RECORD),acctno),inMod.MaxResultsPerAcct,acctno));

	RETURN(ds_final_results);
END;