IMPORT Address, BIPV2, AID, HMS_CSR;

EXPORT layouts := MODULE

	SHARED max_size := _Dataset().max_record_size;
	
	EXPORT address_layout := RECORD ,MAXLENGTH(max_size)
				string100 ln_key;
				string25 hms_src;
				string100 key;
				string25 id;
				string100 entityid;
				string employer_identification_number;
				string raw_full_address;
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
				string CREDENTIAL_TYPE;
				string STATUS;
				string SUB_STATUS;
				string STATE;
				string ISSUE_DATE;
				string EFFECTIVE_DATE;
				string EXPIRATION_DATE;
				string DISCIPLINE;
				string ALL_SCHEDULES;
				string SCHEDULE_1;
				string SCHEDULE_2;
				string SCHEDULE_2N;
				string SCHEDULE_3;
				string SCHEDULE_3N;
				string SCHEDULE_4;
				string SCHEDULE_5;
				string SCHEDULE_6;
				string RAW_STATUS;
				string RAW_SUB_STATUS1;
				string RAW_SUB_STATUS2;
		END;
		
		EXPORT dea_layout := RECORD
				string100 ln_key;
				string25 hms_src;
				string100 key;
				string25 id;
				string100 entityid;
				string50 dea_number;
				string SCHEDULES;
				string EXPIRATION_DATE;
				string ACTIVITY;
        string BAC;
				string BAC_SUBCODE;
				string PAYMENT;
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
				string fine;
		END;
		
		EXPORT education_layout := RECORD
				string100 ln_key;
				string25 hms_src;
				string100 key;
				string25 id;
				string100 entityid;
				string degree;
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
				string prefix;
				string50 first;
				string10 middle;
				string50 last;
				string10 suffix;
				string typecode;
				string position;
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
				string renewal_date;
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
				string REPLACEMENT_NUMBER;
				string ENUMERATION_DATE;
				string LAST_UPDATE_DATE;
				string DEACTIVATION_DATE;
				string REACTIVATION_DATE;
				string DEACTIVATION_REASON;
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
		
		EXPORT medicaid_layout := RECORD
				string100 ln_key;
				string25 hms_src;
				string100 key;
				string25 id;
				string100 entityid;
				string medicaid_number;
				string status;
				string2 state;
				string PARTICIPATION_FLAG;
		END;
		
		EXPORT taxonomy_layout := RECORD
				string100 ln_key;
				string25 hms_src;
				string100 key;
				string25 id;
				string100 entityid;
				string50 npi_number;
				string15 taxonomy_code;
				string taxonomy_order_number;
				string license_number_state_code;
				string taxonomy_switch;
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
		
		EXPORT csrcredential_layout := RECORD
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
					license_layout.renewal_date;
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
					entity_layout.prefix;
					entity_layout.first;
					entity_layout.middle;
					entity_layout.last;
					entity_layout.suffix;
					entity_layout.typecode;
					entity_layout.position;
					entity_layout.cred;
					entity_layout.age;
					entity_layout.dateofbirth;
					entity_layout.email;
					entity_layout.gender;
					entity_layout.dateofdeath;
					string license_class_type;
					string50 license_number;
					string2 license_state;
					address_layout.employer_identification_number;
					address_layout.raw_full_address;
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
					education_layout.degree;
					disciplinaryact_layout.board;
					disciplinaryact_layout.offense;
					disciplinaryact_layout.offense_date;
					disciplinaryact_layout.action;
					disciplinaryact_layout.action_date;
					disciplinaryact_layout.action_start;
					disciplinaryact_layout.action_end;
					disciplinaryact_layout.fine;
					npi_layout.npi_number;
					npi_layout.REPLACEMENT_NUMBER;
					npi_layout.ENUMERATION_DATE;
					npi_layout.LAST_UPDATE_DATE;
					npi_layout.DEACTIVATION_DATE;
					npi_layout.REACTIVATION_DATE;
					npi_layout.DEACTIVATION_REASON;
					csr_layout.csr_number;
					csr_layout.CREDENTIAL_TYPE;
					// csr_layout.STATUS;
					string CSR_STATUS:='';
					csr_layout.SUB_STATUS;
					// csr_layout.STATE;
					string CSR_STATE:='';
					// csr_layout.ISSUE_DATE;
					string CSR_ISSUE_DATE:='';
					csr_layout.EFFECTIVE_DATE;
					// csr_layout.EXPIRATION_DATE;
					string CSR_EXPIRATION_DATE:='';
					csr_layout.DISCIPLINE;
					csr_layout.ALL_SCHEDULES;
					csr_layout.SCHEDULE_1;
					csr_layout.SCHEDULE_2;
					csr_layout.SCHEDULE_2N;
					csr_layout.SCHEDULE_3;
					csr_layout.SCHEDULE_3N;
					csr_layout.SCHEDULE_4;
					csr_layout.SCHEDULE_5;
					csr_layout.SCHEDULE_6;
					csr_layout.RAW_STATUS;
					csr_layout.RAW_SUB_STATUS1;
					csr_layout.RAW_SUB_STATUS2;
					dea_layout.dea_number;
					dea_layout.SCHEDULES;
					// dea_layout.EXPIRATION_DATE;
					string DEA_EXPIRATION_DATE:='';
					dea_layout.ACTIVITY;
					dea_layout.BAC;
					dea_layout.BAC_SUBCODE;
					dea_layout.PAYMENT;
					// stliclookup_layout;
					medicaid_layout.medicaid_number;
					// medicaid_layout.status;
					string medicaid_Status:='';
					// medicaid_layout.state;
					string medicaid_State:='';
					medicaid_layout.PARTICIPATION_FLAG;
					// taxonomy_layout.npi_number;
					string taxonomy_npi_number:='';
					taxonomy_layout.taxonomy_code;
					taxonomy_layout.taxonomy_order_number;
					taxonomy_layout.license_number_state_code;
					taxonomy_layout.taxonomy_switch;
					string50 source_code := '';
					// string15 taxonomy_code := '';
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
		
 		EXPORT csrcredential_base := RECORD
						// csrcredential_layout;
						csrcredential_layout.ln_key;
   					csrcredential_layout.hms_src;
   					csrcredential_layout.key;
   					csrcredential_layout.id;
   					csrcredential_layout.entityid;

						//csrcredential_layout.number;
						//csrcredential_layout.class_type;
						//csrcredential_layout.state;
						// csrcredential_layout.license_number;
						string15 license_number := '';
						string license_class_type := '';
						string2 license_state := '';
						csrcredential_layout.status;
   					csrcredential_layout.issue_date;
   					csrcredential_layout.renewal_date;
   					csrcredential_layout.expiration_date;
   					csrcredential_layout.qualifier1;
   					csrcredential_layout.qualifier2;
   					csrcredential_layout.qualifier3;
   					csrcredential_layout.qualifier4;
   					csrcredential_layout.qualifier5;
   					csrcredential_layout.rawclass;
   					csrcredential_layout.rawissue_date;
   					csrcredential_layout.rawexpiration_date;
   					csrcredential_layout.rawstatus;
   					csrcredential_layout.raw_number;
   					csrcredential_layout.name;
						csrcredential_layout.prefix;
   					csrcredential_layout.first;
   					csrcredential_layout.middle;
   					csrcredential_layout.last;
   					csrcredential_layout.suffix;
   					csrcredential_layout.cred;
   					csrcredential_layout.age;
   					csrcredential_layout.dateofbirth;
   					csrcredential_layout.email;
   					csrcredential_layout.gender;
   					csrcredential_layout.dateofdeath;
						csrcredential_layout.employer_identification_number;
						csrcredential_layout.raw_full_address;
						csrcredential_layout.firmname;
   					csrcredential_layout.street1;
   					csrcredential_layout.street2;
   					csrcredential_layout.street3;
   					csrcredential_layout.city;
						string2 address_state := '';
						typeof(csrcredential_layout.zip) orig_zip := '';
						//csrcredential_layout.zip;
						//csrcredential_layout.county;
						typeof(csrcredential_layout.county) orig_county := '';
						csrcredential_layout.country;
						string25 address_type := '';
						//csrcredential_layout.type;
						csrcredential_layout.phone1;
   					csrcredential_layout.phone2;
   					csrcredential_layout.phone3;
   					csrcredential_layout.fax1;
   					csrcredential_layout.fax2;
   					csrcredential_layout.fax3;
   					csrcredential_layout.other_phone1;
   					csrcredential_layout.description;
   					string25 specialty_class_type := '';
   					string15 phone_number := '';
   					string25 phone_type := '';
   					csrcredential_layout.language;
						csrcredential_layout.degree;
   					csrcredential_layout.graduated;
   					csrcredential_layout.school;
   					csrcredential_layout.location;
						csrcredential_layout.fine;
   					csrcredential_layout.board;
   					csrcredential_layout.offense;
   					csrcredential_layout.offense_date;
   					csrcredential_layout.action;
   					csrcredential_layout.action_date;
   					csrcredential_layout.action_start;
   					csrcredential_layout.action_end;
   					csrcredential_layout.npi_number;
						csrcredential_layout.REPLACEMENT_NUMBER;
						csrcredential_layout.ENUMERATION_DATE;
						csrcredential_layout.LAST_UPDATE_DATE;
						csrcredential_layout.DEACTIVATION_DATE;
						csrcredential_layout.REACTIVATION_DATE;
						csrcredential_layout.DEACTIVATION_REASON;
   					csrcredential_layout.csr_number;
						csrcredential_layout.CREDENTIAL_TYPE;
						csrcredential_layout.CSR_STATUS;
						csrcredential_layout.SUB_STATUS;
						csrcredential_layout.CSR_STATE;
						csrcredential_layout.CSR_ISSUE_DATE;
						csrcredential_layout.EFFECTIVE_DATE;
						csrcredential_layout.CSR_EXPIRATION_DATE;
						csrcredential_layout.DISCIPLINE;
						csrcredential_layout.ALL_SCHEDULES;
						csrcredential_layout.SCHEDULE_1;
						csrcredential_layout.SCHEDULE_2;
						csrcredential_layout.SCHEDULE_2N;
						csrcredential_layout.SCHEDULE_3;
						csrcredential_layout.SCHEDULE_3N;
						csrcredential_layout.SCHEDULE_4;
						csrcredential_layout.SCHEDULE_5;
						csrcredential_layout.SCHEDULE_6;
						csrcredential_layout.RAW_STATUS;
						csrcredential_layout.RAW_SUB_STATUS1;
						csrcredential_layout.RAW_SUB_STATUS2;
						
   					csrcredential_layout.dea_number;
						csrcredential_layout.SCHEDULES;
						csrcredential_layout.DEA_EXPIRATION_DATE;
						csrcredential_layout.ACTIVITY;
						csrcredential_layout.BAC;
						csrcredential_layout.BAC_SUBCODE;
						csrcredential_layout.PAYMENT;
						
						csrcredential_layout.medicaid_number;
						csrcredential_layout.medicaid_Status;
						csrcredential_layout.medicaid_State;
						csrcredential_layout.PARTICIPATION_FLAG;
						csrcredential_layout.taxonomy_npi_number;
						csrcredential_layout.taxonomy_code;
						csrcredential_layout.taxonomy_order_number;
						csrcredential_layout.license_number_state_code;
						csrcredential_layout.taxonomy_switch;
											
						string Prepped_addr1 := '';
						string Prepped_addr2 := '';
						typeof(csrcredential_layout.phone_number) clean_phone := '';
						typeof(csrcredential_layout.phone1) clean_phone1 := '';
						typeof(csrcredential_layout.phone2) clean_phone2 := '';
						typeof(csrcredential_layout.phone3) clean_phone3 := '';
						typeof(csrcredential_layout.fax1) clean_fax1 := '';
						typeof(csrcredential_layout.fax2) clean_fax2 := '';
						typeof(csrcredential_layout.fax3) clean_fax3 := '';
						typeof(csrcredential_layout.other_phone1) clean_other_phone1 := '';
						typeof(csrcredential_layout.dateofbirth) clean_dateofbirth := '';
						typeof(csrcredential_layout.dateofdeath) clean_dateofdeath := '';
						typeof(csrcredential_layout.firmname) clean_company_name := '';
						typeof(csrcredential_layout.issue_date) clean_issue_date := '';
						typeof(csrcredential_layout.expiration_date)  clean_expiration_date := '';
						typeof(csrcredential_layout.offense_date) clean_offense_date := '';
						typeof(csrcredential_layout.action_date) clean_action_date := '';
						
						typeof(csrcredential_layout.renewal_date) clean_renewal_date := '';
						typeof(csrcredential_layout.enumeration_date) clean_enumeration_date := '';
						typeof(csrcredential_layout.last_update_date) clean_last_update_date := '';
						typeof(csrcredential_layout.deactivation_date) clean_deactivation_date := '';
						typeof(csrcredential_layout.reactivation_date) clean_reactivation_date := '';
						typeof(csrcredential_layout.csr_issue_date) clean_csr_issue_date := '';
						typeof(csrcredential_layout.effective_date)  clean_effective_date := '';
						typeof(csrcredential_layout.csr_expiration_date)  clean_csr_expiration_date := '';
						typeof(csrcredential_layout.dea_expiration_date)  clean_dea_expiration_date := '';

						src_and_date - [
															pid
															,ln_record_type
														];
						clean_address;
						clean_name;
						unsigned6 did 			:= 0;	
						unsigned1 did_score := 0;
						unsigned6 bdid;
						unsigned1 bdid_score := 0;
						unsigned4 best_dob;
						string9   best_ssn;
						string5 clean_zip5 := '';
						string4 clean_zip4 := '';
						BIPV2.IDlayouts.l_xlink_ids;
/* 					string In_State := ''; //License State
   					string In_Class := ''; //License Class
   					string In_Status := ''; // License Status
   					string In_Qualifier1 := ''; //License Qualifier 1
   					string In_Qualifier2 := ''; //License Qualifier 2
   					string mapped_class := '';
   					string mapped_status := '';
   					string mapped_qualifier1 := '';
   					string mapped_qualifier2 := '';
   					string mapped_pdma := '';
   					string mapped_pract_type := '';
*/
						string50 source_code := '';
					// string15 taxonomy_code := '';
						string file_date := '';
		END;
		
		EXPORT autokey_common	:= RECORD
			csrcredential_base;
			unsigned1 zero:=0;
			string1 blank:='';
		END;
				
END;

