IMPORT address, AID, BIPV2;

//Version 20150424 has a sources field
// set readSourcesFromInFiles to true to process version 20150424
// to read the sources field in the in-files of 20150424
#declare (readSourcesFromInFiles)
#set (readSourcesFromInFiles, false)
// set WriteSourcesToBaseFiles to true to process ONLY version 20150424
// if you want to use it as history, set it to FALSE, 
// FALSE will write the base file WITHOUT the sources field
// sources field is not written to individual_base file, regardless
#declare (WriteSourcesToBaseFiles)
#set (WriteSourcesToBaseFiles, false)

EXPORT layouts := MODULE

	SHARED max_size := _Dataset().max_record_size;
	
	EXPORT individual_in := record
		STRING10		hms_piid;
		STRING20		first;
		STRING20		middle;
		STRING20		last;
		STRING3			suffix;
		STRING6			cred;
		STRING30		practitioner_type;
		STRING1			active;
		STRING1			vendible;
		STRING10		npi_num;
		STRING10		npi_enumeration_date;
		STRING10		npi_deactivation_date;
		STRING10		npi_reactivation_date;
		STRING10		npi_taxonomy_code;
		STRING6			upin;
		STRING1			medicare_participation_flag;
		STRING10		date_born;
		STRING10		date_died;
#if (%readSourcesFromInFiles%)   //Version 20150424 has a sources field
		STRING1500	sources;
#end
	END;

	EXPORT individual_addresses_in := record
		STRING10	  hms_piid;
		unsigned	  rank;
		STRING32    firm_name;
		STRING4     type;
		STRING30	  address1;
		STRING30	  address2;
		STRING20	  city;
		STRING2		  state;
		STRING5		  addr_zip;
		STRING4		  addr_zip4;
		REAL4       score;
		STRING9		  lid;
		STRING9		  agid;
		STRING2     address_std_code;
		REAL8       latitude;
		REAL8       longitude;
#if (%readSourcesFromInFiles%)   //Version 20150424 has a sources field
		STRING1500	sources;
