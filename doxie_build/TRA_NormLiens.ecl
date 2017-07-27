import VehLic, doxie_files;

export doxie_files.Layout_VehicleContacts TRA_NormLiens(doxie_files.Layout_vehicles L, INTEGER C) :=
TRANSFORM
	// record ids
	SELF.seq_no := L.seq_no;
	SELF.rec_source := CHOOSE(C, 'lien1', 'lien2', 'lien3');
	SELF.DID := 0;	
	SELF.bdid := 0;
	SELF.orig_state := L.orig_state;
	SELF.record_type := L.record_type;
	
	// clean fields
	SELF.prim_range := '';
						
	SELF.predir := '';
	SELF.prim_name := '';
	SELF.addr_suffix := '';
	SELF.postdir := '';
	SELF.unit_desig := ''; 
	SELF.p_city_name := '';
	SELF.v_city_name := '';
	SELF.sec_range := '';
	SELF.st := '';
	SELF.zip5 := '';
	SELF.zip4 := '';
	SELF.county := '';
	SELF.geo_lat := '';
	SELF.geo_long := '';
	SELF.title := '';
	SELF.fname := '';
	SELF.mname := '';
	SELF.lname := '';
	SELF.name_suffix := '';
	SELF.company_name := ''; 
	SELF.ssn := '';
		
	// raw from vehicles
	SELF.customer_type := CHOOSE(C, 			L.LEIN_HOLDER_1_CUSTOMER_TYPE, 	L.LEIN_HOLDER_2_CUSTOMER_TYPE, 
												L.LEIN_HOLDER_3_CUSTOMER_TYPE);
	SELF.customer_number := CHOOSE(C, 			L.LH_1_customer_number, 		L.LH_2_customer_number,
												L.LH_3_customer_number);
	SELF.orig_name := CHOOSE(C, 				L.LH_1_customer_name, 			L.LH_2_customer_name, 
												L.LH_3_customer_name);
	SELF.address_number := CHOOSE(C, 			L.LH_1_address_number, 			L.LH_2_address_number, 
												L.LH_3_address_number);
	SELF.foreign_address_flag := CHOOSE(C, 		L.LH_1_foreign_address_flag, 	L.LH_2_foreign_address_flag,
												L.LH_3_foreign_address_flag);
	SELF.orig_street_address := CHOOSE(C, 		L.LH_1_street_address, 			L.LH_2_street_address, 
												L.LH_3_street_address);
	SELF.orig_apartment_number := CHOOSE(C, 	L.LH_1_apartment_number, 		L.LH_2_apartment_number, 
												L.LH_3_apartment_number);
	SELF.orig_addr_city := CHOOSE(C, 			L.LH_1_city, 					L.LH_2_city,
												L.LH_3_city);
	SELF.orig_addr_state := CHOOSE(C, 			L.LH_1_state, 					L.LH_2_state, 	
												L.LH_3_state);
	SELF.zip5_zip4_foreign_postal := CHOOSE(C, 	L.LH_1_zip5_zip4_foreign_postal, L.LH_2_zip5_zip4_foreign_postal, 
												L.LH_3_zip5_zip4_foreign_postal);
	SELF.orig_residence_county := CHOOSE(C,		L.LH_1_residence_county, 		L.LH_2_residence_county, 
												L.LH_3_residence_county);
	SELF.DEALER_LICENSE_NUMBER := CHOOSE(C, 	L.LH_1_dealer_license_number, 	L.LH_2_dealer_license_number, 
												L.LH_3_dealer_license_number);
		
	SELF.feid_ssn := CHOOSE(C, 					L.LH_1_FEID_SSN, 				L.LH_2_FEID_SSN, 
												L.LH_3_FEID_SSN);
	SELF.drivers_license_number:= CHOOSE(C, 	L.LH_1_DRIVER_LICENSE_NUMBER, 	L.LH_2_DRIVER_LICENSE_NUMBER,
												L.LH_3_DRIVER_LICENSE_NUMBER);
	SELF.dob := CHOOSE(C, 						L.LH_1_DOB, 					L.LH_2_DOB, 
												L.LH_3_DOB);
	SELF.sex := CHOOSE(C, 						L.LH_1_sex, 					L.LH_2_sex, 
												L.LH_3_sex);
	SELF.sexual_predator_flag := CHOOSE(C, 		L.LH_1_sexual_predator_flag, 	L.LH_2_sexual_predator_flag, 
												L.LH_3_sexual_predator_flag);
	SELF.mail_suppresion_flag := CHOOSE(C, 		L.LH_1_mail_suppession_flag, 	L.LH_2_mail_suppession_flag, 
												L.LH_3_mail_suppession_flag);
	SELF.addr_non_disclosure_flag := CHOOSE(C, 	L.LH_1_addr_non_disclosure_flag, L.LH_2_addr_non_disclosure_flag, 
												L.LH_3_addr_non_disclosure_flag);
	SELF.law_enforcement_flag := CHOOSE(C, 		L.LH_1_law_enforcement_flag, 	L.LH_2_law_enforcement_flag, 
												L.LH_3_law_enforcement_flag);
	
	// generic Vehicle info
	SELF.dt_last_seen := L.dt_last_seen;
	SELF.dt_first_seen := L.dt_first_seen;
	SELF.registration_expiration_date := L.REGISTRATION_EXPIRATION_DATE;
	SELF.title_issue_date := L.title_issue_date;
	
	// lein holder specific
	SELF.LH_lein_date := CHOOSE(C,	L.LH_1_lien_date, L.LH_2_lein_date, L.LH_3_lien_date)
END;