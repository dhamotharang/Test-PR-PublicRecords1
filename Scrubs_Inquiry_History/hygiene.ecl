IMPORT SALT311,STD;
EXPORT hygiene(dataset(layout_File) h) := MODULE
 
//A simple summary record
EXPORT Summary(SALT311.Str30Type  txt) := FUNCTION
  SummaryLayout := RECORD
    txt;
    NumberOfRecords := COUNT(GROUP);
    populated_lex_id_cnt := COUNT(GROUP,h.lex_id <> (TYPEOF(h.lex_id))'');
    populated_lex_id_pcnt := AVE(GROUP,IF(h.lex_id = (TYPEOF(h.lex_id))'',0,100));
    maxlength_lex_id := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.lex_id)));
    avelength_lex_id := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.lex_id)),h.lex_id<>(typeof(h.lex_id))'');
    populated_product_id_cnt := COUNT(GROUP,h.product_id <> (TYPEOF(h.product_id))'');
    populated_product_id_pcnt := AVE(GROUP,IF(h.product_id = (TYPEOF(h.product_id))'',0,100));
    maxlength_product_id := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.product_id)));
    avelength_product_id := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.product_id)),h.product_id<>(typeof(h.product_id))'');
    populated_inquiry_date_cnt := COUNT(GROUP,h.inquiry_date <> (TYPEOF(h.inquiry_date))'');
    populated_inquiry_date_pcnt := AVE(GROUP,IF(h.inquiry_date = (TYPEOF(h.inquiry_date))'',0,100));
    maxlength_inquiry_date := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.inquiry_date)));
    avelength_inquiry_date := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.inquiry_date)),h.inquiry_date<>(typeof(h.inquiry_date))'');
    populated_transaction_id_cnt := COUNT(GROUP,h.transaction_id <> (TYPEOF(h.transaction_id))'');
    populated_transaction_id_pcnt := AVE(GROUP,IF(h.transaction_id = (TYPEOF(h.transaction_id))'',0,100));
    maxlength_transaction_id := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.transaction_id)));
    avelength_transaction_id := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.transaction_id)),h.transaction_id<>(typeof(h.transaction_id))'');
    populated_date_added_cnt := COUNT(GROUP,h.date_added <> (TYPEOF(h.date_added))'');
    populated_date_added_pcnt := AVE(GROUP,IF(h.date_added = (TYPEOF(h.date_added))'',0,100));
    maxlength_date_added := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.date_added)));
    avelength_date_added := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.date_added)),h.date_added<>(typeof(h.date_added))'');
    populated_customer_number_cnt := COUNT(GROUP,h.customer_number <> (TYPEOF(h.customer_number))'');
    populated_customer_number_pcnt := AVE(GROUP,IF(h.customer_number = (TYPEOF(h.customer_number))'',0,100));
    maxlength_customer_number := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.customer_number)));
    avelength_customer_number := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.customer_number)),h.customer_number<>(typeof(h.customer_number))'');
    populated_customer_account_cnt := COUNT(GROUP,h.customer_account <> (TYPEOF(h.customer_account))'');
    populated_customer_account_pcnt := AVE(GROUP,IF(h.customer_account = (TYPEOF(h.customer_account))'',0,100));
    maxlength_customer_account := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.customer_account)));
    avelength_customer_account := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.customer_account)),h.customer_account<>(typeof(h.customer_account))'');
    populated_ssn_cnt := COUNT(GROUP,h.ssn <> (TYPEOF(h.ssn))'');
    populated_ssn_pcnt := AVE(GROUP,IF(h.ssn = (TYPEOF(h.ssn))'',0,100));
    maxlength_ssn := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.ssn)));
    avelength_ssn := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.ssn)),h.ssn<>(typeof(h.ssn))'');
    populated_drivers_license_number_cnt := COUNT(GROUP,h.drivers_license_number <> (TYPEOF(h.drivers_license_number))'');
    populated_drivers_license_number_pcnt := AVE(GROUP,IF(h.drivers_license_number = (TYPEOF(h.drivers_license_number))'',0,100));
    maxlength_drivers_license_number := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.drivers_license_number)));
    avelength_drivers_license_number := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.drivers_license_number)),h.drivers_license_number<>(typeof(h.drivers_license_number))'');
    populated_drivers_license_state_cnt := COUNT(GROUP,h.drivers_license_state <> (TYPEOF(h.drivers_license_state))'');
    populated_drivers_license_state_pcnt := AVE(GROUP,IF(h.drivers_license_state = (TYPEOF(h.drivers_license_state))'',0,100));
    maxlength_drivers_license_state := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.drivers_license_state)));
    avelength_drivers_license_state := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.drivers_license_state)),h.drivers_license_state<>(typeof(h.drivers_license_state))'');
    populated_name_first_cnt := COUNT(GROUP,h.name_first <> (TYPEOF(h.name_first))'');
    populated_name_first_pcnt := AVE(GROUP,IF(h.name_first = (TYPEOF(h.name_first))'',0,100));
    maxlength_name_first := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.name_first)));
    avelength_name_first := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.name_first)),h.name_first<>(typeof(h.name_first))'');
    populated_name_last_cnt := COUNT(GROUP,h.name_last <> (TYPEOF(h.name_last))'');
    populated_name_last_pcnt := AVE(GROUP,IF(h.name_last = (TYPEOF(h.name_last))'',0,100));
    maxlength_name_last := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.name_last)));
    avelength_name_last := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.name_last)),h.name_last<>(typeof(h.name_last))'');
    populated_name_middle_cnt := COUNT(GROUP,h.name_middle <> (TYPEOF(h.name_middle))'');
    populated_name_middle_pcnt := AVE(GROUP,IF(h.name_middle = (TYPEOF(h.name_middle))'',0,100));
    maxlength_name_middle := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.name_middle)));
    avelength_name_middle := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.name_middle)),h.name_middle<>(typeof(h.name_middle))'');
    populated_name_suffix_cnt := COUNT(GROUP,h.name_suffix <> (TYPEOF(h.name_suffix))'');
    populated_name_suffix_pcnt := AVE(GROUP,IF(h.name_suffix = (TYPEOF(h.name_suffix))'',0,100));
    maxlength_name_suffix := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.name_suffix)));
    avelength_name_suffix := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.name_suffix)),h.name_suffix<>(typeof(h.name_suffix))'');
    populated_addr_street_cnt := COUNT(GROUP,h.addr_street <> (TYPEOF(h.addr_street))'');
    populated_addr_street_pcnt := AVE(GROUP,IF(h.addr_street = (TYPEOF(h.addr_street))'',0,100));
    maxlength_addr_street := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.addr_street)));
    avelength_addr_street := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.addr_street)),h.addr_street<>(typeof(h.addr_street))'');
    populated_addr_city_cnt := COUNT(GROUP,h.addr_city <> (TYPEOF(h.addr_city))'');
    populated_addr_city_pcnt := AVE(GROUP,IF(h.addr_city = (TYPEOF(h.addr_city))'',0,100));
    maxlength_addr_city := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.addr_city)));
    avelength_addr_city := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.addr_city)),h.addr_city<>(typeof(h.addr_city))'');
    populated_addr_state_cnt := COUNT(GROUP,h.addr_state <> (TYPEOF(h.addr_state))'');
    populated_addr_state_pcnt := AVE(GROUP,IF(h.addr_state = (TYPEOF(h.addr_state))'',0,100));
    maxlength_addr_state := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.addr_state)));
    avelength_addr_state := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.addr_state)),h.addr_state<>(typeof(h.addr_state))'');
    populated_addr_zip5_cnt := COUNT(GROUP,h.addr_zip5 <> (TYPEOF(h.addr_zip5))'');
    populated_addr_zip5_pcnt := AVE(GROUP,IF(h.addr_zip5 = (TYPEOF(h.addr_zip5))'',0,100));
    maxlength_addr_zip5 := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.addr_zip5)));
    avelength_addr_zip5 := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.addr_zip5)),h.addr_zip5<>(typeof(h.addr_zip5))'');
    populated_addr_zip4_cnt := COUNT(GROUP,h.addr_zip4 <> (TYPEOF(h.addr_zip4))'');
    populated_addr_zip4_pcnt := AVE(GROUP,IF(h.addr_zip4 = (TYPEOF(h.addr_zip4))'',0,100));
    maxlength_addr_zip4 := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.addr_zip4)));
    avelength_addr_zip4 := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.addr_zip4)),h.addr_zip4<>(typeof(h.addr_zip4))'');
    populated_dob_cnt := COUNT(GROUP,h.dob <> (TYPEOF(h.dob))'');
    populated_dob_pcnt := AVE(GROUP,IF(h.dob = (TYPEOF(h.dob))'',0,100));
    maxlength_dob := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.dob)));
    avelength_dob := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.dob)),h.dob<>(typeof(h.dob))'');
    populated_transaction_location_cnt := COUNT(GROUP,h.transaction_location <> (TYPEOF(h.transaction_location))'');
    populated_transaction_location_pcnt := AVE(GROUP,IF(h.transaction_location = (TYPEOF(h.transaction_location))'',0,100));
    maxlength_transaction_location := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.transaction_location)));
    avelength_transaction_location := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.transaction_location)),h.transaction_location<>(typeof(h.transaction_location))'');
    populated_ppc_cnt := COUNT(GROUP,h.ppc <> (TYPEOF(h.ppc))'');
    populated_ppc_pcnt := AVE(GROUP,IF(h.ppc = (TYPEOF(h.ppc))'',0,100));
    maxlength_ppc := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.ppc)));
    avelength_ppc := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.ppc)),h.ppc<>(typeof(h.ppc))'');
    populated_internal_identifier_cnt := COUNT(GROUP,h.internal_identifier <> (TYPEOF(h.internal_identifier))'');
    populated_internal_identifier_pcnt := AVE(GROUP,IF(h.internal_identifier = (TYPEOF(h.internal_identifier))'',0,100));
    maxlength_internal_identifier := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.internal_identifier)));
    avelength_internal_identifier := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.internal_identifier)),h.internal_identifier<>(typeof(h.internal_identifier))'');
    populated_eu1_customer_number_cnt := COUNT(GROUP,h.eu1_customer_number <> (TYPEOF(h.eu1_customer_number))'');
    populated_eu1_customer_number_pcnt := AVE(GROUP,IF(h.eu1_customer_number = (TYPEOF(h.eu1_customer_number))'',0,100));
    maxlength_eu1_customer_number := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.eu1_customer_number)));
    avelength_eu1_customer_number := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.eu1_customer_number)),h.eu1_customer_number<>(typeof(h.eu1_customer_number))'');
    populated_eu1_customer_account_cnt := COUNT(GROUP,h.eu1_customer_account <> (TYPEOF(h.eu1_customer_account))'');
    populated_eu1_customer_account_pcnt := AVE(GROUP,IF(h.eu1_customer_account = (TYPEOF(h.eu1_customer_account))'',0,100));
    maxlength_eu1_customer_account := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.eu1_customer_account)));
    avelength_eu1_customer_account := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.eu1_customer_account)),h.eu1_customer_account<>(typeof(h.eu1_customer_account))'');
    populated_eu2_customer_number_cnt := COUNT(GROUP,h.eu2_customer_number <> (TYPEOF(h.eu2_customer_number))'');
    populated_eu2_customer_number_pcnt := AVE(GROUP,IF(h.eu2_customer_number = (TYPEOF(h.eu2_customer_number))'',0,100));
    maxlength_eu2_customer_number := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.eu2_customer_number)));
    avelength_eu2_customer_number := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.eu2_customer_number)),h.eu2_customer_number<>(typeof(h.eu2_customer_number))'');
    populated_eu2_customer_account_cnt := COUNT(GROUP,h.eu2_customer_account <> (TYPEOF(h.eu2_customer_account))'');
    populated_eu2_customer_account_pcnt := AVE(GROUP,IF(h.eu2_customer_account = (TYPEOF(h.eu2_customer_account))'',0,100));
    maxlength_eu2_customer_account := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.eu2_customer_account)));
    avelength_eu2_customer_account := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.eu2_customer_account)),h.eu2_customer_account<>(typeof(h.eu2_customer_account))'');
    populated_email_addr_cnt := COUNT(GROUP,h.email_addr <> (TYPEOF(h.email_addr))'');
    populated_email_addr_pcnt := AVE(GROUP,IF(h.email_addr = (TYPEOF(h.email_addr))'',0,100));
    maxlength_email_addr := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.email_addr)));
    avelength_email_addr := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.email_addr)),h.email_addr<>(typeof(h.email_addr))'');
    populated_ip_address_cnt := COUNT(GROUP,h.ip_address <> (TYPEOF(h.ip_address))'');
    populated_ip_address_pcnt := AVE(GROUP,IF(h.ip_address = (TYPEOF(h.ip_address))'',0,100));
    maxlength_ip_address := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.ip_address)));
    avelength_ip_address := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.ip_address)),h.ip_address<>(typeof(h.ip_address))'');
    populated_state_id_number_cnt := COUNT(GROUP,h.state_id_number <> (TYPEOF(h.state_id_number))'');
    populated_state_id_number_pcnt := AVE(GROUP,IF(h.state_id_number = (TYPEOF(h.state_id_number))'',0,100));
    maxlength_state_id_number := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.state_id_number)));
    avelength_state_id_number := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.state_id_number)),h.state_id_number<>(typeof(h.state_id_number))'');
    populated_state_id_state_cnt := COUNT(GROUP,h.state_id_state <> (TYPEOF(h.state_id_state))'');
    populated_state_id_state_pcnt := AVE(GROUP,IF(h.state_id_state = (TYPEOF(h.state_id_state))'',0,100));
    maxlength_state_id_state := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.state_id_state)));
    avelength_state_id_state := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.state_id_state)),h.state_id_state<>(typeof(h.state_id_state))'');
    populated_eu_company_name_cnt := COUNT(GROUP,h.eu_company_name <> (TYPEOF(h.eu_company_name))'');
    populated_eu_company_name_pcnt := AVE(GROUP,IF(h.eu_company_name = (TYPEOF(h.eu_company_name))'',0,100));
    maxlength_eu_company_name := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.eu_company_name)));
    avelength_eu_company_name := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.eu_company_name)),h.eu_company_name<>(typeof(h.eu_company_name))'');
    populated_eu_addr_street_cnt := COUNT(GROUP,h.eu_addr_street <> (TYPEOF(h.eu_addr_street))'');
    populated_eu_addr_street_pcnt := AVE(GROUP,IF(h.eu_addr_street = (TYPEOF(h.eu_addr_street))'',0,100));
    maxlength_eu_addr_street := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.eu_addr_street)));
    avelength_eu_addr_street := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.eu_addr_street)),h.eu_addr_street<>(typeof(h.eu_addr_street))'');
    populated_eu_addr_city_cnt := COUNT(GROUP,h.eu_addr_city <> (TYPEOF(h.eu_addr_city))'');
    populated_eu_addr_city_pcnt := AVE(GROUP,IF(h.eu_addr_city = (TYPEOF(h.eu_addr_city))'',0,100));
    maxlength_eu_addr_city := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.eu_addr_city)));
    avelength_eu_addr_city := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.eu_addr_city)),h.eu_addr_city<>(typeof(h.eu_addr_city))'');
    populated_eu_addr_state_cnt := COUNT(GROUP,h.eu_addr_state <> (TYPEOF(h.eu_addr_state))'');
    populated_eu_addr_state_pcnt := AVE(GROUP,IF(h.eu_addr_state = (TYPEOF(h.eu_addr_state))'',0,100));
    maxlength_eu_addr_state := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.eu_addr_state)));
    avelength_eu_addr_state := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.eu_addr_state)),h.eu_addr_state<>(typeof(h.eu_addr_state))'');
    populated_eu_addr_zip5_cnt := COUNT(GROUP,h.eu_addr_zip5 <> (TYPEOF(h.eu_addr_zip5))'');
    populated_eu_addr_zip5_pcnt := AVE(GROUP,IF(h.eu_addr_zip5 = (TYPEOF(h.eu_addr_zip5))'',0,100));
    maxlength_eu_addr_zip5 := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.eu_addr_zip5)));
    avelength_eu_addr_zip5 := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.eu_addr_zip5)),h.eu_addr_zip5<>(typeof(h.eu_addr_zip5))'');
    populated_eu_phone_nbr_cnt := COUNT(GROUP,h.eu_phone_nbr <> (TYPEOF(h.eu_phone_nbr))'');
    populated_eu_phone_nbr_pcnt := AVE(GROUP,IF(h.eu_phone_nbr = (TYPEOF(h.eu_phone_nbr))'',0,100));
    maxlength_eu_phone_nbr := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.eu_phone_nbr)));
    avelength_eu_phone_nbr := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.eu_phone_nbr)),h.eu_phone_nbr<>(typeof(h.eu_phone_nbr))'');
    populated_product_code_cnt := COUNT(GROUP,h.product_code <> (TYPEOF(h.product_code))'');
    populated_product_code_pcnt := AVE(GROUP,IF(h.product_code = (TYPEOF(h.product_code))'',0,100));
    maxlength_product_code := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.product_code)));
    avelength_product_code := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.product_code)),h.product_code<>(typeof(h.product_code))'');
    populated_transaction_type_cnt := COUNT(GROUP,h.transaction_type <> (TYPEOF(h.transaction_type))'');
    populated_transaction_type_pcnt := AVE(GROUP,IF(h.transaction_type = (TYPEOF(h.transaction_type))'',0,100));
    maxlength_transaction_type := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.transaction_type)));
    avelength_transaction_type := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.transaction_type)),h.transaction_type<>(typeof(h.transaction_type))'');
    populated_function_name_cnt := COUNT(GROUP,h.function_name <> (TYPEOF(h.function_name))'');
    populated_function_name_pcnt := AVE(GROUP,IF(h.function_name = (TYPEOF(h.function_name))'',0,100));
    maxlength_function_name := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.function_name)));
    avelength_function_name := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.function_name)),h.function_name<>(typeof(h.function_name))'');
    populated_customer_id_cnt := COUNT(GROUP,h.customer_id <> (TYPEOF(h.customer_id))'');
    populated_customer_id_pcnt := AVE(GROUP,IF(h.customer_id = (TYPEOF(h.customer_id))'',0,100));
    maxlength_customer_id := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.customer_id)));
    avelength_customer_id := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.customer_id)),h.customer_id<>(typeof(h.customer_id))'');
    populated_company_id_cnt := COUNT(GROUP,h.company_id <> (TYPEOF(h.company_id))'');
    populated_company_id_pcnt := AVE(GROUP,IF(h.company_id = (TYPEOF(h.company_id))'',0,100));
    maxlength_company_id := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.company_id)));
    avelength_company_id := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.company_id)),h.company_id<>(typeof(h.company_id))'');
    populated_global_company_id_cnt := COUNT(GROUP,h.global_company_id <> (TYPEOF(h.global_company_id))'');
    populated_global_company_id_pcnt := AVE(GROUP,IF(h.global_company_id = (TYPEOF(h.global_company_id))'',0,100));
    maxlength_global_company_id := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.global_company_id)));
    avelength_global_company_id := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.global_company_id)),h.global_company_id<>(typeof(h.global_company_id))'');
    populated_phone_nbr_cnt := COUNT(GROUP,h.phone_nbr <> (TYPEOF(h.phone_nbr))'');
    populated_phone_nbr_pcnt := AVE(GROUP,IF(h.phone_nbr = (TYPEOF(h.phone_nbr))'',0,100));
    maxlength_phone_nbr := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.phone_nbr)));
    avelength_phone_nbr := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.phone_nbr)),h.phone_nbr<>(typeof(h.phone_nbr))'');
  END;
    T := TABLE(h,SummaryLayout);
  R1 := RECORD
    UNSIGNED LinkingPotential :=  + T.Populated_lex_id_pcnt *   0.00 / 100 + T.Populated_product_id_pcnt *   0.00 / 100 + T.Populated_inquiry_date_pcnt *   0.00 / 100 + T.Populated_transaction_id_pcnt *   0.00 / 100 + T.Populated_date_added_pcnt *   0.00 / 100 + T.Populated_customer_number_pcnt *   0.00 / 100 + T.Populated_customer_account_pcnt *   0.00 / 100 + T.Populated_ssn_pcnt *   0.00 / 100 + T.Populated_drivers_license_number_pcnt *   0.00 / 100 + T.Populated_drivers_license_state_pcnt *   0.00 / 100 + T.Populated_name_first_pcnt *   0.00 / 100 + T.Populated_name_last_pcnt *   0.00 / 100 + T.Populated_name_middle_pcnt *   0.00 / 100 + T.Populated_name_suffix_pcnt *   0.00 / 100 + T.Populated_addr_street_pcnt *   0.00 / 100 + T.Populated_addr_city_pcnt *   0.00 / 100 + T.Populated_addr_state_pcnt *   0.00 / 100 + T.Populated_addr_zip5_pcnt *   0.00 / 100 + T.Populated_addr_zip4_pcnt *   0.00 / 100 + T.Populated_dob_pcnt *   0.00 / 100 + T.Populated_transaction_location_pcnt *   0.00 / 100 + T.Populated_ppc_pcnt *   0.00 / 100 + T.Populated_internal_identifier_pcnt *   0.00 / 100 + T.Populated_eu1_customer_number_pcnt *   0.00 / 100 + T.Populated_eu1_customer_account_pcnt *   0.00 / 100 + T.Populated_eu2_customer_number_pcnt *   0.00 / 100 + T.Populated_eu2_customer_account_pcnt *   0.00 / 100 + T.Populated_email_addr_pcnt *   0.00 / 100 + T.Populated_ip_address_pcnt *   0.00 / 100 + T.Populated_state_id_number_pcnt *   0.00 / 100 + T.Populated_state_id_state_pcnt *   0.00 / 100 + T.Populated_eu_company_name_pcnt *   0.00 / 100 + T.Populated_eu_addr_street_pcnt *   0.00 / 100 + T.Populated_eu_addr_city_pcnt *   0.00 / 100 + T.Populated_eu_addr_state_pcnt *   0.00 / 100 + T.Populated_eu_addr_zip5_pcnt *   0.00 / 100 + T.Populated_eu_phone_nbr_pcnt *   0.00 / 100 + T.Populated_product_code_pcnt *   0.00 / 100 + T.Populated_transaction_type_pcnt *   0.00 / 100 + T.Populated_function_name_pcnt *   0.00 / 100 + T.Populated_customer_id_pcnt *   0.00 / 100 + T.Populated_company_id_pcnt *   0.00 / 100 + T.Populated_global_company_id_pcnt *   0.00 / 100 + T.Populated_phone_nbr_pcnt *   0.00 / 100;
    T;
  END;
  RETURN TABLE(T,R1);
