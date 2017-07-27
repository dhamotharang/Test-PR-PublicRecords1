import BIPV2, iesp;

export OperationsSitesSection_Layouts := module;

 	export rec_ids_with_bhdata_slimmed := record
		BIPV2.IDlayouts.l_header_ids;
	  TopBusiness_Services.Layouts.rec_common.source;
	  TopBusiness_Services.Layouts.rec_common.source_docid;
    TopBusiness_Services.Layouts.rec_input_ids_wSrc.IdType;
		// v--- BIPV2 Business Header linkids key file fields 
		// the ones commented out, may not be needed for this section ???
		// for BH linkids key layout, see:
		//   BIPV2.Key_BH_Linking_Ids, which uses: 
		//     BIPV2.Files.business_header, which uses: 
		//       BIPV2_Files.files_hrchy.FILE_HRCY_BASE_LF_FULL; , which uses:
		//         BIPv2_HRCHY.Files, which uses:
		//           BIPv2_HRCHY.Layouts.HrchyBase, which uses:
    //             BIPV2.CommonBase.Layout, which uses either:
		//                 BIPV2.CommonBase.Layout_Dynamic;  
		//             or BIPV2.CommonBase.Layout_Static;, which uses BIPV2.CommonBase_mod.Layout_S13;
    //             based upon contents of BIPV2._Config.BASE_LAYOUT_DYNAMIC;
		//
		string120 company_name;  
		string10	prim_range;
		string2		predir;
		string28	prim_name;
		string4		addr_suffix;
		string2		postdir;
		string10	unit_desig;
		string8		sec_range;
		string25	p_city_name;
		string25	v_city_name;
		string2		st;
		string5		zip;
		string4		zip4;
		string2		fips_state;  //2 digit numeric value  //not really needed???
		string3		fips_county; //3 digit numeric value
		string4		msa;
		unsigned4 dt_first_seen;  
		unsigned4 dt_last_seen;  
		//unsigned4 dt_vendor_first_reported;  //???
		//unsigned4 dt_vendor_last_reported;  //???
		string10  company_phone; // 7 or 10 digits
    string1		bh_phone_type; // 'T'=Telephone, 'F'=fax? & ?=???
		unsigned4 dt_first_seen_company_address;
		unsigned4 dt_last_seen_company_address;
  end; 

	export rec_OpsSitesChild_Source := record
    BIPV2.IDlayouts.l_header_ids;
		TopBusiness_Services.Layouts.rec_common.source;
		TopBusiness_Services.Layouts.rec_common.source_docid; // aka IdValue
		TopBusiness_Services.Layouts.rec_input_ids_wSrc.IdType;
		// v--- needed at this level to keep all the source docs for a certain address
		rec_ids_with_bhdata_slimmed.prim_range;
		//rec_ids_with_bhdata_slimmed.predir;
		rec_ids_with_bhdata_slimmed.prim_name;
		//rec_ids_with_bhdata_slimmed.addr_suffix;
		//rec_ids_with_bhdata_slimmed.postdir;
		//rec_ids_with_bhdata_slimmed.unit_desig;
		//rec_ids_with_bhdata_slimmed.sec_range;
		//string25 city_name;
		//rec_ids_with_bhdata_slimmed.p_city_name; //???
		//both ---^ and ---v ???
		//rec_ids_with_bhdata_slimmed.v_city_name; //???
		rec_ids_with_bhdata_slimmed.st;
		rec_ids_with_bhdata_slimmed.zip;
	end;

  export rec_OpsSitesChild_Phone := record
	  BIPV2.IDlayouts.l_header_ids;
		// v--- For BIP2, see revised req 0482		
    string10 phone;  // <--- OR phone10 to be consistent with iesp.share.t_phoneinfo???
		//string10 fax; 
		// AND  ---^ to be consistent with Best section???  Ask Tim B/Todd R???
		string1  listing_type; // gong listing_type_*** (B, G, R)
    string1  line_type;    // blank or L=Landline, W=Wireless, F=Fax , ?=???
		// OR ---^ WirelessIndicator(?) to be consistent with Best section???
		// but we also want to be able to store "F" for fax#, so use line_type field name???
    boolean  active_EDA;   // not in reqs, but discussed with Tim B.
    boolean  disconnected;
	  string8  from_date;
	  string8  to_date;
		string120 listed_name; // not in reqs, but discussed with Tim B.  
		// OR  ---^ listing_name to be consistent with iesp.share.t_phoneinfo???
  end;

  export rec_OpsSitesChild_Address := record
	  BIPV2.IDlayouts.l_header_ids;
		integer1 address_order  := 0;
		integer5 int_prim_range := 0;		
		rec_ids_with_bhdata_slimmed.prim_range;
		rec_ids_with_bhdata_slimmed.predir;
		rec_ids_with_bhdata_slimmed.prim_name;
		rec_ids_with_bhdata_slimmed.addr_suffix;
		rec_ids_with_bhdata_slimmed.postdir;
		rec_ids_with_bhdata_slimmed.unit_desig;
		rec_ids_with_bhdata_slimmed.sec_range;
		string25 city_name;
		//rec_ids_with_bhdata_slimmed.p_city_name; //???
		//both ---^ and ---v ???
		//rec_ids_with_bhdata_slimmed.v_city_name; //???
		rec_ids_with_bhdata_slimmed.st;
		rec_ids_with_bhdata_slimmed.zip;
		rec_ids_with_bhdata_slimmed.zip4;
		rec_ids_with_bhdata_slimmed.fips_county; // needed at this level???
		string18  county_name;  //length ???
		rec_ids_with_bhdata_slimmed.msa;  
    string50  msa_name;  // length ???
		rec_ids_with_bhdata_slimmed.dt_first_seen;
		rec_ids_with_bhdata_slimmed.dt_last_seen;
    string12  property_link; // will store LN FaresId in here
    dataset(rec_OpsSitesChild_Phone) Phones 
		        {maxcount(iesp.constants.TOPBUSINESS.MAX_COUNT_BIZRPT_PHONES_PER_ADDRESS)};
		dataset(rec_OpsSitesChild_Source) SourceDocs 
		        {maxcount(iesp.constants.TOPBUSINESS.MAX_COUNT_BIZRPT_SRCDOC_RECORDS)}; 
 		unsigned2 total_addrs_per_state;
	end;
		
  export rec_OpsSitesParent := record
	  BIPV2.IDlayouts.l_header_ids;
		string2  state;
		string50 state_name;
		unsigned2 ret_addrs_per_state;
		unsigned2 total_addrs_per_state;
    dataset(rec_OpsSitesChild_Address) Addresses  
		        {maxcount(iesp.constants.TOPBUSINESS.MAX_COUNT_BIZRPT_ADDRESSES_PER_STATE)};
		// v--- no longer needed at this level
		//dataset(rec_OpsSitesChild_Source) SourceDocs 
		//        {maxcount(iesp.constants.TOPBUSINESS.MAX_COUNT_BIZRPT_SRCDOC_RECORDS)}; 
	end;

	export rec_ids_plus_OpsSitesDetail := record
    BIPV2.IDlayouts.l_header_ids;
		iesp.topbusinessReport.t_TopBusinessOperationSite;
	end;		

	export rec_ids_plus_OpsSitesSection := record
		TopBusiness_Services.Layouts.rec_input_ids.acctno;
    BIPV2.IDlayouts.l_header_ids;
		iesp.topbusinessReport.t_TopBusinessOperationsSitesSection;
	end;		

	export rec_final := record
		TopBusiness_Services.Layouts.rec_input_ids.acctno;
		iesp.topbusinessReport.t_TopBusinessOperationsSitesSection;
	end;

end;
