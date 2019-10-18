IMPORT SALT311,STD;
EXPORT Scrubs := MODULE
 
// The module to handle the case where no scrubs exist
  EXPORT NumRules := 134;
  EXPORT NumRulesFromFieldType := 134;
  EXPORT NumRulesFromRecordType := 0;
  EXPORT NumFieldsWithRules := 44;
  EXPORT NumFieldsWithPossibleEdits := 43;
  EXPORT NumRulesWithPossibleEdits := 133;
  EXPORT Expanded_Layout := RECORD(Layout_File)
    UNSIGNED1 lex_id_Invalid;
    UNSIGNED1 product_id_Invalid;
    BOOLEAN product_id_wouldClean;
    UNSIGNED1 inquiry_date_Invalid;
    BOOLEAN inquiry_date_wouldClean;
    UNSIGNED1 transaction_id_Invalid;
    BOOLEAN transaction_id_wouldClean;
    UNSIGNED1 date_added_Invalid;
    BOOLEAN date_added_wouldClean;
    UNSIGNED1 customer_number_Invalid;
    BOOLEAN customer_number_wouldClean;
    UNSIGNED1 customer_account_Invalid;
    BOOLEAN customer_account_wouldClean;
    UNSIGNED1 ssn_Invalid;
    BOOLEAN ssn_wouldClean;
    UNSIGNED1 drivers_license_number_Invalid;
    BOOLEAN drivers_license_number_wouldClean;
    UNSIGNED1 drivers_license_state_Invalid;
    BOOLEAN drivers_license_state_wouldClean;
    UNSIGNED1 name_first_Invalid;
    BOOLEAN name_first_wouldClean;
    UNSIGNED1 name_last_Invalid;
    BOOLEAN name_last_wouldClean;
    UNSIGNED1 name_middle_Invalid;
    BOOLEAN name_middle_wouldClean;
    UNSIGNED1 name_suffix_Invalid;
    BOOLEAN name_suffix_wouldClean;
    UNSIGNED1 addr_street_Invalid;
    BOOLEAN addr_street_wouldClean;
    UNSIGNED1 addr_city_Invalid;
    BOOLEAN addr_city_wouldClean;
    UNSIGNED1 addr_state_Invalid;
    BOOLEAN addr_state_wouldClean;
    UNSIGNED1 addr_zip5_Invalid;
    BOOLEAN addr_zip5_wouldClean;
    UNSIGNED1 addr_zip4_Invalid;
    BOOLEAN addr_zip4_wouldClean;
    UNSIGNED1 dob_Invalid;
    BOOLEAN dob_wouldClean;
    UNSIGNED1 transaction_location_Invalid;
    BOOLEAN transaction_location_wouldClean;
    UNSIGNED1 ppc_Invalid;
    BOOLEAN ppc_wouldClean;
    UNSIGNED1 internal_identifier_Invalid;
    BOOLEAN internal_identifier_wouldClean;
    UNSIGNED1 eu1_customer_number_Invalid;
    BOOLEAN eu1_customer_number_wouldClean;
    UNSIGNED1 eu1_customer_account_Invalid;
    BOOLEAN eu1_customer_account_wouldClean;
    UNSIGNED1 eu2_customer_number_Invalid;
    BOOLEAN eu2_customer_number_wouldClean;
    UNSIGNED1 eu2_customer_account_Invalid;
    BOOLEAN eu2_customer_account_wouldClean;
    UNSIGNED1 email_addr_Invalid;
    BOOLEAN email_addr_wouldClean;
    UNSIGNED1 ip_address_Invalid;
    BOOLEAN ip_address_wouldClean;
    UNSIGNED1 state_id_number_Invalid;
    BOOLEAN state_id_number_wouldClean;
    UNSIGNED1 state_id_state_Invalid;
    BOOLEAN state_id_state_wouldClean;
    UNSIGNED1 eu_company_name_Invalid;
    BOOLEAN eu_company_name_wouldClean;
    UNSIGNED1 eu_addr_street_Invalid;
    BOOLEAN eu_addr_street_wouldClean;
    UNSIGNED1 eu_addr_city_Invalid;
    BOOLEAN eu_addr_city_wouldClean;
    UNSIGNED1 eu_addr_state_Invalid;
    BOOLEAN eu_addr_state_wouldClean;
    UNSIGNED1 eu_addr_zip5_Invalid;
    BOOLEAN eu_addr_zip5_wouldClean;
    UNSIGNED1 eu_phone_nbr_Invalid;
    BOOLEAN eu_phone_nbr_wouldClean;
    UNSIGNED1 product_code_Invalid;
    BOOLEAN product_code_wouldClean;
    UNSIGNED1 transaction_type_Invalid;
    BOOLEAN transaction_type_wouldClean;
    UNSIGNED1 function_name_Invalid;
    BOOLEAN function_name_wouldClean;
    UNSIGNED1 customer_id_Invalid;
    BOOLEAN customer_id_wouldClean;
    UNSIGNED1 company_id_Invalid;
    BOOLEAN company_id_wouldClean;
    UNSIGNED1 global_company_id_Invalid;
    BOOLEAN global_company_id_wouldClean;
    UNSIGNED1 phone_nbr_Invalid;
    BOOLEAN phone_nbr_wouldClean;
  END;
  EXPORT  Bitmap_Layout := RECORD(Layout_File)
    UNSIGNED8 ScrubsBits1;
    UNSIGNED8 ScrubsBits2;
    UNSIGNED8 ScrubsCleanBits1;
  END;
