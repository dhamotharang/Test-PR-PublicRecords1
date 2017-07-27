import BIPV2, iesp, Watercraft;

export WatercraftSection_Layouts := module;

	export rec_ids_with_linkidsdata_slimmed := record
		BIPV2.IDlayouts.l_header_ids;
		// For BIP2, use this---^ OR this ---v ???   Here and below???
	  //iesp.share.t_BusinessIdentity; //BIP2, version 2
	  TopBusiness_Services.Layouts.rec_common.source;
	  TopBusiness_Services.Layouts.rec_common.source_docid; //???
		// v--- other new linkids key file fields needed to link to existing wc key(s)
	  Watercraft.Layout_Watercraft_Main_Base.watercraft_key;
	  Watercraft.Layout_Watercraft_Main_Base.sequence_key;
	  Watercraft.Layout_Watercraft_Main_Base.state_origin;
		// other fields that may be needed???
	  //Watercraft.Layout_Watercraft_Main_Base.source_code;
	  //Watercraft.Layout_Watercraft_Main_Base.persistent_record_id; //???
		//Watercraft.Layout_Watercraft_Main_Base.source_rec_id; //???
		//Watercraft.Layout_Watercraft_Main_Base.history_flag; //???
	end;		

/*
  // Is this layout (---v) really needed???
	export rec_child_source := record
    BIPV2.IDlayouts.l_header_ids; // BIP2, version 1
		// For BIP2, use this---^ OR this ---v ???
	  //iesp.share.t_BusinessIdentity; //BIP2, version 2
		TopBusiness_Services.Layouts.rec_common.source;
		TopBusiness_Services.Layouts.rec_common.source_docid; //add for bip2 ???
		//TopBusiness_Services.Layouts.rec_common.source_recid; //add for bip2 ???
	end;
*/

  export rec_child_party := record
		BIPV2.IDlayouts.l_header_ids;
		// v--- new linkids key file fields needed to link to existing party(sid) key
		rec_ids_with_linkidsdata_slimmed.watercraft_key; //needed for linking to the wc main wid key
		rec_ids_with_linkidsdata_slimmed.sequence_key; //needed for linking to the wc main wid key
		rec_ids_with_linkidsdata_slimmed.state_origin; //needed for linking to the wc main wid key
    // v--- party (sid) key fields used for report output
		Watercraft.Layout_Watercraft_Search_Base_slim.orig_name_type_description;
    Watercraft.Layout_Watercraft_Search_Base_slim.title;
    Watercraft.Layout_Watercraft_Search_Base_slim.fname;
	  Watercraft.Layout_Watercraft_Search_Base_slim.mname;
	  Watercraft.Layout_Watercraft_Search_Base_slim.lname;
	  Watercraft.Layout_Watercraft_Search_Base_slim.name_suffix;
    Watercraft.Layout_Watercraft_Search_Base_slim.company_name;
	  Watercraft.Layout_Watercraft_Search_Base_slim.prim_range;
	  Watercraft.Layout_Watercraft_Search_Base_slim.predir;
	  Watercraft.Layout_Watercraft_Search_Base_slim.prim_name;
	  Watercraft.Layout_Watercraft_Search_Base_slim.suffix;
	  Watercraft.Layout_Watercraft_Search_Base_slim.postdir;
	  Watercraft.Layout_Watercraft_Search_Base_slim.unit_desig;
	  Watercraft.Layout_Watercraft_Search_Base_slim.sec_range;
	  //string25	p_city_name;
	  //string25	v_city_name;
    string25 city_name;  //p_city_name and/or v_city_name ???
	  Watercraft.Layout_Watercraft_Search_Base_slim.st;
	  Watercraft.Layout_Watercraft_Search_Base_slim.zip5;
	  Watercraft.Layout_Watercraft_Search_Base_slim.zip4;
		//Watercraft.Layout_Watercraft_Search_Base_slim.county; //3 digit fips_county code???

		// v--- other sid/party key fields not in biz rpt, but that might be needed for some 
		//      kind of internal processing???
	  // string8		date_first_seen;
	  // string8		date_last_seen;
	  // string8		date_vendor_first_reported;
	  // string8		date_vendor_last_reported;
	  // string2		source_code;
	  // string1		dppa_flag;
	  // string1		orig_name_type_code;
	  // string20	  orig_name_type_description;
	  // string9		orig_ssn;
	  // string9		orig_fein;
	  // string9		fein;
	  // string9		ssn;
	  // string1		history_flag; // contents indicate current (blank) or prior (non-blank)
	  // string100 Reg_Owner_Name_2:=''; 
	  // unsigned8 persistent_record_id := 0; 

		// v--- internal field derived from the sid key history_flag field ???
		string1  current_prior_party; // needed here to distinguish current vs prior parties???
	end;

  export rec_parent_wcdetail := record
		BIPV2.IDlayouts.l_header_ids;
	  TopBusiness_Services.Layouts.rec_common.source;  // needed here???
	  TopBusiness_Services.Layouts.rec_common.source_docid;  //needed here???
		// v--- new linkids key file fields needed to link to existing main (wid) key
		rec_ids_with_linkidsdata_slimmed.watercraft_key; //needed for linking to the ucc main key
		rec_ids_with_linkidsdata_slimmed.sequence_key; //needed for linking to the ucc main key
		rec_ids_with_linkidsdata_slimmed.state_origin; //needed for linking to the ucc main key
    // v--- main (wid) key vessel/registration fields used for report output
	  Watercraft.Layout_Watercraft_Main_Base.st_registration;
		Watercraft.Layout_Watercraft_Main_Base.hull_number;
	  Watercraft.Layout_Watercraft_Main_Base.model_year;
		Watercraft.Layout_Watercraft_Main_Base.watercraft_make_description;
	  Watercraft.Layout_Watercraft_Main_Base.watercraft_model_description;
	  Watercraft.Layout_Watercraft_Main_Base.propulsion_description;
	  Watercraft.Layout_Watercraft_Main_Base.watercraft_length;
	  Watercraft.Layout_Watercraft_Main_Base.use_description;
	  Watercraft.Layout_Watercraft_Main_Base.watercraft_name; 
	  Watercraft.Layout_Watercraft_Main_Base.registration_status_description;
	  Watercraft.Layout_Watercraft_Main_Base.registration_number;
	  Watercraft.Layout_Watercraft_Main_Base.registration_date;
	  Watercraft.Layout_Watercraft_Main_Base.registration_expiration_date;
		// v--- internal derived field(s?)
		boolean NonDMVSource;
		string1   current_prior;   // C=Current & P=Prior, built from wid key history_flag
    // v--- not in biz rpt, but may needed to determine current/prior above ???
		//      store with same name as on the watercraft wid key? or re-name to above??? 
		//Watercraft.Layout_Watercraft_Main_Base.history_flag; // contents indicate current (blank) or prior (non-blank)???
	  //Watercraft.Layout_Watercraft_Main_Base.persistent_record_id :=0;
		
		// v--- needed to pass total counts on to the next higher level records???
	  unsigned4 total_current := 0; //default to zero
		unsigned4 total_prior   := 0; //default to zero
    // v--- needed to simulate iesp watercraft section t_TopBusinessWatercraftDetail layout
    dataset(rec_child_party) current_parties 
		    {maxcount(iesp.constants.TOPBUSINESS.MAX_COUNT_BIZRPT_WATERCRAFT_PARTY_RECORDS)};
    dataset(rec_child_party) prior_parties 
		    {maxcount(iesp.constants.TOPBUSINESS.MAX_COUNT_BIZRPT_WATERCRAFT_PARTY_RECORDS)};	
  end;

  // v--- is this really needed or not???
	export rec_ids_plus_WatercraftDetail := record
		BIPV2.IDlayouts.l_header_ids;
	  TopBusiness_Services.Layouts.rec_common.source;  // needed here???
	  TopBusiness_Services.Layouts.rec_common.source_docid;  //needed here???
		rec_parent_wcdetail.current_prior; //???
	  rec_parent_wcdetail.total_current;  //???
		rec_parent_wcdetail.total_prior;    //???
		iesp.topbusinessReport.t_TopbusinessWatercraftDetail;
	end;		

	export rec_ids_plus_WatercraftRecord := record
		TopBusiness_Services.Layouts.rec_input_ids.acctno;
		BIPV2.IDlayouts.l_header_ids;
	  rec_parent_wcdetail.total_current;
		rec_parent_wcdetail.total_prior;
		iesp.topbusinessReport.t_TopbusinessWatercraft;
	end;		

	export rec_final := record
		TopBusiness_Services.Layouts.rec_input_ids.acctno;
		iesp.topbusinessReport.t_TopBusinessWatercraftSection; //???
	end;

