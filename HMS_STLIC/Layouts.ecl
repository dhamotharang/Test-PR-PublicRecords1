IMPORT Address, BIPV2, AID, HMS_STLIC;

EXPORT layouts := MODULE

	SHARED max_size := _Dataset().max_record_size;
	
	EXPORT address_layout := RECORD ,MAXLENGTH(max_size)
				string100 ln_key;
				string25 hms_src;
				string100 key;
				string25 id;
				string100 entityid;
				string50 firmname;
				string50 street1;
				string25 street2;
				string25 street3;
				string50 city;
				string2 state;
				string12 zip;
				string50 county;
				string50 country;
				string type;
				string20 phone1;
				string20 phone2;
				string20 phone3;
				string20 fax1;
				string20 fax2;
				string20 fax3;	
				string20 other_phone1;
		END;
			
		EXPORT csr_layout := RECORD
				string100 ln_key;
				string25 hms_src;
				string100 key;
				string25 id;
				string100 entityid;
				string50 csr_number;
		END;
		
		EXPORT dea_layout := RECORD
				string100 ln_key;
				string25 hms_src;
				string100 key;
				string25 id;
				string100 entityid;
				string50 dea_number;
		END;

		EXPORT disciplinaryact_layout := RECORD
				string100 ln_key;
				string25 hms_src;
				string100 key;
				string25 id;
				string100 entityid;
				string50 board; 
				string50 offense;
				string20 offense_date;
				string50 action;
				string20 action_date;
				string20 action_start;
				string20 action_end;
		END;
		
		EXPORT education_layout := RECORD
				string100 ln_key;
				string25 hms_src;
				string100 key;
				string25 id;
				string100 entityid;
				string50 graduated; 
				string50 school;
				string50 location;
		END;
		
		EXPORT entity_layout := RECORD
				string100 ln_key;
				string25 hms_src;
				string100 key;
				string25 id;
				string100 entityid;
				string100 name;
				string50 first;
				string10 middle;
				string50 last;
				string10 suffix;
				string10 cred;
				unsigned3 age;
				string20 dateofbirth;
				string50 email;
				string1 gender;
				string20 dateofdeath;
		END;
		
		EXPORT language_layout := RECORD
				string100 ln_key;
				string25 hms_src;
				string100 key;
				string25 id;
				string100 entityid;
				string50 language;
		END;
				
		EXPORT license_layout := RECORD
				string100 ln_key;
				string25 hms_src;
				string100 key;
				string25 id;
				string100 entityid;
				string number;
				string class_type;
				string2 state;
				string status;
				string issue_date;
				string expiration_date;
				string qualifier1;
				string qualifier2;
				string qualifier3;
				string qualifier4;
				string qualifier5;
				string rawclass;
				string rawissue_date;
				string rawexpiration_date;
				string rawstatus;
				string raw_number;
		END;
		
		EXPORT npi_layout := RECORD
				string100 ln_key;
				string25 hms_src;
				string100 key;
				string25 id;
				string100 entityid;
				string50 npi_number;
		END;
		
		EXPORT phone_layout := RECORD
				string100 ln_key;
				string25 hms_src;
				string100 key;
				string25 id;
				string100 entityid;
				string20 number;
				string50 type;				
		END;
		
		EXPORT specialty_layout := RECORD
				string100 ln_key;
				string25 hms_src;
				string100 key;
				string25 id;
				string100 entityid;
				string50 description;
				string class_type;
		END;
		
		
		EXPORT stliclookup_layout := RECORD
			STRING state := ''; //License State
			STRING stlicClass := ''; //License Class
			STRING status := ''; // License Status
			STRING qualifier1 := ''; //License Qualifier 1
			STRING qualifier2 := ''; //License Qualifier 2
			STRING mapped_class := '';
			STRING mapped_status := '';
			STRING mapped_qualifier1 := '';
			STRING mapped_qualifier2 := '';
			STRING mapped_pdma := '';
			STRING mapped_pract_type := '';
		END;
		
		EXPORT statelicense_layout := RECORD
					license_layout.ln_key;
					license_layout.hms_src;
					license_layout.key;
					license_layout.id;
					license_layout.entityid;
					license_layout.number;
					license_layout.class_type;
					license_layout.state;
					license_layout.status;
					license_layout.issue_date;
					license_layout.expiration_date;
					license_layout.qualifier1;
					license_layout.qualifier2;
					license_layout.qualifier3;
					license_layout.qualifier4;
					license_layout.qualifier5;
					license_layout.rawclass;
					license_layout.rawissue_date;
					license_layout.rawexpiration_date;
					license_layout.rawstatus;
					license_layout.raw_number;
					entity_layout.name;
					entity_layout.first;
					entity_layout.middle;
					entity_layout.last;
					entity_layout.suffix;
					entity_layout.cred;
					entity_layout.age;
					entity_layout.dateofbirth;
					entity_layout.email;
					entity_layout.gender;
					entity_layout.dateofdeath;
					string license_class_type;
					string50 license_number;
					string2 license_state;
					address_layout.firmname;
					address_layout.street1;
					address_layout.street2;
					address_layout.street3;
					address_layout.city;
					address_layout.zip;
					address_layout.county;
					address_layout.country;
					address_layout.type;
					address_layout.phone1;
					address_layout.phone2;
					address_layout.phone3;
					address_layout.fax1;
					address_layout.fax2;
					address_layout.fax3;
					address_layout.other_phone1;
					string25 address_type := '';
					string2 address_state := '';
					specialty_layout.description;
					string specialty_class_type := '';
					string20 phone_number := '';
					string25 phone_type := '';
					language_layout.language;
					education_layout.graduated;
					education_layout.school;
					education_layout.location;
					disciplinaryact_layout.board;
					disciplinaryact_layout.offense;
					disciplinaryact_layout.offense_date;
					disciplinaryact_layout.action;
					disciplinaryact_layout.action_date;
					disciplinaryact_layout.action_start;
					disciplinaryact_layout.action_end;
					npi_layout.npi_number;
					csr_layout.csr_number;
					dea_layout.dea_number;
					stliclookup_layout;
					string50 source_code := '';
					string15 taxonomy_code := '';
		END;
		
		
	//===================================================
	//  BASE LAYOUTS
	//===================================================
		EXPORT src_and_date	:= RECORD
			UNSIGNED6 	pid;
			STRING10 		src;		
			UNSIGNED4 	dt_vendor_first_reported;
			UNSIGNED4 	dt_vendor_last_reported;
			UNSIGNED4		dt_first_seen	:= 0;
			UNSIGNED4		dt_last_seen	:= 0;
			STRING1   	ln_record_type;
			UNSIGNED8	 	source_rid;
			UNSIGNED8	 	lnpid;
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
		  //STRING3		fips_county:='';
			//STRING3		county:='';
			address.Layout_Clean182.county;
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
			address.Layout_Clean_Name.title;
		  address.Layout_Clean_Name.fname;
		  address.Layout_Clean_Name.mname;
		  address.Layout_Clean_Name.lname;
		  address.Layout_Clean_Name.name_suffix;
			STRING35	clean_company_name;
			STRING1 name_type:='';
			UNSIGNED8	nid;
		END;
		
		EXPORT address_base := RECORD
				address_layout;
				src_and_date - [
													pid
													,source_rid
													,ln_record_type
											 ];
				string orig_county;
				clean_address;
				string Prepped_addr1;
				string Prepped_addr2;
				STRING100	clean_company_name;
				STRING10	clean_phone1;
				STRING10	clean_phone2;
				STRING10	clean_phone3;
				STRING10	clean_fax1;
				STRING10	clean_fax2;
				STRING10	clean_fax3;
				STRING10	clean_other_phone1;
				string file_date := '';
		END;
		
		EXPORT csr_base := RECORD
				csr_layout;
				src_and_date - [
													pid
													,source_rid
													,ln_record_type
												];
				string file_date := '';
		END;
		
		EXPORT dea_base := RECORD
				dea_layout;
				src_and_date - [
													pid
													,source_rid
													,ln_record_type
												];
				string file_date := '';
		END;
		
		EXPORT disciplinaryact_base := RECORD
				disciplinaryact_layout;
				src_and_date - [pid,source_rid,ln_record_type];
				string10 clean_offense_date;
				string10 clean_action_date;
				string file_date := '';
		END;
		
		EXPORT education_base := RECORD
				education_layout;
				src_and_date - [pid,source_rid,ln_record_type];
				string file_date := '';
		END;
				
		EXPORT language_base := RECORD
				language_layout;
				src_and_date - [pid,source_rid,ln_record_type];
				string file_date := '';
		END;
		
		EXPORT license_base := RECORD
				license_layout;
				src_and_date - [pid,source_rid,ln_record_type];
				string10 clean_issue_date;
				string10 clean_expiration_date;
				string file_date := '';
		END;
		
		EXPORT npi_base := RECORD
				npi_layout;
				src_and_date - [pid,source_rid,ln_record_type];
				string file_date := '';
		END;
				
		EXPORT phone_base := RECORD
				phone_layout;
				src_and_date - [pid,source_rid,ln_record_type];
				STRING15	clean_phone;
				string file_date := '';
		END;
				
		EXPORT specialty_base := RECORD
				specialty_layout;
				src_and_date - [pid,source_rid,ln_record_type];
				string file_date := '';
		END;
			
		EXPORT entity_base := RECORD
				entity_layout;
				src_and_date - [pid,source_rid,ln_record_type];
				clean_name;
				string10 clean_dateofbirth;
				string10 clean_dateofdeath;
				string file_date := '';
		END;
		
 		EXPORT statelicense_base := RECORD
			string100 ln_key;
			string25 	hms_src;
			string100 key;
			string25 	id;
			string100 entityid;
			string50 	license_number;
			string 		license_class_type;
			string2 	license_state;
			string 		status;
			string 		issue_date;
			string 		expiration_date;
			string 		qualifier1;
			string 		qualifier2;
			string 		qualifier3;
			string 		qualifier4;
			string 		qualifier5;
			string 		rawclass;
			string 		rawissue_date;
			string 		rawexpiration_date;
			string 		rawstatus;
			string 		raw_number;
			string100 name;
			string50 	first;
			string10 	middle;
			string50 	last;
			string10 	suffix;
			string10 	cred;
			unsigned3 age;
			string20 	dateofbirth;
			string50 	email;
			string1 	gender;
			string20 	dateofdeath;
			string50 	firmname;
			string50 	street1;
			string25 	street2;
			string25 	street3;
			string50 	city;
			string2 	address_state;
			string12 	orig_zip;
			string50 	orig_county;
			string50 	country;
			string25 	address_type;
			string20 	phone1;
			string20 	phone2;
			string20 	phone3;
			string20 	fax1;
			string20 	fax2;
			string20 	fax3;
			string20 	other_phone1;
			string50 	description;
			string25 	specialty_class_type;
			string15 	phone_number;
			string25 	phone_type;
			string50 	language;
			string50 	graduated;
			string50 	school;
			string50 	location;
			string50 	board;
			string50 	offense;
			string20 	offense_date;
			string50 	action;
			string20 	action_date;
			string20 	action_start;
			string20 	action_end;
			string50 	npi_number;
			string50 	csr_number;
			string50 	dea_number;
			string 		prepped_addr1;
			string 		prepped_addr2;
			string20 	clean_phone;
			string20 	clean_phone1;
			string20 	clean_phone2;
			string20 	clean_phone3;
			string20 	clean_fax1;
			string20 	clean_fax2;
			string20 	clean_fax3;
			string20 	clean_other_phone1;
			string20 	clean_dateofbirth;
			string20 	clean_dateofdeath;
			string50 	clean_company_name;
			string 		clean_issue_date;
			string 		clean_expiration_date;
			string20 	clean_offense_date;
			string20 	clean_action_date;
			string10 	src;
			unsigned4 dt_vendor_first_reported;
			unsigned4 dt_vendor_last_reported;
			unsigned4 dt_first_seen;
			unsigned4 dt_last_seen;
			unsigned8 source_rid;
			unsigned8 lnpid;
			string10 	prim_range;
			string2 	predir;
			string28 	prim_name;
			string4 	addr_suffix;
			string2 	postdir;
			string10 	unit_desig;
			string8 	sec_range;
			string25 	p_city_name;
			string25 	v_city_name;
			string2 	st;
			string5 	zip;
			string4 	zip4;
			string4 	cart;
			string1 	cr_sort_sz;
			string4 	lot;
			string1 	lot_order;
			string2 	dbpc;
			string1 	chk_digit;
			string2 	rec_type;
			string2 	fips_st;
			string5 	county;
			string10 	geo_lat;
			string11 	geo_long;
			string4 	msa;
			string7 	geo_blk;
			string1 	geo_match;
			string4 	err_stat;
			unsigned8 rawaid;
			unsigned8 aceaid;
			string5 	title;
			string20 	fname;
			string20 	mname;
			string20 	lname;
			string5 	name_suffix;
			string1 	name_type;
			unsigned8 nid;
			unsigned6 did;
			unsigned1 did_score;
      // InsuranceHeader_xLink.DebugFields;
      integer2 	xadl2_weight := 0; 
			unsigned2 xadl2_score := 0;   // salt score
			integer1 	xadl2_distance := 0;  
      unsigned4 xadl2_keys_used := 0;  
      string 		xadl2_keys_desc := '';
			string60 	xadl2_matches := '';  
			string 		xadl2_matches_desc := '';          
			unsigned6 bdid;
			unsigned1 bdid_score;
			unsigned4 best_dob;
			string9 	best_ssn;
			string5 	clean_zip5;
			string4 	clean_zip4;
			unsigned6 dotid;
			unsigned2 dotscore;
			unsigned2 dotweight;
			unsigned6 empid;
			unsigned2 empscore;
			unsigned2 empweight;
			unsigned6 powid;
			unsigned2 powscore;
			unsigned2 powweight;
			unsigned6 proxid;
			unsigned2 proxscore;
			unsigned2 proxweight;
			unsigned6 seleid;
			unsigned2 selescore;
			unsigned2 seleweight;
			unsigned6 orgid;
			unsigned2 orgscore;
			unsigned2 orgweight;
			unsigned6 ultid;
			unsigned2 ultscore;
			unsigned2 ultweight;
			string 		in_state;
			string 		in_class;
			string 		in_status;
			string 		in_qualifier1;
			string 		in_qualifier2;
			string 		mapped_class;
			string 		mapped_status;
			string 		mapped_qualifier1;
			string 		mapped_qualifier2;
			string 		mapped_pdma;
			string 		mapped_pract_type;
			string50 	source_code;
			string15 	taxonomy_code;
			string 		file_date;
		END;
		
		EXPORT autokey_common	:= RECORD
			statelicense_base - [xadl2_weight, xadl2_score, xadl2_distance, xadl2_keys_used, xadl2_keys_desc, xadl2_matches, xadl2_matches_desc];
			unsigned1 zero:=0;
			string1 blank:='';
		END;

END;