END;
 
summary0 := Summary('Summary');
  invRec := RECORD
  UNSIGNED  FldNo;
  SALT311.StrType FieldName;
  UNSIGNED NumberOfRecords;
  REAL8  populated_pcnt;
  UNSIGNED  maxlength;
  REAL8  avelength;
END;
invRec invert(summary0 le, INTEGER C) := TRANSFORM
  SELF.FldNo := C;
  SELF.NumberOfRecords := le.NumberOfRecords;
  SELF.FieldName := CHOOSE(C,'lex_id','product_id','inquiry_date','transaction_id','date_added','customer_number','customer_account','ssn','drivers_license_number','drivers_license_state','name_first','name_last','name_middle','name_suffix','addr_street','addr_city','addr_state','addr_zip5','addr_zip4','dob','transaction_location','ppc','internal_identifier','eu1_customer_number','eu1_customer_account','eu2_customer_number','eu2_customer_account','email_addr','ip_address','state_id_number','state_id_state','eu_company_name','eu_addr_street','eu_addr_city','eu_addr_state','eu_addr_zip5','eu_phone_nbr','product_code','transaction_type','function_name','customer_id','company_id','global_company_id','phone_nbr');
  SELF.populated_pcnt := CHOOSE(C,le.populated_lex_id_pcnt,le.populated_product_id_pcnt,le.populated_inquiry_date_pcnt,le.populated_transaction_id_pcnt,le.populated_date_added_pcnt,le.populated_customer_number_pcnt,le.populated_customer_account_pcnt,le.populated_ssn_pcnt,le.populated_drivers_license_number_pcnt,le.populated_drivers_license_state_pcnt,le.populated_name_first_pcnt,le.populated_name_last_pcnt,le.populated_name_middle_pcnt,le.populated_name_suffix_pcnt,le.populated_addr_street_pcnt,le.populated_addr_city_pcnt,le.populated_addr_state_pcnt,le.populated_addr_zip5_pcnt,le.populated_addr_zip4_pcnt,le.populated_dob_pcnt,le.populated_transaction_location_pcnt,le.populated_ppc_pcnt,le.populated_internal_identifier_pcnt,le.populated_eu1_customer_number_pcnt,le.populated_eu1_customer_account_pcnt,le.populated_eu2_customer_number_pcnt,le.populated_eu2_customer_account_pcnt,le.populated_email_addr_pcnt,le.populated_ip_address_pcnt,le.populated_state_id_number_pcnt,le.populated_state_id_state_pcnt,le.populated_eu_company_name_pcnt,le.populated_eu_addr_street_pcnt,le.populated_eu_addr_city_pcnt,le.populated_eu_addr_state_pcnt,le.populated_eu_addr_zip5_pcnt,le.populated_eu_phone_nbr_pcnt,le.populated_product_code_pcnt,le.populated_transaction_type_pcnt,le.populated_function_name_pcnt,le.populated_customer_id_pcnt,le.populated_company_id_pcnt,le.populated_global_company_id_pcnt,le.populated_phone_nbr_pcnt);
  SELF.maxlength := CHOOSE(C,le.maxlength_lex_id,le.maxlength_product_id,le.maxlength_inquiry_date,le.maxlength_transaction_id,le.maxlength_date_added,le.maxlength_customer_number,le.maxlength_customer_account,le.maxlength_ssn,le.maxlength_drivers_license_number,le.maxlength_drivers_license_state,le.maxlength_name_first,le.maxlength_name_last,le.maxlength_name_middle,le.maxlength_name_suffix,le.maxlength_addr_street,le.maxlength_addr_city,le.maxlength_addr_state,le.maxlength_addr_zip5,le.maxlength_addr_zip4,le.maxlength_dob,le.maxlength_transaction_location,le.maxlength_ppc,le.maxlength_internal_identifier,le.maxlength_eu1_customer_number,le.maxlength_eu1_customer_account,le.maxlength_eu2_customer_number,le.maxlength_eu2_customer_account,le.maxlength_email_addr,le.maxlength_ip_address,le.maxlength_state_id_number,le.maxlength_state_id_state,le.maxlength_eu_company_name,le.maxlength_eu_addr_street,le.maxlength_eu_addr_city,le.maxlength_eu_addr_state,le.maxlength_eu_addr_zip5,le.maxlength_eu_phone_nbr,le.maxlength_product_code,le.maxlength_transaction_type,le.maxlength_function_name,le.maxlength_customer_id,le.maxlength_company_id,le.maxlength_global_company_id,le.maxlength_phone_nbr);
  SELF.avelength := CHOOSE(C,le.avelength_lex_id,le.avelength_product_id,le.avelength_inquiry_date,le.avelength_transaction_id,le.avelength_date_added,le.avelength_customer_number,le.avelength_customer_account,le.avelength_ssn,le.avelength_drivers_license_number,le.avelength_drivers_license_state,le.avelength_name_first,le.avelength_name_last,le.avelength_name_middle,le.avelength_name_suffix,le.avelength_addr_street,le.avelength_addr_city,le.avelength_addr_state,le.avelength_addr_zip5,le.avelength_addr_zip4,le.avelength_dob,le.avelength_transaction_location,le.avelength_ppc,le.avelength_internal_identifier,le.avelength_eu1_customer_number,le.avelength_eu1_customer_account,le.avelength_eu2_customer_number,le.avelength_eu2_customer_account,le.avelength_email_addr,le.avelength_ip_address,le.avelength_state_id_number,le.avelength_state_id_state,le.avelength_eu_company_name,le.avelength_eu_addr_street,le.avelength_eu_addr_city,le.avelength_eu_addr_state,le.avelength_eu_addr_zip5,le.avelength_eu_phone_nbr,le.avelength_product_code,le.avelength_transaction_type,le.avelength_function_name,le.avelength_customer_id,le.avelength_company_id,le.avelength_global_company_id,le.avelength_phone_nbr);
