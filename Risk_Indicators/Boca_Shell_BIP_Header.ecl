IMPORT Address, BIPV2, Business_Risk_BIP, Doxie, Risk_Indicators, Corp2, MDR,
  DID_add, UCCv2, Inquiry_AccLogs, TopBusiness_Services;

EXPORT Boca_Shell_BIP_Header(grouped DATASET(Risk_Indicators.Layout_Boca_Shell) Shell,
												 Business_Risk_BIP.LIB_Business_Shell_LIBIN Options,
												 BIPV2.mod_sources.iParams linkingOptions,
												 SET OF STRING2 AllowedSourcesSet,
												 boolean isFCRA,
                         Doxie.IDataAccess mod_access,
												 unsigned1 BSversion=1) := FUNCTION

string2 stringZero  := '0';
string2 stringNeg1  := '-1';
string2 stringNeg2  := '-2';
string2 stringNeg3  := '-3';
integer integerZero := 0;
integer integerOne  := 1;
integer integerNeg1 := -1;
integer integerNeg2 := -2;
integer integerNeg3 := -3;
string6 ninesDate   := '999999';

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


	BusinessHeaderRaw1 := BIPV2.Key_BH_Linking_Ids.kFetch2(UniqueRawFEINMatches,
																						 Business_Risk_BIP.Common.SetLinkSearchLevel(Business_Risk_BIP.Constants.LinkSearch.SeleID),
																							integerZero,
																							linkingOptions,
																							Business_Risk_BIP.Constants.Limit_BusHeader,
																							FALSE,
																							TRUE,
																							BIPV2.IDconstants.JoinTypes.LimitTransformJoin);

	// clean up the business header before doing anything else
	Business_Risk_BIP.Common.mac_slim_header(BusinessHeaderRaw1, BusinessHeaderRaw);

	// Add back our Seq numbers
	BusinessHeaderSeq := JOIN(BusinessHeaderRaw, Shell, LEFT.UniqueID = RIGHT.Seq, TRANSFORM({RECORDOF(LEFT), UNSIGNED4 Seq, UNSIGNED3 HistoryDate, UNSIGNED6 HistoryDateTime, UNSIGNED1 HistoryDateLength},
										SELF.Seq := RIGHT.Seq;
										SELF.HistoryDate := RIGHT.HistoryDate;
										SELF.HistoryDateTime := (integer)RIGHT.HistoryDateTimeStamp[1..8];
										SELF.HistoryDateLength := LENGTH( TRIM((STRING)RIGHT.HistoryDateTimeStamp[1..8]) );
										SELF := LEFT),
								FEW);


	// Filter out records after our history date and sources that aren't allowed - pass in AllowedSources to possibly turn on DNB DMI data
	BusinessHeader := GROUP(Business_Risk_BIP.Common.FilterRecords3(BusinessHeaderSeq, dt_first_seen, dt_vendor_first_reported, Source, AllowedSourcesSet), Seq);

	// Tack on new fields to the end of the layout
	layoutExpanded := record
		recordof(BusinessHeader);
		integer 	bus_seleids_peradl := integerZero;
		integer 	bus_gold_seleids_peradl := integerZero;
		integer 	bus_active_seleids_peradl := integerZero;
		integer 	bus_inactive_seleids_peradl := integerZero;
		integer 	bus_defunct_seleids_peradl := integerZero;
		integer 	bus_gold_seleid_first_seen := integerZero;
		integer 	bus_header_first_seen := integerZero;
		integer 	bus_header_last_seen := integerZero;
		integer 	bus_header_build_date := integerZero;
		integer 	bus_SOS_filings_peradl := integerZero;
		integer 	bus_active_SOS_filings_peradl := integerZero;
	end;

	BusinessHeaderExpanded := project(BusinessHeader,
		transform(layoutExpanded,
							defaultDateValue										:= stringZero;	//if first seen date or last seen date is not valid, set it to 0
							DateFirstSeen 											:= (integer)Business_Risk_BIP.Common.checkInvalidDate((STRING)left.dt_first_Seen, defaultDateValue, left.HistoryDate);
							DateLastSeen 												:= (integer)Business_Risk_BIP.Common.checkInvalidDate((STRING)left.dt_last_Seen, defaultDateValue, left.HistoryDate);
							gold_status													:= left.sele_gold = 'G';
							active_status												:= left.sele_seg in ['3','2','1','T','E'] and not gold_status;
							inactive_status											:= left.sele_seg in ['I'] and not gold_status;
							defunct_status											:= left.sele_seg in ['D'] and not gold_status;
							self.bus_seleids_peradl							:= 1;
							self.bus_gold_seleids_peradl				:= if(gold_status, 1, integerZero);
							self.bus_active_seleids_peradl			:= if(active_status, 1, integerZero);
							self.bus_inactive_seleids_peradl		:= if(inactive_status, 1, integerZero);
							self.bus_defunct_seleids_peradl			:= if(defunct_status, 1, integerZero);
							self.bus_gold_seleid_first_seen			:= if(gold_status, DateFirstSeen, integerZero);
							self.bus_header_first_seen					:= DateFirstSeen;
							self.bus_header_last_seen						:= DateLastSeen;
							self.bus_header_build_date					:= integerZero;
							self.bus_SOS_filings_peradl					:= integerZero;
							self.bus_active_SOS_filings_peradl	:= integerZero;
							self																:= left));


	// Sort business header records by SeleID
		SortedBusinessHeader := SORT(UNGROUP(BusinessHeaderExpanded), UniqueID, SeleID);

	// Rollup business header records to calculate counts and dates within unique SeleID
  layoutExpanded rollBusinessHeader(layoutExpanded le, layoutExpanded ri) := transform
		same_SeleID													:= le.SeleID = ri.SeleID;
		self.bus_seleids_peradl 						:= le.bus_seleids_peradl + if(~same_SeleID, ri.bus_seleids_peradl, integerZero);
		self.bus_gold_seleids_peradl				:= le.bus_gold_seleids_peradl + if(~same_SeleID, ri.bus_gold_seleids_peradl, integerZero);
		self.bus_active_seleids_peradl			:= le.bus_active_seleids_peradl + if(~same_SeleID, ri.bus_active_seleids_peradl, integerZero);
		self.bus_inactive_seleids_peradl		:= le.bus_inactive_seleids_peradl + if(~same_SeleID, ri.bus_inactive_seleids_peradl, integerZero);
		self.bus_defunct_seleids_peradl			:= le.bus_defunct_seleids_peradl + if(~same_SeleID, ri.bus_defunct_seleids_peradl, integerZero);
		self.bus_gold_seleid_first_seen			:= map(le.bus_gold_seleid_first_seen = integerZero	=> ri.bus_gold_seleid_first_seen,
																							 ri.bus_gold_seleid_first_seen = integerZero	=> le.bus_gold_seleid_first_seen,
																																										 min(le.bus_gold_seleid_first_seen,ri.bus_gold_seleid_first_seen));
		self.bus_header_first_seen					:= map(le.bus_header_first_seen = integerZero	=> ri.bus_header_first_seen,
																							 ri.bus_header_first_seen = integerZero	=> le.bus_header_first_seen,
																																										 min(le.bus_header_first_seen,ri.bus_header_first_seen));
		self.bus_header_last_seen						:= map(le.bus_header_last_seen = integerZero	=> ri.bus_header_last_seen,
																							 ri.bus_header_last_seen = integerZero	=> le.bus_header_last_seen,
																																										 max(le.bus_header_last_seen,ri.bus_header_last_seen));
		self.bus_header_build_date 					:= integerZero;
		self.bus_SOS_filings_peradl					:= integerZero;
		self.bus_active_SOS_filings_peradl	:= integerZero;
		self.SeleID 												:= ri.SeleID;
		self																:= le;
	end;

  RolledBusinessHeader := rollup(SortedBusinessHeader, rollBusinessHeader(left,right), UniqueID);

	//Get Business header build date
	BHBuildDate := Risk_Indicators.get_Build_date('bip_build_version');

	risk_indicators.Layout_Boca_Shell addBusinessHeader(risk_indicators.Layout_Boca_Shell le, RolledBusinessHeader ri) := TRANSFORM
		noHit																					:= le.seq <> ri.UniqueID;
		noDID																					:= le.DID = integerZero;
		SELF.BIP_Header.bus_seleids_peradl     				:= map(noDID															=> integerNeg1,
																												 noHit															=> integerNeg2,
																																															 ri.bus_seleids_peradl);
		SELF.BIP_Header.bus_gold_seleids_peradl     	:= map(noDID															=> integerNeg1,
																												 noHit															=> integerNeg2,
																																															 ri.bus_gold_seleids_peradl);
		SELF.BIP_Header.bus_active_seleids_peradl     := map(noDID															=> integerNeg1,
																												 noHit															=> integerNeg2,
																																															 ri.bus_active_seleids_peradl);
		SELF.BIP_Header.bus_inactive_seleids_peradl   := map(noDID															=> integerNeg1,
																												 noHit															=> integerNeg2,
																																															 ri.bus_inactive_seleids_peradl);
		SELF.BIP_Header.bus_defunct_seleids_peradl    := map(noDID															=> integerNeg1,
																												 noHit															=> integerNeg2,
																																															 ri.bus_defunct_seleids_peradl);
		SELF.BIP_Header.bus_gold_seleid_first_seen    := map(noDID															=> integerNeg1,
																												 noHit															=> integerNeg2,
																												 ri.bus_gold_seleid_first_seen = integerZero	=> -3,
																																															 ri.bus_gold_seleid_first_seen);
		SELF.BIP_Header.bus_header_first_seen    			:= map(noDID															=> integerNeg1,
																												 noHit															=> integerNeg2,
																												 ri.bus_header_first_seen = integerZero				=> -3,
																																															 ri.bus_header_first_seen);
		SELF.BIP_Header.bus_header_last_seen     			:= map(noDID															=> integerNeg1,
																												 noHit															=> integerNeg2,
																												 ri.bus_header_last_seen = integerZero				=> -3,
																																															 ri.bus_header_last_seen);
		SELF.BIP_Header.bus_header_build_date     		:= map(noDID															=> integerNeg1,
																												 noHit															=> integerNeg2,
																																															 (integer)BHBuildDate);
		SELF.BIP_Header.bus_SOS_filings_peradl     		:= map(noDID															=> integerNeg1,
																												 noHit															=> integerNeg2,
																																															 ri.bus_SOS_filings_peradl);
		SELF.BIP_Header.bus_active_SOS_filings_peradl := map(noDID															=> integerNeg1,
																												 noHit															=> integerNeg2,
																																															 ri.bus_active_SOS_filings_peradl);
		SELF 																					:= le;
	END;

	WithBusinessHeader := JOIN(Shell, RolledBusinessHeader, LEFT.seq=RIGHT.UniqueID, addBusinessHeader(LEFT,RIGHT), LEFT OUTER);

 	UniqueSeleIDs := DEDUP(SORT(UniqueRawFEINMatches, UniqueID, -SeleID),	UniqueID);

	WithSeleIDFlag := JOIN(WithBusinessHeader, UniqueSeleIDs, LEFT.Seq = RIGHT.UniqueID,
                     TRANSFORM(risk_indicators.Layout_Boca_Shell,
                       SELF.BIP_Header54.bus_seleID_match     := LEFT.seq = RIGHT.UniqueID;
											 SELF                                   := LEFT),
										 LEFT OUTER, KEEP(1), ATMOST(100), FEW);




	LinkIDs := DEDUP(SORT(UniqueRawFEINMatches, UniqueID, SeleID),	UniqueID, SeleID);

	//get SOS filings
	CorpFilings_raw := Corp2.Key_LinkIDs.Corp.kfetch2(LinkIDs,
	                                         Business_Risk_BIP.Common.SetLinkSearchLevel(Options.LinkSearchLevel),
	                                         integerZero,
																					 Business_Risk_BIP.Constants.Limit_Default,
																					 Options.KeepLargeBusinesses
													);

	// Add back our Seq numbers.
	CorpFilings_Seq := JOIN(CorpFilings_raw, Shell, LEFT.UniqueID = RIGHT.Seq, TRANSFORM({RECORDOF(LEFT), UNSIGNED4 Seq, UNSIGNED3 HistoryDate, UNSIGNED6 HistoryDateTime, UNSIGNED1 HistoryDateLength, integer bus_SOS_filings_peradl, integer bus_active_SOS_filings_peradl, integer3 bus_sos_filings_not_instate},
										SELF.Seq := RIGHT.Seq;
										SELF.HistoryDate := RIGHT.HistoryDate;
										SELF.HistoryDateTime := integerZero;
										SELF.HistoryDateLength := integerZero;
										SELF.bus_SOS_filings_peradl := 1;
										SELF.bus_active_SOS_filings_peradl := if(Business_Risk_BIP.Common.is_ActiveCorp(LEFT.record_type, LEFT.corp_status_cd, LEFT.corp_status_desc), 1, integerZero);
										SELF.bus_sos_filings_not_instate := map(LEFT.corp_inc_state = '' and LEFT.corp_forgn_state_cd = ''																																				=> -3,  //can't know
																																																		LEFT.corp_inc_state = RIGHT.shell_input.st or LEFT.corp_forgn_state_cd = RIGHT.shell_input.st	=> 0,	  //in state
																																																																																																																																																   1);  //out of state
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
		self.bus_SOS_filings_peradl					:= le.bus_SOS_filings_peradl + if(~same_Corp_Key, ri.bus_SOS_filings_peradl, integerZero);
		self.bus_active_SOS_filings_peradl	:= le.bus_active_SOS_filings_peradl + if(~same_Corp_Key, ri.bus_active_SOS_filings_peradl, integerZero);
		//if any SOS filing record matches input state (value of 0), return 0. Only if ALL filings are out of state (value of 1) do we want to return 1.
		self.bus_sos_filings_not_instate	:= map(le.bus_sos_filings_not_instate <> -3 and ri.bus_sos_filings_not_instate <> -3 => min(le.bus_sos_filings_not_instate, ri.bus_sos_filings_not_instate),
																																										le.bus_sos_filings_not_instate = -3 and ri.bus_sos_filings_not_instate = -3 		=> le.bus_sos_filings_not_instate,
																																																																																																																											max(le.bus_sos_filings_not_instate, ri.bus_sos_filings_not_instate));
		self.UniqueID												:= ri.UniqueID;
		self.SeleID 												 := ri.SeleID;
		self.Corp_Key												:= ri.Corp_Key;
		self																     := le;
	end;

  RolledCorpFilings := rollup(SortedCorpFilings, rollCorpFilings(left,right), UniqueID, SeleID);

  RECORDOF(SortedCorpFilings) rollSOSFilings(RolledCorpFilings le, RolledCorpFilings ri) := transform
		self.bus_SOS_filings_peradl					:= le.bus_SOS_filings_peradl + ri.bus_SOS_filings_peradl;
		self.bus_active_SOS_filings_peradl	:= le.bus_active_SOS_filings_peradl + ri.bus_active_SOS_filings_peradl;
		self.bus_sos_filings_not_instate	:= map(le.bus_sos_filings_not_instate = -3 and ri.bus_sos_filings_not_instate = -3 		=> le.bus_sos_filings_not_instate,
																																										le.bus_sos_filings_not_instate <> -3 and ri.bus_sos_filings_not_instate <> -3 => min(le.bus_sos_filings_not_instate, ri.bus_sos_filings_not_instate),
																																																																																																																											max(le.bus_sos_filings_not_instate, ri.bus_sos_filings_not_instate));
		self.UniqueID												:= ri.UniqueID;
		self.SeleID 												 := ri.SeleID;
		self.Corp_Key												:= ri.Corp_Key;
		self															     	:= le;
	end;

  RolledSOSFilings := rollup(RolledCorpFilings, rollSOSFilings(left,right), UniqueID);

	risk_indicators.Layout_Boca_Shell addSOSFilings(risk_indicators.Layout_Boca_Shell le, RolledSOSFilings ri) := TRANSFORM
		noHit																					:= le.seq <> ri.UniqueID;
		noDID																					:= le.DID = integerZero;
		SELF.BIP_Header.bus_SOS_filings_peradl     		:= map(noDID															  => integerNeg1,
																												 noHit															  => integerNeg2,
                                                                                                 ri.bus_SOS_filings_peradl);
		SELF.BIP_Header.bus_active_SOS_filings_peradl := map(noDID															  => integerNeg1,
																												 noHit															  => integerNeg2,
                                                                                                 ri.bus_active_SOS_filings_peradl);
		SELF.BIP_Header54.bus_sos_filings_not_instate := map(noDID															  => integerNeg1,
                                                         ~le.BIP_Header54.bus_seleID_match    => integerNeg2,
																												 noHit															  => integerNeg3,
                                                                                                 ri.bus_sos_filings_not_instate);
		SELF 																					:= le;
	END;

	WithSOSFilings := JOIN(WithSeleIDFlag, RolledSOSFilings, LEFT.seq=RIGHT.UniqueID, addSOSFilings(LEFT,RIGHT), LEFT OUTER);


	// *** Get UCC filings ***

  // Key fetch to get UCC linkids key records
	ds_ucc_linkidskey_recs := UCCv2.Key_LinkIds.kFetch2(UniqueRawFEINMatches,
	                                                     Business_Risk_BIP.Common.SetLinkSearchLevel(Options.LinkSearchLevel),TopBusiness_Services.Constants.UCCKfetchMaxLimit);

	// Add back our Seq numbers
	ds_ucc_linkidskey_seq := JOIN(ds_ucc_linkidskey_recs, Shell, LEFT.UniqueID = RIGHT.Seq, TRANSFORM({RECORDOF(LEFT), UNSIGNED4 Seq, UNSIGNED3 HistoryDate, UNSIGNED6 HistoryDateTime, UNSIGNED1 HistoryDateLength},
										SELF.Seq := RIGHT.Seq;
										SELF.HistoryDate := RIGHT.HistoryDate;
										SELF.HistoryDateTime := (integer)RIGHT.HistoryDateTimeStamp[1..8];
										SELF.HistoryDateLength := LENGTH( TRIM((STRING)RIGHT.HistoryDateTimeStamp[1..8]) );
										SELF := LEFT),
								FEW);

	// Filter out records after our history date
	ds_ucc_linkidskey_filtered := Business_Risk_BIP.Common.FilterRecords(ds_ucc_linkidskey_seq, dt_first_seen, dt_vendor_first_reported, MDR.SourceTools.src_UCCV2, AllowedSourcesSet);


  layout_UCC_TMSID_slim := record
    unsigned6 UniqueID;
    TopBusiness_Services.UCCSection_Layouts.rec_ids_with_linkidsdata_slimmed;
  end;

	// Filter to only use recs that are not 'A'/Assignee (bug 138650) and then project onto a slimmed layout.
  ds_linkids_keyrecs_slimmed := project (ds_ucc_linkidskey_filtered(party_type != 'A'),
		  transform(layout_UCC_TMSID_slim,
				self.source       := MDR.sourceTools.src_UCCv2, // not needed here???
				self.role_type    := if(left.party_type = TopBusiness_Services.Constants.Debtor, //D = Debtor
														    TopBusiness_Services.Constants.Debtor,TopBusiness_Services.Constants.SecuredParty), //S = SecuredParty
			  self              := left, // to preserve ids & other key fields being kept
			));

  // Sort/dedup to only keep 1 record for each tmsid per set of linkids to reduce the number of key lookups when joining to the ucc main key file below.
	ds_linkids_keyrecs_deduped := dedup(sort(ds_linkids_keyrecs_slimmed,
												                   #expand(BIPV2.IDmacros.mac_ListTop3Linkids()),
																			     tmsid
																					 ),
																      #expand(BIPV2.IDmacros.mac_ListTop3Linkids()),
																			tmsid);

	set_terminated_types := ['LAPSED','L','RELEASE','EXPUNGED','DELETED',
	                         'TERMINATED','TERMINATION','UCC3 TERMINATION', 'UCC-3 TERMINATION'];

  layout_UCC_RMSID_slim := record
    unsigned6 UniqueID;
    TopBusiness_Services.UCCSection_Layouts.rec_ids_with_maindata_slimmed;
  end;

  // Get RMSID records
  ds_uccmain_keyrecs := join(ds_linkids_keyrecs_deduped,UCCV2.Key_Rmsid_Main(),
                               keyed(left.tmsid = right.tmsid), //get all recs for the tmsids
	  transform(layout_UCC_RMSID_slim,
			temp_status_type           := StringLib.StringToUpperCase(right.status_type);
			temp_filing_type           := StringLib.StringToUpperCase(right.filing_type);
			self.orig_filing_number    := if(right.orig_filing_number != '',
			                                 right.orig_filing_number,right.filing_number),
			self.status_type           := temp_status_type,
			self.filing_type           := temp_filing_type,
			self.status_code           := if(temp_status_type in set_terminated_types or
						                           temp_filing_type in set_terminated_types,
																			 TopBusiness_Services.Constants.TERMINATED,TopBusiness_Services.Constants.ACTIVE
																			 );
			self := right,  // to pull off the ucc main key fields we want
			self := left,   // to preserve ids & other(?) kept linkids key fields ???
    ),
		left outer,
		limit(10000,skip) // needed because of bad/generic tmsid=DNB, see bug 148946
	 );

  ds_ucc_RMSID_dedup := dedup(sort(ds_uccmain_keyrecs, UniqueID, TMSID, -status_code), UniqueID, TMSID);

	table_UCC_counts 	:= table(ds_ucc_RMSID_dedup, {UniqueID, bus_UCC_count := count(group), bus_UCC_active_count := count(group, status_code = 'A')}, UniqueID); //count total UCC filings and active UCC filings

	WithUCCFilings := JOIN(WithSOSFilings, table_UCC_counts, LEFT.Seq = RIGHT.UniqueID,
                     TRANSFORM(risk_indicators.Layout_Boca_Shell,
                       noHit																	:= LEFT.seq <> RIGHT.UniqueID;
                       noDID																	:= LEFT.DID = integerZero;
                       SELF.BIP_Header54.bus_UCC_count        := map(noDID					                      => integerNeg1,
                                                                     ~LEFT.BIP_Header54.bus_seleID_match  => integerNeg2,
                                                                                                             RIGHT.bus_UCC_count);
                       SELF.BIP_Header54.bus_UCC_active_count := map(noDID					                      => integerNeg1,
                                                                     ~LEFT.BIP_Header54.bus_seleID_match  => integerNeg2,
                                                                     noHit                                => integerNeg3,
                                                                                                             RIGHT.bus_UCC_active_count);
											 SELF                                   := LEFT),
										 LEFT OUTER, KEEP(1), ATMOST(100), FEW);


 // *** Get Inquiries ***

	InqBuildDate := Risk_Indicators.get_Build_date('inquiry_update_build_version');

	// ---------------- Business Inquiries - Only Allowed in Non-Marketing Mode ------------------
	InquiriesRaw := Inquiry_AccLogs.Key_Inquiry_LinkIds.kFetch2(UniqueRawFEINMatches,
																						 Business_Risk_BIP.Common.SetLinkSearchLevel(Business_Risk_BIP.Constants.LinkSearch.SeleID),
																							0,
																							Business_Risk_BIP.Constants.Limit_Inquiries,
																							Options.KeepLargeBusinesses);

	// Add back our Seq numbers
	InquiriesSeq := JOIN(InquiriesRaw, Shell, LEFT.UniqueID = RIGHT.Seq, TRANSFORM({RECORDOF(LEFT), UNSIGNED4 Seq, UNSIGNED3 HistoryDate, UNSIGNED6 HistoryDateTime, UNSIGNED1 HistoryDateLength,
                                                                                 INTEGER3 bus_inq_count12, INTEGER3 bus_inq_credit_count12, INTEGER3 bus_inq_highriskcredit_count12, INTEGER3 bus_inq_other_count12},
										SELF.Seq := RIGHT.Seq;
										SELF.HistoryDate := RIGHT.HistoryDate;
										SELF.HistoryDateTime := (integer)RIGHT.HistoryDateTimeStamp[1..8];
										SELF.HistoryDateLength := LENGTH( TRIM((STRING)RIGHT.HistoryDateTimeStamp[1..8]) );
          agebucket := risk_indicators.iid_constants.age_bucket(LEFT.search_info.datetime[1..8], RIGHT.historydate, RIGHT.historyDateTimeStamp);
          SELF.bus_inq_count12					            := if(ageBucket between 1 and 12, 1, 0);
          SELF.bus_inq_credit_count12          := if(ageBucket between 1 and 12 and LEFT.bus_intel.industry in Inquiry_AccLogs.shell_constants.banking_industry5, 1, 0);
          SELF.bus_inq_highriskcredit_count12  := if(ageBucket between 1 and 12 and LEFT.bus_intel.industry in [Inquiry_AccLogs.shell_constants.collection_industry,
                                                                                                                Inquiry_AccLogs.shell_constants.HighRiskCredit_industry5,
                                                                                                                Inquiry_AccLogs.shell_constants.PrepaidCards_industry], 1, 0);
										SELF.bus_inq_other_count12           := if(ageBucket between 1 and 12 and LEFT.bus_intel.industry not in [Inquiry_AccLogs.shell_constants.banking_industry5,
                                                                                                                    Inquiry_AccLogs.shell_constants.collection_industry,
                                                                                                                    Inquiry_AccLogs.shell_constants.HighRiskCredit_industry5,
                                                                                                                    Inquiry_AccLogs.shell_constants.PrepaidCards_industry], 1, 0);
          SELF := LEFT),
								FEW);

	// Figure out if the kFetch was successful
	kFetchErrorCodesInquiry := Business_Risk_BIP.Common.GrabFetchErrorCode(InquiriesSeq);

	// Filter out records after our history date
	Inquiries := Business_Risk_BIP.Common.FilterRecords2(InquiriesSeq, (TRIM(Search_Info.DateTime,ALL))[1..12], '', AllowedSourcesSet);

	InquiriesUpdateRaw := Inquiry_AccLogs.Key_Inquiry_LinkIds_Update.kFetch2(UniqueRawFEINMatches,
    mod_access,
    Business_Risk_BIP.Common.SetLinkSearchLevel(Options.LinkSearchLevel),
    0,
    Business_Risk_BIP.Constants.Limit_Inquiries,
    Options.KeepLargeBusinesses);

	// Add back our Seq numbers
	InquiriesUpdateSeq := JOIN(InquiriesUpdateRaw, Shell, LEFT.UniqueID = RIGHT.Seq, TRANSFORM({RECORDOF(LEFT), UNSIGNED4 Seq, UNSIGNED3 HistoryDate, UNSIGNED6 HistoryDateTime, UNSIGNED1 HistoryDateLength,
                                                                                             INTEGER3 bus_inq_count12, INTEGER3 bus_inq_credit_count12, INTEGER3 bus_inq_highriskcredit_count12, INTEGER3 bus_inq_other_count12},
										SELF.Seq := RIGHT.Seq;
										SELF.HistoryDate := RIGHT.HistoryDate;
										SELF.HistoryDateTime := (integer)RIGHT.HistoryDateTimeStamp[1..8];
										SELF.HistoryDateLength := LENGTH( TRIM((STRING)RIGHT.HistoryDateTimeStamp[1..8]) );
          agebucket := risk_indicators.iid_constants.age_bucket(LEFT.search_info.datetime[1..8], RIGHT.historydate, RIGHT.historyDateTimeStamp);
          SELF.bus_inq_count12					            := if(ageBucket between 1 and 12, 1, 0);
          SELF.bus_inq_credit_count12          := if(ageBucket between 1 and 12 and LEFT.bus_intel.industry in Inquiry_AccLogs.shell_constants.banking_industry5, 1, 0);
          SELF.bus_inq_highriskcredit_count12  := if(ageBucket between 1 and 12 and LEFT.bus_intel.industry in [Inquiry_AccLogs.shell_constants.collection_industry,
                                                                                                                Inquiry_AccLogs.shell_constants.HighRiskCredit_industry5,
                                                                                                                Inquiry_AccLogs.shell_constants.PrepaidCards_industry], 1, 0);
										SELF.bus_inq_other_count12           := if(ageBucket between 1 and 12 and LEFT.bus_intel.industry not in [Inquiry_AccLogs.shell_constants.banking_industry5,
                                                                                                                    Inquiry_AccLogs.shell_constants.collection_industry,
                                                                                                                    Inquiry_AccLogs.shell_constants.HighRiskCredit_industry5,
                                                                                                                    Inquiry_AccLogs.shell_constants.PrepaidCards_industry], 1, 0);
										SELF := LEFT),
								FEW);

	// Figure out if the kFetch was successful
	kFetchErrorCodesInquiryUpdate := Business_Risk_BIP.Common.GrabFetchErrorCode(InquiriesUpdateSeq);

	// Filter out records after our history date
	InquiriesUpdate := Business_Risk_BIP.Common.FilterRecords2(InquiriesUpdateSeq, (TRIM(Search_Info.DateTime,ALL))[1..12], '', AllowedSourcesSet);

	// Keep the unique inquiries between the historical and update keys
	InquiriesAllTemp := DEDUP(SORT((Inquiries + InquiriesUpdate), Seq, Search_Info.Transaction_ID, -Search_Info.DateTime[1..8], -Search_Info.DateTime[10..15]), Seq, Search_Info.Transaction_ID, Search_Info.DateTime[1..8], Search_Info.DateTime[10..15]);

 RECORDOF(InquiriesAllTemp) rollInquiries(InquiriesAllTemp le, InquiriesAllTemp ri) := transform
		self.bus_inq_count12					       := le.bus_inq_count12 + ri.bus_inq_count12;
		self.bus_inq_credit_count12       	 := le.bus_inq_credit_count12 + ri.bus_inq_credit_count12;
		self.bus_inq_highriskcredit_count12	 := le.bus_inq_highriskcredit_count12 + ri.bus_inq_highriskcredit_count12;
		self.bus_inq_other_count12	         := le.bus_inq_other_count12 + ri.bus_inq_other_count12;
		self															   := le;
	end;

 rolledInquiries := rollup(sort(InquiriesAllTemp, Seq), rollInquiries(left,right), Seq);

	risk_indicators.Layout_Boca_Shell addInquiries(risk_indicators.Layout_Boca_Shell le, rolledInquiries ri) := TRANSFORM
		noDID																					    := le.DID = integerZero;
		SELF.BIP_Header54.bus_inq_count12                 := map(noDID					                    => integerNeg1, // return -1 if no LexID found
                                                             ~le.BIP_Header54.bus_seleID_match  => integerNeg2, // return -2 if no SeleIDs found for LexID
                                                                                                   ri.bus_inq_count12);
		SELF.BIP_Header54.bus_inq_credit_count12          := map(noDID					                    => integerNeg1,
                                                             ~le.BIP_Header54.bus_seleID_match  => integerNeg2,
                                                             ri.bus_inq_count12 = 0             => integerNeg3, // return -3 if no inquiries for SeleIDs in last 12 months
                                                                                                   ri.bus_inq_credit_count12);
		SELF.BIP_Header54.bus_inq_highriskcredit_count12  := map(noDID					                    => integerNeg1,
                                                             ~le.BIP_Header54.bus_seleID_match  => integerNeg2,
                                                             ri.bus_inq_count12 = 0             => integerNeg3,
                                                                                                   ri.bus_inq_highriskcredit_count12);
		SELF.BIP_Header54.bus_inq_other_count12           := map(noDID					                    => integerNeg1,
                                                             ~le.BIP_Header54.bus_seleID_match  => integerNeg2,
                                                             ri.bus_inq_count12 = 0             => integerNeg3,
                                                                                                   ri.bus_inq_other_count12);
	SELF 																					      := le;
	END;

	withInquiries := JOIN(WithUCCFilings, rolledInquiries, LEFT.seq=RIGHT.Seq, addInquiries(LEFT,RIGHT), LEFT OUTER);


	// Here starts business header verification to verify input DID, address, SSN, fname, lname and phone against the business header records.  This logic mimics the business shell, but
	// for name, SSN and phone verification, both the contact information and business information on the business header will be verified against to give lift to verification rates.

	sourcesLayout := RECORD
		UNSIGNED4 					Seq := integerZero;
		DATASET(Business_Risk_BIP.Layouts.LayoutSources) DIDSources; // Note, this is only for internal use, it will be rolled up for the Verification Section
		DATASET(Business_Risk_BIP.Layouts.LayoutSources) fNameSources;
		DATASET(Business_Risk_BIP.Layouts.LayoutSources) lNameSources;
		DATASET(Business_Risk_BIP.Layouts.LayoutSources) addressSources;
		DATASET(Business_Risk_BIP.Layouts.LayoutSources) phoneSources;
		DATASET(Business_Risk_BIP.Layouts.LayoutSources) SSNSources;
  // Risk_Indicators.Layouts.layout_BIP_Header_info BIP_Header;
 End;

	sourcesLayout verifyElements(Risk_Indicators.Layout_Boca_Shell le, BusinessHeader ri) := TRANSFORM
		fNamePopulated				:= TRIM(le.shell_input.fName) <> '' AND TRIM(ri.fName) <> '';
		// In an effort to "short-circuit" all of the fuzzy matching, we will require that the first letter match - if it doesn't match it bypasses the slow fuzzy matching which speeds up our query
		fNameMatchScore			:= IF(fNamePopulated AND le.shell_input.fName[1] = ri.fName[1], Risk_Indicators.FnameScore(le.shell_input.fName, ri.fName), Risk_Indicators.iid_constants.default_empty_score);
		fNameMatched						:= Risk_Indicators.iid_constants.g(fNameMatchScore);

		lNamePopulated				:= TRIM(le.shell_input.lName) <> '' AND TRIM(ri.lName) <> '';
		lNameMatchScore			:= IF(lNamePopulated AND le.shell_input.lName[1] = ri.lName[1], Risk_Indicators.lnameScore(le.shell_input.lName, ri.lName), Risk_Indicators.iid_constants.default_empty_score);
		lNameMatched						:= Risk_Indicators.iid_constants.g(lNameMatchScore);

		phonematchscore 		:= Risk_Indicators.PhoneScore(le.shell_input.phone10, ri.contact_phone);
		phonematched 					:= Risk_Indicators.iid_constants.gn(phonematchscore);
		cphonematchscore 	:= Risk_Indicators.PhoneScore(le.shell_input.phone10, ri.company_phone);
		cphonematched 				:= Risk_Indicators.iid_constants.gn(cphonematchscore);

		SSNPopulated 					:= (INTEGER)le.shell_Input.ssn > integerZero;
		SSNLength									:= LENGTH(TRIM(le.shell_Input.SSN));
		SSNMatched 							:= MAP(NOT SSNPopulated																																				 => FALSE,
																											SSNPopulated AND le.shell_Input.SSN[1] = ri.contact_ssn[IF(SSNLength = 4, 6, 1)]	=> Risk_Indicators.iid_constants.gn(DID_Add.SSN_Match_Score(le.shell_Input.SSN, ri.contact_ssn, SSNLength=4)),
																																																																																			FALSE);
		cSSNMatched 						:= MAP(NOT SSNPopulated																																				 => FALSE,
																											SSNPopulated AND le.shell_Input.SSN[1] = ri.company_FEIN[IF(SSNLength = 4, 6, 1)]	=> Risk_Indicators.iid_constants.gn(DID_Add.SSN_Match_Score(le.shell_Input.SSN, ri.company_FEIN, SSNLength=4)),
																																																																																			FALSE);

		NoScoreValue						:= 255; // This is what the various score functions return if blank is passed in
		addressPopulated		:= TRIM(le.shell_input.Prim_Name) <> '' AND TRIM(le.shell_input.z5) <> '' AND TRIM(ri.prim_name) <> '' AND TRIM(ri.Zip) <> '';

		ZIPScore										:= IF(le.shell_input.z5 <> '' AND ri.Zip <> '' AND le.shell_input.z5[1] = ri.Zip[1], Risk_Indicators.AddrScore.ZIP_Score(le.shell_input.z5, ri.Zip), NoScoreValue);
		StateMatched						:= StringLib.StringToUpperCase(le.shell_input.st) = StringLib.StringToUpperCase(ri.st);
		CityStateScore				:= IF(le.shell_input.p_city_name <> '' AND le.shell_input.st <> '' AND ri.p_city_name <> '' AND ri.st <> '' AND StateMatched,
																										Risk_Indicators.AddrScore.CityState_Score(le.shell_input.p_city_name, le.shell_input.st, ri.p_city_name, ri.st, ''), NoScoreValue);
		CityStateZipMatched	:= AddressPopulated AND Risk_Indicators.iid_constants.ga(ZIPScore) AND Risk_Indicators.iid_constants.ga(CityStateScore);

		AddressScore := MAP(NOT AddressPopulated 																																																											=> NoScoreValue,
																						AddressPopulated AND ZIPScore = NoScoreValue AND CityStateScore = NoScoreValue 	=> NoScoreValue,
																						Risk_Indicators.AddrScore.AddressScore(le.shell_input.Prim_Range, le.shell_input.Prim_Name, le.shell_input.Sec_Range,
																																																													ri.prim_range, ri.prim_name, ri.sec_range, ZIPScore, CityStateScore));
		AddressMatched				:= AddressPopulated AND Risk_Indicators.iid_constants.ga(AddressScore);
		AddressMatchLevel := MAP(AddressPopulated = FALSE																											=> stringNeg1, // Address Not Input
																							TRIM(ri.Prim_Name) = '' OR (INTEGER)ri.zip <= integerZero								=> stringZero, // Address Not Found
																							CityStateZipMatched = TRUE AND AddressMatched = FALSE		=> '1', // City/State/Zip Match
																							AddressMatched = TRUE																																		=> '2', // Street/City/State/Zip Match
																																																																																	stringZero); // Not verified
		fNameHit_new      := AddressMatched AND Business_Risk_BIP.Common.fn_isFoundInCompanyName( TRIM(le.shell_input.fName), ri.Company_Name );
		lNameHit_new      := AddressMatched AND Business_Risk_BIP.Common.fn_isFoundInCompanyName( TRIM(le.shell_input.lName), ri.Company_Name );


		DIDmatched								:= le.DID = ri.contact_DID;

		DateFirstSeen := Business_Risk_BIP.Common.checkInvalidDate((STRING)ri.dt_first_Seen, Business_Risk_BIP.Constants.MissingDate, le.HistoryDate)[1..6];
		DateVendorFirstSeen := Business_Risk_BIP.Common.checkInvalidDate((STRING)ri.dt_vendor_first_reported, Business_Risk_BIP.Constants.MissingDate, le.HistoryDate)[1..6];
		DateLastSeen := Business_Risk_BIP.Common.checkInvalidDate((STRING)ri.dt_last_seen, Business_Risk_BIP.Constants.MissingDate, le.HistoryDate)[1..6];
		DateVendorLastSeen := Business_Risk_BIP.Common.checkInvalidDate((STRING)ri.dt_vendor_last_reported, Business_Risk_BIP.Constants.MissingDate, le.HistoryDate)[1..6];

		SELF.DIDSources 				:= IF(DIDMatched, DATASET([{ri.Source,
																																if(DateFirstSeen <= stringZero, stringNeg3, DateFirstSeen),
																																if(DateVendorFirstSeen <= stringZero, stringNeg3, DateVendorFirstSeen),
																																if(DateLastSeen <= stringZero, stringNeg3, DateLastSeen),
																																if(DateVendorLastSeen <= stringZero, stringNeg3, DateVendorLastSeen),
																																1}], Business_Risk_BIP.Layouts.LayoutSources), DATASET([], Business_Risk_BIP.Layouts.LayoutSources));
		SELF.fNameSources 		:= IF(fNameMatched or fNameHit_new, DATASET([{ri.Source,
																																if(DateFirstSeen <= stringZero, stringNeg3, DateFirstSeen),
																																if(DateVendorFirstSeen <= stringZero, stringNeg3, DateVendorFirstSeen),
																																if(DateLastSeen <= stringZero, stringNeg3, DateLastSeen),
																																if(DateVendorLastSeen <= stringZero, stringNeg3, DateVendorLastSeen),
																																1}], Business_Risk_BIP.Layouts.LayoutSources), DATASET([], Business_Risk_BIP.Layouts.LayoutSources));
		SELF.lNameSources 		:= IF(lNameMatched or lNameHit_new, DATASET([{ri.Source,
																																if(DateFirstSeen <= stringZero, stringNeg3, DateFirstSeen),
																																if(DateVendorFirstSeen <= stringZero, stringNeg3, DateVendorFirstSeen),
																																if(DateLastSeen <= stringZero, stringNeg3, DateLastSeen),
																																if(DateVendorLastSeen <= stringZero, stringNeg3, DateVendorLastSeen),
																																1}], Business_Risk_BIP.Layouts.LayoutSources), DATASET([], Business_Risk_BIP.Layouts.LayoutSources));
		SELF.addressSources := IF((INTEGER)AddressMatchLevel >= 2, DATASET([{ri.Source, // Only keep sources that fully verified
																																if(DateFirstSeen <= stringZero, stringNeg3, DateFirstSeen),
																																if(DateVendorFirstSeen <= stringZero, stringNeg3, DateVendorFirstSeen),
																																if(DateLastSeen <= stringZero, stringNeg3, DateLastSeen),
																																if(DateVendorLastSeen <= stringZero, stringNeg3, DateVendorLastSeen),
																																1}], Business_Risk_BIP.Layouts.LayoutSources), DATASET([], Business_Risk_BIP.Layouts.LayoutSources));
		SELF.phoneSources 		:= IF(PhoneMatched or cPhoneMatched, DATASET([{ri.Source,
																																if(DateFirstSeen <= stringZero, stringNeg3, DateFirstSeen),
																																if(DateVendorFirstSeen <= stringZero, stringNeg3, DateVendorFirstSeen),
																																if(DateLastSeen <= stringZero, stringNeg3, DateLastSeen),
																																if(DateVendorLastSeen <= stringZero, stringNeg3, DateVendorLastSeen),
																																1}], Business_Risk_BIP.Layouts.LayoutSources), DATASET([], Business_Risk_BIP.Layouts.LayoutSources));
		SELF.SSNSources 				:= IF(SSNMatched or cSSNMatched, DATASET([{ri.Source,
																																if(DateFirstSeen <= stringZero, stringNeg3, DateFirstSeen),
																																if(DateVendorFirstSeen <= stringZero, stringNeg3, DateVendorFirstSeen),
																																if(DateLastSeen <= stringZero, stringNeg3, DateLastSeen),
																																if(DateVendorLastSeen <= stringZero, stringNeg3, DateVendorLastSeen),
																																1}], Business_Risk_BIP.Layouts.LayoutSources), DATASET([], Business_Risk_BIP.Layouts.LayoutSources));

		SELF.seq											 := le.seq;
  SELF                := [];
	END;


	BusinessHeaderVerification := JOIN(withInquiries, BusinessHeader, LEFT.Seq = RIGHT.Seq,
																																			verifyElements(LEFT, RIGHT),
																																			INNER, ATMOST(Business_Risk_BIP.Constants.Limit_BusHeader));

	sourcesLayout rollBusinessHeaderVerification(sourcesLayout le, sourcesLayout ri) := TRANSFORM
		SELF.DIDSources 				:= le.DIDSources + ri.DIDSources;
		SELF.FNameSources 		:= le.FNameSources + ri.FNameSources;
		SELF.LNameSources 		:= le.LNameSources + ri.LNameSources;
		SELF.AddressSources := le.AddressSources + ri.AddressSources;
		SELF.PhoneSources 		:= le.PhoneSources + ri.PhoneSources;
		SELF.SSNSources 				:= le.SSNSources + ri.SSNSources;
		SELF 															:= le;
	END;

	BusinessHeaderVerificationRolled := ROLLUP(SORT(BusinessHeaderVerification, Seq), LEFT.Seq = RIGHT.Seq, rollBusinessHeaderVerification(LEFT, RIGHT));


	Business_Risk_BIP.Layouts.LayoutSources rollSource(Business_Risk_BIP.Layouts.LayoutSources le, Business_Risk_BIP.Layouts.LayoutSources ri) := TRANSFORM
		SELF.Source               := IF(StringLib.StringFind(le.Source, ',', 1) > integerZero, '\'' + le.Source + '\'', le.Source); // Because this is a comma delimited list - if a source contains a comma, put quotes around it
		MinDate 								          := MAP((INTEGER)le.DateFirstSeen > integerZero AND (INTEGER)ri.DateFirstSeen > integerZero		=> MIN((INTEGER)le.DateFirstSeen, (INTEGER)ri.DateFirstSeen),
																																			(INTEGER)le.DateFirstSeen <= integerZero AND (INTEGER)ri.DateFirstSeen > integerZero	=> (INTEGER)ri.DateFirstSeen,
																																																																																																							(INTEGER)le.DateFirstSeen);
		SELF.DateFirstSeen        := (STRING)MinDate;

		MinVendorDate             := MAP((INTEGER)le.DateVendorFirstSeen > integerZero AND (INTEGER)ri.DateVendorFirstSeen > integerZero		  => MIN((INTEGER)le.DateVendorFirstSeen, (INTEGER)ri.DateVendorFirstSeen),
                                   (INTEGER)le.DateVendorFirstSeen <= integerZero AND (INTEGER)ri.DateVendorFirstSeen > integerZero	  => (INTEGER)ri.DateVendorFirstSeen,
                                                                                                                     (INTEGER)le.DateVendorFirstSeen);
		SELF.DateVendorFirstSeen  := (STRING)MinVendorDate;

		MaxDate                   := MAX((INTEGER)le.DateLastSeen, (INTEGER)ri.DateLastSeen);
		SELF.DateLastSeen         := (STRING)MaxDate;

		MaxVendorDate             := MAX((INTEGER)le.DateVendorLastSeen, (INTEGER)ri.DateVendorLastSeen);
		SELF.DateVendorLastSeen   := (STRING)MaxVendorDate;

		SELF.RecordCount          := le.RecordCount + ri.RecordCount;

		SELF                      := le;
	END;


	risk_indicators.Layout_Boca_Shell addBIPHeaderVer(risk_indicators.Layout_Boca_Shell le, BusinessHeaderVerificationRolled ri) := TRANSFORM

		// Group sources based on what the modelers would like to see
		GroupedDIDSources 				:= Business_Risk_BIP.Common.groupSources(Business_Risk_BIP.Layouts.LayoutSources, ri.DIDSources);
		GroupedFNameSources 		:= Business_Risk_BIP.Common.groupSources(Business_Risk_BIP.Layouts.LayoutSources, ri.fNameSources);
		GroupedLNameSources 		:= Business_Risk_BIP.Common.groupSources(Business_Risk_BIP.Layouts.LayoutSources, ri.lNameSources);
		GroupedAddressSources := Business_Risk_BIP.Common.groupSources(Business_Risk_BIP.Layouts.LayoutSources, ri.AddressSources);
		GroupedPhoneSources 		:= Business_Risk_BIP.Common.groupSources(Business_Risk_BIP.Layouts.LayoutSources, ri.PhoneSources);
		GroupedSSNSources 				:= Business_Risk_BIP.Common.groupSources(Business_Risk_BIP.Layouts.LayoutSources, ri.SSNSources);

		// Get this Seq's unique Sources/Dates
		UniqueDIDSources 					:= ROLLUP(SORT(GroupedDIDSources, Source), LEFT.Source = RIGHT.Source, rollSource(LEFT, RIGHT)) (Source <> '');
		UniqueFNameSources 			:= ROLLUP(SORT(GroupedFNameSources, Source), LEFT.Source = RIGHT.Source, rollSource(LEFT, RIGHT)) (Source <> '');
		UniqueLNameSources 			:= ROLLUP(SORT(GroupedLNameSources, Source), LEFT.Source = RIGHT.Source, rollSource(LEFT, RIGHT)) (Source <> '');
		UniqueAddressSources 	:= ROLLUP(SORT(GroupedAddressSources, Source), LEFT.Source = RIGHT.Source, rollSource(LEFT, RIGHT)) (Source <> '');
		UniquePhoneSources 			:= ROLLUP(SORT(GroupedPhoneSources, Source), LEFT.Source = RIGHT.Source, rollSource(LEFT, RIGHT)) (Source <> '');
		UniqueSSNSources 					:= ROLLUP(SORT(GroupedSSNSources, Source), LEFT.Source = RIGHT.Source, rollSource(LEFT, RIGHT)) (Source <> '');

		// Now sort the sources by the order we want them to appear in our delimited fields (DateFirstSeen), which is consistent with the consumer side's verification fields
		SeqDIDSources         := SORT(UniqueDIDSources, if(DateFirstSeen=stringNeg3, ninesDate, DateFirstSeen), DateLastSeen, Source, -RecordCount);
		SeqFNameSources       := SORT(UniqueFNameSources, if(DateFirstSeen=stringNeg3, ninesDate, DateFirstSeen), DateLastSeen, Source, -RecordCount);
		SeqLNameSources       := SORT(UniqueLNameSources, if(DateFirstSeen=stringNeg3, ninesDate, DateFirstSeen), DateLastSeen, Source, -RecordCount);
		SeqAddressSources     := SORT(UniqueAddressSources, if(DateFirstSeen=stringNeg3, ninesDate, DateFirstSeen), DateLastSeen, Source, -RecordCount);
		SeqPhoneSources       := SORT(UniquePhoneSources, if(DateFirstSeen=stringNeg3, ninesDate, DateFirstSeen), DateLastSeen, Source, -RecordCount);
		SeqSSNSources         := SORT(UniqueSSNSources, if(DateFirstSeen=stringNeg3, ninesDate, DateFirstSeen), DateLastSeen, Source, -RecordCount);

		// These flags will be used to set special values in the resulting fields
		noDID																					:= le.DID = integerZero;
  noFName                   := TRIM(le.shell_input.fName) = '';
  noLName                   := TRIM(le.shell_input.lName) = '';
  noPhone                   := le.shell_input.phone10 = '';
  noSSN                     := le.shell_input.ssn = '';
  noAddr                    := TRIM(le.shell_input.Prim_Name) = '' OR TRIM(le.shell_input.z5) = '';
 	noHit																					:= le.seq <> ri.seq;

		SELF.BIP_Header54.bus_ver_sources_total             := map(noDID													  => integerNeg1,
                                                             noHit            			=> integerNeg2,
                                                                                    Business_Risk_BIP.Common.capNum(COUNT(SeqDIDSources), integerNeg1, 99));
		SELF.BIP_Header54.bus_ver_sources                   := map(noDID															=> stringNeg1,
                                                             noHit          					=> stringNeg2,
                                                                                    Business_Risk_BIP.Common.convertDelimited(SeqDIDSources, Source, Business_Risk_BIP.Constants.FieldDelimiter));
		SELF.BIP_Header54.bus_ver_sources_first_seen        := map(noDID															=> stringNeg1,
                                                             noHit          					=> stringNeg2,
                                                                                    Business_Risk_BIP.Common.convertDelimited(SeqDIDSources, DateFirstSeen, Business_Risk_BIP.Constants.FieldDelimiter));
		SELF.BIP_Header54.bus_ver_sources_last_seen         := map(noDID															=> stringNeg1,
                                                             noHit          					=> stringNeg2,
                                                                                    Business_Risk_BIP.Common.convertDelimited(SeqDIDSources, DateLastSeen, Business_Risk_BIP.Constants.FieldDelimiter));

		SELF.BIP_Header54.bus_fname_ver_sources_total       := map(noDID or noFName				=> integerNeg1,
                                                             noHit            			=> integerNeg2,
                                                                                    Business_Risk_BIP.Common.capNum(COUNT(SeqFNameSources), integerNeg1, 99));
		SELF.BIP_Header54.bus_fname_ver_sources             := map(noDID or noFName				=> stringNeg1,
                                                             noHit            			=> stringNeg2,
                                                                                    Business_Risk_BIP.Common.convertDelimited(SeqFNameSources, Source, Business_Risk_BIP.Constants.FieldDelimiter));
		SELF.BIP_Header54.bus_fname_ver_sources_first_seen  := map(noDID or noFName				=> stringNeg1,
                                                             noHit            			=> stringNeg2,
                                                                                    Business_Risk_BIP.Common.convertDelimited(SeqFNameSources, DateFirstSeen, Business_Risk_BIP.Constants.FieldDelimiter));
		SELF.BIP_Header54.bus_fname_ver_sources_last_seen   := map(noDID or noFName				=> stringNeg1,
                                                             noHit            			=> stringNeg2,
                                                                                    Business_Risk_BIP.Common.convertDelimited(SeqFNameSources, DateLastSeen, Business_Risk_BIP.Constants.FieldDelimiter));

		SELF.BIP_Header54.bus_lname_ver_sources_total       := map(noDID or noLName				=> integerNeg1,
                                                             noHit            			=> integerNeg2,
                                                                                    Business_Risk_BIP.Common.capNum(COUNT(SeqLNameSources), integerNeg1, 99));
		SELF.BIP_Header54.bus_lname_ver_sources             := map(noDID	or noLName				=> stringNeg1,
                                                             noHit            			=> stringNeg2,
                                                                                    Business_Risk_BIP.Common.convertDelimited(SeqLNameSources, Source, Business_Risk_BIP.Constants.FieldDelimiter));
		SELF.BIP_Header54.bus_lname_ver_sources_first_seen  := map(noDID	or noLName				=> stringNeg1,
                                                             noHit            			=> stringNeg2,
                                                                                    Business_Risk_BIP.Common.convertDelimited(SeqLNameSources, DateFirstSeen, Business_Risk_BIP.Constants.FieldDelimiter));
		SELF.BIP_Header54.bus_lname_ver_sources_last_seen   := map(noDID	or noLName				=> stringNeg1,
                                                             noHit            			=> stringNeg2,
                                                                                    Business_Risk_BIP.Common.convertDelimited(SeqLNameSources, DateLastSeen, Business_Risk_BIP.Constants.FieldDelimiter));

		SELF.BIP_Header54.bus_addr_ver_sources_total        := map(noDID	or noAddr 				=> integerNeg1,
                                                             noHit              	=> integerNeg2,
                                                                                    Business_Risk_BIP.Common.capNum(COUNT(SeqAddressSources), integerNeg1, 99));
		SELF.BIP_Header54.bus_addr_ver_sources              := map(noDID	or noAddr					=> stringNeg1,
                                                             noHit              	=> stringNeg2,
                                                                                    Business_Risk_BIP.Common.convertDelimited(SeqAddressSources, Source, Business_Risk_BIP.Constants.FieldDelimiter));
		SELF.BIP_Header54.bus_addr_ver_sources_first_seen   := map(noDID	or noAddr					=> stringNeg1,
                                                             noHit              	=> stringNeg2,
                                                                                    Business_Risk_BIP.Common.convertDelimited(SeqAddressSources, DateFirstSeen, Business_Risk_BIP.Constants.FieldDelimiter));
		SELF.BIP_Header54.bus_addr_ver_sources_last_seen    := map(noDID	or noAddr					=> stringNeg1,
                                                             noHit              	=> stringNeg2,
                                                                                    Business_Risk_BIP.Common.convertDelimited(SeqAddressSources, DateLastSeen, Business_Risk_BIP.Constants.FieldDelimiter));

		SELF.BIP_Header54.bus_phone_ver_sources_total       := map(noDID	or noPhone				=> integerNeg1,
                                                             noHit	           			=> integerNeg2,
                                                                                    Business_Risk_BIP.Common.capNum(COUNT(SeqPhoneSources), integerNeg1, 99));
		SELF.BIP_Header54.bus_phone_ver_sources             := map(noDID	or noPhone				=> stringNeg1,
                                                             noHit	           			=> stringNeg2,
                                                                                    Business_Risk_BIP.Common.convertDelimited(SeqPhoneSources, Source, Business_Risk_BIP.Constants.FieldDelimiter));
		SELF.BIP_Header54.bus_phone_ver_sources_first_seen  := map(noDID	or noPhone				=> stringNeg1,
                                                             noHit	           			=> stringNeg2,
                                                                                    Business_Risk_BIP.Common.convertDelimited(SeqPhoneSources, DateFirstSeen, Business_Risk_BIP.Constants.FieldDelimiter));
		SELF.BIP_Header54.bus_phone_ver_sources_last_seen   := map(noDID	or noPhone				=> stringNeg1,
                                                             noHit	           			=> stringNeg2,
                                                                                    Business_Risk_BIP.Common.convertDelimited(SeqPhoneSources, DateLastSeen, Business_Risk_BIP.Constants.FieldDelimiter));

		SELF.BIP_Header54.bus_ssn_ver_sources_total         := map(noDID	or noSSN  				=> integerNeg1,
                                                             noHit	         					=> integerNeg2,
                                                                                    Business_Risk_BIP.Common.capNum(COUNT(SeqSSNSources), integerNeg1, 99));
		SELF.BIP_Header54.bus_ssn_ver_sources               := map(noDID	or noSSN						=> stringNeg1,
                                                           noHit	         					  => stringNeg2,
                                                                                    Business_Risk_BIP.Common.convertDelimited(SeqSSNSources, Source, Business_Risk_BIP.Constants.FieldDelimiter));
		SELF.BIP_Header54.bus_ssn_ver_sources_first_seen    := map(noDID	or noSSN						=> stringNeg1,
                                                             noHit	         					=> stringNeg2,
                                                                                    Business_Risk_BIP.Common.convertDelimited(SeqSSNSources, DateFirstSeen, Business_Risk_BIP.Constants.FieldDelimiter));
		SELF.BIP_Header54.bus_ssn_ver_sources_last_seen     := map(noDID	or noSSN						=> stringNeg1,
                                                             noHit	         					=> stringNeg2,
                                                                                    Business_Risk_BIP.Common.convertDelimited(SeqSSNSources, DateLastSeen, Business_Risk_BIP.Constants.FieldDelimiter));

		SELF := le;
	END;

	withBIPHeaderVerification := JOIN(withInquiries, BusinessHeaderVerificationRolled, LEFT.seq=RIGHT.seq, addBIPHeaderVer(LEFT,RIGHT), LEFT OUTER);

	//for FCRA these fields are not allowed so just set to -1 if no DID, else set to -2
	FCRAdefaults := project(ungroup(shell),
		transform(risk_indicators.Layout_Boca_Shell,
			self.BIP_Header.bus_seleids_peradl 						:= if(left.DID = integerZero, integerNeg1, integerNeg2);
			self.BIP_Header.bus_gold_seleids_peradl				:= if(left.DID = integerZero, integerNeg1, integerNeg2);
			self.BIP_Header.bus_active_seleids_peradl			:= if(left.DID = integerZero, integerNeg1, integerNeg2);
			self.BIP_Header.bus_inactive_seleids_peradl		:= if(left.DID = integerZero, integerNeg1, integerNeg2);
			self.BIP_Header.bus_defunct_seleids_peradl		:= if(left.DID = integerZero, integerNeg1, integerNeg2);
			self.BIP_Header.bus_gold_seleid_first_seen		:= if(left.DID = integerZero, integerNeg1, integerNeg2);
			self.BIP_Header.bus_header_first_seen					:= if(left.DID = integerZero, integerNeg1, integerNeg2);
			self.BIP_Header.bus_header_last_seen					:= if(left.DID = integerZero, integerNeg1, integerNeg2);
			self.BIP_Header.bus_header_build_date 				:= if(left.DID = integerZero, integerNeg1, integerNeg2);
			self.BIP_Header.bus_SOS_filings_peradl				:= if(left.DID = integerZero, integerNeg1, integerNeg2);
			self.BIP_Header.bus_active_SOS_filings_peradl	:= if(left.DID = integerZero, integerNeg1, integerNeg2);
			self.BIP_Header54.bus_ver_sources_total	:= if(left.DID = integerZero, integerNeg1, integerNeg2);
			self.BIP_Header54.bus_ver_sources	:= if(left.DID = integerZero, stringNeg1, stringNeg2);
			self.BIP_Header54.bus_ver_sources_first_seen	:= if(left.DID = integerZero, stringNeg1, stringNeg2);
			self.BIP_Header54.bus_ver_sources_last_seen	:= if(left.DID = integerZero, stringNeg1, stringNeg2);
			self.BIP_Header54.bus_fname_ver_sources_total	:= if(left.DID = integerZero, integerNeg1, integerNeg2);
			self.BIP_Header54.bus_fname_ver_sources	:= if(left.DID = integerZero, stringNeg1, stringNeg2);
			self.BIP_Header54.bus_fname_ver_sources_first_seen	:= if(left.DID = integerZero, stringNeg1, stringNeg2);
			self.BIP_Header54.bus_fname_ver_sources_last_seen	:= if(left.DID = integerZero, stringNeg1, stringNeg2);
			self.BIP_Header54.bus_lname_ver_sources_total	:= if(left.DID = integerZero, integerNeg1, integerNeg2);
			self.BIP_Header54.bus_lname_ver_sources	:= if(left.DID = integerZero, stringNeg1, stringNeg2);
			self.BIP_Header54.bus_lname_ver_sources_first_seen	:= if(left.DID = integerZero, stringNeg1, stringNeg2);
			self.BIP_Header54.bus_lname_ver_sources_last_seen	:= if(left.DID = integerZero, stringNeg1, stringNeg2);
			self.BIP_Header54.bus_addr_ver_sources_total	:= if(left.DID = integerZero, integerNeg1, integerNeg2);
			self.BIP_Header54.bus_addr_ver_sources	:= if(left.DID = integerZero, stringNeg1, stringNeg2);
			self.BIP_Header54.bus_addr_ver_sources_first_seen	:= if(left.DID = integerZero, stringNeg1, stringNeg2);
			self.BIP_Header54.bus_addr_ver_sources_last_seen	:= if(left.DID = integerZero, stringNeg1, stringNeg2);
			self.BIP_Header54.bus_ssn_ver_sources_total	:= if(left.DID = integerZero, integerNeg1, integerNeg2);
			self.BIP_Header54.bus_ssn_ver_sources	:= if(left.DID = integerZero, stringNeg1, stringNeg2);
			self.BIP_Header54.bus_ssn_ver_sources_first_seen	:= if(left.DID = integerZero, stringNeg1, stringNeg2);
			self.BIP_Header54.bus_ssn_ver_sources_last_seen	:= if(left.DID = integerZero, stringNeg1, stringNeg2);
			self.BIP_Header54.bus_phone_ver_sources_total	:= if(left.DID = integerZero, integerNeg1, integerNeg2);
			self.BIP_Header54.bus_phone_ver_sources	:= if(left.DID = integerZero, stringNeg1, stringNeg2);
			self.BIP_Header54.bus_phone_ver_sources_first_seen	:= if(left.DID = integerZero, stringNeg1, stringNeg2);
			self.BIP_Header54.bus_phone_ver_sources_last_seen	:= if(left.DID = integerZero, stringNeg1, stringNeg2);
			self.BIP_Header54.bus_sos_filings_not_instate	:= if(left.DID = integerZero, integerNeg1, integerNeg2);
			self.BIP_Header54.bus_ucc_count	:= if(left.DID = integerZero, integerNeg1, integerNeg2);
			self.BIP_Header54.bus_ucc_active_count	:= if(left.DID = integerZero, integerNeg1, integerNeg2);
			self.BIP_Header54.bus_inq_count12	:= if(left.DID = integerZero, integerNeg1, integerNeg2);
			self.BIP_Header54.bus_inq_credit_count12	:= if(left.DID = integerZero, integerNeg1, integerNeg2);
			self.BIP_Header54.bus_inq_highriskcredit_count12	:= if(left.DID = integerZero, integerNeg1, integerNeg2);
			self.BIP_Header54.bus_inq_other_count12	:= if(left.DID = integerZero, integerNeg1, integerNeg2);

			self := left));

	FinalBIP := map(isFCRA                    => FCRADefaults,
                 BSVersion >= 54            => withBIPHeaderVerification, //this is new for BS 5.4
                                               WithSOSFilings);


	// *********************
	//   DEBUGGING OUTPUTS
	// *********************
	// OUTPUT(CHOOSEN(CorpFilings_raw, 33), NAMED('CorpFilings_raw'));
	// OUTPUT(CHOOSEN(CorpFilings_Seq, 33), NAMED('CorpFilings_Seq'));
	// OUTPUT(CHOOSEN(kFetchErrorCodes, 33), NAMED('kFetchErrorCodes'));
	// OUTPUT(CHOOSEN(CorpFilings_withSrcCode, 33), NAMED('CorpFilings_withSrcCode'));
	// OUTPUT(CHOOSEN(CorpFilings_recs, 33), NAMED('CorpFilings_recs'));
	// OUTPUT(CHOOSEN(SortedCorpFilings, 33), NAMED('SortedCorpFilings'));
	// OUTPUT(CHOOSEN(RolledCorpFilings, 30), NAMED('RolledCorpFilings'));
	// OUTPUT(CHOOSEN(RolledSOSFilings, 30), NAMED('RolledSOSFilings'));
	// OUTPUT(CHOOSEN(WithSOSFilings, 30), NAMED('WithSOSFilings'));
	// OUTPUT(CHOOSEN(BusinessHeaderSeq, 300), NAMED('BusinessHeaderSeq'));
	// OUTPUT(CHOOSEN(BusinessHeader, 300), NAMED('BusinessHeader'));
	// OUTPUT(CHOOSEN(BusinessHeaderVerification, 300), NAMED('BusinessHeaderVerification'));
	// OUTPUT(CHOOSEN(BusinessHeaderVerificationRolled, 300), NAMED('BusinessHeaderVerificationRolled'));
	// OUTPUT(CHOOSEN(withBIPHeaderVerification, 300), NAMED('withBIPHeaderVerification'));

	// OUTPUT(CHOOSEN(UniqueRawFEINMatches, 100), NAMED('UniqueRawFEINMatches'));
	// OUTPUT(CHOOSEN(sortedBusinessHeader, 100), NAMED('sortedBusinessHeader'));
	// OUTPUT(COUNT(sortedBusinessHeader), NAMED('sortedBusinessHeaderCount'));
	// OUTPUT(CHOOSEN(rolledBusinessHeader, 100), NAMED('rolledBusinessHeader'));
	// OUTPUT(CHOOSEN(WithSeleIDFlag, 100), NAMED('WithSeleIDFlag'));
	// OUTPUT(CHOOSEN(RolledSOSFilings, 100), NAMED('RolledSOSFilings'));
	// OUTPUT(CHOOSEN(withSOSFilings, 100), NAMED('withSOSFilings'));
	// OUTPUT(CHOOSEN(InquiriesRaw, 100), NAMED('InquiriesRaw'));
	// OUTPUT(CHOOSEN(InquiriesSeq, 100), NAMED('InquiriesSeq'));
	// OUTPUT(CHOOSEN(InquiriesAllTemp, 100), NAMED('InquiriesAllTemp'));
	// OUTPUT(CHOOSEN(rolledInquiries, 100), NAMED('rolledInquiries'));
	// OUTPUT(CHOOSEN(withInquiries, 100), NAMED('withInquiries'));
	// OUTPUT(CHOOSEN(ds_ucc_linkidskey_recs, 100), NAMED('ds_ucc_linkidskey_recs'));
	// OUTPUT(COUNT(ds_ucc_linkidskey_recs), NAMED('ds_ucc_linkidskey_recs'));
	// OUTPUT(CHOOSEN(ds_ucc_linkidskey_seq, 100), NAMED('ds_ucc_linkidskey_seq'));
	// OUTPUT(COUNT(ds_ucc_linkidskey_seq), NAMED('ds_ucc_linkidskey_seq'));
	// OUTPUT(CHOOSEN(ds_ucc_linkidskey_filtered, 100), NAMED('ds_ucc_linkidskey_filtered'));
	// OUTPUT(COUNT(ds_ucc_linkidskey_recs), NAMED('ds_ucc_linkidskey_recs_count'));
	// OUTPUT(CHOOSEN(ds_linkids_keyrecs_slimmed, 100), NAMED('ds_linkids_keyrecs_slimmed'));
	// OUTPUT(CHOOSEN(ds_linkids_keyrecs_deduped, 100), NAMED('ds_linkids_keyrecs_deduped'));
	// OUTPUT(COUNT(ds_linkids_keyrecs_deduped), NAMED('ds_linkids_keyrecs_deduped_count'));
	// OUTPUT(CHOOSEN(ds_uccmain_keyrecs, 450), NAMED('ds_uccmain_keyrecs'));
	// OUTPUT(COUNT(ds_uccmain_keyrecs), NAMED('ds_uccmain_keyrecs_count'));
	// OUTPUT(COUNT(ds_ucc_RMSID_dedup), NAMED('ds_ucc_RMSID_dedup'));
	// OUTPUT(COUNT(ds_ucc_RMSID_dedup(status_code = 'A')), NAMED('ds_ucc_RMSID_dedup_active'));
	// OUTPUT(CHOOSEN(table_UCC_counts, 100), NAMED('table_UCC_counts'));
	RETURN FinalBIP;

END;