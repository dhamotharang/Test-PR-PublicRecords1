IMPORT AutoStandardI, BIPV2, Doxie, Inquiry_AccLogs;

EXPORT Batch_Records( DATASET(Inquiry_Services.Layouts.Batch_Input_Processed) ds_BatchIn,
															Inquiry_Services.Iparam.BatchParams inMod) := FUNCTION

    mod_access := PROJECT(inMod, Doxie.IDataAccess);
		// Get linkids from search criteria

		// Format to BIP search layout
		BIPV2.IDfunctions.rec_SearchInput tFormat2SearchInput(Inquiry_Services.Layouts.Batch_Input_Processed pInput) := TRANSFORM
			SELF.company_name     := pInput.comp_name;
			SELF.city             := pInput.p_city_name;
			SELF.state            := pInput.st;
			SELF.zip5             := pInput.z5;
			SELF.phone10          := pInput.workphone;
			SELF.inSeleid					:= (STRING) pInput.SeleID;
			SELF.zip_radius_miles := IF ((INTEGER)pInput.mileradius > Inquiry_Services.Constants.BIP_MAX_MILERADIUS, Inquiry_Services.Constants.BIP_MAX_MILERADIUS, (INTEGER)pInput.mileradius);
			SELF.Hsort            := TRUE; // this boolean only affect the proxid level returns not SELEID level.
			SELF                  := pInput;
			SELF                  := [];
		END;

		// Seperate bipid input records from search records, records with ultid id will assume no search
		ds_Format2SearchInput := PROJECT(ds_batchIn(ultid = 0),tFormat2SearchInput(LEFT));

		// Get the linkids from the search criteria
		ds_InqSearchIDs := PROJECT(BIPV2.IDfunctions.fn_IndexedSearchForXLinkIDs(ds_Format2SearchInput).uid_results_w_acct,
																		TRANSFORM(Inquiry_Services.Layouts.SearchSlim_layout,
																				 SELF.UltID := LEFT.UltID,
																				 SELF.OrgID := IF(inmod.BIPFetchLevel IN BIPV2.IDconstants.Set_Fetch_Level_OrgID_And_Down,  LEFT.OrgID, 0),
																				 SELF.SeleID := IF(inmod.BIPFetchLevel IN BIPV2.IDconstants.Set_Fetch_Level_SELEID_And_Down, LEFT.SeleID, 0),
																				 SELF.ProxID := IF(inmod.BIPFetchLevel IN BIPV2.IDconstants.Set_Fetch_Level_ProxID_And_Down, LEFT.ProxID, 0),
																				 SELF.PowID := IF(inmod.BIPFetchLevel IN BIPV2.IDconstants.Set_Fetch_Level_PowID_And_Down, LEFT.PowID, 0),
																				 SELF := LEFT,
																				 SELF := []));

		ds_InqSearchIDs_Dedup := DEDUP(SORT(ds_InqSearchIDs,acctno,#expand(BIPV2.IDmacros.mac_ListAllLinkids()),-weight),acctno,#expand(BIPV2.IDmacros.mac_ListAllLinkids()));

		// Search via business linkids
		ds_linkIds := PROJECT(ds_BatchIn(ultid !=0),BIPV2.IDlayouts.l_xlink_ids2) +
									PROJECT(ds_InqSearchIDs_Dedup,BIPV2.IDlayouts.l_xlink_ids2);


		// Kfetch to get Inquiry records by linkid.
		ds_from_linkids := PROJECT(Inquiry_AccLogs.Key_Inquiry_LinkIds.kFetch2(ds_linkIds,inMod.BIPFetchLevel,,Inquiry_Services.Constants.INQUIRY_LIMIT),
																								TRANSFORM(Inquiry_Services.Layouts.Batch_Raw_Linkid,
																													SELF.inquiry_src := Inquiry_Services.Constants.INQ_HISTORY,
																													SELF := LEFT));

		ds_from_linkidsUpd := PROJECT(Inquiry_AccLogs.Key_Inquiry_LinkIds_Update.kFetch2(ds_linkIds, mod_access, inMod.BIPFetchLevel, ,Inquiry_Services.Constants.INQUIRY_LIMIT),
																								TRANSFORM(Inquiry_Services.Layouts.Batch_Raw_Linkid,
																													SELF.inquiry_src := Inquiry_Services.Constants.INQ_UPDATE,
																													SELF := LEFT));

		dsLinkidsRaw := PROJECT(ds_from_linkids+ds_from_linkidsUpd,Inquiry_Services.Transforms.xfrom_toBatchRaw(LEFT));

		// inquiry date time, transaction ID and sequence number uniquely identify an inquiry record, use to dedup accross
		// history and update file records, if there are duplicates the history record takes precedence.
		dsLinkidsDedup := DEDUP(SORT(dsLinkidsRaw,-inquiry_dateTime,inquiry_transactionID,inquiry_seqNum,inquiry_src),inquiry_dateTime,inquiry_transactionID,inquiry_seqNum);

		// Add back acctno's.
		// Two separate joins, one to add acctno's for the results from the batch input records with linkid's passed
		// and the second for batch input records with name/address
		fromLinkids := JOIN(dsLinkidsDedup,ds_BatchIn(ultid !=0),
													BIPV2.IDmacros.mac_JoinLinkids(inMod.BIPFetchLevel),
															TRANSFORM(Inquiry_Services.Layouts.Batch_Raw_Acct,
																						SELF.acctno := RIGHT.acctno,
																						SELF := LEFT,
																						SELF := []));

		fromSearch := JOIN(dsLinkidsDedup,ds_InqSearchIDs_Dedup,
													BIPV2.IDmacros.mac_JoinLinkids(inMod.BIPFetchLevel),
															TRANSFORM(Inquiry_Services.Layouts.Batch_Raw_Acct,
																						SELF.acctno := RIGHT.acctno,
																						SELF.weight := RIGHT.weight,
																						SELF := LEFT));

		// Sort and keep max number records per acctno.
		ds_linkidsPerAcct := UNGROUP(TOPN(GROUP(SORT(fromLinkids+fromSearch,acctno,-weight,-inquiry_datetime,RECORD),acctno),inMod.MaxResultsPerAcct,acctno));

		final_results := PROJECT(ds_linkidsPerAcct,TRANSFORM(Inquiry_Services.Layouts.Batch_Output,SELF := LEFT, SELF := []));

	  RETURN(final_results);

END;