END;
EXPORT invSummary := NORMALIZE(summary0, 44, invert(LEFT,COUNTER));
// The character counts
// Move everything into 'inverted list' form so processing can be done 'in library'
SALT311.MAC_Character_Counts.X_Data_Layout Into(h le,unsigned C) := TRANSFORM
  SELF.Fld := TRIM(CHOOSE(C,TRIM((SALT311.StrType)le.lex_id),TRIM((SALT311.StrType)le.product_id),TRIM((SALT311.StrType)le.inquiry_date),TRIM((SALT311.StrType)le.transaction_id),TRIM((SALT311.StrType)le.date_added),TRIM((SALT311.StrType)le.customer_number),TRIM((SALT311.StrType)le.customer_account),TRIM((SALT311.StrType)le.ssn),TRIM((SALT311.StrType)le.drivers_license_number),TRIM((SALT311.StrType)le.drivers_license_state),TRIM((SALT311.StrType)le.name_first),TRIM((SALT311.StrType)le.name_last),TRIM((SALT311.StrType)le.name_middle),TRIM((SALT311.StrType)le.name_suffix),TRIM((SALT311.StrType)le.addr_street),TRIM((SALT311.StrType)le.addr_city),TRIM((SALT311.StrType)le.addr_state),TRIM((SALT311.StrType)le.addr_zip5),TRIM((SALT311.StrType)le.addr_zip4),TRIM((SALT311.StrType)le.dob),TRIM((SALT311.StrType)le.transaction_location),TRIM((SALT311.StrType)le.ppc),TRIM((SALT311.StrType)le.internal_identifier),TRIM((SALT311.StrType)le.eu1_customer_number),TRIM((SALT311.StrType)le.eu1_customer_account),TRIM((SALT311.StrType)le.eu2_customer_number),TRIM((SALT311.StrType)le.eu2_customer_account),TRIM((SALT311.StrType)le.email_addr),TRIM((SALT311.StrType)le.ip_address),TRIM((SALT311.StrType)le.state_id_number),TRIM((SALT311.StrType)le.state_id_state),TRIM((SALT311.StrType)le.eu_company_name),TRIM((SALT311.StrType)le.eu_addr_street),TRIM((SALT311.StrType)le.eu_addr_city),TRIM((SALT311.StrType)le.eu_addr_state),TRIM((SALT311.StrType)le.eu_addr_zip5),TRIM((SALT311.StrType)le.eu_phone_nbr),TRIM((SALT311.StrType)le.product_code),TRIM((SALT311.StrType)le.transaction_type),TRIM((SALT311.StrType)le.function_name),TRIM((SALT311.StrType)le.customer_id),TRIM((SALT311.StrType)le.company_id),TRIM((SALT311.StrType)le.global_company_id),TRIM((SALT311.StrType)le.phone_nbr)));
  SELF.FldNo := C;