EXPORT FromNone(DATASET(Layout_File) h) := MODULE
  SHARED Expanded_Layout toExpanded(h le, BOOLEAN withOnfail) := TRANSFORM
    SELF.lex_id_Invalid := Fields.InValid_lex_id((SALT311.StrType)le.lex_id);
    SELF.product_id_Invalid := Fields.InValid_product_id((SALT311.StrType)le.product_id);
    clean_product_id := (TYPEOF(le.product_id))Fields.Make_product_id((SALT311.StrType)le.product_id);
    clean_product_id_Invalid := Fields.InValid_product_id((SALT311.StrType)clean_product_id);
    SELF.product_id := IF(withOnfail, clean_product_id, le.product_id); // ONFAIL(CLEAN)
    SELF.product_id_wouldClean := TRIM((SALT311.StrType)le.product_id) <> TRIM((SALT311.StrType)clean_product_id);
    SELF.inquiry_date_Invalid := Fields.InValid_inquiry_date((SALT311.StrType)le.inquiry_date);
    clean_inquiry_date := (TYPEOF(le.inquiry_date))Fields.Make_inquiry_date((SALT311.StrType)le.inquiry_date);
    clean_inquiry_date_Invalid := Fields.InValid_inquiry_date((SALT311.StrType)clean_inquiry_date);
    SELF.inquiry_date := IF(withOnfail, clean_inquiry_date, le.inquiry_date); // ONFAIL(CLEAN)
    SELF.inquiry_date_wouldClean := TRIM((SALT311.StrType)le.inquiry_date) <> TRIM((SALT311.StrType)clean_inquiry_date);
    SELF.transaction_id_Invalid := Fields.InValid_transaction_id((SALT311.StrType)le.transaction_id);
    clean_transaction_id := (TYPEOF(le.transaction_id))Fields.Make_transaction_id((SALT311.StrType)le.transaction_id);
    clean_transaction_id_Invalid := Fields.InValid_transaction_id((SALT311.StrType)clean_transaction_id);
    SELF.transaction_id := IF(withOnfail, clean_transaction_id, le.transaction_id); // ONFAIL(CLEAN)
    SELF.transaction_id_wouldClean := TRIM((SALT311.StrType)le.transaction_id) <> TRIM((SALT311.StrType)clean_transaction_id);
    SELF.date_added_Invalid := Fields.InValid_date_added((SALT311.StrType)le.date_added);
    clean_date_added := (TYPEOF(le.date_added))Fields.Make_date_added((SALT311.StrType)le.date_added);
    clean_date_added_Invalid := Fields.InValid_date_added((SALT311.StrType)clean_date_added);
    SELF.date_added := IF(withOnfail, clean_date_added, le.date_added); // ONFAIL(CLEAN)
    SELF.date_added_wouldClean := TRIM((SALT311.StrType)le.date_added) <> TRIM((SALT311.StrType)clean_date_added);
    SELF.customer_number_Invalid := Fields.InValid_customer_number((SALT311.StrType)le.customer_number);
    clean_customer_number := (TYPEOF(le.customer_number))Fields.Make_customer_number((SALT311.StrType)le.customer_number);
    clean_customer_number_Invalid := Fields.InValid_customer_number((SALT311.StrType)clean_customer_number);
    SELF.customer_number := IF(withOnfail, clean_customer_number, le.customer_number); // ONFAIL(CLEAN)
    SELF.customer_number_wouldClean := TRIM((SALT311.StrType)le.customer_number) <> TRIM((SALT311.StrType)clean_customer_number);
    SELF.customer_account_Invalid := Fields.InValid_customer_account((SALT311.StrType)le.customer_account);
    clean_customer_account := (TYPEOF(le.customer_account))Fields.Make_customer_account((SALT311.StrType)le.customer_account);
    clean_customer_account_Invalid := Fields.InValid_customer_account((SALT311.StrType)clean_customer_account);
    SELF.customer_account := IF(withOnfail, clean_customer_account, le.customer_account); // ONFAIL(CLEAN)
    SELF.customer_account_wouldClean := TRIM((SALT311.StrType)le.customer_account) <> TRIM((SALT311.StrType)clean_customer_account);
    SELF.ssn_Invalid := Fields.InValid_ssn((SALT311.StrType)le.ssn);
    clean_ssn := (TYPEOF(le.ssn))Fields.Make_ssn((SALT311.StrType)le.ssn);
    clean_ssn_Invalid := Fields.InValid_ssn((SALT311.StrType)clean_ssn);
    SELF.ssn := IF(withOnfail, clean_ssn, le.ssn); // ONFAIL(CLEAN)
    SELF.ssn_wouldClean := TRIM((SALT311.StrType)le.ssn) <> TRIM((SALT311.StrType)clean_ssn);
    SELF.drivers_license_number_Invalid := Fields.InValid_drivers_license_number((SALT311.StrType)le.drivers_license_number);
    clean_drivers_license_number := (TYPEOF(le.drivers_license_number))Fields.Make_drivers_license_number((SALT311.StrType)le.drivers_license_number);
    clean_drivers_license_number_Invalid := Fields.InValid_drivers_license_number((SALT311.StrType)clean_drivers_license_number);
    SELF.drivers_license_number := IF(withOnfail, clean_drivers_license_number, le.drivers_license_number); // ONFAIL(CLEAN)
    SELF.drivers_license_number_wouldClean := TRIM((SALT311.StrType)le.drivers_license_number) <> TRIM((SALT311.StrType)clean_drivers_license_number);
    SELF.drivers_license_state_Invalid := Fields.InValid_drivers_license_state((SALT311.StrType)le.drivers_license_state);
    clean_drivers_license_state := (TYPEOF(le.drivers_license_state))Fields.Make_drivers_license_state((SALT311.StrType)le.drivers_license_state);
    clean_drivers_license_state_Invalid := Fields.InValid_drivers_license_state((SALT311.StrType)clean_drivers_license_state);
    SELF.drivers_license_state := IF(withOnfail, clean_drivers_license_state, le.drivers_license_state); // ONFAIL(CLEAN)
    SELF.drivers_license_state_wouldClean := TRIM((SALT311.StrType)le.drivers_license_state) <> TRIM((SALT311.StrType)clean_drivers_license_state);
    SELF.name_first_Invalid := Fields.InValid_name_first((SALT311.StrType)le.name_first);
    clean_name_first := (TYPEOF(le.name_first))Fields.Make_name_first((SALT311.StrType)le.name_first);
    clean_name_first_Invalid := Fields.InValid_name_first((SALT311.StrType)clean_name_first);
    SELF.name_first := IF(withOnfail, clean_name_first, le.name_first); // ONFAIL(CLEAN)
    SELF.name_first_wouldClean := TRIM((SALT311.StrType)le.name_first) <> TRIM((SALT311.StrType)clean_name_first);
    SELF.name_last_Invalid := Fields.InValid_name_last((SALT311.StrType)le.name_last);
    clean_name_last := (TYPEOF(le.name_last))Fields.Make_name_last((SALT311.StrType)le.name_last);
    clean_name_last_Invalid := Fields.InValid_name_last((SALT311.StrType)clean_name_last);
    SELF.name_last := IF(withOnfail, clean_name_last, le.name_last); // ONFAIL(CLEAN)
    SELF.name_last_wouldClean := TRIM((SALT311.StrType)le.name_last) <> TRIM((SALT311.StrType)clean_name_last);
    SELF.name_middle_Invalid := Fields.InValid_name_middle((SALT311.StrType)le.name_middle);
    clean_name_middle := (TYPEOF(le.name_middle))Fields.Make_name_middle((SALT311.StrType)le.name_middle);
    clean_name_middle_Invalid := Fields.InValid_name_middle((SALT311.StrType)clean_name_middle);
    SELF.name_middle := IF(withOnfail, clean_name_middle, le.name_middle); // ONFAIL(CLEAN)
    SELF.name_middle_wouldClean := TRIM((SALT311.StrType)le.name_middle) <> TRIM((SALT311.StrType)clean_name_middle);
    SELF.name_suffix_Invalid := Fields.InValid_name_suffix((SALT311.StrType)le.name_suffix);
    clean_name_suffix := (TYPEOF(le.name_suffix))Fields.Make_name_suffix((SALT311.StrType)le.name_suffix);
    clean_name_suffix_Invalid := Fields.InValid_name_suffix((SALT311.StrType)clean_name_suffix);
    SELF.name_suffix := IF(withOnfail, clean_name_suffix, le.name_suffix); // ONFAIL(CLEAN)
    SELF.name_suffix_wouldClean := TRIM((SALT311.StrType)le.name_suffix) <> TRIM((SALT311.StrType)clean_name_suffix);
    SELF.addr_street_Invalid := Fields.InValid_addr_street((SALT311.StrType)le.addr_street);
    clean_addr_street := (TYPEOF(le.addr_street))Fields.Make_addr_street((SALT311.StrType)le.addr_street);
    clean_addr_street_Invalid := Fields.InValid_addr_street((SALT311.StrType)clean_addr_street);
    SELF.addr_street := IF(withOnfail, clean_addr_street, le.addr_street); // ONFAIL(CLEAN)
    SELF.addr_street_wouldClean := TRIM((SALT311.StrType)le.addr_street) <> TRIM((SALT311.StrType)clean_addr_street);
    SELF.addr_city_Invalid := Fields.InValid_addr_city((SALT311.StrType)le.addr_city);
    clean_addr_city := (TYPEOF(le.addr_city))Fields.Make_addr_city((SALT311.StrType)le.addr_city);
    clean_addr_city_Invalid := Fields.InValid_addr_city((SALT311.StrType)clean_addr_city);
    SELF.addr_city := IF(withOnfail, clean_addr_city, le.addr_city); // ONFAIL(CLEAN)
    SELF.addr_city_wouldClean := TRIM((SALT311.StrType)le.addr_city) <> TRIM((SALT311.StrType)clean_addr_city);
    SELF.addr_state_Invalid := Fields.InValid_addr_state((SALT311.StrType)le.addr_state);
    clean_addr_state := (TYPEOF(le.addr_state))Fields.Make_addr_state((SALT311.StrType)le.addr_state);
    clean_addr_state_Invalid := Fields.InValid_addr_state((SALT311.StrType)clean_addr_state);
    SELF.addr_state := IF(withOnfail, clean_addr_state, le.addr_state); // ONFAIL(CLEAN)
    SELF.addr_state_wouldClean := TRIM((SALT311.StrType)le.addr_state) <> TRIM((SALT311.StrType)clean_addr_state);
    SELF.addr_zip5_Invalid := Fields.InValid_addr_zip5((SALT311.StrType)le.addr_zip5);
    clean_addr_zip5 := (TYPEOF(le.addr_zip5))Fields.Make_addr_zip5((SALT311.StrType)le.addr_zip5);
    clean_addr_zip5_Invalid := Fields.InValid_addr_zip5((SALT311.StrType)clean_addr_zip5);
    SELF.addr_zip5 := IF(withOnfail, clean_addr_zip5, le.addr_zip5); // ONFAIL(CLEAN)
    SELF.addr_zip5_wouldClean := TRIM((SALT311.StrType)le.addr_zip5) <> TRIM((SALT311.StrType)clean_addr_zip5);
    SELF.addr_zip4_Invalid := Fields.InValid_addr_zip4((SALT311.StrType)le.addr_zip4);
    clean_addr_zip4 := (TYPEOF(le.addr_zip4))Fields.Make_addr_zip4((SALT311.StrType)le.addr_zip4);
    clean_addr_zip4_Invalid := Fields.InValid_addr_zip4((SALT311.StrType)clean_addr_zip4);
    SELF.addr_zip4 := IF(withOnfail, clean_addr_zip4, le.addr_zip4); // ONFAIL(CLEAN)
    SELF.addr_zip4_wouldClean := TRIM((SALT311.StrType)le.addr_zip4) <> TRIM((SALT311.StrType)clean_addr_zip4);
    SELF.dob_Invalid := Fields.InValid_dob((SALT311.StrType)le.dob);
    clean_dob := (TYPEOF(le.dob))Fields.Make_dob((SALT311.StrType)le.dob);
    clean_dob_Invalid := Fields.InValid_dob((SALT311.StrType)clean_dob);
    SELF.dob := IF(withOnfail, clean_dob, le.dob); // ONFAIL(CLEAN)
    SELF.dob_wouldClean := TRIM((SALT311.StrType)le.dob) <> TRIM((SALT311.StrType)clean_dob);
    SELF.transaction_location_Invalid := Fields.InValid_transaction_location((SALT311.StrType)le.transaction_location);
    clean_transaction_location := (TYPEOF(le.transaction_location))Fields.Make_transaction_location((SALT311.StrType)le.transaction_location);
    clean_transaction_location_Invalid := Fields.InValid_transaction_location((SALT311.StrType)clean_transaction_location);
    SELF.transaction_location := IF(withOnfail, clean_transaction_location, le.transaction_location); // ONFAIL(CLEAN)
    SELF.transaction_location_wouldClean := TRIM((SALT311.StrType)le.transaction_location) <> TRIM((SALT311.StrType)clean_transaction_location);
    SELF.ppc_Invalid := Fields.InValid_ppc((SALT311.StrType)le.ppc);
    clean_ppc := (TYPEOF(le.ppc))Fields.Make_ppc((SALT311.StrType)le.ppc);
    clean_ppc_Invalid := Fields.InValid_ppc((SALT311.StrType)clean_ppc);
    SELF.ppc := IF(withOnfail, clean_ppc, le.ppc); // ONFAIL(CLEAN)
    SELF.ppc_wouldClean := TRIM((SALT311.StrType)le.ppc) <> TRIM((SALT311.StrType)clean_ppc);
    SELF.internal_identifier_Invalid := Fields.InValid_internal_identifier((SALT311.StrType)le.internal_identifier);
    clean_internal_identifier := (TYPEOF(le.internal_identifier))Fields.Make_internal_identifier((SALT311.StrType)le.internal_identifier);
    clean_internal_identifier_Invalid := Fields.InValid_internal_identifier((SALT311.StrType)clean_internal_identifier);
    SELF.internal_identifier := IF(withOnfail, clean_internal_identifier, le.internal_identifier); // ONFAIL(CLEAN)
    SELF.internal_identifier_wouldClean := TRIM((SALT311.StrType)le.internal_identifier) <> TRIM((SALT311.StrType)clean_internal_identifier);
    SELF.eu1_customer_number_Invalid := Fields.InValid_eu1_customer_number((SALT311.StrType)le.eu1_customer_number);
    clean_eu1_customer_number := (TYPEOF(le.eu1_customer_number))Fields.Make_eu1_customer_number((SALT311.StrType)le.eu1_customer_number);
    clean_eu1_customer_number_Invalid := Fields.InValid_eu1_customer_number((SALT311.StrType)clean_eu1_customer_number);
    SELF.eu1_customer_number := IF(withOnfail, clean_eu1_customer_number, le.eu1_customer_number); // ONFAIL(CLEAN)
    SELF.eu1_customer_number_wouldClean := TRIM((SALT311.StrType)le.eu1_customer_number) <> TRIM((SALT311.StrType)clean_eu1_customer_number);
    SELF.eu1_customer_account_Invalid := Fields.InValid_eu1_customer_account((SALT311.StrType)le.eu1_customer_account);
    clean_eu1_customer_account := (TYPEOF(le.eu1_customer_account))Fields.Make_eu1_customer_account((SALT311.StrType)le.eu1_customer_account);
    clean_eu1_customer_account_Invalid := Fields.InValid_eu1_customer_account((SALT311.StrType)clean_eu1_customer_account);
    SELF.eu1_customer_account := IF(withOnfail, clean_eu1_customer_account, le.eu1_customer_account); // ONFAIL(CLEAN)
    SELF.eu1_customer_account_wouldClean := TRIM((SALT311.StrType)le.eu1_customer_account) <> TRIM((SALT311.StrType)clean_eu1_customer_account);
    SELF.eu2_customer_number_Invalid := Fields.InValid_eu2_customer_number((SALT311.StrType)le.eu2_customer_number);
    clean_eu2_customer_number := (TYPEOF(le.eu2_customer_number))Fields.Make_eu2_customer_number((SALT311.StrType)le.eu2_customer_number);
    clean_eu2_customer_number_Invalid := Fields.InValid_eu2_customer_number((SALT311.StrType)clean_eu2_customer_number);
    SELF.eu2_customer_number := IF(withOnfail, clean_eu2_customer_number, le.eu2_customer_number); // ONFAIL(CLEAN)
    SELF.eu2_customer_number_wouldClean := TRIM((SALT311.StrType)le.eu2_customer_number) <> TRIM((SALT311.StrType)clean_eu2_customer_number);
    SELF.eu2_customer_account_Invalid := Fields.InValid_eu2_customer_account((SALT311.StrType)le.eu2_customer_account);
    clean_eu2_customer_account := (TYPEOF(le.eu2_customer_account))Fields.Make_eu2_customer_account((SALT311.StrType)le.eu2_customer_account);
    clean_eu2_customer_account_Invalid := Fields.InValid_eu2_customer_account((SALT311.StrType)clean_eu2_customer_account);
    SELF.eu2_customer_account := IF(withOnfail, clean_eu2_customer_account, le.eu2_customer_account); // ONFAIL(CLEAN)
    SELF.eu2_customer_account_wouldClean := TRIM((SALT311.StrType)le.eu2_customer_account) <> TRIM((SALT311.StrType)clean_eu2_customer_account);
    SELF.email_addr_Invalid := Fields.InValid_email_addr((SALT311.StrType)le.email_addr);
    clean_email_addr := (TYPEOF(le.email_addr))Fields.Make_email_addr((SALT311.StrType)le.email_addr);
    clean_email_addr_Invalid := Fields.InValid_email_addr((SALT311.StrType)clean_email_addr);
    SELF.email_addr := IF(withOnfail, clean_email_addr, le.email_addr); // ONFAIL(CLEAN)
    SELF.email_addr_wouldClean := TRIM((SALT311.StrType)le.email_addr) <> TRIM((SALT311.StrType)clean_email_addr);
    SELF.ip_address_Invalid := Fields.InValid_ip_address((SALT311.StrType)le.ip_address);
    clean_ip_address := (TYPEOF(le.ip_address))Fields.Make_ip_address((SALT311.StrType)le.ip_address);
    clean_ip_address_Invalid := Fields.InValid_ip_address((SALT311.StrType)clean_ip_address);
    SELF.ip_address := IF(withOnfail, clean_ip_address, le.ip_address); // ONFAIL(CLEAN)
    SELF.ip_address_wouldClean := TRIM((SALT311.StrType)le.ip_address) <> TRIM((SALT311.StrType)clean_ip_address);
    SELF.state_id_number_Invalid := Fields.InValid_state_id_number((SALT311.StrType)le.state_id_number);
    clean_state_id_number := (TYPEOF(le.state_id_number))Fields.Make_state_id_number((SALT311.StrType)le.state_id_number);
    clean_state_id_number_Invalid := Fields.InValid_state_id_number((SALT311.StrType)clean_state_id_number);
    SELF.state_id_number := IF(withOnfail, clean_state_id_number, le.state_id_number); // ONFAIL(CLEAN)
    SELF.state_id_number_wouldClean := TRIM((SALT311.StrType)le.state_id_number) <> TRIM((SALT311.StrType)clean_state_id_number);
    SELF.state_id_state_Invalid := Fields.InValid_state_id_state((SALT311.StrType)le.state_id_state);
    clean_state_id_state := (TYPEOF(le.state_id_state))Fields.Make_state_id_state((SALT311.StrType)le.state_id_state);
    clean_state_id_state_Invalid := Fields.InValid_state_id_state((SALT311.StrType)clean_state_id_state);
    SELF.state_id_state := IF(withOnfail, clean_state_id_state, le.state_id_state); // ONFAIL(CLEAN)
    SELF.state_id_state_wouldClean := TRIM((SALT311.StrType)le.state_id_state) <> TRIM((SALT311.StrType)clean_state_id_state);
    SELF.eu_company_name_Invalid := Fields.InValid_eu_company_name((SALT311.StrType)le.eu_company_name);
    clean_eu_company_name := (TYPEOF(le.eu_company_name))Fields.Make_eu_company_name((SALT311.StrType)le.eu_company_name);
    clean_eu_company_name_Invalid := Fields.InValid_eu_company_name((SALT311.StrType)clean_eu_company_name);
    SELF.eu_company_name := IF(withOnfail, clean_eu_company_name, le.eu_company_name); // ONFAIL(CLEAN)
    SELF.eu_company_name_wouldClean := TRIM((SALT311.StrType)le.eu_company_name) <> TRIM((SALT311.StrType)clean_eu_company_name);
    SELF.eu_addr_street_Invalid := Fields.InValid_eu_addr_street((SALT311.StrType)le.eu_addr_street);
    clean_eu_addr_street := (TYPEOF(le.eu_addr_street))Fields.Make_eu_addr_street((SALT311.StrType)le.eu_addr_street);
    clean_eu_addr_street_Invalid := Fields.InValid_eu_addr_street((SALT311.StrType)clean_eu_addr_street);
    SELF.eu_addr_street := IF(withOnfail, clean_eu_addr_street, le.eu_addr_street); // ONFAIL(CLEAN)
    SELF.eu_addr_street_wouldClean := TRIM((SALT311.StrType)le.eu_addr_street) <> TRIM((SALT311.StrType)clean_eu_addr_street);
    SELF.eu_addr_city_Invalid := Fields.InValid_eu_addr_city((SALT311.StrType)le.eu_addr_city);
    clean_eu_addr_city := (TYPEOF(le.eu_addr_city))Fields.Make_eu_addr_city((SALT311.StrType)le.eu_addr_city);
    clean_eu_addr_city_Invalid := Fields.InValid_eu_addr_city((SALT311.StrType)clean_eu_addr_city);
    SELF.eu_addr_city := IF(withOnfail, clean_eu_addr_city, le.eu_addr_city); // ONFAIL(CLEAN)
    SELF.eu_addr_city_wouldClean := TRIM((SALT311.StrType)le.eu_addr_city) <> TRIM((SALT311.StrType)clean_eu_addr_city);
    SELF.eu_addr_state_Invalid := Fields.InValid_eu_addr_state((SALT311.StrType)le.eu_addr_state);
    clean_eu_addr_state := (TYPEOF(le.eu_addr_state))Fields.Make_eu_addr_state((SALT311.StrType)le.eu_addr_state);
    clean_eu_addr_state_Invalid := Fields.InValid_eu_addr_state((SALT311.StrType)clean_eu_addr_state);
    SELF.eu_addr_state := IF(withOnfail, clean_eu_addr_state, le.eu_addr_state); // ONFAIL(CLEAN)
    SELF.eu_addr_state_wouldClean := TRIM((SALT311.StrType)le.eu_addr_state) <> TRIM((SALT311.StrType)clean_eu_addr_state);
    SELF.eu_addr_zip5_Invalid := Fields.InValid_eu_addr_zip5((SALT311.StrType)le.eu_addr_zip5);
    clean_eu_addr_zip5 := (TYPEOF(le.eu_addr_zip5))Fields.Make_eu_addr_zip5((SALT311.StrType)le.eu_addr_zip5);
    clean_eu_addr_zip5_Invalid := Fields.InValid_eu_addr_zip5((SALT311.StrType)clean_eu_addr_zip5);
    SELF.eu_addr_zip5 := IF(withOnfail, clean_eu_addr_zip5, le.eu_addr_zip5); // ONFAIL(CLEAN)
    SELF.eu_addr_zip5_wouldClean := TRIM((SALT311.StrType)le.eu_addr_zip5) <> TRIM((SALT311.StrType)clean_eu_addr_zip5);
    SELF.eu_phone_nbr_Invalid := Fields.InValid_eu_phone_nbr((SALT311.StrType)le.eu_phone_nbr);
    clean_eu_phone_nbr := (TYPEOF(le.eu_phone_nbr))Fields.Make_eu_phone_nbr((SALT311.StrType)le.eu_phone_nbr);
    clean_eu_phone_nbr_Invalid := Fields.InValid_eu_phone_nbr((SALT311.StrType)clean_eu_phone_nbr);
    SELF.eu_phone_nbr := IF(withOnfail, clean_eu_phone_nbr, le.eu_phone_nbr); // ONFAIL(CLEAN)
    SELF.eu_phone_nbr_wouldClean := TRIM((SALT311.StrType)le.eu_phone_nbr) <> TRIM((SALT311.StrType)clean_eu_phone_nbr);
    SELF.product_code_Invalid := Fields.InValid_product_code((SALT311.StrType)le.product_code);
    clean_product_code := (TYPEOF(le.product_code))Fields.Make_product_code((SALT311.StrType)le.product_code);
    clean_product_code_Invalid := Fields.InValid_product_code((SALT311.StrType)clean_product_code);
    SELF.product_code := IF(withOnfail, clean_product_code, le.product_code); // ONFAIL(CLEAN)
    SELF.product_code_wouldClean := TRIM((SALT311.StrType)le.product_code) <> TRIM((SALT311.StrType)clean_product_code);
    SELF.transaction_type_Invalid := Fields.InValid_transaction_type((SALT311.StrType)le.transaction_type);
    clean_transaction_type := (TYPEOF(le.transaction_type))Fields.Make_transaction_type((SALT311.StrType)le.transaction_type);
    clean_transaction_type_Invalid := Fields.InValid_transaction_type((SALT311.StrType)clean_transaction_type);
    SELF.transaction_type := IF(withOnfail, clean_transaction_type, le.transaction_type); // ONFAIL(CLEAN)
    SELF.transaction_type_wouldClean := TRIM((SALT311.StrType)le.transaction_type) <> TRIM((SALT311.StrType)clean_transaction_type);
    SELF.function_name_Invalid := Fields.InValid_function_name((SALT311.StrType)le.function_name);
    clean_function_name := (TYPEOF(le.function_name))Fields.Make_function_name((SALT311.StrType)le.function_name);
    clean_function_name_Invalid := Fields.InValid_function_name((SALT311.StrType)clean_function_name);
    SELF.function_name := IF(withOnfail, clean_function_name, le.function_name); // ONFAIL(CLEAN)
    SELF.function_name_wouldClean := TRIM((SALT311.StrType)le.function_name) <> TRIM((SALT311.StrType)clean_function_name);
    SELF.customer_id_Invalid := Fields.InValid_customer_id((SALT311.StrType)le.customer_id);
    clean_customer_id := (TYPEOF(le.customer_id))Fields.Make_customer_id((SALT311.StrType)le.customer_id);
    clean_customer_id_Invalid := Fields.InValid_customer_id((SALT311.StrType)clean_customer_id);
    SELF.customer_id := IF(withOnfail, clean_customer_id, le.customer_id); // ONFAIL(CLEAN)
    SELF.customer_id_wouldClean := TRIM((SALT311.StrType)le.customer_id) <> TRIM((SALT311.StrType)clean_customer_id);
    SELF.company_id_Invalid := Fields.InValid_company_id((SALT311.StrType)le.company_id);
    clean_company_id := (TYPEOF(le.company_id))Fields.Make_company_id((SALT311.StrType)le.company_id);
    clean_company_id_Invalid := Fields.InValid_company_id((SALT311.StrType)clean_company_id);
    SELF.company_id := IF(withOnfail, clean_company_id, le.company_id); // ONFAIL(CLEAN)
    SELF.company_id_wouldClean := TRIM((SALT311.StrType)le.company_id) <> TRIM((SALT311.StrType)clean_company_id);
    SELF.global_company_id_Invalid := Fields.InValid_global_company_id((SALT311.StrType)le.global_company_id);
    clean_global_company_id := (TYPEOF(le.global_company_id))Fields.Make_global_company_id((SALT311.StrType)le.global_company_id);
    clean_global_company_id_Invalid := Fields.InValid_global_company_id((SALT311.StrType)clean_global_company_id);
    SELF.global_company_id := IF(withOnfail, clean_global_company_id, le.global_company_id); // ONFAIL(CLEAN)
    SELF.global_company_id_wouldClean := TRIM((SALT311.StrType)le.global_company_id) <> TRIM((SALT311.StrType)clean_global_company_id);
    SELF.phone_nbr_Invalid := Fields.InValid_phone_nbr((SALT311.StrType)le.phone_nbr);
    clean_phone_nbr := (TYPEOF(le.phone_nbr))Fields.Make_phone_nbr((SALT311.StrType)le.phone_nbr);
    clean_phone_nbr_Invalid := Fields.InValid_phone_nbr((SALT311.StrType)clean_phone_nbr);
    SELF.phone_nbr := IF(withOnfail, clean_phone_nbr, le.phone_nbr); // ONFAIL(CLEAN)
    SELF.phone_nbr_wouldClean := TRIM((SALT311.StrType)le.phone_nbr) <> TRIM((SALT311.StrType)clean_phone_nbr);
    SELF := le;
  END;
  EXPORT ExpandedInfile := PROJECT(h,toExpanded(LEFT,FALSE));
  EXPORT ProcessedInfile := PROJECT(PROJECT(h,toExpanded(LEFT,TRUE)),Layout_File);
  Bitmap_Layout Into(ExpandedInfile le) := TRANSFORM
    SELF.ScrubsBits1 := ( le.lex_id_Invalid << 0 ) + ( le.product_id_Invalid << 1 ) + ( le.inquiry_date_Invalid << 4 ) + ( le.transaction_id_Invalid << 7 ) + ( le.date_added_Invalid << 10 ) + ( le.customer_number_Invalid << 13 ) + ( le.customer_account_Invalid << 15 ) + ( le.ssn_Invalid << 17 ) + ( le.drivers_license_number_Invalid << 19 ) + ( le.drivers_license_state_Invalid << 21 ) + ( le.name_first_Invalid << 23 ) + ( le.name_last_Invalid << 25 ) + ( le.name_middle_Invalid << 27 ) + ( le.name_suffix_Invalid << 29 ) + ( le.addr_street_Invalid << 31 ) + ( le.addr_city_Invalid << 33 ) + ( le.addr_state_Invalid << 35 ) + ( le.addr_zip5_Invalid << 37 ) + ( le.addr_zip4_Invalid << 39 ) + ( le.dob_Invalid << 41 ) + ( le.transaction_location_Invalid << 43 ) + ( le.ppc_Invalid << 45 ) + ( le.internal_identifier_Invalid << 47 ) + ( le.eu1_customer_number_Invalid << 49 ) + ( le.eu1_customer_account_Invalid << 51 ) + ( le.eu2_customer_number_Invalid << 53 ) + ( le.eu2_customer_account_Invalid << 55 ) + ( le.email_addr_Invalid << 57 ) + ( le.ip_address_Invalid << 59 ) + ( le.state_id_number_Invalid << 61 );
    SELF.ScrubsBits2 := ( le.state_id_state_Invalid << 0 ) + ( le.eu_company_name_Invalid << 2 ) + ( le.eu_addr_street_Invalid << 4 ) + ( le.eu_addr_city_Invalid << 6 ) + ( le.eu_addr_state_Invalid << 8 ) + ( le.eu_addr_zip5_Invalid << 10 ) + ( le.eu_phone_nbr_Invalid << 12 ) + ( le.product_code_Invalid << 14 ) + ( le.transaction_type_Invalid << 16 ) + ( le.function_name_Invalid << 18 ) + ( le.customer_id_Invalid << 20 ) + ( le.company_id_Invalid << 22 ) + ( le.global_company_id_Invalid << 24 ) + ( le.phone_nbr_Invalid << 26 );
    SELF.ScrubsCleanBits1 := ( IF(le.product_id_wouldClean, 1, 0) << 0 ) + ( IF(le.inquiry_date_wouldClean, 1, 0) << 1 ) + ( IF(le.transaction_id_wouldClean, 1, 0) << 2 ) + ( IF(le.date_added_wouldClean, 1, 0) << 3 ) + ( IF(le.customer_number_wouldClean, 1, 0) << 4 ) + ( IF(le.customer_account_wouldClean, 1, 0) << 5 ) + ( IF(le.ssn_wouldClean, 1, 0) << 6 ) + ( IF(le.drivers_license_number_wouldClean, 1, 0) << 7 ) + ( IF(le.drivers_license_state_wouldClean, 1, 0) << 8 ) + ( IF(le.name_first_wouldClean, 1, 0) << 9 ) + ( IF(le.name_last_wouldClean, 1, 0) << 10 ) + ( IF(le.name_middle_wouldClean, 1, 0) << 11 ) + ( IF(le.name_suffix_wouldClean, 1, 0) << 12 ) + ( IF(le.addr_street_wouldClean, 1, 0) << 13 ) + ( IF(le.addr_city_wouldClean, 1, 0) << 14 ) + ( IF(le.addr_state_wouldClean, 1, 0) << 15 ) + ( IF(le.addr_zip5_wouldClean, 1, 0) << 16 ) + ( IF(le.addr_zip4_wouldClean, 1, 0) << 17 ) + ( IF(le.dob_wouldClean, 1, 0) << 18 ) + ( IF(le.transaction_location_wouldClean, 1, 0) << 19 ) + ( IF(le.ppc_wouldClean, 1, 0) << 20 ) + ( IF(le.internal_identifier_wouldClean, 1, 0) << 21 ) + ( IF(le.eu1_customer_number_wouldClean, 1, 0) << 22 ) + ( IF(le.eu1_customer_account_wouldClean, 1, 0) << 23 ) + ( IF(le.eu2_customer_number_wouldClean, 1, 0) << 24 ) + ( IF(le.eu2_customer_account_wouldClean, 1, 0) << 25 ) + ( IF(le.email_addr_wouldClean, 1, 0) << 26 ) + ( IF(le.ip_address_wouldClean, 1, 0) << 27 ) + ( IF(le.state_id_number_wouldClean, 1, 0) << 28 ) + ( IF(le.state_id_state_wouldClean, 1, 0) << 29 ) + ( IF(le.eu_company_name_wouldClean, 1, 0) << 30 ) + ( IF(le.eu_addr_street_wouldClean, 1, 0) << 31 ) + ( IF(le.eu_addr_city_wouldClean, 1, 0) << 32 ) + ( IF(le.eu_addr_state_wouldClean, 1, 0) << 33 ) + ( IF(le.eu_addr_zip5_wouldClean, 1, 0) << 34 ) + ( IF(le.eu_phone_nbr_wouldClean, 1, 0) << 35 ) + ( IF(le.product_code_wouldClean, 1, 0) << 36 ) + ( IF(le.transaction_type_wouldClean, 1, 0) << 37 ) + ( IF(le.function_name_wouldClean, 1, 0) << 38 ) + ( IF(le.customer_id_wouldClean, 1, 0) << 39 ) + ( IF(le.company_id_wouldClean, 1, 0) << 40 ) + ( IF(le.global_company_id_wouldClean, 1, 0) << 41 ) + ( IF(le.phone_nbr_wouldClean, 1, 0) << 42 );
    SELF := le;
  END;
  EXPORT BitmapInfile := PROJECT(ExpandedInfile,Into(LEFT));
END;
// Module to use if you already have a scrubs bitmap you wish to expand or compare
EXPORT FromBits(DATASET(Bitmap_Layout) h) := MODULE
  EXPORT Infile := PROJECT(h,Layout_File);
  Expanded_Layout into(h le) := TRANSFORM
    SELF.lex_id_Invalid := (le.ScrubsBits1 >> 0) & 1;
    SELF.product_id_Invalid := (le.ScrubsBits1 >> 1) & 7;
    SELF.inquiry_date_Invalid := (le.ScrubsBits1 >> 4) & 7;
    SELF.transaction_id_Invalid := (le.ScrubsBits1 >> 7) & 7;
    SELF.date_added_Invalid := (le.ScrubsBits1 >> 10) & 7;
    SELF.customer_number_Invalid := (le.ScrubsBits1 >> 13) & 3;
    SELF.customer_account_Invalid := (le.ScrubsBits1 >> 15) & 3;
    SELF.ssn_Invalid := (le.ScrubsBits1 >> 17) & 3;
    SELF.drivers_license_number_Invalid := (le.ScrubsBits1 >> 19) & 3;
    SELF.drivers_license_state_Invalid := (le.ScrubsBits1 >> 21) & 3;
    SELF.name_first_Invalid := (le.ScrubsBits1 >> 23) & 3;
    SELF.name_last_Invalid := (le.ScrubsBits1 >> 25) & 3;
    SELF.name_middle_Invalid := (le.ScrubsBits1 >> 27) & 3;
    SELF.name_suffix_Invalid := (le.ScrubsBits1 >> 29) & 3;
    SELF.addr_street_Invalid := (le.ScrubsBits1 >> 31) & 3;
    SELF.addr_city_Invalid := (le.ScrubsBits1 >> 33) & 3;
    SELF.addr_state_Invalid := (le.ScrubsBits1 >> 35) & 3;
    SELF.addr_zip5_Invalid := (le.ScrubsBits1 >> 37) & 3;
    SELF.addr_zip4_Invalid := (le.ScrubsBits1 >> 39) & 3;
    SELF.dob_Invalid := (le.ScrubsBits1 >> 41) & 3;
    SELF.transaction_location_Invalid := (le.ScrubsBits1 >> 43) & 3;
    SELF.ppc_Invalid := (le.ScrubsBits1 >> 45) & 3;
    SELF.internal_identifier_Invalid := (le.ScrubsBits1 >> 47) & 3;
    SELF.eu1_customer_number_Invalid := (le.ScrubsBits1 >> 49) & 3;
    SELF.eu1_customer_account_Invalid := (le.ScrubsBits1 >> 51) & 3;
    SELF.eu2_customer_number_Invalid := (le.ScrubsBits1 >> 53) & 3;
    SELF.eu2_customer_account_Invalid := (le.ScrubsBits1 >> 55) & 3;
    SELF.email_addr_Invalid := (le.ScrubsBits1 >> 57) & 3;
    SELF.ip_address_Invalid := (le.ScrubsBits1 >> 59) & 3;
    SELF.state_id_number_Invalid := (le.ScrubsBits1 >> 61) & 3;
    SELF.state_id_state_Invalid := (le.ScrubsBits2 >> 0) & 3;
    SELF.eu_company_name_Invalid := (le.ScrubsBits2 >> 2) & 3;
    SELF.eu_addr_street_Invalid := (le.ScrubsBits2 >> 4) & 3;
    SELF.eu_addr_city_Invalid := (le.ScrubsBits2 >> 6) & 3;
    SELF.eu_addr_state_Invalid := (le.ScrubsBits2 >> 8) & 3;
    SELF.eu_addr_zip5_Invalid := (le.ScrubsBits2 >> 10) & 3;
    SELF.eu_phone_nbr_Invalid := (le.ScrubsBits2 >> 12) & 3;
    SELF.product_code_Invalid := (le.ScrubsBits2 >> 14) & 3;
    SELF.transaction_type_Invalid := (le.ScrubsBits2 >> 16) & 3;
    SELF.function_name_Invalid := (le.ScrubsBits2 >> 18) & 3;
    SELF.customer_id_Invalid := (le.ScrubsBits2 >> 20) & 3;
    SELF.company_id_Invalid := (le.ScrubsBits2 >> 22) & 3;
    SELF.global_company_id_Invalid := (le.ScrubsBits2 >> 24) & 3;
    SELF.phone_nbr_Invalid := (le.ScrubsBits2 >> 26) & 3;
    SELF.product_id_wouldClean := le.ScrubsCleanBits1 >> 0;
    SELF.inquiry_date_wouldClean := le.ScrubsCleanBits1 >> 1;
    SELF.transaction_id_wouldClean := le.ScrubsCleanBits1 >> 2;
    SELF.date_added_wouldClean := le.ScrubsCleanBits1 >> 3;
    SELF.customer_number_wouldClean := le.ScrubsCleanBits1 >> 4;
    SELF.customer_account_wouldClean := le.ScrubsCleanBits1 >> 5;
    SELF.ssn_wouldClean := le.ScrubsCleanBits1 >> 6;
    SELF.drivers_license_number_wouldClean := le.ScrubsCleanBits1 >> 7;
    SELF.drivers_license_state_wouldClean := le.ScrubsCleanBits1 >> 8;
    SELF.name_first_wouldClean := le.ScrubsCleanBits1 >> 9;
    SELF.name_last_wouldClean := le.ScrubsCleanBits1 >> 10;
    SELF.name_middle_wouldClean := le.ScrubsCleanBits1 >> 11;
    SELF.name_suffix_wouldClean := le.ScrubsCleanBits1 >> 12;
    SELF.addr_street_wouldClean := le.ScrubsCleanBits1 >> 13;
    SELF.addr_city_wouldClean := le.ScrubsCleanBits1 >> 14;
    SELF.addr_state_wouldClean := le.ScrubsCleanBits1 >> 15;
    SELF.addr_zip5_wouldClean := le.ScrubsCleanBits1 >> 16;
    SELF.addr_zip4_wouldClean := le.ScrubsCleanBits1 >> 17;
    SELF.dob_wouldClean := le.ScrubsCleanBits1 >> 18;
    SELF.transaction_location_wouldClean := le.ScrubsCleanBits1 >> 19;
    SELF.ppc_wouldClean := le.ScrubsCleanBits1 >> 20;
    SELF.internal_identifier_wouldClean := le.ScrubsCleanBits1 >> 21;
    SELF.eu1_customer_number_wouldClean := le.ScrubsCleanBits1 >> 22;
    SELF.eu1_customer_account_wouldClean := le.ScrubsCleanBits1 >> 23;
    SELF.eu2_customer_number_wouldClean := le.ScrubsCleanBits1 >> 24;
    SELF.eu2_customer_account_wouldClean := le.ScrubsCleanBits1 >> 25;
    SELF.email_addr_wouldClean := le.ScrubsCleanBits1 >> 26;
    SELF.ip_address_wouldClean := le.ScrubsCleanBits1 >> 27;
    SELF.state_id_number_wouldClean := le.ScrubsCleanBits1 >> 28;
    SELF.state_id_state_wouldClean := le.ScrubsCleanBits1 >> 29;
    SELF.eu_company_name_wouldClean := le.ScrubsCleanBits1 >> 30;
    SELF.eu_addr_street_wouldClean := le.ScrubsCleanBits1 >> 31;
    SELF.eu_addr_city_wouldClean := le.ScrubsCleanBits1 >> 32;
    SELF.eu_addr_state_wouldClean := le.ScrubsCleanBits1 >> 33;
    SELF.eu_addr_zip5_wouldClean := le.ScrubsCleanBits1 >> 34;
    SELF.eu_phone_nbr_wouldClean := le.ScrubsCleanBits1 >> 35;
    SELF.product_code_wouldClean := le.ScrubsCleanBits1 >> 36;
    SELF.transaction_type_wouldClean := le.ScrubsCleanBits1 >> 37;
    SELF.function_name_wouldClean := le.ScrubsCleanBits1 >> 38;
    SELF.customer_id_wouldClean := le.ScrubsCleanBits1 >> 39;
    SELF.company_id_wouldClean := le.ScrubsCleanBits1 >> 40;
    SELF.global_company_id_wouldClean := le.ScrubsCleanBits1 >> 41;
    SELF.phone_nbr_wouldClean := le.ScrubsCleanBits1 >> 42;
    SELF := le;
  END;
  EXPORT ExpandedInfile := PROJECT(h,Into(LEFT));