#end		
	END;
		
	EXPORT clean_address := RECORD
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
		STRING2		fips_st:='';
		STRING3		fips_county:='';
		address.Layout_Clean182.geo_lat;
		address.Layout_Clean182.geo_long;
		address.Layout_Clean182.msa;
		address.Layout_Clean182.geo_blk;
		address.Layout_Clean182.geo_match;
		address.Layout_Clean182.err_stat;     
		AID.Common.xAID		RawAID;		
		AID.Common.xAID   ACEAID;         
	END;
	
	EXPORT clean_name	:= RECORD
		address.Layout_Clean_Name.fname;
		address.Layout_Clean_Name.mname;
		address.Layout_Clean_Name.lname;
		address.Layout_Clean_Name.name_suffix;
		STRING1 NameType:='';
		UNSIGNED8	nid;
	END;
	
	EXPORT individual_state_licenses_in := record
		STRING10	hms_piid;
		STRING2		state_license_state;
		STRING20	state_license_number;
		STRING3		state_license_type;
		STRING1		state_license_active;
		STRING10	state_license_expire;
		STRING2		state_license_qualifier;
		STRING2		state_license_sub_qualifier;
		STRING10	state_license_issued;
	END;

	EXPORT individual_dea_in := record
		STRING10	hms_piid;
		STRING9		dea_num;
		STRING1		dea_bac;
		STRING1		dea_sub_bac;
		STRING11	dea_schedule;
		STRING10	dea_expire;
		unsigned	dea_rank;
		unsigned	dea_active;
	END;

	EXPORT individual_state_csr_in := record
		STRING10	hms_piid;
		STRING10	csr_number;
		STRING2		csr_state;
		STRING10	csr_expire_date; 
		STRING10	csr_issue_date;
		STRING1		dsa_lvl_2;
		STRING2		dsa_lvl_2n;
		STRING1		dsa_lvl_3;
		STRING2		dsa_lvl_3n;
		STRING1		dsa_lvl_4;
		STRING1		dsa_lvl_5;
		STRING0		csr_raw1;
		STRING0		csr_raw2;
		STRING0		csr_raw3;
		STRING0		csr_raw4;
	END;

	EXPORT individual_sanctions_in := record
		STRING10	hms_piid;
		STRING32	sanction_id;
		STRING6		sanction_action_code;
		STRING78	sanction_action_description;
		STRING9   sanction_board_code;
		STRING74  sanction_board_description;
		STRING10	action_date;
		STRING10	sanction_period_start_date;
		STRING10	sanction_period_end_date;
		STRING3		month_duration;
		STRING8		fine_amount;
		STRING6		offense_code;
		STRING97	offense_description;
		STRING10	offense_date;                      
	END;

	EXPORT individual_gsa_sanctions_in := record
		STRING28	gsa_sanction_id;  // note, this is first in in-file; hms_piid is second
		STRING10	hms_piid;
		STRING27	gsa_first;
		STRING16	gsa_middle;
		STRING30	gsa_last;
		STRING3		gsa_suffix;
		STRING25	gsa_city;
		STRING16	gsa_state;
		STRING9		gsa_zip;
		STRING10	action_date;
		STRING10	date;
		STRING10	agency;
		STRING1		confidence;
	END;
	
	EXPORT state_license_types_in := record
		STRING3		stlic_type;
		STRING60	stlic_desc;
	END;
	
	EXPORT src_and_date	:= RECORD
		UNSIGNED6 	pid;
		STRING2 		src;		
		UNSIGNED4 	date_vendor_first_reported;
		UNSIGNED4 	date_vendor_last_reported;
		UNSIGNED4		date_first_seen	:= 0;
		UNSIGNED4		date_last_seen	:= 0;
		STRING1   	record_type;
		UNSIGNED8	 	source_rid;
		UNSIGNED8	 	lnpid;
	END;
	
	EXPORT individual_specialty_in := RECORD
		STRING10	hms_piid;
		STRING30	specialty_description;
		STRING2   specialty_rank;
	END;

	EXPORT individual_address_phones_in := RECORD
		STRING10		hms_piid;
		STRING10  	phone_lid;
		STRING10  	phone;
		STRING1   	phone_rank;
#if (%readSourcesFromInFiles%)   //Version 20150424 has a sources field
		STRING1500	phone_sources;
#end
	END;
	
	EXPORT individual_address_faxes_in := RECORD
		STRING10		hms_piid;
		STRING10		fax_lid;
		STRING10  	fax;
		STRING1   	fax_rank;
#if (%readSourcesFromInFiles%)   //Version 20150424 has a sources field
		STRING1500	fax_sources;
#end		
	END;

	EXPORT individual_education_in := RECORD
		STRING10	hms_piid;
		STRING6   hms_scid;
		STRING32  school_name;
		STRING4   grad_year;
	END;

	EXPORT individual_certifications_in := RECORD
		STRING10	hms_piid;
		STRING6   certification_code;
		STRING32  certification_description;
		STRING8   board_code;
		STRING32  board_description;
		STRING4   expiration_year;
		STRING4   issue_year;
		STRING4   renewal_year;
		STRING1   lifetime_flag;
		STRING1   certification_rank;
	END;
	
	EXPORT individual_covered_recipients_in := RECORD
		STRING10  hms_piid;
		STRING6   covered_recipient_id;
		STRING2   cov_rcp_raw_state_code;
		STRING63  cov_rcp_raw_full_name;	
		STRING20  first;	//raw_first_name;	
		STRING20  middle;	//raw_middle_name;	
		STRING20  last;	  //raw_last_name;
		STRING10  suffix;	//raw_suffix;
		STRING32  cov_rcp_raw_attribute1;
		STRING32  cov_rcp_raw_attribute2; 
		STRING32  cov_rcp_raw_attribute3;
		STRING32  cov_rcp_raw_attribute4;
	END;
	
	EXPORT individual_languages_in := RECORD
		STRING10	hms_piid;
		STRING7 	lang_code;
		STRING20	language;
		STRING1	  lang_rank;
	END;

  EXPORT piid_migration_in := RECORD
		STRING10	old_piid;
		STRING10	new_piid;
		STRING11	piid_action;
	END;

	//===================================================
	//  BASE FILES
	//===================================================
			
	EXPORT individual_addresses_base	:= RECORD
