import Address, BIPV2, AID;
export layouts:=module
	
	export clean_name	:= RECORD
			address.Layout_Clean_Name.title;
		  address.Layout_Clean_Name.fname;
		  address.Layout_Clean_Name.mname;
		  address.Layout_Clean_Name.lname;
		  address.Layout_Clean_Name.name_suffix;
			string1 NameType:='';
			unsigned8	nid;
	end;	
	
	export test_flag	:= RECORD
		boolean		isTest;
	end;

	export Individual_in:=record
		string38  surrogate_key;
		string50	name_in;		// added 6.6
		string20  name_key;
		string50  full_name;
		string15  pre_name;
		string50  first_name;
		string50  middle_name;
		string50  last_name;
		string15  maturity_suffix;
		string15  other_suffix;
		string1   gender;
		string50  preferred_name;
		unsigned3 name_confidence;
		unsigned8 name_st;
		string100 prac_company1_in;	// added 6.6
		string20  prac_company1_key;
		string100 prac_company1_name;
		string3   prac_company1_apcfirm1;
		unsigned8 prac_company1_st;
		string10  birthdate;
		unsigned8 birthdate_st;
		string9   ssn;
		string9   hashed_ssn;
		unsigned8 ssn_st;
		string10  prac_phone1;
		unsigned8 prac_phone1_st;
		string10  bill_phone1;
		unsigned8 bill_phone1_st;
		string10  prac_fax1;
		unsigned8 prac_fax1_st;
		string10  bill_fax1;
		unsigned8 bill_fax1_st;
		string48  email_addr;
		unsigned8 email_addr_st;
		string512 web_site;	// was string50 - changed in 6.7p
		unsigned8 web_site_st;
		string6   upin;
		unsigned8 upin_st;
		string9   tin1;
		unsigned8 tin1_st;
		string9   dea_num1;
		string10  dea_num1_exp;
		string16  dea_num1_sch;	// changed from string2 to string16 ver 6.6
		string1   dea_num1_bus_act_ind;
		string1		dea_num1_bus_subcode;	//added 6.6
		string1		dea_num1_payment_ind;	// added 6.6
		unsigned8 dea_num1_st;
		string3   specialty1;
		unsigned8 specialty1_st;
		string3   specialty2;
		unsigned8 specialty2_st;
		string25  lic1_num_in;
		string2   lic1_state;
		string20  lic1_num;
		string10  lic1_type;
		string1   lic1_status;
		string10  lic1_begin_date;
		string10  lic1_end_date;
		string16	lic1_drug_schedule;	// added 6.6
		unsigned8 lic1_st;
		string25  lic2_num_in;
		string2   lic2_state;
		string20  lic2_num;
		string10  lic2_type;
		string1   lic2_status;
		string10  lic2_begin_date;
		string10  lic2_end_date;
		string16	lic2_drug_schedule;	// added 6.6
		unsigned8 lic2_st;
		string25  lic3_num_in;
		string2   lic3_state;
		string20  lic3_num;
		string10  lic3_type;
		string1   lic3_status;
		string10  lic3_begin_date;
		string10  lic3_end_date;
		string16	lic3_drug_schedule;	// added 6.6
		unsigned8 lic3_st;
		string20  prac1_key;
		string50  prac1_primary_address;
		string50  prac1_secondary_address;
		string28  prac1_city;
		string2   prac1_state;
		string5   prac1_zip;
		string4   prac1_zip4;
		string2   prac1_rectype;
		string10  prac1_primary_range;
		string2   prac1_pre_directional;
		string28  prac1_primary_name;
		string4   prac1_suffix;
		string2   prac1_post_directional;
		string10  prac1_unit_designator;
		string8   prac1_secondary_range;
		string9   prac1_pobox;
		string9   prac1_rrnumber;
		string10  prac1_npsr;
		string6   prac1_ace_stat_code;
		string6   prac1_error_code;
		string5   prac1_fipscode;
		string1   prac1_rdi;
		unsigned8 prac1_st;
		string20  bill1_key;
		string50  bill1_primary_address;
		string50  bill1_secondary_address;
		string28  bill1_city;
		string2   bill1_state;
		string5   bill1_zip;
		string4   bill1_zip4;
		string2   bill1_rectype;
		string10  bill1_primary_range;
		string2   bill1_pre_directional;
		string28  bill1_primary_name;
		string4   bill1_suffix;
		string2   bill1_post_directional;
		string10  bill1_unit_designator;
		string8   bill1_secondary_range;
		string9   bill1_pobox;
		string9   bill1_rrnumber;
		string10  bill1_npsr;
		string6   bill1_ace_stat_code;
		string6   bill1_error_code;
		string5   bill1_fipscode;
		string1   bill1_rdi;
		unsigned8 bill1_st;
		string5   aff_code_mg;
		unsigned8 aff_code_mg_st;
		string2   sanc1_state;
		string10  sanc1_date;
		string25  sanc1_case;
		string50  sanc1_source;
		string100 sanc1_complaint;
		unsigned8 sanc1_st;
		string3   kil_code;
		unsigned8 kil_code_st;
		string10  date_of_death;
		unsigned8 date_of_death_st;
		unsigned8 sequence_num;
		string8   project_num;
		string9   filecode;
		string20  state_mask;
		string3   dept_code;
		string50  provider_id;
		unsigned8 provider_id_st;
		string100 medschool1;
		string4   medschool1_year;
		unsigned8 medschool1_st;
		string10  npi_num;
		string2   npi_drc;
		unsigned8 npi_st;
		string10  taxonomy;
		string10  last_update_date;
		string10  group_affiliation;
		string10  hosp_affiliation;
		string2   abms_member_board_id;
		unsigned8 abms_certificate_id;
		string1   abms_certificate_type;
		string1   abms_occurrence_type;
		string2   abms_duration_type;
		string10  abms_start_eff_date;
		string10  abms_end_eff_date;
		unsigned8 abms_st;
		string38  group_key;
		unsigned8 taxonomy_st;
		string1   taxonomy_primary_ind;
		string1   male_female;
		unsigned8 male_female_st;
		unsigned8 call_return_id;
		string10  dea_num1_deact_date;
		string10  npi_deact_date;
		string10  sanc1_rein_date;
		string1   primary_location;
		unsigned8 primary_location_st;
		string1		medicare_optout_flag;	// added 6.6
		string10	medicare_optout_eff_date;	// added 6.6
		string10	medicare_optout_end_date;	// added 6.6
		unsigned8 medicare_optout_st;	// added 6.6
		string1		medicare_assign_ind;	// added 6.6
		unsigned8 medicare_assign_ind_st;	// added 6.6
		string1		opt_out_flag;
		test_flag;
  end;
		
	export individual_in_for_grpkey:=record
		individual_in;
		string1 normed_addr_rec_type:='';
	end;
	
	export individual_base:=record
		individual_in-[
		prac1_primary_address,		
		prac1_secondary_address,	
		prac1_city,	
		prac1_state,	
		prac1_zip,	
		prac1_zip4,	
		prac1_rectype,	
		prac1_primary_range,	
		prac1_pre_directional,	
		prac1_primary_name,	
		prac1_suffix,	
		prac1_post_directional,	
		prac1_unit_designator,	
		prac1_secondary_range,	
		prac1_pobox,	
		prac1_rrnumber,	
		prac1_npsr,	
		prac1_ace_stat_code,			
		prac1_error_code,			
		prac1_fipscode,			
		prac1_rdi,			
		prac1_st,			
		bill1_primary_address,			
		bill1_secondary_address,			
		bill1_city,			
		bill1_state,			
		bill1_zip,			
		bill1_zip4,			
		bill1_rectype,			
		bill1_primary_range,			
		bill1_pre_directional,			
		bill1_primary_name,			
		bill1_suffix,			
		bill1_post_directional,			
		bill1_unit_designator,			
		bill1_secondary_range,			
		bill1_pobox,			
		bill1_rrnumber,			
		bill1_npsr,			
		bill1_ace_stat_code,			
		bill1_error_code,			
		bill1_fipscode,			
		bill1_rdi,
		bill1_st			
		];
	  clean_name;
		string1 	normed_addr_rec_type:=''; //P=primary, S=secondary
		string50  orig_adresss;
		string3   orig_state;
		string28  orig_city;
		string5   orig_zip;
		string50  Prepped_addr1;
		string39  Prepped_addr2;
		string51 	clean_prac1_company_name;
		string10	clean_prim_range;
		string2  	clean_predir;
		string28 	clean_prim_name;
		string4  	clean_addr_suffix;
		string2  	clean_postdir;
		string10 	clean_unit_desig;
		string8  	clean_sec_range;
		string25 	clean_p_city_name;
		string25 	clean_v_city_name;
		string2  	clean_st;			
		string5  	clean_zip;		
		string4  	clean_zip4;		
		string4  	clean_cart;
		string1  	clean_cr_sort_sz;
		string4  	clean_lot;
		string1  	clean_lot_order;
		string2  	clean_dbpc;
		string1  	clean_chk_digit;  
		string2  	clean_rec_type;
		string2  	clean_fips_st:='';
		string3  	clean_fips_county:=''; 		
		string10 	clean_geo_lat;     		
		string11 	clean_geo_long;    		
		string4  	clean_msa;         		
		string7  	clean_geo_blk;     		
		string1  	clean_geo_match;
		string4  	clean_err_stat;
		string10 	clean_prac_Phone1;
		string10 	clean_bill_Phone1;
		string8  	date_first_seen  := '0';
		string8  	date_last_seen :='0';
		string1  	record_type;
		string2  	src;
		string8  	clean_birthdate;
		string8  	clean_lic1_begin_date;
		string8   clean_lic1_end_date;
		string8   clean_lic2_begin_date;
		string8   clean_lic2_end_date;
		string8   clean_lic3_begin_date;
		string8   clean_lic3_end_date;
		string8   clean_sanc1_date;
		string8   clean_date_of_death;
		string8   clean_last_update_date;
		string8   clean_abms_start_eff_date;
		string8   clean_abms_end_eff_date;
		string8   clean_dea_num1_deact_date;
		string8   clean_npi_deact_date;
		string8   clean_sanc1_rein_date;
		string8   clean_dea_num1_exp;
		string8		clean_medicare_optout_eff_date;
		string8		clean_medicare_optout_end_date;
		string8		clean_abms_reverification_date;
		unsigned6 did 			:= 0;	
		unsigned1 did_score 			:= 0;
		unsigned6 Date_vendor_first_reported;
		unsigned6 Date_vendor_last_reported;
		unsigned8	source_rec_id ;
		unsigned6 bdid;
		unsigned1 bdid_score := 0; 
		unsigned8	lnpid;
		unsigned4 best_dob;
    string9   best_ssn;
		string8		LN_derived_rein_date;
		boolean		LN_derived_rein_flag	:= false;	
		BIPV2.IDlayouts.l_xlink_ids;
		AID.Common.xAID	RawAID;
		AID.Common.xAID	ACEAID;
	end;

	export taxonomy_full_lu_in:=record	 
		string10 	taxonomy; 
		string80 	type1;
		string100 classification;
		string80 	specialization;
		string260 fulllist;
	end;  

	export taxonomy_full_lu_base:=record	 
		string10 	taxonomy; 
		string80 	type1;
		string100 classification;
		string80 	specialization;
		string260 fulllist;
	end;  
	
end;