END;
SHARED FldInv0 := NORMALIZE(h,44,Into(LEFT,COUNTER));
// Move everything into 'pairs' form so processing can be done 'in library'
SALT311.MAC_Correlate.Data_Layout IntoP(h le,UNSIGNED C) := TRANSFORM
  SELF.FldNo1 := 1 + (C / 44);
  SELF.FldNo2 := 1 + (C % 44);
  SELF.Fld1 := TRIM(CHOOSE(SELF.FldNo1,TRIM((SALT311.StrType)le.lex_id),TRIM((SALT311.StrType)le.product_id),TRIM((SALT311.StrType)le.inquiry_date),TRIM((SALT311.StrType)le.transaction_id),TRIM((SALT311.StrType)le.date_added),TRIM((SALT311.StrType)le.customer_number),TRIM((SALT311.StrType)le.customer_account),TRIM((SALT311.StrType)le.ssn),TRIM((SALT311.StrType)le.drivers_license_number),TRIM((SALT311.StrType)le.drivers_license_state),TRIM((SALT311.StrType)le.name_first),TRIM((SALT311.StrType)le.name_last),TRIM((SALT311.StrType)le.name_middle),TRIM((SALT311.StrType)le.name_suffix),TRIM((SALT311.StrType)le.addr_street),TRIM((SALT311.StrType)le.addr_city),TRIM((SALT311.StrType)le.addr_state),TRIM((SALT311.StrType)le.addr_zip5),TRIM((SALT311.StrType)le.addr_zip4),TRIM((SALT311.StrType)le.dob),TRIM((SALT311.StrType)le.transaction_location),TRIM((SALT311.StrType)le.ppc),TRIM((SALT311.StrType)le.internal_identifier),TRIM((SALT311.StrType)le.eu1_customer_number),TRIM((SALT311.StrType)le.eu1_customer_account),TRIM((SALT311.StrType)le.eu2_customer_number),TRIM((SALT311.StrType)le.eu2_customer_account),TRIM((SALT311.StrType)le.email_addr),TRIM((SALT311.StrType)le.ip_address),TRIM((SALT311.StrType)le.state_id_number),TRIM((SALT311.StrType)le.state_id_state),TRIM((SALT311.StrType)le.eu_company_name),TRIM((SALT311.StrType)le.eu_addr_street),TRIM((SALT311.StrType)le.eu_addr_city),TRIM((SALT311.StrType)le.eu_addr_state),TRIM((SALT311.StrType)le.eu_addr_zip5),TRIM((SALT311.StrType)le.eu_phone_nbr),TRIM((SALT311.StrType)le.product_code),TRIM((SALT311.StrType)le.transaction_type),TRIM((SALT311.StrType)le.function_name),TRIM((SALT311.StrType)le.customer_id),TRIM((SALT311.StrType)le.company_id),TRIM((SALT311.StrType)le.global_company_id),TRIM((SALT311.StrType)le.phone_nbr)));
  SELF.Fld2 := TRIM(CHOOSE(SELF.FldNo2,TRIM((SALT311.StrType)le.lex_id),TRIM((SALT311.StrType)le.product_id),TRIM((SALT311.StrType)le.inquiry_date),TRIM((SALT311.StrType)le.transaction_id),TRIM((SALT311.StrType)le.date_added),TRIM((SALT311.StrType)le.customer_number),TRIM((SALT311.StrType)le.customer_account),TRIM((SALT311.StrType)le.ssn),TRIM((SALT311.StrType)le.drivers_license_number),TRIM((SALT311.StrType)le.drivers_license_state),TRIM((SALT311.StrType)le.name_first),TRIM((SALT311.StrType)le.name_last),TRIM((SALT311.StrType)le.name_middle),TRIM((SALT311.StrType)le.name_suffix),TRIM((SALT311.StrType)le.addr_street),TRIM((SALT311.StrType)le.addr_city),TRIM((SALT311.StrType)le.addr_state),TRIM((SALT311.StrType)le.addr_zip5),TRIM((SALT311.StrType)le.addr_zip4),TRIM((SALT311.StrType)le.dob),TRIM((SALT311.StrType)le.transaction_location),TRIM((SALT311.StrType)le.ppc),TRIM((SALT311.StrType)le.internal_identifier),TRIM((SALT311.StrType)le.eu1_customer_number),TRIM((SALT311.StrType)le.eu1_customer_account),TRIM((SALT311.StrType)le.eu2_customer_number),TRIM((SALT311.StrType)le.eu2_customer_account),TRIM((SALT311.StrType)le.email_addr),TRIM((SALT311.StrType)le.ip_address),TRIM((SALT311.StrType)le.state_id_number),TRIM((SALT311.StrType)le.state_id_state),TRIM((SALT311.StrType)le.eu_company_name),TRIM((SALT311.StrType)le.eu_addr_street),TRIM((SALT311.StrType)le.eu_addr_city),TRIM((SALT311.StrType)le.eu_addr_state),TRIM((SALT311.StrType)le.eu_addr_zip5),TRIM((SALT311.StrType)le.eu_phone_nbr),TRIM((SALT311.StrType)le.product_code),TRIM((SALT311.StrType)le.transaction_type),TRIM((SALT311.StrType)le.function_name),TRIM((SALT311.StrType)le.customer_id),TRIM((SALT311.StrType)le.company_id),TRIM((SALT311.StrType)le.global_company_id),TRIM((SALT311.StrType)le.phone_nbr)));
  END;