#if (%readSourcesFromInFiles%)   //Version 20150424 has a sources field
	#if (%WriteSourcesToBaseFiles%)
			individual_addresses_in -[address1, address2, city, state, addr_zip, addr_zip4];   //  write sources field to base file
	#else		
			individual_addresses_in - [address1, address2, city, state, addr_zip, addr_zip4, sources];   // do not  write sources field to base file
	#end		
#else
		individual_addresses_in - [address1, address2, city, state, addr_zip, addr_zip4];   // sources field was not read to begin with
#end	

		src_and_date;
		
		STRING100	clean_company_name;
		
		STRING50	prepped_addr1;
		STRING39	prepped_addr2;
		
		clean_address;
		
		UNSIGNED6 bdid;
		UNSIGNED1 bdid_score := 0;
		
		UNSIGNED6 did;
		UNSIGNED1	did_score :=0;

		BIPV2.IDlayouts.l_xlink_ids;
	END;
	
	EXPORT individual_base := record
		// Individuals
#if (%readSourcesFromInFiles%)   //Version 20150424 has a sources field 
                                 // source field is not written to file individual_base
		individual_in - [sources];
#else		
		individual_in;
#end
		src_and_date;
		
		clean_name;
			
		// Individual cleans
		STRING50 clean_npi_enumeration_date;
		STRING50 clean_npi_deactivation_date;
		STRING50 clean_npi_reactivation_date;
		STRING50 clean_date_born;
		STRING50 clean_date_died;
		STRING100	clean_company_name; // Needed for name cleaner

		// Individual addresses
		clean_address;

#if (%readSourcesFromInFiles%)   //Version 20150424 has a sources field
		individual_addresses_in - [hms_piid, rank, address1, address2, city, state, addr_zip, addr_zip4, type, score, sources];
#else
		individual_addresses_in - [hms_piid, rank, address1, address2, city, state, addr_zip, addr_zip4, type, score];
#end

		STRING50  prepped_addr1;
		STRING39  prepped_addr2;
		STRING4   addr_type;  //replaces type field of indiv_addr_in
		
		
		// Individual state licenses
		individual_state_licenses_in-[hms_piid];	
		STRING10	clean_state_license_expire;
		STRING10	clean_state_license_issued;
		
		// Individual DEA
		individual_dea_in - [hms_piid, dea_rank];
		STRING10	clean_dea_expire;
		
		// Individual State CSR
		individual_state_csr_in-[hms_piid];
		STRING10	clean_csr_expire_date;
		STRING10	clean_csr_issue_date;
		
		// Individual Sanctions
		individual_sanctions_in-[hms_piid];
		STRING10	clean_offense_date;
		STRING10	clean_action_date;
		STRING10	clean_sanction_period_start_date;
		STRING10	clean_sanction_period_end_date;   
		
		// Individual GSA Sanctions
		individual_gsa_sanctions_in-[hms_piid];
		STRING27	clean_gsa_first;
		STRING16	clean_gsa_middle;
		STRING30	clean_gsa_last;
		STRING3		clean_gsa_suffix;
		STRING25	clean_gsa_city;
		STRING16	clean_gsa_state;
		STRING9		clean_gsa_zip;
		STRING10	clean_gsa_action_date;
		STRING10	clean_gsa_date;
		
		// Individual Address Faxes
#if (%readSourcesFromInFiles%)   //Version 20150424 has a sources field
		individual_address_faxes_in - [hms_piid, fax_rank, fax_sources, fax_lid];
#else		
		individual_address_faxes_in - [hms_piid, fax_rank, fax_lid];
#end

		// Individual Address Phones
#if (%readSourcesFromInFiles%)   //Version 20150424 has a sources field
		individual_address_phones_in - [hms_piid, phone_rank, phone_sources, phone_lid];
