// General Purpose Testing
OUTPUT(Scrubs.Functions.fn_numeric('12345', 5), NAMED('fn_numeric_test_TRUE'));

OUTPUT(Scrubs.Functions.fn_numeric_optional('', 5), NAMED('fn_numeric_optional_test_TRUE'));

OUTPUT(Scrubs.Functions.fn_range_numeric('150', 0, 100), NAMED('fn_range_numeric_test_FALSE'));

OUTPUT(Scrubs.Functions.fn_populated_strings('This', 'songs', 'gonna', 'get', 'stuck inside your head'), NAMED('fn_populated_strings_test_TRUE'));
OUTPUT(Scrubs.Functions.fn_populated_strings(''), NAMED('fn_populated_strings_test2_FALSE'));

OUTPUT(Scrubs.Functions.fn_alphanum('HIDYHO53'), NAMED('fn_alphanum_test_TRUE'));
OUTPUT(Scrubs.Functions.fn_alphanum('HIDYHO53!'), NAMED('fn_alphanum_test2_FALSE'));

OUTPUT(Scrubs.Functions.fn_alpha('LegoMovie', 9), NAMED('fn_alpha_test_TRUE'));

OUTPUT(Scrubs.Functions.fn_ASCII_printable('Lego~Movie@gmail.com'), NAMED('fn_ASCII_printable_test_TRUE'));

OUTPUT(Scrubs.Functions.fn_str1_xor_str2('Good','the Bad'), NAMED('fn_str1_xor_str2_test_TRUE'));
OUTPUT(Scrubs.Functions.fn_str1_xor_str2('Good',''), NAMED('fn_str1_xor_str2_test2_FALSE'));

OUTPUT(Scrubs.Functions.fn_valid_codesv3('CF','8S','COURT_OFF_LEV','COURT_OFFENSES'), NAMED('fn_valid_codesv3_test_TRUE'));
// END General Purpose Testing

// Time/Date Testing
OUTPUT(Scrubs.Functions.fn_valid_date('20190405', ''), NAMED('fn_valid_date_test_TRUE'));
OUTPUT(Scrubs.Functions.fn_valid_date('20190510', ''), NAMED('fn_valid_date_test2_FALSE'));
OUTPUT(Scrubs.Functions.fn_valid_date('', 'Future'), NAMED('fn_valid_date_test3_TRUE'));
OUTPUT(Scrubs.Functions.fn_valid_date('20200220', 'Future'), NAMED('fn_valid_date_test4_TRUE'));

OUTPUT(Scrubs.Functions.fn_valid_GeneralDate('0'), NAMED('fn_valid_GeneralDate_test_TRUE'));
OUTPUT(Scrubs.Functions.fn_valid_GeneralDate('20191010'), NAMED('fn_valid_GeneralDate_test2_TRUE'));

OUTPUT(Scrubs.Functions.fn_valid_pastDate('20190305'), NAMED('fn_valid_pastDate_test_TRUE'));
OUTPUT(Scrubs.Functions.fn_valid_pastDate('20190905'), NAMED('fn_valid_pastDate_test2_FALSE'));

OUTPUT(Scrubs.Functions.fn_past_yyyymmdd('20190305', 'T'), NAMED('fn_past_yyyymmdd_test_TRUE'));
OUTPUT(Scrubs.Functions.fn_past_yyyymmdd('20190905', ''), NAMED('fn_past_yyyymmdd_test2_FALSE'));

OUTPUT(Scrubs.Functions.fn_general_yyyymmdd('20190305', 'T'), NAMED('fn_general_yyyymmdd_test_TRUE'));
OUTPUT(Scrubs.Functions.fn_general_yyyymmdd('20190905', ''), NAMED('fn_general_yyyymmdd_test2_TRUE'));

OUTPUT(Scrubs.Functions.fn_valid_generic_date('2019'), NAMED('fn_valid_generic_date_test_FALSE'));
OUTPUT(Scrubs.Functions.fn_valid_generic_date(''), NAMED('fn_valid_generic_date_test2_TRUE'));
OUTPUT(Scrubs.Functions.fn_valid_generic_date('20190305'), NAMED('fn_valid_generic_date_test3_TRUE'));

OUTPUT(Scrubs.Functions.fn_is_valid_earlier_date('20190305', '20190405'), NAMED('fn_is_valid_earlier_date_test_TRUE'));
OUTPUT(Scrubs.Functions.fn_is_valid_earlier_date('20190405', '20190205'), NAMED('fn_is_valid_earlier_date_test2_FALSE'));

OUTPUT(Scrubs.Functions.fn_is_valid_opt_earlier_date('20190305', '20190405'), NAMED('fn_is_valid_opt_earlier_date_test_TRUE'));
OUTPUT(Scrubs.Functions.fn_is_valid_opt_earlier_date('', '20190205'), NAMED('fn_is_valid_opt_earlier_date_test2_TRUE'));

