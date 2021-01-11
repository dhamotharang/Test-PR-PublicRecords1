// =====================================================================
// ROXIE QUERY
// -----------
// For the complete list of input parameters please check published WU.
// Look at the history of this attribute for the old SOAP info.
// =====================================================================
IMPORT  AutoStandardI,PhonesFeedback, PhonesFeedback_Services, AddressFeedback_Services, WSInput, Royalty, Suppress;

EXPORT HeaderFileSearchService := MACRO
#constant('SearchLibraryVersion', AutoheaderV2.Constants.LibVersion.SALT);

		//The following macro defines the field sequence on WsECL page of query.
		WSInput.MAC_HeaderFileSearchService();

		#CONSTANT('MaxRelatives',0);
		boolean  IncludePhonesFeedback := false : stored('IncludePhonesFeedback');
		boolean  IncludeAddressFeedback := false : stored('IncludeAddressFeedback');
		set of string Include_SourceList := [] : stored('IncludeSourceList'); // keeping name in sync with IncludeSourceList in Doxie.HeaderSource_Service

    doxie.MAC_Header_Field_Declare() //date_first_seen_value, date_last_seen_value, allow_date_seen_value, allow_wildcard_val, some includes, etc.
    mod_access := doxie.compliance.GetGlobalDataAccessModule();
		unsigned seq_value := 0 : STORED('seq');

		// Added for the FDN project, 1 new input option & 3 required input fields
		boolean IncludeFraudDefenseNetwork := false : stored('IncludeFraudDefenseNetwork');
		unsigned6 in_FDN_gcid     := 0 : stored('GlobalCompanyId');
		unsigned2 in_FDN_indtype  := 0 : stored('IndustryType');
		unsigned6 in_FDN_prodcode := 0 : stored('ProductCode');

		outf := doxie.header_records(true, allow_wildcard_val);
		presRecs := PROJECT(outf, doxie.layout_presentation);

		ta_ready := doxie.header_presentation(presRecs, mod_access);

		doxie.MAC_Apply_DtSeen_Filter(ta_ready, ta_filtered, last_seen, first_seen);

		ta1 := if(allow_date_seen_value and date_last_seen_value<>0 and pname_value<>'', ta_filtered, ta_ready);

		// doxie.MAC_Marshall_Results(ta1,ta2);
		// ta3 := TABLE(ta2,{unsigned4 seq := seq_value,ta2});
		// ta3_tmp := TABLE(ta2,{unsigned4 seq := seq_value,ta2});

		rec_with_Feedback := doxie.Layout_Search.rec_with_Feedback;

		sdocfilter := doxie.SourceDocFilter.GetBitmask(Include_SourceList);

		rec_with_Feedback xform_final(recordof (ta1) le):=transform
		filtered_rids 		:= doxie.rid_cnt.rid_filter(le.rids, sdocfilter);
		self.rid_cnt			:= if(Include_SourceDocCounts, doxie.rid_cnt.rid_cnt(filtered_rids), 0);
		self.src_cnt			:= if(Include_SourceDocCounts, doxie.rid_cnt.src_cnt(filtered_rids), 0);
		self.src_doc_cnt	:= if(Include_SourceDocCounts, doxie.rid_cnt.src_doc_cnt(filtered_rids), 0);
		self.rids					:= if(Include_SourceDocCounts, doxie.rid_cnt.clean(filtered_rids), dataset([], doxie.rid_cnt.l_triple));
		self.Feedback 				:= DATASET ([], PhonesFeedback_Services.Layouts.feedback_report);
		self.Listed_Feedback 	:= DATASET ([], PhonesFeedback_Services.Layouts.feedback_report);
		self.Address_Feedback	:= DATASET ([], AddressFeedback_Services.Layouts.feedback_report);
		SELF.IsCurrent := le.tnt in doxie.rollup_limits.TNT_CURRENT_SET;
				 // added for IRB customization project to
	       // signify to ESP/downstream to show 'current'
				 // in output field for instead of using value in 'dt_last_seen' field
		self:=le;
		end;
		ta1_tmp:= project(ta1,xform_final(Left));

		PhonesFeedback_Services.Mac_Append_Feedback(ta1_tmp
																								,did
																								,listed_phone
																								,ta1_tmp_LF
																								,mod_access
                                           ,Listed_Feedback);

		PhonesFeedback_Services.Mac_Append_Feedback(ta1_tmp_LF
																								,did
																								,Phone
																								,ta1_feedback
                                           ,mod_access
																								);

		ta_phFeedback:=if(IncludePhonesFeedback,ta1_feedback,ta1_tmp);

		AddressFeedback_Services.MAC_Append_Feedback(ta_phFeedback,ta_addrFeedback,Address_Feedback);

		results := if(IncludeAddressFeedback, ta_addrFeedback, ta_phFeedback);

		// This section of coding immediately below was added for the FDN project.
		// Created shorter alias names to be passed into new function below.
		boolean FDNContDataPermitted := doxie.DataPermission.use_FDNContributoryData;
		boolean FDNInqDataPermitted  := ~doxie.DataRestriction.FDNInquiry;

		// If FDN was asked for, call the new function to set the new fdn indicators.
		ds_results_with_fdninds := if(IncludeFraudDefenseNetwork,
																	doxie.func_FdnCheckSearchRecs(
																		 results,
																		 in_FDN_gcid, in_FDN_indtype, in_FDN_prodcode,
																		 FDNContDataPermitted, FDNInqDataPermitted),
																	//Otherwise just pass along the original results dataset
																	results);

    FDN_check     := ds_results_with_fdninds(fdn_results_found = true);
	  FDN_Royalties := Royalty.RoyaltyFDNCoRR.GetOnlineRoyalties(FDN_check);
    royalties     := if(IncludeFraudDefenseNetwork, FDN_Royalties);
    OUTPUT(Royalties, NAMED('RoyaltySet'));

		doxie.MAC_Marshall_Results(ds_results_with_fdninds,ta2);
		ta3 := TABLE(ta2,{unsigned4 seq := seq_value,ta2});

		MAP( did_only => output(DEDUP(table(outf, {did}), did)),
				 Raw_Records => output(outf),
			 output(ta3, NAMED('Results')))

ENDMACRO;
