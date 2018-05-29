/*--SOAP--
<message name="headerFileSearchRequest" fast_display = "true">
	<part name="seq" type="xsd:integer"/>
  <part name="SSN" type="xsd:string"/>
  <part name="SSNTypos" type="xsd:boolean"/>
	<part name="UnParsedFullName" type="xsd:string"/>
  <part name="FirstName" type="xsd:string"/>
  <part name="AllowNickNames" type="xsd:boolean"/>
  <part name="RelativeFirstName1" type="xsd:string"/>
  <part name="RelativeFirstName2" type="xsd:string"/>
  <part name="LastName" type="xsd:string"/>
  <part name="OtherLastName1" type="xsd:string"/>
  <part name="PhoneticMatch" type="xsd:boolean"/>
  <part name="PhoneticDistanceMatch" type="xsd:boolean"/>
  <part name="DistanceThreshold" type="xsd:unsignedInt"/>
  <part name="MiddleName" type="xsd:string"/>
  <part name="Addr" type="xsd:string"/>
  <part name="City" type="xsd:string"/>
  <part name="OtherCity1" type="xsd:string"/>
  <part name="County" type="xsd:string"/>
  <part name="State" type="xsd:string"/>
  <part name="OtherState1" type="xsd:string"/>
  <part name="OtherState2" type="xsd:string"/>
  <part name="Zip" type="xsd:string"/>
  <part name="ZipRadius" type="xsd:unsignedInt"/>
	<part name="CurrentResidentsOnly" type="xsd:boolean"/>
	<part name="FuzzySecRange"		type="xsd:integer"/>
  <part name="Phone" type="xsd:string"/>
  <part name="DOB" type="xsd:unsignedInt"/>
  <part name="AgeLow" type="xsd:byte"/>
  <part name="AgeHigh" type="xsd:byte"/>
  <part name="AllowDateSeen" type="xsd:boolean"/>
  <part name="DateFirstSeen" type="xsd:integer"/>
  <part name="DateLastSeen" type="xsd:integer"/>
  <part name="DID" type="xsd:string" required="1"/>
  <part name="Household" type="xsd:boolean"/> 
  <part name="LookupType" type="xsd:string"/>
  <part name="RID" type="xsd:string"/>
  <part name="IncludeAllDIDRecords" type="xsd:boolean"/>
  <part name="MaxResults" type="xsd:unsignedInt"/>
  <part name="MaxResultsThisTime" type="xsd:unsignedInt"/>
  <part name="SkipRecords" type="xsd:unsignedInt"/>
  <part name="DPPAPurpose" type="xsd:byte"/>
  <part name="GLBPurpose" type="xsd:byte"/> 
  <part name="NoLookupSearch" type="xsd:boolean"/>
  <part name="BestOnly" type="xsd:boolean"/>
  <part name="DoNotFillBlanks" type="xsd:boolean"/> 
  <part name="Raw" type="xsd:boolean"/> 
  <part name="DIDOnly" type="xsd:boolean"/>
  <part name="ScoreThreshold" type="xsd:unsignedInt"/>
  <part name="SSNMask" type="xsd:string"/>
  <part name="DLMask" type="xsd:string"/>
  <part name="IndustryClass" type="xsd:string"/>
	<part name="IncludeZeroDIDRefs" type="xsd:boolean"/>
  <part name="IncludeHRI" type="xsd:boolean"/>
  <part name="MaxHriPer" type="xsd:unsignedInt"/>
  <part name="ProbationOverride" type="xsd:boolean"/>
  <part name="LnBranded" type="xsd:boolean"/>
  <part name="KeepOldSsns" type="xsd:boolean"/>
  <part name="UsingKeepSsns" type="xsd:boolean"/>	
	<part name="DataRestrictionMask" type="xsd:string"/>
	<part name="DataPermissionMask" type="xsd:string"/>
	<part name="DidTypeMask" type="xsd:string"/>
  <part name="DialContactPrecision" type="xsd:unsignedInt"/>
  <part name="AllowWildcard" type="xsd:boolean"/>
  <part name="AllowHeaderQuick" type="xsd:boolean"/>
	<part name="NonExclusion" type="xsd:boolean"/>
	<part name="StrictMatch"	type="xsd:boolean"/>
	<part name="IncludeDLInfo" type="xsd:boolean"/>
	<part name="IncludePhonesFeedback" type="xsd:boolean"/>
	<part name="IncludeAddressFeedback" type="xsd:boolean"/>
	<part name="IncludeSourceDocCounts" type="xsd:boolean"/>
	<part name="IncludeSourceList" type="tns:EspStringArray"/>
	<part name="ReturnAlsoFound" type = "xsd:boolean"/>
	<part name="ECL_NegateTrueDefaults" type = "xsd:boolean"/>
  <part name="IncludeBankruptcyCount" type = "xsd:boolean"/>
  <part name="IncludeCriminalIndicators" type="xsd:boolean"/>
	<part name="IncludeCriminalImageIndicators" type="xsd:boolean"/>
	<part name="ExcludeDMVPII" type="xsd:boolean"/>

	<!-- FDN only option/fields -->
	<part name="IncludeFraudDefenseNetwork" type="xsd:boolean"/>
	<part name="GlobalCompanyId"				    type="xsd:unsignedInt"/>
	<part name="IndustryType"	    			    type="xsd:unsignedInt"/>
	<part name="ProductCode"		  		      type="xsd:unsignedInt"/>

</message>
*/
/*--INFO-- This service searches the header file.*/
/*
<message name="headerFileSearchRequest" wuTimeout="300000">
*/

IMPORT PhonesFeedback,PhonesFeedback_Services,doxie,Risk_Indicators,iesp,AddressFeedback,AddressFeedback_Services,WSInput,Royalty;
EXPORT HeaderFileSearchService := MACRO
#constant('SearchLibraryVersion', AutoheaderV2.Constants.LibVersion.LEGACY);
		
		//The following macro defines the field sequence on WsECL page of query. 
		WSInput.MAC_HeaderFileSearchService();
		
		#CONSTANT('MaxRelatives',0);
		boolean  IncludePhonesFeedback := false : stored('IncludePhonesFeedback');
		boolean  IncludeAddressFeedback := false : stored('IncludeAddressFeedback');
		set of string Include_SourceList := [] : stored('IncludeSourceList'); // keeping name in sync with IncludeSourceList in Doxie.HeaderSource_Service
		doxie.MAC_Header_Field_Declare()
		unsigned seq_value := 0 : STORED('seq');

		// Added for the FDN project, 1 new input option & 3 required input fields
		boolean IncludeFraudDefenseNetwork := false : stored('IncludeFraudDefenseNetwork');
		unsigned6 in_FDN_gcid     := 0 : stored('GlobalCompanyId');
		unsigned2 in_FDN_indtype  := 0 : stored('IndustryType');
		unsigned6 in_FDN_prodcode := 0 : stored('ProductCode');

		outf := doxie.header_records(true, allow_wildcard_val);
		presRecs := PROJECT(outf, doxie.layout_presentation);

		ta_ready := doxie.header_presentation(presRecs);

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
																								,Listed_Feedback);
															
		PhonesFeedback_Services.Mac_Append_Feedback(ta1_tmp_LF
																								,did
																								,Phone
																								,ta1_feedback
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
// HeaderFileSearchService();