SHARED Pairs0 := NORMALIZE(ENTH(h,Config.CorrelateSampleSize),44*44,IntoP(LEFT,COUNTER))(FldNo1<FldNo2);
SHARED FldIds := DATASET([{1,'lex_id'}
      ,{2,'product_id'}
      ,{3,'inquiry_date'}
      ,{4,'transaction_id'}
      ,{5,'date_added'}
      ,{6,'customer_number'}
      ,{7,'customer_account'}
      ,{8,'ssn'}
      ,{9,'drivers_license_number'}
      ,{10,'drivers_license_state'}
      ,{11,'name_first'}
      ,{12,'name_last'}
      ,{13,'name_middle'}
      ,{14,'name_suffix'}
      ,{15,'addr_street'}
      ,{16,'addr_city'}
      ,{17,'addr_state'}
      ,{18,'addr_zip5'}
      ,{19,'addr_zip4'}
      ,{20,'dob'}
      ,{21,'transaction_location'}
      ,{22,'ppc'}
      ,{23,'internal_identifier'}
      ,{24,'eu1_customer_number'}
      ,{25,'eu1_customer_account'}
      ,{26,'eu2_customer_number'}
      ,{27,'eu2_customer_account'}
      ,{28,'email_addr'}
      ,{29,'ip_address'}
      ,{30,'state_id_number'}
      ,{31,'state_id_state'}
      ,{32,'eu_company_name'}
      ,{33,'eu_addr_street'}
      ,{34,'eu_addr_city'}
      ,{35,'eu_addr_state'}
      ,{36,'eu_addr_zip5'}
      ,{37,'eu_phone_nbr'}
      ,{38,'product_code'}
      ,{39,'transaction_type'}
      ,{40,'function_name'}
      ,{41,'customer_id'}
      ,{42,'company_id'}
      ,{43,'global_company_id'}
      ,{44,'phone_nbr'}],SALT311.MAC_Character_Counts.Field_Identification);
