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

	export facility_in:=record
   	string38  surrogate_key;
		string100 prac_company1_in;	// added 6.6
   	string20  prac_company1_key;
   	string100 prac_company1_name;
   	string3   prac_company1_apcfirm1;
   	unsigned8 prac_company1_st;
		string50	name_in;	// added 6.6
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
   	string512 web_site;	// string50 - changed in 6.7p
   	unsigned8 web_site_st;
   	string9   tin1;
   	unsigned8 tin1_st;
   	string9   dea_num1;
   	string10  dea_num1_exp;
   	string16  dea_num1_sch;	// string2 changed to string16 ver 6.6
   	string1   dea_num1_bus_act_ind;
		string1		dea_num_bus_subcode;	// added 6.6
		string1		dea_num1_payment_ind;	// added 6.6
   	unsigned8 dea_num1_st;
   	string25  lic1_num_in;
   	string2   lic1_state;
    string8 	lic1_num;
   	string10  lic1_type;
   	string1   lic1_status;
   	string10  lic1_begin_date;
   	string10  lic1_end_date;
		string16	lic1_drug_schedule;		// added 6.6
   	unsigned8 lic1_st;
   	string25  lic2_num_in;
   	string2   lic2_state;
    string8 	lic2_num;
   	string10  lic2_type;
   	string1   lic2_status;
   	string10  lic2_begin_date;
   	string10  lic2_end_date;
		string16	lic2_drug_schedule;	// added 6.6
   	unsigned8 lic2_st;
   	string25  lic3_num_in;
   	string2   lic3_state;
   	string8 	lic3_num;
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
   	unsigned4 sequence_num;
   	string8   project_num;
   	string9   filecode;
   	string20	state_mask;
   	string3   dept_code;
   	string50  provider_id;
   	unsigned8 provider_id_st;
   	string10  npi_num;
   	string2   npi_drc;
   	unsigned8 npi_st;
   	string10  medicare_fac_num;
		string2		medicare_fac_num_status_code;
		string10	medicare_fac_num_term_date;
   	unsigned8 medicare_fac_num_st;
   	string10  medicaid_fac_num;
   	unsigned8 medicaid_fac_num_st;
   	string10  facility_type;
   	unsigned8 facility_type_st;
   	string10  taxonomy;
   	string10  last_update_date;
   	string38  group_key;
   	string7   ncpdp_id;
   	unsigned8 ncpdp_id_st;
   	string10  group_affiliation;
   	string10  hosp_affiliation;
   	string2   sanc1_state;
   	string10  sanc1_date;
   	string25  sanc1_case;
   	string50  sanc1_source;
   	string1000 sanc1_complaint;
   	unsigned8 sanc1_st;
   	unsigned8 taxonomy_st;
		string100	dba_in;	// added 6.6
   	string20  dba_key;
   	string100 dba_name;
   	string3   dba_apcfirm1;
   	unsigned8 dba_st;
		string100	bill_company1_in;	// added 6.6
   	string20  bill_company1_key;
   	string100 bill_company1_name;
   	string3   bill_company1_apcfirm1;
   	unsigned8 bill_company1_st;
   	string1   taxonomy_primary_ind;
   	unsigned2 call_return_id;
   	string10  dea_num1_deact_date;
   	string10  npi_deact_date;
   	string1   ownership;
   	unsigned8 ownership_st;
   	string1   control;
   	unsigned8 control_st;
   	unsigned2 approval;
   	unsigned8 approval_st;
   	string10  sanc1_rein_date;
   	string10  clia_num;
   	string2   clia_status_code;
   	string1   clia_cert_type_code;
   	string10  clia_cert_eff_date;
   	string10  clia_end_date;
		unsigned8 clia_test_vol_accredited;
		unsigned8	clia_test_vol_annual;
		unsigned8	clia_test_vol_ppm;
		unsigned8	clia_test_vol_survey;
		unsigned8	clia_test_vol_waived;
   	unsigned8 clia_data_st;
		test_flag;
	end;
   
	export facility_in_for_grpkey:=record
		facility_in;
		string1 normed_addr_rec_type:='';
	end;

 	export facility_base:=record
   	Facility_in-[
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
    string51	clean_dba_name;
   	string51 	clean_prac1_company_name;
   	string1   normed_addr_rec_type:=''; //P=primary, S=secondary	
   	string50  orig_adresss;
    string3   orig_state;
   	string28  orig_city;
   	string5   orig_zip;
   	string50  Prepped_addr1;
   	string39  Prepped_addr2;
   	string10 	clean_prim_range;
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
   	string4 	clean_lot;
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
   	string10 	clean_Phone;
   	string8 	date_first_seen  := '0';
   	string8 	date_last_seen :='0';
   	string1 	record_type;
   	string2 	src;
   	string8  	clean_lic1_begin_date;
   	string8  	clean_lic1_end_date;
   	string8  	clean_lic2_begin_date;
   	string8  	clean_lic2_end_date;
   	string8  	clean_lic3_begin_date;
   	string8  	clean_lic3_end_date;
   	string8  	clean_last_update_date;
   	string8  	clean_sanc1_date;
    string8 	clean_dea_num1_deact_date; 
   	string8   clean_dea_num1_exp;
   	string8  	clean_npi_deact_date;
   	string8  	clean_sanc1_rein_date;
   	string8  	clean_clia_cert_eff_date;
   	string8  	clean_clia_end_date;
		string8		clean_medicare_fac_num_term_date;
   	unsigned6 did 			:= 0;	
   	unsigned1 did_score 			:= 0;
   	unsigned6 Date_vendor_first_reported;
   	unsigned6 Date_vendor_last_reported;
   	unsigned8	source_rec_id;
   	unsigned8	lnpid;
		string8		LN_derived_rein_date;
		boolean		LN_derived_rein_flag	:= false;
   	AID.Common.xAID		RawAID;
		AID.Common.xAID		ACEAID;
   	unsigned6 bdid;
   	unsigned1 bdid_score := 0; 
   	BIPV2.IDlayouts.l_xlink_ids;
  end;

	export choice_point_in:=record
		string38	surrogate_key; 
		string50	name_in;	// added 6.6
		string20	name_key; 
		string50	full_name; 
		string15	pre_name; 
		string50	first_name; 
		string50	middle_name; 
		string50	last_name; 
		string15	maturity_suffix; 
		string15	other_suffix; 
		string1		gender; 
		string50	preferred_name; 
		unsigned3	name_confidence; 
		unsigned8	name_st; 
		string100	prac_company1_in;	// added 6.6
		string20	prac_company1_key; 
		string100	prac_company1_name; 
		unsigned8	prac_company1_apcfirm1; 
		unsigned8	prac_company1_st; 
		string100	prac_company2_in;	// added 6.6
		string20	prac_company2_key; 
		string100	prac_company2_name; 
		unsigned8	prac_company2_apcfirm1; 
		unsigned8	prac_company2_st; 
		string100	prac_company3_in;	// added 6.6
		string20	prac_company3_key; 
		string100	prac_company3_name; 
		unsigned8	prac_company3_apcfirm1; 
		unsigned8	prac_company3_st; 
		string100	bill_company1_in;	// added 6.6
		string20	bill_company1_key; 
		string100	bill_company1_name; 
		unsigned8	bill_company1_apcfirm1; 
		unsigned8	bill_company1_st;
		string100	bill_company2_in;	// added 6.6
		string20	bill_company2_key; 
		string100	bill_company2_name; 
		unsigned8	bill_company2_apcfirm1; 
		unsigned8	bill_company2_st; 
		string100	bill_company3_in;	// added 6.6
		string20	bill_company3_key; 
		string100	bill_company3_name; 
		unsigned8	bill_company3_apcfirm1; 
		unsigned8	bill_company3_st; 
		string10	birthdate; 
		unsigned8	birthdate_st; 
		unsigned5	ssn; 
		string9		hashed_ssn; 
		unsigned8	ssn_st; 
		string10	prac_phone1; 
		unsigned8	prac_phone1_st; 
		string10	prac_phone2; 
		unsigned8	prac_phone2_st; 
		string10	prac_phone3; 
		unsigned8	prac_phone3_st; 
		string10	bill_phone1; 
		unsigned8	bill_phone1_st; 
		string10	bill_phone2; 
		unsigned8	bill_phone2_st; 
		string10	bill_phone3; 
		unsigned8	bill_phone3_st; 
		string10	prac_fax1; 
		unsigned8	prac_fax1_st; 
		string10	prac_fax2; 
		unsigned8	prac_fax2_st; 
		string10	prac_fax3; 
		unsigned8	prac_fax3_st; 
		unsigned8	bill_fax1; 
		unsigned8	bill_fax1_st; 
		string10	bill_fax2; 
		unsigned8	bill_fax2_st; 
		string10	bill_fax3; 
		unsigned8	bill_fax3_st; 
		string48	email_addr; 
		unsigned8	email_addr_st; 
		string50	web_site; 
		unsigned8	web_site_st; 
		string6	  upin; 
		unsigned8	upin_st; 
		string9	  tin1; 
		unsigned8	tin1_st; 
		string9	  tin2; 
		unsigned8	tin2_st; 
		string9	  tin3; 
		unsigned8	tin3_st; 
		string9	  dea_num1; 
		string	  dea_num1_exp; 
		string16	dea_num1_sch; // changed from unsigned1 to string16 ver 6.6 
		string1	  dea_num1_bus_act_ind; 
		string1		dea_num1_bus_subcode;	// added 6.6
		string1		dea_num1_payment_ind;	// added 6.6
		unsigned8	dea_num1_st; 
		string9	  dea_num2; 
		string	  dea_num2_exp; 
		string16  dea_num2_sch; // changed from strin2 to string16 ver 6.6 
		string1	  dea_num2_bus_act_ind;
		string1		dea_num2_bus_subcode;	// added 6.6
		string1		dea_num2_payment_ind;	// added 6.6
		unsigned8	dea_num2_st; 
		string9		dea_num3; 
		string		dea_num3_exp; 
		string16	dea_num3_sch;	// changed from string2 to string16 ver 6.6 
		string1		dea_num3_bus_act_ind; 
		string1		dea_num3_bus_subcode;	// added 6.6
		string1		dea_num3_payment_ind; // added 6.6
		unsigned8	dea_num3_st; 
		string9		dea_num4; 
		string		dea_num4_exp; 
		string16	dea_num4_sch;	// changed from string2 to string16 ver 6.6 
		string1		dea_num4_bus_act_ind; 
		string1		dea_num4_bus_subcode;	// added 6.6
		string1		dea_num4_payment_ind;	// added 6.6
		unsigned8	dea_num4_st; 
		string9		dea_num5; 
		string		dea_num5_exp; 
		string16	dea_num5_sch;	// changed from string2 to string16 ver 6.6 
		string1		dea_num5_bus_act_ind; 
		string1		dea_num5_bus_subcode;	// added 6.6
		string1		dea_num5_payment_ind;	// added 6.6
		unsigned8	dea_num5_st; 
		string9		dea_num6; 
		string		dea_num6_exp; 
		string16	dea_num6_sch;	// changed from string2 to string16 ver 6.6 
		string1		dea_num6_bus_act_ind; 
		string1		dea_num6_bus_subcode;		// added 6.6
		string1		dea_num6_payment_ind;	// added 6.6
		unsigned8	dea_num6_st; 
		string9		dea_num7; 
		string		dea_num7_exp; 
		string16	dea_num7_sch;		// changed from string2 to string16 ver 6.6 
		string1		dea_num7_bus_act_ind; 
		string1		dea_num7_bus_subcode;		// added 6.6
		string1		dea_num7_payment_ind;		// added 6.6
		unsigned8	dea_num7_st; 
		string9		dea_num8; 
		string		dea_num8_exp; 
		string16	dea_num8_sch; 	// changed from string2 to string16 ver 6.6
		string1		dea_num8_bus_act_ind; 
		string1		dea_num8_bus_subcode;	// added 6.6
		string1		dea_num8_payment_ind;	// added 6.6
		unsigned8	dea_num8_st; 
		string9		dea_num9; 
		string		dea_num9_exp; 
		string16	dea_num9_sch;	// changed from string2 to string16 ver 6.6 
		string1		dea_num9_bus_act_ind; 
		string1		dea_num9_bus_subcode;	// added 6.6
		string1		dea_num9_payment_ind;	// added 6.6
		unsigned8	dea_num9_st; 
		string9		dea_num10; 
		string		dea_num10_exp; 
		string16	dea_num10_sch;	// changed from string2 to string16 ver 6.6 
		string1		dea_num10_bus_act_ind; 
		string1		dea_num10_bus_subcode;	// added 6.6
		string1		dea_num10_payment_ind;	// added 6.6
		unsigned8	dea_num10_st; 
		string3		specialty1; 
		unsigned8	specialty1_st; 
		string3		specialty2; 
		unsigned8	specialty2_st; 
		string3		specialty3; 
		unsigned8	specialty3_st; 
		string25	lic1_num_in; 
		string2		lic1_state; 
		string8	  lic1_num; 
		string10	lic1_type; 
		string1		lic1_status; 
		string		lic1_begin_date; 
		string		lic1_end_date; 
		string16	lic1_drug_schedule;	// added 6.6
		unsigned8 lic1_st; 
		string25	lic2_num_in; 
		string2		lic2_state; 
		unsigned8	lic2_num; 
		string10	lic2_type; 
		unsigned1 lic2_status; 
		string		lic2_begin_date; 
		string		lic2_end_date; 
		string16	lic2_drug_schedule;	// added 6.6
		unsigned8	lic2_st; 
		string25	lic3_num_in; 
		string2		lic3_state; 
		unsigned8	lic3_num; 
		string10	lic3_type; 
		unsigned1 lic3_status; 
		string		lic3_begin_date; 
		string		lic3_end_date; 
		string16	lic3_drug_schedule;	// added 6.6
		unsigned8	lic3_st; 
		string25	lic4_num_in; 
		string2		lic4_state; 
		unsigned8	lic4_num; 
		string10	lic4_type; 
		string1		lic4_status; 
		string		lic4_begin_date; 
		string		lic4_end_date; 
		string16	lic4_drug_schedule;	// added 6.6
		unsigned8	lic4_st; 
		string25	lic5_num_in; 
		string2		lic5_state; 
		unsigned8	lic5_num; 
		string10	lic5_type; 
		string1		lic5_status; 
		string		lic5_begin_date; 
		string		lic5_end_date;
		string16	lic5_drug_schedule;	// added 6.6
		unsigned8	lic5_st; 
		string2		sanc1_state; 
		string10	sanc1_date; 
		string25	sanc1_case; 
		string50	sanc1_source; 
		string100	sanc1_complaint; 
		unsigned8	sanc1_st; 
		string2		sanc2_state; 
		string10	sanc2_date; 
		string25	sanc2_case; 
		string50	sanc2_source; 
		string100	sanc2_complaint; 
		unsigned8	sanc2_st; 
		string2		sanc3_state; 
		string10	sanc3_date; 
		string25	sanc3_case; 
		string50	sanc3_source; 
		string100	sanc3_complaint; 
		unsigned8	sanc3_st; 
		string2		sanc4_state; 
		string10	sanc4_date; 
		string25	sanc4_case; 
		string50	sanc4_source; 
		string100	sanc4_complaint; 
		unsigned8	sanc4_st; 
		string2		sanc5_state; 
		string10	sanc5_date; 
		string25	sanc5_case; 
		string50	sanc5_source; 
		string100	sanc5_complaint; 
		unsigned8	sanc5_st; 
		string2		sanc6_state; 
		string10	sanc6_date; 
		string25	sanc6_case; 
		string50	sanc6_source; 
		string100	sanc6_complaint; 
		unsigned8	sanc6_st; 
		string2		sanc7_state; 
		string10	sanc7_date; 
		string25	sanc7_case; 
		string50	sanc7_source; 
		string100	sanc7_complaint; 
		unsigned8	sanc7_st; 
		string2		sanc8_state; 
		string10	sanc8_date; 
		string25	sanc8_case; 
		string50	sanc8_source; 
		string100	sanc8_complaint; 
		unsigned8	sanc8_st; 
		string2		sanc9_state; 
		string10	sanc9_date; 
		string25	sanc9_case; 
		string50	sanc9_source; 
		string100	sanc9_complaint; 
		unsigned8	sanc9_st; 
		string2		sanc10_state; 
		string10	sanc10_date; 
		string25	sanc10_case; 
		string50	sanc10_source; 
		string100	sanc10_complaint; 
		unsigned8	sanc10_st; 
		string20	prac1_key; 
		string50	prac1_primary_address; 
		string50	prac1_secondary_address; 
		string28	prac1_city; 
		string2 	prac1_state; 
		string5		prac1_zip; 
		string4		prac1_zip4; 
		string2		prac1_rectype; 
		string10	prac1_primary_range; 
		string2		prac1_pre_directional; 
		string28	prac1_primary_name; 
		string4		prac1_suffix; 
		string2		prac1_post_directional; 
		string10	prac1_unit_designator; 
		string8		prac1_secondary_range; 
		string9		prac1_pobox; 
		string9		prac1_rrnumber; 
		string10	prac1_npsr; 
		string6		prac1_ace_stat_code; 
		string6		prac1_error_code; 
		string5		prac1_fipscode; 
		string1		prac1_rdi; 
		unsigned8	prac1_st; 
		string20	prac2_key; 
		string50	prac2_primary_address; 
		string50	prac2_secondary_address; 
		string28	prac2_city; 
		string2		prac2_state; 
		string5		prac2_zip; 
		string4		prac2_zip4; 
		string2		prac2_rectype; 
		string10	prac2_primary_range; 
		string2		prac2_pre_directional; 
		string28	prac2_primary_name; 
		string4		prac2_suffix; 
		string2		prac2_post_directional; 
		string10	prac2_unit_designator; 
		string8		prac2_secondary_range; 
		string9		prac2_pobox; 
		string9		prac2_rrnumber; 
		string10	prac2_npsr; 
		string6		prac2_ace_stat_code; 
		string6		prac2_error_code; 
		string5		prac2_fipscode; 
		string1		prac2_rdi; 
		unsigned8	prac2_st; 
		string20	prac3_key; 
		string50	prac3_primary_address; 
		string50	prac3_secondary_address; 
		string28	prac3_city; 
		string2		prac3_state; 
		string5		prac3_zip; 
		string4		prac3_zip4; 
		string2		prac3_rectype; 
		string10	prac3_primary_range; 
		string2		prac3_pre_directional; 
		string28	prac3_primary_name; 
		string4		prac3_suffix; 
		string2		prac3_post_directional; 
		string10	prac3_unit_designator; 
		string8		prac3_secondary_range; 
		string9		prac3_pobox; 
		string9		prac3_rrnumber; 
		string10	prac3_npsr; 
		string6		prac3_ace_stat_code; 
		string6		prac3_error_code; 
		string5		prac3_fipscode; 
		string1		prac3_rdi; 
		unsigned8	prac3_st; 
		string20	bill1_key; 
		string50	bill1_primary_address; 
		string50	bill1_secondary_address; 
		string28	bill1_city; 
		string2		bill1_state; 
		string5		bill1_zip; 
		string4		bill1_zip4; 
		string2		bill1_rectype; 
		string10	bill1_primary_range; 
		string2		bill1_pre_directional; 
		string28	bill1_primary_name; 
		string4		bill1_suffix; 
		string2		bill1_post_directional; 
		string10	bill1_unit_designator; 
		string8		bill1_secondary_range; 
		string9		bill1_pobox; 
		string9		bill1_rrnumber; 
		string10	bill1_npsr; 
		string6		bill1_ace_stat_code; 
		string6		bill1_error_code; 
		string5		bill1_fipscode; 
		string1		bill1_rdi; 
		unsigned8	bill1_st; 
		string20	bill2_key; 
		string50	bill2_primary_address; 
		string50	bill2_secondary_address; 
		string28	bill2_city; 
		string2		bill2_state; 
		string5		bill2_zip; 
		string4		bill2_zip4; 
		string2		bill2_rectype; 
		string10	bill2_primary_range; 
		string2		bill2_pre_directional; 
		string28	bill2_primary_name; 
		string4		bill2_suffix; 
		string2		bill2_post_directional; 
		string10	bill2_unit_designator; 
		string8		bill2_secondary_range; 
		string9		bill2_pobox; 
		string9		bill2_rrnumber; 
		string10	bill2_npsr; 
		string6		bill2_ace_stat_code; 
		string6		bill2_error_code; 
		string5		bill2_fipscode; 
		string1		bill2_rdi; 
		unsigned8	bill2_st; 
		string20	bill3_key; 
		string50	bill3_primary_address; 
		string50	bill3_secondary_address; 
		string28	bill3_city; 
		string2		bill3_state; 
		string5		bill3_zip; 
		string4		bill3_zip4; 
		string2		bill3_rectype; 
		string10	bill3_primary_range; 
		string2		bill3_pre_directional; 
		string28	bill3_primary_name; 
		string4		bill3_suffix; 
		string2		bill3_post_directional; 
		string10	bill3_unit_designator; 
		string8		bill3_secondary_range; 
		string9		bill3_pobox; 
		string9		bill3_rrnumber; 
		string10	bill3_npsr; 
		string6		bill3_ace_stat_code; 
		string6		bill3_error_code; 
		string5		bill3_fipscode; 
		string1		bill3_rdi; 
		unsigned8	bill3_st; 
		string3		profcode1; 
		unsigned8	profcode1_st; 
		string3		profcode2; 
		unsigned8	profcode2_st; 
		string3		profcode3; 
		unsigned8	profcode3_st; 
		unsigned1 aff_code_mg; 
		unsigned8	aff_code_mg_st; 
		string80	aff_name_mg; 
		unsigned8	aff_name_mg_st; 
		string1		profstat; 
		unsigned8	profstat_st; 
		string1		provstat; 
		unsigned8	provstat_st; 
		string10	date_of_death; //string8
		unsigned8	date_of_death_st; 
		string1		death_flag; 
		unsigned8	death_flag_st; 
		string3		kil_code; 
		unsigned8	kil_code_st; 
		unsigned4	sequence_num; 
		string8		project_num; 
		string9		filecode; 
		unsigned8	state_mask; 
		string3		dept_code; 
		string50	provider_id; 
		unsigned8	provider_id_st; 
		string100	medschool1; 
		unsigned2	medschool1_year; 
		unsigned8	medschool1_st; 
		string100	medschool2; 
		unsigned2	medschool2_year; 
		unsigned8	medschool2_st; 
		string100	medschool3; 
		unsigned2	medschool3_year; 
		unsigned8	medschool3_st; 
		string10	npi_num; 
		string2		npi_drc; 
		unsigned8	npi_st; 
		string10	taxonomy; 
		string10	last_update_date; 
		string38	group_key; 
		unsigned8	taxonomy_st; 
		string1		taxonomy_primary_ind; 
		string1		male_female; 
		unsigned8	male_female_st; 
		unsigned8	call_return_id; 
		string10	dea_num1_deact_date; 
		string10	dea_num2_deact_date; 
		string10	dea_num3_deact_date; 
		string10	dea_num4_deact_date; 
		string10	dea_num5_deact_date; 
		string10	dea_num6_deact_date; 
		string10	dea_num7_deact_date; 
		string10	dea_num8_deact_date; 
		string10	dea_num9_deact_date; 
		string10	dea_num10_deact_date; 
		string10	npi_deact_date; 
		string10	sanc1_rein_date; 
		string10	sanc2_rein_date; 
		string10	sanc3_rein_date; 
		string10	sanc4_rein_date; 
		string10	sanc5_rein_date; 
		string10	sanc6_rein_date; 
		string10	sanc7_rein_date; 
		string10	sanc8_rein_date; 
		string10	sanc9_rein_date; 
		string10	sanc10_rein_date; 
		test_flag;
	end;

  export choice_point_base:=record
		choice_point_in -[
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
		prac2_key, 	
		prac2_primary_address, 	
		prac2_secondary_address, 	
		prac2_city, 	
		prac2_state, 
		prac2_zip, 
		prac2_zip4, 
		prac2_rectype, 
		prac2_primary_range, 	
		prac2_pre_directional, 
		prac2_primary_name, 	
		prac2_suffix, 
		prac2_post_directional, 
		prac2_unit_designator, 	
		prac2_secondary_range, 
		prac2_pobox, 
		prac2_rrnumber, 
		prac2_npsr, 	
		prac2_ace_stat_code, 
		prac2_error_code, 
		prac2_fipscode, 
		prac2_rdi, 
		prac2_st, 	
		prac3_key, 	
		prac3_primary_address, 	
		prac3_secondary_address, 	
		prac3_city, 	
		prac3_state, 
		prac3_zip, 
		prac3_zip4, 
		prac3_rectype, 
		prac3_primary_range, 	
		prac3_pre_directional, 
		prac3_primary_name, 	
		prac3_suffix, 
		prac3_post_directional, 
		prac3_unit_designator, 	
		prac3_secondary_range, 
		prac3_pobox, 
		prac3_rrnumber, 
		prac3_npsr, 	
		prac3_ace_stat_code, 
		prac3_error_code, 
		prac3_fipscode, 
		prac3_rdi, 
		prac3_st, 	
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
		bill1_st, 	
		bill2_primary_address, 	
		bill2_secondary_address, 	
		bill2_city, 	
		bill2_state, 
		bill2_zip, 
		bill2_zip4, 
		bill2_rectype, 
		bill2_primary_range, 	
		bill2_pre_directional, 
		bill2_primary_name, 	
		bill2_suffix, 
		bill2_post_directional, 
		bill2_unit_designator, 	
		bill2_secondary_range, 
		bill2_pobox, 
		bill2_rrnumber, 
		bill2_npsr, 	
		bill2_ace_stat_code, 
		bill2_error_code, 
		bill2_fipscode, 
		bill2_rdi, 
		bill2_st, 	
		bill3_primary_address, 	
		bill3_secondary_address, 	
		bill3_city, 	
		bill3_state, 
		bill3_zip, 
		bill3_zip4, 
		bill3_rectype, 
		bill3_primary_range, 	
		bill3_pre_directional, 
		bill3_primary_name, 	
		bill3_suffix, 
		bill3_post_directional, 
		bill3_unit_designator, 	
		bill3_secondary_range, 
		bill3_pobox, 
		bill3_rrnumber, 
		bill3_npsr, 	
		bill3_ace_stat_code, 
		bill3_error_code, 
		bill3_fipscode, 
		bill3_rdi, 
		bill3_st 	
		];
		clean_name;
		string2 normed_addr_rec_type:=''; //P=primary, S=secondary	
		string50 orig_adresss;
		string3  orig_state;
		string28 orig_city;
		string5  orig_zip;
		string50 Prepped_addr1;
		string39 Prepped_addr2;
		string51 clean_prac_company1_name;
		string51 clean_prac_company2_name;
		string51 clean_prac_company3_name;
		string51 clean_bill_company1_name;
		string51 clean_bill_company2_name;
		string51 clean_bill_company3_name;
		string10 clean_prim_range;
		string2  clean_predir;
		string28 clean_prim_name;
		string4  clean_addr_suffix;
		string2  clean_postdir;
		string10 clean_unit_desig;
		string8  clean_sec_range;
		string25 clean_p_city_name;
		string25 clean_v_city_name;
		string2  clean_st;			
		string5  clean_zip;		
		string4  clean_zip4;		
		string4  clean_cart;
		string1  clean_cr_sort_sz;
		string4  clean_lot;
		string1  clean_lot_order;
		string2  clean_dbpc;
		string1  clean_chk_digit;  
		string2  clean_rec_type;
		string2  clean_fips_st:='';
		string3  clean_fips_county:=''; 		
		string10 clean_geo_lat;     		
		string11 clean_geo_long;    		
		string4  clean_msa;         		
		string7  clean_geo_blk;     		
		string1  clean_geo_match;
		string4  clean_err_stat;
		string10 clean_prac1_Phone;
		string10 clean_prac2_Phone;
		string10 clean_prac3_Phone;
		string10 clean_bill1_Phone;
		string10 clean_bill2_Phone;
		string10 clean_bill3_Phone;
		string8  date_first_seen  := '0';
		string8  date_last_seen :='0';
		string1  record_type;
		string2  src;
		string8  clean_birthdate;
		string8  clean_lic1_begin_date;
		string8  clean_lic1_end_date;
		string8  clean_lic2_begin_date;
		string8  clean_lic2_end_date;
		string8  clean_lic3_begin_date;
		string8  clean_lic3_end_date;
		string8  clean_lic4_begin_date;	
		string8  clean_lic4_end_date;
		string8  clean_lic5_begin_date;	
		string8  clean_lic5_end_date;
		string8  clean_sanc1_date;
		string8  clean_sanc2_date;
		string8  clean_sanc3_date;
		string8  clean_sanc4_date;
		string8  clean_sanc5_date;
		string8  clean_sanc6_date;
		string8  clean_sanc7_date;
		string8  clean_sanc8_date;
		string8  clean_sanc9_date;
		string8  clean_sanc10_date;
		string8  clean_sanc1_rein_date;
		string8  clean_sanc2_rein_date;
		string8  clean_sanc3_rein_date;
		string8  clean_sanc4_rein_date;
		string8  clean_sanc5_rein_date;
		string8  clean_sanc6_rein_date;
		string8  clean_sanc7_rein_date;
		string8  clean_sanc8_rein_date;
		string8  clean_sanc9_rein_date;
		string8  clean_sanc10_rein_date;
		string8  clean_date_of_death;
		string8  clean_last_update_date;
		string8  clean_abms_start_eff_date;
		string8  clean_abms_end_eff_date;
		string8  clean_npi_deact_date;
		string8  clean_dea_num1_exp;
		string8  clean_dea_num2_exp;
		string8  clean_dea_num3_exp;
		string8  clean_dea_num4_exp;
		string8  clean_dea_num5_exp;
		string8  clean_dea_num6_exp;
		string8  clean_dea_num7_exp;
		string8  clean_dea_num8_exp;
		string8  clean_dea_num9_exp;
		string8  clean_dea_num10_exp;
		string8  clean_dea_num1_deact_date;
		string8  clean_dea_num2_deact_date;
		string8  clean_dea_num3_deact_date;
		string8  clean_dea_num4_deact_date;
		string8  clean_dea_num5_deact_date;
		string8  clean_dea_num6_deact_date;
		string8  clean_dea_num7_deact_date;
		string8  clean_dea_num8_deact_date;
		string8  clean_dea_num9_deact_date;
		string8  clean_dea_num10_deact_date;
		unsigned6 did 			:= 0;	
		unsigned1 did_score 			:= 0;
		unsigned6 Date_vendor_first_reported;
		unsigned6 Date_vendor_last_reported;
		unsigned8	source_rec_id ;
		unsigned6 bdid;
		unsigned1 bdid_score := 0; 
		unsigned8	lnpid;
		BIPV2.IDlayouts.l_xlink_ids;
		AID.Common.xAID	RawAID;
		AID.Common.xAID	ACEAID;
	end;
		
	export lic_xref_in:=record
		unsigned2	lic_num;
		string2		lic_state;
		string50	first_name;
		string50	last_name;
		string38	group_key;
	end;

	export lic_xref_base:=record
		lic_xref_in;
		string50 middle_name;
		string5  maturity_suffix;
		clean_name;
	end;

	export dea_xref_in:=record
		string9 	dea_num;
		string38 	group_key;
	end;

	export dea_xref_base:=record
		string9  dea_num;
		string38 group_key;
	end;

	export facility_name_xref_in :=record
		string100	prac_company1_name;
		string100	dba_name;
		string28	prac1_city;
		string28	prac1_state;
		string10	taxonomy;
		string38	group_key;
	end;

	export facility_name_xref_base :=record
		facility_name_xref_in;
		string100	clean_prac_company1_name;
		string100	clean_dba_name;
	end;

	export address_name_xref_in:=record
		string20	addrkey;
		string38	group_key;
		string20	name_key;
		string50	last_name;
		string50	preferred_name;
		string1	prac;
	end;

	export address_name_xref_base:=record
		address_name_xref_in;
		string50 middle_name:='';
		string50 first_name:='';
		string5  maturity_suffix:='';
		clean_name;
	end;

	export npi_tin_xref_in:=record
		string10	bill_npi;
		string20	bill_tin;
		unsigned8	restrict_indicator;
		unsigned8	source;
		test_flag;
	end;	

	export npi_tin_xref_base :=record
		npi_tin_xref_in;
	end;	

	export abbr_lu_in:=record
		string50 code;
		string50 description;
		string2 state;
	end;
	
	export abbr_lu_base:=record
		string50 code;
		string50 description;
		string2 state;
	end;
 
	export std_terms_lu_in := record
		string50 code;
		string50 description;
		string10 state;
	end;

	export std_terms_lu_base := record
		string50 code;
		string50 description;
		string10 state;
	end;

	export taxon_lu_in := record
		string50 code;
		string50 description;
		string10 state;
	end; 

	export taxon_lu_base := record
		string50 code;
		string50 description;
		string10 state;
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

	export call_queue_bad_in:=record
		string10 prac_phone1;
		string10 bad_set_date;
	end; 

	export call_queue_bad_base:=record
		string10 prac_phone1;
		string10 bad_set_date;
	end; 

	export specialty_lu_in:=record
		string3  specialty;
		string40 specialty_desc;
	end;	 

	export specialty_lu_base:=record
		string3  specialty;
		string40 specialty_desc;
	end;

	export group_lu_in := record
		string50 	code;
		string50  description;
		string10  state;
		test_flag;
	end;	 

	export group_lu_base := record
		group_lu_in;
	end;	 

	export hospital_lu_in := record
		string50	code;
		string50	description;
		string10	state;
		test_flag;
	end;

	export hospital_lu_base := record
		hospital_lu_in;
	end;

	export group_practice_in:=record	 
		string10 	group_affiliation;
		string50 	group_name;
		string20 	prac1_key;
		string50 	prac1_primary_address;
		string50 	prac1_secondary_address;
		string28 	prac1_city;
		string2  	prac1_state;
		string5  	prac1_zip;
		string4  	prac1_zip4;
		string2  	prac1_rectype;
		string10 	prac1_primary_range;
		string2  	prac1_pre_directional;
		string28 	prac1_primary_name;
		string4  	prac1_suffix;
		string2  	prac1_post_directional;
		string10 	prac1_unit_designator;
		string8  	prac1_secondary_range;
		string9  	prac1_pobox;
		string9  	prac1_rrnumber;
		string10 	prac1_npsr;
		string6  	prac1_ace_stat_code;
		string6  	prac1_error_code;
		string5  	prac1_fipscode;
		string1  	prac1_rdi;
		unsigned8 prac1_st;
		string10 	prac_phone1;
		string10 	prac_fax1;
		string10 	prac_fax2;
		string10 	taxonomy;
		string10 	first_created_date;
		string10 	last_load_date;
		unsigned8 active_status;
	end;  
  
	export group_practice_base	:= record
		group_practice_in;
		string50 	clean_group_name;
		string1 	normed_addr_rec_type:=''; //P=primary, S=secondary
		string50  Prepped_addr1;
		string39  Prepped_addr2;
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
		string10 	clean_prac_phone1;
		string10 	clean_prac_fax1;
		string10 	clean_prac_fax2;
		string8  	date_first_seen		:= '0';
		string8  	date_last_seen 		:= '0';
		unsigned6 Date_vendor_first_reported;
   	unsigned6 Date_vendor_last_reported;
		string1  	record_type;
		string2  	src;
		unsigned8	source_rec_id ;
		unsigned6 bdid;
		unsigned1 bdid_score := 0; 
		unsigned8	lnpid;
		string8  	clean_first_created_date;
		string8  	clean_last_load_date;
		BIPV2.IDlayouts.l_xlink_ids;
		AID.Common.xAID	RawAID;
		AID.Common.xAID	ACEAID;
	end;

	export lic_filedate_in:=record
		string12	filecode;	
		string10	filedate;	
		string1		current_flag;	
		test_flag;
	end;	

	export lic_filedate_base:=record
		lic_filedate_in;
		string8 clean_filedate;	
	end;	

	export rev_mod_weights_in:=record
		string intercept;
		string lic_old;
		string lic_gk_no_prac_addr;
		string lic_gk_no_addr_match;
		string lic_gk_no_license;
		string lic_gk_inactive;
		string lic_gk_prc_st_no_mtch;
		string lic_gk_date_0_365;
		string lic_gk_date_731_plus;
		string lic_gk_date_366_730;
		string chiropractor;
		string podiatrist;
		string rehab;
		string pathology;
		string enclarity_20x_taxon;
		string prc_fac_npi;
		string ph_fac_npi;
		string prc_NPI;
		string npi_fac_3_plus;
		string npi_fac_2;
		string npi_fac_1;
		string npi_date_547_plus;
		string npi_date_0_546;
		string grp_dea;
		string dea_date_731_plus;
		string dea_date_366_730;
		string dea_date_under_365;
		string mch_ct_3_plus;
		string mch_ct_2;
		string mch_ct_1;
		string prc_ph_fac_ct_64_plus;
		string prc_ph_fac_ct_10_63;
		string prc_ph_fac_ct_4_9;
		string prc_ph_fac_ct_1_3;
		string prc_grp_ct_61_plus;
		string prc_grp_ct_4_60;
		string prc_grp_ct_1_3;
		string prc_b_grp_ct_61_plus;
		string prc_b_grp_ct_4_60;
		string prc_b_grp_ct_1_3;
		string grp_g_prc_ct_3_plus;
		string grp_g_prc_ct_2;
		string grp_g_prc_ct_1;
		string grp_ph_alt_ct_3_plus;
		string grp_ph_alt_ct_2;
		string grp_ph_alt_ct_1;
		string ph_g_prc_ct_4_plus;
		string ph_g_prc_ct_2_3;
		string ph_g_prc_ct_1;
		string ph_b_prc_ct_4_plus;
		string ph_b_prc_ct_2_3;
		string ph_b_prc_ct_1;
		string prc_obp;
		string ph_obp;
		string grp_obp;
		string grp_prc_pv_481_plus;
		string grp_prc_pv_241_480;
		string ph_PV_ACT;
		string prc_SKA_INACT;
		string prc_PV_INACT;
		string grp_prc_ska_inact;
		string pv_addr_per_gkph_multi;
		string pv_addr_per_gkph_1;
		string phone_state_discrep;
		string upin_flg;
		string ph_hospital;
		string ph_ncp;
		string ph_mch_gen;
	end;

	export nanpa_in:=record
		string2  state;
		string7  npa_num;
		string4  ocn;
		string85 carrier_name;
		string10 rate_center;
		string10 effective_date;
		string2  use_code;
		string10 assign_date;
		string1  initial_growth_code;
		string3  area_code;
		string3  exchange_code;
		test_flag;
	end;   
		
	export nanpa_base:=record		
		nanpa_in;
		string85 clean_carrier_name;
		string8  clean_effective_date;
		string8  clean_assign_date;
		string10 clean_rate_center;
		string4  clean_ocn;
	end;

	export dirconfidence2010lu_in:=record
		string set_directory_confidence;
		string validity_score_cutoff;
	end;

	export dirconfidence2010lu_base:=record
		string set_directory_confidence;
		string validity_score_cutoff;
	end;
 
	export ignore_terms_lu_in:=record
		string10 code;
	end;	
	 
	export ignore_terms_lu_base:=record
		string10 code;
	end;	
	  
  export basc_claims_in:=record
		string38	surrogate_key;
		string50	name_in;	// added 6.6
		string20	name_key;
		string50	full_name;
		string15	pre_name;
		string50	first_name;
		string50	middle_name;
		string50	last_name;
		string15	maturity_suffix;
		string15	other_suffix;
		string1		gender;
		string50	preferred_name;
		string3		name_confidence;
		string8		name_st;
		string100	prac_company1_in;	// added 6.6
		string20	prac_company1_key;
		string100 prac_company1_name;
		string3 	prac_company1_apcfirm1;
		string8 	prac_company1_st;
		string9 	ssn;
		string9 	hashed_ssn;
		string8 	ssn_st;
		string20 	prac1_key;
		string50 	prac1_primary_address;
		string50 	prac1_secondary_address;
		string28 	prac1_city;
		string2 	prac1_state;
		string5 	prac1_zip;
		string4 	prac1_zip4;
		string2 	prac1_rectype;
		string10 	prac1_primary_range;
		string2 	prac1_pre_directional;
		string28 	prac1_primary_name;
		string4 	prac1_suffix;
		string2 	prac1_post_directional;
		string10 	prac1_unit_designator;
		string8 	prac1_secondary_range;
		string9 	prac1_pobox;
		string9 	prac1_rrnumber;
		string10 	prac1_npsr;
		string6 	prac1_ace_stat_code;
		string6 	prac1_error_code;
		string5 	prac1_fipscode;
		string1 	prac1_rdi;
		string8 	prac1_st;
		string10 	prac_phone1;
		string8 	prac_phone1_st;
		string10 	prac_fax1;
		string8 	prac_fax1_st;
		string20 	bill1_key;
		string50 	bill1_primary_address;
		string50 	bill1_secondary_address;
		string28 	bill1_city;
		string2 	bill1_state;
		string5 	bill1_zip;
		string4 	bill1_zip4;
		string2 	bill1_rectype;
		string10 	bill1_primary_range;
		string2 	bill1_pre_directional;
		string28 	bill1_primary_name;
		string4 	bill1_suffix;
		string2 	bill1_post_directional;
		string10 	bill1_unit_designator;
		string8 	bill1_secondary_range;
		string9 	bill1_pobox;
		string9 	bill1_rrnumber;
		string10 	bill1_npsr;
		string6 	bill1_ace_stat_code;
		string6 	bill1_error_code;
		string5 	bill1_fipscode;
		string1 	bill1_rdi;
		string8 	bill1_st;
		string10 	bill_phone1;
		string8 	bill_phone1_st;
		string10 	bill_fax1;
		string8 	bill_fax1_st;
		string6 	upin;
		string8 	upin_st;
		string9 	tin1;
		string8 	tin1_st;
		string25 	lic1_num_in;
		string2 	lic1_state;
		string20 	lic1_num;
		string10 	lic1_type;
		string1 	lic1_status;
		string10 	lic1_begin_date;
		string10 	lic1_end_date;
		string16	lic1_drug_sschedule;	// added 6.6
		string8 	lic1_st;
		string8 	sequence_num;
		string8 	project_num;
		string9 	filecode;
		string20 	state_mask;
		string10 	npi_num;
		string1 	npi_drc;
		string8 	npi_st;
		string10 	taxonomy;
		string10 	last_update_date;
		string38 	group_key;
		string8 	taxonomy_st;
		string1 	taxonomy_primary_ind;
		string1 	male_female;
		string8 	male_female_st;
		string8 	call_return_id;
		string10 	npi_deact_date;
		test_flag;
	end;	
	
	export basc_claims_base:=record
		basc_claims_in -[
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
		bill1_rdi
		];
		Clean_name;
		string1 normed_addr_rec_type:=''; //P=primary, S=secondary
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
		unsigned6 did 			:= 0;	
		unsigned1 did_score 			:= 0;
		unsigned6 Date_vendor_first_reported;
		unsigned6 Date_vendor_last_reported;
		unsigned8	source_rec_id ;
		unsigned6 bdid;
		unsigned1 bdid_score := 0; 
		unsigned8	lnpid;
		BIPV2.IDlayouts.l_xlink_ids;
		AID.Common.xAID	RawAID;
		AID.Common.xAID	ACEAID;
	end;
  
	export office_attributes_in:=record
		string38 	surrogate_key;
		string4  	oh_m_start_in;
		string4  	oh_m_start;
		unsigned8 oh_m_start_st;
		string4 	oh_m_end_in;
		string4 	oh_m_end;
		unsigned8 oh_m_end_st;
		string4 	oh_m_lunch_in;
		string4 	oh_m_lunch;
		unsigned8 oh_m_lunch_st;
		string4 	oh_m_dur_in;
		string4 	oh_m_dur;
		unsigned8 oh_m_dur_st;
		string4 	oh_tu_start_in;
		string4 	oh_tu_start;
		unsigned8 oh_tu_start_st;
		string4 	oh_tu_end_in;
		string4 	oh_tu_end;
		unsigned8 oh_tu_end_st;
		string4 	oh_tu_lunch_in;
		string4 	oh_tu_lunch;
		unsigned8 oh_tu_lunch_st;
		string4 	oh_tu_dur_in;
		string4 	oh_tu_dur;
		unsigned8 oh_tu_dur_st;
		string4 	oh_w_start_in;
		string4 	oh_w_start;
		unsigned8 oh_w_start_st;
		string4 	oh_w_end_in;
		string4 	oh_w_end;
		unsigned8 oh_w_end_st;
		string4 	oh_w_lunch_in;
		string4 	oh_w_lunch;
		unsigned8 oh_w_lunch_st;
		string4 	oh_w_dur_in;
		string4 	oh_w_dur;
		unsigned8 oh_w_dur_st;
		string4 	oh_th_start_in;
		string4 	oh_th_start;
		unsigned8 oh_th_start_st;
		string4 	oh_th_end_in;
		string4 	oh_th_end;
		unsigned8 oh_th_end_st;
		string4 	oh_th_lunch_in;
		string4 	oh_th_lunch;
		unsigned8 oh_th_lunch_st;
		string4 	oh_th_dur_in;
		string4 	oh_th_dur;
		unsigned8 oh_th_dur_st;
		string4 	oh_f_start_in;
		string4 	oh_f_start;
		unsigned8 oh_f_start_st;
		string4 	oh_f_end_in;
		string4 	oh_f_end;
		unsigned8 oh_f_end_st;
		string4 	oh_f_lunch_in;
		string4 	oh_f_lunch;
		unsigned8 oh_f_lunch_st;
		string4 	oh_f_dur_in;
		string4 	oh_f_dur;
		unsigned8 oh_f_dur_st;
		string4 	oh_sa_start_in;
		string4 	oh_sa_start;
		unsigned8 oh_sa_start_st;
		string4 	oh_sa_end_in;
		string4 	oh_sa_end;
		unsigned8 oh_sa_end_st;
		string4 	oh_sa_lunch_in;
		string4 	oh_sa_lunch;
		unsigned8 oh_sa_lunch_st;
		string4 	oh_sa_dur_in;
		string4 	oh_sa_dur;
		unsigned8 oh_sa_dur_st;
		string4 	oh_su_start_in;
		string4 	oh_su_start;
		unsigned8	oh_su_start_st;
		string4 	oh_su_end_in;
		string4 	oh_su_end;
		unsigned8	oh_su_end_st;
		string4 	oh_su_lunch_in;
		string4 	oh_su_lunch;
		unsigned8	oh_su_lunch_st;
		string4 	oh_su_dur_in;
		string4 	oh_su_dur;
		unsigned8	oh_su_dur_st;
		unsigned8 languages_in;
		unsigned8 languages;
		unsigned8 languages_st;
		string4 	exam_rooms_in;
		string4 	exam_rooms;
		unsigned8 exam_rooms_st;
		string1 	medicaid_part_in;
		string1 	medicaid_part;
		unsigned8 medicaid_part_st;
		string1 	medicare_part_in;
		string1 	medicare_part;
		unsigned8 medicare_part_st;
		string1 	new_patients_in;
		string1 	new_patients;
		unsigned8 new_patients_st;
		string20 	filecode;
		test_flag;
	end;	
	
	export office_attributes_base:=record
		office_attributes_in;
	end;	

	export office_attributes_facility_in:=record
		string38 	surrogate_key;
		string4 	oh_m_start_in;
		string4 	oh_m_start;
		unsigned8 oh_m_start_st;
		string4 	oh_m_end_in;
		string4 	oh_m_end;
		unsigned8 oh_m_end_st;
		string4 	oh_m_lunch_in;
		string4 	oh_m_lunch;
		unsigned8 oh_m_lunch_st;
		string4 	oh_m_dur_in;
		string4 	oh_m_dur;
		unsigned8 oh_m_dur_st;
		string4 	oh_tu_start_in;
		string4 	oh_tu_start;
		unsigned8 oh_tu_start_st;
		string4 	oh_tu_end_in;
		string4 	oh_tu_end;
		unsigned8 oh_tu_end_st;
		string4 	oh_tu_lunch_in;
		string4 	oh_tu_lunch;
		unsigned8 oh_tu_lunch_st;
		string4 	oh_tu_dur_in;
		string4 	oh_tu_dur;
		unsigned8 oh_tu_dur_st;
		string4 	oh_w_start_in;
		string4 	oh_w_start;
		unsigned8 oh_w_start_st;
		string4 	oh_w_end_in;
		string4 	oh_w_end;
		unsigned8 oh_w_end_st;
		string4 	oh_w_lunch_in;
		string4 	oh_w_lunch;
		unsigned8 oh_w_lunch_st;
		string4 	oh_w_dur_in;
		string4 	oh_w_dur;
		unsigned8 oh_w_dur_st;
		string4 	oh_th_start_in;
		string4 	oh_th_start;
		unsigned8 oh_th_start_st;
		string4 	oh_th_end_in;
		string4 	oh_th_end;
		unsigned8 oh_th_end_st;
		string4 	oh_th_lunch_in;
		string4 	oh_th_lunch;
		unsigned8 oh_th_lunch_st;
		string4 	oh_th_dur_in;
		string4 	oh_th_dur;
		unsigned8 oh_th_dur_st;
		string4 	oh_f_start_in;
		string4 	oh_f_start;
		unsigned8 oh_f_start_st;
		string4 	oh_f_end_in;
		string4 	oh_f_end;
		unsigned8 oh_f_end_st;
		string4 	oh_f_lunch_in;
		string4 	oh_f_lunch;
		unsigned8 oh_f_lunch_st;
		string4 	oh_f_dur_in;
		string4 	oh_f_dur;
		unsigned8 oh_f_dur_st;
		string4 	oh_sa_start_in;
		string4 	oh_sa_start;
		unsigned8	oh_sa_start_st;
		string4 	oh_sa_end_in;
		string4 	oh_sa_end;
		unsigned8	oh_sa_end_st;
		string4 	oh_sa_lunch_in;
		string4 	oh_sa_lunch;
		unsigned8	oh_sa_lunch_st;
		string4 	oh_sa_dur_in;
		string4 	oh_sa_dur;
		unsigned8	oh_sa_dur_st;
		string4 	oh_su_start_in;
		string4 	oh_su_start;
		unsigned8	oh_su_start_st;
		string4 	oh_su_end_in;
		string4 	oh_su_end;
		unsigned8	oh_su_end_st;
		string4 	oh_su_lunch_in;
		string4 	oh_su_lunch;
		unsigned8	oh_su_lunch_st;
		string4 	oh_su_dur_in;
		string4 	oh_su_dur;
		unsigned8	oh_su_dur_st;
		unsigned8 languages_in;
		unsigned8 languages;
		unsigned8 languages_st;
		string4 	exam_rooms_in;
		string4 	exam_rooms;
		unsigned8 exam_rooms_st;
		string1 	medicaid_part_in;
		string1 	medicaid_part;
		unsigned8 medicaid_part_st;
		string1 	medicare_part_in;
		string1 	medicare_part;
		unsigned8 medicare_part_st;
		string1 	new_patients_in;
		string1 	new_patients;
		unsigned8 new_patients_st;
		string20 	filecode;
		test_flag;
	end;

	export office_attributes_facility_base:=record
		office_attributes_facility_in;
	end;

	export npi_extension_in:=record
		string10	npi_num;
		string 		npi_st;
		string1 	dba_type_code;
		string 		dba_type_code_st;
		string100	other_name_in;	// added 6.6
		string20 	other_name_key;
		string50 	other_fullname;
		string15 	other_pre_name;
		string50 	other_first_name;
		string50 	other_middle_name;
		string50 	other_last_name;
		string15 	other_maturity_suffix;
		string15 	other_other_suffix;
		string1 	other_gender;
		string50 	other_preferred_name;
		unsigned3 other_name_confidence;
		string 		other_name_st;
		string1 	other_name_type_code;
		string 		other_name_type_code_st;
		string1 	sole_proprietor;
		string 		sole_proprietor_st;
		string100	parent_org_lbn_in;	// added 6.6
		string20 	parent_org_lbn_key;
		string100 parent_org_lbn_name;
		string3 	parent_org_lbn_apcfirm1;
		string 		parent_org_lbn_st;
		string100	authorized_name_in;	// added 6.6
		string20 	authorized_name_key;
		string50 	authorized_fullname;
		string15 	authorized_pre_name;
		string50 	authorized_first_name;
		string50 	authorized_middle_name;
		string50 	authorized_last_name;
		string15 	authorized_maturity_suffix;
		string15 	authorized_other_suffix;
		string1 	authorized_gender;
		string50	authorized_preferred_name;
		unsigned3 authorized_name_confidence;
		string 		authorized_name_st;
		string35 	authorized_title;
		string 		authorized_title_st;
		string10 	authorized_phone;
		string 		authorized_phone_st;
		string10 	taxonomy;
		string1 	taxonomy_primary_ind;
		string 		taxonomy_st;
		string10 	taxonomy2;
		string1 	taxonomy2_primary_ind;
		string 		taxonomy2_st;
		string10 	taxonomy3;
		string1 	taxonomy3_primary_ind;
		string 		taxonomy3_st;
		string10 	taxonomy4;
		string1 	taxonomy4_primary_ind;
		string 		taxonomy4_st;
		string10 	taxonomy5;
		string1 	taxonomy5_primary_ind;
		string 		taxonomy5_st;
		string10 	taxonomy6;
		string1 	taxonomy6_primary_ind;
		string 		taxonomy6_st;
		string10 	taxonomy7;
		string1 	taxonomy7_primary_ind;
		string 		taxonomy7_st;
		string10 	taxonomy8;
		string1 	taxonomy8_primary_ind;
		string 		taxonomy8_st;
		string10 	taxonomy9;
		string1 	taxonomy9_primary_ind;
		string 		taxonomy9_st;
		string10 	taxonomy10;
		string1 	taxonomy10_primary_ind;
		string 		taxonomy10_st;
		string10 	taxonomy11;
		string1 	taxonomy11_primary_ind;
		string 		taxonomy11_st;
		string10 	taxonomy12;
		string1 	taxonomy12_primary_ind;
		string 		taxonomy12_st;
		string10 	taxonomy13;
		string1 	taxonomy13_primary_ind;
		string 		taxonomy13_st;
		string10 	taxonomy14;
		string1 	taxonomy14_primary_ind;
		string 		taxonomy14_st;
		string10 	taxonomy15;
		string1 	taxonomy15_primary_ind;
		string 		taxonomy15_st;
		string25 	lic1_num_in;
		string2 	lic1_state;
		string20	lic1_num;
		string10 	lic1_type;
		string1 	lic1_status;
		string10 	lic1_begin_date;
		string10 	lic1_end_date;
		string16	lic1_drug_schedule;	// added 6.6
		string 		lic1_st;
		string25 	lic2_num_in;
		string2 	lic2_state;
		string20	lic2_num;
		string10 	lic2_type;
		string1 	lic2_status;
		string10 	lic2_begin_date;
		string10 	lic2_end_date;
		string16	lic2_drug_schedule;	// added 6.6
		string 		lic2_st;
		string25 	lic3_num_in;
		string2 	lic3_state;
		string20	lic3_num;
		string10 	lic3_type;
		string1 	lic3_status;
		string10 	lic3_begin_date;
		string10 	lic3_end_date;
		string16	lic3_drug_schedule;	// added 6.6		
		string 		lic3_st;
		string25 	lic4_num_in;
		string2 	lic4_state;
		string20	lic4_num;
		string10 	lic4_type;
		string1 	lic4_status;
		string10 	lic4_begin_date;
		string10 	lic4_end_date;
		string16	lic4_drug_schedule;	// added 6.6
		string 		lic4_st;
		string25 	lic5_num_in;
		string2 	lic5_state;
		string20	lic5_num;
		string10 	lic5_type;
		string1 	lic5_status;
		string10 	lic5_begin_date;
		string10 	lic5_end_date;
		string16	lic5_drug_schedule;	// added 6.6
		string 		lic5_st;
		string25 	lic6_num_in;
		string2 	lic6_state;
		string20	lic6_num;
		string10 	lic6_type;
		string1 	lic6_status;
		string10 	lic6_begin_date;
		string10 	lic6_end_date;
		string16	lic6_drug_schedule;	// added 6.6
		string 		lic6_st;
		string25 	lic7_num_in;
		string2 	lic7_state;
		string20	lic7_num;
		string10 	lic7_type;
		string1 	lic7_status;
		string10 	lic7_begin_date;
		string10 	lic7_end_date;
		string16	lic7_drug_schedule;	// added 6.6
		string 		lic7_st;
		string25 	lic8_num_in;
		string2 	lic8_state;
		string20	lic8_num;
		string10 	lic8_type;
		string1 	lic8_status;
		string10 	lic8_begin_date;
		string10 	lic8_end_date;
		string16	lic8_drug_schedule;	// added 6.6
		string 		lic8_st;
		string25 	lic9_num_in;
		string2 	lic9_state;
		string20	lic9_num;
		string10 	lic9_type;
		string1 	lic9_status;
		string10 	lic9_begin_date;
		string10 	lic9_end_date;
		string16	lic9_drug_schedule;	// added 6.6
		string 		lic9_st;
		string25 	lic10_num_in;
		string2 	lic10_state;
		string20	lic10_num;
		string10 	lic10_type;
		string1 	lic10_status;
		string10 	lic10_begin_date;
		string10 	lic10_end_date;
		string16	lic10_drug_schedule;	// added 6.6
		string 		lic10_st;
		string25 	lic11_num_in;
		string2 	lic11_state;
		string20	lic11_num;
		string10 	lic11_type;
		string1 	lic11_status;
		string10 	lic11_begin_date;
		string10 	lic11_end_date;
		string16	lic11_drug_schedule;	// added 6.6
		string 		lic11_st;
		string25 	lic12_num_in;
		string2 	lic12_state;
		string20	lic12_num;
		string10 	lic12_type;
		string1 	lic12_status;
		string10 	lic12_begin_date;
		string10 	lic12_end_date;
		string16	lic12_drug_schedule;	// added 6.6
		string 		lic12_st;
		string25 	lic13_num_in;
		string2 	lic13_state;
		string20	lic13_num;
		string10 	lic13_type;
		string1 	lic13_status;
		string10 	lic13_begin_date;
		string10 	lic13_end_date;
		string16	lic13_drug_schedule;	// added 6.6
		string 		lic13_st;
		string25 	lic14_num_in;
		string2 	lic14_state;
		string20	lic14_num;
		string10 	lic14_type;
		string1 	lic14_status;
		string10 	lic14_begin_date;
		string10 	lic14_end_date;
		string16	lic14_drug_schedule;	// added 6.6
		string 		lic14_st;
		string25 	lic15_num_in;
		string2 	lic15_state;
		string20	lic15_num;
		string10 	lic15_type;
		string1 	lic15_status;
		string10 	lic15_begin_date;
		string10 	lic15_end_date;
		string16	lic15_drug_schedule;	// added 6.6
		string 		lic15_st;
		string10 	npi_deact_date;
		string10	npi_enum_date;	// added 6.6
		string10	npi_react_date;	// added 6.6
		test_flag;
	end;

	export npi_extension_base:=record
		npi_extension_in;
		string1  normed_name_rec_type;           
		string20 first_name;                     
		string20 middle_name;                    
		string20 last_name;                      
		string5  maturity_suffix;        
		string8  	date_first_seen  := '0';
		string8  	date_last_seen :='0';
		string1  	record_type;
		string2  	src;
		clean_name;
		string8  	clean_lic1_begin_date;
		string8   clean_lic1_end_date;
		string8   clean_lic2_begin_date;
		string8   clean_lic2_end_date;
		string8   clean_lic3_begin_date;
		string8   clean_lic3_end_date;
		string8   clean_lic4_begin_date;
		string8   clean_lic4_end_date;
		string8   clean_lic5_begin_date;
		string8   clean_lic5_end_date;
		string8   clean_lic6_begin_date;
		string8   clean_lic6_end_date;
		string8   clean_lic7_begin_date;
		string8   clean_lic7_end_date;
		string8   clean_lic8_begin_date;
		string8   clean_lic8_end_date;
		string8   clean_lic9_begin_date;
		string8   clean_lic9_end_date;
		string8   clean_lic10_begin_date;
		string8   clean_lic10_end_date;
		string8   clean_lic11_begin_date;
		string8   clean_lic11_end_date;
		string8   clean_lic12_begin_date;
		string8   clean_lic12_end_date;
		string8   clean_lic13_begin_date;
		string8   clean_lic13_end_date;
		string8   clean_lic14_begin_date;
		string8   clean_lic14_end_date;
		string8   clean_lic15_begin_date;
		string8   clean_lic15_end_date;
		string8   clean_npi_deact_date;
		string8		clean_npi_enum_date;
		string8		clean_npi_react_date;
		unsigned6 did 			:= 0;	
		unsigned1 did_score 			:= 0;
		unsigned6 Date_vendor_first_reported;
		unsigned6 Date_vendor_last_reported;
		unsigned8	source_rec_id ;
		unsigned6 bdid;
		unsigned1 bdid_score := 0; 
		unsigned8	lnpid;
	end;
	
	export npi_extension_facility_in:=record
		string10	npi_num;
		string		npi_st;
		string1 	dba_type_code;
		string 		dba_type_code_st;
		string100	other_name_in;	// added 6.6
		string20 	other_name_key;
		string50 	other_fullname;
		string15 	other_pre_name;
		string50 	other_first_name;
		string50 	other_middle_name;
		string50 	other_last_name;
		string15 	other_maturity_suffix;
		string15 	other_other_suffix;
		string1 	other_gender;
		string50 	other_preferred_name;
		unsigned3 other_name_confidence;
		string 		other_name_st;
		string1 	other_name_type_code;
		string 		other_name_type_code_st;
		string1 	sole_proprietor;
		string 		sole_proprietor_st;
		string100	parent_org_lbn_in;	// added 6.6
		string20 	parent_org_lbn_key;
		string100 parent_org_lbn_name;
		string3 	parent_org_lbn_apcfirm1;
		string 		parent_org_lbn_st;
		string100	authorized_name_in;	// added 6.6
		string20 	authorized_name_key;
		string50 	authorized_fullname;
		string15 	authorized_pre_name;
		string50 	authorized_first_name;
		string50 	authorized_middle_name;
		string50 	authorized_last_name;
		string15 	authorized_maturity_suffix;
		string15 	authorized_other_suffix;
		string1 	authorized_gender;
		string50 	authorized_preferred_name;
		unsigned3 authorized_name_confidence;
		string 		authorized_name_st;
		string35 	authorized_title;
		string 		authorized_title_st;
		string10 	authorized_phone;
		string 		authorized_phone_st;
		string10 	taxonomy;
		string1 	taxonomy_primary_ind;
		string 		taxonomy_st;
		string10 	taxonomy2;
		string1 	taxonomy2_primary_ind;
		string 		taxonomy2_st;
		string10 	taxonomy3;
		string1 	taxonomy3_primary_ind;
		string 		taxonomy3_st;
		string10 	taxonomy4;
		string1 	taxonomy4_primary_ind;
		string 		taxonomy4_st;
		string10 	taxonomy5;
		string1 	taxonomy5_primary_ind;
		string 		taxonomy5_st;
		string10 	taxonomy6;
		string1 	taxonomy6_primary_ind;
		string 		taxonomy6_st;
		string10 	taxonomy7;
		string1 	taxonomy7_primary_ind;
		string 		taxonomy7_st;
		string10 	taxonomy8;
		string1 	taxonomy8_primary_ind;
		string 		taxonomy8_st;
		string10 	taxonomy9;
		string1 	taxonomy9_primary_ind;
		string 		taxonomy9_st;
		string10 	taxonomy10;
		string1 	taxonomy10_primary_ind;
		string 		taxonomy10_st;
		string10 	taxonomy11;
		string1 	taxonomy11_primary_ind;
		string 		taxonomy11_st;
		string10 	taxonomy12;
		string1 	taxonomy12_primary_ind;
		string 		taxonomy12_st;
		string10 	taxonomy13;
		string1 	taxonomy13_primary_ind;
		string 		taxonomy13_st;
		string10 	taxonomy14;
		string1 	taxonomy14_primary_ind;
		string 		taxonomy14_st;
		string10 	taxonomy15;
		string1 	taxonomy15_primary_ind;
		string 		taxonomy15_st;
		string25 	lic1_num_in;
		string2 	lic1_state;
		unsigned8 lic1_num;
		string10 	lic1_type;
		string1 	lic1_status;
		string10 	lic1_begin_date;
		string10 	lic1_end_date;
		string16	lic1_drug_schedule;	// added 6.6
		string 		lic1_st;
		string25 	lic2_num_in;
		string2 	lic2_state;
		unsigned8 lic2_num;
		string10 	lic2_type;
		string1 	lic2_status;
		string10 	lic2_begin_date;
		string10 	lic2_end_date;
		string16	lic2_drug_schedule;	// added 6.6
		string 		lic2_st;
		string25 	lic3_num_in;
		string2 	lic3_state;
		unsigned8 lic3_num;
		string10 	lic3_type;
		string1 	lic3_status;
		string10 	lic3_begin_date;
		string10 	lic3_end_date;
		string16	lic3_drug_schedule;	// added 6.6
		string 		lic3_st;
		string25 	lic4_num_in;
		string2 	lic4_state;
		unsigned8 lic4_num;
		string10 	lic4_type;
		string1 	lic4_status;
		string10 	lic4_begin_date;
		string10 	lic4_end_date;
		string16	lic4_drug_schedule;	// added 6.6
		string 		lic4_st;
		string25 	lic5_num_in;
		string2 	lic5_state;
		unsigned8 lic5_num;
		string10 	lic5_type;
		string1 	lic5_status;
		string10 	lic5_begin_date;
		string10 	lic5_end_date;
		string16	lic5_drug_schedule;	// added 6.6
		string 		lic5_st;
		string25 	lic6_num_in;
		string2 	lic6_state;
		unsigned8 lic6_num;
		string10 	lic6_type;
		string1 	lic6_status;
		string10 	lic6_begin_date;
		string10 	lic6_end_date;
		string16	lic6_drug_schedule;	// added 6.6
		string 		lic6_st;
		string25 	lic7_num_in;
		string2 	lic7_state;
		unsigned8 lic7_num;
		string10 	lic7_type;
		string1 	lic7_status;
		string10 	lic7_begin_date;
		string10 	lic7_end_date;
		string16	lic7_drug_schedule;	// added 6.6
		string 		lic7_st;
		string25 	lic8_num_in;
		string2 	lic8_state;
		unsigned8 lic8_num;
		string10 	lic8_type;
		string1 	lic8_status;
		string10 	lic8_begin_date;
		string10 	lic8_end_date;
		string16	lic8_drug_schedule;	// added 6.6
		string 		lic8_st;
		string25 	lic9_num_in;
		string2 	lic9_state;
		unsigned8 lic9_num;
		string10 	lic9_type;
		string1 	lic9_status;
		string10 	lic9_begin_date;
		string10 	lic9_end_date;
		string16	lic9_drug_schedule;	// added 6.6
		string 		lic9_st;
		string25 	lic10_num_in;
		string2 	lic10_state;
		unsigned8 lic10_num;
		string10 	lic10_type;
		string1 	lic10_status;
		string10 	lic10_begin_date;
		string10 	lic10_end_date;
		string16	lic10_drug_schedule;	// added 6.6
		string 		lic10_st;
		string25 	lic11_num_in;
		string2 	lic11_state;
		unsigned8 lic11_num;
		string10 	lic11_type;
		string1 	lic11_status;
		string10 	lic11_begin_date;
		string10 	lic11_end_date;
		string16	lic11_drug_schedule;	// added 6.6
		string 		lic11_st;
		string25 	lic12_num_in;
		string2 	lic12_state;
		unsigned8 lic12_num;
		string10 	lic12_type;
		string1 	lic12_status;
		string10 	lic12_begin_date;
		string10 	lic12_end_date;
		string16	lic12_drug_schedule;	// added 6.6
		string   	lic12_st;
		string25 	lic13_num_in;
		string2 	lic13_state;
		unsigned8 lic13_num;
		string10 	lic13_type;
		string1 	lic13_status;
		string10 	lic13_begin_date;
		string10 	lic13_end_date;
		string16	lic13_drug_schedule;	// added 6.6
		string 		lic13_st;
		string25 	lic14_num_in;
		string2 	lic14_state;
		unsigned8 lic14_num;
		string10 	lic14_type;
		string1 	lic14_status;
		string10 	lic14_begin_date;
		string10 	lic14_end_date;
		string16	lic14_drug_schedule;	// added 6.6
		string 		lic14_st;
		string25 	lic15_num_in;
		string2 	lic15_state;
		unsigned8 lic15_num;
		string10 	lic15_type;
		string1 	lic15_status;
		string10 	lic15_begin_date;
		string10 	lic15_end_date;
		string16	lic15_drug_schedule;	// added 6.6
		string 		lic15_st;
		string10 	npi_deact_date;
		string10	npi_enum_date;	// added 6.6
		string10	npi_react_date;	// added 6.6
		test_flag;
	end;
	
	export npi_extension_facility_base:=record
		npi_extension_facility_in;
		string1  normed_name_rec_type;           
		string20 first_name;                     
		string20 middle_name;                    
		string20 last_name;                      
		string5  maturity_suffix;                    
		string8  date_first_seen  := '0';
		string8  date_last_seen :='0';
		string1  record_type;
		string2  src;
		clean_name;
		string8  	clean_lic1_begin_date;
		string8   clean_lic1_end_date;
		string8   clean_lic2_begin_date;
		string8   clean_lic2_end_date;
		string8   clean_lic3_begin_date;
		string8   clean_lic3_end_date;
		string8   clean_lic4_begin_date;
		string8   clean_lic4_end_date;
		string8   clean_lic5_begin_date;
		string8   clean_lic5_end_date;
		string8   clean_lic6_begin_date;
		string8   clean_lic6_end_date;
		string8   clean_lic7_begin_date;
		string8   clean_lic7_end_date;
		string8   clean_lic8_begin_date;
		string8   clean_lic8_end_date;
		string8   clean_lic9_begin_date;
		string8   clean_lic9_end_date;
		string8   clean_lic10_begin_date;
		string8   clean_lic10_end_date;
		string8   clean_lic11_begin_date;
		string8   clean_lic11_end_date;
		string8   clean_lic12_begin_date;
		string8   clean_lic12_end_date;
		string8   clean_lic13_begin_date;
		string8   clean_lic13_end_date;
		string8   clean_lic14_begin_date;
		string8   clean_lic14_end_date;
		string8   clean_lic15_begin_date;
		string8   clean_lic15_end_date;
		string8   clean_npi_deact_date;
		string8		clean_npi_enum_date;
		string8		clean_npi_react_date;
		unsigned6 did 			:= 0;	
		unsigned1 did_score 			:= 0;
		unsigned6 Date_vendor_first_reported;
		unsigned6 Date_vendor_last_reported;
		unsigned8	source_rec_id ;
		unsigned6 bdid;
		unsigned1 bdid_score := 0; 
		unsigned8	lnpid;
	end;
	
	export basc_facility_mme_in:=record
		string64 mm_table;
		string64 skey_type;
		string38 surrogate_key;
		string38 group_key;
		string10 dept_group_key;
		string multiple_bels;
		test_flag;
	end;

	export basc_facility_mme_base:=record
		basc_facility_mme_in;
	end;

	export basc_deceased_in:=record
		string38 group_key;
		string20 name_key;
		string50 full_name;
		string15 pre_name;
		string50 first_name;
		string50 middle_name;
		string50 last_name;
		string15 maturity_suffix;
		string15 other_suffix;
		string50 preferred_name;
		string1 gender;
		unsigned8 name_confidence;
		string10 birthdate;
		string10 incomplete_birthdate;
		string10 date_of_death;
		string10 incomplete_date_of_death;
		test_flag;
	end;

	export basc_deceased_base:=record
		basc_deceased_in;	
		clean_name;
		string8  	date_first_seen  := '0';
		string8  	date_last_seen :='0';
		string10 clean_birthdate;
		string10 clean_incomplete_birthdate;
		string10 clean_date_of_death;
		string10 clean_incomplete_date_of_death;
		unsigned6 did 			:= 0;	
		unsigned1 did_score 			:= 0;
		unsigned6 Date_vendor_first_reported;
		unsigned6 Date_vendor_last_reported;
		unsigned8	source_rec_id ;
		string2  	src;
		string1  	record_type;
		unsigned6 bdid;
		unsigned1 bdid_score := 0; 
		unsigned8	lnpid;
	end;

	export basc_addr_in := record
    string38     surrogate_key;
		string100		 prac_company1_in;	// added 6.6
    string20     prac_company1_key;
    string100    prac_company1_name;
    string3      prac_company1_apcfirm1;
    unsigned8    prac_company1_st;
		string50		 name_in;	// added 6.6
    string20     name_key;
    string50     fullname;
    string15     pre_name;
    string50     first_name;
    string50     middle_name;
    string50     last_name;
    string15     maturity_suffix;
    string15     other_suffix;
    string1      gender;
    string50     preferred_name;
    string       name_confidence;
    unsigned8    name_st;
    string10     prac_phone1;
    unsigned8    prac_phone1_st;
    string10     bill_phone1;
    unsigned8    bill_phone1_st;
    string10     prac_fax1;
    unsigned8    prac_fax1_st;
    string10     bill_fax1;
    unsigned8    bill_fax1_st;
    string48     email_addr;
    unsigned8    email_addr_st;
    string50     web_site;
    unsigned8    web_site_st;
    string9      tin1;
    unsigned8    tin1_st;
    string9      dea_num1;
    string8      dea_num1_exp;
    string16     dea_num1_sch;	// changed from string2 to string16 in ver 6.6
    string1      dea_num1_bus_act_ind;
		string1			 dea_num1_bus_subcode;	// added 6.6
		string1			 dea_num2_payment_ind;	// added 6.6
    unsigned8    dea_num1_st;
    string25     lic1_num_in;
    string2      lic1_state;
    string8    	 lic1_num;
    string10     lic1_type;
    string1      lic1_status;
    string10     lic1_begin_date;
    string10     lic1_end_date;
		string16		 lic1_drug_schedule;	// added 6.6
    unsigned8    lic1_st;
    string25     lic2_num_in;
    string2      lic2_state;
    string8    	 lic2_num;
    string10     lic2_type;
    string1      lic2_status;
    string10     lic2_begin_date;
    string10     lic2_end_date;
		string16		 lic2_drug_schedule;	// added 6.6
    unsigned8    lic2_st;
    string25     lic3_num_in;
    string2      lic3_state;
    string8			 lic3_num;
    string10     lic3_type;
    string1      lic3_status;
    string10     lic3_begin_date;
    string10     lic3_end_date;
		string16		 lic3_drug_schedule;	// added 6.6
    unsigned8    lic3_st;
    string20     prac1_key;
    string50     prac1_primary_address;
    string50     prac1_secondary_address; 
    string28     prac1_city;
    string2      prac1_state;
    string5      prac1_zip;
    string4      prac1_zip4;
    string2      prac1_rectype;
    string10     prac1_primary_range;
    string2      prac1_pre_directional;
    string28     prac1_primary_name;
    string4      prac1_suffix;
    string2      prac1_post_directional;
    string10     prac1_unit_designator;
    string8      prac1_secondary_range;
    string9      prac1_pobox;
    string9      prac1_rrnumber;
    string10     prac1_npsr;
    string6      prac1_ace_stat_code;
    string6      prac1_error_code;
    string5      prac1_fipscode;
    string1      prac1_rdi;
    unsigned8    prac1_st;
    string20     bill1_key;
    string50     bill1_primary_address;
    string50     bill1_secondary_address;
    string28     bill1_city;
    string2      bill1_state;
    string5      bill1_zip;
    string4      bill1_zip4;
    string2      bill1_rectype;
    string10     bill1_primary_range;
    string2      bill1_pre_directional;
    string28     bill1_primary_name;
    string4      bill1_suffix;
    string2      bill1_post_directional;
    string10     bill1_unit_designator;
    string8      bill1_secondary_range;
    string9      bill1_pobox;
    string9      bill1_rrnumber;
    string10     bill1_npsr;
    string6      bill1_ace_stat_code;
    string6      bill1_error_code;
    string5      bill1_fipscode;
    string1      bill1_rdi;
    unsigned8    bill1_st;
    string12     sequence_num;
    string8      project_num;
    string9      filecode;
    unsigned8    state_mask;               
    string3      dept_code;
    string50     provider_id;
    unsigned8    provider_id_st;
    string10     npi_num;
    string2      npi_drc;
    unsigned8    npi_st;
    string10     medicare_fac_num;
		string2			 medicare_fac_num_status_code;
		string8			 medicare_fac_num_term_date;
    unsigned8    medicare_fac_num_st;
    string10     medicaid_fac_num;
    unsigned8    medicaid_fac_num_st;
    string10     facility_type;
    unsigned8    facility_type_st;
    string10     taxonomy;
    string10     last_update_date;
    string38     group_key;
    string7      ncpdp_id;
    unsigned8    ncpdp_id_st;
    string10     group_affiliation;
    string10     hosp_affiliation;
    string2      sanc1_state;
    string10     sanc1_date;
    string25     sanc1_case;
    string50     sanc1_source;
    string1000   sanc1_complaint;
    unsigned8    sanc1_st;
    unsigned8    taxonomy_st;
		string100		 dba_in;	// added 6.6
    string20     dba_key;
    string100    dba_name;
    string3      dba_apcfirm1;
    unsigned8    dba_st;
		string100		 bill_company1_in;	// added 6.6
    string20     bill_company1_key;
    string100    bill_company1_name;
    string3      bill_company1_apcfirm1;
    unsigned8    bill_company1_st;
    string1      taxonomy_primary_ind;
    unsigned2    call_return_id;
    string10     dea_num1_deact_date;
    string10     npi_deact_date;
    string1      ownership;
    unsigned8    ownership_st;
    string1      control;
    unsigned8    control_st;
    unsigned2    approval;
    unsigned8    approval_st;
    string10     sanc1_rein_date;
    string10     clia_num;
    string2      clia_status_code;
    string1      clia_cert_type_code;
    string10     clia_cert_eff_date;
    string10     clia_end_date;
		unsigned8		 clia_test_vol_accredited;
		unsigned8		 clia_test_vol_annual;
		unsigned8		 clia_test_vol_ppm;
		unsigned8		 clia_test_vol_survey;
		unsigned8		 clia_test_vol_waived;
    unsigned8    clia_data_st;
	end;

	export basc_addr_base:=record
		basc_addr_in-[
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
		string51	clean_dba_name;
		string51 	clean_prac1_company_name;
		string1   normed_addr_rec_type:=''; //P=primary, S=secondary	
		string50  orig_adresss;
		string3   orig_state;
		string28  orig_city;
		string5   orig_zip;
		string50  Prepped_addr1;
		string39  Prepped_addr2;
		string10 	clean_prim_range;
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
		string4 	clean_lot;
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
		string10 	clean_Phone;
		string8 	date_first_seen  := '0';
		string8 	date_last_seen :='0';
		string1 	record_type;
		string2 	src;
		string8  	clean_lic1_begin_date;
		string8  	clean_lic1_end_date;
		string8  	clean_lic2_begin_date;
		string8  	clean_lic2_end_date;
		string8  	clean_lic3_begin_date;
		string8  	clean_lic3_end_date;
		string8  	clean_last_update_date;
		string8  	clean_sanc1_date;
		string8 	clean_dea_num1_deact_date; 
		string8   clean_dea_num1_exp;
		string8  	clean_npi_deact_date;
		string8  	clean_sanc1_rein_date;
		string8  	clean_clia_cert_eff_date;
		string8  	clean_clia_end_date;
		string8		clean_medicare_fac_num_term_date;
		unsigned6 did 			:= 0;	
		unsigned1 did_score 			:= 0;
		unsigned6 Date_vendor_first_reported;
		unsigned6 Date_vendor_last_reported;
		unsigned8	source_rec_id;
		unsigned8	lnpid;
		AID.Common.xAID	RawAID;
		AID.Common.xAID	ACEAID;
		unsigned6 bdid;
		unsigned1 bdid_score := 0; 
		BIPV2.IDlayouts.l_xlink_ids;
	end;

	export last_name_stats_in := record
    string50     last_name;
    unsigned8    cnt;
	end;

	export last_name_stats_base := record
    string50		last_name;
    unsigned8   cnt;
	end;

	export taxonomy_equiv_in := record
    string10     taxonomy;
    string10     taxonomy2;
    string11     score;
	end;

	export taxonomy_equiv_base := record
    string10     taxonomy;
    string10     taxonomy2;
    string11     score;  
	end;

	export client_data_in := record
    string9      hashed_ssn;
    string15     filecode;
    string50     provider_id;
    string10     birthdate;
    string10     date_of_death;
    string38     group_key;
    string10     load_date;
    string50     full_name;
    string50     first_name;
    string50     middle_name;
    string50     last_name;
    string15     maturity_suffix;
    string48     email_addr;
    string50     web_site;
    string6      upin;
    string9      dea_num;
    string10     npi_num;
    string25     lic_num_in;
    string2      lic_state;
    string       lic_num;      
    string10     lic_type;
    string20     prac_key;
    string50     prac_primary_address;
    string50     prac_secondary_address;
    string28     prac_city;
    string2      prac_state;
    string5      prac_zip;
    string4      prac_zip4;
    string50     prac_primary_range;
    string2      prac_pre_directional;
    string28     prac_primary_name;
    string4      prac_suffix;
    string2      prac_post_directional;
    string10     prac_unit_designator;
    string8      prac_secondary_range;
    string9      prac_pobox;
    string10     prac_phone;
    string10     prac_fax;
    string100    medschool;
    string4      medschool_year;
    string10     taxonomy;
    string38     surrogate_key;
	end;

	export client_data_base := record
		client_data_in -[
		prac_primary_address,
    prac_secondary_address,
    prac_city,
    prac_state,
    prac_zip,
    prac_zip4,
    prac_primary_range,
    prac_pre_directional,
    prac_primary_name,
		prac_suffix,
    prac_post_directional,
    prac_unit_designator,
		prac_secondary_range
		];
		clean_name;
		string1 normed_addr_rec_type:=''; //P=primary, S=secondary
		string50 	orig_adresss;
		string3 	orig_state;
		string28	orig_city;
		string5 	orig_zip;
		string50 	Prepped_addr1;
		string39 	Prepped_addr2;
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
		string10 	clean_prac_Phone;
		string8  	date_first_seen  := '0';
		string8  	date_last_seen :='0';
		string1  	record_type;
		string2  	src;
		string8  	clean_birthdate;
		string8   clean_date_of_death;
		string4 	clean_medschool_year;
		string8   clean_load_date;
		unsigned6 did 			:= 0;	
		unsigned1 did_score 			:= 0;
		unsigned6 Date_vendor_first_reported;
		unsigned6 Date_vendor_last_reported;
		unsigned8	source_rec_id ;
		unsigned6 bdid;
		unsigned1 bdid_score := 0; 
		unsigned8	lnpid;
		BIPV2.IDlayouts.l_xlink_ids;
		AID.Common.xAID	RawAID;
		AID.Common.xAID	ACEAID;
	end;

	export claims_address_master_in := record
    string10     bill_npi;
    string20     addr_key;
    string50     primary_address;
    string50     secondary_address;
    string28     city;
    string2      state;
    string5      zip;
    string4      zip4;
    string2      rectype;
    string10     primary_range;
    string2      pre_directional;
    string28     primary_name;
    string4      suffix;
    string2      post_directional;
    string10     unit_designator;
    string8      secondary_range;
    string9      pobox;
    string9      rrnumber;
    string10     npsr;
    string6      ace_stat_code;
    string6      error_code;
    string5      fipscode;
    string1      rdi;
    unsigned8    addr_st;              
    unsigned8    addr_ustat;         
    string10     bill_tin;
    string10     rendering_npi;
    string11     addr_usage;                    
    string10     latest_clm_date;  
    string10     earliest_clm_date;    
    string10     service_npi;
    string3      type_bill;
    string2      place_service;
    string100    service_company;
    string100    service_name2;
    string10     insert_date;     
    string11     source;      
		test_flag;
	end;

	export claims_address_master_base := record
		claims_address_master_in -[
		primary_address,		
		secondary_address,	
		city,	
		state,	
		zip,	
		zip4,	
		rectype,	
		primary_range,	
		pre_directional,	
		primary_name,	
		suffix,	
		post_directional,	
		unit_designator,	
		secondary_range,	
		pobox,	
		rrnumber,	
		npsr,	
		ace_stat_code,			
		error_code,			
		fipscode,			
		rdi,			
		addr_st];
		string51	clean_service_company;
		string51 	clean_service_name2;
		string1   normed_addr_rec_type:=''; //P=primary, S=secondary	
		string50  orig_adresss;
		string3   orig_state;
		string28  orig_city;
		string5   orig_zip;
		string50  Prepped_addr1;
		string39  Prepped_addr2;
		string10 	clean_prim_range;
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
		string4 	clean_lot;
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
		string8 	date_first_seen  := '0';
		string8 	date_last_seen :='0';
		string1 	record_type;
		string2 	src;
		string8  	clean_latest_clm_date;
		string8  	clean_earliest_clm_date;
		string8  	clean_insert_date;
		unsigned6 did 			:= 0;	
		unsigned1 did_score 			:= 0;
		unsigned6 Date_vendor_first_reported;
		unsigned6 Date_vendor_last_reported;
		unsigned8	source_rec_id;
		unsigned8	lnpid;
		AID.Common.xAID	RawAID;
		AID.Common.xAID	ACEAID;
		unsigned6 bdid;
		unsigned1 bdid_score := 0; 
		BIPV2.IDlayouts.l_xlink_ids;
	end;

	export source_confidence_lu_in   := record
    string9       filecode;
    unsigned3     confidence_score;  
    string10      audit_date;   
		test_flag;
	end;

	export source_confidence_lu_base   := record
   source_confidence_lu_in;
   string8       clean_audit_date;  
	end;

	export claims_by_month_in := record
    string10      bill_tin;
    string20      addr_key;
    string10      bill_npi;
    string10      rendering_npi;
    string11      cbm1;     
    string11      cbm3;        
    string11      cbm6;       
    string11      cbm12;  
    string11      cbm18;   
		test_flag;
	end;

	export claims_by_month_base := record
		claims_by_month_in;
	end;

		export best_hospital_in := record
    string20     addr_key;
    string38      group_key;
    string100     prac_company1_name;
    string10      prac_phone1;
		test_flag;
	end;

	export best_hospital_base := record
    best_hospital_in;
		string100     clean_prac_company1_name;
    string10      clean_prac_phone1;
	end;

	export aci_schedule_in	:= record
		string2		state;
		string5		provider_type_code;
		string50	provider_type;
		string200	board_name;
		string20	primary_source;
		string20	secondary_source;
		string20	tertiary_source;
		string30	reporting_method;
		string30	timeframe;
		string30	monitor_frequency;
		string100	followup_method;
	end;
	
	export aci_schedule_base	:= record
		aci_schedule_in;
	end;
	
	export business_activities_lu_in	:= record
		string1		dea_bus_act_ind;
		string1		dea_bus_subcode;
		string50	dea_bus_act_descr;
	end;
	
	export business_activities_lu_base	:= record
		business_activities_lu_in;
	end;
	
	export cms_ecp_in	:= record
		unsigned8	seq_num;
		string20	filecode;
		string128	ecp_provider_name;
		string128	ecp_site_name;
		string128	ecp_org_name;
		string15	ecp_org_ein;
		string3		ecp_type_hosp;
		string3		ecp_type_fqhc;
		string3		ecp_type_rw;
		string3		ecp_type_fp;
		string3		ecp_type_ip;
		string3		ecp_type_other;
		unsigned8	ecp_type_all;
		string128	ecp_site_addr1;
		string50	ecp_site_addr2;
		string28	ecp_site_city;
		string2		ecp_site_state;
		string5		ecp_site_zip;
		string40	ecp_site_county;
		string50	ecp_org_addr1;
		string50	ecp_org_addr2;
		string28	ecp_org_city;
		string2		ecp_org_state;
		string5		ecp_org_zip;
		string50	poc_name_fqhc;
		string25	poc_phone_fqhc;
		string25	poc_phone_ch;
		string25	poc_phone_rw;
		string25	poc_phone_tb;
		string25	poc_phone_std;
		string128	poc_name_pp;
		string50	poc_title_pp;
		string25	poc_phone_pp;
		string50	poc_name_opa;
		string50	poc_title_opa;
		string25	poc_phone_opa;
		string50	poc_name_ihs;
		string50	poc_title_ihs;
		string25	poc_phone_ihs;
		string144	poc_name_bl;
		string25	poc_phone_bl;
		string50	poc_name_dental;
		string25	poc_phone_dental;
		test_flag;
	end;
	
	export cms_ecp_base	:= record
		cms_ecp_in;
		string128	clean_ecp_provider_name;
		string128	clean_ecp_site_name;
		string128	clean_ecp_org_name;
		string50	clean_poc_name_fqhc;
		string128	clean_poc_name_pp;
		string50	clean_poc_name_opa;
		string50	clean_poc_name_ihs;
		string144	clean_poc_name_bl;
		string50	clean_poc_name_dental;
    string10  clean_poc_phone_fqhc;
		string10	clean_poc_phone_ch;
		string10	clean_poc_phone_rw;
		string10	clean_poc_phone_tb;
		string10	clean_poc_phone_std;
		string10	clean_poc_phone_pp;
		string10	clean_poc_phone_opa;
		string10	clean_poc_phone_ihs;
		string10	clean_poc_phone_bl;
		string10	clean_poc_phone_dental;
   	string1   normed_addr_rec_type:=''; //1-site addr1, 2-site addr2, 3-org addr1, 4-org addr2
   	string50  Prepped_addr1;
   	string39  Prepped_addr2;
   	string10 	clean_prim_range;
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
   	string4 	clean_lot;
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
   	string8 	date_first_seen  	:= '0';
   	string8 	date_last_seen 		:='0';
   	string1 	record_type;
   	string2 	src;
   	unsigned6 Date_vendor_first_reported;
   	unsigned6 Date_vendor_last_reported;
   	unsigned8	source_rec_id;
   	unsigned8	lnpid;
   	AID.Common.xAID		RawAID;
		AID.Common.xAID		ACEAID;
   	unsigned6 bdid;
   	unsigned1 bdid_score := 0; 
   	BIPV2.IDlayouts.l_xlink_ids;
  end;
	
	export opi_in	:= record
		string10	npi;
		string20	opi_in;
		string20	opi;
		string2		opi_state;
		string2		opi_type_code;
		test_flag;
	end;
	
	export opi_base	:= record
		opi_in;
	end;
	
	export opi_facility_in	:= record
		string10	npi;
		string20	opi_in;
		string20	opi;
		string2		opi_state;
		string2		opi_type_code;
		test_flag;
	end;
	
	export opi_facility_base	:= record
		opi_facility_in;
	end;
	
	export abms_cert_lu_in	:= record
		string100	cert_desc;
		string10	cert_code;
		string60	board_name;
		string1		cert_type;
		string4		cert_id;
		string10	taxonomy;
	end;
	
	export abms_cert_lu_base	:= record
		abms_cert_lu_in;
	end;
	
	export abms_cooked_in	:= record
		unsigned8		biog_nbr;
		unsigned8		certificate_id;
		string1			board_certified;
		string1			cert_type_ind;
		string1			occurence_type;
		string2			duration_type;
		string10		cert_date;
		string10		exp_date;
		string10		rev_date;
		unsigned8		input_st;
		test_flag;
	end;
	
	export abms_cooked_base	:= record
		abms_cooked_in;
		string8 	date_first_seen  	:= '0';
   	string8 	date_last_seen 		:='0';
   	string1 	record_type;
   	string2 	src;
   	unsigned6 Date_vendor_first_reported;
   	unsigned6 Date_vendor_last_reported;
		string8		clean_cert_date;
		string8		clean_exp_date;
		string8		clean_rev_date;
	end;
	
end;