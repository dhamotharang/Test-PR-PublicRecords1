EXPORT layouts_commonized := Module
	EXPORT layout_acctno := RECORD
			STRING acctno := '';
			unsigned6 InternalID := 0;
			unsigned6 LNPID := 0;
			unsigned6 LNFID := 0;
	END;
	EXPORT layout_matchStat := RECORD
		integer matchType := 0;
		integer fuzzyInfo := 0;
		integer score := 0;
		integer numPossibleFatFingers := 0;
		integer	extendedInfo := 0;
	END;
	EXPORT layout_std_common := RECORD
			unsigned6 did := 0;
			unsigned6 bdid := 0;
			UNSIGNED6 UltID := 0;
			UNSIGNED6 OrgID := 0;
			UNSIGNED6 SeleID := 0;
			UNSIGNED6 ProxID := 0;
			UNSIGNED6 PowID := 0;
			UNSIGNED6 EmpID := 0;
			UNSIGNED6 DotID := 0;
			string38  vendor_id := '';
			string38  surrogate_key := '';
			string38  group_key := '';		
			unsigned8 sequence_num := 0;
			string8   project_num := '';
			string9  	filesource := '';
			string9   filecode := '';
			unsigned8 filecode_enum := 0;
			string8 	lic_filedate := '';
			integer		source_confidence_score := 0;
			string10	audit_date := '';
			string20  state_mask := '';
			string3   dept_code := '';
			string50  provider_id := '';
			unsigned8 provider_id_st := Healthcare_Shared.Constants.stat_Missing;		
			unsigned8 call_return_id := 0;
			string1   primary_location := '';
			unsigned8 primary_location_st := Healthcare_Shared.Constants.stat_Missing;
			string1   control := '';
			unsigned2 control_st := Healthcare_Shared.Constants.stat_Missing;
			string1   ownership := '';
			unsigned2 ownership_st := Healthcare_Shared.Constants.stat_Missing;
			unsigned2 approval := 0;
			unsigned2 approval_st := Healthcare_Shared.Constants.stat_Missing;
			string8   DOSBeginDate := '';
			string8   DOSEndDate := '';
			string		record_type := '';
			string 		derived_input_type := '';
			string 		DBA_type_code := '';
			unsigned2 DBA_type_code_st := 0;
			string 		kill_code := '';
			string 		last_update_date := '';
			string 		other_name_type_code := '';
			unsigned2 other_name_type_code_st := 0;
			string 		sole_proprietor := '';
			unsigned2	sole_proprietor_st := 0;
			string 		authorized_title := '';
			unsigned2	authorized_title_st := 0;
			string 		claim_id := '';
			string 		claim_version_id := '';
			string1 	normed_addr_rec_type := '';
	END;
	EXPORT layout_std_name := RECORD
			string50  name_in := '';
			string20  name_key := '';
			string50  full_name := '';
			string15  pre_name := '';
			string50  first_name := '';
			string50  middle_name := '';
			string50  last_name := '';
			string15  maturity_suffix := '';
			string15  other_suffix := '';
			string1   gender := '';
			string50  preferred_name := '';
			unsigned3 name_confidence := 0;
			unsigned8 name_st := Healthcare_Shared.Constants.stat_Missing;
	END;
	EXPORT layout_all_name := RECORD
			layout_std_name;
	END;
	EXPORT layout_std_company := RECORD
			string20  company_key := '';
			string100 company_name := '';
			string3   company_apcfirm := '';
			unsigned8 company_st := Healthcare_Shared.Constants.stat_Missing;
	END;
	EXPORT layout_all_company := RECORD
			layout_std_company;
	END;
	EXPORT layout_std_birthdate := RECORD
			string10  birthdate := '';
			unsigned8 birthdate_st := Healthcare_Shared.Constants.stat_Missing;
	END;
	EXPORT layout_all_birthdate := RECORD
			layout_std_birthdate;
	END;
	EXPORT layout_std_ssn  := RECORD
			string9   ssn := '';
			string9   hashed_ssn := '';
			unsigned8 ssn_st := Healthcare_Shared.Constants.stat_Missing;
	END;
	EXPORT layout_all_ssn := RECORD
			layout_std_ssn;
	END;
	EXPORT layout_std_phone := RECORD
			string10  phone := '';
			unsigned8 phone_st := Healthcare_Shared.Constants.stat_Missing;
	END;
	EXPORT layout_all_phone := RECORD
			layout_std_phone;
	END;
	EXPORT layout_std_fax := RECORD
			string10  fax := '';
			unsigned8 fax_st := Healthcare_Shared.Constants.stat_Missing;
	END;
	EXPORT layout_all_fax := RECORD
			layout_std_fax;
	END;
	EXPORT layout_std_email := RECORD
			string48  email_addr := '';
			unsigned8 email_addr_st := Healthcare_Shared.Constants.stat_Missing;
	END;
	EXPORT layout_all_email := RECORD
			layout_std_email;
	END;
	EXPORT layout_std_website := RECORD
			string50  web_site := '';
			unsigned8 web_site_st := Healthcare_Shared.Constants.stat_Missing;
	END;
	EXPORT layout_all_website := RECORD
			layout_std_website;
	END;
	EXPORT layout_std_upin := RECORD
			string6   upin := '';
			unsigned8 upin_st := Healthcare_Shared.Constants.stat_Missing;
	END;
	EXPORT layout_all_upin := RECORD
			layout_std_upin;
	END;
	EXPORT layout_std_tin := RECORD
			string9   tin := '';
			unsigned8 tin_st := Healthcare_Shared.Constants.stat_Missing;
	END;
	EXPORT layout_all_tin := RECORD
			layout_std_tin;
	END;
	EXPORT layout_std_dea := RECORD
			string9   dea_num := '';
			string10  dea_num_exp := '';
			string16  dea_num_sch := '';
			string1   dea_num_bus_act_ind := '';
			string10  dea_num_deact_date := '';
			unsigned8 dea_num_st := Healthcare_Shared.Constants.stat_Missing;
			string8 	dea_num_status := '';
			string1 	dea_num_bus_act_sub_ind := '';
	END;
	EXPORT layout_all_dea := RECORD
			layout_std_dea;
	END;
	EXPORT layout_std_specialty := RECORD
			string3   specialty := '';
			string50  specialtyDesc := '';
			unsigned8 specialty_st := Healthcare_Shared.Constants.stat_Missing;
	END;
	EXPORT layout_all_specialty := RECORD
			layout_std_specialty;
	END;
	EXPORT layout_std_license := RECORD
			string2   lic_state := '';
			string20 lic_num_in := '';
			string20  lic_num := '';
			string10  lic_type := '';
			string1   lic_status := '';
			string10  lic_begin_date := '';
			string10  lic_end_date := '';
			string16	lic_drug_schedule := '';
			unsigned8 lic_st := Healthcare_Shared.Constants.stat_Missing;
			integer 	msLicense_score := 0;
	END;
	EXPORT layout_all_license := RECORD
			layout_std_license;
	END;
	EXPORT layout_std_address := RECORD
			string20  addr_key := '';
			string50  primary_address := '';
			string50  secondary_address := '';
			string28  city := '';
			string2   state := '';
			string5   zip := '';
			string4   zip4 := '';
			string2   rectype := '';
			string10  primary_range := '';
			string2   pre_directional := '';
			string28  primary_name := '';
			string4   suffix := '';
			string2   post_directional := '';
			string10  unit_designator := '';
			string8   secondary_range := '';
			string9   pobox := '';
			string9   rrnumber := '';
			string10  npsr := '';
			string6   ace_stat_code := '';
			string6   error_code := '';
			string5   fipscode := '';
			string1   rdi := '';
			string10	clean_geo_lat :='';
			string11	clean_geo_long :='';
			string2   clean_fips_st:='';
			string3   clean_fips_county:='';                   
			string4   clean_msa:='';                                         
			string7   clean_geo_blk:='';                                 
			string1   clean_geo_match:='';
			unsigned4 addr_st := Healthcare_Shared.Constants.stat_Missing;
	END;
	EXPORT layout_all_address := RECORD
			layout_std_address;
	END;
	EXPORT layout_std_profcode := RECORD
			String3		profcode := ''; 
			unsigned8	profcode_st := Healthcare_Shared.Constants.stat_Missing; 
	END;
	EXPORT layout_all_profcode := RECORD
			layout_std_profcode;
	END;
	EXPORT layout_std_aff_code := RECORD
			string5   aff_code_mg := '';
			unsigned8 aff_code_mg_st := Healthcare_Shared.Constants.stat_Missing;
			String80	aff_name_mg := ''; 
			unsigned8	aff_name_mg_st := Healthcare_Shared.Constants.stat_Missing;
	END;
	EXPORT layout_all_aff_code := RECORD
			layout_std_aff_code;
	END;
	EXPORT layout_std_profstat := RECORD
			String1		profstat := ''; 
			unsigned8	profstat_st := Healthcare_Shared.Constants.stat_Missing;
	END;
	EXPORT layout_all_profstat := RECORD
			layout_std_profstat;
	END;
	EXPORT layout_std_provstat := RECORD
			String1		provstat := ''; 
			unsigned8	provstat_st := Healthcare_Shared.Constants.stat_Missing;
	END;
	EXPORT layout_all_provstat := RECORD
			layout_std_provstat;
	END;
	EXPORT layout_std_sanction := RECORD
			string2   sanc_state := '';
			string10  sanc_date := '';
			string25  sanc_case := '';
			string50  sanc_source := '';
			string100 sanc_complaint := '';
			string10  sanc_rein_date := '';
			string5		sanc_type := '';
			INTEGER sanc_category := 0;
			string10 sanc_prof_type := '';
			string25 sanc_lic_num := '';
			unsigned8 sanc_st := Healthcare_Shared.Constants.stat_Missing;
	END;
	EXPORT layout_all_sanction := layout_std_sanction;	// doesn't have a raw.
	EXPORT layout_std_kil_code := RECORD
			string3   kil_code := '';
			unsigned8 kil_code_st := Healthcare_Shared.Constants.stat_Missing;
	END;
	EXPORT layout_all_kil_code := RECORD
			layout_std_kil_code;
	END;
	EXPORT layout_std_date_of_death := RECORD
			string10  date_of_death := '';
			unsigned8 date_of_death_st := Healthcare_Shared.Constants.stat_Missing;
	END;
	EXPORT layout_all_date_of_death := RECORD
			layout_std_date_of_death;
	END;
	EXPORT layout_std_death_flag := RECORD
			String1		death_flag := ''; 
			unsigned8	death_flag_st := Healthcare_Shared.Constants.stat_Missing;
	END;
	EXPORT layout_all_death_flag := RECORD
			layout_std_death_flag;
	END;
	EXPORT layout_std_medschool	:= RECORD
			string100 medschool := '';
			string4   medschool_year := '';
			unsigned8 medschool_st := Healthcare_Shared.Constants.stat_Missing;
	END;
	EXPORT layout_all_medschool := record
		layout_std_medschool;	// doesn't have a raw format
	end;
	EXPORT layout_std_npi := RECORD
			string10  npi_num := '';
			string1   npi_type := '';				
			string2   npi_drc := '';				
			string10  taxonomy_mprd := '';
			string10  last_update_date := '';
			string10  npi_deact_date := '';
			string10  npi_react_date := ''; // added 6.6?
			string10 	npi_enum_date := '';
			integer		Bel := 0;    // 1 => Facility found in basc_facility_mme_group_key.qa
			unsigned8 npi_st := Healthcare_Shared.Constants.stat_Missing;  // Enclarity has default st=3 (they add not configured value of 1)
	END;
	EXPORT layout_all_npi := RECORD
		layout_std_npi;
	END;
	EXPORT layout_std_group_affiliation := RECORD
			string10  group_affiliation := '';
			string10	Aff_GrpCode:='';
			string10	Aff_HospCode:='';
			string20	Aff_PracKey:='';
			string10	Aff_PracPhone:='';
	END;
	EXPORT layout_all_group_affiliation := layout_std_group_affiliation;	// no raw
	EXPORT layout_std_hospital_affiliation := RECORD
			string10  hosp_affiliation := '';
	END;
	EXPORT layout_all_hospital_affiliation := layout_std_hospital_affiliation;	// no raw
	EXPORT layout_std_abms := RECORD
			string2   abms_member_board_id := '';
			string8   abms_certificate_id := '';
			string1   abms_certificate_type := '';
			string1   abms_occurrence_type := '';
			string2   abms_duration_type := '';
			string10  abms_start_eff_date := '';
			string10  abms_end_eff_date := '';
			unsigned8 abms_st := Healthcare_Shared.Constants.stat_Missing;
	END;
	EXPORT layout_best_hospital := RECORD
			string100	hospital_name :='';
			string40	hospital_group_key :='';
			unsigned6	hospital_lnpid :=0;
			string10	hospital_Phone :='';
			boolean		worksfor := false;
	END;
	EXPORT layout_all_abms := layout_std_abms;	// no raw
	EXPORT layout_std_taxonomy := RECORD
			string10	taxonomy := '';
			unsigned8 taxonomy_st := Healthcare_Shared.Constants.stat_Missing;
			string1   taxonomy_primary_ind := '';
			unsigned2 TaxonomyMissing:=0; 
			unsigned2 TaxonomyBadFormat:=0 ; 
			unsigned2 taxonomyinvalid:= 0; 
	END;
	EXPORT layout_all_taxonomy := RECORD
			layout_std_taxonomy;
	END;
	EXPORT layout_std_male_female := RECORD
			string1   male_female := '';
			unsigned8 male_female_st := Healthcare_Shared.Constants.stat_Missing;
	END;
	EXPORT layout_all_male_female := RECORD
		layout_std_male_female;
	END;
	EXPORT layout_std_clia := RECORD
			string10  clia_num := '';
			string2   clia_status_code := '';
			string1   clia_cert_type_code := '';
			string10  clia_cert_eff_date := '';
			string10  clia_end_date := '';
			unsigned2 clia_data_st := Healthcare_Shared.Constants.stat_Missing;	
			STRING50  clia_lab_type_description:='';
			STRING2	 	clia_lab_term_code:='';
			string 		clia_TermCodeDesc :='';
	END;
	EXPORT layout_all_clia := RECORD
			layout_std_clia;
	END;
	EXPORT layout_std_dba := RECORD
			string20  dba_key := '';
			string100 dba_name := '';
			string3   dba_apcfirm1 := '';
			unsigned2 dba_st := Healthcare_Shared.Constants.stat_Missing;
	END;
	EXPORT layout_all_dba := RECORD
			layout_std_dba;
	END;
	EXPORT layout_std_provider_degree := RECORD
			string50  provider_degree := '';
	END;
	EXPORT layout_all_provider_degree := RECORD
			layout_std_provider_degree;
	END;
	EXPORT layout_std_facility_type := RECORD
			string10  facility_type := '';
			unsigned2 facility_type_st := Healthcare_Shared.Constants.stat_Missing;
	END;
	EXPORT layout_all_facility_type := RECORD
			layout_std_facility_type;
	END;
	EXPORT layout_std_medicare := RECORD
			string10  medicare_fac_num := '';
			unsigned2 medicare_fac_num_st := Healthcare_Shared.Constants.stat_Missing;
	END;
	EXPORT layout_all_medicare := RECORD
			layout_std_medicare;
	END;
	EXPORT layout_std_medicaid := RECORD
			string10  medicaid_fac_num := '';
			unsigned2 medicaid_fac_num_st := Healthcare_Shared.Constants.stat_Missing;
	END;
	EXPORT layout_all_medicaid := RECORD
			layout_std_medicaid;
	END;
	EXPORT layout_std_ncpdp := RECORD
			string7   ncpdp_id := '';
			unsigned2 ncpdp_id_st := Healthcare_Shared.Constants.stat_Missing;
	END;
	EXPORT layout_all_ncpdp := RECORD
		layout_std_ncpdp;
	END;
	EXPORT layout_all_claims := RECORD
	  string11  addr_usage := '';                    
    string10  latest_clm_date := '';  
    string10  earliest_clm_date := '';    
    string3   type_bill := '';
    string2   place_service := '';
		string10  bill_npi := '';
		string10  bill_tin := '';
		string10  rendering_npi := '';
		unsigned2 cbm1 := 0;
		unsigned2 cbm3 := 0;
		unsigned2 cbm6 := 0;
		unsigned2 cbm12 := 0;
		unsigned2 cbm18 := 0;
	END;
	Export std_record_struct := record
		layout_acctno;
		layout_std_common;
		layout_all_name;
		layout_all_provider_degree;
		layout_all_company prac_company1;
		layout_all_company prac_company2;
		layout_all_company prac_company3;
		layout_all_company bill_company1;
		layout_all_company bill_company2;
		layout_all_company bill_company3;
		layout_all_company dba;
		layout_all_company parent_org_LBN;
		layout_all_birthdate;
		layout_all_ssn;
		layout_all_phone prac_phone1;
		layout_all_phone prac_phone2;
		layout_all_phone prac_phone3;
		layout_all_fax prac_fax1;
		layout_all_fax prac_fax2;
		layout_all_fax prac_fax3;
		layout_all_phone bill_phone1;
		layout_all_phone bill_phone2;
		layout_all_phone bill_phone3;
		layout_all_fax bill_fax1;
		layout_all_fax bill_fax2;
		layout_all_fax bill_fax3;
		layout_all_email;
		layout_all_website;
		layout_all_upin;
		layout_all_tin tin1;
		layout_all_tin tin2;
		layout_all_tin tin3;
		layout_all_dea dea1;
		layout_all_dea dea2;
		layout_all_dea dea3;
		layout_all_dea dea4;
		layout_all_dea dea5;
		layout_all_dea dea6;
		layout_all_dea dea7;
		layout_all_dea dea8;
		layout_all_dea dea9;
		layout_all_dea dea10;
		layout_all_ncpdp;
		layout_all_specialty specialty1;
		layout_all_specialty specialty2;
		layout_all_specialty specialty3;
		layout_all_license lic1;
		layout_all_license lic2;
		layout_all_license lic3;
		layout_all_license lic4;
		layout_all_license lic5;
		layout_all_license lic6;
		layout_all_license lic7;
		layout_all_license lic8;
		layout_all_license lic9;
		layout_all_license lic10;
		layout_all_license lic11;
		layout_all_license lic12;
		layout_all_license lic13;
		layout_all_license lic14;
		layout_all_license lic15;
		layout_all_address prac1;
		layout_all_address prac2;
		layout_all_address prac3;
		layout_all_address bill1;
		layout_all_address bill2;
		layout_all_address bill3;
		layout_all_profcode profcode1;
		layout_all_profcode profcode2;
		layout_all_profcode profcode3;
		layout_all_aff_code;
		layout_all_profstat;
		layout_all_provstat;
		layout_all_sanction sanc1;
		layout_all_sanction sanc2;
		layout_all_sanction sanc3;
		layout_all_sanction sanc4;
		layout_all_sanction sanc5;
		layout_all_sanction sanc6;
		layout_all_sanction sanc7;
		layout_all_sanction sanc8;
		layout_all_sanction sanc9;
		layout_all_sanction sanc10;
		layout_all_kil_code;
		layout_all_date_of_death;
		layout_all_death_flag;
		layout_all_medschool medschool1;
		layout_all_medschool medschool2;
		layout_all_medschool medschool3;
		layout_all_npi;
		layout_all_name other_name; 
		layout_all_name authorized_name;
		layout_all_phone authorized_phone;
		layout_all_group_affiliation;
		layout_all_hospital_affiliation;
		layout_all_abms;
		layout_all_taxonomy;
		layout_all_taxonomy taxonomy2;
		layout_all_taxonomy taxonomy3;
		layout_all_taxonomy taxonomy4;
		layout_all_taxonomy taxonomy5;
		layout_all_taxonomy taxonomy6;
		layout_all_taxonomy taxonomy7;
		layout_all_taxonomy taxonomy8;
		layout_all_taxonomy taxonomy9;
		layout_all_taxonomy taxonomy10;
		layout_all_taxonomy taxonomy11;
		layout_all_taxonomy taxonomy12;
		layout_all_taxonomy taxonomy13;
		layout_all_taxonomy taxonomy14;
		layout_all_taxonomy taxonomy15;
		layout_all_taxonomy derived_taxonomy;
		layout_all_male_female;
		layout_all_clia;
		layout_all_dba;
		layout_all_facility_type;
		layout_all_medicare;
		layout_all_medicaid;
		layout_best_hospital;
		layout_all_claims;
	end;
End;