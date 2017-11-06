IMPORT Address, ADVO, BIPV2, BizLinkFull, Business_Risk_BIP, CellPhone, Gong, Risk_Indicators, RiskWise, UT, Corp2, MDR, LN_PropertyV2, DueDiligence;

EXPORT Boca_Shell_BIP_Header(grouped DATASET(Risk_Indicators.Layout_Boca_Shell) Shell, 
												 Business_Risk_BIP.LIB_Business_Shell_LIBIN Options,
												 BIPV2.mod_sources.iParams linkingOptions,
												 SET OF STRING2 AllowedSourcesSet, 
												 boolean isFCRA) := FUNCTION

	// ------- Get FEIN Matches across all businesses ------------- //
	For_FEIN_Search := PROJECT(UNGROUP(Shell), TRANSFORM(BIPV2.IDFunctions.rec_SearchInput,
				SELF.acctno 			:= (string)LEFT.Seq,
				SELF.contact_did 	:= LEFT.DID,
				SELF := []));
				
	FEIN_results_w_acct := PROJECT(BIPV2.IDfunctions.fn_IndexedSearchForXLinkIDs(For_FEIN_Search).uid_results_w_acct, 
																			TRANSFORM(BIPV2.IDlayouts.l_xlink_ids2,
																								SELF.UniqueID := (UNSIGNED)LEFT.acctno,
																								SELF.UltID := LEFT.UltID,
																								SELF.OrgID := LEFT.OrgID,
																								SELF.SeleID := LEFT.SeleID,
																								SELF.ProxID := LEFT.ProxID,
																								SELF.PowID := LEFT.PowID,
																								SELF := []));

																					
	UniqueRawFEINMatches := DEDUP(SORT(FEIN_results_w_acct, UniqueID, UltID, OrgID, SeleID, ProxID, PowID),	UniqueID, UltID, OrgID, SeleID, ProxID, PowID);
	
	
	BusinessHeaderRaw := BIPV2.Key_BH_Linking_Ids.kFetch2(UniqueRawFEINMatches,
																						 Business_Risk_BIP.Common.SetLinkSearchLevel(Business_Risk_BIP.Constants.LinkSearch.SeleID), 
																							0, /*ScoreThreshold --> 0 = Give me everything*/
																							linkingOptions,
																							Business_Risk_BIP.Constants.Limit_BusHeader,
																							FALSE, /* dnbFullRemove */
																							TRUE, /* bypassContactSuppression */
																							Options.KeepLargeBusinesses);
											
	// Add back our Seq numbers
	BusinessHeaderSeq := JOIN(BusinessHeaderRaw, Shell, LEFT.UniqueID = RIGHT.Seq, TRANSFORM({RECORDOF(LEFT), UNSIGNED4 Seq, UNSIGNED3 HistoryDate, UNSIGNED6 HistoryDateTime, UNSIGNED1 HistoryDateLength},
										SELF.Seq := RIGHT.Seq;
										SELF.HistoryDate := RIGHT.HistoryDate; 
										SELF.HistoryDateTime := 0; 
										SELF.HistoryDateLength := 0;
										SELF := LEFT), 
								FEW); 
	

	// Filter out records after our history date and sources that aren't allowed - pass in AllowedSources to possibly turn on DNB DMI data
	BusinessHeader := GROUP(Business_Risk_BIP.Common.FilterRecords(BusinessHeaderSeq, dt_first_seen, dt_vendor_first_reported, Source, AllowedSourcesSet), Seq);

	// Tack on new fields to the end of the layout
	layoutExpanded := record
		recordof(BusinessHeader);
		integer 	bus_seleids_peradl := 0;
		integer 	bus_gold_seleids_peradl := 0;
		integer 	bus_active_seleids_peradl := 0;
		integer 	bus_inactive_seleids_peradl := 0;
		integer 	bus_defunct_seleids_peradl := 0;
		integer 	bus_gold_seleid_first_seen := 0;
		integer 	bus_header_first_seen := 0;
		integer 	bus_header_last_seen := 0;
		integer 	bus_header_build_date := 0;
		integer 	bus_SOS_filings_peradl := 0;
		integer 	bus_active_SOS_filings_peradl := 0;
	end;
	
	BusinessHeaderExpanded := project(BusinessHeader, 
		transform(layoutExpanded,
							defaultDateValue										:= '0';	//if first seen date or last seen date is not valid, set it to 0
							DateFirstSeen 											:= (integer)Business_Risk_BIP.Common.checkInvalidDate((STRING)left.dt_first_Seen, defaultDateValue, left.HistoryDate);
							DateLastSeen 												:= (integer)Business_Risk_BIP.Common.checkInvalidDate((STRING)left.dt_last_Seen, defaultDateValue, left.HistoryDate);
							gold_status													:= left.sele_gold = 'G';
							active_status												:= left.sele_seg in ['3','2','1','T','E'] and not gold_status;
							inactive_status											:= left.sele_seg in ['I'] and not gold_status;
							defunct_status											:= left.sele_seg in ['D'] and not gold_status;
							self.bus_seleids_peradl							:= 1; 
							self.bus_gold_seleids_peradl				:= if(gold_status, 1, 0);
							self.bus_active_seleids_peradl			:= if(active_status, 1, 0); 
							self.bus_inactive_seleids_peradl		:= if(inactive_status, 1, 0); 
							self.bus_defunct_seleids_peradl			:= if(defunct_status, 1, 0); 
							// self.bus_other_seleids_peradl				:= if(~gold_status and ~active_status and ~inactive_status and ~defunct_status, 1, 0); 
							self.bus_gold_seleid_first_seen			:= if(gold_status, DateFirstSeen, 0); 
							self.bus_header_first_seen					:= DateFirstSeen; 
							self.bus_header_last_seen						:= DateLastSeen;
							self.bus_header_build_date					:= 0; 
							self.bus_SOS_filings_peradl					:= 0; 
							self.bus_active_SOS_filings_peradl	:= 0; 
							self																:= left));
	
		
	// Sort business header records by SeleID
	SortedBusinessHeader := SORT(BusinessHeaderExpanded, UniqueID, SeleID);
	
	// Rollup business header records to calculate counts and dates within unique SeleID
  layoutExpanded rollBusinessHeader(layoutExpanded le, layoutExpanded ri) := transform
		same_SeleID													:= le.SeleID = ri.SeleID;
		self.bus_seleids_peradl 						:= le.bus_seleids_peradl + if(~same_SeleID, ri.bus_seleids_peradl, 0);
		self.bus_gold_seleids_peradl				:= le.bus_gold_seleids_peradl + if(~same_SeleID, ri.bus_gold_seleids_peradl, 0);
		self.bus_active_seleids_peradl			:= le.bus_active_seleids_peradl + if(~same_SeleID, ri.bus_active_seleids_peradl, 0);
		self.bus_inactive_seleids_peradl		:= le.bus_inactive_seleids_peradl + if(~same_SeleID, ri.bus_inactive_seleids_peradl, 0);
		self.bus_defunct_seleids_peradl			:= le.bus_defunct_seleids_peradl + if(~same_SeleID, ri.bus_defunct_seleids_peradl, 0);
		self.bus_gold_seleid_first_seen			:= map(le.bus_gold_seleid_first_seen = 0	=> ri.bus_gold_seleid_first_seen,
																							 ri.bus_gold_seleid_first_seen = 0	=> le.bus_gold_seleid_first_seen,
																																										 min(le.bus_gold_seleid_first_seen,ri.bus_gold_seleid_first_seen));
		self.bus_header_first_seen					:= map(le.bus_header_first_seen = 0	=> ri.bus_header_first_seen,
																							 ri.bus_header_first_seen = 0	=> le.bus_header_first_seen,
																																										 min(le.bus_header_first_seen,ri.bus_header_first_seen));
		self.bus_header_last_seen						:= map(le.bus_header_last_seen = 0	=> ri.bus_header_last_seen,
																							 ri.bus_header_last_seen = 0	=> le.bus_header_last_seen,
																																										 max(le.bus_header_last_seen,ri.bus_header_last_seen));
		self.bus_header_build_date 					:= 0;
		self.bus_SOS_filings_peradl					:= 0;
		self.bus_active_SOS_filings_peradl	:= 0;
		self.SeleID 												:= ri.SeleID;
		self																:= le;
	end;
	
  RolledBusinessHeader := rollup(SortedBusinessHeader, rollBusinessHeader(left,right), UniqueID);

	//Get Business header build date
	BHBuildDate := Risk_Indicators.get_Build_date('bheader_build_version');
	
	risk_indicators.Layout_Boca_Shell addBusinessHeader(risk_indicators.Layout_Boca_Shell le, RolledBusinessHeader ri) := TRANSFORM
		noHit																					:= le.seq <> ri.UniqueID;
		noDID																					:= le.DID = 0;
		SELF.BIP_Header.bus_seleids_peradl     				:= map(noDID															=> -1,
																												 noHit															=> -2,
																																															 ri.bus_seleids_peradl);
		SELF.BIP_Header.bus_gold_seleids_peradl     	:= map(noDID															=> -1,
																												 noHit															=> -2,
																																															 ri.bus_gold_seleids_peradl);
		SELF.BIP_Header.bus_active_seleids_peradl     := map(noDID															=> -1,
																												 noHit															=> -2,
																																															 ri.bus_active_seleids_peradl);
		SELF.BIP_Header.bus_inactive_seleids_peradl   := map(noDID															=> -1,
																												 noHit															=> -2,
																																															 ri.bus_inactive_seleids_peradl);
		SELF.BIP_Header.bus_defunct_seleids_peradl    := map(noDID															=> -1,
																												 noHit															=> -2,
																																															 ri.bus_defunct_seleids_peradl);
		SELF.BIP_Header.bus_gold_seleid_first_seen    := map(noDID															=> -1,
																												 noHit															=> -2,
																												 ri.bus_gold_seleid_first_seen = 0	=> -3,
																																															 ri.bus_gold_seleid_first_seen);
		SELF.BIP_Header.bus_header_first_seen    			:= map(noDID															=> -1,
																												 noHit															=> -2,
																												 ri.bus_header_first_seen = 0				=> -3,
																																															 ri.bus_header_first_seen);
		SELF.BIP_Header.bus_header_last_seen     			:= map(noDID															=> -1,
																												 noHit															=> -2,
																												 ri.bus_header_last_seen = 0				=> -3,
																																															 ri.bus_header_last_seen);
		SELF.BIP_Header.bus_header_build_date     		:= map(noDID															=> -1,
																												 noHit															=> -2,
																																															 (integer)BHBuildDate);
		SELF.BIP_Header.bus_SOS_filings_peradl     		:= map(noDID															=> -1,
																												 noHit															=> -2,
																																															 ri.bus_SOS_filings_peradl);
		SELF.BIP_Header.bus_active_SOS_filings_peradl := map(noDID															=> -1,
																												 noHit															=> -2,
																																															 ri.bus_active_SOS_filings_peradl);
		SELF 																					:= le;
	END;
	
	WithBusinessHeader := JOIN(Shell, RolledBusinessHeader, LEFT.seq=RIGHT.UniqueID, addBusinessHeader(LEFT,RIGHT), LEFT OUTER);

	LinkIDs := DEDUP(SORT(UniqueRawFEINMatches, UniqueID, SeleID),	UniqueID, SeleID);

	//get SOS filings
	CorpFilings_raw := Corp2.Key_LinkIDs.Corp.kfetch2(LinkIDs,
	                                         Business_Risk_BIP.Common.SetLinkSearchLevel(Options.LinkSearchLevel),
	                                         0, 
																					 Business_Risk_BIP.Constants.Limit_Default,
																					 Options.KeepLargeBusinesses
													);

	// Add back our Seq numbers.
	CorpFilings_Seq := JOIN(CorpFilings_raw, Shell, LEFT.UniqueID = RIGHT.Seq, TRANSFORM({RECORDOF(LEFT), UNSIGNED4 Seq, UNSIGNED3 HistoryDate, UNSIGNED6 HistoryDateTime, UNSIGNED1 HistoryDateLength, integer bus_SOS_filings_peradl, integer bus_active_SOS_filings_peradl},
										SELF.Seq := RIGHT.Seq;
										SELF.HistoryDate := RIGHT.HistoryDate; 
										SELF.HistoryDateTime := 0; 
										SELF.HistoryDateLength := 0;
										SELF.bus_SOS_filings_peradl := 1;
										SELF.bus_active_SOS_filings_peradl := if(Business_Risk_BIP.Common.is_ActiveCorp(LEFT.record_type, LEFT.corp_status_cd, LEFT.corp_status_desc), 1, 0);
										SELF := LEFT), 
								FEW); 
	
	// Figure out if the kFetch was successful
	kFetchErrorCodes := Business_Risk_BIP.Common.GrabFetchErrorCode(CorpFilings_Seq);

  CorpFilings_withSrcCode := 
  PROJECT(
    CorpFilings_seq,
    TRANSFORM( RECORDOF(CorpFilings_seq), 
      SELF.corp_src_type := MDR.sourceTools.fCorpV2( LEFT.corp_key, LEFT.corp_state_origin ),
      SELF := LEFT
    ) );
  
	// Filter out records after our history date.
	CorpFilings_recs := Business_Risk_BIP.Common.FilterRecords(CorpFilings_withSrcCode, dt_first_seen, dt_vendor_first_reported, corp_src_type, AllowedSourcesSet);

	// Sort corp filings records by SeleID and Corp_Key
	SortedCorpFilings := SORT(CorpFilings_recs, UniqueID, SeleID, Corp_key);
	
	// Rollup corp filings records to calculate counts and dates within unique SeleID and unique Corp Key
  RECORDOF(SortedCorpFilings) rollCorpFilings(SortedCorpFilings le, SortedCorpFilings ri) := transform
		same_Corp_Key												:= le.Corp_Key = ri.Corp_Key;
		self.bus_SOS_filings_peradl					:= le.bus_SOS_filings_peradl + if(~same_Corp_Key, ri.bus_SOS_filings_peradl, 0);
		self.bus_active_SOS_filings_peradl	:= le.bus_active_SOS_filings_peradl + if(~same_Corp_Key, ri.bus_active_SOS_filings_peradl, 0);
		self.UniqueID												:= ri.UniqueID;
		self.SeleID 												:= ri.SeleID;
		self.Corp_Key												:= ri.Corp_Key;
		self																:= le;
	end;
	
  RolledCorpFilings := rollup(SortedCorpFilings, rollCorpFilings(left,right), UniqueID, SeleID);

  RECORDOF(SortedCorpFilings) rollSOSFilings(RolledCorpFilings le, RolledCorpFilings ri) := transform
		self.bus_SOS_filings_peradl					:= le.bus_SOS_filings_peradl + ri.bus_SOS_filings_peradl;
		self.bus_active_SOS_filings_peradl	:= le.bus_active_SOS_filings_peradl + ri.bus_active_SOS_filings_peradl;
		self.UniqueID												:= ri.UniqueID;
		self.SeleID 												:= ri.SeleID;
		self.Corp_Key												:= ri.Corp_Key;
		self																:= le;
	end;
	
  RolledSOSFilings := rollup(RolledCorpFilings, rollSOSFilings(left,right), UniqueID);

	risk_indicators.Layout_Boca_Shell addSOSFilings(risk_indicators.Layout_Boca_Shell le, RolledSOSFilings ri) := TRANSFORM
		noHit																					:= le.seq <> ri.UniqueID;
		noDID																					:= le.DID = 0;
		SELF.BIP_Header.bus_SOS_filings_peradl     		:= map(noDID															=> -1,
																												 noHit															=> -2,
																																															 ri.bus_SOS_filings_peradl);
		SELF.BIP_Header.bus_active_SOS_filings_peradl := map(noDID															=> -1,
																												 noHit															=> -2,
																																															 ri.bus_active_SOS_filings_peradl);
		SELF 																					:= le;
	END;
	
	WithSOSFilings := JOIN(WithBusinessHeader, RolledSOSFilings, LEFT.seq=RIGHT.UniqueID, addSOSFilings(LEFT,RIGHT), LEFT OUTER);
	//for FCRA these fields are not allowed so just set to -1 if no DID, else set to -2
	FCRAdefaults := project(ungroup(shell), 
		transform(risk_indicators.Layout_Boca_Shell, 
			self.BIP_Header.bus_seleids_peradl 						:= if(left.DID = 0, -1, -2);
			self.BIP_Header.bus_gold_seleids_peradl				:= if(left.DID = 0, -1, -2);
			self.BIP_Header.bus_active_seleids_peradl			:= if(left.DID = 0, -1, -2);
			self.BIP_Header.bus_inactive_seleids_peradl		:= if(left.DID = 0, -1, -2);
			self.BIP_Header.bus_defunct_seleids_peradl		:= if(left.DID = 0, -1, -2);
			self.BIP_Header.bus_gold_seleid_first_seen		:= if(left.DID = 0, -1, -2);
			self.BIP_Header.bus_header_first_seen					:= if(left.DID = 0, -1, -2);
			self.BIP_Header.bus_header_last_seen					:= if(left.DID = 0, -1, -2);
			self.BIP_Header.bus_header_build_date 				:= if(left.DID = 0, -1, -2);
			self.BIP_Header.bus_SOS_filings_peradl				:= if(left.DID = 0, -1, -2);
			self.BIP_Header.bus_active_SOS_filings_peradl	:= if(left.DID = 0, -1, -2);
			self := left));
		