end;
/* iesp.TopBusinessReport watercraft related layouts:
...
export t_TopBusinessReportItemInfo := record
	share.t_BusinessIdentity BusinessIds {xpath('BusinessIds')};
	string2 SourceCode {xpath('SourceCode')};
	string50 SourceDocId {xpath('SourceDocId')};
end;
...
export t_TopBusinessWatercraftParty := record
	string20 PartyTypeDescription {xpath('PartyTypeDescription')};
	string60 CompanyName {xpath('CompanyName')};
	share.t_Name Name {xpath('Name')};
	share.t_Address Address {xpath('Address')};
end;
		
export t_TopBusinessWatercraftDetail := record
	dataset(t_TopBusinessReportItemInfo) SourceDocs {xpath('SourceDocs/SourceDoc'), MAXCOUNT(iesp.constants.TOPBUSINESS.MAX_COUNT_BIZRPT_SRCDOC_RECORDS)};
	string2 StateJurisdiction {xpath('StateJurisdiction')};
	string30 HullNumber {xpath('HullNumber')};
	integer ModelYear {xpath('ModelYear')};
	string30 VesselMake {xpath('VesselMake')};
	string30 VesselModel {xpath('VesselModel')};
	string20 Propulsion {xpath('Propulsion')};
	string7 Length {xpath('Length')};
	string20 Use {xpath('Use')};
	string50 VesselName {xpath('VesselName')};
	string40 RegistrationStatus {xpath('RegistrationStatus')};
	string20 RegistrationNumber {xpath('RegistrationNumber')};
	share.t_Date RegistrationDate {xpath('RegistrationDate')};
	share.t_Date ExpirationDate {xpath('ExpirationDate')};
	dataset(t_TopBusinessWatercraftParty) PriorParties {xpath('PriorParties/PriorParty'), MAXCOUNT(iesp.Constants.TOPBUSINESS.MAX_COUNT_BIZRPT_WATERCRAFT_PARTY_RECORDS)};
	dataset(t_TopBusinessWatercraftParty) CurrentParties {xpath('CurrentParties/CurrentParty'), MAXCOUNT(iesp.Constants.TOPBUSINESS.MAX_COUNT_BIZRPT_WATERCRAFT_PARTY_RECORDS)};
end;
		
export t_TopBusinessWatercraft := record
	integer CurrentRecordCount {xpath('CurrentRecordCount')};
	integer TotalCurrentRecordCount {xpath('TotalCurrentRecordCount')};
	dataset(t_TopBusinessWatercraftDetail) CurrentWatercrafts {xpath('CurrentWatercrafts/Watercraft'), MAXCOUNT(iesp.Constants.TOPBUSINESS.MAX_COUNT_BIZRPT_WATERCRAFT_MAIN_RECORDS)};
	dataset(t_TopBusinessReportItemInfo) CurrentSourceDocs {xpath('CurrentSourceDocs/SourceDoc'), MAXCOUNT(iesp.constants.TOPBUSINESS.MAX_COUNT_BIZRPT_SRCDOC_RECORDS)};
	integer PriorRecordCount {xpath('PriorRecordCount')};
	integer TotalPriorRecordCount {xpath('TotalPriorRecordCount')};
	dataset(t_TopBusinessWatercraftDetail) PriorWatercrafts {xpath('PriorWatercrafts/Watercraft'), MAXCOUNT(iesp.Constants.TOPBUSINESS.MAX_COUNT_BIZRPT_WATERCRAFT_MAIN_RECORDS)};
	dataset(t_TopBusinessReportItemInfo) PriorSourceDocs {xpath('PriorSourceDocs/SourceDoc'), MAXCOUNT(iesp.constants.TOPBUSINESS.MAX_COUNT_BIZRPT_SRCDOC_RECORDS)};
end;
		
export t_TopBusinessWatercraftSection := record
	integer WatercraftRecordCount {xpath('WatercraftRecordCount')}; // <--- is this needed at this level???
	integer TotalWatercraftRecordCount {xpath('TotalWatercraftRecordCount')};
	t_TopBusinessWatercraft WatercraftRecords {xpath('WatercraftRecords')};
end;
...
*/