END;
// This can be thought of as the 'reporting module' - if you don't have an expanded; the other two modules create them ...
EXPORT FromExpanded(DATASET(Expanded_Layout) h) := MODULE
  r := RECORD
    TotalCnt := COUNT(GROUP); // Number of records in total
    lex_id_ALLOW_ErrorCount := COUNT(GROUP,h.lex_id_Invalid=1);
    product_id_LEFTTRIM_ErrorCount := COUNT(GROUP,h.product_id_Invalid=1);
    product_id_LEFTTRIM_WouldModifyCount := COUNT(GROUP,h.product_id_Invalid=1 AND h.product_id_wouldClean);
    product_id_ALLOW_ErrorCount := COUNT(GROUP,h.product_id_Invalid=2);
    product_id_ALLOW_WouldModifyCount := COUNT(GROUP,h.product_id_Invalid=2 AND h.product_id_wouldClean);
    product_id_LENGTHS_ErrorCount := COUNT(GROUP,h.product_id_Invalid=3);
    product_id_LENGTHS_WouldModifyCount := COUNT(GROUP,h.product_id_Invalid=3 AND h.product_id_wouldClean);
    product_id_WORDS_ErrorCount := COUNT(GROUP,h.product_id_Invalid=4);
    product_id_WORDS_WouldModifyCount := COUNT(GROUP,h.product_id_Invalid=4 AND h.product_id_wouldClean);
    product_id_Total_ErrorCount := COUNT(GROUP,h.product_id_Invalid>0);
    inquiry_date_LEFTTRIM_ErrorCount := COUNT(GROUP,h.inquiry_date_Invalid=1);
    inquiry_date_LEFTTRIM_WouldModifyCount := COUNT(GROUP,h.inquiry_date_Invalid=1 AND h.inquiry_date_wouldClean);
    inquiry_date_ALLOW_ErrorCount := COUNT(GROUP,h.inquiry_date_Invalid=2);
    inquiry_date_ALLOW_WouldModifyCount := COUNT(GROUP,h.inquiry_date_Invalid=2 AND h.inquiry_date_wouldClean);
    inquiry_date_LENGTHS_ErrorCount := COUNT(GROUP,h.inquiry_date_Invalid=3);
    inquiry_date_LENGTHS_WouldModifyCount := COUNT(GROUP,h.inquiry_date_Invalid=3 AND h.inquiry_date_wouldClean);
    inquiry_date_WORDS_ErrorCount := COUNT(GROUP,h.inquiry_date_Invalid=4);
    inquiry_date_WORDS_WouldModifyCount := COUNT(GROUP,h.inquiry_date_Invalid=4 AND h.inquiry_date_wouldClean);
    inquiry_date_Total_ErrorCount := COUNT(GROUP,h.inquiry_date_Invalid>0);
    transaction_id_LEFTTRIM_ErrorCount := COUNT(GROUP,h.transaction_id_Invalid=1);
    transaction_id_LEFTTRIM_WouldModifyCount := COUNT(GROUP,h.transaction_id_Invalid=1 AND h.transaction_id_wouldClean);
    transaction_id_ALLOW_ErrorCount := COUNT(GROUP,h.transaction_id_Invalid=2);
    transaction_id_ALLOW_WouldModifyCount := COUNT(GROUP,h.transaction_id_Invalid=2 AND h.transaction_id_wouldClean);
    transaction_id_LENGTHS_ErrorCount := COUNT(GROUP,h.transaction_id_Invalid=3);
    transaction_id_LENGTHS_WouldModifyCount := COUNT(GROUP,h.transaction_id_Invalid=3 AND h.transaction_id_wouldClean);
    transaction_id_WORDS_ErrorCount := COUNT(GROUP,h.transaction_id_Invalid=4);
    transaction_id_WORDS_WouldModifyCount := COUNT(GROUP,h.transaction_id_Invalid=4 AND h.transaction_id_wouldClean);
    transaction_id_Total_ErrorCount := COUNT(GROUP,h.transaction_id_Invalid>0);
    date_added_LEFTTRIM_ErrorCount := COUNT(GROUP,h.date_added_Invalid=1);
    date_added_LEFTTRIM_WouldModifyCount := COUNT(GROUP,h.date_added_Invalid=1 AND h.date_added_wouldClean);
    date_added_ALLOW_ErrorCount := COUNT(GROUP,h.date_added_Invalid=2);
    date_added_ALLOW_WouldModifyCount := COUNT(GROUP,h.date_added_Invalid=2 AND h.date_added_wouldClean);
    date_added_LENGTHS_ErrorCount := COUNT(GROUP,h.date_added_Invalid=3);
    date_added_LENGTHS_WouldModifyCount := COUNT(GROUP,h.date_added_Invalid=3 AND h.date_added_wouldClean);
    date_added_WORDS_ErrorCount := COUNT(GROUP,h.date_added_Invalid=4);
    date_added_WORDS_WouldModifyCount := COUNT(GROUP,h.date_added_Invalid=4 AND h.date_added_wouldClean);
    date_added_Total_ErrorCount := COUNT(GROUP,h.date_added_Invalid>0);
    customer_number_LEFTTRIM_ErrorCount := COUNT(GROUP,h.customer_number_Invalid=1);
    customer_number_LEFTTRIM_WouldModifyCount := COUNT(GROUP,h.customer_number_Invalid=1 AND h.customer_number_wouldClean);
    customer_number_LENGTHS_ErrorCount := COUNT(GROUP,h.customer_number_Invalid=2);
    customer_number_LENGTHS_WouldModifyCount := COUNT(GROUP,h.customer_number_Invalid=2 AND h.customer_number_wouldClean);
    customer_number_WORDS_ErrorCount := COUNT(GROUP,h.customer_number_Invalid=3);
    customer_number_WORDS_WouldModifyCount := COUNT(GROUP,h.customer_number_Invalid=3 AND h.customer_number_wouldClean);
    customer_number_Total_ErrorCount := COUNT(GROUP,h.customer_number_Invalid>0);
    customer_account_LEFTTRIM_ErrorCount := COUNT(GROUP,h.customer_account_Invalid=1);
    customer_account_LEFTTRIM_WouldModifyCount := COUNT(GROUP,h.customer_account_Invalid=1 AND h.customer_account_wouldClean);
    customer_account_LENGTHS_ErrorCount := COUNT(GROUP,h.customer_account_Invalid=2);
    customer_account_LENGTHS_WouldModifyCount := COUNT(GROUP,h.customer_account_Invalid=2 AND h.customer_account_wouldClean);
    customer_account_WORDS_ErrorCount := COUNT(GROUP,h.customer_account_Invalid=3);
    customer_account_WORDS_WouldModifyCount := COUNT(GROUP,h.customer_account_Invalid=3 AND h.customer_account_wouldClean);
    customer_account_Total_ErrorCount := COUNT(GROUP,h.customer_account_Invalid>0);
    ssn_LEFTTRIM_ErrorCount := COUNT(GROUP,h.ssn_Invalid=1);
    ssn_LEFTTRIM_WouldModifyCount := COUNT(GROUP,h.ssn_Invalid=1 AND h.ssn_wouldClean);
    ssn_LENGTHS_ErrorCount := COUNT(GROUP,h.ssn_Invalid=2);
    ssn_LENGTHS_WouldModifyCount := COUNT(GROUP,h.ssn_Invalid=2 AND h.ssn_wouldClean);
    ssn_WORDS_ErrorCount := COUNT(GROUP,h.ssn_Invalid=3);
    ssn_WORDS_WouldModifyCount := COUNT(GROUP,h.ssn_Invalid=3 AND h.ssn_wouldClean);
    ssn_Total_ErrorCount := COUNT(GROUP,h.ssn_Invalid>0);
    drivers_license_number_LEFTTRIM_ErrorCount := COUNT(GROUP,h.drivers_license_number_Invalid=1);
    drivers_license_number_LEFTTRIM_WouldModifyCount := COUNT(GROUP,h.drivers_license_number_Invalid=1 AND h.drivers_license_number_wouldClean);
    drivers_license_number_LENGTHS_ErrorCount := COUNT(GROUP,h.drivers_license_number_Invalid=2);
    drivers_license_number_LENGTHS_WouldModifyCount := COUNT(GROUP,h.drivers_license_number_Invalid=2 AND h.drivers_license_number_wouldClean);
    drivers_license_number_WORDS_ErrorCount := COUNT(GROUP,h.drivers_license_number_Invalid=3);
    drivers_license_number_WORDS_WouldModifyCount := COUNT(GROUP,h.drivers_license_number_Invalid=3 AND h.drivers_license_number_wouldClean);
    drivers_license_number_Total_ErrorCount := COUNT(GROUP,h.drivers_license_number_Invalid>0);
    drivers_license_state_LEFTTRIM_ErrorCount := COUNT(GROUP,h.drivers_license_state_Invalid=1);
    drivers_license_state_LEFTTRIM_WouldModifyCount := COUNT(GROUP,h.drivers_license_state_Invalid=1 AND h.drivers_license_state_wouldClean);
    drivers_license_state_LENGTHS_ErrorCount := COUNT(GROUP,h.drivers_license_state_Invalid=2);
    drivers_license_state_LENGTHS_WouldModifyCount := COUNT(GROUP,h.drivers_license_state_Invalid=2 AND h.drivers_license_state_wouldClean);
    drivers_license_state_WORDS_ErrorCount := COUNT(GROUP,h.drivers_license_state_Invalid=3);
    drivers_license_state_WORDS_WouldModifyCount := COUNT(GROUP,h.drivers_license_state_Invalid=3 AND h.drivers_license_state_wouldClean);
    drivers_license_state_Total_ErrorCount := COUNT(GROUP,h.drivers_license_state_Invalid>0);
    name_first_LEFTTRIM_ErrorCount := COUNT(GROUP,h.name_first_Invalid=1);
    name_first_LEFTTRIM_WouldModifyCount := COUNT(GROUP,h.name_first_Invalid=1 AND h.name_first_wouldClean);
    name_first_LENGTHS_ErrorCount := COUNT(GROUP,h.name_first_Invalid=2);
    name_first_LENGTHS_WouldModifyCount := COUNT(GROUP,h.name_first_Invalid=2 AND h.name_first_wouldClean);
    name_first_WORDS_ErrorCount := COUNT(GROUP,h.name_first_Invalid=3);
    name_first_WORDS_WouldModifyCount := COUNT(GROUP,h.name_first_Invalid=3 AND h.name_first_wouldClean);
    name_first_Total_ErrorCount := COUNT(GROUP,h.name_first_Invalid>0);
    name_last_LEFTTRIM_ErrorCount := COUNT(GROUP,h.name_last_Invalid=1);
    name_last_LEFTTRIM_WouldModifyCount := COUNT(GROUP,h.name_last_Invalid=1 AND h.name_last_wouldClean);
    name_last_LENGTHS_ErrorCount := COUNT(GROUP,h.name_last_Invalid=2);
    name_last_LENGTHS_WouldModifyCount := COUNT(GROUP,h.name_last_Invalid=2 AND h.name_last_wouldClean);
    name_last_WORDS_ErrorCount := COUNT(GROUP,h.name_last_Invalid=3);
    name_last_WORDS_WouldModifyCount := COUNT(GROUP,h.name_last_Invalid=3 AND h.name_last_wouldClean);
    name_last_Total_ErrorCount := COUNT(GROUP,h.name_last_Invalid>0);
    name_middle_LEFTTRIM_ErrorCount := COUNT(GROUP,h.name_middle_Invalid=1);
    name_middle_LEFTTRIM_WouldModifyCount := COUNT(GROUP,h.name_middle_Invalid=1 AND h.name_middle_wouldClean);
    name_middle_LENGTHS_ErrorCount := COUNT(GROUP,h.name_middle_Invalid=2);
    name_middle_LENGTHS_WouldModifyCount := COUNT(GROUP,h.name_middle_Invalid=2 AND h.name_middle_wouldClean);
    name_middle_WORDS_ErrorCount := COUNT(GROUP,h.name_middle_Invalid=3);
    name_middle_WORDS_WouldModifyCount := COUNT(GROUP,h.name_middle_Invalid=3 AND h.name_middle_wouldClean);
    name_middle_Total_ErrorCount := COUNT(GROUP,h.name_middle_Invalid>0);
    name_suffix_LEFTTRIM_ErrorCount := COUNT(GROUP,h.name_suffix_Invalid=1);
    name_suffix_LEFTTRIM_WouldModifyCount := COUNT(GROUP,h.name_suffix_Invalid=1 AND h.name_suffix_wouldClean);
    name_suffix_LENGTHS_ErrorCount := COUNT(GROUP,h.name_suffix_Invalid=2);
    name_suffix_LENGTHS_WouldModifyCount := COUNT(GROUP,h.name_suffix_Invalid=2 AND h.name_suffix_wouldClean);
    name_suffix_WORDS_ErrorCount := COUNT(GROUP,h.name_suffix_Invalid=3);
    name_suffix_WORDS_WouldModifyCount := COUNT(GROUP,h.name_suffix_Invalid=3 AND h.name_suffix_wouldClean);
    name_suffix_Total_ErrorCount := COUNT(GROUP,h.name_suffix_Invalid>0);
    addr_street_LEFTTRIM_ErrorCount := COUNT(GROUP,h.addr_street_Invalid=1);
    addr_street_LEFTTRIM_WouldModifyCount := COUNT(GROUP,h.addr_street_Invalid=1 AND h.addr_street_wouldClean);
    addr_street_LENGTHS_ErrorCount := COUNT(GROUP,h.addr_street_Invalid=2);
    addr_street_LENGTHS_WouldModifyCount := COUNT(GROUP,h.addr_street_Invalid=2 AND h.addr_street_wouldClean);
    addr_street_WORDS_ErrorCount := COUNT(GROUP,h.addr_street_Invalid=3);
    addr_street_WORDS_WouldModifyCount := COUNT(GROUP,h.addr_street_Invalid=3 AND h.addr_street_wouldClean);
    addr_street_Total_ErrorCount := COUNT(GROUP,h.addr_street_Invalid>0);
    addr_city_LEFTTRIM_ErrorCount := COUNT(GROUP,h.addr_city_Invalid=1);
    addr_city_LEFTTRIM_WouldModifyCount := COUNT(GROUP,h.addr_city_Invalid=1 AND h.addr_city_wouldClean);
    addr_city_LENGTHS_ErrorCount := COUNT(GROUP,h.addr_city_Invalid=2);
    addr_city_LENGTHS_WouldModifyCount := COUNT(GROUP,h.addr_city_Invalid=2 AND h.addr_city_wouldClean);
    addr_city_WORDS_ErrorCount := COUNT(GROUP,h.addr_city_Invalid=3);
    addr_city_WORDS_WouldModifyCount := COUNT(GROUP,h.addr_city_Invalid=3 AND h.addr_city_wouldClean);
    addr_city_Total_ErrorCount := COUNT(GROUP,h.addr_city_Invalid>0);
    addr_state_LEFTTRIM_ErrorCount := COUNT(GROUP,h.addr_state_Invalid=1);
    addr_state_LEFTTRIM_WouldModifyCount := COUNT(GROUP,h.addr_state_Invalid=1 AND h.addr_state_wouldClean);
    addr_state_LENGTHS_ErrorCount := COUNT(GROUP,h.addr_state_Invalid=2);
    addr_state_LENGTHS_WouldModifyCount := COUNT(GROUP,h.addr_state_Invalid=2 AND h.addr_state_wouldClean);
    addr_state_WORDS_ErrorCount := COUNT(GROUP,h.addr_state_Invalid=3);
    addr_state_WORDS_WouldModifyCount := COUNT(GROUP,h.addr_state_Invalid=3 AND h.addr_state_wouldClean);
    addr_state_Total_ErrorCount := COUNT(GROUP,h.addr_state_Invalid>0);
    addr_zip5_LEFTTRIM_ErrorCount := COUNT(GROUP,h.addr_zip5_Invalid=1);
    addr_zip5_LEFTTRIM_WouldModifyCount := COUNT(GROUP,h.addr_zip5_Invalid=1 AND h.addr_zip5_wouldClean);
    addr_zip5_LENGTHS_ErrorCount := COUNT(GROUP,h.addr_zip5_Invalid=2);
    addr_zip5_LENGTHS_WouldModifyCount := COUNT(GROUP,h.addr_zip5_Invalid=2 AND h.addr_zip5_wouldClean);
    addr_zip5_WORDS_ErrorCount := COUNT(GROUP,h.addr_zip5_Invalid=3);
    addr_zip5_WORDS_WouldModifyCount := COUNT(GROUP,h.addr_zip5_Invalid=3 AND h.addr_zip5_wouldClean);
    addr_zip5_Total_ErrorCount := COUNT(GROUP,h.addr_zip5_Invalid>0);
    addr_zip4_LEFTTRIM_ErrorCount := COUNT(GROUP,h.addr_zip4_Invalid=1);
    addr_zip4_LEFTTRIM_WouldModifyCount := COUNT(GROUP,h.addr_zip4_Invalid=1 AND h.addr_zip4_wouldClean);
    addr_zip4_LENGTHS_ErrorCount := COUNT(GROUP,h.addr_zip4_Invalid=2);
    addr_zip4_LENGTHS_WouldModifyCount := COUNT(GROUP,h.addr_zip4_Invalid=2 AND h.addr_zip4_wouldClean);
    addr_zip4_WORDS_ErrorCount := COUNT(GROUP,h.addr_zip4_Invalid=3);
    addr_zip4_WORDS_WouldModifyCount := COUNT(GROUP,h.addr_zip4_Invalid=3 AND h.addr_zip4_wouldClean);
    addr_zip4_Total_ErrorCount := COUNT(GROUP,h.addr_zip4_Invalid>0);
    dob_LEFTTRIM_ErrorCount := COUNT(GROUP,h.dob_Invalid=1);
    dob_LEFTTRIM_WouldModifyCount := COUNT(GROUP,h.dob_Invalid=1 AND h.dob_wouldClean);
    dob_LENGTHS_ErrorCount := COUNT(GROUP,h.dob_Invalid=2);
    dob_LENGTHS_WouldModifyCount := COUNT(GROUP,h.dob_Invalid=2 AND h.dob_wouldClean);
    dob_WORDS_ErrorCount := COUNT(GROUP,h.dob_Invalid=3);
    dob_WORDS_WouldModifyCount := COUNT(GROUP,h.dob_Invalid=3 AND h.dob_wouldClean);
    dob_Total_ErrorCount := COUNT(GROUP,h.dob_Invalid>0);
    transaction_location_LEFTTRIM_ErrorCount := COUNT(GROUP,h.transaction_location_Invalid=1);
    transaction_location_LEFTTRIM_WouldModifyCount := COUNT(GROUP,h.transaction_location_Invalid=1 AND h.transaction_location_wouldClean);
    transaction_location_LENGTHS_ErrorCount := COUNT(GROUP,h.transaction_location_Invalid=2);
    transaction_location_LENGTHS_WouldModifyCount := COUNT(GROUP,h.transaction_location_Invalid=2 AND h.transaction_location_wouldClean);
    transaction_location_WORDS_ErrorCount := COUNT(GROUP,h.transaction_location_Invalid=3);
    transaction_location_WORDS_WouldModifyCount := COUNT(GROUP,h.transaction_location_Invalid=3 AND h.transaction_location_wouldClean);
    transaction_location_Total_ErrorCount := COUNT(GROUP,h.transaction_location_Invalid>0);
    ppc_LEFTTRIM_ErrorCount := COUNT(GROUP,h.ppc_Invalid=1);
    ppc_LEFTTRIM_WouldModifyCount := COUNT(GROUP,h.ppc_Invalid=1 AND h.ppc_wouldClean);
    ppc_LENGTHS_ErrorCount := COUNT(GROUP,h.ppc_Invalid=2);
    ppc_LENGTHS_WouldModifyCount := COUNT(GROUP,h.ppc_Invalid=2 AND h.ppc_wouldClean);
    ppc_WORDS_ErrorCount := COUNT(GROUP,h.ppc_Invalid=3);
    ppc_WORDS_WouldModifyCount := COUNT(GROUP,h.ppc_Invalid=3 AND h.ppc_wouldClean);
    ppc_Total_ErrorCount := COUNT(GROUP,h.ppc_Invalid>0);
    internal_identifier_LEFTTRIM_ErrorCount := COUNT(GROUP,h.internal_identifier_Invalid=1);
    internal_identifier_LEFTTRIM_WouldModifyCount := COUNT(GROUP,h.internal_identifier_Invalid=1 AND h.internal_identifier_wouldClean);
    internal_identifier_LENGTHS_ErrorCount := COUNT(GROUP,h.internal_identifier_Invalid=2);
    internal_identifier_LENGTHS_WouldModifyCount := COUNT(GROUP,h.internal_identifier_Invalid=2 AND h.internal_identifier_wouldClean);
    internal_identifier_WORDS_ErrorCount := COUNT(GROUP,h.internal_identifier_Invalid=3);
    internal_identifier_WORDS_WouldModifyCount := COUNT(GROUP,h.internal_identifier_Invalid=3 AND h.internal_identifier_wouldClean);
    internal_identifier_Total_ErrorCount := COUNT(GROUP,h.internal_identifier_Invalid>0);
    eu1_customer_number_LEFTTRIM_ErrorCount := COUNT(GROUP,h.eu1_customer_number_Invalid=1);
    eu1_customer_number_LEFTTRIM_WouldModifyCount := COUNT(GROUP,h.eu1_customer_number_Invalid=1 AND h.eu1_customer_number_wouldClean);
    eu1_customer_number_LENGTHS_ErrorCount := COUNT(GROUP,h.eu1_customer_number_Invalid=2);
    eu1_customer_number_LENGTHS_WouldModifyCount := COUNT(GROUP,h.eu1_customer_number_Invalid=2 AND h.eu1_customer_number_wouldClean);
    eu1_customer_number_WORDS_ErrorCount := COUNT(GROUP,h.eu1_customer_number_Invalid=3);
    eu1_customer_number_WORDS_WouldModifyCount := COUNT(GROUP,h.eu1_customer_number_Invalid=3 AND h.eu1_customer_number_wouldClean);
    eu1_customer_number_Total_ErrorCount := COUNT(GROUP,h.eu1_customer_number_Invalid>0);
    eu1_customer_account_LEFTTRIM_ErrorCount := COUNT(GROUP,h.eu1_customer_account_Invalid=1);
    eu1_customer_account_LEFTTRIM_WouldModifyCount := COUNT(GROUP,h.eu1_customer_account_Invalid=1 AND h.eu1_customer_account_wouldClean);
    eu1_customer_account_LENGTHS_ErrorCount := COUNT(GROUP,h.eu1_customer_account_Invalid=2);
    eu1_customer_account_LENGTHS_WouldModifyCount := COUNT(GROUP,h.eu1_customer_account_Invalid=2 AND h.eu1_customer_account_wouldClean);
    eu1_customer_account_WORDS_ErrorCount := COUNT(GROUP,h.eu1_customer_account_Invalid=3);
    eu1_customer_account_WORDS_WouldModifyCount := COUNT(GROUP,h.eu1_customer_account_Invalid=3 AND h.eu1_customer_account_wouldClean);
    eu1_customer_account_Total_ErrorCount := COUNT(GROUP,h.eu1_customer_account_Invalid>0);
    eu2_customer_number_LEFTTRIM_ErrorCount := COUNT(GROUP,h.eu2_customer_number_Invalid=1);
    eu2_customer_number_LEFTTRIM_WouldModifyCount := COUNT(GROUP,h.eu2_customer_number_Invalid=1 AND h.eu2_customer_number_wouldClean);
    eu2_customer_number_LENGTHS_ErrorCount := COUNT(GROUP,h.eu2_customer_number_Invalid=2);
    eu2_customer_number_LENGTHS_WouldModifyCount := COUNT(GROUP,h.eu2_customer_number_Invalid=2 AND h.eu2_customer_number_wouldClean);
    eu2_customer_number_WORDS_ErrorCount := COUNT(GROUP,h.eu2_customer_number_Invalid=3);
    eu2_customer_number_WORDS_WouldModifyCount := COUNT(GROUP,h.eu2_customer_number_Invalid=3 AND h.eu2_customer_number_wouldClean);
    eu2_customer_number_Total_ErrorCount := COUNT(GROUP,h.eu2_customer_number_Invalid>0);
    eu2_customer_account_LEFTTRIM_ErrorCount := COUNT(GROUP,h.eu2_customer_account_Invalid=1);
    eu2_customer_account_LEFTTRIM_WouldModifyCount := COUNT(GROUP,h.eu2_customer_account_Invalid=1 AND h.eu2_customer_account_wouldClean);
    eu2_customer_account_LENGTHS_ErrorCount := COUNT(GROUP,h.eu2_customer_account_Invalid=2);
    eu2_customer_account_LENGTHS_WouldModifyCount := COUNT(GROUP,h.eu2_customer_account_Invalid=2 AND h.eu2_customer_account_wouldClean);
    eu2_customer_account_WORDS_ErrorCount := COUNT(GROUP,h.eu2_customer_account_Invalid=3);
    eu2_customer_account_WORDS_WouldModifyCount := COUNT(GROUP,h.eu2_customer_account_Invalid=3 AND h.eu2_customer_account_wouldClean);
    eu2_customer_account_Total_ErrorCount := COUNT(GROUP,h.eu2_customer_account_Invalid>0);
    email_addr_LEFTTRIM_ErrorCount := COUNT(GROUP,h.email_addr_Invalid=1);
    email_addr_LEFTTRIM_WouldModifyCount := COUNT(GROUP,h.email_addr_Invalid=1 AND h.email_addr_wouldClean);
    email_addr_LENGTHS_ErrorCount := COUNT(GROUP,h.email_addr_Invalid=2);
    email_addr_LENGTHS_WouldModifyCount := COUNT(GROUP,h.email_addr_Invalid=2 AND h.email_addr_wouldClean);
    email_addr_WORDS_ErrorCount := COUNT(GROUP,h.email_addr_Invalid=3);
    email_addr_WORDS_WouldModifyCount := COUNT(GROUP,h.email_addr_Invalid=3 AND h.email_addr_wouldClean);
    email_addr_Total_ErrorCount := COUNT(GROUP,h.email_addr_Invalid>0);
    ip_address_LEFTTRIM_ErrorCount := COUNT(GROUP,h.ip_address_Invalid=1);
    ip_address_LEFTTRIM_WouldModifyCount := COUNT(GROUP,h.ip_address_Invalid=1 AND h.ip_address_wouldClean);
    ip_address_LENGTHS_ErrorCount := COUNT(GROUP,h.ip_address_Invalid=2);
    ip_address_LENGTHS_WouldModifyCount := COUNT(GROUP,h.ip_address_Invalid=2 AND h.ip_address_wouldClean);
    ip_address_WORDS_ErrorCount := COUNT(GROUP,h.ip_address_Invalid=3);
    ip_address_WORDS_WouldModifyCount := COUNT(GROUP,h.ip_address_Invalid=3 AND h.ip_address_wouldClean);
    ip_address_Total_ErrorCount := COUNT(GROUP,h.ip_address_Invalid>0);
    state_id_number_LEFTTRIM_ErrorCount := COUNT(GROUP,h.state_id_number_Invalid=1);
    state_id_number_LEFTTRIM_WouldModifyCount := COUNT(GROUP,h.state_id_number_Invalid=1 AND h.state_id_number_wouldClean);
    state_id_number_LENGTHS_ErrorCount := COUNT(GROUP,h.state_id_number_Invalid=2);
    state_id_number_LENGTHS_WouldModifyCount := COUNT(GROUP,h.state_id_number_Invalid=2 AND h.state_id_number_wouldClean);
    state_id_number_WORDS_ErrorCount := COUNT(GROUP,h.state_id_number_Invalid=3);
    state_id_number_WORDS_WouldModifyCount := COUNT(GROUP,h.state_id_number_Invalid=3 AND h.state_id_number_wouldClean);
    state_id_number_Total_ErrorCount := COUNT(GROUP,h.state_id_number_Invalid>0);
    state_id_state_LEFTTRIM_ErrorCount := COUNT(GROUP,h.state_id_state_Invalid=1);
    state_id_state_LEFTTRIM_WouldModifyCount := COUNT(GROUP,h.state_id_state_Invalid=1 AND h.state_id_state_wouldClean);
    state_id_state_LENGTHS_ErrorCount := COUNT(GROUP,h.state_id_state_Invalid=2);
    state_id_state_LENGTHS_WouldModifyCount := COUNT(GROUP,h.state_id_state_Invalid=2 AND h.state_id_state_wouldClean);
    state_id_state_WORDS_ErrorCount := COUNT(GROUP,h.state_id_state_Invalid=3);
    state_id_state_WORDS_WouldModifyCount := COUNT(GROUP,h.state_id_state_Invalid=3 AND h.state_id_state_wouldClean);
    state_id_state_Total_ErrorCount := COUNT(GROUP,h.state_id_state_Invalid>0);
    eu_company_name_LEFTTRIM_ErrorCount := COUNT(GROUP,h.eu_company_name_Invalid=1);
    eu_company_name_LEFTTRIM_WouldModifyCount := COUNT(GROUP,h.eu_company_name_Invalid=1 AND h.eu_company_name_wouldClean);
    eu_company_name_LENGTHS_ErrorCount := COUNT(GROUP,h.eu_company_name_Invalid=2);
    eu_company_name_LENGTHS_WouldModifyCount := COUNT(GROUP,h.eu_company_name_Invalid=2 AND h.eu_company_name_wouldClean);
    eu_company_name_WORDS_ErrorCount := COUNT(GROUP,h.eu_company_name_Invalid=3);
    eu_company_name_WORDS_WouldModifyCount := COUNT(GROUP,h.eu_company_name_Invalid=3 AND h.eu_company_name_wouldClean);
    eu_company_name_Total_ErrorCount := COUNT(GROUP,h.eu_company_name_Invalid>0);
    eu_addr_street_LEFTTRIM_ErrorCount := COUNT(GROUP,h.eu_addr_street_Invalid=1);
    eu_addr_street_LEFTTRIM_WouldModifyCount := COUNT(GROUP,h.eu_addr_street_Invalid=1 AND h.eu_addr_street_wouldClean);
    eu_addr_street_LENGTHS_ErrorCount := COUNT(GROUP,h.eu_addr_street_Invalid=2);
    eu_addr_street_LENGTHS_WouldModifyCount := COUNT(GROUP,h.eu_addr_street_Invalid=2 AND h.eu_addr_street_wouldClean);
    eu_addr_street_WORDS_ErrorCount := COUNT(GROUP,h.eu_addr_street_Invalid=3);
    eu_addr_street_WORDS_WouldModifyCount := COUNT(GROUP,h.eu_addr_street_Invalid=3 AND h.eu_addr_street_wouldClean);
    eu_addr_street_Total_ErrorCount := COUNT(GROUP,h.eu_addr_street_Invalid>0);
    eu_addr_city_LEFTTRIM_ErrorCount := COUNT(GROUP,h.eu_addr_city_Invalid=1);
    eu_addr_city_LEFTTRIM_WouldModifyCount := COUNT(GROUP,h.eu_addr_city_Invalid=1 AND h.eu_addr_city_wouldClean);
    eu_addr_city_LENGTHS_ErrorCount := COUNT(GROUP,h.eu_addr_city_Invalid=2);
    eu_addr_city_LENGTHS_WouldModifyCount := COUNT(GROUP,h.eu_addr_city_Invalid=2 AND h.eu_addr_city_wouldClean);
    eu_addr_city_WORDS_ErrorCount := COUNT(GROUP,h.eu_addr_city_Invalid=3);
    eu_addr_city_WORDS_WouldModifyCount := COUNT(GROUP,h.eu_addr_city_Invalid=3 AND h.eu_addr_city_wouldClean);
    eu_addr_city_Total_ErrorCount := COUNT(GROUP,h.eu_addr_city_Invalid>0);
    eu_addr_state_LEFTTRIM_ErrorCount := COUNT(GROUP,h.eu_addr_state_Invalid=1);
    eu_addr_state_LEFTTRIM_WouldModifyCount := COUNT(GROUP,h.eu_addr_state_Invalid=1 AND h.eu_addr_state_wouldClean);
    eu_addr_state_LENGTHS_ErrorCount := COUNT(GROUP,h.eu_addr_state_Invalid=2);
    eu_addr_state_LENGTHS_WouldModifyCount := COUNT(GROUP,h.eu_addr_state_Invalid=2 AND h.eu_addr_state_wouldClean);
    eu_addr_state_WORDS_ErrorCount := COUNT(GROUP,h.eu_addr_state_Invalid=3);
    eu_addr_state_WORDS_WouldModifyCount := COUNT(GROUP,h.eu_addr_state_Invalid=3 AND h.eu_addr_state_wouldClean);
    eu_addr_state_Total_ErrorCount := COUNT(GROUP,h.eu_addr_state_Invalid>0);
    eu_addr_zip5_LEFTTRIM_ErrorCount := COUNT(GROUP,h.eu_addr_zip5_Invalid=1);
    eu_addr_zip5_LEFTTRIM_WouldModifyCount := COUNT(GROUP,h.eu_addr_zip5_Invalid=1 AND h.eu_addr_zip5_wouldClean);
    eu_addr_zip5_LENGTHS_ErrorCount := COUNT(GROUP,h.eu_addr_zip5_Invalid=2);
    eu_addr_zip5_LENGTHS_WouldModifyCount := COUNT(GROUP,h.eu_addr_zip5_Invalid=2 AND h.eu_addr_zip5_wouldClean);
    eu_addr_zip5_WORDS_ErrorCount := COUNT(GROUP,h.eu_addr_zip5_Invalid=3);
    eu_addr_zip5_WORDS_WouldModifyCount := COUNT(GROUP,h.eu_addr_zip5_Invalid=3 AND h.eu_addr_zip5_wouldClean);
    eu_addr_zip5_Total_ErrorCount := COUNT(GROUP,h.eu_addr_zip5_Invalid>0);
    eu_phone_nbr_LEFTTRIM_ErrorCount := COUNT(GROUP,h.eu_phone_nbr_Invalid=1);
    eu_phone_nbr_LEFTTRIM_WouldModifyCount := COUNT(GROUP,h.eu_phone_nbr_Invalid=1 AND h.eu_phone_nbr_wouldClean);
    eu_phone_nbr_LENGTHS_ErrorCount := COUNT(GROUP,h.eu_phone_nbr_Invalid=2);
    eu_phone_nbr_LENGTHS_WouldModifyCount := COUNT(GROUP,h.eu_phone_nbr_Invalid=2 AND h.eu_phone_nbr_wouldClean);
    eu_phone_nbr_WORDS_ErrorCount := COUNT(GROUP,h.eu_phone_nbr_Invalid=3);
    eu_phone_nbr_WORDS_WouldModifyCount := COUNT(GROUP,h.eu_phone_nbr_Invalid=3 AND h.eu_phone_nbr_wouldClean);
    eu_phone_nbr_Total_ErrorCount := COUNT(GROUP,h.eu_phone_nbr_Invalid>0);
    product_code_LEFTTRIM_ErrorCount := COUNT(GROUP,h.product_code_Invalid=1);
    product_code_LEFTTRIM_WouldModifyCount := COUNT(GROUP,h.product_code_Invalid=1 AND h.product_code_wouldClean);
    product_code_LENGTHS_ErrorCount := COUNT(GROUP,h.product_code_Invalid=2);
    product_code_LENGTHS_WouldModifyCount := COUNT(GROUP,h.product_code_Invalid=2 AND h.product_code_wouldClean);
    product_code_WORDS_ErrorCount := COUNT(GROUP,h.product_code_Invalid=3);
    product_code_WORDS_WouldModifyCount := COUNT(GROUP,h.product_code_Invalid=3 AND h.product_code_wouldClean);
    product_code_Total_ErrorCount := COUNT(GROUP,h.product_code_Invalid>0);
    transaction_type_LEFTTRIM_ErrorCount := COUNT(GROUP,h.transaction_type_Invalid=1);
    transaction_type_LEFTTRIM_WouldModifyCount := COUNT(GROUP,h.transaction_type_Invalid=1 AND h.transaction_type_wouldClean);
    transaction_type_LENGTHS_ErrorCount := COUNT(GROUP,h.transaction_type_Invalid=2);
    transaction_type_LENGTHS_WouldModifyCount := COUNT(GROUP,h.transaction_type_Invalid=2 AND h.transaction_type_wouldClean);
    transaction_type_WORDS_ErrorCount := COUNT(GROUP,h.transaction_type_Invalid=3);
    transaction_type_WORDS_WouldModifyCount := COUNT(GROUP,h.transaction_type_Invalid=3 AND h.transaction_type_wouldClean);
    transaction_type_Total_ErrorCount := COUNT(GROUP,h.transaction_type_Invalid>0);
    function_name_LEFTTRIM_ErrorCount := COUNT(GROUP,h.function_name_Invalid=1);
    function_name_LEFTTRIM_WouldModifyCount := COUNT(GROUP,h.function_name_Invalid=1 AND h.function_name_wouldClean);
    function_name_LENGTHS_ErrorCount := COUNT(GROUP,h.function_name_Invalid=2);
    function_name_LENGTHS_WouldModifyCount := COUNT(GROUP,h.function_name_Invalid=2 AND h.function_name_wouldClean);
    function_name_WORDS_ErrorCount := COUNT(GROUP,h.function_name_Invalid=3);
    function_name_WORDS_WouldModifyCount := COUNT(GROUP,h.function_name_Invalid=3 AND h.function_name_wouldClean);
    function_name_Total_ErrorCount := COUNT(GROUP,h.function_name_Invalid>0);
    customer_id_LEFTTRIM_ErrorCount := COUNT(GROUP,h.customer_id_Invalid=1);
    customer_id_LEFTTRIM_WouldModifyCount := COUNT(GROUP,h.customer_id_Invalid=1 AND h.customer_id_wouldClean);
    customer_id_LENGTHS_ErrorCount := COUNT(GROUP,h.customer_id_Invalid=2);
    customer_id_LENGTHS_WouldModifyCount := COUNT(GROUP,h.customer_id_Invalid=2 AND h.customer_id_wouldClean);
    customer_id_WORDS_ErrorCount := COUNT(GROUP,h.customer_id_Invalid=3);
    customer_id_WORDS_WouldModifyCount := COUNT(GROUP,h.customer_id_Invalid=3 AND h.customer_id_wouldClean);
    customer_id_Total_ErrorCount := COUNT(GROUP,h.customer_id_Invalid>0);
    company_id_LEFTTRIM_ErrorCount := COUNT(GROUP,h.company_id_Invalid=1);
    company_id_LEFTTRIM_WouldModifyCount := COUNT(GROUP,h.company_id_Invalid=1 AND h.company_id_wouldClean);
    company_id_LENGTHS_ErrorCount := COUNT(GROUP,h.company_id_Invalid=2);
    company_id_LENGTHS_WouldModifyCount := COUNT(GROUP,h.company_id_Invalid=2 AND h.company_id_wouldClean);
    company_id_WORDS_ErrorCount := COUNT(GROUP,h.company_id_Invalid=3);
    company_id_WORDS_WouldModifyCount := COUNT(GROUP,h.company_id_Invalid=3 AND h.company_id_wouldClean);
    company_id_Total_ErrorCount := COUNT(GROUP,h.company_id_Invalid>0);
    global_company_id_LEFTTRIM_ErrorCount := COUNT(GROUP,h.global_company_id_Invalid=1);
    global_company_id_LEFTTRIM_WouldModifyCount := COUNT(GROUP,h.global_company_id_Invalid=1 AND h.global_company_id_wouldClean);
    global_company_id_LENGTHS_ErrorCount := COUNT(GROUP,h.global_company_id_Invalid=2);
    global_company_id_LENGTHS_WouldModifyCount := COUNT(GROUP,h.global_company_id_Invalid=2 AND h.global_company_id_wouldClean);
    global_company_id_WORDS_ErrorCount := COUNT(GROUP,h.global_company_id_Invalid=3);
    global_company_id_WORDS_WouldModifyCount := COUNT(GROUP,h.global_company_id_Invalid=3 AND h.global_company_id_wouldClean);
    global_company_id_Total_ErrorCount := COUNT(GROUP,h.global_company_id_Invalid>0);
    phone_nbr_LEFTTRIM_ErrorCount := COUNT(GROUP,h.phone_nbr_Invalid=1);
    phone_nbr_LEFTTRIM_WouldModifyCount := COUNT(GROUP,h.phone_nbr_Invalid=1 AND h.phone_nbr_wouldClean);
    phone_nbr_LENGTHS_ErrorCount := COUNT(GROUP,h.phone_nbr_Invalid=2);
    phone_nbr_LENGTHS_WouldModifyCount := COUNT(GROUP,h.phone_nbr_Invalid=2 AND h.phone_nbr_wouldClean);
    phone_nbr_WORDS_ErrorCount := COUNT(GROUP,h.phone_nbr_Invalid=3);
    phone_nbr_WORDS_WouldModifyCount := COUNT(GROUP,h.phone_nbr_Invalid=3 AND h.phone_nbr_wouldClean);
    phone_nbr_Total_ErrorCount := COUNT(GROUP,h.phone_nbr_Invalid>0);
    AnyRule_WithErrorsCount := COUNT(GROUP, h.lex_id_Invalid > 0 OR h.product_id_Invalid > 0 OR h.inquiry_date_Invalid > 0 OR h.transaction_id_Invalid > 0 OR h.date_added_Invalid > 0 OR h.customer_number_Invalid > 0 OR h.customer_account_Invalid > 0 OR h.ssn_Invalid > 0 OR h.drivers_license_number_Invalid > 0 OR h.drivers_license_state_Invalid > 0 OR h.name_first_Invalid > 0 OR h.name_last_Invalid > 0 OR h.name_middle_Invalid > 0 OR h.name_suffix_Invalid > 0 OR h.addr_street_Invalid > 0 OR h.addr_city_Invalid > 0 OR h.addr_state_Invalid > 0 OR h.addr_zip5_Invalid > 0 OR h.addr_zip4_Invalid > 0 OR h.dob_Invalid > 0 OR h.transaction_location_Invalid > 0 OR h.ppc_Invalid > 0 OR h.internal_identifier_Invalid > 0 OR h.eu1_customer_number_Invalid > 0 OR h.eu1_customer_account_Invalid > 0 OR h.eu2_customer_number_Invalid > 0 OR h.eu2_customer_account_Invalid > 0 OR h.email_addr_Invalid > 0 OR h.ip_address_Invalid > 0 OR h.state_id_number_Invalid > 0 OR h.state_id_state_Invalid > 0 OR h.eu_company_name_Invalid > 0 OR h.eu_addr_street_Invalid > 0 OR h.eu_addr_city_Invalid > 0 OR h.eu_addr_state_Invalid > 0 OR h.eu_addr_zip5_Invalid > 0 OR h.eu_phone_nbr_Invalid > 0 OR h.product_code_Invalid > 0 OR h.transaction_type_Invalid > 0 OR h.function_name_Invalid > 0 OR h.customer_id_Invalid > 0 OR h.company_id_Invalid > 0 OR h.global_company_id_Invalid > 0 OR h.phone_nbr_Invalid > 0);
    AnyRule_WithEditsCount := COUNT(GROUP, h.product_id_wouldClean OR h.inquiry_date_wouldClean OR h.transaction_id_wouldClean OR h.date_added_wouldClean OR h.customer_number_wouldClean OR h.customer_account_wouldClean OR h.ssn_wouldClean OR h.drivers_license_number_wouldClean OR h.drivers_license_state_wouldClean OR h.name_first_wouldClean OR h.name_last_wouldClean OR h.name_middle_wouldClean OR h.name_suffix_wouldClean OR h.addr_street_wouldClean OR h.addr_city_wouldClean OR h.addr_state_wouldClean OR h.addr_zip5_wouldClean OR h.addr_zip4_wouldClean OR h.dob_wouldClean OR h.transaction_location_wouldClean OR h.ppc_wouldClean OR h.internal_identifier_wouldClean OR h.eu1_customer_number_wouldClean OR h.eu1_customer_account_wouldClean OR h.eu2_customer_number_wouldClean OR h.eu2_customer_account_wouldClean OR h.email_addr_wouldClean OR h.ip_address_wouldClean OR h.state_id_number_wouldClean OR h.state_id_state_wouldClean OR h.eu_company_name_wouldClean OR h.eu_addr_street_wouldClean OR h.eu_addr_city_wouldClean OR h.eu_addr_state_wouldClean OR h.eu_addr_zip5_wouldClean OR h.eu_phone_nbr_wouldClean OR h.product_code_wouldClean OR h.transaction_type_wouldClean OR h.function_name_wouldClean OR h.customer_id_wouldClean OR h.company_id_wouldClean OR h.global_company_id_wouldClean OR h.phone_nbr_wouldClean);
    FieldsChecked_WithErrors := 0;
    FieldsChecked_NoErrors := 0;
    Rules_WithErrors := 0;
    Rules_NoErrors := 0;
    Rules_WithEdits := 0;
  END;
  SummaryStats0 := TABLE(h,r);
  SummaryStats0 xAddErrSummary(SummaryStats0 le) := TRANSFORM
    SELF.FieldsChecked_WithErrors := IF(le.lex_id_ALLOW_ErrorCount > 0, 1, 0) + IF(le.product_id_Total_ErrorCount > 0, 1, 0) + IF(le.inquiry_date_Total_ErrorCount > 0, 1, 0) + IF(le.transaction_id_Total_ErrorCount > 0, 1, 0) + IF(le.date_added_Total_ErrorCount > 0, 1, 0) + IF(le.customer_number_Total_ErrorCount > 0, 1, 0) + IF(le.customer_account_Total_ErrorCount > 0, 1, 0) + IF(le.ssn_Total_ErrorCount > 0, 1, 0) + IF(le.drivers_license_number_Total_ErrorCount > 0, 1, 0) + IF(le.drivers_license_state_Total_ErrorCount > 0, 1, 0) + IF(le.name_first_Total_ErrorCount > 0, 1, 0) + IF(le.name_last_Total_ErrorCount > 0, 1, 0) + IF(le.name_middle_Total_ErrorCount > 0, 1, 0) + IF(le.name_suffix_Total_ErrorCount > 0, 1, 0) + IF(le.addr_street_Total_ErrorCount > 0, 1, 0) + IF(le.addr_city_Total_ErrorCount > 0, 1, 0) + IF(le.addr_state_Total_ErrorCount > 0, 1, 0) + IF(le.addr_zip5_Total_ErrorCount > 0, 1, 0) + IF(le.addr_zip4_Total_ErrorCount > 0, 1, 0) + IF(le.dob_Total_ErrorCount > 0, 1, 0) + IF(le.transaction_location_Total_ErrorCount > 0, 1, 0) + IF(le.ppc_Total_ErrorCount > 0, 1, 0) + IF(le.internal_identifier_Total_ErrorCount > 0, 1, 0) + IF(le.eu1_customer_number_Total_ErrorCount > 0, 1, 0) + IF(le.eu1_customer_account_Total_ErrorCount > 0, 1, 0) + IF(le.eu2_customer_number_Total_ErrorCount > 0, 1, 0) + IF(le.eu2_customer_account_Total_ErrorCount > 0, 1, 0) + IF(le.email_addr_Total_ErrorCount > 0, 1, 0) + IF(le.ip_address_Total_ErrorCount > 0, 1, 0) + IF(le.state_id_number_Total_ErrorCount > 0, 1, 0) + IF(le.state_id_state_Total_ErrorCount > 0, 1, 0) + IF(le.eu_company_name_Total_ErrorCount > 0, 1, 0) + IF(le.eu_addr_street_Total_ErrorCount > 0, 1, 0) + IF(le.eu_addr_city_Total_ErrorCount > 0, 1, 0) + IF(le.eu_addr_state_Total_ErrorCount > 0, 1, 0) + IF(le.eu_addr_zip5_Total_ErrorCount > 0, 1, 0) + IF(le.eu_phone_nbr_Total_ErrorCount > 0, 1, 0) + IF(le.product_code_Total_ErrorCount > 0, 1, 0) + IF(le.transaction_type_Total_ErrorCount > 0, 1, 0) + IF(le.function_name_Total_ErrorCount > 0, 1, 0) + IF(le.customer_id_Total_ErrorCount > 0, 1, 0) + IF(le.company_id_Total_ErrorCount > 0, 1, 0) + IF(le.global_company_id_Total_ErrorCount > 0, 1, 0) + IF(le.phone_nbr_Total_ErrorCount > 0, 1, 0);
    SELF.FieldsChecked_NoErrors := NumFieldsWithRules - SELF.FieldsChecked_WithErrors;
    SELF.Rules_WithErrors := IF(le.lex_id_ALLOW_ErrorCount > 0, 1, 0) + IF(le.product_id_LEFTTRIM_ErrorCount > 0, 1, 0) + IF(le.product_id_ALLOW_ErrorCount > 0, 1, 0) + IF(le.product_id_LENGTHS_ErrorCount > 0, 1, 0) + IF(le.product_id_WORDS_ErrorCount > 0, 1, 0) + IF(le.inquiry_date_LEFTTRIM_ErrorCount > 0, 1, 0) + IF(le.inquiry_date_ALLOW_ErrorCount > 0, 1, 0) + IF(le.inquiry_date_LENGTHS_ErrorCount > 0, 1, 0) + IF(le.inquiry_date_WORDS_ErrorCount > 0, 1, 0) + IF(le.transaction_id_LEFTTRIM_ErrorCount > 0, 1, 0) + IF(le.transaction_id_ALLOW_ErrorCount > 0, 1, 0) + IF(le.transaction_id_LENGTHS_ErrorCount > 0, 1, 0) + IF(le.transaction_id_WORDS_ErrorCount > 0, 1, 0) + IF(le.date_added_LEFTTRIM_ErrorCount > 0, 1, 0) + IF(le.date_added_ALLOW_ErrorCount > 0, 1, 0) + IF(le.date_added_LENGTHS_ErrorCount > 0, 1, 0) + IF(le.date_added_WORDS_ErrorCount > 0, 1, 0) + IF(le.customer_number_LEFTTRIM_ErrorCount > 0, 1, 0) + IF(le.customer_number_LENGTHS_ErrorCount > 0, 1, 0) + IF(le.customer_number_WORDS_ErrorCount > 0, 1, 0) + IF(le.customer_account_LEFTTRIM_ErrorCount > 0, 1, 0) + IF(le.customer_account_LENGTHS_ErrorCount > 0, 1, 0) + IF(le.customer_account_WORDS_ErrorCount > 0, 1, 0) + IF(le.ssn_LEFTTRIM_ErrorCount > 0, 1, 0) + IF(le.ssn_LENGTHS_ErrorCount > 0, 1, 0) + IF(le.ssn_WORDS_ErrorCount > 0, 1, 0) + IF(le.drivers_license_number_LEFTTRIM_ErrorCount > 0, 1, 0) + IF(le.drivers_license_number_LENGTHS_ErrorCount > 0, 1, 0) + IF(le.drivers_license_number_WORDS_ErrorCount > 0, 1, 0) + IF(le.drivers_license_state_LEFTTRIM_ErrorCount > 0, 1, 0) + IF(le.drivers_license_state_LENGTHS_ErrorCount > 0, 1, 0) + IF(le.drivers_license_state_WORDS_ErrorCount > 0, 1, 0) + IF(le.name_first_LEFTTRIM_ErrorCount > 0, 1, 0) + IF(le.name_first_LENGTHS_ErrorCount > 0, 1, 0) + IF(le.name_first_WORDS_ErrorCount > 0, 1, 0) + IF(le.name_last_LEFTTRIM_ErrorCount > 0, 1, 0) + IF(le.name_last_LENGTHS_ErrorCount > 0, 1, 0) + IF(le.name_last_WORDS_ErrorCount > 0, 1, 0) + IF(le.name_middle_LEFTTRIM_ErrorCount > 0, 1, 0) + IF(le.name_middle_LENGTHS_ErrorCount > 0, 1, 0) + IF(le.name_middle_WORDS_ErrorCount > 0, 1, 0) + IF(le.name_suffix_LEFTTRIM_ErrorCount > 0, 1, 0) + IF(le.name_suffix_LENGTHS_ErrorCount > 0, 1, 0) + IF(le.name_suffix_WORDS_ErrorCount > 0, 1, 0) + IF(le.addr_street_LEFTTRIM_ErrorCount > 0, 1, 0) + IF(le.addr_street_LENGTHS_ErrorCount > 0, 1, 0) + IF(le.addr_street_WORDS_ErrorCount > 0, 1, 0) + IF(le.addr_city_LEFTTRIM_ErrorCount > 0, 1, 0) + IF(le.addr_city_LENGTHS_ErrorCount > 0, 1, 0) + IF(le.addr_city_WORDS_ErrorCount > 0, 1, 0) + IF(le.addr_state_LEFTTRIM_ErrorCount > 0, 1, 0) + IF(le.addr_state_LENGTHS_ErrorCount > 0, 1, 0) + IF(le.addr_state_WORDS_ErrorCount > 0, 1, 0) + IF(le.addr_zip5_LEFTTRIM_ErrorCount > 0, 1, 0) + IF(le.addr_zip5_LENGTHS_ErrorCount > 0, 1, 0) + IF(le.addr_zip5_WORDS_ErrorCount > 0, 1, 0) + IF(le.addr_zip4_LEFTTRIM_ErrorCount > 0, 1, 0) + IF(le.addr_zip4_LENGTHS_ErrorCount > 0, 1, 0) + IF(le.addr_zip4_WORDS_ErrorCount > 0, 1, 0) + IF(le.dob_LEFTTRIM_ErrorCount > 0, 1, 0) + IF(le.dob_LENGTHS_ErrorCount > 0, 1, 0) + IF(le.dob_WORDS_ErrorCount > 0, 1, 0) + IF(le.transaction_location_LEFTTRIM_ErrorCount > 0, 1, 0) + IF(le.transaction_location_LENGTHS_ErrorCount > 0, 1, 0) + IF(le.transaction_location_WORDS_ErrorCount > 0, 1, 0) + IF(le.ppc_LEFTTRIM_ErrorCount > 0, 1, 0) + IF(le.ppc_LENGTHS_ErrorCount > 0, 1, 0) + IF(le.ppc_WORDS_ErrorCount > 0, 1, 0) + IF(le.internal_identifier_LEFTTRIM_ErrorCount > 0, 1, 0) + IF(le.internal_identifier_LENGTHS_ErrorCount > 0, 1, 0) + IF(le.internal_identifier_WORDS_ErrorCount > 0, 1, 0) + IF(le.eu1_customer_number_LEFTTRIM_ErrorCount > 0, 1, 0) + IF(le.eu1_customer_number_LENGTHS_ErrorCount > 0, 1, 0) + IF(le.eu1_customer_number_WORDS_ErrorCount > 0, 1, 0) + IF(le.eu1_customer_account_LEFTTRIM_ErrorCount > 0, 1, 0) + IF(le.eu1_customer_account_LENGTHS_ErrorCount > 0, 1, 0) + IF(le.eu1_customer_account_WORDS_ErrorCount > 0, 1, 0) + IF(le.eu2_customer_number_LEFTTRIM_ErrorCount > 0, 1, 0) + IF(le.eu2_customer_number_LENGTHS_ErrorCount > 0, 1, 0) + IF(le.eu2_customer_number_WORDS_ErrorCount > 0, 1, 0) + IF(le.eu2_customer_account_LEFTTRIM_ErrorCount > 0, 1, 0) + IF(le.eu2_customer_account_LENGTHS_ErrorCount > 0, 1, 0) + IF(le.eu2_customer_account_WORDS_ErrorCount > 0, 1, 0) + IF(le.email_addr_LEFTTRIM_ErrorCount > 0, 1, 0) + IF(le.email_addr_LENGTHS_ErrorCount > 0, 1, 0) + IF(le.email_addr_WORDS_ErrorCount > 0, 1, 0) + IF(le.ip_address_LEFTTRIM_ErrorCount > 0, 1, 0) + IF(le.ip_address_LENGTHS_ErrorCount > 0, 1, 0) + IF(le.ip_address_WORDS_ErrorCount > 0, 1, 0) + IF(le.state_id_number_LEFTTRIM_ErrorCount > 0, 1, 0) + IF(le.state_id_number_LENGTHS_ErrorCount > 0, 1, 0) + IF(le.state_id_number_WORDS_ErrorCount > 0, 1, 0) + IF(le.state_id_state_LEFTTRIM_ErrorCount > 0, 1, 0) + IF(le.state_id_state_LENGTHS_ErrorCount > 0, 1, 0) + IF(le.state_id_state_WORDS_ErrorCount > 0, 1, 0) + IF(le.eu_company_name_LEFTTRIM_ErrorCount > 0, 1, 0) + IF(le.eu_company_name_LENGTHS_ErrorCount > 0, 1, 0) + IF(le.eu_company_name_WORDS_ErrorCount > 0, 1, 0) + IF(le.eu_addr_street_LEFTTRIM_ErrorCount > 0, 1, 0) + IF(le.eu_addr_street_LENGTHS_ErrorCount > 0, 1, 0) + IF(le.eu_addr_street_WORDS_ErrorCount > 0, 1, 0) + IF(le.eu_addr_city_LEFTTRIM_ErrorCount > 0, 1, 0) + IF(le.eu_addr_city_LENGTHS_ErrorCount > 0, 1, 0) + IF(le.eu_addr_city_WORDS_ErrorCount > 0, 1, 0) + IF(le.eu_addr_state_LEFTTRIM_ErrorCount > 0, 1, 0) + IF(le.eu_addr_state_LENGTHS_ErrorCount > 0, 1, 0) + IF(le.eu_addr_state_WORDS_ErrorCount > 0, 1, 0) + IF(le.eu_addr_zip5_LEFTTRIM_ErrorCount > 0, 1, 0) + IF(le.eu_addr_zip5_LENGTHS_ErrorCount > 0, 1, 0) + IF(le.eu_addr_zip5_WORDS_ErrorCount > 0, 1, 0) + IF(le.eu_phone_nbr_LEFTTRIM_ErrorCount > 0, 1, 0) + IF(le.eu_phone_nbr_LENGTHS_ErrorCount > 0, 1, 0) + IF(le.eu_phone_nbr_WORDS_ErrorCount > 0, 1, 0) + IF(le.product_code_LEFTTRIM_ErrorCount > 0, 1, 0) + IF(le.product_code_LENGTHS_ErrorCount > 0, 1, 0) + IF(le.product_code_WORDS_ErrorCount > 0, 1, 0) + IF(le.transaction_type_LEFTTRIM_ErrorCount > 0, 1, 0) + IF(le.transaction_type_LENGTHS_ErrorCount > 0, 1, 0) + IF(le.transaction_type_WORDS_ErrorCount > 0, 1, 0) + IF(le.function_name_LEFTTRIM_ErrorCount > 0, 1, 0) + IF(le.function_name_LENGTHS_ErrorCount > 0, 1, 0) + IF(le.function_name_WORDS_ErrorCount > 0, 1, 0) + IF(le.customer_id_LEFTTRIM_ErrorCount > 0, 1, 0) + IF(le.customer_id_LENGTHS_ErrorCount > 0, 1, 0) + IF(le.customer_id_WORDS_ErrorCount > 0, 1, 0) + IF(le.company_id_LEFTTRIM_ErrorCount > 0, 1, 0) + IF(le.company_id_LENGTHS_ErrorCount > 0, 1, 0) + IF(le.company_id_WORDS_ErrorCount > 0, 1, 0) + IF(le.global_company_id_LEFTTRIM_ErrorCount > 0, 1, 0) + IF(le.global_company_id_LENGTHS_ErrorCount > 0, 1, 0) + IF(le.global_company_id_WORDS_ErrorCount > 0, 1, 0) + IF(le.phone_nbr_LEFTTRIM_ErrorCount > 0, 1, 0) + IF(le.phone_nbr_LENGTHS_ErrorCount > 0, 1, 0) + IF(le.phone_nbr_WORDS_ErrorCount > 0, 1, 0);
    SELF.Rules_NoErrors := NumRules - SELF.Rules_WithErrors;
    SELF.Rules_WithEdits := IF(le.product_id_LEFTTRIM_WouldModifyCount > 0, 1, 0) + IF(le.product_id_ALLOW_WouldModifyCount > 0, 1, 0) + IF(le.product_id_LENGTHS_WouldModifyCount > 0, 1, 0) + IF(le.product_id_WORDS_WouldModifyCount > 0, 1, 0) + IF(le.inquiry_date_LEFTTRIM_WouldModifyCount > 0, 1, 0) + IF(le.inquiry_date_ALLOW_WouldModifyCount > 0, 1, 0) + IF(le.inquiry_date_LENGTHS_WouldModifyCount > 0, 1, 0) + IF(le.inquiry_date_WORDS_WouldModifyCount > 0, 1, 0) + IF(le.transaction_id_LEFTTRIM_WouldModifyCount > 0, 1, 0) + IF(le.transaction_id_ALLOW_WouldModifyCount > 0, 1, 0) + IF(le.transaction_id_LENGTHS_WouldModifyCount > 0, 1, 0) + IF(le.transaction_id_WORDS_WouldModifyCount > 0, 1, 0) + IF(le.date_added_LEFTTRIM_WouldModifyCount > 0, 1, 0) + IF(le.date_added_ALLOW_WouldModifyCount > 0, 1, 0) + IF(le.date_added_LENGTHS_WouldModifyCount > 0, 1, 0) + IF(le.date_added_WORDS_WouldModifyCount > 0, 1, 0) + IF(le.customer_number_LEFTTRIM_WouldModifyCount > 0, 1, 0) + IF(le.customer_number_LENGTHS_WouldModifyCount > 0, 1, 0) + IF(le.customer_number_WORDS_WouldModifyCount > 0, 1, 0) + IF(le.customer_account_LEFTTRIM_WouldModifyCount > 0, 1, 0) + IF(le.customer_account_LENGTHS_WouldModifyCount > 0, 1, 0) + IF(le.customer_account_WORDS_WouldModifyCount > 0, 1, 0) + IF(le.ssn_LEFTTRIM_WouldModifyCount > 0, 1, 0) + IF(le.ssn_LENGTHS_WouldModifyCount > 0, 1, 0) + IF(le.ssn_WORDS_WouldModifyCount > 0, 1, 0) + IF(le.drivers_license_number_LEFTTRIM_WouldModifyCount > 0, 1, 0) + IF(le.drivers_license_number_LENGTHS_WouldModifyCount > 0, 1, 0) + IF(le.drivers_license_number_WORDS_WouldModifyCount > 0, 1, 0) + IF(le.drivers_license_state_LEFTTRIM_WouldModifyCount > 0, 1, 0) + IF(le.drivers_license_state_LENGTHS_WouldModifyCount > 0, 1, 0) + IF(le.drivers_license_state_WORDS_WouldModifyCount > 0, 1, 0) + IF(le.name_first_LEFTTRIM_WouldModifyCount > 0, 1, 0) + IF(le.name_first_LENGTHS_WouldModifyCount > 0, 1, 0) + IF(le.name_first_WORDS_WouldModifyCount > 0, 1, 0) + IF(le.name_last_LEFTTRIM_WouldModifyCount > 0, 1, 0) + IF(le.name_last_LENGTHS_WouldModifyCount > 0, 1, 0) + IF(le.name_last_WORDS_WouldModifyCount > 0, 1, 0) + IF(le.name_middle_LEFTTRIM_WouldModifyCount > 0, 1, 0) + IF(le.name_middle_LENGTHS_WouldModifyCount > 0, 1, 0) + IF(le.name_middle_WORDS_WouldModifyCount > 0, 1, 0) + IF(le.name_suffix_LEFTTRIM_WouldModifyCount > 0, 1, 0) + IF(le.name_suffix_LENGTHS_WouldModifyCount > 0, 1, 0) + IF(le.name_suffix_WORDS_WouldModifyCount > 0, 1, 0) + IF(le.addr_street_LEFTTRIM_WouldModifyCount > 0, 1, 0) + IF(le.addr_street_LENGTHS_WouldModifyCount > 0, 1, 0) + IF(le.addr_street_WORDS_WouldModifyCount > 0, 1, 0) + IF(le.addr_city_LEFTTRIM_WouldModifyCount > 0, 1, 0) + IF(le.addr_city_LENGTHS_WouldModifyCount > 0, 1, 0) + IF(le.addr_city_WORDS_WouldModifyCount > 0, 1, 0) + IF(le.addr_state_LEFTTRIM_WouldModifyCount > 0, 1, 0) + IF(le.addr_state_LENGTHS_WouldModifyCount > 0, 1, 0) + IF(le.addr_state_WORDS_WouldModifyCount > 0, 1, 0) + IF(le.addr_zip5_LEFTTRIM_WouldModifyCount > 0, 1, 0) + IF(le.addr_zip5_LENGTHS_WouldModifyCount > 0, 1, 0) + IF(le.addr_zip5_WORDS_WouldModifyCount > 0, 1, 0) + IF(le.addr_zip4_LEFTTRIM_WouldModifyCount > 0, 1, 0) + IF(le.addr_zip4_LENGTHS_WouldModifyCount > 0, 1, 0) + IF(le.addr_zip4_WORDS_WouldModifyCount > 0, 1, 0) + IF(le.dob_LEFTTRIM_WouldModifyCount > 0, 1, 0) + IF(le.dob_LENGTHS_WouldModifyCount > 0, 1, 0) + IF(le.dob_WORDS_WouldModifyCount > 0, 1, 0) + IF(le.transaction_location_LEFTTRIM_WouldModifyCount > 0, 1, 0) + IF(le.transaction_location_LENGTHS_WouldModifyCount > 0, 1, 0) + IF(le.transaction_location_WORDS_WouldModifyCount > 0, 1, 0) + IF(le.ppc_LEFTTRIM_WouldModifyCount > 0, 1, 0) + IF(le.ppc_LENGTHS_WouldModifyCount > 0, 1, 0) + IF(le.ppc_WORDS_WouldModifyCount > 0, 1, 0) + IF(le.internal_identifier_LEFTTRIM_WouldModifyCount > 0, 1, 0) + IF(le.internal_identifier_LENGTHS_WouldModifyCount > 0, 1, 0) + IF(le.internal_identifier_WORDS_WouldModifyCount > 0, 1, 0) + IF(le.eu1_customer_number_LEFTTRIM_WouldModifyCount > 0, 1, 0) + IF(le.eu1_customer_number_LENGTHS_WouldModifyCount > 0, 1, 0) + IF(le.eu1_customer_number_WORDS_WouldModifyCount > 0, 1, 0) + IF(le.eu1_customer_account_LEFTTRIM_WouldModifyCount > 0, 1, 0) + IF(le.eu1_customer_account_LENGTHS_WouldModifyCount > 0, 1, 0) + IF(le.eu1_customer_account_WORDS_WouldModifyCount > 0, 1, 0) + IF(le.eu2_customer_number_LEFTTRIM_WouldModifyCount > 0, 1, 0) + IF(le.eu2_customer_number_LENGTHS_WouldModifyCount > 0, 1, 0) + IF(le.eu2_customer_number_WORDS_WouldModifyCount > 0, 1, 0) + IF(le.eu2_customer_account_LEFTTRIM_WouldModifyCount > 0, 1, 0) + IF(le.eu2_customer_account_LENGTHS_WouldModifyCount > 0, 1, 0) + IF(le.eu2_customer_account_WORDS_WouldModifyCount > 0, 1, 0) + IF(le.email_addr_LEFTTRIM_WouldModifyCount > 0, 1, 0) + IF(le.email_addr_LENGTHS_WouldModifyCount > 0, 1, 0) + IF(le.email_addr_WORDS_WouldModifyCount > 0, 1, 0) + IF(le.ip_address_LEFTTRIM_WouldModifyCount > 0, 1, 0) + IF(le.ip_address_LENGTHS_WouldModifyCount > 0, 1, 0) + IF(le.ip_address_WORDS_WouldModifyCount > 0, 1, 0) + IF(le.state_id_number_LEFTTRIM_WouldModifyCount > 0, 1, 0) + IF(le.state_id_number_LENGTHS_WouldModifyCount > 0, 1, 0) + IF(le.state_id_number_WORDS_WouldModifyCount > 0, 1, 0) + IF(le.state_id_state_LEFTTRIM_WouldModifyCount > 0, 1, 0) + IF(le.state_id_state_LENGTHS_WouldModifyCount > 0, 1, 0) + IF(le.state_id_state_WORDS_WouldModifyCount > 0, 1, 0) + IF(le.eu_company_name_LEFTTRIM_WouldModifyCount > 0, 1, 0) + IF(le.eu_company_name_LENGTHS_WouldModifyCount > 0, 1, 0) + IF(le.eu_company_name_WORDS_WouldModifyCount > 0, 1, 0) + IF(le.eu_addr_street_LEFTTRIM_WouldModifyCount > 0, 1, 0) + IF(le.eu_addr_street_LENGTHS_WouldModifyCount > 0, 1, 0) + IF(le.eu_addr_street_WORDS_WouldModifyCount > 0, 1, 0) + IF(le.eu_addr_city_LEFTTRIM_WouldModifyCount > 0, 1, 0) + IF(le.eu_addr_city_LENGTHS_WouldModifyCount > 0, 1, 0) + IF(le.eu_addr_city_WORDS_WouldModifyCount > 0, 1, 0) + IF(le.eu_addr_state_LEFTTRIM_WouldModifyCount > 0, 1, 0) + IF(le.eu_addr_state_LENGTHS_WouldModifyCount > 0, 1, 0) + IF(le.eu_addr_state_WORDS_WouldModifyCount > 0, 1, 0) + IF(le.eu_addr_zip5_LEFTTRIM_WouldModifyCount > 0, 1, 0) + IF(le.eu_addr_zip5_LENGTHS_WouldModifyCount > 0, 1, 0) + IF(le.eu_addr_zip5_WORDS_WouldModifyCount > 0, 1, 0) + IF(le.eu_phone_nbr_LEFTTRIM_WouldModifyCount > 0, 1, 0) + IF(le.eu_phone_nbr_LENGTHS_WouldModifyCount > 0, 1, 0) + IF(le.eu_phone_nbr_WORDS_WouldModifyCount > 0, 1, 0) + IF(le.product_code_LEFTTRIM_WouldModifyCount > 0, 1, 0) + IF(le.product_code_LENGTHS_WouldModifyCount > 0, 1, 0) + IF(le.product_code_WORDS_WouldModifyCount > 0, 1, 0) + IF(le.transaction_type_LEFTTRIM_WouldModifyCount > 0, 1, 0) + IF(le.transaction_type_LENGTHS_WouldModifyCount > 0, 1, 0) + IF(le.transaction_type_WORDS_WouldModifyCount > 0, 1, 0) + IF(le.function_name_LEFTTRIM_WouldModifyCount > 0, 1, 0) + IF(le.function_name_LENGTHS_WouldModifyCount > 0, 1, 0) + IF(le.function_name_WORDS_WouldModifyCount > 0, 1, 0) + IF(le.customer_id_LEFTTRIM_WouldModifyCount > 0, 1, 0) + IF(le.customer_id_LENGTHS_WouldModifyCount > 0, 1, 0) + IF(le.customer_id_WORDS_WouldModifyCount > 0, 1, 0) + IF(le.company_id_LEFTTRIM_WouldModifyCount > 0, 1, 0) + IF(le.company_id_LENGTHS_WouldModifyCount > 0, 1, 0) + IF(le.company_id_WORDS_WouldModifyCount > 0, 1, 0) + IF(le.global_company_id_LEFTTRIM_WouldModifyCount > 0, 1, 0) + IF(le.global_company_id_LENGTHS_WouldModifyCount > 0, 1, 0) + IF(le.global_company_id_WORDS_WouldModifyCount > 0, 1, 0) + IF(le.phone_nbr_LEFTTRIM_WouldModifyCount > 0, 1, 0) + IF(le.phone_nbr_LENGTHS_WouldModifyCount > 0, 1, 0) + IF(le.phone_nbr_WORDS_WouldModifyCount > 0, 1, 0);
    SELF := le;
  END;
  EXPORT SummaryStats := PROJECT(SummaryStats0, xAddErrSummary(LEFT));
  r := RECORD
    STRING10 Src;
    STRING FieldName;
    STRING FieldType;
    STRING ErrorType;
    SALT311.StrType ErrorMessage;
    SALT311.StrType FieldContents;
  END;
  r into(h le,UNSIGNED c) := TRANSFORM
    SELF.Src :=  ''; // Source not provided
    UNSIGNED1 ErrNum := CHOOSE(c,le.lex_id_Invalid,le.product_id_Invalid,le.inquiry_date_Invalid,le.transaction_id_Invalid,le.date_added_Invalid,le.customer_number_Invalid,le.customer_account_Invalid,le.ssn_Invalid,le.drivers_license_number_Invalid,le.drivers_license_state_Invalid,le.name_first_Invalid,le.name_last_Invalid,le.name_middle_Invalid,le.name_suffix_Invalid,le.addr_street_Invalid,le.addr_city_Invalid,le.addr_state_Invalid,le.addr_zip5_Invalid,le.addr_zip4_Invalid,le.dob_Invalid,le.transaction_location_Invalid,le.ppc_Invalid,le.internal_identifier_Invalid,le.eu1_customer_number_Invalid,le.eu1_customer_account_Invalid,le.eu2_customer_number_Invalid,le.eu2_customer_account_Invalid,le.email_addr_Invalid,le.ip_address_Invalid,le.state_id_number_Invalid,le.state_id_state_Invalid,le.eu_company_name_Invalid,le.eu_addr_street_Invalid,le.eu_addr_city_Invalid,le.eu_addr_state_Invalid,le.eu_addr_zip5_Invalid,le.eu_phone_nbr_Invalid,le.product_code_Invalid,le.transaction_type_Invalid,le.function_name_Invalid,le.customer_id_Invalid,le.company_id_Invalid,le.global_company_id_Invalid,le.phone_nbr_Invalid,100);
    SELF.ErrorMessage := IF ( ErrNum = 0, SKIP, CHOOSE(c,Fields.InvalidMessage_lex_id(le.lex_id_Invalid),Fields.InvalidMessage_product_id(le.product_id_Invalid),Fields.InvalidMessage_inquiry_date(le.inquiry_date_Invalid),Fields.InvalidMessage_transaction_id(le.transaction_id_Invalid),Fields.InvalidMessage_date_added(le.date_added_Invalid),Fields.InvalidMessage_customer_number(le.customer_number_Invalid),Fields.InvalidMessage_customer_account(le.customer_account_Invalid),Fields.InvalidMessage_ssn(le.ssn_Invalid),Fields.InvalidMessage_drivers_license_number(le.drivers_license_number_Invalid),Fields.InvalidMessage_drivers_license_state(le.drivers_license_state_Invalid),Fields.InvalidMessage_name_first(le.name_first_Invalid),Fields.InvalidMessage_name_last(le.name_last_Invalid),Fields.InvalidMessage_name_middle(le.name_middle_Invalid),Fields.InvalidMessage_name_suffix(le.name_suffix_Invalid),Fields.InvalidMessage_addr_street(le.addr_street_Invalid),Fields.InvalidMessage_addr_city(le.addr_city_Invalid),Fields.InvalidMessage_addr_state(le.addr_state_Invalid),Fields.InvalidMessage_addr_zip5(le.addr_zip5_Invalid),Fields.InvalidMessage_addr_zip4(le.addr_zip4_Invalid),Fields.InvalidMessage_dob(le.dob_Invalid),Fields.InvalidMessage_transaction_location(le.transaction_location_Invalid),Fields.InvalidMessage_ppc(le.ppc_Invalid),Fields.InvalidMessage_internal_identifier(le.internal_identifier_Invalid),Fields.InvalidMessage_eu1_customer_number(le.eu1_customer_number_Invalid),Fields.InvalidMessage_eu1_customer_account(le.eu1_customer_account_Invalid),Fields.InvalidMessage_eu2_customer_number(le.eu2_customer_number_Invalid),Fields.InvalidMessage_eu2_customer_account(le.eu2_customer_account_Invalid),Fields.InvalidMessage_email_addr(le.email_addr_Invalid),Fields.InvalidMessage_ip_address(le.ip_address_Invalid),Fields.InvalidMessage_state_id_number(le.state_id_number_Invalid),Fields.InvalidMessage_state_id_state(le.state_id_state_Invalid),Fields.InvalidMessage_eu_company_name(le.eu_company_name_Invalid),Fields.InvalidMessage_eu_addr_street(le.eu_addr_street_Invalid),Fields.InvalidMessage_eu_addr_city(le.eu_addr_city_Invalid),Fields.InvalidMessage_eu_addr_state(le.eu_addr_state_Invalid),Fields.InvalidMessage_eu_addr_zip5(le.eu_addr_zip5_Invalid),Fields.InvalidMessage_eu_phone_nbr(le.eu_phone_nbr_Invalid),Fields.InvalidMessage_product_code(le.product_code_Invalid),Fields.InvalidMessage_transaction_type(le.transaction_type_Invalid),Fields.InvalidMessage_function_name(le.function_name_Invalid),Fields.InvalidMessage_customer_id(le.customer_id_Invalid),Fields.InvalidMessage_company_id(le.company_id_Invalid),Fields.InvalidMessage_global_company_id(le.global_company_id_Invalid),Fields.InvalidMessage_phone_nbr(le.phone_nbr_Invalid),'UNKNOWN'));
    SELF.ErrorType := IF ( ErrNum = 0, SKIP, CHOOSE(c
          ,CHOOSE(le.lex_id_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.product_id_Invalid,'LEFTTRIM','ALLOW','LENGTHS','WORDS','UNKNOWN')
          ,CHOOSE(le.inquiry_date_Invalid,'LEFTTRIM','ALLOW','LENGTHS','WORDS','UNKNOWN')
          ,CHOOSE(le.transaction_id_Invalid,'LEFTTRIM','ALLOW','LENGTHS','WORDS','UNKNOWN')
          ,CHOOSE(le.date_added_Invalid,'LEFTTRIM','ALLOW','LENGTHS','WORDS','UNKNOWN')
          ,CHOOSE(le.customer_number_Invalid,'LEFTTRIM','LENGTHS','WORDS','UNKNOWN')
          ,CHOOSE(le.customer_account_Invalid,'LEFTTRIM','LENGTHS','WORDS','UNKNOWN')
          ,CHOOSE(le.ssn_Invalid,'LEFTTRIM','LENGTHS','WORDS','UNKNOWN')
          ,CHOOSE(le.drivers_license_number_Invalid,'LEFTTRIM','LENGTHS','WORDS','UNKNOWN')
          ,CHOOSE(le.drivers_license_state_Invalid,'LEFTTRIM','LENGTHS','WORDS','UNKNOWN')
          ,CHOOSE(le.name_first_Invalid,'LEFTTRIM','LENGTHS','WORDS','UNKNOWN')
          ,CHOOSE(le.name_last_Invalid,'LEFTTRIM','LENGTHS','WORDS','UNKNOWN')
          ,CHOOSE(le.name_middle_Invalid,'LEFTTRIM','LENGTHS','WORDS','UNKNOWN')
          ,CHOOSE(le.name_suffix_Invalid,'LEFTTRIM','LENGTHS','WORDS','UNKNOWN')
          ,CHOOSE(le.addr_street_Invalid,'LEFTTRIM','LENGTHS','WORDS','UNKNOWN')
          ,CHOOSE(le.addr_city_Invalid,'LEFTTRIM','LENGTHS','WORDS','UNKNOWN')
          ,CHOOSE(le.addr_state_Invalid,'LEFTTRIM','LENGTHS','WORDS','UNKNOWN')
          ,CHOOSE(le.addr_zip5_Invalid,'LEFTTRIM','LENGTHS','WORDS','UNKNOWN')
          ,CHOOSE(le.addr_zip4_Invalid,'LEFTTRIM','LENGTHS','WORDS','UNKNOWN')
          ,CHOOSE(le.dob_Invalid,'LEFTTRIM','LENGTHS','WORDS','UNKNOWN')
          ,CHOOSE(le.transaction_location_Invalid,'LEFTTRIM','LENGTHS','WORDS','UNKNOWN')
          ,CHOOSE(le.ppc_Invalid,'LEFTTRIM','LENGTHS','WORDS','UNKNOWN')
          ,CHOOSE(le.internal_identifier_Invalid,'LEFTTRIM','LENGTHS','WORDS','UNKNOWN')
          ,CHOOSE(le.eu1_customer_number_Invalid,'LEFTTRIM','LENGTHS','WORDS','UNKNOWN')
          ,CHOOSE(le.eu1_customer_account_Invalid,'LEFTTRIM','LENGTHS','WORDS','UNKNOWN')
          ,CHOOSE(le.eu2_customer_number_Invalid,'LEFTTRIM','LENGTHS','WORDS','UNKNOWN')
          ,CHOOSE(le.eu2_customer_account_Invalid,'LEFTTRIM','LENGTHS','WORDS','UNKNOWN')
          ,CHOOSE(le.email_addr_Invalid,'LEFTTRIM','LENGTHS','WORDS','UNKNOWN')
          ,CHOOSE(le.ip_address_Invalid,'LEFTTRIM','LENGTHS','WORDS','UNKNOWN')
          ,CHOOSE(le.state_id_number_Invalid,'LEFTTRIM','LENGTHS','WORDS','UNKNOWN')
          ,CHOOSE(le.state_id_state_Invalid,'LEFTTRIM','LENGTHS','WORDS','UNKNOWN')
          ,CHOOSE(le.eu_company_name_Invalid,'LEFTTRIM','LENGTHS','WORDS','UNKNOWN')
          ,CHOOSE(le.eu_addr_street_Invalid,'LEFTTRIM','LENGTHS','WORDS','UNKNOWN')
          ,CHOOSE(le.eu_addr_city_Invalid,'LEFTTRIM','LENGTHS','WORDS','UNKNOWN')
          ,CHOOSE(le.eu_addr_state_Invalid,'LEFTTRIM','LENGTHS','WORDS','UNKNOWN')
          ,CHOOSE(le.eu_addr_zip5_Invalid,'LEFTTRIM','LENGTHS','WORDS','UNKNOWN')
          ,CHOOSE(le.eu_phone_nbr_Invalid,'LEFTTRIM','LENGTHS','WORDS','UNKNOWN')
          ,CHOOSE(le.product_code_Invalid,'LEFTTRIM','LENGTHS','WORDS','UNKNOWN')
          ,CHOOSE(le.transaction_type_Invalid,'LEFTTRIM','LENGTHS','WORDS','UNKNOWN')
          ,CHOOSE(le.function_name_Invalid,'LEFTTRIM','LENGTHS','WORDS','UNKNOWN')
          ,CHOOSE(le.customer_id_Invalid,'LEFTTRIM','LENGTHS','WORDS','UNKNOWN')
          ,CHOOSE(le.company_id_Invalid,'LEFTTRIM','LENGTHS','WORDS','UNKNOWN')
          ,CHOOSE(le.global_company_id_Invalid,'LEFTTRIM','LENGTHS','WORDS','UNKNOWN')
          ,CHOOSE(le.phone_nbr_Invalid,'LEFTTRIM','LENGTHS','WORDS','UNKNOWN'),'UNKNOWN'));
    SELF.FieldName := CHOOSE(c,'lex_id','product_id','inquiry_date','transaction_id','date_added','customer_number','customer_account','ssn','drivers_license_number','drivers_license_state','name_first','name_last','name_middle','name_suffix','addr_street','addr_city','addr_state','addr_zip5','addr_zip4','dob','transaction_location','ppc','internal_identifier','eu1_customer_number','eu1_customer_account','eu2_customer_number','eu2_customer_account','email_addr','ip_address','state_id_number','state_id_state','eu_company_name','eu_addr_street','eu_addr_city','eu_addr_state','eu_addr_zip5','eu_phone_nbr','product_code','transaction_type','function_name','customer_id','company_id','global_company_id','phone_nbr','UNKNOWN');
    SELF.FieldType := CHOOSE(c,'NUMBER','product_id','inquiry_date','transaction_id','date_added','customer_number','customer_account','ssn','drivers_license_number','drivers_license_state','name_first','name_last','name_middle','name_suffix','addr_street','addr_city','addr_state','addr_zip5','addr_zip4','dob','transaction_location','ppc','internal_identifier','eu1_customer_number','eu1_customer_account','eu2_customer_number','eu2_customer_account','email_addr','ip_address','state_id_number','state_id_state','eu_company_name','eu_addr_street','eu_addr_city','eu_addr_state','eu_addr_zip5','eu_phone_nbr','product_code','transaction_type','function_name','customer_id','company_id','global_company_id','phone_nbr','UNKNOWN');
    SELF.FieldContents := CHOOSE(c,(SALT311.StrType)le.lex_id,(SALT311.StrType)le.product_id,(SALT311.StrType)le.inquiry_date,(SALT311.StrType)le.transaction_id,(SALT311.StrType)le.date_added,(SALT311.StrType)le.customer_number,(SALT311.StrType)le.customer_account,(SALT311.StrType)le.ssn,(SALT311.StrType)le.drivers_license_number,(SALT311.StrType)le.drivers_license_state,(SALT311.StrType)le.name_first,(SALT311.StrType)le.name_last,(SALT311.StrType)le.name_middle,(SALT311.StrType)le.name_suffix,(SALT311.StrType)le.addr_street,(SALT311.StrType)le.addr_city,(SALT311.StrType)le.addr_state,(SALT311.StrType)le.addr_zip5,(SALT311.StrType)le.addr_zip4,(SALT311.StrType)le.dob,(SALT311.StrType)le.transaction_location,(SALT311.StrType)le.ppc,(SALT311.StrType)le.internal_identifier,(SALT311.StrType)le.eu1_customer_number,(SALT311.StrType)le.eu1_customer_account,(SALT311.StrType)le.eu2_customer_number,(SALT311.StrType)le.eu2_customer_account,(SALT311.StrType)le.email_addr,(SALT311.StrType)le.ip_address,(SALT311.StrType)le.state_id_number,(SALT311.StrType)le.state_id_state,(SALT311.StrType)le.eu_company_name,(SALT311.StrType)le.eu_addr_street,(SALT311.StrType)le.eu_addr_city,(SALT311.StrType)le.eu_addr_state,(SALT311.StrType)le.eu_addr_zip5,(SALT311.StrType)le.eu_phone_nbr,(SALT311.StrType)le.product_code,(SALT311.StrType)le.transaction_type,(SALT311.StrType)le.function_name,(SALT311.StrType)le.customer_id,(SALT311.StrType)le.company_id,(SALT311.StrType)le.global_company_id,(SALT311.StrType)le.phone_nbr,'***SALTBUG***');
  END;
  EXPORT AllErrors := NORMALIZE(h,44,Into(LEFT,COUNTER));
   bv := TABLE(AllErrors,{FieldContents, FieldName, Cnt := COUNT(GROUP)},FieldContents, FieldName,MERGE);
  EXPORT BadValues := TOPN(bv,1000,-Cnt);
  // Particular form of stats required for Orbit
  EXPORT OrbitStats(UNSIGNED examples = 10, UNSIGNED Pdate=(UNSIGNED)StringLib.getdateYYYYMMDD(), DATASET(Layout_File) prevDS = DATASET([], Layout_File), STRING10 Src='UNK'):= FUNCTION
  // field error stats
    SALT311.ScrubsOrbitLayout Into(SummaryStats le, UNSIGNED c) := TRANSFORM
      SELF.recordstotal := le.TotalCnt;
      SELF.processdate := Pdate;
      SELF.sourcecode := src;
      SELF.ruledesc := CHOOSE(c
          ,'lex_id:NUMBER:ALLOW'
          ,'product_id:product_id:LEFTTRIM','product_id:product_id:ALLOW','product_id:product_id:LENGTHS','product_id:product_id:WORDS'
          ,'inquiry_date:inquiry_date:LEFTTRIM','inquiry_date:inquiry_date:ALLOW','inquiry_date:inquiry_date:LENGTHS','inquiry_date:inquiry_date:WORDS'
          ,'transaction_id:transaction_id:LEFTTRIM','transaction_id:transaction_id:ALLOW','transaction_id:transaction_id:LENGTHS','transaction_id:transaction_id:WORDS'
          ,'date_added:date_added:LEFTTRIM','date_added:date_added:ALLOW','date_added:date_added:LENGTHS','date_added:date_added:WORDS'
          ,'customer_number:customer_number:LEFTTRIM','customer_number:customer_number:LENGTHS','customer_number:customer_number:WORDS'
          ,'customer_account:customer_account:LEFTTRIM','customer_account:customer_account:LENGTHS','customer_account:customer_account:WORDS'
          ,'ssn:ssn:LEFTTRIM','ssn:ssn:LENGTHS','ssn:ssn:WORDS'
          ,'drivers_license_number:drivers_license_number:LEFTTRIM','drivers_license_number:drivers_license_number:LENGTHS','drivers_license_number:drivers_license_number:WORDS'
          ,'drivers_license_state:drivers_license_state:LEFTTRIM','drivers_license_state:drivers_license_state:LENGTHS','drivers_license_state:drivers_license_state:WORDS'
          ,'name_first:name_first:LEFTTRIM','name_first:name_first:LENGTHS','name_first:name_first:WORDS'
          ,'name_last:name_last:LEFTTRIM','name_last:name_last:LENGTHS','name_last:name_last:WORDS'
          ,'name_middle:name_middle:LEFTTRIM','name_middle:name_middle:LENGTHS','name_middle:name_middle:WORDS'
          ,'name_suffix:name_suffix:LEFTTRIM','name_suffix:name_suffix:LENGTHS','name_suffix:name_suffix:WORDS'
          ,'addr_street:addr_street:LEFTTRIM','addr_street:addr_street:LENGTHS','addr_street:addr_street:WORDS'
          ,'addr_city:addr_city:LEFTTRIM','addr_city:addr_city:LENGTHS','addr_city:addr_city:WORDS'
          ,'addr_state:addr_state:LEFTTRIM','addr_state:addr_state:LENGTHS','addr_state:addr_state:WORDS'
          ,'addr_zip5:addr_zip5:LEFTTRIM','addr_zip5:addr_zip5:LENGTHS','addr_zip5:addr_zip5:WORDS'
          ,'addr_zip4:addr_zip4:LEFTTRIM','addr_zip4:addr_zip4:LENGTHS','addr_zip4:addr_zip4:WORDS'
          ,'dob:dob:LEFTTRIM','dob:dob:LENGTHS','dob:dob:WORDS'
          ,'transaction_location:transaction_location:LEFTTRIM','transaction_location:transaction_location:LENGTHS','transaction_location:transaction_location:WORDS'
          ,'ppc:ppc:LEFTTRIM','ppc:ppc:LENGTHS','ppc:ppc:WORDS'
          ,'internal_identifier:internal_identifier:LEFTTRIM','internal_identifier:internal_identifier:LENGTHS','internal_identifier:internal_identifier:WORDS'
          ,'eu1_customer_number:eu1_customer_number:LEFTTRIM','eu1_customer_number:eu1_customer_number:LENGTHS','eu1_customer_number:eu1_customer_number:WORDS'
          ,'eu1_customer_account:eu1_customer_account:LEFTTRIM','eu1_customer_account:eu1_customer_account:LENGTHS','eu1_customer_account:eu1_customer_account:WORDS'
          ,'eu2_customer_number:eu2_customer_number:LEFTTRIM','eu2_customer_number:eu2_customer_number:LENGTHS','eu2_customer_number:eu2_customer_number:WORDS'
          ,'eu2_customer_account:eu2_customer_account:LEFTTRIM','eu2_customer_account:eu2_customer_account:LENGTHS','eu2_customer_account:eu2_customer_account:WORDS'
          ,'email_addr:email_addr:LEFTTRIM','email_addr:email_addr:LENGTHS','email_addr:email_addr:WORDS'
          ,'ip_address:ip_address:LEFTTRIM','ip_address:ip_address:LENGTHS','ip_address:ip_address:WORDS'
          ,'state_id_number:state_id_number:LEFTTRIM','state_id_number:state_id_number:LENGTHS','state_id_number:state_id_number:WORDS'
          ,'state_id_state:state_id_state:LEFTTRIM','state_id_state:state_id_state:LENGTHS','state_id_state:state_id_state:WORDS'
          ,'eu_company_name:eu_company_name:LEFTTRIM','eu_company_name:eu_company_name:LENGTHS','eu_company_name:eu_company_name:WORDS'
          ,'eu_addr_street:eu_addr_street:LEFTTRIM','eu_addr_street:eu_addr_street:LENGTHS','eu_addr_street:eu_addr_street:WORDS'
          ,'eu_addr_city:eu_addr_city:LEFTTRIM','eu_addr_city:eu_addr_city:LENGTHS','eu_addr_city:eu_addr_city:WORDS'
          ,'eu_addr_state:eu_addr_state:LEFTTRIM','eu_addr_state:eu_addr_state:LENGTHS','eu_addr_state:eu_addr_state:WORDS'
          ,'eu_addr_zip5:eu_addr_zip5:LEFTTRIM','eu_addr_zip5:eu_addr_zip5:LENGTHS','eu_addr_zip5:eu_addr_zip5:WORDS'
          ,'eu_phone_nbr:eu_phone_nbr:LEFTTRIM','eu_phone_nbr:eu_phone_nbr:LENGTHS','eu_phone_nbr:eu_phone_nbr:WORDS'
          ,'product_code:product_code:LEFTTRIM','product_code:product_code:LENGTHS','product_code:product_code:WORDS'
          ,'transaction_type:transaction_type:LEFTTRIM','transaction_type:transaction_type:LENGTHS','transaction_type:transaction_type:WORDS'
          ,'function_name:function_name:LEFTTRIM','function_name:function_name:LENGTHS','function_name:function_name:WORDS'
          ,'customer_id:customer_id:LEFTTRIM','customer_id:customer_id:LENGTHS','customer_id:customer_id:WORDS'
          ,'company_id:company_id:LEFTTRIM','company_id:company_id:LENGTHS','company_id:company_id:WORDS'
          ,'global_company_id:global_company_id:LEFTTRIM','global_company_id:global_company_id:LENGTHS','global_company_id:global_company_id:WORDS'
          ,'phone_nbr:phone_nbr:LEFTTRIM','phone_nbr:phone_nbr:LENGTHS','phone_nbr:phone_nbr:WORDS'
          ,'field:Number_Errored_Fields:SUMMARY'
          ,'field:Number_Perfect_Fields:SUMMARY'
          ,'rule:Number_Errored_Rules:SUMMARY'
          ,'rule:Number_Perfect_Rules:SUMMARY'
          ,'rule:Number_OnFail_Rules:SUMMARY'
          ,'record:Number_Errored_Records:SUMMARY'
          ,'record:Number_Perfect_Records:SUMMARY'
          ,'record:Number_Edited_Records:SUMMARY'
          ,'rule:Number_Edited_Rules:SUMMARY','UNKNOWN');
      SELF.ErrorMessage := CHOOSE(c
          ,Fields.InvalidMessage_lex_id(1)
          ,Fields.InvalidMessage_product_id(1),Fields.InvalidMessage_product_id(2),Fields.InvalidMessage_product_id(3),Fields.InvalidMessage_product_id(4)
          ,Fields.InvalidMessage_inquiry_date(1),Fields.InvalidMessage_inquiry_date(2),Fields.InvalidMessage_inquiry_date(3),Fields.InvalidMessage_inquiry_date(4)
          ,Fields.InvalidMessage_transaction_id(1),Fields.InvalidMessage_transaction_id(2),Fields.InvalidMessage_transaction_id(3),Fields.InvalidMessage_transaction_id(4)
          ,Fields.InvalidMessage_date_added(1),Fields.InvalidMessage_date_added(2),Fields.InvalidMessage_date_added(3),Fields.InvalidMessage_date_added(4)
          ,Fields.InvalidMessage_customer_number(1),Fields.InvalidMessage_customer_number(2),Fields.InvalidMessage_customer_number(3)
          ,Fields.InvalidMessage_customer_account(1),Fields.InvalidMessage_customer_account(2),Fields.InvalidMessage_customer_account(3)
          ,Fields.InvalidMessage_ssn(1),Fields.InvalidMessage_ssn(2),Fields.InvalidMessage_ssn(3)
          ,Fields.InvalidMessage_drivers_license_number(1),Fields.InvalidMessage_drivers_license_number(2),Fields.InvalidMessage_drivers_license_number(3)
          ,Fields.InvalidMessage_drivers_license_state(1),Fields.InvalidMessage_drivers_license_state(2),Fields.InvalidMessage_drivers_license_state(3)
          ,Fields.InvalidMessage_name_first(1),Fields.InvalidMessage_name_first(2),Fields.InvalidMessage_name_first(3)
          ,Fields.InvalidMessage_name_last(1),Fields.InvalidMessage_name_last(2),Fields.InvalidMessage_name_last(3)
          ,Fields.InvalidMessage_name_middle(1),Fields.InvalidMessage_name_middle(2),Fields.InvalidMessage_name_middle(3)
          ,Fields.InvalidMessage_name_suffix(1),Fields.InvalidMessage_name_suffix(2),Fields.InvalidMessage_name_suffix(3)
          ,Fields.InvalidMessage_addr_street(1),Fields.InvalidMessage_addr_street(2),Fields.InvalidMessage_addr_street(3)
          ,Fields.InvalidMessage_addr_city(1),Fields.InvalidMessage_addr_city(2),Fields.InvalidMessage_addr_city(3)
          ,Fields.InvalidMessage_addr_state(1),Fields.InvalidMessage_addr_state(2),Fields.InvalidMessage_addr_state(3)
          ,Fields.InvalidMessage_addr_zip5(1),Fields.InvalidMessage_addr_zip5(2),Fields.InvalidMessage_addr_zip5(3)
          ,Fields.InvalidMessage_addr_zip4(1),Fields.InvalidMessage_addr_zip4(2),Fields.InvalidMessage_addr_zip4(3)
          ,Fields.InvalidMessage_dob(1),Fields.InvalidMessage_dob(2),Fields.InvalidMessage_dob(3)
          ,Fields.InvalidMessage_transaction_location(1),Fields.InvalidMessage_transaction_location(2),Fields.InvalidMessage_transaction_location(3)
          ,Fields.InvalidMessage_ppc(1),Fields.InvalidMessage_ppc(2),Fields.InvalidMessage_ppc(3)
          ,Fields.InvalidMessage_internal_identifier(1),Fields.InvalidMessage_internal_identifier(2),Fields.InvalidMessage_internal_identifier(3)
          ,Fields.InvalidMessage_eu1_customer_number(1),Fields.InvalidMessage_eu1_customer_number(2),Fields.InvalidMessage_eu1_customer_number(3)
          ,Fields.InvalidMessage_eu1_customer_account(1),Fields.InvalidMessage_eu1_customer_account(2),Fields.InvalidMessage_eu1_customer_account(3)
          ,Fields.InvalidMessage_eu2_customer_number(1),Fields.InvalidMessage_eu2_customer_number(2),Fields.InvalidMessage_eu2_customer_number(3)
          ,Fields.InvalidMessage_eu2_customer_account(1),Fields.InvalidMessage_eu2_customer_account(2),Fields.InvalidMessage_eu2_customer_account(3)
          ,Fields.InvalidMessage_email_addr(1),Fields.InvalidMessage_email_addr(2),Fields.InvalidMessage_email_addr(3)
          ,Fields.InvalidMessage_ip_address(1),Fields.InvalidMessage_ip_address(2),Fields.InvalidMessage_ip_address(3)
          ,Fields.InvalidMessage_state_id_number(1),Fields.InvalidMessage_state_id_number(2),Fields.InvalidMessage_state_id_number(3)
          ,Fields.InvalidMessage_state_id_state(1),Fields.InvalidMessage_state_id_state(2),Fields.InvalidMessage_state_id_state(3)
          ,Fields.InvalidMessage_eu_company_name(1),Fields.InvalidMessage_eu_company_name(2),Fields.InvalidMessage_eu_company_name(3)
          ,Fields.InvalidMessage_eu_addr_street(1),Fields.InvalidMessage_eu_addr_street(2),Fields.InvalidMessage_eu_addr_street(3)
          ,Fields.InvalidMessage_eu_addr_city(1),Fields.InvalidMessage_eu_addr_city(2),Fields.InvalidMessage_eu_addr_city(3)
          ,Fields.InvalidMessage_eu_addr_state(1),Fields.InvalidMessage_eu_addr_state(2),Fields.InvalidMessage_eu_addr_state(3)
          ,Fields.InvalidMessage_eu_addr_zip5(1),Fields.InvalidMessage_eu_addr_zip5(2),Fields.InvalidMessage_eu_addr_zip5(3)
          ,Fields.InvalidMessage_eu_phone_nbr(1),Fields.InvalidMessage_eu_phone_nbr(2),Fields.InvalidMessage_eu_phone_nbr(3)
          ,Fields.InvalidMessage_product_code(1),Fields.InvalidMessage_product_code(2),Fields.InvalidMessage_product_code(3)
          ,Fields.InvalidMessage_transaction_type(1),Fields.InvalidMessage_transaction_type(2),Fields.InvalidMessage_transaction_type(3)
          ,Fields.InvalidMessage_function_name(1),Fields.InvalidMessage_function_name(2),Fields.InvalidMessage_function_name(3)
          ,Fields.InvalidMessage_customer_id(1),Fields.InvalidMessage_customer_id(2),Fields.InvalidMessage_customer_id(3)
          ,Fields.InvalidMessage_company_id(1),Fields.InvalidMessage_company_id(2),Fields.InvalidMessage_company_id(3)
          ,Fields.InvalidMessage_global_company_id(1),Fields.InvalidMessage_global_company_id(2),Fields.InvalidMessage_global_company_id(3)
          ,Fields.InvalidMessage_phone_nbr(1),Fields.InvalidMessage_phone_nbr(2),Fields.InvalidMessage_phone_nbr(3)
          ,'Fields with errors'
          ,'Fields without errors'
          ,'Rules with errors'
          ,'Rules without errors'
          ,'Rules with possible edits'
          ,'Records with at least one error'
          ,'Records without errors'
          ,'Edited records'
          ,'Rules leading to edits','UNKNOWN');
      SELF.rulecnt := CHOOSE(c
          ,le.lex_id_ALLOW_ErrorCount
          ,le.product_id_LEFTTRIM_ErrorCount,le.product_id_ALLOW_ErrorCount,le.product_id_LENGTHS_ErrorCount,le.product_id_WORDS_ErrorCount
          ,le.inquiry_date_LEFTTRIM_ErrorCount,le.inquiry_date_ALLOW_ErrorCount,le.inquiry_date_LENGTHS_ErrorCount,le.inquiry_date_WORDS_ErrorCount
          ,le.transaction_id_LEFTTRIM_ErrorCount,le.transaction_id_ALLOW_ErrorCount,le.transaction_id_LENGTHS_ErrorCount,le.transaction_id_WORDS_ErrorCount
          ,le.date_added_LEFTTRIM_ErrorCount,le.date_added_ALLOW_ErrorCount,le.date_added_LENGTHS_ErrorCount,le.date_added_WORDS_ErrorCount
          ,le.customer_number_LEFTTRIM_ErrorCount,le.customer_number_LENGTHS_ErrorCount,le.customer_number_WORDS_ErrorCount
          ,le.customer_account_LEFTTRIM_ErrorCount,le.customer_account_LENGTHS_ErrorCount,le.customer_account_WORDS_ErrorCount
          ,le.ssn_LEFTTRIM_ErrorCount,le.ssn_LENGTHS_ErrorCount,le.ssn_WORDS_ErrorCount
          ,le.drivers_license_number_LEFTTRIM_ErrorCount,le.drivers_license_number_LENGTHS_ErrorCount,le.drivers_license_number_WORDS_ErrorCount
          ,le.drivers_license_state_LEFTTRIM_ErrorCount,le.drivers_license_state_LENGTHS_ErrorCount,le.drivers_license_state_WORDS_ErrorCount
          ,le.name_first_LEFTTRIM_ErrorCount,le.name_first_LENGTHS_ErrorCount,le.name_first_WORDS_ErrorCount
          ,le.name_last_LEFTTRIM_ErrorCount,le.name_last_LENGTHS_ErrorCount,le.name_last_WORDS_ErrorCount
          ,le.name_middle_LEFTTRIM_ErrorCount,le.name_middle_LENGTHS_ErrorCount,le.name_middle_WORDS_ErrorCount
          ,le.name_suffix_LEFTTRIM_ErrorCount,le.name_suffix_LENGTHS_ErrorCount,le.name_suffix_WORDS_ErrorCount
          ,le.addr_street_LEFTTRIM_ErrorCount,le.addr_street_LENGTHS_ErrorCount,le.addr_street_WORDS_ErrorCount
          ,le.addr_city_LEFTTRIM_ErrorCount,le.addr_city_LENGTHS_ErrorCount,le.addr_city_WORDS_ErrorCount
          ,le.addr_state_LEFTTRIM_ErrorCount,le.addr_state_LENGTHS_ErrorCount,le.addr_state_WORDS_ErrorCount
          ,le.addr_zip5_LEFTTRIM_ErrorCount,le.addr_zip5_LENGTHS_ErrorCount,le.addr_zip5_WORDS_ErrorCount
          ,le.addr_zip4_LEFTTRIM_ErrorCount,le.addr_zip4_LENGTHS_ErrorCount,le.addr_zip4_WORDS_ErrorCount
          ,le.dob_LEFTTRIM_ErrorCount,le.dob_LENGTHS_ErrorCount,le.dob_WORDS_ErrorCount
          ,le.transaction_location_LEFTTRIM_ErrorCount,le.transaction_location_LENGTHS_ErrorCount,le.transaction_location_WORDS_ErrorCount
          ,le.ppc_LEFTTRIM_ErrorCount,le.ppc_LENGTHS_ErrorCount,le.ppc_WORDS_ErrorCount
          ,le.internal_identifier_LEFTTRIM_ErrorCount,le.internal_identifier_LENGTHS_ErrorCount,le.internal_identifier_WORDS_ErrorCount
          ,le.eu1_customer_number_LEFTTRIM_ErrorCount,le.eu1_customer_number_LENGTHS_ErrorCount,le.eu1_customer_number_WORDS_ErrorCount
          ,le.eu1_customer_account_LEFTTRIM_ErrorCount,le.eu1_customer_account_LENGTHS_ErrorCount,le.eu1_customer_account_WORDS_ErrorCount
          ,le.eu2_customer_number_LEFTTRIM_ErrorCount,le.eu2_customer_number_LENGTHS_ErrorCount,le.eu2_customer_number_WORDS_ErrorCount
          ,le.eu2_customer_account_LEFTTRIM_ErrorCount,le.eu2_customer_account_LENGTHS_ErrorCount,le.eu2_customer_account_WORDS_ErrorCount
          ,le.email_addr_LEFTTRIM_ErrorCount,le.email_addr_LENGTHS_ErrorCount,le.email_addr_WORDS_ErrorCount
          ,le.ip_address_LEFTTRIM_ErrorCount,le.ip_address_LENGTHS_ErrorCount,le.ip_address_WORDS_ErrorCount
          ,le.state_id_number_LEFTTRIM_ErrorCount,le.state_id_number_LENGTHS_ErrorCount,le.state_id_number_WORDS_ErrorCount
          ,le.state_id_state_LEFTTRIM_ErrorCount,le.state_id_state_LENGTHS_ErrorCount,le.state_id_state_WORDS_ErrorCount
          ,le.eu_company_name_LEFTTRIM_ErrorCount,le.eu_company_name_LENGTHS_ErrorCount,le.eu_company_name_WORDS_ErrorCount
          ,le.eu_addr_street_LEFTTRIM_ErrorCount,le.eu_addr_street_LENGTHS_ErrorCount,le.eu_addr_street_WORDS_ErrorCount
          ,le.eu_addr_city_LEFTTRIM_ErrorCount,le.eu_addr_city_LENGTHS_ErrorCount,le.eu_addr_city_WORDS_ErrorCount
          ,le.eu_addr_state_LEFTTRIM_ErrorCount,le.eu_addr_state_LENGTHS_ErrorCount,le.eu_addr_state_WORDS_ErrorCount
          ,le.eu_addr_zip5_LEFTTRIM_ErrorCount,le.eu_addr_zip5_LENGTHS_ErrorCount,le.eu_addr_zip5_WORDS_ErrorCount
          ,le.eu_phone_nbr_LEFTTRIM_ErrorCount,le.eu_phone_nbr_LENGTHS_ErrorCount,le.eu_phone_nbr_WORDS_ErrorCount
          ,le.product_code_LEFTTRIM_ErrorCount,le.product_code_LENGTHS_ErrorCount,le.product_code_WORDS_ErrorCount
          ,le.transaction_type_LEFTTRIM_ErrorCount,le.transaction_type_LENGTHS_ErrorCount,le.transaction_type_WORDS_ErrorCount
          ,le.function_name_LEFTTRIM_ErrorCount,le.function_name_LENGTHS_ErrorCount,le.function_name_WORDS_ErrorCount
          ,le.customer_id_LEFTTRIM_ErrorCount,le.customer_id_LENGTHS_ErrorCount,le.customer_id_WORDS_ErrorCount
          ,le.company_id_LEFTTRIM_ErrorCount,le.company_id_LENGTHS_ErrorCount,le.company_id_WORDS_ErrorCount
          ,le.global_company_id_LEFTTRIM_ErrorCount,le.global_company_id_LENGTHS_ErrorCount,le.global_company_id_WORDS_ErrorCount
          ,le.phone_nbr_LEFTTRIM_ErrorCount,le.phone_nbr_LENGTHS_ErrorCount,le.phone_nbr_WORDS_ErrorCount
          ,le.FieldsChecked_WithErrors
          ,le.FieldsChecked_NoErrors
          ,le.Rules_WithErrors
          ,le.Rules_NoErrors
          ,NumRulesWithPossibleEdits
          ,le.AnyRule_WithErrorsCount
          ,SELF.recordstotal - le.AnyRule_WithErrorsCount
          ,le.AnyRule_WithEditsCount
          ,le.Rules_WithEdits,0);
      SELF.rulepcnt := IF(c <= NumRules, 100 * CHOOSE(c
          ,le.lex_id_ALLOW_ErrorCount
          ,le.product_id_LEFTTRIM_ErrorCount,le.product_id_ALLOW_ErrorCount,le.product_id_LENGTHS_ErrorCount,le.product_id_WORDS_ErrorCount
          ,le.inquiry_date_LEFTTRIM_ErrorCount,le.inquiry_date_ALLOW_ErrorCount,le.inquiry_date_LENGTHS_ErrorCount,le.inquiry_date_WORDS_ErrorCount
          ,le.transaction_id_LEFTTRIM_ErrorCount,le.transaction_id_ALLOW_ErrorCount,le.transaction_id_LENGTHS_ErrorCount,le.transaction_id_WORDS_ErrorCount
          ,le.date_added_LEFTTRIM_ErrorCount,le.date_added_ALLOW_ErrorCount,le.date_added_LENGTHS_ErrorCount,le.date_added_WORDS_ErrorCount
          ,le.customer_number_LEFTTRIM_ErrorCount,le.customer_number_LENGTHS_ErrorCount,le.customer_number_WORDS_ErrorCount
          ,le.customer_account_LEFTTRIM_ErrorCount,le.customer_account_LENGTHS_ErrorCount,le.customer_account_WORDS_ErrorCount
          ,le.ssn_LEFTTRIM_ErrorCount,le.ssn_LENGTHS_ErrorCount,le.ssn_WORDS_ErrorCount
          ,le.drivers_license_number_LEFTTRIM_ErrorCount,le.drivers_license_number_LENGTHS_ErrorCount,le.drivers_license_number_WORDS_ErrorCount
          ,le.drivers_license_state_LEFTTRIM_ErrorCount,le.drivers_license_state_LENGTHS_ErrorCount,le.drivers_license_state_WORDS_ErrorCount
          ,le.name_first_LEFTTRIM_ErrorCount,le.name_first_LENGTHS_ErrorCount,le.name_first_WORDS_ErrorCount
          ,le.name_last_LEFTTRIM_ErrorCount,le.name_last_LENGTHS_ErrorCount,le.name_last_WORDS_ErrorCount
          ,le.name_middle_LEFTTRIM_ErrorCount,le.name_middle_LENGTHS_ErrorCount,le.name_middle_WORDS_ErrorCount
          ,le.name_suffix_LEFTTRIM_ErrorCount,le.name_suffix_LENGTHS_ErrorCount,le.name_suffix_WORDS_ErrorCount
          ,le.addr_street_LEFTTRIM_ErrorCount,le.addr_street_LENGTHS_ErrorCount,le.addr_street_WORDS_ErrorCount
          ,le.addr_city_LEFTTRIM_ErrorCount,le.addr_city_LENGTHS_ErrorCount,le.addr_city_WORDS_ErrorCount
          ,le.addr_state_LEFTTRIM_ErrorCount,le.addr_state_LENGTHS_ErrorCount,le.addr_state_WORDS_ErrorCount
          ,le.addr_zip5_LEFTTRIM_ErrorCount,le.addr_zip5_LENGTHS_ErrorCount,le.addr_zip5_WORDS_ErrorCount
          ,le.addr_zip4_LEFTTRIM_ErrorCount,le.addr_zip4_LENGTHS_ErrorCount,le.addr_zip4_WORDS_ErrorCount
          ,le.dob_LEFTTRIM_ErrorCount,le.dob_LENGTHS_ErrorCount,le.dob_WORDS_ErrorCount
          ,le.transaction_location_LEFTTRIM_ErrorCount,le.transaction_location_LENGTHS_ErrorCount,le.transaction_location_WORDS_ErrorCount
          ,le.ppc_LEFTTRIM_ErrorCount,le.ppc_LENGTHS_ErrorCount,le.ppc_WORDS_ErrorCount
          ,le.internal_identifier_LEFTTRIM_ErrorCount,le.internal_identifier_LENGTHS_ErrorCount,le.internal_identifier_WORDS_ErrorCount
          ,le.eu1_customer_number_LEFTTRIM_ErrorCount,le.eu1_customer_number_LENGTHS_ErrorCount,le.eu1_customer_number_WORDS_ErrorCount
          ,le.eu1_customer_account_LEFTTRIM_ErrorCount,le.eu1_customer_account_LENGTHS_ErrorCount,le.eu1_customer_account_WORDS_ErrorCount
          ,le.eu2_customer_number_LEFTTRIM_ErrorCount,le.eu2_customer_number_LENGTHS_ErrorCount,le.eu2_customer_number_WORDS_ErrorCount
          ,le.eu2_customer_account_LEFTTRIM_ErrorCount,le.eu2_customer_account_LENGTHS_ErrorCount,le.eu2_customer_account_WORDS_ErrorCount
          ,le.email_addr_LEFTTRIM_ErrorCount,le.email_addr_LENGTHS_ErrorCount,le.email_addr_WORDS_ErrorCount
          ,le.ip_address_LEFTTRIM_ErrorCount,le.ip_address_LENGTHS_ErrorCount,le.ip_address_WORDS_ErrorCount
          ,le.state_id_number_LEFTTRIM_ErrorCount,le.state_id_number_LENGTHS_ErrorCount,le.state_id_number_WORDS_ErrorCount
          ,le.state_id_state_LEFTTRIM_ErrorCount,le.state_id_state_LENGTHS_ErrorCount,le.state_id_state_WORDS_ErrorCount
          ,le.eu_company_name_LEFTTRIM_ErrorCount,le.eu_company_name_LENGTHS_ErrorCount,le.eu_company_name_WORDS_ErrorCount
          ,le.eu_addr_street_LEFTTRIM_ErrorCount,le.eu_addr_street_LENGTHS_ErrorCount,le.eu_addr_street_WORDS_ErrorCount
          ,le.eu_addr_city_LEFTTRIM_ErrorCount,le.eu_addr_city_LENGTHS_ErrorCount,le.eu_addr_city_WORDS_ErrorCount
          ,le.eu_addr_state_LEFTTRIM_ErrorCount,le.eu_addr_state_LENGTHS_ErrorCount,le.eu_addr_state_WORDS_ErrorCount
          ,le.eu_addr_zip5_LEFTTRIM_ErrorCount,le.eu_addr_zip5_LENGTHS_ErrorCount,le.eu_addr_zip5_WORDS_ErrorCount
          ,le.eu_phone_nbr_LEFTTRIM_ErrorCount,le.eu_phone_nbr_LENGTHS_ErrorCount,le.eu_phone_nbr_WORDS_ErrorCount
          ,le.product_code_LEFTTRIM_ErrorCount,le.product_code_LENGTHS_ErrorCount,le.product_code_WORDS_ErrorCount
          ,le.transaction_type_LEFTTRIM_ErrorCount,le.transaction_type_LENGTHS_ErrorCount,le.transaction_type_WORDS_ErrorCount
          ,le.function_name_LEFTTRIM_ErrorCount,le.function_name_LENGTHS_ErrorCount,le.function_name_WORDS_ErrorCount
          ,le.customer_id_LEFTTRIM_ErrorCount,le.customer_id_LENGTHS_ErrorCount,le.customer_id_WORDS_ErrorCount
          ,le.company_id_LEFTTRIM_ErrorCount,le.company_id_LENGTHS_ErrorCount,le.company_id_WORDS_ErrorCount
          ,le.global_company_id_LEFTTRIM_ErrorCount,le.global_company_id_LENGTHS_ErrorCount,le.global_company_id_WORDS_ErrorCount
          ,le.phone_nbr_LEFTTRIM_ErrorCount,le.phone_nbr_LENGTHS_ErrorCount,le.phone_nbr_WORDS_ErrorCount,0) / le.TotalCnt, CHOOSE(c - NumRules
          ,IF(NumFieldsWithRules = 0, 0, le.FieldsChecked_WithErrors/NumFieldsWithRules * 100)
          ,IF(NumFieldsWithRules = 0, 0, le.FieldsChecked_NoErrors/NumFieldsWithRules * 100)
          ,IF(NumRules = 0, 0, le.Rules_WithErrors/NumRules * 100)
          ,IF(NumRules = 0, 0, le.Rules_NoErrors/NumRules * 100)
          ,0
          ,IF(SELF.recordstotal = 0, 0, le.AnyRule_WithErrorsCount/SELF.recordstotal * 100)
          ,IF(SELF.recordstotal = 0, 0, (SELF.recordstotal - le.AnyRule_WithErrorsCount)/SELF.recordstotal * 100)
          ,IF(SELF.recordstotal = 0, 0, le.AnyRule_WithEditsCount/SELF.recordstotal * 100)
          ,IF(NumRulesWithPossibleEdits = 0, 0, le.Rules_WithEdits/NumRulesWithPossibleEdits * 100),0));
    END;
    SummaryInfo := NORMALIZE(SummaryStats,NumRules + 9,Into(LEFT,COUNTER));
    orb_r := RECORD
      AllErrors.Src;
      STRING RuleDesc := TRIM(AllErrors.FieldName)+':'+TRIM(AllErrors.FieldType)+':'+AllErrors.ErrorType;
      STRING ErrorMessage := TRIM(AllErrors.errormessage);
      SALT311.StrType RawCodeMissing := AllErrors.FieldContents;
    END;
    tab := TABLE(AllErrors,orb_r);
    orb_sum := TABLE(tab,{src,ruledesc,ErrorMessage,rawcodemissing,rawcodemissingcnt := COUNT(GROUP)},src,ruledesc,ErrorMessage,rawcodemissing,MERGE);
    gt := GROUP(TOPN(GROUP(orb_sum,src,ruledesc,ALL),examples,-rawcodemissingcnt));
    SALT311.ScrubsOrbitLayout jn(SummaryInfo le, gt ri) := TRANSFORM
      SELF.rawcodemissing := ri.rawcodemissing;
      SELF.rawcodemissingcnt := ri.rawcodemissingcnt;
      SELF := le;
    END;
    j := JOIN(SummaryInfo,gt,LEFT.ruledesc=RIGHT.ruledesc,jn(LEFT,RIGHT),HASH,LEFT OUTER);
    FieldErrorStats := IF(examples>0,j,SummaryInfo);
 
    // field population stats
    mod_hygiene := hygiene(PROJECT(h, Layout_File));
    hygiene_summaryStats := mod_hygiene.Summary('');
    getFieldTypeText(infield) := FUNCTIONMACRO
      isNumField := (STRING)((TYPEOF(infield))'') = '0';
      RETURN IF(isNumField, 'nonzero', 'nonblank');
    ENDMACRO;
    SALT311.ScrubsOrbitLayout xNormHygieneStats(hygiene_summaryStats le, UNSIGNED c, STRING suffix) := TRANSFORM
      SELF.recordstotal := le.NumberOfRecords;
      SELF.processdate := Pdate;
      SELF.sourcecode := src;
      SELF.ruledesc := CHOOSE(c
          ,'lex_id:' + getFieldTypeText(h.lex_id) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'product_id:' + getFieldTypeText(h.product_id) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'inquiry_date:' + getFieldTypeText(h.inquiry_date) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'transaction_id:' + getFieldTypeText(h.transaction_id) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'date_added:' + getFieldTypeText(h.date_added) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'customer_number:' + getFieldTypeText(h.customer_number) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'customer_account:' + getFieldTypeText(h.customer_account) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'ssn:' + getFieldTypeText(h.ssn) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'drivers_license_number:' + getFieldTypeText(h.drivers_license_number) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'drivers_license_state:' + getFieldTypeText(h.drivers_license_state) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'name_first:' + getFieldTypeText(h.name_first) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'name_last:' + getFieldTypeText(h.name_last) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'name_middle:' + getFieldTypeText(h.name_middle) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'name_suffix:' + getFieldTypeText(h.name_suffix) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'addr_street:' + getFieldTypeText(h.addr_street) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'addr_city:' + getFieldTypeText(h.addr_city) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'addr_state:' + getFieldTypeText(h.addr_state) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'addr_zip5:' + getFieldTypeText(h.addr_zip5) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'addr_zip4:' + getFieldTypeText(h.addr_zip4) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'dob:' + getFieldTypeText(h.dob) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'transaction_location:' + getFieldTypeText(h.transaction_location) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'ppc:' + getFieldTypeText(h.ppc) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'internal_identifier:' + getFieldTypeText(h.internal_identifier) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'eu1_customer_number:' + getFieldTypeText(h.eu1_customer_number) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'eu1_customer_account:' + getFieldTypeText(h.eu1_customer_account) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'eu2_customer_number:' + getFieldTypeText(h.eu2_customer_number) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'eu2_customer_account:' + getFieldTypeText(h.eu2_customer_account) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'email_addr:' + getFieldTypeText(h.email_addr) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'ip_address:' + getFieldTypeText(h.ip_address) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'state_id_number:' + getFieldTypeText(h.state_id_number) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'state_id_state:' + getFieldTypeText(h.state_id_state) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'eu_company_name:' + getFieldTypeText(h.eu_company_name) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'eu_addr_street:' + getFieldTypeText(h.eu_addr_street) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'eu_addr_city:' + getFieldTypeText(h.eu_addr_city) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'eu_addr_state:' + getFieldTypeText(h.eu_addr_state) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'eu_addr_zip5:' + getFieldTypeText(h.eu_addr_zip5) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'eu_phone_nbr:' + getFieldTypeText(h.eu_phone_nbr) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'product_code:' + getFieldTypeText(h.product_code) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'transaction_type:' + getFieldTypeText(h.transaction_type) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'function_name:' + getFieldTypeText(h.function_name) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'customer_id:' + getFieldTypeText(h.customer_id) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'company_id:' + getFieldTypeText(h.company_id) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'global_company_id:' + getFieldTypeText(h.global_company_id) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'phone_nbr:' + getFieldTypeText(h.phone_nbr) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix,'UNKNOWN');
      SELF.rulecnt := CHOOSE(c
          ,le.populated_lex_id_cnt
          ,le.populated_product_id_cnt
          ,le.populated_inquiry_date_cnt
          ,le.populated_transaction_id_cnt
          ,le.populated_date_added_cnt
          ,le.populated_customer_number_cnt
          ,le.populated_customer_account_cnt
          ,le.populated_ssn_cnt
          ,le.populated_drivers_license_number_cnt
          ,le.populated_drivers_license_state_cnt
          ,le.populated_name_first_cnt
          ,le.populated_name_last_cnt
          ,le.populated_name_middle_cnt
          ,le.populated_name_suffix_cnt
          ,le.populated_addr_street_cnt
          ,le.populated_addr_city_cnt
          ,le.populated_addr_state_cnt
          ,le.populated_addr_zip5_cnt
          ,le.populated_addr_zip4_cnt
          ,le.populated_dob_cnt
          ,le.populated_transaction_location_cnt
          ,le.populated_ppc_cnt
          ,le.populated_internal_identifier_cnt
          ,le.populated_eu1_customer_number_cnt
          ,le.populated_eu1_customer_account_cnt
          ,le.populated_eu2_customer_number_cnt
          ,le.populated_eu2_customer_account_cnt
          ,le.populated_email_addr_cnt
          ,le.populated_ip_address_cnt
          ,le.populated_state_id_number_cnt
          ,le.populated_state_id_state_cnt
          ,le.populated_eu_company_name_cnt
          ,le.populated_eu_addr_street_cnt
          ,le.populated_eu_addr_city_cnt
          ,le.populated_eu_addr_state_cnt
          ,le.populated_eu_addr_zip5_cnt
          ,le.populated_eu_phone_nbr_cnt
          ,le.populated_product_code_cnt
          ,le.populated_transaction_type_cnt
          ,le.populated_function_name_cnt
          ,le.populated_customer_id_cnt
          ,le.populated_company_id_cnt
          ,le.populated_global_company_id_cnt
          ,le.populated_phone_nbr_cnt,0);
      SELF.rulepcnt := CHOOSE(c
          ,le.populated_lex_id_pcnt
          ,le.populated_product_id_pcnt
          ,le.populated_inquiry_date_pcnt
          ,le.populated_transaction_id_pcnt
          ,le.populated_date_added_pcnt
          ,le.populated_customer_number_pcnt
          ,le.populated_customer_account_pcnt
          ,le.populated_ssn_pcnt
          ,le.populated_drivers_license_number_pcnt
          ,le.populated_drivers_license_state_pcnt
          ,le.populated_name_first_pcnt
          ,le.populated_name_last_pcnt
          ,le.populated_name_middle_pcnt
          ,le.populated_name_suffix_pcnt
          ,le.populated_addr_street_pcnt
          ,le.populated_addr_city_pcnt
          ,le.populated_addr_state_pcnt
          ,le.populated_addr_zip5_pcnt
          ,le.populated_addr_zip4_pcnt
          ,le.populated_dob_pcnt
          ,le.populated_transaction_location_pcnt
          ,le.populated_ppc_pcnt
          ,le.populated_internal_identifier_pcnt
          ,le.populated_eu1_customer_number_pcnt
          ,le.populated_eu1_customer_account_pcnt
          ,le.populated_eu2_customer_number_pcnt
          ,le.populated_eu2_customer_account_pcnt
          ,le.populated_email_addr_pcnt
          ,le.populated_ip_address_pcnt
          ,le.populated_state_id_number_pcnt
          ,le.populated_state_id_state_pcnt
          ,le.populated_eu_company_name_pcnt
          ,le.populated_eu_addr_street_pcnt
          ,le.populated_eu_addr_city_pcnt
          ,le.populated_eu_addr_state_pcnt
          ,le.populated_eu_addr_zip5_pcnt
          ,le.populated_eu_phone_nbr_pcnt
          ,le.populated_product_code_pcnt
          ,le.populated_transaction_type_pcnt
          ,le.populated_function_name_pcnt
          ,le.populated_customer_id_pcnt
          ,le.populated_company_id_pcnt
          ,le.populated_global_company_id_pcnt
          ,le.populated_phone_nbr_pcnt,0);
      SELF.ErrorMessage := '';
    END;
    FieldPopStats := NORMALIZE(hygiene_summaryStats,44,xNormHygieneStats(LEFT,COUNTER,'POP'));
 
  // record count stats
    SALT311.ScrubsOrbitLayout xTotalRecs(hygiene_summaryStats le, STRING inRuleDesc) := TRANSFORM
      SELF.recordstotal := le.NumberOfRecords;
      SELF.processdate := Pdate;
      SELF.sourcecode := src;
      SELF.ruledesc := inRuleDesc;
      SELF.ErrorMessage := '';
      SELF.rulecnt := le.NumberOfRecords;
      SELF.rulepcnt := 0;
    END;
    TotalRecsStats := PROJECT(hygiene_summaryStats, xTotalRecs(LEFT, 'records:total_records:POP'));
 
    mod_Delta := Delta(prevDS, PROJECT(h, Layout_File));
    deltaHygieneSummary := mod_Delta.DifferenceSummary;
    DeltaFieldPopStats := NORMALIZE(deltaHygieneSummary(txt <> 'New'),44,xNormHygieneStats(LEFT,COUNTER,'DELTA'));
    deltaStatName(STRING inTxt) := IF(STD.Str.Find(inTxt, 'Updates_') > 0,
                                      'Updates:count_Updates:DELTA',
                                      TRIM(inTxt) + ':count_' + TRIM(inTxt) + ':DELTA');
    DeltaTotalRecsStats := PROJECT(deltaHygieneSummary(txt <> 'Updates_OldFile'), xTotalRecs(LEFT, deltaStatName(LEFT.txt)));
    DeltaStats := IF(COUNT(prevDS) > 0, DeltaFieldPopStats + DeltaTotalRecsStats);
 
    RETURN FieldErrorStats & FieldPopStats & TotalRecsStats & DeltaStats;
  END;