#else
		individual_address_phones_in - [hms_piid, phone_rank, phone_lid];
#end
		
		// Individual Certifications
		individual_certifications_in - [hms_piid, certification_rank];

		// Individual Covered Recipients
		individual_covered_recipients_in - [hms_piid];
		
		// Invividual Education
		individual_education_in - [hms_piid];
		
		// Individual Languages
		individual_languages_in - [hms_piid, lang_rank];
		
		// Individual Specialty
		individual_specialty_in - [hms_piid, specialty_rank];
		
		//STRING100	prac_company_name;
		STRING10  clean_Phone;
		UNSIGNED6 bdid;
		UNSIGNED1 bdid_score := 0;
		
		UNSIGNED6 did;
		UNSIGNED1	did_score :=0;
		STRING8		clean_dob;
		UNSIGNED4	best_dob;
		// STRING9		clean_ssn;
		STRING9		best_ssn;

    //PIID Migration
		STRING10	rec_deactivated_date;
		STRING10	superceeding_piid;

		BIPV2.IDlayouts.l_xlink_ids;
		
	END;
	
	EXPORT individual_state_licenses_base	:= RECORD
		individual_state_licenses_in;
		src_and_date;
		
		STRING10	clean_state_license_expire;
		STRING10	clean_state_license_issued;
	END;

	EXPORT individual_dea_base	:= RECORD
		individual_dea_in;
		src_and_date;
		
		STRING10	clean_dea_expire;
	END;

	EXPORT individual_state_csr_base	:= RECORD
		individual_state_csr_in;
		src_and_date;
		
		STRING10	clean_csr_expire_date; 
		STRING10	clean_csr_issue_date;
	END;

	EXPORT individual_sanctions_base	:= RECORD
		individual_sanctions_in;
		src_and_date;
		
		STRING10	clean_offense_date;
		STRING10	clean_action_date;
		STRING10	clean_sanction_period_start_date;
		STRING10	clean_sanction_period_end_date;
	END;

	EXPORT individual_gsa_sanctions_base	:= RECORD
		individual_gsa_sanctions_in;
		src_and_date;
		clean_name;
		
		STRING10	clean_action_date;
		STRING27	clean_date;
	END;

	EXPORT state_license_types_base	:= RECORD
		state_license_types_in;
		src_and_date;
	END;
	
	EXPORT individual_address_faxes_base := RECORD
#if (%readSourcesFromInFiles%)   //Version 20150424 has a sources field
	#if (%WriteSourcesToBaseFiles%)
			individual_address_faxes_in;   //  write sources field to base file
	#else		
			individual_address_faxes_in - [fax_sources];   // do not  write sources field to base file
	#end		
#else
		individual_address_faxes_in;   // sources field was not read to begin with
#end	
		src_and_date;
	END;

	EXPORT individual_address_phones_base := RECORD
#if (%readSourcesFromInFiles%)   //Version 20150424 has a sources field
	#if (%WriteSourcesToBaseFiles%)
			individual_address_phones_in;   //  write sources field to base file
	#else		
			individual_address_phones_in - [phone_sources];   // do not  write sources field to base file
	#end		
#else
		individual_address_phones_in;   // sources field was not read to begin with
#end	

		src_and_date;
		STRING10 clean_Phone;
	END;

	EXPORT individual_certifications_base := RECORD
    individual_certifications_in;	
		src_and_date;
	END;

	EXPORT individual_covered_recipients_base := RECORD
	  individual_covered_recipients_in;
		src_and_date;
		
		clean_name;
	END;

	EXPORT individual_education_base := RECORD
	  individual_education_in;
		src_and_date;
	END;

	EXPORT individual_languages_base := RECORD
		individual_languages_in;
		src_and_date;
	END;

	EXPORT individual_specialty_base := RECORD
		individual_specialty_in;
		src_and_date;
	END;

	EXPORT piid_migration_base := RECORD
		piid_migration_in;
		src_and_date;
	END;
	
END;

