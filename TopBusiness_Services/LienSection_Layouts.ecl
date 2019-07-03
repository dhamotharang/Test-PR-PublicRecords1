import BIPV2, iesp, LiensV2;

export LienSection_Layouts := module;

  // A slimmed layout with needed linkids key fields only
  export rec_ids_with_linkidsdata_slimmed := record
		BIPV2.IDlayouts.l_header_ids;
		// For BIP2, use this---^ OR this ---v ???
	  // iesp.share.t_BusinessIdentity; //BIP2, version 2
	  TopBusiness_Services.Layouts.rec_common.source;
	  TopBusiness_Services.Layouts.rec_common.source_docid; //tmsid
    LiensV2.layout_liens_party.tmsid; //needed for linking to the liens main & party keys
		LiensV2.layout_liens_party.rmsid; //needed for linking to the liens main & party keys???
    // v--- rename linkids key file field=name_type to "role_party_type" to distinguish this
		// field as the "role" on the filing of the company being reported on. 
		// Also so it is not confused with the name_type of the party on the liens party_id key.
		// Is this (---v) even needed???
	  string1 role_party_type;  //D(=debtor) or C(=creditor) or ??
		unsigned2 tot_rec_count; // on this level and below???
  end;

  // A slimmed layout with lien main key (tmsid/rmsid)/report output lien main fields only
  export rec_ids_with_maindata_slimmed := record
	     string30 acctno;
		// string case_link_id;
		// unsigned case_link_priority;
		BIPV2.IDlayouts.l_header_ids;
		// For BIP2, use this---^ OR this ---v ???
	  // iesp.share.t_BusinessIdentity; //BIP2, version 2
	  TopBusiness_Services.Layouts.rec_common.source;
	  TopBusiness_Services.Layouts.rec_common.source_docid;
		// v--- Fields kept from the liens main_id key (see LiensV2.layout_liens_main_module)
		     // no field lengths on the LiensV2.layout_liens_main_module, will that be a problem???
		     // maybe use LiensV2.layout_base_allsources_main instead,  ???
		     // but some of those fields are way too long ???
		Liensv2.layout_liens_main_module.layout_liens_main.tmsid; //needed for linking to the party key
		Liensv2.layout_liens_main_module.layout_liens_main.rmsid; //needed for linking to the party key???
		Liensv2.layout_liens_main_module.layout_liens_main.filing_jurisdiction;
		Liensv2.layout_liens_main_module.layout_liens_main.orig_filing_number;		
		Liensv2.layout_liens_main_module.layout_liens_main.orig_filing_type;	
		Liensv2.layout_liens_main_module.layout_liens_main.orig_filing_date;	
		Liensv2.layout_liens_main_module.layout_liens_main.filing_number;
		Liensv2.layout_liens_main_module.layout_liens_main.filing_type_desc;
		Liensv2.layout_liens_main_module.layout_liens_main.filing_date;	
		Liensv2.layout_liens_main_module.layout_liens_main.filing_status;
		Liensv2.layout_liens_main_module.layout_liens_main.amount;
		// new field
		Liensv2.layout_liens_main_module.layout_liens_main.release_date;
          Liensv2.layout_liens_main_module.layout_liens_main.eviction; 
		Liensv2.layout_liens_main_module.layout_liens_main.agency;
		Liensv2.layout_liens_main_module.layout_liens_main.agency_state;
		Liensv2.layout_liens_main_module.layout_liens_main.agency_county; 
    // fields kept for internal processing
		Liensv2.layout_liens_main_module.layout_liens_main.process_date;
    // Liensv2.layout_liens_main_module.layout_liens_main.persistent_record_id; //needed ???
    // v--- derived/internal fields		???
		rec_ids_with_linkidsdata_slimmed.role_party_type; //the "role"/name_type of the reported on company on the filing
		unsigned2 tot_rec_count; // on this level and below???
		// bus smart linx additions for SMLINX-3
		Liensv2.layout_liens_main_module.layout_liens_main.irs_serial_number;
		Liensv2.layout_liens_main_module.layout_liens_main.case_number;
		Liensv2.layout_liens_main_module.layout_liens_main.filing_page;
		Liensv2.layout_liens_main_module.layout_liens_main.filing_book;	
		Liensv2.layout_liens_main_module.layout_liens_main.certificate_number;		
	end;
	