EXPORT AllProfiles := SALT311.MAC_Character_Counts.FN_Profile(FldInv0,FldIds);
 
EXPORT SrcProfiles := SALT311.MAC_Character_Counts.Src_Profile(FldInv0,FldIds);
 
EXPORT Correlations := SALT311.MAC_Correlate.Fn_Profile(Pairs0,FldIds);
 
ErrorRecord := RECORD
  UNSIGNED1 FieldNum;
  UNSIGNED1 ErrorNum;
END;
ErrorRecord NoteErrors(h le,UNSIGNED1 c) := TRANSFORM
  SELF.ErrorNum := CHOOSE(c,
    Fields.InValid_lex_id((SALT311.StrType)le.lex_id),
    Fields.InValid_product_id((SALT311.StrType)le.product_id),
    Fields.InValid_inquiry_date((SALT311.StrType)le.inquiry_date),
    Fields.InValid_transaction_id((SALT311.StrType)le.transaction_id),
    Fields.InValid_date_added((SALT311.StrType)le.date_added),
    Fields.InValid_customer_number((SALT311.StrType)le.customer_number),
    Fields.InValid_customer_account((SALT311.StrType)le.customer_account),
    Fields.InValid_ssn((SALT311.StrType)le.ssn),
    Fields.InValid_drivers_license_number((SALT311.StrType)le.drivers_license_number),
    Fields.InValid_drivers_license_state((SALT311.StrType)le.drivers_license_state),
    Fields.InValid_name_first((SALT311.StrType)le.name_first),
    Fields.InValid_name_last((SALT311.StrType)le.name_last),
    Fields.InValid_name_middle((SALT311.StrType)le.name_middle),
    Fields.InValid_name_suffix((SALT311.StrType)le.name_suffix),
    Fields.InValid_addr_street((SALT311.StrType)le.addr_street),
    Fields.InValid_addr_city((SALT311.StrType)le.addr_city),
    Fields.InValid_addr_state((SALT311.StrType)le.addr_state),
    Fields.InValid_addr_zip5((SALT311.StrType)le.addr_zip5),
    Fields.InValid_addr_zip4((SALT311.StrType)le.addr_zip4),
    Fields.InValid_dob((SALT311.StrType)le.dob),
    Fields.InValid_transaction_location((SALT311.StrType)le.transaction_location),
    Fields.InValid_ppc((SALT311.StrType)le.ppc),
    Fields.InValid_internal_identifier((SALT311.StrType)le.internal_identifier),
    Fields.InValid_eu1_customer_number((SALT311.StrType)le.eu1_customer_number),
    Fields.InValid_eu1_customer_account((SALT311.StrType)le.eu1_customer_account),
    Fields.InValid_eu2_customer_number((SALT311.StrType)le.eu2_customer_number),
    Fields.InValid_eu2_customer_account((SALT311.StrType)le.eu2_customer_account),
    Fields.InValid_email_addr((SALT311.StrType)le.email_addr),
    Fields.InValid_ip_address((SALT311.StrType)le.ip_address),
    Fields.InValid_state_id_number((SALT311.StrType)le.state_id_number),
    Fields.InValid_state_id_state((SALT311.StrType)le.state_id_state),
    Fields.InValid_eu_company_name((SALT311.StrType)le.eu_company_name),
    Fields.InValid_eu_addr_street((SALT311.StrType)le.eu_addr_street),
    Fields.InValid_eu_addr_city((SALT311.StrType)le.eu_addr_city),
    Fields.InValid_eu_addr_state((SALT311.StrType)le.eu_addr_state),
    Fields.InValid_eu_addr_zip5((SALT311.StrType)le.eu_addr_zip5),
    Fields.InValid_eu_phone_nbr((SALT311.StrType)le.eu_phone_nbr),
    Fields.InValid_product_code((SALT311.StrType)le.product_code),
    Fields.InValid_transaction_type((SALT311.StrType)le.transaction_type),
    Fields.InValid_function_name((SALT311.StrType)le.function_name),
    Fields.InValid_customer_id((SALT311.StrType)le.customer_id),
    Fields.InValid_company_id((SALT311.StrType)le.company_id),
    Fields.InValid_global_company_id((SALT311.StrType)le.global_company_id),
    Fields.InValid_phone_nbr((SALT311.StrType)le.phone_nbr),
    0);
  SELF.FieldNum := IF(SELF.ErrorNum=0,SKIP,c); // Bail early to avoid creating record