OUTPUT(Scrubs.Functions.fn_dob('19690912'), NAMED('fn_dob_test_TRUE'));
OUTPUT(Scrubs.Functions.fn_dob('1975'), NAMED('fn_dob_test2_TRUE'));

OUTPUT(Scrubs.Functions.fn_check_time('1312'), NAMED('fn_check_time_test_TRUE'));
OUTPUT(Scrubs.Functions.fn_check_time(''), NAMED('fn_check_time_test2_TRUE'));
OUTPUT(Scrubs.Functions.fn_check_time('0'), NAMED('fn_check_time_test3_FALSE'));

// END Time/Date Testing

// Address Testing
OUTPUT(Scrubs.Functions.fn_Valid_StateAbbrev('OH'), NAMED('fn_Valid_StateAbbrev_test_TRUE'));
OUTPUT(Scrubs.Functions.fn_Valid_StateAbbrev('XX'), NAMED('fn_Valid_StateAbbrev_test2_FALSE'));

OUTPUT(Scrubs.Functions.fn_verify_state('ID', 'T'), NAMED('fn_verify_state_test_TRUE'));
OUTPUT(Scrubs.Functions.fn_verify_state('', 'T'), NAMED('fn_verify_state_test2_TRUE'));

OUTPUT(Scrubs.Functions.fn_verify_zip59('453420002'), NAMED('fn_verify_zip59_test_TRUE'));
OUTPUT(Scrubs.Functions.fn_verify_zip59('4534'), NAMED('fn_verify_zip59_test2_FALSE'));

OUTPUT(Scrubs.Functions.fn_valid_zip('45342-0002'), NAMED('fn_valid_zip_test_TRUE'));
OUTPUT(Scrubs.Functions.fn_valid_zip(''), NAMED('fn_valid_zip_test2_TRUE'));
OUTPUT(Scrubs.Functions.fn_valid_zip('453420002'), NAMED('fn_valid_zip_test3_TRUE'));
OUTPUT(Scrubs.Functions.fn_valid_zip('4534'), NAMED('fn_valid_zip_test4_FALSE'));

OUTPUT(Scrubs.Functions.fn_verify_phone('8675309', 'T'), NAMED('fn_verify_phone_test_TRUE'));
OUTPUT(Scrubs.Functions.fn_verify_phone('', 'T'), NAMED('fn_verify_phone_test2_TRUE'));
OUTPUT(Scrubs.Functions.fn_verify_phone(''), NAMED('fn_verify_phone_test3_FALSE'));

OUTPUT(Scrubs.Functions.fn_verify_cart('B002'), NAMED('fn_verify_cart_test_TRUE'));
OUTPUT(Scrubs.Functions.fn_verify_cart(''), NAMED('fn_verify_cart_test2_TRUE'));

OUTPUT(Scrubs.Functions.fn_addr_rec_type('FD'), NAMED('fn_addr_rec_type_test_TRUE'));
OUTPUT(Scrubs.Functions.fn_addr_rec_type(''), NAMED('fn_addr_rec_type_test2_TRUE'));

OUTPUT(Scrubs.Functions.fn_geo_coord('-82.335730'), NAMED('fn_geo_coord_test_TRUE'));
OUTPUT(Scrubs.Functions.fn_geo_coord('2016'), NAMED('fn_geo_coord_test2_FALSE'));
OUTPUT(Scrubs.Functions.fn_geo_coord('82.335730'), NAMED('fn_geo_coord_test3_TRUE'));
OUTPUT(Scrubs.Functions.fn_geo_coord('2016.ABCD'), NAMED('fn_geo_coord_test4_FALSE'));

// END Address Testing

// Business Testing
OUTPUT(Scrubs.Functions.fn_source('L0'), NAMED('fn_source_test_TRUE'));
OUTPUT(Scrubs.Functions.fn_source('##'), NAMED('fn_source_test2_FALSE'));

OUTPUT(Scrubs.Functions.fn_sic('1234'), NAMED('fn_sic_test_TRUE'));
OUTPUT(Scrubs.Functions.fn_sic('12345'), NAMED('fn_sic_test2_FALSE'));

OUTPUT(Scrubs.Functions.fn_naics('12345'), NAMED('fn_naics_test_TRUE'));
OUTPUT(Scrubs.Functions.fn_naics('1'), NAMED('fn_naics_test2_FALSE'));

OUTPUT(Scrubs.Functions.fn_company_xor_person('Company X', '', '', ''), NAMED('fn_company_xor_person_test_TRUE'));
OUTPUT(Scrubs.Functions.fn_company_xor_person('', 'Joe', '', 'Schmoe'), NAMED('fn_company_xor_person_test2_TRUE'));
OUTPUT(Scrubs.Functions.fn_company_xor_person('Company X', 'Joe', '', 'Schmoe'), NAMED('fn_company_xor_person_test3_FALSE'));
OUTPUT(Scrubs.Functions.fn_company_xor_person('', '', '', ''), NAMED('fn_company_xor_person_test4_FALSE'));

// END Business Testing