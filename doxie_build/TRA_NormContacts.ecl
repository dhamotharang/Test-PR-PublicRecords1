import VehLic, doxie_files;

export doxie_files.Layout_VehicleContacts TRA_NormContacts(doxie_files.Layout_vehicles L, INTEGER C) :=
TRANSFORM
	// record ids
	SELF.seq_no := L.seq_no;// + (C - 1); // makes the seq_no unique for roxie
	SELF.rec_source := CHOOSE(C, 'own_1', 'own_2', 'reg_1', 'reg_2');
	SELF.DID := (unsigned6)CHOOSE(C, L.own_1_did, L.own_2_did, 
								  L.reg_1_did, L.reg_2_did);	
	SELF.bdid := (unsigned6)CHOOSE(C, L.own_1_bdid, L.own_2_bdid, 
								  L.reg_1_bdid, L.reg_2_bdid);	
	SELF.orig_state := L.orig_state;
	SELF.record_type := L.record_type;
	
	// clean fields
	SELF.prim_range := CHOOSE(C, L.own_1_prim_range, L.own_2_prim_range, 
								  L.reg_1_prim_range, L.reg_2_prim_range);
	SELF.predir := CHOOSE(C, L.own_1_predir, L.own_2_predir, L.reg_1_predir, L.reg_2_predir);
	SELF.prim_name := CHOOSE(C, L.own_1_prim_name, L.own_2_prim_name, L.reg_1_prim_name, L.reg_2_prim_name);
	SELF.addr_suffix := CHOOSE(C, L.own_1_suffix, L.own_2_suffix, L.reg_1_suffix, L.reg_2_suffix);
	SELF.postdir := CHOOSE(C, L.own_1_postdir, L.own_2_postdir, L.reg_1_postdir, L.reg_2_postdir);
	SELF.unit_desig := CHOOSE(C, L.own_1_unit_desig, L.own_2_unit_desig, L.reg_1_unit_desig, L.reg_2_unit_desig);
	SELF.p_city_name := CHOOSE(C, L.own_1_p_city_name, L.own_2_p_city_name, L.reg_1_p_city_name, L.reg_2_p_city_name);
	SELF.v_city_name := CHOOSE(C, L.own_1_v_city_name, L.own_2_v_city_name, L.reg_1_v_city_name, L.reg_2_v_city_name);
	SELF.sec_range := CHOOSE(C, L.own_1_sec_range, L.own_2_sec_range, L.reg_1_sec_range, L.reg_2_sec_range);
	SELF.st := CHOOSE(C, L.own_1_state_2, L.own_2_state_2, L.reg_1_state_2, L.reg_2_state_2);
	SELF.zip5 := CHOOSE(C, L.own_1_zip5, L.own_2_zip5, L.reg_1_zip5, L.reg_2_zip5);
	SELF.zip4 := CHOOSE(C, L.own_1_zip4, L.own_2_zip4, L.reg_1_zip4, L.reg_2_zip4);
	SELF.county := CHOOSE(C, L.own_1_county, L.own_2_county, L.reg_1_county, L.reg_2_county);
	SELF.geo_lat := CHOOSE(C, L.own_1_geo_lat, L.own_2_geo_lat, L.reg_1_geo_lat, L.reg_2_geo_lat);
	SELF.geo_long := CHOOSE(C, L.own_1_geo_long, L.own_2_geo_long, L.reg_1_geo_long, L.reg_2_geo_long);
	SELF.title := CHOOSE(C, L.own_1_title, L.own_2_title, L.reg_1_title, L.reg_2_title);
	SELF.fname := CHOOSE(C, L.own_1_fname, L.own_2_fname, L.reg_1_fname, L.reg_2_fname);
	SELF.mname := CHOOSE(C, L.own_1_mname, L.own_2_mname, L.reg_1_mname, L.reg_2_mname);
	SELF.lname := CHOOSE(C, L.own_1_lname, L.own_2_lname, L.reg_1_lname, L.reg_2_lname);
	SELF.name_suffix := CHOOSE(C, L.own_1_name_suffix, L.own_2_name_suffix, L.reg_1_name_suffix, L.reg_2_name_suffix);
	SELF.company_name := CHOOSE(C, L.own_1_company_name, L.own_2_company_name, 
									L.reg_1_company_name, L.reg_2_company_name);
	SELF.ssn := CHOOSE(C, L.own_1_ssn, L.own_2_ssn, L.reg_1_ssn, L.reg_2_ssn);
		
	// raw from vehicles
	SELF.customer_type := CHOOSE(C, 			L.OWNER_1_CUSTOMER_TYPExBG3, 	L.OWNER_2_CUSTOMER_TYPE, 
												L.REGISTRANT_1_CUSTOMER_TYPExBG5, L.REGISTRANT_2_CUSTOMER_TYPE);
	SELF.customer_number := CHOOSE(C, 			L.own_1_customer_number, 		L.own_2_customer_number,
												L.reg_1_customer_number, 		L.reg_2_customer_number);
	SELF.orig_name := CHOOSE(C, 				L.own_1_customer_name, 			L.own_2_customer_name, 
												L.reg_1_customer_name,			L.reg_2_customer_name);
	SELF.address_number := CHOOSE(C, 			L.own_1_address_number, 		L.own_2_address_number, 
												L.reg_1_address_number, 		L.reg_1_address_number);
	SELF.foreign_address_flag := CHOOSE(C, 		L.own_1_foreign_address_flag, 	L.own_2_foreign_address_flag,
												L.reg_1_foreign_address_flag, 	L.reg_2_foreign_address_flag);
	SELF.orig_street_address := CHOOSE(C, 		L.own_1_street_address, 		L.own_2_street_address, 
												L.reg_1_street_address, 		L.reg_2_street_address);
	SELF.orig_apartment_number := CHOOSE(C, 	L.own_1_apartment_number, 		L.own_2_apartment_number, 
												L.reg_1_apartment_number, 		L.reg_2_apartment_number);
	SELF.orig_addr_city := CHOOSE(C, 			L.own_1_city, 					L.own_2_city,
												L.reg_1_city, 					L.reg_2_city);
	SELF.orig_addr_state := CHOOSE(C, 			L.own_1_state, 					L.own_2_state, 	
												L.reg_1_state, 					L.reg_2_state);
	SELF.zip5_zip4_foreign_postal := CHOOSE(C, 	L.own_1_zip5_zip4_foreign_postal, L.own_2_zip5_zip4_foreign_postal, 
												L.reg_1_zip5_zip4_foreign_postal, L.reg_2_zip5_zip4_foreign_postal);
	SELF.orig_residence_county := CHOOSE(C,		L.own_1_residence_county, 		L.own_2_residence_county, 
												L.reg_1_residence_county, 		L.reg_2_residence_county);
	SELF.DEALER_LICENSE_NUMBER := CHOOSE(C, 	L.own_1_dealer_license_number, 	L.own_2_dealer_license_number, 
												L.reg_1_dealer_license_number, 	L.reg_2_dealer_license_number);
		
	SELF.feid_ssn := CHOOSE(C, 					L.OWN_1_FEID_SSN, 				L.OWN_2_FEID_SSN, 
												L.REG_1_FEID_SSN, 				L.REG_2_FEID_SSN);
	SELF.drivers_license_number:= CHOOSE(C, 	L.OWN_1_DRIVER_LICENSE_NUMBER, L.OWN_2_DRIVER_LICENSE_NUMBER,
												L.REG_1_DRIVER_LICENSE_NUMBER, L.REG_2_DRIVER_LICENSE_NUMBER);
	SELF.dob := CHOOSE(C, 						L.OWN_1_DOB, L.OWN_2_DOB, L.REG_1_DOB, L.REG_2_DOB);
	SELF.sex := CHOOSE(C, 						L.own_1_sex, L.own_2_sex, L.reg_1_sex, L.reg_2_sex);
	SELF.sexual_predator_flag := CHOOSE(C, 		L.own_1_sexual_predator_flag, L.own_2_sexual_predator_flag, 
												L.reg_1_sexual_predator_flag, L.reg_2_sexual_predator_flag);
	SELF.mail_suppresion_flag := CHOOSE(C, 		L.own_1_mail_suppession_flag, L.own_2_mail_suppession_flag, 
												L.reg_1_mail_suppession_flag, L.reg_2_mail_suppession_flag);
	SELF.addr_non_disclosure_flag := CHOOSE(C, 	L.own_1_addr_non_disclosure_flag, L.own_2_addr_non_disclosure_flag, 
												L.reg_1_addr_non_disclosure_flag, L.reg_2_addr_non_disclosure_flag);
	SELF.law_enforcement_flag := CHOOSE(C, 		L.own_1_law_enforcement_flag, L.own_2_law_enforcement_flag, 
												L.reg_1_law_enforcement_flag, L.reg_2_law_enforcement_flag);
	
	// generic Vehicle info
	SELF.dt_last_seen := L.dt_last_seen;
	SELF.dt_first_seen := L.dt_first_seen;
	SELF.registration_expiration_date := L.REGISTRATION_EXPIRATION_DATE;
	SELF.title_issue_date := L.title_issue_date;
	
	// lein holder specific
	SELF.LH_lein_date := '';
END;