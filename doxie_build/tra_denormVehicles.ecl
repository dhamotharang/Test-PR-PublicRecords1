import Vehlic, doxie_files;

chooser(src, src_test, yesfield, nofield) :=
MACRO
	IF(src = src_test, yesfield, nofield)
ENDMACRO;

export doxie_files.Layout_Vehicles tra_denormVehicles(doxie_files.Layout_Vehicles le, doxie_files.Layout_VehicleContacts ri) :=
TRANSFORM
	/* ************************************* Owner 1 ************************************* */
	SELF.OWNER_1_CUSTOMER_TYPExBG3 := chooser(ri.rec_source, 'own_1', ri.customer_type , le.owner_1_customer_typexbg3);
	SELF.OWN_1_CUSTOMER_NUMBER := chooser(ri.rec_source, 'own_1', ri.customer_number , le.own_1_customer_number);
	SELF.OWN_1_FEID_SSN := chooser(ri.rec_source, 'own_1', ri.feid_ssn, le.own_1_feid_ssn);
	SELF.OWN_1_CUSTOMER_NAME := chooser(ri.rec_source, 'own_1', ri.orig_name, le.own_1_customer_name);
	SELF.OWN_1_DEALER_LICENSE_NUMBER := chooser(ri.rec_source, 'own_1', ri.dealer_license_number, le.own_1_dealer_license_number);
	SELF.OWN_1_DRIVER_LICENSE_NUMBER := chooser(ri.rec_source, 'own_1', ri.drivers_license_number, le.own_1_DRIVER_LICENSE_NUMBER);
	SELF.own_1_dob := chooser(ri.rec_source, 'own_1', IF(ri.dob != '', ri.dob, ri.best_dob), le.own_1_dob);
	SELF.own_1_sex := chooser(ri.rec_source, 'own_1', ri.sex, le.own_1_sex);
	SELF.OWN_1_SEXUAL_PREDATOR_FLAG := chooser(ri.rec_source, 'own_1', ri.sexual_predator_flag , le.own_1_sexual_predator_flag);
	SELF.OWN_1_MAIL_SUPPESSION_FLAG := chooser(ri.rec_source, 'own_1', ri.mail_suppresion_flag , le.own_1_MAIL_SUPPESSION_FLAG);
	SELF.OWN_1_ADDR_NON_DISCLOSURE_FLAG := chooser(ri.rec_source, 'own_1', ri.ADDR_NON_DISCLOSURE_FLAG , le.own_1_ADDR_NON_DISCLOSURE_FLAG);
	SELF.OWN_1_LAW_ENFORCEMENT_FLAG := chooser(ri.rec_source, 'own_1', ri.LAW_ENFORCEMENT_FLAG , le.own_1_LAW_ENFORCEMENT_FLAG);
	SELF.OWN_1_ADDRESS_NUMBER := chooser(ri.rec_source, 'own_1', ri.ADDRESS_NUMBER , le.own_1_ADDRESS_NUMBER);
	SELF.OWN_1_FOREIGN_ADDRESS_FLAG := chooser(ri.rec_source, 'own_1', ri.FOREIGN_ADDRESS_FLAG , le.own_1_FOREIGN_ADDRESS_FLAG);
	SELF.OWN_1_STREET_ADDRESS := chooser(ri.rec_source, 'own_1', ri.orig_street_address, le.own_1_street_address);
	SELF.OWN_1_APARTMENT_NUMBER := chooser(ri.rec_source, 'own_1', ri.orig_apartment_number, le.own_1_apartment_number);
	SELF.OWN_1_CITY := chooser(ri.rec_source, 'own_1', ri.orig_addr_city, le.own_1_city);
	SELF.OWN_1_STATE := chooser(ri.rec_source, 'own_1', ri.orig_addr_state, le.own_1_state);
	SELF.OWN_1_ZIP5_ZIP4_FOREIGN_POSTAL := chooser(ri.rec_source, 'own_1', ri.zip5_zip4_foreign_postal, le.own_1_zip5_zip4_foreign_postal);
	SELF.OWN_1_RESIDENCE_COUNTY := chooser(ri.rec_source, 'own_1', ri.orig_residence_county , le.own_1_residence_county);
	
	SELF.own_1_title := chooser(ri.rec_source, 'own_1', ri.title, le.own_1_title);
	SELF.own_1_fname := chooser(ri.rec_source, 'own_1', ri.fname, le.own_1_fname);
	SELF.own_1_mname := chooser(ri.rec_source, 'own_1', ri.mname, le.own_1_mname);
	SELF.own_1_lname := chooser(ri.rec_source, 'own_1', ri.lname, le.own_1_lname);
	SELF.own_1_name_suffix := chooser(ri.rec_source, 'own_1', ri.name_suffix, le.own_1_name_suffix);
	SELF.own_1_did := chooser(ri.rec_source, 'own_1', (STRING)ri.did, le.own_1_did);
	SELF.own_1_ssn := chooser(ri.rec_source, 'own_1', ri.ssn, le.own_1_ssn);
	SELF.own_1_company_name := chooser(ri.rec_source, 'own_1', ri.company_name, le.own_1_company_name);
	SELF.own_1_prim_range := chooser(ri.rec_source, 'own_1', ri.prim_range , le.own_1_prim_range);
	SELF.own_1_predir := chooser(ri.rec_source, 'own_1', ri.predir , le.own_1_predir);
	SELF.own_1_prim_name := chooser(ri.rec_source, 'own_1', ri.prim_name , le.own_1_prim_name);
	SELF.own_1_suffix := chooser(ri.rec_source, 'own_1', ri.addr_suffix , le.own_1_suffix);
	SELF.own_1_postdir := chooser(ri.rec_source, 'own_1', ri.postdir , le.own_1_postdir);
	SELF.own_1_unit_desig := chooser(ri.rec_source, 'own_1', ri.unit_desig , le.own_1_unit_desig);
	SELF.own_1_sec_range := chooser(ri.rec_source, 'own_1', ri.sec_range , le.own_1_sec_range);
	SELF.own_1_p_city_name := chooser(ri.rec_source, 'own_1', ri.p_city_name , le.own_1_p_city_name);
	SELF.own_1_v_city_name := chooser(ri.rec_source, 'own_1', ri.v_city_name , le.own_1_v_city_name);
	SELF.own_1_state_2 := chooser(ri.rec_source, 'own_1', ri.st , le.own_1_state_2);
	SELF.own_1_zip5 := chooser(ri.rec_source, 'own_1', ri.zip5, le.own_1_zip5);
	SELF.own_1_zip4 := chooser(ri.rec_source, 'own_1', ri.zip4 , le.own_1_zip4);
	SELF.own_1_county := chooser(ri.rec_source, 'own_1', ri.county, le.own_1_county);
	SELF.own_1_county_name := chooser(ri.rec_source, 'own_1', ri.county_name, le.own_1_county_name);
	SELF.own_1_geo_lat := chooser(ri.rec_source, 'own_1', ri.geo_lat , le.own_1_geo_lat);
	SELF.own_1_geo_long := chooser(ri.rec_source, 'own_1', ri.geo_long , le.own_1_geo_long);

	/* ************************************* Owner 2 ************************************* */
	SELF.OWNER_2_CUSTOMER_TYPE := chooser(ri.rec_source, 'own_2', ri.customer_type , le.owner_2_customer_type);
	SELF.own_2_CUSTOMER_NUMBER := chooser(ri.rec_source, 'own_2', ri.customer_number , le.own_2_customer_number);
	SELF.own_2_FEID_SSN := chooser(ri.rec_source, 'own_2', ri.feid_ssn, le.own_2_feid_ssn);
	SELF.own_2_CUSTOMER_NAME := chooser(ri.rec_source, 'own_2', ri.orig_name, le.own_2_customer_name);
	SELF.own_2_DEALER_LICENSE_NUMBER := chooser(ri.rec_source, 'own_2', ri.dealer_license_number, le.own_2_dealer_license_number);
	SELF.own_2_DRIVER_LICENSE_NUMBER := chooser(ri.rec_source, 'own_2', ri.drivers_license_number, le.own_2_DRIVER_LICENSE_NUMBER);
	SELF.own_2_dob := chooser(ri.rec_source, 'own_2', IF(ri.dob != '', ri.dob, ri.best_dob), le.own_2_dob);
	SELF.own_2_sex := chooser(ri.rec_source, 'own_2', ri.sex, le.own_2_sex);
	SELF.own_2_SEXUAL_PREDATOR_FLAG := chooser(ri.rec_source, 'own_2', ri.sexual_predator_flag , le.own_2_sexual_predator_flag);
	SELF.own_2_MAIL_SUPPESSION_FLAG := chooser(ri.rec_source, 'own_2', ri.mail_suppresion_flag , le.own_2_MAIL_SUPPESSION_FLAG);
	SELF.own_2_ADDR_NON_DISCLOSURE_FLAG := chooser(ri.rec_source, 'own_2', ri.ADDR_NON_DISCLOSURE_FLAG , le.own_2_ADDR_NON_DISCLOSURE_FLAG);
	SELF.own_2_LAW_ENFORCEMENT_FLAG := chooser(ri.rec_source, 'own_2', ri.LAW_ENFORCEMENT_FLAG , le.own_2_LAW_ENFORCEMENT_FLAG);
	SELF.own_2_ADDRESS_NUMBER := chooser(ri.rec_source, 'own_2', ri.ADDRESS_NUMBER , le.own_2_ADDRESS_NUMBER);
	SELF.own_2_FOREIGN_ADDRESS_FLAG := chooser(ri.rec_source, 'own_2', ri.FOREIGN_ADDRESS_FLAG , le.own_2_FOREIGN_ADDRESS_FLAG);
	SELF.own_2_STREET_ADDRESS := chooser(ri.rec_source, 'own_2', ri.orig_street_address, le.own_2_street_address);
	SELF.own_2_APARTMENT_NUMBER := chooser(ri.rec_source, 'own_2', ri.orig_apartment_number, le.own_2_apartment_number);
	SELF.own_2_CITY := chooser(ri.rec_source, 'own_2', ri.orig_addr_city, le.own_2_city);
	SELF.own_2_STATE := chooser(ri.rec_source, 'own_2', ri.orig_addr_state, le.own_2_state);
	SELF.own_2_ZIP5_ZIP4_FOREIGN_POSTAL := chooser(ri.rec_source, 'own_2', ri.zip5_zip4_foreign_postal, le.own_2_zip5_zip4_foreign_postal);
	SELF.own_2_RESIDENCE_COUNTY := chooser(ri.rec_source, 'own_2', ri.orig_residence_county , le.own_2_residence_county);
	
	SELF.own_2_title := chooser(ri.rec_source, 'own_2', ri.title, le.own_2_title);
	SELF.own_2_fname := chooser(ri.rec_source, 'own_2', ri.fname, le.own_2_fname);
	SELF.own_2_mname := chooser(ri.rec_source, 'own_2', ri.mname, le.own_2_mname);
	SELF.own_2_lname := chooser(ri.rec_source, 'own_2', ri.lname, le.own_2_lname);
	SELF.own_2_name_suffix := chooser(ri.rec_source, 'own_2', ri.name_suffix, le.own_2_name_suffix);
	SELF.own_2_did := chooser(ri.rec_source, 'own_2', (STRING)ri.did, le.own_2_did);
	SELF.own_2_ssn := chooser(ri.rec_source, 'own_2', ri.ssn, le.own_2_ssn);
	SELF.own_2_company_name := chooser(ri.rec_source, 'own_2', ri.company_name, le.own_2_company_name);
	SELF.own_2_prim_range := chooser(ri.rec_source, 'own_2', ri.prim_range , le.own_2_prim_range);
	SELF.own_2_predir := chooser(ri.rec_source, 'own_2', ri.predir , le.own_2_predir);
	SELF.own_2_prim_name := chooser(ri.rec_source, 'own_2', ri.prim_name , le.own_2_prim_name);
	SELF.own_2_suffix := chooser(ri.rec_source, 'own_2', ri.addr_suffix , le.own_2_suffix);
	SELF.own_2_postdir := chooser(ri.rec_source, 'own_2', ri.postdir , le.own_2_postdir);
	SELF.own_2_unit_desig := chooser(ri.rec_source, 'own_2', ri.unit_desig , le.own_2_unit_desig);
	SELF.own_2_sec_range := chooser(ri.rec_source, 'own_2', ri.sec_range , le.own_2_sec_range);
	SELF.own_2_p_city_name := chooser(ri.rec_source, 'own_2', ri.p_city_name , le.own_2_p_city_name);
	SELF.own_2_v_city_name := chooser(ri.rec_source, 'own_2', ri.v_city_name , le.own_2_v_city_name);
	SELF.own_2_state_2 := chooser(ri.rec_source, 'own_2', ri.st , le.own_2_state_2);
	SELF.own_2_zip5 := chooser(ri.rec_source, 'own_2', ri.zip5, le.own_2_zip5);
	SELF.own_2_zip4 := chooser(ri.rec_source, 'own_2', ri.zip4 , le.own_2_zip4);
	SELF.own_2_county := chooser(ri.rec_source, 'own_2', ri.county, le.own_2_county);
	SELF.own_2_county_name := chooser(ri.rec_source, 'own_2', ri.county_name, le.own_2_county_name);
	SELF.own_2_geo_lat := chooser(ri.rec_source, 'own_2', ri.geo_lat , le.own_2_geo_lat);
	SELF.own_2_geo_long := chooser(ri.rec_source, 'own_2', ri.geo_long , le.own_2_geo_long);
	
	/* ************************************* Registrant 1 ************************************* */
	SELF.REGISTRANT_1_CUSTOMER_TYPExBG5 := chooser(ri.rec_source, 'reg_1', ri.customer_type , le.REGISTRANT_1_customer_typexbg5);
	SELF.reg_1_CUSTOMER_NUMBER := chooser(ri.rec_source, 'reg_1', ri.customer_number , le.reg_1_customer_number);
	SELF.reg_1_FEID_SSN := chooser(ri.rec_source, 'reg_1', ri.feid_ssn, le.reg_1_feid_ssn);
	SELF.reg_1_CUSTOMER_NAME := chooser(ri.rec_source, 'reg_1', ri.orig_name, le.reg_1_customer_name);
	SELF.reg_1_DEALER_LICENSE_NUMBER := chooser(ri.rec_source, 'reg_1', ri.dealer_license_number, le.reg_1_dealer_license_number);
	SELF.reg_1_DRIVER_LICENSE_NUMBER := chooser(ri.rec_source, 'reg_1', ri.drivers_license_number, le.reg_1_DRIVER_LICENSE_NUMBER);
	SELF.reg_1_dob := chooser(ri.rec_source, 'reg_1', IF(ri.dob != '', ri.dob, ri.best_dob), le.reg_1_dob);
	SELF.reg_1_sex := chooser(ri.rec_source, 'reg_1', ri.sex, le.reg_1_sex);
	SELF.reg_1_SEXUAL_PREDATOR_FLAG := chooser(ri.rec_source, 'reg_1', ri.sexual_predator_flag , le.reg_1_sexual_predator_flag);
	SELF.reg_1_MAIL_SUPPESSION_FLAG := chooser(ri.rec_source, 'reg_1', ri.mail_suppresion_flag , le.reg_1_MAIL_SUPPESSION_FLAG);
	SELF.reg_1_ADDR_NON_DISCLOSURE_FLAG := chooser(ri.rec_source, 'reg_1', ri.ADDR_NON_DISCLOSURE_FLAG , le.reg_1_ADDR_NON_DISCLOSURE_FLAG);
	SELF.reg_1_LAW_ENFORCEMENT_FLAG := chooser(ri.rec_source, 'reg_1', ri.LAW_ENFORCEMENT_FLAG , le.reg_1_LAW_ENFORCEMENT_FLAG);
	SELF.reg_1_ADDRESS_NUMBER := chooser(ri.rec_source, 'reg_1', ri.ADDRESS_NUMBER , le.reg_1_ADDRESS_NUMBER);
	SELF.reg_1_FOREIGN_ADDRESS_FLAG := chooser(ri.rec_source, 'reg_1', ri.FOREIGN_ADDRESS_FLAG , le.reg_1_FOREIGN_ADDRESS_FLAG);
	SELF.reg_1_STREET_ADDRESS := chooser(ri.rec_source, 'reg_1', ri.orig_street_address, le.reg_1_street_address);
	SELF.reg_1_APARTMENT_NUMBER := chooser(ri.rec_source, 'reg_1', ri.orig_apartment_number, le.reg_1_apartment_number);
	SELF.reg_1_CITY := chooser(ri.rec_source, 'reg_1', ri.orig_addr_city, le.reg_1_city);
	SELF.reg_1_STATE := chooser(ri.rec_source, 'reg_1', ri.orig_addr_state, le.reg_1_state);
	SELF.reg_1_ZIP5_ZIP4_FOREIGN_POSTAL := chooser(ri.rec_source, 'reg_1', ri.zip5_zip4_foreign_postal, le.reg_1_zip5_zip4_foreign_postal);
	SELF.reg_1_RESIDENCE_COUNTY := chooser(ri.rec_source, 'reg_1', ri.orig_residence_county , le.reg_1_residence_county);
	
	SELF.reg_1_title := chooser(ri.rec_source, 'reg_1', ri.title, le.reg_1_title);
	SELF.reg_1_fname := chooser(ri.rec_source, 'reg_1', ri.fname, le.reg_1_fname);
	SELF.reg_1_mname := chooser(ri.rec_source, 'reg_1', ri.mname, le.reg_1_mname);
	SELF.reg_1_lname := chooser(ri.rec_source, 'reg_1', ri.lname, le.reg_1_lname);
	SELF.reg_1_name_suffix := chooser(ri.rec_source, 'reg_1', ri.name_suffix, le.reg_1_name_suffix);
	SELF.reg_1_did := chooser(ri.rec_source, 'reg_1', (STRING)ri.did, le.reg_1_did);
	SELF.reg_1_ssn := chooser(ri.rec_source, 'reg_1', ri.ssn, le.reg_1_ssn);
	SELF.reg_1_company_name := chooser(ri.rec_source, 'reg_1', ri.company_name, le.reg_1_company_name);
	SELF.reg_1_prim_range := chooser(ri.rec_source, 'reg_1', ri.prim_range , le.reg_1_prim_range);
	SELF.reg_1_predir := chooser(ri.rec_source, 'reg_1', ri.predir , le.reg_1_predir);
	SELF.reg_1_prim_name := chooser(ri.rec_source, 'reg_1', ri.prim_name , le.reg_1_prim_name);
	SELF.reg_1_suffix := chooser(ri.rec_source, 'reg_1', ri.addr_suffix , le.reg_1_suffix);
	SELF.reg_1_postdir := chooser(ri.rec_source, 'reg_1', ri.postdir , le.reg_1_postdir);
	SELF.reg_1_unit_desig := chooser(ri.rec_source, 'reg_1', ri.unit_desig , le.reg_1_unit_desig);
	SELF.reg_1_sec_range := chooser(ri.rec_source, 'reg_1', ri.sec_range , le.reg_1_sec_range);
	SELF.reg_1_p_city_name := chooser(ri.rec_source, 'reg_1', ri.p_city_name , le.reg_1_p_city_name);
	SELF.reg_1_v_city_name := chooser(ri.rec_source, 'reg_1', ri.v_city_name , le.reg_1_v_city_name);
	SELF.reg_1_state_2 := chooser(ri.rec_source, 'reg_1', ri.st , le.reg_1_state_2);
	SELF.reg_1_zip5 := chooser(ri.rec_source, 'reg_1', ri.zip5, le.reg_1_zip5);
	SELF.reg_1_zip4 := chooser(ri.rec_source, 'reg_1', ri.zip4 , le.reg_1_zip4);
	SELF.reg_1_county := chooser(ri.rec_source, 'reg_1', ri.county, le.reg_1_county);
	SELF.reg_1_county_name := chooser(ri.rec_source, 'reg_1', ri.county_name, le.reg_1_county_name);
	SELF.reg_1_geo_lat := chooser(ri.rec_source, 'reg_1', ri.geo_lat , le.reg_1_geo_lat);
	SELF.reg_1_geo_long := chooser(ri.rec_source, 'reg_1', ri.geo_long , le.reg_1_geo_long);
	
	/* ************************************* Registrant 2 ************************************* */
	SELF.REGISTRANT_2_CUSTOMER_TYPE := chooser(ri.rec_source, 'reg_2', ri.customer_type , le.REGISTRANT_2_customer_type);
	SELF.reg_2_CUSTOMER_NUMBER := chooser(ri.rec_source, 'reg_2', ri.customer_number , le.reg_2_customer_number);
	SELF.reg_2_FEID_SSN := chooser(ri.rec_source, 'reg_2', ri.feid_ssn, le.reg_2_feid_ssn);
	SELF.reg_2_CUSTOMER_NAME := chooser(ri.rec_source, 'reg_2', ri.orig_name, le.reg_2_customer_name);
	SELF.reg_2_DEALER_LICENSE_NUMBER := chooser(ri.rec_source, 'reg_2', ri.dealer_license_number, le.reg_2_dealer_license_number);
	SELF.reg_2_DRIVER_LICENSE_NUMBER := chooser(ri.rec_source, 'reg_2', ri.drivers_license_number, le.reg_2_DRIVER_LICENSE_NUMBER);
	SELF.reg_2_dob := chooser(ri.rec_source, 'reg_2', IF(ri.dob != '', ri.dob, ri.best_dob), le.reg_2_dob);
	SELF.reg_2_sex := chooser(ri.rec_source, 'reg_2', ri.sex, le.reg_2_sex);
	SELF.reg_2_SEXUAL_PREDATOR_FLAG := chooser(ri.rec_source, 'reg_2', ri.sexual_predator_flag , le.reg_2_sexual_predator_flag);
	SELF.reg_2_MAIL_SUPPESSION_FLAG := chooser(ri.rec_source, 'reg_2', ri.mail_suppresion_flag , le.reg_2_MAIL_SUPPESSION_FLAG);
	SELF.reg_2_ADDR_NON_DISCLOSURE_FLAG := chooser(ri.rec_source, 'reg_2', ri.ADDR_NON_DISCLOSURE_FLAG , le.reg_2_ADDR_NON_DISCLOSURE_FLAG);
	SELF.reg_2_LAW_ENFORCEMENT_FLAG := chooser(ri.rec_source, 'reg_2', ri.LAW_ENFORCEMENT_FLAG , le.reg_2_LAW_ENFORCEMENT_FLAG);
	SELF.reg_2_ADDRESS_NUMBER := chooser(ri.rec_source, 'reg_2', ri.ADDRESS_NUMBER , le.reg_2_ADDRESS_NUMBER);
	SELF.reg_2_FOREIGN_ADDRESS_FLAG := chooser(ri.rec_source, 'reg_2', ri.FOREIGN_ADDRESS_FLAG , le.reg_2_FOREIGN_ADDRESS_FLAG);
	SELF.reg_2_STREET_ADDRESS := chooser(ri.rec_source, 'reg_2', ri.orig_street_address, le.reg_2_street_address);
	SELF.reg_2_APARTMENT_NUMBER := chooser(ri.rec_source, 'reg_2', ri.orig_apartment_number, le.reg_2_apartment_number);
	SELF.reg_2_CITY := chooser(ri.rec_source, 'reg_2', ri.orig_addr_city, le.reg_2_city);
	SELF.reg_2_STATE := chooser(ri.rec_source, 'reg_2', ri.orig_addr_state, le.reg_2_state);
	SELF.reg_2_ZIP5_ZIP4_FOREIGN_POSTAL := chooser(ri.rec_source, 'reg_2', ri.zip5_zip4_foreign_postal, le.reg_2_zip5_zip4_foreign_postal);
	SELF.reg_2_RESIDENCE_COUNTY := chooser(ri.rec_source, 'reg_2', ri.orig_residence_county , le.reg_2_residence_county);
	
	SELF.reg_2_title := chooser(ri.rec_source, 'reg_2', ri.title, le.reg_2_title);
	SELF.reg_2_fname := chooser(ri.rec_source, 'reg_2', ri.fname, le.reg_2_fname);
	SELF.reg_2_mname := chooser(ri.rec_source, 'reg_2', ri.mname, le.reg_2_mname);
	SELF.reg_2_lname := chooser(ri.rec_source, 'reg_2', ri.lname, le.reg_2_lname);
	SELF.reg_2_name_suffix := chooser(ri.rec_source, 'reg_2', ri.name_suffix, le.reg_2_name_suffix);
	SELF.reg_2_did := chooser(ri.rec_source, 'reg_2', (STRING)ri.did, le.reg_2_did);
	SELF.reg_2_ssn := chooser(ri.rec_source, 'reg_2', ri.ssn, le.reg_2_ssn);
	SELF.reg_2_company_name := chooser(ri.rec_source, 'reg_2', ri.company_name, le.reg_2_company_name);
	SELF.reg_2_prim_range := chooser(ri.rec_source, 'reg_2', ri.prim_range , le.reg_2_prim_range);
	SELF.reg_2_predir := chooser(ri.rec_source, 'reg_2', ri.predir , le.reg_2_predir);
	SELF.reg_2_prim_name := chooser(ri.rec_source, 'reg_2', ri.prim_name , le.reg_2_prim_name);
	SELF.reg_2_suffix := chooser(ri.rec_source, 'reg_2', ri.addr_suffix , le.reg_2_suffix);
	SELF.reg_2_postdir := chooser(ri.rec_source, 'reg_2', ri.postdir , le.reg_2_postdir);
	SELF.reg_2_unit_desig := chooser(ri.rec_source, 'reg_2', ri.unit_desig , le.reg_2_unit_desig);
	SELF.reg_2_sec_range := chooser(ri.rec_source, 'reg_2', ri.sec_range , le.reg_2_sec_range);
	SELF.reg_2_p_city_name := chooser(ri.rec_source, 'reg_2', ri.p_city_name , le.reg_2_p_city_name);
	SELF.reg_2_v_city_name := chooser(ri.rec_source, 'reg_2', ri.v_city_name , le.reg_2_v_city_name);
	SELF.reg_2_state_2 := chooser(ri.rec_source, 'reg_2', ri.st , le.reg_2_state_2);
	SELF.reg_2_zip5 := chooser(ri.rec_source, 'reg_2', ri.zip5, le.reg_2_zip5);
	SELF.reg_2_zip4 := chooser(ri.rec_source, 'reg_2', ri.zip4 , le.reg_2_zip4);
	SELF.reg_2_county := chooser(ri.rec_source, 'reg_2', ri.county, le.reg_2_county);
	SELF.reg_2_county_name := chooser(ri.rec_source, 'reg_2', ri.county_name, le.reg_2_county_name);
	SELF.reg_2_geo_lat := chooser(ri.rec_source, 'reg_2', ri.geo_lat , le.reg_2_geo_lat);
	SELF.reg_2_geo_long := chooser(ri.rec_source, 'reg_2', ri.geo_long , le.reg_2_geo_long);
	
	
	/* ************************************* Lein Holders 2 ************************************* */
	SELF.LH_1_LIEN_DATE:= chooser(ri.rec_source, 'lien1', ri.LH_lein_date, le.LH_1_LIEN_DATE);
	SELF.LEIN_HOLDER_1_CUSTOMER_TYPE:= chooser(ri.rec_source, 'lien1', ri.CUSTOMER_TYPE, le.LEIN_HOLDER_1_CUSTOMER_TYPE);
	SELF.LH_1_CUSTOMER_NUMBER:= chooser(ri.rec_source, 'lien1', ri.CUSTOMER_NUMBER, le.LH_1_CUSTOMER_NUMBER);
	SELF.LH_1_FEID_SSN:= chooser(ri.rec_source, 'lien1', ri.FEID_SSN, le.LH_1_FEID_SSN);
	SELF.LH_1_CUSTOMER_NAME:= chooser(ri.rec_source, 'lien1', ri.orig_name, le.LH_1_CUSTOMER_NAME);
	SELF.LH_1_DEALER_LICENSE_NUMBER:= chooser(ri.rec_source, 'lien1', ri.DEALER_LICENSE_NUMBER, le.LH_1_DEALER_LICENSE_NUMBER);
	SELF.LH_1_DRIVER_LICENSE_NUMBER:= chooser(ri.rec_source, 'lien1', ri.drivers_LICENSE_NUMBER, le.LH_1_DRIVER_LICENSE_NUMBER);
	SELF.LH_1_DOB:= chooser(ri.rec_source, 'lien1', ri.DOB, le.LH_1_DOB);
	SELF.LH_1_SEX:= chooser(ri.rec_source, 'lien1', ri.SEX, le.LH_1_SEX);
	SELF.LH_1_SEXUAL_PREDATOR_FLAG:= chooser(ri.rec_source, 'lien1', ri.SEXUAL_PREDATOR_FLAG, le.LH_1_SEXUAL_PREDATOR_FLAG);
	SELF.LH_1_MAIL_SUPPESSION_FLAG:= chooser(ri.rec_source, 'lien1', ri.mail_suppresion_flag, le.LH_1_MAIL_SUPPESSION_FLAG);
	SELF.LH_1_ADDR_NON_DISCLOSURE_FLAG:= chooser(ri.rec_source, 'lien1', ri.ADDR_NON_DISCLOSURE_FLAG, le.LH_1_ADDR_NON_DISCLOSURE_FLAG);
	SELF.LH_1_LAW_ENFORCEMENT_FLAG:= chooser(ri.rec_source, 'lien1', ri.LAW_ENFORCEMENT_FLAG, le.LH_1_LAW_ENFORCEMENT_FLAG);
	SELF.LH_1_ADDRESS_NUMBER:= chooser(ri.rec_source, 'lien1', ri.ADDRESS_NUMBER, le.LH_1_ADDRESS_NUMBER);
	SELF.LH_1_FOREIGN_ADDRESS_FLAG:= chooser(ri.rec_source, 'lien1', ri.FOREIGN_ADDRESS_FLAG, le.LH_1_FOREIGN_ADDRESS_FLAG);
	SELF.LH_1_STREET_ADDRESS:= chooser(ri.rec_source, 'lien1', ri.orig_street_address, le.LH_1_STREET_ADDRESS);
	SELF.LH_1_APARTMENT_NUMBER:= chooser(ri.rec_source, 'lien1', ri.orig_apartment_number, le.LH_1_APARTMENT_NUMBER);
	SELF.LH_1_CITY:= chooser(ri.rec_source, 'lien1', ri.orig_addr_city, le.LH_1_CITY);
	SELF.LH_1_STATE:= chooser(ri.rec_source, 'lien1', ri.orig_addr_STATE, le.LH_1_STATE);
	SELF.LH_1_ZIP5_ZIP4_FOREIGN_POSTAL:= chooser(ri.rec_source, 'lien1', ri.ZIP5_ZIP4_FOREIGN_POSTAL, le.LH_1_ZIP5_ZIP4_FOREIGN_POSTAL);
	SELF.LH_1_RESIDENCE_COUNTY:= chooser(ri.rec_source, 'lien1', ri.orig_residence_county, le.LH_1_RESIDENCE_COUNTY);
	SELF.LH_2_LEIN_DATE:= chooser(ri.rec_source, 'lien2', ri.LH_lein_date, le.LH_2_LEIN_DATE);
	SELF.LEIN_HOLDER_2_CUSTOMER_TYPE:= chooser(ri.rec_source, 'lien2', ri.CUSTOMER_TYPE, le.LEIN_HOLDER_2_CUSTOMER_TYPE);
	SELF.LH_2_CUSTOMER_NUMBER:= chooser(ri.rec_source, 'lien2', ri.CUSTOMER_NUMBER, le.LH_2_CUSTOMER_NUMBER);
	SELF.LH_2_FEID_SSN:= chooser(ri.rec_source, 'lien2', ri.FEID_SSN, le.LH_2_FEID_SSN);
	SELF.LH_2_CUSTOMER_NAME:= chooser(ri.rec_source, 'lien2', ri.orig_name, le.LH_2_CUSTOMER_NAME);
	SELF.LH_2_DEALER_LICENSE_NUMBER:= chooser(ri.rec_source, 'lien2', ri.DEALER_LICENSE_NUMBER, le.LH_2_DEALER_LICENSE_NUMBER);
	SELF.LH_2_DRIVER_LICENSE_NUMBER:= chooser(ri.rec_source, 'lien2', ri.drivers_LICENSE_NUMBER, le.LH_2_DRIVER_LICENSE_NUMBER);
	SELF.LH_2_DOB:= chooser(ri.rec_source, 'lien2', ri.DOB, le.LH_2_DOB);
	SELF.LH_2_SEX:= chooser(ri.rec_source, 'lien2', ri.SEX, le.LH_2_SEX);
	SELF.LH_2_SEXUAL_PREDATOR_FLAG:= chooser(ri.rec_source, 'lien2', ri.SEXUAL_PREDATOR_FLAG, le.LH_2_SEXUAL_PREDATOR_FLAG);
	SELF.LH_2_MAIL_SUPPESSION_FLAG:= chooser(ri.rec_source, 'lien2', ri.mail_suppresion_flag, le.LH_2_MAIL_SUPPESSION_FLAG);
	SELF.LH_2_ADDR_NON_DISCLOSURE_FLAG:= chooser(ri.rec_source, 'lien2', ri.ADDR_NON_DISCLOSURE_FLAG, le.LH_2_ADDR_NON_DISCLOSURE_FLAG);
	SELF.LH_2_LAW_ENFORCEMENT_FLAG:= chooser(ri.rec_source, 'lien2', ri.LAW_ENFORCEMENT_FLAG, le.LH_2_LAW_ENFORCEMENT_FLAG);
	SELF.LH_2_ADDRESS_NUMBER:= chooser(ri.rec_source, 'lien2', ri.ADDRESS_NUMBER, le.LH_2_ADDRESS_NUMBER);
	SELF.LH_2_FOREIGN_ADDRESS_FLAG:= chooser(ri.rec_source, 'lien2', ri.FOREIGN_ADDRESS_FLAG, le.LH_2_FOREIGN_ADDRESS_FLAG);
	SELF.LH_2_STREET_ADDRESS:= chooser(ri.rec_source, 'lien2', ri.orig_street_address, le.LH_2_STREET_ADDRESS);
	SELF.LH_2_APARTMENT_NUMBER:= chooser(ri.rec_source, 'lien2', ri.orig_apartment_number, le.LH_2_APARTMENT_NUMBER);
	SELF.LH_2_CITY:= chooser(ri.rec_source, 'lien2', ri.orig_addr_CITY, le.LH_2_CITY);
	SELF.LH_2_STATE:= chooser(ri.rec_source, 'lien2', ri.orig_addr_STATE, le.LH_2_STATE);
	SELF.LH_2_ZIP5_ZIP4_FOREIGN_POSTAL:= chooser(ri.rec_source, 'lien2', ri.ZIP5_ZIP4_FOREIGN_POSTAL, le.LH_2_ZIP5_ZIP4_FOREIGN_POSTAL);
	SELF.LH_2_RESIDENCE_COUNTY:= chooser(ri.rec_source, 'lien2', ri.orig_residence_county, le.LH_2_RESIDENCE_COUNTY);
	SELF.LH_3_LIEN_DATE:= chooser(ri.rec_source, 'lien3', ri.LH_lein_date, le.LH_3_LIEN_DATE);
	SELF.LEIN_HOLDER_3_CUSTOMER_TYPE:= chooser(ri.rec_source, 'lien3', ri.CUSTOMER_TYPE, le.LEIN_HOLDER_3_CUSTOMER_TYPE);
	SELF.LH_3_CUSTOMER_NUMBER:= chooser(ri.rec_source, 'lien3', ri.CUSTOMER_NUMBER, le.LH_3_CUSTOMER_NUMBER);
	SELF.LH_3_FEID_SSN:= chooser(ri.rec_source, 'lien3', ri.FEID_SSN, le.LH_3_FEID_SSN);
	SELF.LH_3_CUSTOMER_NAME:= chooser(ri.rec_source, 'lien3', ri.orig_name, le.LH_3_CUSTOMER_NAME);
	SELF.LH_3_DEALER_LICENSE_NUMBER:= chooser(ri.rec_source, 'lien3', ri.DEALER_LICENSE_NUMBER, le.LH_3_DEALER_LICENSE_NUMBER);
	SELF.LH_3_DRIVER_LICENSE_NUMBER:= chooser(ri.rec_source, 'lien3', ri.drivers_LICENSE_NUMBER, le.LH_3_DRIVER_LICENSE_NUMBER);
	SELF.LH_3_DOB:= chooser(ri.rec_source, 'lien3', ri.DOB, le.LH_3_DOB);
	SELF.LH_3_SEX:= chooser(ri.rec_source, 'lien3', ri.SEX, le.LH_3_SEX);
	SELF.LH_3_SEXUAL_PREDATOR_FLAG:= chooser(ri.rec_source, 'lien3', ri.SEXUAL_PREDATOR_FLAG, le.LH_3_SEXUAL_PREDATOR_FLAG);
	SELF.LH_3_MAIL_SUPPESSION_FLAG:= chooser(ri.rec_source, 'lien3', ri.mail_suppresion_flag, le.LH_3_MAIL_SUPPESSION_FLAG);
	SELF.LH_3_ADDR_NON_DISCLOSURE_FLAG:= chooser(ri.rec_source, 'lien3', ri.ADDR_NON_DISCLOSURE_FLAG, le.LH_3_ADDR_NON_DISCLOSURE_FLAG);
	SELF.LH_3_LAW_ENFORCEMENT_FLAG:= chooser(ri.rec_source, 'lien3', ri.LAW_ENFORCEMENT_FLAG, le.LH_3_LAW_ENFORCEMENT_FLAG);
	SELF.LH_3_ADDRESS_NUMBER:= chooser(ri.rec_source, 'lien3', ri.ADDRESS_NUMBER, le.LH_3_ADDRESS_NUMBER);
	SELF.LH_3_FOREIGN_ADDRESS_FLAG:= chooser(ri.rec_source, 'lien3', ri.FOREIGN_ADDRESS_FLAG, le.LH_3_FOREIGN_ADDRESS_FLAG);
	SELF.LH_3_STREET_ADDRESS:= chooser(ri.rec_source, 'lien3', ri.orig_street_address, le.LH_3_STREET_ADDRESS);
	SELF.LH_3_APARTMENT_NUMBER:= chooser(ri.rec_source, 'lien3', ri.orig_apartment_number, le.LH_3_APARTMENT_NUMBER);
	SELF.LH_3_CITY:= chooser(ri.rec_source, 'lien3', ri.orig_addr_city, le.LH_3_CITY);
	SELF.LH_3_STATE:= chooser(ri.rec_source, 'lien3', ri.orig_addr_STATE, le.LH_3_STATE);
	SELF.LH_3_ZIP5_ZIP4_FOREIGN_POSTAL:= chooser(ri.rec_source, 'lien3', ri.ZIP5_ZIP4_FOREIGN_POSTAL, le.LH_3_ZIP5_ZIP4_FOREIGN_POSTAL);
	SELF.LH_3_RESIDENCE_COUNTY:= chooser(ri.rec_source, 'lien3', ri.orig_residence_county, le.LH_3_RESIDENCE_COUNTY);

	
	
	SELF := le;
END;