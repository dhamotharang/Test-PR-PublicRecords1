IMPORT Address, BIPV2, AID;

export layouts:= Module
	export Collapse_input := record
		string38        group_key1;
		string38        group_key2;
	end;

	export Split_input := record
		string38        group_key1;
		string38        group_key2;
	end;

	export Drop_input := record
		string38        group_key;
	end;

	export Facility_input := record
		string38        group_key;
		string10        dept_group_key;
		string100       prac_company_name;
		string20        addr_key;
		string50        addr_primary_address;
		string50        addr_secondary_address;
		string28        addr_city;
		string2         addr_state;
		string5         addr_zip;
		string4         addr_zip4;
		string5         addr_fipscode;
		string8         addr_secondary_range;
		string1         pv_addr_ind;
		string10        phone1;
		string10        fax1;
		string10        last_verified_date;
		string9         dea_num;
		string10        dea_num_exp;
		string1         dea_bus_act_ind;
		string25        lic_num_in;
		string2         lic_state;
		string25        lic_num;
		string10        lic_type;
		string1         lic_status;
		string10        lic_begin_date;
		string10        lic_end_date;
		string1         lic_src_ind;
		string10        npi_num;
		string10        taxonomy;
		string80        type1;
		string100       classification;
		string80        specialization;
		string10        medicare_fac_num;
		string1         oig_flag;
		string10        sanc1_date;
		string10        sanc1_code;
		string10        medicare_fac_num1:='';
		string2 				clia_status_code:='';
		string10 				clia_num:='';
		string10 				clia_end_date:='';
		string1 				clia_cert_type_code:='';
		string10				clia_cert_eff_date:='';
		string7 				ncpdp_id:='';
		string10 				tin1:='';
	end;

	export Individual_input := record
		string38        group_key;
		string50				orig_fullname;
		string15        prefix_name;
		string50        first_name;
		string50        middle_name;
		string50        last_name;
		string15        suffix_name;
		string15        suffix_other;
		string1         oig_flag;
		string1         opm_flag;	
		string1         state_restrict_flag;
		string2					provider_status;	// see note below for details
		string4					birth_year;
		string8					date_of_death; 
		string1					gender;	
		string6					upin;
	end;
	// Provider Status 
	//		D  = Provider confirmed deceased (only used when SSN is populated on input)
	//		U  = Provider reported deceased strong (99% accuracy)
	//		U1 = Provider reported deceased
	//		R1 = Provider reported retired (98% accuracy)
	//		R2 = Provider reported retired (95% accuracy)
	//		R4 = Provider reported retired (85% accuracy)
	//		N  = Provider not found deceased or retired: Active default
	
	export Associate_input	:= record
		string38		group_key;
		string50		orig_fullname; 
		string11		prac_addr_confidence_score;
		string11		bill_addr_confidence_score;
		string20		addr_key;
		string50		address;
		string50		addr_city;
		string2			addr_state;
		string10		addr_zip;
		string10		addr_phone;
		string50		sloc_bname; // service location best name
		string10		sloc_phone;	// service location phone
		string38		sloc_group_key;	// service location group key
		string38		billing_group_key;
		string50		legal_business_name;
		string50		doing_business_as;
		string50		bill_npi;
		string50		bill_tin;
		string10		cam_latest;	// claims addr master latest date
		string10		cam_earliest;	// claims addr master earliest date
		unsigned5		cbm1;	// claims by month1
		unsigned5		cbm3;	// claims by month3
		unsigned5		cbm6;	// claims by month6
		unsigned5		cbm12;	// claims by month12
		unsigned5		cbm18;	// claims by month18
		string1			pgk_works_for;	// explanation of relationship between facility (fgk) and provider (pgk) 'Y' = the provider works for the facility
		string1			pgk_is_affiliated_to;	// explanation of the relationship between facility (fgk) and provider (pgk) 'Y' = the provider is affiliated to the facility
		// string10		addr_lat;
		// string11		addr_long;
		// string10		Medicare_fac_num;
		// unsigned5		total_bed;
	end;
		
	export Address_input := record
		string38        group_key;
		string20        addr_key;
		string50        addr_primary_address;
		string50        addr_secondary_address;
		string20				addr_secondary_range;
		string28        addr_city;
		string2         addr_state;
		string5         addr_zip;
		string4         addr_zip4;
		string5         addr_fipscode;
		string1         prac_addr_ind;
		string1         bill_addr_ind;
		string10        phone1;
		string1					prac1_phone_ind;
		string1					bill1_phone_ind;
		string10				phone1_last_contact_date;
		string10        phone2;
		string1					prac2_phone_ind;
		string1					bill2_phone_ind;
		string10				phone2_last_contact_date;
		string10				phone3;
		string1					prac3_phone_ind;
		string1					bill3_phone_ind;
		string10				phone3_last_contact_date;
		string10				fax1;
		string1					prac1_fax_ind;
		string1					bill1_fax_ind;
		string10				fax2;
		string1					prac2_fax_ind;
		string1					bill2_fax_ind;
		string10				fax3;
		string1					prac3_fax_ind;
		string1					bill3_fax_ind;
		string100				prac_company_name;
		string10        last_verified_date;
		integer					addr_conf_score;
		string2         addr_rectype;
		string1         primary_location;
		// string10				addr_lat;
		// string11				addr_long;
	end;
	
	export DEA_input := record
		string38        group_key;
		string9         dea_num;
		string10         dea_num_exp;
		string1         dea_bus_act_ind;
		string1					dea_bus_act_ind_sub;
		string15        dea_drug_schedule;	// see notes below
		string10				dea_num_deact_date;
		string20				addr_key;
		string50				addr_primary_address;
		string50				addr_secondary_address;
		string28				addr_city;
		string2         addr_state;
		string5         addr_zip;
		string4         addr_zip4;
		string5         addr_fipscode;
	end;
	// DEA Drug Schedule
	//	Position         2:  "1" = Schedule 1 Controlled Substances
	//	Position         4:  "2" = Schedule 2 Narcotic Controlled Substances
	//	Position   5 and 6: "2N" = Schedule 2N Non-Narcotic Controlled Substances
	//	Position         8:  "3" = Schedule 3 Narcotic Controlled Substances
	//	Position	9 and 10: "3N" = Schedule 3N Non-Narcotic Controlled Substances
	//	Position        12:  "4" = Schedule 4 Controlled Substances
	//	Position        14:  "5" = Schedule 5 Controlled Substances
	//	Position 15 and 16: "L1" = List 1 Chemicals
	
	export License_input := record
		string38        group_key;
		string50				orig_fullname;
		string15        prefix_name;
		string50        first_name;
		string50        middle_name;
		string50        last_name;
		string15        suffix_name;
		string15        suffix_other;
		string25        lic_num_in;
		string2         lic_state;	
		string25        lic_num;
		string10				lic_type;
		string1					lic_status;	// A = Active; I = Inactive; D = Deceased, R = Retired
		string10				lic_begin_date;	//CCYYMMDD
		string10				lic_end_date;		//CCYYMMDD
		string20				addr_key;
		string50				addr_primary_address;
		string50				addr_secondary_address;
		string28				addr_city;
		string2					addr_state;
		string5					addr_zip;
		string4					addr_zip4;
		string2					addr_rectype;
	end;
	
	export NPI_input := record
		string38        group_key;
		string10				npi_num;
		string10				taxonomy;
		string80				type1;
		string100				classification;
		string80				specialization;
		string1					taxonomy_primary_ind;
		string50        last_name;
		string50        first_name;
		string50        middle_name;
		string50        other_last_name;
		string50        other_first_name;
		string50        other_middle_name;
		string1					other_name_type; // 1 = Former Name, 2 = Professional Name, 3 = DBA, 4 = Former Legal Name, 5 = Other Name
		string100				company_name;
		string100				other_company_name;
		string1					other_company_name_type; // 1 = Former Name, 2 = Professional Name, 3 = DBA, 4 = Former Legal Name, 5 = Other Name
		string100				parent_organization_name;
		string20				addr_key;
		string50				addr_primary_address;
		string50				addr_secondary_address;
		string28				addr_city;
		string2					addr_state;
		string5					addr_zip;
		string4					addr_zip4;
		string8					addr_secondary_range;
		string5					addr_fipscode;
		string10				phone1;
		string1					npi_type;	// 1 = Type 1 (Individual), 2 = Type 2 (Non Individuals)
		string1					npi_sole_proprietor;	// Y/N/X(unanswered) - only populated when npi_type is 1
		string10				npi_deact_date;
		string10				npi_enum_date;
	end;
	
	export Sanction_input	:= RECORD
		string38				group_key;
		string10				sanc1_date;
		string10				sanc1_code;
		string2					sanc1_state;
		string25				sanc1_lic_num;
		string10				sanc1_prof_type;
		string10				sanc1_rein_date;
		string1 				Enc_derived_rein_flag;
		string50				sanc1_desc;
	end;
	
	export Specialty_input	:= RECORD
		string38				group_key;
		string3					spec_code;
		string40				spec_desc;
	end;
		
	export MedSchool_input := RECORD
		string38				group_key;
		string100				medschool;
		string4					medschool_year;
	end;
	
	export Taxonomy_input	:= RECORD
		string38				group_key;
		string10				taxonomy;
		string80				type1;
		string100				classification;
		string80				specialization;
	end;
	
	export Sanc_Codes_input	:= RECORD
		string10				sanc_code;
		string100				sanc_desc;
	end;
	
	export Sanc_Prov_Type_input		:= RECORD
		string5					prov_type_code;
		string50				prov_type_desc;
	end;
	
	export Tax_Codes_input		:= RECORD
		string10				taxonomy;
		string50				type1;
		string50				classification;
		string50				specialization;
		string500				definition;
		string10				effect_date;
		string10				deact_date;
		string10				last_mod_date;
		string200				notes;
	end;
	
	export DEA_BACodes_input	:= RECORD
		string1					dea_bus_act_ind;
		string1					dea_bus_act_ind_sub;
		string50				desc;
	end;
	
	export Prov_SSN_input	:= RECORD
		string38				group_key;
		string10				ssn;
	end;
	
	export Prov_Birthdate_input	:= RECORD
		string38		group_key;
		string10		date_of_birth;
	end;
		
	export src_and_date	:= RECORD
			UNSIGNED6 	pid;
			STRING2 		src;		
			UNSIGNED4 	dt_vendor_first_reported;
			UNSIGNED4 	dt_vendor_last_reported;
			UNSIGNED4		dt_first_seen	:= 0;
			UNSIGNED4		dt_last_seen	:= 0;
			STRING1   	record_type;
			UNSIGNED8	 	source_rid;
			UNSIGNED8	 	lnpid;
	end;
	
	export clean_address := RECORD
			address.Layout_Clean182.prim_range;
		  address.Layout_Clean182.predir;
		  address.Layout_Clean182.prim_name;
		  address.Layout_Clean182.addr_suffix;
		  address.Layout_Clean182.postdir;
		  address.Layout_Clean182.unit_desig;
		  address.Layout_Clean182.sec_range;
		  address.Layout_Clean182.p_city_name;
		  address.Layout_Clean182.v_city_name;
		  address.Layout_Clean182.st;
		  address.Layout_Clean182.zip;
		  address.Layout_Clean182.zip4;
		  address.Layout_Clean182.cart;
		  address.Layout_Clean182.cr_sort_sz;
		  address.Layout_Clean182.lot;
		  address.Layout_Clean182.lot_order;
		  address.Layout_Clean182.dbpc;
		  address.Layout_Clean182.chk_digit;
		  address.Layout_Clean182.rec_type;
		  string2		fips_st:='';
		  string3		fips_county:='';
		  address.Layout_Clean182.geo_lat;
		  address.Layout_Clean182.geo_long;
		  address.Layout_Clean182.msa;
		  address.Layout_Clean182.geo_blk;
		  address.Layout_Clean182.geo_match;
		  address.Layout_Clean182.err_stat;
			AID.Common.xAID		RawAID;		
			AID.Common.xAID   ACEAID;
	end;
	
	export clean_name	:= RECORD
			address.Layout_Clean_Name.title;
		  address.Layout_Clean_Name.fname;
		  address.Layout_Clean_Name.mname;
		  address.Layout_Clean_Name.lname;
		  address.Layout_Clean_Name.name_suffix;
			string1 NameType:='';
			UNSIGNED8	nid;
	end;
	
	export Address_base	:= RECORD
			address_input - [
											addr_primary_address
											,addr_secondary_address
											,addr_secondary_range
											,addr_city
											,addr_state
											,addr_zip
											,addr_zip4
											,addr_fipscode
											];
			src_and_date - lnpid;
			UNSIGNED6 bdid;
			UNSIGNED1 bdid_score := 0;
			STRING100	clean_company_name;
			string1 normed_addr_rec_type:=''; //P=primary, S=secondary
			string50 Prepped_addr1;
			string39 Prepped_addr2;
			clean_address;
			unsigned4	 clean_last_verify_date;
			unsigned4	 clean_phone_last_contact_date;
			string10 clean_Phone;
			STRING10 clean_fax;
			BIPV2.IDlayouts.l_xlink_ids;
	END;
	
	export Facility_Base	:= RECORD
			facility_input - [
											addr_primary_address
											,addr_secondary_address
											,addr_secondary_range
											,addr_city
											,addr_state
											,addr_zip
											,addr_zip4
											,addr_fipscode
											];
			src_and_date;
			UNSIGNED6 bdid;
			UNSIGNED1 bdid_score := 0;	
			UNSIGNED4	clean_last_verify_date;
			UNSIGNED4 clean_lic_begin_date;
			UNSIGNED4 clean_lic_end_date;
			UNSIGNED4 clean_sanc1_date;
			UNSIGNEd4	clean_dea_num_exp;
			STRING100	clean_company_name;
			UNSIGNED4 clean_clia_end_date:=0;
			UNSIGNED4	clean_clia_cert_eff_date:=0;
			string1 normed_addr_rec_type:=''; //P=primary, S=secondary
			string50 Prepped_addr1;
			string39 Prepped_addr2;
			clean_address;
			STRING10 clean_Phone;
			STRING10 clean_fax;
			BIPV2.IDlayouts.l_xlink_ids;
	END;
	
	export associate_base	:= RECORD
			associate_input - [
											address
											,addr_city
											,addr_state
											,addr_zip
											,orig_fullname
											,sloc_bname
											,legal_business_name
											,doing_business_as
											];
			typeof(facility_input.type1) sloc_type;
			typeof(facility_input.type1) billing_type;
			src_and_date;
			UNSIGNED6 did;
			UNSIGNED1	did_score :=0;
			INTEGER2	xadl2_weight 				:= 0;
			UNSIGNED2	xadl2_score	 				:= 0;
			INTEGER1	xadl2_distance			:= 0;
			UNSIGNED4	xadl2_keys_used			:= 0;
			STRING		xadl2_keys_desc			:= '';
			STRING60	xadl2_matches				:= '';
			STRING		xadl2_matches_desc	:= '';			
			UNSIGNED6 bdid;
			UNSIGNED1 bdid_score := 0;	
			STRING100	prepped_name;
			string1 normed_name_rec_type := ''; //associate file has up to four name fields, 1->orig_fullname, 2->sloc_bname, 3->legal_business_name, 4->doing_business_as
			STRING100	clean_company_name;
			clean_name;
			string50 Prepped_addr1;
			string39 Prepped_addr2;
			clean_address;
			UNSIGNED4	clean_cam_latest;
			UNSIGNED4 clean_cam_earliest;
			STRING10 clean_Phone;
			STRING10 clean_sloc_phone;
			string8		clean_dob;
			UNSIGNED4	best_dob;
			string9		clean_ssn;
			string9		best_ssn;
			BIPV2.IDlayouts.l_xlink_ids;
		end;
		
	export license_base	:= RECORD
			license_input - [
											addr_primary_address
											,addr_secondary_address
											,addr_city
											,addr_state
											,addr_zip
											,addr_zip4
											];
			src_and_date;
			UNSIGNED6 did;
			UNSIGNED2 did_score		:= 0;
			UNSIGNED6	bdid;
			UNSIGNED1	bdid_score	:= 0;
			clean_name;
			string1 normed_addr_rec_type:=''; //P=primary, S=secondary
			string50 Prepped_addr1;
			string39 Prepped_addr2;
			clean_address;
			string8	 clean_lic_begin_date;
			string8	 clean_lic_end_date;
			string8	 clean_dob;
			unsigned4	best_dob;
			string9	 clean_ssn;
			string9	 best_ssn;
			BIPV2.IDlayouts.l_xlink_ids;
	END;
	
	export dea_base	:= RECORD
			dea_input - [
									addr_primary_address
									,addr_secondary_address
									,addr_city
									,addr_state
									,addr_zip
									,addr_zip4
									,addr_fipscode
									];
			src_and_date;
			string1 normed_addr_rec_type:=''; //P=primary, S=secondary
			string50 Prepped_addr1;
			string39 Prepped_addr2;
			clean_address;
			string8	 clean_dea_num_exp;
			string8	 clean_dea_num_deact_date;
			BIPV2.IDlayouts.l_xlink_ids;
	END;
	
	EXPORT taxonomy_base	:= RECORD
			taxonomy_input;
			npi_input.taxonomy_primary_ind;
			src_and_date-pid;
	end;	
	
	export npi_base	:= RECORD
			npi_input - [
									addr_primary_address
									,addr_secondary_address
									,addr_secondary_range
									,addr_city
									,addr_state
									,addr_zip
									,addr_zip4
									,addr_fipscode
									];
			src_and_date;
			UNSIGNED6 did	:= 0;
			UNSIGNED2 did_score		:= 0;
			UNSIGNED6 bdid;
			UNSIGNED1 bdid_score := 0;			
			clean_name;
			string1 normed_addr_rec_type:=''; //P=primary, S=secondary
			string50 Prepped_addr1;
			string39 Prepped_addr2;
			clean_address;
			string8	 clean_phone;
			string8	 clean_npi_deact_date;
			string8	 clean_npi_enum_date;
			string8	 clean_dob;
			unsigned4	best_dob;
			string9	 clean_ssn;
			string9		best_ssn;
			BIPV2.IDlayouts.l_xlink_ids;
	END;
	
	export medschool_base	:= RECORD
		medschool_input;
		src_and_date;
	end;
	
	export tax_codes_base	:= RECORD
			tax_codes_input;
			src_and_date-[pid,lnpid];
			string8			clean_effect_date;
			string8			clean_deact_date;
			string8			clean_last_mod_date;
	end;
	
	EXPORT prov_ssn_base	:= RECORD
			prov_ssn_input;
			string9 clean_ssn;
			src_and_date;
	end;	
	
	EXPORT specialty_base	:= RECORD
			specialty_input;
			src_and_date;
	end;	
	EXPORT sanc_prov_type_base	:= RECORD
			sanc_prov_type_input;
			src_and_date-[pid,lnpid];
	end;	
	
	EXPORT sanc_codes_base	:= RECORD
			sanc_codes_input;
			src_and_date-[pid,lnpid];
	end;	
	
	EXPORT DEA_BAcodes_base	:= RECORD
			DEA_BAcodes_input;
			src_and_date-[pid,lnpid];
	end;	
	
	EXPORT prov_birthdate_base	:= RECORD
			prov_birthdate_input;
			src_and_date;
			string8			clean_date_of_birth;
	end;	
	
	EXPORT sanction_base	:= RECORD
			sanction_input - [Enc_derived_rein_flag, sanc1_desc];
			src_and_date;
			string8			clean_sanc1_date;
			string8			clean_sanc1_rein_date;
			string8			LN_derived_rein_date;
			boolean			LN_derived_rein_flag	:= false;		
			string5			Level	:= '';	
			string8			Enc_derived_rein_date;
			string1			Enc_derived_rein_flag;
			string50		sanc1_desc;
	end;	
	
	EXPORT gk_to_provID_base	:= RECORD
			STRING38	group_key;
			UNSIGNED6	pid;
	end;

	export Collapse_Base := record
		string38        group_key1;
		string38        group_key2;
	end;

	export Split_Base := record
		string38        group_key1;
		string38        group_key2;
	end;

	export Drop_Base := record
		string38        group_key;
	end;

	export individual_base	:= RECORD
			individual_input;
			src_and_date;
			UNSIGNED6 did	:= 0;
			UNSIGNED2 did_score		:= 0;
			INTEGER2	xadl2_weight 				:= 0;
			UNSIGNED2	xadl2_score	 				:= 0;
			INTEGER1	xadl2_distance			:= 0;
			UNSIGNED4	xadl2_keys_used			:= 0;
			STRING		xadl2_keys_desc			:= '';
			STRING60	xadl2_matches				:= '';
			STRING		xadl2_matches_desc	:= '';			
			UNSIGNED6 bdid :=0;
			UNSIGNED1 bdid_score := 0;	
			clean_name;
			STRING100	clean_company_name;

			Address_base.normed_addr_rec_type;
			clean_address;

			Address_input.addr_key;
			Address_input.primary_location;
			Address_input.prac_addr_ind;
			Address_input.bill_addr_ind;
			Address_input.addr_conf_score;
			Address_input.addr_rectype;
			Address_base.clean_last_verify_date;
			Address_input.phone1;
			Address_input.prac1_phone_ind;
			Address_input.bill1_phone_ind;
			Address_input.fax1;
			Address_input.prac1_fax_ind;
			Address_input.bill1_fax_ind;

			string8		clean_dob;
			UNSIGNED4	best_dob;
			string9		clean_ssn;
			string9		best_ssn;

			License_input.lic_state	;
			License_input.lic_num_in;
			License_input.lic_num;
			License_input.lic_type;
			License_input.lic_status;
			License_input.lic_begin_date;
			License_input.lic_end_date;

			NPI_input.npi_num;
			NPI_input.taxonomy;
			NPI_input.type1;
			NPI_input.classification;
			NPI_input.taxonomy_primary_ind;
			NPI_input.npi_enum_date;
			NPI_input.npi_deact_date;

			DEA_input.dea_num;
			DEA_input.dea_num_exp;
			DEA_input.dea_bus_act_ind;

			Sanction_input.sanc1_date;
			Sanction_input.sanc1_code;
			Sanction_input.sanc1_state;
			Sanction_input.sanc1_lic_num;
			Sanction_input.sanc1_rein_date;

			BIPV2.IDlayouts.l_xlink_ids;
	END;

	EXPORT autokey_common	:= RECORD
			individual_base - 
				[xadl2_weight, xadl2_score, xadl2_distance, xadl2_keys_used, xadl2_keys_desc, xadl2_matches, xadl2_matches_desc];
			facility_input.dept_group_key;
			facility_input.prac_company_name;
			facility_input.pv_addr_ind;
			facility_input.specialization;
			facility_input.medicare_fac_num;
			facility_input.lic_src_ind;
			facility_base.clean_phone;
			facility_base.clean_fax;
			unsigned1 zero:=0;
			string1 blank:='';
		end;

End;