END;
 
EXPORT StandardStats(DATASET(Layout_File) inFile, BOOLEAN doErrorOverall = TRUE) := FUNCTION
  myTimeStamp := (UNSIGNED6)SALT311.Fn_Now('YYYYMMDDHHMMSS') : INDEPENDENT;
  expandedFile := FromNone(inFile).ExpandedInfile;
  mod_fromexpandedOverall := FromExpanded(expandedFile);
  scrubsSummaryOverall := mod_fromexpandedOverall.SummaryStats;
 
  SALT311.mod_StandardStatsTransforms.mac_scrubsSummaryStatsFieldErrTransform(Scrubs_Inquiry_History, Fields, 'RECORDOF(scrubsSummaryOverall)', '');
  scrubsSummaryOverall_Standard := NORMALIZE(scrubsSummaryOverall, (NumRulesFromFieldType + NumFieldsWithRules) * 4, xSummaryStats(LEFT, COUNTER, myTimeStamp, 'all', 'all'));
 
  allErrsOverall := mod_fromexpandedOverall.AllErrors;
  tErrsOverall := TABLE(DISTRIBUTE(allErrsOverall, HASH(FieldName, ErrorType)), {FieldName, ErrorType, FieldContents, cntExamples := COUNT(GROUP)}, FieldName, ErrorType, FieldContents, LOCAL);
 
  scrubsSummaryOverall_Standard_addErr   := IF(doErrorOverall,
                                               DENORMALIZE(SORT(DISTRIBUTE(scrubsSummaryOverall_Standard, HASH(field, ruletype)), field, ruletype, LOCAL),
  	                                                       SORT(tErrsOverall, FieldName, ErrorType, -cntExamples, FieldContents, LOCAL),
  	                                                       LEFT.field = RIGHT.FieldName AND LEFT.ruletype = RIGHT.ErrorType AND LEFT.MeasureType = 'CntRecs',
  	                                                       TRANSFORM(RECORDOF(LEFT),
  	                                                       SELF.dsExamples := LEFT.dsExamples & DATASET([{RIGHT.FieldContents, RIGHT.cntExamples, IF(LEFT.StatValue > 0, RIGHT.cntExamples/LEFT.StatValue * 100, 0)}], SALT311.Layout_Stats_Standard.Examples);
  	                                                       SELF := LEFT),
  	                                                       KEEP(10), LEFT OUTER, LOCAL, NOSORT));
  scrubsSummaryOverall_Standard_GeneralErrs := IF(doErrorOverall, SALT311.mod_StandardStatsTransforms.scrubsSummaryStatsGeneral(scrubsSummaryOverall,, myTimeStamp, 'all', 'all'));
 
  RETURN scrubsSummaryOverall_Standard_addErr & scrubsSummaryOverall_Standard_GeneralErrs;
END;
END;
