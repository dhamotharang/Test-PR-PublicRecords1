import BIPV2, iesp, UCCV2;
export UCCSection_Layouts := module;

  // A slimmed layout with needed linkids key fields only
  export rec_ids_with_linkidsdata_slimmed := record
		BIPV2.IDlayouts.l_header_ids;
	  TopBusiness_Services.Layouts.rec_common.source;  // not needed here???
	  //TopBusiness_Services.Layouts.rec_common.source_docid; //contains tmsid not needed here???
    UCCV2.Layout_UCC_Common.Layout_party_With_AID.tmsid; //needed for linking to the ucc main & party keys
		UCCV2.Layout_UCC_Common.Layout_party_With_AID.rmsid; //needed for linking to the ucc main & party keys???
		string1 role_type; // stored on linkids key file just as party_type, but  
		                   // renamed here to distinguish it from party key party_type
		                   // D=Debtor, S=Secured Party(aka Creditor) or A=Assignee
  end;
	
  // A slimmed layout with only ucc main key fields used on the report output
  export rec_ids_with_maindata_slimmed := record
		BIPV2.IDlayouts.l_header_ids;
	  rec_ids_with_linkidsdata_slimmed.source; //???
		rec_ids_with_linkidsdata_slimmed.tmsid; //needed for linking to the ucc party key
		rec_ids_with_linkidsdata_slimmed.rmsid; //needed for linking to the ucc party key
    // v--- report output/needed fields from the ucc main (tmsid/rmsid) key file
		UCCV2.Layout_UCC_Common.Layout_ucc_new.filing_jurisdiction;
		UCCV2.Layout_UCC_Common.Layout_ucc_new.orig_filing_number;		
		//UCCV2.Layout_UCC_Common.Layout_ucc_new.orig_filing_type;	// not needed ???
		UCCV2.Layout_UCC_Common.Layout_ucc_new.orig_filing_date;	
		UCCV2.Layout_UCC_Common.Layout_ucc_new.filing_number;
		UCCV2.Layout_UCC_Common.Layout_ucc_new.filing_type;	
		UCCV2.Layout_UCC_Common.Layout_ucc_new.filing_date;	
		UCCV2.Layout_UCC_Common.Layout_ucc_new.expiration_date;
		UCCV2.Layout_UCC_Common.Layout_ucc_new.filing_agency;
		UCCV2.Layout_UCC_Common.Layout_ucc_new.address;
		UCCV2.Layout_UCC_Common.Layout_ucc_new.city;
		UCCV2.Layout_UCC_Common.Layout_ucc_new.state;
		UCCV2.Layout_UCC_Common.Layout_ucc_new.zip;
		//v--- will be split apart into 100 byte fields???
		UCCV2.Layout_UCC_Common.Layout_ucc_new.collateral_desc; 
    // other fields from the ucc main (tmsid/rmsid) key file for internal processing
		UCCV2.Layout_UCC_Common.Layout_ucc_new.process_date; // needed for sorting
		//string8   filing_status; //might need to be used to determine overall ucc status???
		UCCV2.Layout_UCC_Common.Layout_ucc_new.status_type; //used to determine overall ucc status
		// v--- derived fields for internal processing
		string1   status_code; // derived field to indicate A(active) or T(terminated)
		rec_ids_with_linkidsdata_slimmed.role_type; //carried forward from linkids key, D, S or A
	  unsigned4 total_as_debtor  := 0;
		unsigned4 total_as_secured := 0;
	end;

  // A slimmed layout with ucc main key collateral related fields only???
  export rec_ids_with_colldata_split := record
		BIPV2.IDlayouts.l_header_ids;
		rec_ids_with_linkidsdata_slimmed.tmsid; //needed for linking to the ucc main key
		rec_ids_with_linkidsdata_slimmed.rmsid; //needed for linking to the ucc main key
		rec_ids_with_maindata_slimmed.filing_number; 
		rec_ids_with_maindata_slimmed.filing_date;	
		unsigned2 collateral_sequence;
		string100 collateral_description;
	end;

  // A slimmed layout with only ucc party key fields used on the report output
  export rec_ids_with_partydata_slimmed := record
		BIPV2.IDlayouts.l_header_ids;
	  //TopBusiness_Services.Layouts.rec_common.source; //???
	  //TopBusiness_Services.Layouts.rec_common.source_docid; //??? tmsid???
		rec_ids_with_linkidsdata_slimmed.tmsid; //needed for linking to the ucc main key
		rec_ids_with_linkidsdata_slimmed.rmsid; //needed for linking to the ucc main key
    // v--- party key /report output fields
		UCCV2.Layout_UCC_Common.Layout_party.orig_name; 
		UCCV2.Layout_UCC_Common.Layout_party.ssn;
		UCCV2.Layout_UCC_Common.Layout_party.fein;
		UCCV2.Layout_UCC_Common.Layout_party.party_type; //D, S or A
		UCCV2.Layout_UCC_Common.Layout_party.title;
		UCCV2.Layout_UCC_Common.Layout_party.fname;
		UCCV2.Layout_UCC_Common.Layout_party.mname;
		UCCV2.Layout_UCC_Common.Layout_party.lname;
		UCCV2.Layout_UCC_Common.Layout_party.name_suffix;
    UCCV2.Layout_UCC_Common.Layout_party.company_name;			
		UCCV2.Layout_UCC_Common.Layout_party.prim_range;
		UCCV2.Layout_UCC_Common.Layout_party.predir;
		UCCV2.Layout_UCC_Common.Layout_party.prim_name;
		UCCV2.Layout_UCC_Common.Layout_party.suffix;
		UCCV2.Layout_UCC_Common.Layout_party.postdir;
		UCCV2.Layout_UCC_Common.Layout_party.unit_desig;
		UCCV2.Layout_UCC_Common.Layout_party.sec_range;
		UCCV2.Layout_UCC_Common.Layout_party.p_city_name;
		UCCV2.Layout_UCC_Common.Layout_party.v_city_name;			
		UCCV2.Layout_UCC_Common.Layout_party.st;
		UCCV2.Layout_UCC_Common.Layout_party.zip5;
		UCCV2.Layout_UCC_Common.Layout_party.zip4;
		// v--- needed for party deduping
		BIPV2.IDlayouts.l_header_ids party_linkids;
  end;

	export rec_child_source := record
    BIPV2.IDlayouts.l_header_ids;
		TopBusiness_Services.Layouts.rec_common.source;
		TopBusiness_Services.Layouts.rec_common.source_docid; //add for bip2 ???
		//TopBusiness_Services.Layouts.rec_common.source_recid; //add for bip2 ???
	end;

  export rec_parchild_filing := record
	  BIPV2.IDlayouts.l_header_ids;
		rec_ids_with_linkidsdata_slimmed.tmsid;
		rec_ids_with_linkidsdata_slimmed.rmsid;
		//rec_ids_with_maindata_slimmed.filing_number; // might be needed for linking to collateral???
		//rec_ids_with_maindata_slimmed.filing_date;	 // might be needed for linking to collateral???
		//rec_ids_with_maindata_slimmed.status_code;	//???
    iesp.topbusinessReport.t_TopBusinessUCCFiling;
  end;

  export rec_parent_ucc := record 
	  BIPV2.IDlayouts.l_header_ids;
	  TopBusiness_Services.Layouts.rec_common.source; //???
	  //TopBusiness_Services.Layouts.rec_common.source_docid; //??? tmsid
		rec_ids_with_maindata_slimmed.tmsid;  //???
		//rec_ids_with_maindata_slimmed.rmsid; //???
		rec_ids_with_maindata_slimmed.status_code;
		rec_ids_with_maindata_slimmed.role_type;
	  rec_ids_with_maindata_slimmed.total_as_debtor; 
		rec_ids_with_maindata_slimmed.total_as_secured;
		iesp.topbusinessReport.t_TopBusinessUCC; 
	end;

  export rec_parent_role := record
	  BIPV2.IDlayouts.l_header_ids;
		rec_ids_with_maindata_slimmed.role_type;
	  rec_ids_with_maindata_slimmed.total_as_debtor; 
		rec_ids_with_maindata_slimmed.total_as_secured;
		iesp.topbusinessReport.t_TopBusinessUCCRole; 
	end;

	export rec_parent_uccsection := record
		TopBusiness_Services.Layouts.rec_input_ids.acctno;
	  BIPV2.IDlayouts.l_header_ids;
		iesp.topbusinessReport.t_TopBusinessUCCSection;
	end;

	export rec_final := record
		TopBusiness_Services.Layouts.rec_input_ids.acctno;
		iesp.topbusinessReport.t_TopBusinessUCCSection;
	end;
	
end;