END;
Errors := NORMALIZE(h,44,NoteErrors(LEFT,COUNTER));
ErrorRecordsTotals := RECORD
  Errors.FieldNum;
  Errors.ErrorNum;
  UNSIGNED Cnt := COUNT(GROUP);
END;
TotalErrors := TABLE(Errors,ErrorRecordsTotals,FieldNum,ErrorNum,FEW);
PrettyErrorTotals := RECORD
  FieldNme := Fields.FieldName(TotalErrors.FieldNum);
  FieldType := CHOOSE(TotalErrors.FieldNum,'NUMBER','product_id','inquiry_date','transaction_id','date_added','customer_number','customer_account','ssn','drivers_license_number','drivers_license_state','name_first','name_last','name_middle','name_suffix','addr_street','addr_city','addr_state','addr_zip5','addr_zip4','dob','transaction_location','ppc','internal_identifier','eu1_customer_number','eu1_customer_account','eu2_customer_number','eu2_customer_account','email_addr','ip_address','state_id_number','state_id_state','eu_company_name','eu_addr_street','eu_addr_city','eu_addr_state','eu_addr_zip5','eu_phone_nbr','product_code','transaction_type','function_name','customer_id','company_id','global_company_id','phone_nbr');
  ErrorMessage := CHOOSE(TotalErrors.FieldNum,Fields.InValidMessage_lex_id(TotalErrors.ErrorNum),Fields.InValidMessage_product_id(TotalErrors.ErrorNum),Fields.InValidMessage_inquiry_date(TotalErrors.ErrorNum),Fields.InValidMessage_transaction_id(TotalErrors.ErrorNum),Fields.InValidMessage_date_added(TotalErrors.ErrorNum),Fields.InValidMessage_customer_number(TotalErrors.ErrorNum),Fields.InValidMessage_customer_account(TotalErrors.ErrorNum),Fields.InValidMessage_ssn(TotalErrors.ErrorNum),Fields.InValidMessage_drivers_license_number(TotalErrors.ErrorNum),Fields.InValidMessage_drivers_license_state(TotalErrors.ErrorNum),Fields.InValidMessage_name_first(TotalErrors.ErrorNum),Fields.InValidMessage_name_last(TotalErrors.ErrorNum),Fields.InValidMessage_name_middle(TotalErrors.ErrorNum),Fields.InValidMessage_name_suffix(TotalErrors.ErrorNum),Fields.InValidMessage_addr_street(TotalErrors.ErrorNum),Fields.InValidMessage_addr_city(TotalErrors.ErrorNum),Fields.InValidMessage_addr_state(TotalErrors.ErrorNum),Fields.InValidMessage_addr_zip5(TotalErrors.ErrorNum),Fields.InValidMessage_addr_zip4(TotalErrors.ErrorNum),Fields.InValidMessage_dob(TotalErrors.ErrorNum),Fields.InValidMessage_transaction_location(TotalErrors.ErrorNum),Fields.InValidMessage_ppc(TotalErrors.ErrorNum),Fields.InValidMessage_internal_identifier(TotalErrors.ErrorNum),Fields.InValidMessage_eu1_customer_number(TotalErrors.ErrorNum),Fields.InValidMessage_eu1_customer_account(TotalErrors.ErrorNum),Fields.InValidMessage_eu2_customer_number(TotalErrors.ErrorNum),Fields.InValidMessage_eu2_customer_account(TotalErrors.ErrorNum),Fields.InValidMessage_email_addr(TotalErrors.ErrorNum),Fields.InValidMessage_ip_address(TotalErrors.ErrorNum),Fields.InValidMessage_state_id_number(TotalErrors.ErrorNum),Fields.InValidMessage_state_id_state(TotalErrors.ErrorNum),Fields.InValidMessage_eu_company_name(TotalErrors.ErrorNum),Fields.InValidMessage_eu_addr_street(TotalErrors.ErrorNum),Fields.InValidMessage_eu_addr_city(TotalErrors.ErrorNum),Fields.InValidMessage_eu_addr_state(TotalErrors.ErrorNum),Fields.InValidMessage_eu_addr_zip5(TotalErrors.ErrorNum),Fields.InValidMessage_eu_phone_nbr(TotalErrors.ErrorNum),Fields.InValidMessage_product_code(TotalErrors.ErrorNum),Fields.InValidMessage_transaction_type(TotalErrors.ErrorNum),Fields.InValidMessage_function_name(TotalErrors.ErrorNum),Fields.InValidMessage_customer_id(TotalErrors.ErrorNum),Fields.InValidMessage_company_id(TotalErrors.ErrorNum),Fields.InValidMessage_global_company_id(TotalErrors.ErrorNum),Fields.InValidMessage_phone_nbr(TotalErrors.ErrorNum));
  TotalErrors.Cnt;
