IMPORT BIPV2, SAM;

EXPORT Batch_Records( DATASET(SAM_Services.Layouts.Batch_Input_Processed) ds_BatchIn,
															SAM_Services.Iparam.BatchParams inMod) := FUNCTION
															
		// Get linkids from search criteria
		
		// Format to BIP search layout
		BIPV2.IDfunctions.rec_SearchInput tFormat2SearchInput(SAM_Services.Layouts.Batch_Input_Processed pInput) := TRANSFORM
			SELF.company_name     := pInput.comp_name;
			SELF.city             := pInput.p_city_name;
			SELF.state            := pInput.st;
			SELF.zip5             := pInput.z5;
			SELF.phone10          := pInput.workphone;
			SELF.inSeleid					:= (STRING) pInput.SeleID;
			SELF.zip_radius_miles := IF ((INTEGER)pInput.mileradius > SAM_Services.Constants.BIP_MAX_MILERADIUS, SAM_Services.Constants.BIP_MAX_MILERADIUS, (INTEGER)pInput.mileradius); 
			SELF.Hsort            := TRUE; // this boolean only affect the proxid level returns not SELEID level.		
			SELF                  := pInput;
			SELF                  := [];
		END;	
  
		// Seperate bipid input records from search records, records with ultid id will assume no search
		ds_Format2SearchInput := PROJECT(ds_batchIn(ultid = 0),tFormat2SearchInput(LEFT));
		
		// Get the linkids from the search criteria
		ds_SAMSearchIDs := PROJECT(BIPV2.IDfunctions.fn_IndexedSearchForXLinkIDs(ds_Format2SearchInput).uid_results_w_acct,	
																		TRANSFORM(SAM_Services.Layouts.SearchSlim_layout,
																				 SELF.UltID := LEFT.UltID,
																				 SELF.OrgID := IF(inmod.BIPFetchLevel IN BIPV2.IDconstants.Set_Fetch_Level_OrgID_And_Down,  LEFT.OrgID, 0),
																				 SELF.SeleID := IF(inmod.BIPFetchLevel IN BIPV2.IDconstants.Set_Fetch_Level_SELEID_And_Down, LEFT.SeleID, 0),
																				 SELF.ProxID := IF(inmod.BIPFetchLevel IN BIPV2.IDconstants.Set_Fetch_Level_ProxID_And_Down, LEFT.ProxID, 0),
																				 SELF.PowID := IF(inmod.BIPFetchLevel IN BIPV2.IDconstants.Set_Fetch_Level_PowID_And_Down, LEFT.PowID, 0),
																				 SELF := LEFT,
																				 SELF := []));
		
		ds_SAMSearchIDs_Dedup := DEDUP(SORT(ds_SAMSearchIDs,#expand(BIPV2.IDmacros.mac_ListAllLinkids()),acctno,-weight),#expand(BIPV2.IDmacros.mac_ListAllLinkids()),acctno);
		
		// Search via business linkids
		ds_linkIds := PROJECT(ds_BatchIn(ultid !=0),BIPV2.IDlayouts.l_xlink_ids2) + 
									PROJECT(ds_SAMSearchIDs_Dedup,BIPV2.IDlayouts.l_xlink_ids2);
		
		// Kfetch to get SAM/ Govt Debarred records
		ds_from_linkids := PROJECT(SAM.key_linkID.kFetch2(ds_linkIds,inMod.BIPFetchLevel),
															 TRANSFORM(SAM_Services.Layouts.Batch_Raw,
																					SELF := LEFT,
																					SELF := []));
		// Add back acctno's. 
		// Two separate joins, one to add acctno's for the results from the batch input records with linkid's passed
		// and the second for batch input records with name/address
		fromLinkids := JOIN(ds_from_linkids,ds_BatchIn(ultid !=0),
													BIPV2.IDmacros.mac_JoinLinkids(inMod.BIPFetchLevel),
															TRANSFORM(SAM_Services.Layouts.Batch_Raw_Acct,
																						SELF.acctno := RIGHT.acctno,
																						SELF := LEFT,
																						SELF := []));
																						
		fromSearch := JOIN(ds_from_linkids,ds_SAMSearchIDs_Dedup,
													BIPV2.IDmacros.mac_JoinLinkids(inMod.BIPFetchLevel),
															TRANSFORM(SAM_Services.Layouts.Batch_Raw_Acct,
																						SELF.acctno := RIGHT.acctno,
																						SELF.weight := RIGHT.weight,
																						SELF := LEFT));
		
		// Sort and keep max number records per acctno.
		ds_linkidsPerAcct := UNGROUP(TOPN(GROUP(SORT(fromLinkids+fromSearch,acctno,-weight,-activedate,RECORD),acctno),inMod.MaxResultsPerAcct,acctno));

		final_results := PROJECT(ds_linkidsPerAcct,TRANSFORM(SAM_Services.Layouts.Batch_Output,SELF := LEFT, SELF := []));

	  return(final_results);
	 
END;