finalBIP := if(isFCRA, FCRAdefaults, WithSOSFilings);	

	// *********************
	//   DEBUGGING OUTPUTS
	// *********************
	// OUTPUT(CHOOSEN(CorpFilings_raw, 33), NAMED('CorpFilings_raw'));	
	// OUTPUT(CHOOSEN(CorpFilings_Seq, 33), NAMED('CorpFilings_Seq'));	
	// OUTPUT(CHOOSEN(kFetchErrorCodes, 33), NAMED('kFetchErrorCodes'));	
	// OUTPUT(CHOOSEN(CorpFilings_withSrcCode, 33), NAMED('CorpFilings_withSrcCode'));	
	// OUTPUT(CHOOSEN(CorpFilings_recs, 33), NAMED('CorpFilings_recs'));	
	// OUTPUT(CHOOSEN(SortedCorpFilings, 33), NAMED('SortedCorpFilings'));	
	// OUTPUT(CHOOSEN(RolledCorpFilings, 33), NAMED('RolledCorpFilings'));	
	// OUTPUT(CHOOSEN(RolledSOSFilings, 33), NAMED('RolledSOSFilings'));	
	// OUTPUT(CHOOSEN(WithSOSFilings, 33), NAMED('WithSOSFilings'));	

	RETURN FinalBIP;
	
END;													