END;
ValErr := TABLE(TotalErrors,PrettyErrorTotals);
EXPORT ValidityErrors := ValErr;
EXPORT StandardStats(BOOLEAN doSummaryGlobal = TRUE, BOOLEAN doAllProfiles = TRUE) := FUNCTION
  myTimeStamp := (UNSIGNED6)SALT311.Fn_Now('YYYYMMDDHHMMSS') : INDEPENDENT;
  fieldPopulationOverall := Summary('');
 
  SALT311.mod_StandardStatsTransforms.mac_hygieneSummaryTransform(Scrubs_Inquiry_History, Fields, 'RECORDOF(fieldPopulationOverall)', FALSE);
 
  fieldPopulationOverall_Standard := IF(doSummaryGlobal, NORMALIZE(fieldPopulationOverall, COUNT(FldIds) * 6, xSummary(LEFT, COUNTER, myTimeStamp, 'all', 'all')));
  fieldPopulationOverall_TotalRecs_Standard := IF(doSummaryGlobal, SALT311.mod_StandardStatsTransforms.mac_hygieneTotalRecs(fieldPopulationOverall, myTimeStamp, 'all', FALSE, 'all'));
  allProfiles_Standard := IF(doAllProfiles, SALT311.mod_StandardStatsTransforms.hygieneAllProfiles(AllProfiles, myTimeStamp, 10, 'all'));
 
  RETURN fieldPopulationOverall_Standard & fieldPopulationOverall_TotalRecs_Standard & allProfiles_Standard;
END;
END;
