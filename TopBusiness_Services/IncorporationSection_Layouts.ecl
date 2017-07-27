import BIPV2, BusReg, Corp2, iesp, Standard;

export IncorporationSection_Layouts := module;

 	export rec_ids_with_keydata_slimmed := record
		BIPV2.IDlayouts.l_header_ids;
	  TopBusiness_Services.Layouts.rec_common.source;
	  TopBusiness_Services.Layouts.rec_common.source_docid;
	  //TopBusiness_Services.Layouts.rec_common.source_recid; //???
    // v--- Corp linkids key fields used on report output or for internal processing, 
		//      in order by req 0500 output order
	  Corp2.Layout_Corporate_Direct_Corp_Base.corp_legal_name; // length=350 on base corp2 corp, but that seems excessive
    Corp2.Layout_Corporate_Direct_Corp_Base.corp_orig_sos_charter_nbr; //AKA Filing Number
    Corp2.Layout_Corporate_Direct_Corp_Base.corp_ln_name_type_desc; //needed for sorting

    // v--- Business Type (corp org structure) related "raw" corp fields from the state, not standardized.
		// These 4 (---v) are used by Corp2.fCorp2_As_Business_Linking to call corp2.Linking_filters.org_structure(... 
    Corp2.Layout_Corporate_Direct_Corp_Base.corp_orig_org_structure_desc;
    //Corp2.Layout_Corporate_Direct_Corp_Base.corp_state_origin;  // stored below
		Corp2.Layout_Corporate_Direct_Corp_Base.corp_orig_bus_type_desc;
    Corp2.Layout_Corporate_Direct_Corp_Base.corp_name_comment;
    string60 company_org_structure_raw; // Corp2.linking filter output value
    string60 business_type;             // BH standardized value

    Corp2.Layout_Corporate_Direct_Corp_Base.corp_filing_date; //needed/used to determine latest
		Corp2.Layout_Corporate_Direct_Corp_Base.corp_status_date; //needed/used to determine latest
    Corp2.Layout_Corporate_Direct_Corp_Base.corp_inc_date;   
		string8 latest_filing_date; //Filing_Date (most recent) internally determined

    // v--- Business Status related "raw" corp fields from the state, not standardized
		// These 3 (---v) are used by Corp2.fCorp2_As_Business_Linking to call corp2.Linking_filters.company_status(... 
		Corp2.Layout_Corporate_Direct_Corp_Base.corp_status_desc; 
    //Corp2.Layout_Corporate_Direct_Corp_Base.corp_state_origin;  // stored below
    Corp2.Layout_Corporate_Direct_Corp_Base.corp_status_comment; 
    string60 company_status_raw; // Corp2.linking filter output value
		string60 business_status;    // BH standardized value

    // v--- Name Status related "raw" corp fields from the state, not standardized
		// These 3 (---v) are used by Corp2.fCorp2_As_Business_Linking to call corp2.Linking_filters.name_status(...
    //Corp2.Layout_Corporate_Direct_Corp_Base.corp_name_comment; // already stored above
    //Corp2.Layout_Corporate_Direct_Corp_Base.corp_state_origin; // stored below
		//Corp2.Layout_Corporate_Direct_Corp_Base.corp_status_desc;  // already stored above
    string50 company_name_status_raw; // Corp2.linking filter output value
    string50 name_status;             // BH standardized value

		Corp2.Layout_Corporate_Direct_Corp_Base.corp_foreign_domestic_ind; //i.e. blank, D or F
		Corp2.Layout_Corporate_Direct_Corp_Base.corp_forgn_state_cd; 
		Corp2.Layout_Corporate_Direct_Corp_Base.corp_forgn_state_desc; 
		Corp2.Layout_Corporate_Direct_Corp_Base.corp_forgn_date;
		Corp2.Layout_Corporate_Direct_Corp_Base.corp_for_profit_ind; // blank, N or Y
		Corp2.Layout_Corporate_Direct_Corp_Base.corp_filing_desc; // AKA Filing_Type

		//v--- fields used from the corporation "events" file
		//     Put on this layout to be filled in after getting the data from the events file
		Corp2.Layout_Corporate_Direct_Event_In.event_filing_date;
		Corp2.Layout_Corporate_Direct_Event_In.event_filing_desc;

    // Expiration related "raw" corp & internal fields to use
		Corp2.Layout_Corporate_Direct_Corp_Base.corp_term_exist_cd; 
    Corp2.Layout_Corporate_Direct_Corp_Base.corp_term_exist_exp; 
		Corp2.Layout_Corporate_Direct_Corp_Base.corp_term_exist_desc;
		Corp2.Layout_Corporate_Direct_Corp_Base.corp_forgn_term_exist_cd; 
    Corp2.Layout_Corporate_Direct_Corp_Base.corp_forgn_term_exist_exp; 
		Corp2.Layout_Corporate_Direct_Corp_Base.corp_forgn_term_exist_desc;

    string8	 existence_code; // blank, D, P OR N
    string8  existence_expiration;  // an expiration_date, "P" or the # of years
		string60 existence_desc; //the word "DATE OF EXPIRATION", "PERPETUAL", "nn YEARS", "INDEFINITE", etc.

    Corp2.Layout_Corporate_Direct_Corp_Base.corp_state_origin; // AKA State or Jurisdiction

    // Fields added for bug 150019, needed for the Accurint version of the new BIP Bus Comp Rpt
	  Corp2.Layout_Corporate_Direct_Corp_Base.corp_address1_type_desc; 
	  Corp2.Layout_Corporate_Direct_Corp_Base.corp_addr1_prim_range;
	  Corp2.Layout_Corporate_Direct_Corp_Base.corp_addr1_predir;
	  Corp2.Layout_Corporate_Direct_Corp_Base.corp_addr1_prim_name;
	  Corp2.Layout_Corporate_Direct_Corp_Base.corp_addr1_addr_suffix;
	  Corp2.Layout_Corporate_Direct_Corp_Base.corp_addr1_postdir;
	  Corp2.Layout_Corporate_Direct_Corp_Base.corp_addr1_unit_desig;
	  Corp2.Layout_Corporate_Direct_Corp_Base.corp_addr1_sec_range;
	  Corp2.Layout_Corporate_Direct_Corp_Base.corp_addr1_p_city_name;
	  Corp2.Layout_Corporate_Direct_Corp_Base.corp_addr1_v_city_name;
	  Corp2.Layout_Corporate_Direct_Corp_Base.corp_addr1_state;
	  Corp2.Layout_Corporate_Direct_Corp_Base.corp_addr1_zip5;
	  Corp2.Layout_Corporate_Direct_Corp_Base.corp_addr1_zip4;

	  Corp2.Layout_Corporate_Direct_Corp_Base.corp_address2_type_desc;
	  Corp2.Layout_Corporate_Direct_Corp_Base.corp_addr2_prim_range;
	  Corp2.Layout_Corporate_Direct_Corp_Base.corp_addr2_predir;
	  Corp2.Layout_Corporate_Direct_Corp_Base.corp_addr2_prim_name;
	  Corp2.Layout_Corporate_Direct_Corp_Base.corp_addr2_addr_suffix;
	  Corp2.Layout_Corporate_Direct_Corp_Base.corp_addr2_postdir;
	  Corp2.Layout_Corporate_Direct_Corp_Base.corp_addr2_unit_desig;
	  Corp2.Layout_Corporate_Direct_Corp_Base.corp_addr2_sec_range;
	  Corp2.Layout_Corporate_Direct_Corp_Base.corp_addr2_p_city_name;
	  Corp2.Layout_Corporate_Direct_Corp_Base.corp_addr2_v_city_name;
	  Corp2.Layout_Corporate_Direct_Corp_Base.corp_addr2_state;
	  Corp2.Layout_Corporate_Direct_Corp_Base.corp_addr2_zip5;
	  Corp2.Layout_Corporate_Direct_Corp_Base.corp_addr2_zip4;

		Corp2.Layout_Corporate_Direct_Corp_Base.corp_standing;
 	  Corp2.Layout_Corporate_Direct_Corp_Base.corp_addl_info;
	  Corp2.Layout_Corporate_Direct_Corp_Base.corp_ra_name;
    Corp2.Layout_Corporate_Direct_Corp_Base.corp_ra_title1;
	  Corp2.Layout_Corporate_Direct_Corp_Base.corp_ra_fname1;
	  Corp2.Layout_Corporate_Direct_Corp_Base.corp_ra_mname1;
	  Corp2.Layout_Corporate_Direct_Corp_Base.corp_ra_lname1;
    Corp2.Layout_Corporate_Direct_Corp_Base.corp_ra_name_suffix1;
    Corp2.Layout_Corporate_Direct_Corp_Base.corp_ra_cname1;
    Corp2.Layout_Corporate_Direct_Corp_Base.corp_ra_prim_range;
    Corp2.Layout_Corporate_Direct_Corp_Base.corp_ra_predir;
    Corp2.Layout_Corporate_Direct_Corp_Base.corp_ra_prim_name;
    Corp2.Layout_Corporate_Direct_Corp_Base.corp_ra_addr_suffix;
    Corp2.Layout_Corporate_Direct_Corp_Base.corp_ra_postdir;
    Corp2.Layout_Corporate_Direct_Corp_Base.corp_ra_unit_desig;
    Corp2.Layout_Corporate_Direct_Corp_Base.corp_ra_sec_range;
    Corp2.Layout_Corporate_Direct_Corp_Base.corp_ra_p_city_name;
    Corp2.Layout_Corporate_Direct_Corp_Base.corp_ra_v_city_name;
    Corp2.Layout_Corporate_Direct_Corp_Base.corp_ra_state;
    Corp2.Layout_Corporate_Direct_Corp_Base.corp_ra_zip5;
    Corp2.Layout_Corporate_Direct_Corp_Base.corp_ra_zip4;
    // end of fields added for Accurint version of the report.

		// Not output on report, but needed to match to the corp "Events" key
		Corp2.Layout_Corporate_Direct_Corp_Base.corp_key; // needed for linking to corp events key file
		// other fields needed for internal linking/processing
    Corp2.Layout_Corporate_Direct_Corp_Base.dt_first_seen;
    Corp2.Layout_Corporate_Direct_Corp_Base.dt_last_seen;
    Corp2.Layout_Corporate_Direct_Corp_Base.dt_vendor_first_reported;
    Corp2.Layout_Corporate_Direct_Corp_Base.dt_vendor_last_reported;
		Corp2.Layout_Corporate_Direct_Corp_Base.corp_process_date;
		Corp2.Layout_Corporate_Direct_Corp_Base.record_type; // 'C' Current & 'H' Historical
    unsigned4 total_corps_per_linkids;
		
		string32 filing_number; // common field name to store both corp & busreg filing number info

		// v--- BusReg fields
    BusReg.Layouts.Base.full.rawfields.corpcode;
		BusReg.Layouts.Base.full.rawfields.sos_code;
		BusReg.Layouts.Base.full.rawfields.state_code;
		BusReg.Layouts.Base.full.rawfields.status;
		//BusReg.Layouts.Base.full.rawfields.stat_des; //???
		BusReg.Layouts.Base.full.rawfields.filing_num;
		BusReg.Layouts.Base.full.rawfields.start_date;
		BusReg.Layouts.Base.full.rawfields.file_date;
		BusReg.Layouts.Base.full.rawfields.ccyymmdd;
		BusReg.Layouts.Base.full.rawfields.exp_date;
 end; 

	export rec_IncorporationChild_Source := record 
    BIPV2.IDlayouts.l_header_ids; //needed on this level???
		TopBusiness_Services.Layouts.rec_common.source;
		TopBusiness_Services.Layouts.rec_common.source_docid;
		//TopBusiness_Services.Layouts.rec_common.source_recid; //???
	end;

  export rec_IncorporationChild_CorpHist := record
	  BIPV2.IDlayouts.l_header_ids; //needed on this level???
		//v--- fields used from the corporation "events" file
		rec_ids_with_keydata_slimmed.event_filing_date;
		rec_ids_with_keydata_slimmed.event_filing_desc;
		rec_ids_with_keydata_slimmed.corp_key; // needed here or not???
	end;

  // Added for Bug 150019
  export rec_IncorporationChild_CorpAddr := record
	  //BIPV2.IDlayouts.l_header_ids; //needed on this level???
    string60 corp_address_type_desc;
	  Standard.Addr.prim_range;
	  Standard.Addr.predir;
	  Standard.Addr.prim_name;
	  Standard.Addr.addr_suffix;
	  Standard.Addr.postdir;
	  Standard.Addr.unit_desig;
	  Standard.Addr.sec_range;
	  //Standard.Addr.p_city_name; //p_city_name not in Standard.Addr is it needed here???
		//string25 p_city_name; //???
	  Standard.Addr.v_city_name;
	  Standard.Addr.st;  //note "st", not "state"
	  Standard.Addr.zip5;
	  Standard.Addr.zip4;
	end;
 //end of record/fields added for bug 150019

  export rec_IncorporationParent_CorpInfo := record
	  BIPV2.IDlayouts.l_header_ids;
    rec_ids_with_keydata_slimmed.source;
		// Fields in requirement 0500 order/name
    rec_ids_with_keydata_slimmed.corp_legal_name; //AKA Corporation Name
    rec_ids_with_keydata_slimmed.corp_orig_sos_charter_nbr; //AKA Filing Number
 	  rec_ids_with_keydata_slimmed.business_type;
		rec_ids_with_keydata_slimmed.latest_filing_date; //AKA Filing Date (most recent)
		rec_ids_with_keydata_slimmed.business_status;
		rec_ids_with_keydata_slimmed.name_status;
		rec_ids_with_keydata_slimmed.corp_foreign_domestic_ind;  //AKA Foreign/Domestic Indicator
		rec_ids_with_keydata_slimmed.corp_forgn_state_cd;
		rec_ids_with_keydata_slimmed.corp_forgn_state_desc;
		rec_ids_with_keydata_slimmed.corp_forgn_date;
		rec_ids_with_keydata_slimmed.corp_for_profit_ind;  //AKA For profit/Not-for_Profit Indicator
		rec_ids_with_keydata_slimmed.corp_filing_desc; //AKA Filing Type
    rec_ids_with_keydata_slimmed.existence_code;
    rec_ids_with_keydata_slimmed.existence_expiration;
		rec_ids_with_keydata_slimmed.existence_desc;
    rec_ids_with_keydata_slimmed.corp_state_origin;  //State or Jurisdiction
    dataset(rec_IncorporationChild_CorpHist) CorpHistorys 
		        {maxcount(iesp.Constants.TOPBUSINESS.MAX_COUNT_BIZRPT_CORPHIST_RECORDS)};
		dataset(rec_IncorporationChild_Source) SourceDocs //needed at this level???
		        {maxcount(iesp.constants.TOPBUSINESS.MAX_COUNT_BIZRPT_SRCDOC_RECORDS)}; 
		unsigned4 total_corps_per_linkids;

   // v--- Fields added for the Accurint version of the BIP Bus Comp Rpt, bug 150019
    rec_ids_with_keydata_slimmed.corp_ln_name_type_desc; //AKA Name Type
    dataset(rec_IncorporationChild_CorpAddr) CorpAddresses 
		        {maxcount(iesp.Constants.TOPBUSINESS.MAX_COUNT_BIZRPT_ADDRESSES_PER_STATE)};
	  rec_ids_with_keydata_slimmed.corp_standing; //AKA In Good Standing
	  rec_ids_with_keydata_slimmed.corp_orig_bus_type_desc; //AKA Purpose
	  rec_ids_with_keydata_slimmed.corp_addl_info; //AKA Additional Info
	  rec_ids_with_keydata_slimmed.corp_ra_name;   //Registered Agent Name fields
    rec_ids_with_keydata_slimmed.corp_ra_title1; //  " 
    rec_ids_with_keydata_slimmed.corp_ra_fname1; //  "
 	  rec_ids_with_keydata_slimmed.corp_ra_mname1; //  "
	  rec_ids_with_keydata_slimmed.corp_ra_lname1; //  "
    rec_ids_with_keydata_slimmed.corp_ra_name_suffix1; // "
    rec_ids_with_keydata_slimmed.corp_ra_cname1; //???
    rec_ids_with_keydata_slimmed.corp_ra_prim_range; //Registered Agent Address fields ---v
    rec_ids_with_keydata_slimmed.corp_ra_predir;
    rec_ids_with_keydata_slimmed.corp_ra_prim_name;
    rec_ids_with_keydata_slimmed.corp_ra_addr_suffix;
    rec_ids_with_keydata_slimmed.corp_ra_postdir;
    rec_ids_with_keydata_slimmed.corp_ra_unit_desig;
    rec_ids_with_keydata_slimmed.corp_ra_sec_range;
    rec_ids_with_keydata_slimmed.corp_ra_p_city_name;
    rec_ids_with_keydata_slimmed.corp_ra_v_city_name;
    rec_ids_with_keydata_slimmed.corp_ra_state;
    rec_ids_with_keydata_slimmed.corp_ra_zip5;
    rec_ids_with_keydata_slimmed.corp_ra_zip4;
    //end of fields added for bug 150019
	end;

  export rec_IncorporationGrandParent := record
	  BIPV2.IDlayouts.l_header_ids;
		unsigned2 ret_corps_per_linkids; 
		unsigned2 total_corps_per_linkids;
	  dataset(rec_IncorporationParent_CorpInfo) CorpFilings 
		        {maxcount(iesp.constants.TOPBUSINESS.MAX_COUNT_BIZRPT_INCORP_RECORDS)};
		dataset(rec_IncorporationChild_Source) SourceDocs // needed at this level???
		        {maxcount(iesp.constants.TOPBUSINESS.MAX_COUNT_BIZRPT_SRCDOC_RECORDS)}; 
	end;

	export rec_ids_plus_IncorporationSection := record
		TopBusiness_Services.Layouts.rec_input_ids.acctno;
    BIPV2.IDlayouts.l_header_ids;
		iesp.topbusinessReport.t_TopBusinessIncorporationSection;
	end;		

	export rec_final := record
		TopBusiness_Services.Layouts.rec_input_ids.acctno;
		iesp.topbusinessReport.t_TopBusinessIncorporationSection;
	end;

end;
