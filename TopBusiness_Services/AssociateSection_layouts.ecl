import BankruptcyV2, BIPV2, iesp, LiensV2, LN_PropertyV2, Property, Standard, 
       UCCV2, VehicleV2, Watercraft;

export AssociateSection_Layouts := module;

	export rec_ids_with_linkidsdata_slimmed := record
		BIPV2.IDlayouts.l_header_ids;
	  TopBusiness_Services.Layouts.rec_common.source; //needed for ssn masking
	  //TopBusiness_Services.Layouts.rec_common.source_docid; //needed for ???
	  //TopBusiness_Services.Layouts.rec_common.source_recid; //needed for ???

		// v--- other linkids key file fields needed to link to existing source party key(s)
    // For bankruptcy, liens & UCCs
		string50 tmsid;

    // For leins & UCCs
		string50 rmsid;

    // For property
		LN_PropertyV2.layout_deed_mortgage_property_search.ln_fares_id;
		
		// For Foreclosure & NOD
		Property.Layout_Fares_Foreclosure.foreclosure_id;
		// v--- Foreclosure linkids key names fields, copied from Property.File_Foreclosure_Bip, 
		//      because layout not exported there
	  //string20 forec_name_first;
	  //string20 forec_name_middle;
	  //string20 forec_name_last;
	  //string5  forec_name_suffix; //???
	  string60 forec_name_Company;
		// v--- NOD linkids key names fields, copied from Property.File_Foreclosure_Bip_NOD, 
		//      because layout not exported there
		// nod person name fields???
	  string60 nod_name_Company;

		// For MVRs
	  VehicleV2.Layout_Base.Party_Base_BIP.Vehicle_key; // needed for linking to the mvr main & party keys
	  VehicleV2.Layout_Base.Party_Base_BIP.Iteration_key; // needed for linking to the mvr main & party keys
	  VehicleV2.Layout_Base.Party_Base_BIP.Sequence_key;  // needed or not for linking to the mvr party key

    // For Watercraft
	  Watercraft.Layout_Watercraft_Search_Base_slim.watercraft_key;
	  //Watercraft.Layout_Watercraft_Search_Base_slim.sequence_key; //not needed here, 
		                                              // can use the vehiclev2 sequence_key above
	  Watercraft.Layout_Watercraft_Search_Base_slim.state_origin;

    // other linkids keys fields that may be needed
    string8 date_vendor_last_reported;  

	  // v--- internal fields derived from certain linkids key fields
		string25 role_source; // Bankruptcy, Judgment/Lien, MVR, UCC, Watercraft &  
		                      // Real Estate/Real Property(???) OR 
													// Property(?), Foreclosure(?) & NOD/Notice of Default(?),  ??? 
	end;		

 export rec_child_party := record
		BIPV2.IDlayouts.l_header_ids;
    string120 company_name;
		BIPV2.IDlayouts.l_header_ids associated_business_linkids;
	  Standard.Name	person_name;
		string12 did;
		string9 ssn;
		boolean is_deceased;
		boolean has_derog;
	  Standard.Addr	common_address;
		string8 date_first_seen;
		string8 date_last_seen;
		string25 role_source;
		// v--- not on output, but needed for internal processing
		rec_ids_with_linkidsdata_slimmed.forec_name_Company;
		rec_ids_with_linkidsdata_slimmed.nod_name_Company;
		string1 liens_name_type; //???
		string2 source; 
		string1 associate_type; 
		string8 date_vendor_last_reported; 
		// v--- needed to pass total counts on to the next higher level records???
	  unsigned4 total_business := 0; //default to zero
		unsigned4 total_person   := 0; //default to zero
	end;

  export rec_parent_section := record
	  BIPV2.IDlayouts.l_header_ids;
		// v--- needed to pass info on to the next higher level records
	  unsigned4 total_business;
		unsigned4 total_person;
    // v--- needed to simulate iesp parent layout
		dataset(rec_child_party) business_associates
       {maxcount(iesp.constants.TOPBUSINESS.MAX_COUNT_BIZRPT_ASSOCIATE_RECORDS)};	
		dataset(rec_child_party) person_associates
       {maxcount(iesp.constants.TOPBUSINESS.MAX_COUNT_BIZRPT_ASSOCIATE_RECORDS)};	
  end;

	export rec_ids_plus_AssociateSection := record
		TopBusiness_Services.Layouts.rec_input_ids.acctno;
	  BIPV2.IDlayouts.l_header_ids;
		iesp.topbusinessReport.t_TopBusinessAssociateSection;
	end;

	export rec_final := record
		TopBusiness_Services.Layouts.rec_input_ids.acctno;
		iesp.TopBusinessReport.t_TopBusinessAssociateSection;
	end;		

end;