export rec_ids_with_maindata_slimmedExtra := record
                              rec_ids_with_maindata_slimmed;
				         unsigned case_link_id;
					    unsigned case_link_priority;
		end;

  // A slimmed layout with lien party key (tmsid/rmsid)/report output lien party fields only
  export rec_ids_with_partydata_slimmed := record
	     // bus smart linx additions additions
           unsigned case_link_id;
		unsigned case_link_priority;
		//
		BIPV2.IDlayouts.l_header_ids;
		// For BIP2, use this---^ OR this ---v ???
	  // iesp.share.t_BusinessIdentity; //BIP2, version 2
		// v--- Fields kept from the liens party_id key (see LiensV2.layout_liens_party)
		    // no field lengths on the LiensV2.layout_liens_party, will that be a problem???
		    // maybe use LiensV2.layout_base_allsources_party instead,  ???
		    // but some of those fields are way too long ???
		LiensV2.layout_liens_party.tmsid; //needed for linking to the main key
		LiensV2.layout_liens_party.rmsid; //needed for linking to the main key???
		LiensV2.layout_liens_party.tax_id;  //fein when party is a company???
		LiensV2.layout_liens_party.ssn;     // only when a party is a person
		LiensV2.layout_liens_party.title;
		LiensV2.layout_liens_party.fname;
		LiensV2.layout_liens_party.mname;
		LiensV2.layout_liens_party.lname;
		LiensV2.layout_liens_party.name_suffix;
		LiensV2.layout_liens_party.cname;      // company name
		LiensV2.layout_liens_party.prim_range;
		LiensV2.layout_liens_party.predir;
		LiensV2.layout_liens_party.prim_name;
		LiensV2.layout_liens_party.addr_suffix;
		LiensV2.layout_liens_party.postdir;
		LiensV2.layout_liens_party.unit_desig;
		LiensV2.layout_liens_party.sec_range;
		LiensV2.layout_liens_party.p_city_name;
		LiensV2.layout_liens_party.v_city_name;			
		LiensV2.layout_liens_party.st;
		LiensV2.layout_liens_party.zip;
		LiensV2.layout_liens_party.zip4;
		LiensV2.layout_liens_party.name_type;  
		// ^--- Existing field (note string2, not 1) on liens party file which contains: 
		    // A(Attorney), AD(Attorney for Debtor), C(Creditor), D(Debtor), T(Third Party)				
  end;

  export rec_LiensDataChild_Party := record
		rec_ids_with_partydata_slimmed;
	end;

  export rec_LiensDataChild_Filings := record
		rec_ids_with_maindata_slimmed.filing_date;	
		rec_ids_with_maindata_slimmed.filing_number;
           rec_ids_with_maindata_slimmed.filing_type_desc;
		rec_ids_with_maindata_slimmed.filing_status;
		rec_ids_with_maindata_slimmed.agency;
		rec_ids_with_maindata_slimmed.agency_state;
		rec_ids_with_maindata_slimmed.agency_county; 
		rec_ids_with_maindata_slimmed.release_date;
	end;

  export rec_LiensDataParent := record
	     //  bus smart linx  additions
		unsigned case_link_id;
		unsigned case_link_priority;
		//
		BIPV2.IDlayouts.l_header_ids;
		// For BIP2, use this---^ OR this ---v ???
	  // iesp.share.t_BusinessIdentity; //BIP2, version 2
	  TopBusiness_Services.Layouts.rec_common.source;
	  TopBusiness_Services.Layouts.rec_common.source_docid;
		unsigned2 derog_count := 0; //???
		rec_ids_with_maindata_slimmed.role_party_type; //bip2 ???  needed here???
		unsigned2 ret_rec_count; // on this level and below???
		unsigned2 tot_rec_count; // on this level and below???
		rec_ids_with_maindata_slimmed.filing_jurisdiction;
		rec_ids_with_maindata_slimmed.orig_filing_date;
		rec_ids_with_maindata_slimmed.orig_filing_number;
		rec_ids_with_maindata_slimmed.orig_filing_type;
		rec_ids_with_maindata_slimmed.release_date;
    rec_ids_with_maindata_slimmed.amount;
    rec_ids_with_maindata_slimmed.eviction; 
		boolean debtoroverflow; //???
		boolean creditoroverflow; //???
		
    dataset(rec_LiensDataChild_Party) debtors
		  {maxcount(iesp.constants.TOPBUSINESS.MAX_COUNT_BIZRPT_LIENS_PARTYS)}; 
    dataset(rec_LiensDataChild_Party) creditors
		  {maxcount(iesp.constants.TOPBUSINESS.MAX_COUNT_BIZRPT_LIENS_PARTYS)};    
    dataset(rec_LiensDataChild_Filings) filings
		  {maxcount(iesp.constants.TOPBUSINESS.MAX_COUNT_BIZRPT_LIENS_FILINGS)}; 
  end;

	export rec_ids_plus_JL_Detail := record
		// bus smart linx addition
		unsigned case_link_id;
		unsigned case_link_priority;
		//
		BIPV2.IDlayouts.l_header_ids;
		// For BIP2, use this---^ OR this ---v ???
	  // iesp.share.t_BusinessIdentity; //BIP2, version 2
		// rec_ids_with_maindata_slimmed.status_code;
		unsigned2 derogCount; //???
		unsigned2 ret_rec_count; // on this level and above???
		unsigned2 tot_rec_count; // on this level and above???
		iesp.topbusinessReport.t_TopBusinessJudgmentLienDetail;
	end;		

	export rec_ids_plus_JL_Rec := record
		TopBusiness_Services.Layouts.rec_input_ids.acctno;		
	  BIPV2.IDlayouts.l_header_ids;
		iesp.topbusinessReport.t_TopBusinessLienSection;
	end;

	export rec_final := record
		TopBusiness_Services.Layouts.rec_input_ids.acctno;
		iesp.topbusinessReport.t_TopBusinessLienSection;
	end;
	
end;
