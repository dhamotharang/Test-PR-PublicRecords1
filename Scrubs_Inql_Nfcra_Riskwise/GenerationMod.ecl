// Machine-readable versions of the spec file and subsets thereof
IMPORT SALT39;
EXPORT GenerationMod := MODULE(SALT39.iGenerationMod)
 
  // SALT Version info
  EXPORT salt_VERSION := 'V3.9.0';
  EXPORT salt_MODULE := 'SALT39'; // Optional override by HACK:SALTMODULE
  EXPORT salt_TOOLSMODULE := 'SALTTOOLS30'; // Optional override by HACK:SALTTOOLSMODULE
 
  // Core module configuration values
  EXPORT spc_MODULE := 'Scrubs_Inql_Nfcra_Riskwise';
  EXPORT spc_NAMESCOPE := '';
  EXPORT spc_PROCESS := '';
  EXPORT spc_PROCLAYOUTS := 'Process__Layouts';
  EXPORT spc_IDNAME := ''; // cluster id (input)
  EXPORT spc_IDFIELD := ''; // cluster id (output)
  EXPORT spc_RIDFIELD := ''; // record id
  EXPORT spc_CONFIG := 'Config';
  EXPORT spc_CONFIGPARAM := FALSE;
  EXPORT spc_SOURCEFIELD := '';
  EXPORT spc_FILEPREFIX := 'In_';
  EXPORT spc_FILENAME := 'FILE';
  EXPORT spc_INGESTSTATUS := '';
  EXPORT spc_EXTERNAL_MAPPING := 'UniqueID:';
  EXPORT spc_EXTERNAL_BATCH_PARAM := ',/* MY_ */,orig_login_id,orig_billing_code,orig_transaction_id,orig_function_name,orig_company_id,orig_reference_code,orig_fname,orig_mname,orig_lname,orig_name_suffix,orig_fname_2,orig_mname_2,orig_lname_2,orig_name_suffix_2,orig_address,orig_city,orig_state,orig_zip,orig_zip4,orig_address_2,orig_city_2,orig_state_2,orig_zip_2,orig_zip4_2,orig_clean_address,orig_clean_city,orig_clean_state,orig_clean_zip,orig_clean_zip4,orig_phone,orig_homephone,orig_homephone_2,orig_workphone,orig_workphone_2,orig_ssn,orig_ssn_2,orig_free,orig_record_count,orig_price,orig_revenue,orig_full_name,orig_business_name,orig_business_name_2,orig_years,orig_pricing_error_code,orig_fcra_purpose,orig_result_format,orig_dob,orig_dob_2,orig_unique_id,orig_response_time,orig_data_source,orig_report_options,orig_end_user_name,orig_end_user_address_1,orig_end_user_address_2,orig_end_user_city,orig_end_user_state,orig_end_user_zip,orig_login_history_id,orig_employment_state,orig_end_user_industry_class,orig_function_specific_data,orig_date_added,orig_retail_price,orig_country_code,orig_email,orig_email_2,orig_dl_number,orig_dl_number_2,orig_sub_id,orig_neighbors,orig_relatives,orig_associates,orig_property,orig_bankruptcy,orig_dls,orig_mvs,orig_ip_address';
  EXPORT spc_HAS_TWOSTEP := FALSE;
  EXPORT spc_HAS_PARTITION := FALSE;
  EXPORT spc_HAS_FIELDTYPES := TRUE;
  EXPORT spc_HAS_INCREMENTAL := FALSE;
  EXPORT spc_HAS_ASOF := FALSE;
  EXPORT spc_HAS_NONCONTIGUOUS := FALSE;
  EXPORT spc_HAS_SUPERFILES := FALSE;
  EXPORT spc_HAS_CONSISTENT := FALSE;
  EXPORT spc_HAS_EXTERNAL := FALSE;
  EXPORT spc_HAS_PARENTS := FALSE;
  EXPORT spc_HAS_FORCE := FALSE;
  EXPORT spc_HAS_BLOCKLINK := FALSE;
 
  // The entire spec file
  EXPORT spcString :=
    'OPTIONS:-gh\n'
    + 'MODULE:Scrubs_Inql_Nfcra_Riskwise\n'
    + 'FILENAME:FILE\n'
    + '\n'
    + 'FIELDTYPE:DEFAULT:LEFTTRIM:NOQUOTES("\')\n'
    + 'FIELDTYPE:ALPHA:ALLOW(ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz):\n'
    + 'FIELDTYPE:NAME:ALLOW(ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz-,\'.):\n'
    + 'FIELDTYPE:NUMBER:ALLOW(0123456789):\n'
    + 'FIELDTYPE:WORDBAG:ALLOW(ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789<>{}[]-^=!+&,./:|#_@$):SPACES( ):ONFAIL(CLEAN):\n'
    + '\n'
    + 'FIELDTYPE:orig_login_id:SPACES( ):LIKE(WORDBAG):LEFTTRIM:LENGTHS(8,17,6):WORDS(1):ONFAIL(CLEAN)\n'
    + 'FIELDTYPE:orig_billing_code:SPACES( ):ALLOW(N):LEFTTRIM:LENGTHS(2):WORDS(1):ONFAIL(CLEAN)\n'
    + 'FIELDTYPE:orig_transaction_id:SPACES( ):ALLOW(0123456789U):WORDS(1):ONFAIL(CLEAN)\n'
    + 'FIELDTYPE:orig_function_name:SPACES( ):LIKE(WORDBAG):LEFTTRIM:LENGTHS(7):WORDS(1):ONFAIL(CLEAN)\n'
    + 'FIELDTYPE:orig_company_id:SPACES( ):LIKE(NUMBER):WORDS(1):ONFAIL(CLEAN)\n'
    + 'FIELDTYPE:orig_reference_code:SPACES( ):ALLOW(N):LEFTTRIM:LENGTHS(2):WORDS(1):ONFAIL(CLEAN)\n'
    + 'FIELDTYPE:orig_fname:SPACES( ):LIKE(NAME):WORDS(1,2):ONFAIL(CLEAN)\n'
    + 'FIELDTYPE:orig_mname:SPACES( ):LIKE(NAME):WORDS(1,2):ONFAIL(CLEAN)\n'
    + 'FIELDTYPE:orig_lname:SPACES( ):LIKE(NAME):WORDS(1,2,3):ONFAIL(CLEAN)\n'
    + 'FIELDTYPE:orig_name_suffix:SPACES( ):ALLOW(N):LEFTTRIM:LENGTHS(2):WORDS(1):ONFAIL(CLEAN)\n'
    + 'FIELDTYPE:orig_fname_2:SPACES( ):LIKE(NAME):WORDS(1):ONFAIL(CLEAN)\n'
    + 'FIELDTYPE:orig_mname_2:SPACES( ):ALLOW(N):LEFTTRIM:LENGTHS(2):WORDS(1):ONFAIL(CLEAN)\n'
    + 'FIELDTYPE:orig_lname_2:SPACES( ):LIKE(NAME):WORDS(1):ONFAIL(CLEAN)\n'
    + 'FIELDTYPE:orig_name_suffix_2:SPACES( ):ALLOW(N):LEFTTRIM:LENGTHS(2):WORDS(1):ONFAIL(CLEAN)\n'
    + 'FIELDTYPE:orig_address:SPACES( ):LIKE(WORDBAG):ONFAIL(CLEAN)\n'
    + 'FIELDTYPE:orig_city:SPACES( ):LIKE(ALPHA):WORDS(1,2,3):ONFAIL(CLEAN)\n'
    + 'FIELDTYPE:orig_state:SPACES( ):LIKE(ALPHA):LENGTHS(2):WORDS(1):ONFAIL(CLEAN)\n'
    + 'FIELDTYPE:orig_zip:SPACES( ):TYPE(NUMBERFIELD):LEFTTRIM:LENGTHS(5,9,2):WORDS(1):ONFAIL(CLEAN)\n'
    + 'FIELDTYPE:orig_zip4:SPACES( ):ALLOW(N):LEFTTRIM:LENGTHS(2):WORDS(1):ONFAIL(CLEAN)\n'
    + 'FIELDTYPE:orig_address_2:SPACES( ):ALLOW(N):LEFTTRIM:LENGTHS(2):WORDS(1):ONFAIL(CLEAN)\n'
    + 'FIELDTYPE:orig_city_2:SPACES( ):LIKE(ALPHA):WORDS(1,2):ONFAIL(CLEAN)\n'
    + 'FIELDTYPE:orig_state_2:SPACES( ):LIKE(ALPHA):LENGTHS(2):WORDS(1):ONFAIL(CLEAN)\n'
    + 'FIELDTYPE:orig_zip_2:SPACES( ):ALLOW(0123456789N):LEFTTRIM:LENGTHS(2,5,9):WORDS(1):ONFAIL(CLEAN)\n'
    + 'FIELDTYPE:orig_zip4_2:SPACES( ):ALLOW(N):LEFTTRIM:LENGTHS(2):WORDS(1):ONFAIL(CLEAN)\n'
    + 'FIELDTYPE:orig_clean_address:SPACES( ):ALLOW(N):LEFTTRIM:LENGTHS(2):WORDS(1):ONFAIL(CLEAN)\n'
    + 'FIELDTYPE:orig_clean_city:SPACES( ):ALLOW(N):LEFTTRIM:LENGTHS(2):WORDS(1):ONFAIL(CLEAN)\n'
    + 'FIELDTYPE:orig_clean_state:SPACES( ):ALLOW(N):LEFTTRIM:LENGTHS(2):WORDS(1):ONFAIL(CLEAN)\n'
    + 'FIELDTYPE:orig_clean_zip:SPACES( ):ALLOW(N):LEFTTRIM:LENGTHS(2):WORDS(1):ONFAIL(CLEAN)\n'
    + 'FIELDTYPE:orig_clean_zip4:SPACES( ):ALLOW(N):LEFTTRIM:LENGTHS(2):WORDS(1):ONFAIL(CLEAN)\n'
    + 'FIELDTYPE:orig_phone:SPACES( ):ALLOW(N):LEFTTRIM:LENGTHS(2):WORDS(1):ONFAIL(CLEAN)\n'
    + 'FIELDTYPE:orig_homephone:SPACES( ):ALLOW(-0123456789N):LEFTTRIM:LENGTHS(10,2,7,12):WORDS(1):ONFAIL(CLEAN)\n'
    + 'FIELDTYPE:orig_homephone_2:SPACES( ):ALLOW(0123456789N):LEFTTRIM:LENGTHS(2,10):WORDS(1):ONFAIL(CLEAN)\n'
    + 'FIELDTYPE:orig_workphone:SPACES( ):ALLOW(0123456789N):LEFTTRIM:LENGTHS(2,10):WORDS(1):ONFAIL(CLEAN)\n'
    + 'FIELDTYPE:orig_workphone_2:SPACES( ):ALLOW(N):LEFTTRIM:LENGTHS(2,0):WORDS(1,0):ONFAIL(CLEAN)\n'
    + 'FIELDTYPE:orig_ssn:SPACES( ):ALLOW(0123456789N):LEFTTRIM:LENGTHS(9,2):WORDS(1):ONFAIL(CLEAN)\n'
    + 'FIELDTYPE:orig_ssn_2:SPACES( ):ALLOW(0123456789N):LEFTTRIM:LENGTHS(2,9):WORDS(1):ONFAIL(CLEAN)\n'
    + 'FIELDTYPE:orig_free:SPACES( ):ALLOW(02):LEFTTRIM:LENGTHS(1):WORDS(1):ONFAIL(CLEAN)\n'
    + 'FIELDTYPE:orig_record_count:SPACES( ):ALLOW(1):LEFTTRIM:LENGTHS(1):WORDS(1):ONFAIL(CLEAN)\n'
    + 'FIELDTYPE:orig_price:SPACES( ):TYPE(NUMBERFIELD):LEFTTRIM:LENGTHS(8,9):WORDS(1):ONFAIL(CLEAN)\n'
    + 'FIELDTYPE:orig_revenue:SPACES( ):ALLOW(N):LEFTTRIM:LENGTHS(2):WORDS(1):ONFAIL(CLEAN)\n'
    + 'FIELDTYPE:orig_full_name:SPACES( ):ALLOW(N):LEFTTRIM:LENGTHS(2):WORDS(1):ONFAIL(CLEAN)\n'
    + 'FIELDTYPE:orig_business_name:SPACES( ):LIKE(WORDBAG):WORDS(1,2,3,4,5,6):ONFAIL(CLEAN)\n'
    + 'FIELDTYPE:orig_business_name_2:SPACES( ):LIKE(NAME):WORDS(1,2,3,4):ONFAIL(CLEAN)\n'
    + 'FIELDTYPE:orig_years:SPACES( ):ALLOW(N):LEFTTRIM:LENGTHS(2):WORDS(1):ONFAIL(CLEAN)\n'
    + 'FIELDTYPE:orig_pricing_error_code:SPACES( ):ALLOW(-02):LEFTTRIM:LENGTHS(1,2):WORDS(1):ONFAIL(CLEAN)\n'
    + 'FIELDTYPE:orig_fcra_purpose:SPACES( ):ALLOW(0):LEFTTRIM:LENGTHS(1):WORDS(1):ONFAIL(CLEAN)\n'
    + 'FIELDTYPE:orig_result_format:SPACES( ):ALLOW(0):LEFTTRIM:LENGTHS(1):WORDS(1):ONFAIL(CLEAN)\n'
    + 'FIELDTYPE:orig_dob:SPACES( ):ALLOW(/0123456789N):LEFTTRIM:LENGTHS(8,2):WORDS(1):ONFAIL(CLEAN)\n'
    + 'FIELDTYPE:orig_dob_2:SPACES( ):ALLOW(1N):LEFTTRIM:LENGTHS(2):WORDS(1):ONFAIL(CLEAN)\n'
    + 'FIELDTYPE:orig_unique_id:SPACES( ):ALLOW(N):LEFTTRIM:LENGTHS(2):WORDS(1):ONFAIL(CLEAN)\n'
    + 'FIELDTYPE:orig_response_time:SPACES( ):TYPE(NUMBERFIELD):LEFTTRIM:LENGTHS(4):WORDS(1):ONFAIL(CLEAN)\n'
    + 'FIELDTYPE:orig_data_source:SPACES( ):ALLOW(N):LEFTTRIM:LENGTHS(2):WORDS(1):ONFAIL(CLEAN)\n'
    + 'FIELDTYPE:orig_report_options:SPACES( ):ALLOW(N):LEFTTRIM:LENGTHS(2):WORDS(1):ONFAIL(CLEAN)\n'
    + 'FIELDTYPE:orig_end_user_name:SPACES( ):ALLOW():LEFTTRIM:LENGTHS(0):WORDS(0):ONFAIL(CLEAN)\n'
    + 'FIELDTYPE:orig_end_user_address_1:SPACES( ):ALLOW():LEFTTRIM:LENGTHS(0):WORDS(0):ONFAIL(CLEAN)\n'
    + 'FIELDTYPE:orig_end_user_address_2:SPACES( ):ALLOW(N):LEFTTRIM:LENGTHS(2):WORDS(1):ONFAIL(CLEAN)\n'
    + 'FIELDTYPE:orig_end_user_city:SPACES( ):ALLOW():LEFTTRIM:LENGTHS(0):WORDS(0):ONFAIL(CLEAN)\n'
    + 'FIELDTYPE:orig_end_user_state:SPACES( ):ALLOW():LEFTTRIM:LENGTHS(0):WORDS(0):ONFAIL(CLEAN)\n'
    + 'FIELDTYPE:orig_end_user_zip:SPACES( ):ALLOW():LEFTTRIM:LENGTHS(0):WORDS(0):ONFAIL(CLEAN)\n'
    + 'FIELDTYPE:orig_login_history_id:SPACES( ):ALLOW(0):LEFTTRIM:LENGTHS(1):WORDS(1):ONFAIL(CLEAN)\n'
    + 'FIELDTYPE:orig_employment_state:SPACES( ):ALLOW(N):LEFTTRIM:LENGTHS(2):WORDS(1):ONFAIL(CLEAN)\n'
    + 'FIELDTYPE:orig_end_user_industry_class:SPACES( ):ALLOW(0):LEFTTRIM:LENGTHS(1):WORDS(1):ONFAIL(CLEAN)\n'
    + 'FIELDTYPE:orig_function_specific_data:SPACES( ):ALLOW(N):LEFTTRIM:LENGTHS(2):WORDS(1):ONFAIL(CLEAN)\n'
    + 'FIELDTYPE:orig_date_added:SPACES( ):ALLOW( -0123456789:):LEFTTRIM:LENGTHS(19):WORDS(2):ONFAIL(CLEAN)\n'
    + 'FIELDTYPE:orig_retail_price:SPACES( ):ALLOW(.0123478N):LEFTTRIM:LENGTHS(8,2):WORDS(1):ONFAIL(CLEAN)\n'
    + 'FIELDTYPE:orig_country_code:SPACES( ):ALLOW(N):LEFTTRIM:LENGTHS(2):WORDS(1):ONFAIL(CLEAN)\n'
    + 'FIELDTYPE:orig_email:SPACES( ):LIKE(WORDBAG):LEFTTRIM:WORDS(1):ONFAIL(CLEAN)\n'
    + 'FIELDTYPE:orig_email_2:SPACES( ):ALLOW(N):LEFTTRIM:LENGTHS(2):WORDS(1):ONFAIL(CLEAN)\n'
    + 'FIELDTYPE:orig_dl_number:SPACES( ):LIKE(WORDBAG):LEFTTRIM:WORDS(1):ONFAIL(CLEAN)\n'
    + 'FIELDTYPE:orig_dl_number_2:SPACES( ):ALLOW(N):LEFTTRIM:LENGTHS(2):WORDS(1):ONFAIL(CLEAN)\n'
    + 'FIELDTYPE:orig_sub_id:SPACES( ):LIKE(WORDBAG):LEFTTRIM:WORDS(1):ONFAIL(CLEAN)\n'
    + 'FIELDTYPE:orig_neighbors:SPACES( ):ALLOW(0):LEFTTRIM:LENGTHS(1):WORDS(1):ONFAIL(CLEAN)\n'
    + 'FIELDTYPE:orig_relatives:SPACES( ):ALLOW(0):LEFTTRIM:LENGTHS(1):WORDS(1):ONFAIL(CLEAN)\n'
    + 'FIELDTYPE:orig_associates:SPACES( ):ALLOW(0):LEFTTRIM:LENGTHS(1):WORDS(1):ONFAIL(CLEAN)\n'
    + 'FIELDTYPE:orig_property:SPACES( ):ALLOW(0):LEFTTRIM:LENGTHS(1):WORDS(1):ONFAIL(CLEAN)\n'
    + 'FIELDTYPE:orig_bankruptcy:SPACES( ):ALLOW(0):LEFTTRIM:LENGTHS(1):WORDS(1):ONFAIL(CLEAN)\n'
    + 'FIELDTYPE:orig_dls:SPACES( ):ALLOW(0):LEFTTRIM:LENGTHS(1):WORDS(1):ONFAIL(CLEAN)\n'
    + 'FIELDTYPE:orig_mvs:SPACES( ):ALLOW(0):LEFTTRIM:LENGTHS(1):WORDS(1):ONFAIL(CLEAN)\n'
    + 'FIELDTYPE:orig_ip_address:SPACES( ):TYPE(NUMBERFIELD):LEFTTRIM:LENGTHS(13,14,11,12):WORDS(1):ONFAIL(CLEAN)\n'
    + '\n'
    + 'FIELD:orig_login_id:LIKE(orig_login_id):TYPE(STRING20):0,0\n'
    + 'FIELD:orig_billing_code:LIKE(orig_billing_code):TYPE(STRING20):0,0\n'
    + 'FIELD:orig_transaction_id:LIKE(orig_transaction_id):TYPE(STRING16):0,0\n'
    + 'FIELD:orig_function_name:LIKE(orig_function_name):TYPE(STRING20):0,0\n'
    + 'FIELD:orig_company_id:LIKE(orig_company_id):TYPE(STRING10):0,0\n'
    + 'FIELD:orig_reference_code:LIKE(orig_reference_code):TYPE(STRING50):0,0\n'
    + 'FIELD:orig_fname:LIKE(orig_fname):TYPE(STRING30):0,0\n'
    + 'FIELD:orig_mname:LIKE(orig_mname):TYPE(STRING30):0,0\n'
    + 'FIELD:orig_lname:LIKE(orig_lname):TYPE(STRING30):0,0\n'
    + 'FIELD:orig_name_suffix:LIKE(orig_name_suffix):TYPE(STRING10):0,0\n'
    + 'FIELD:orig_fname_2:LIKE(orig_fname_2):TYPE(STRING30):0,0\n'
    + 'FIELD:orig_mname_2:LIKE(orig_mname_2):TYPE(STRING30):0,0\n'
    + 'FIELD:orig_lname_2:LIKE(orig_lname_2):TYPE(STRING30):0,0\n'
    + 'FIELD:orig_name_suffix_2:LIKE(orig_name_suffix_2):TYPE(STRING10):0,0\n'
    + 'FIELD:orig_address:LIKE(orig_address):TYPE(STRING60):0,0\n'
    + 'FIELD:orig_city:LIKE(orig_city):TYPE(STRING50):0,0\n'
    + 'FIELD:orig_state:LIKE(orig_state):TYPE(STRING2):0,0\n'
    + 'FIELD:orig_zip:LIKE(orig_zip):TYPE(STRING9):0,0\n'
    + 'FIELD:orig_zip4:LIKE(orig_zip4):TYPE(STRING4):0,0\n'
    + 'FIELD:orig_address_2:LIKE(orig_address_2):TYPE(STRING60):0,0\n'
    + 'FIELD:orig_city_2:LIKE(orig_city_2):TYPE(STRING50):0,0\n'
    + 'FIELD:orig_state_2:LIKE(orig_state_2):TYPE(STRING2):0,0\n'
    + 'FIELD:orig_zip_2:LIKE(orig_zip_2):TYPE(STRING9):0,0\n'
    + 'FIELD:orig_zip4_2:LIKE(orig_zip4_2):TYPE(STRING4):0,0\n'
    + 'FIELD:orig_clean_address:LIKE(orig_clean_address):TYPE(STRING60):0,0\n'
    + 'FIELD:orig_clean_city:LIKE(orig_clean_city):TYPE(STRING50):0,0\n'
    + 'FIELD:orig_clean_state:LIKE(orig_clean_state):TYPE(STRING2):0,0\n'
    + 'FIELD:orig_clean_zip:LIKE(orig_clean_zip):TYPE(STRING5):0,0\n'
    + 'FIELD:orig_clean_zip4:LIKE(orig_clean_zip4):TYPE(STRING4):0,0\n'
    + 'FIELD:orig_phone:LIKE(orig_phone):TYPE(STRING20):0,0\n'
    + 'FIELD:orig_homephone:LIKE(orig_homephone):TYPE(STRING20):0,0\n'
    + 'FIELD:orig_homephone_2:LIKE(orig_homephone_2):TYPE(STRING20):0,0\n'
    + 'FIELD:orig_workphone:LIKE(orig_workphone):TYPE(STRING20):0,0\n'
    + 'FIELD:orig_workphone_2:LIKE(orig_workphone_2):TYPE(STRING20):0,0\n'
    + 'FIELD:orig_ssn:LIKE(orig_ssn):TYPE(STRING9):0,0\n'
    + 'FIELD:orig_ssn_2:LIKE(orig_ssn_2):TYPE(STRING9):0,0\n'
    + 'FIELD:orig_free:LIKE(orig_free):TYPE(STRING20):0,0\n'
    + 'FIELD:orig_record_count:LIKE(orig_record_count):TYPE(STRING20):0,0\n'
    + 'FIELD:orig_price:LIKE(orig_price):TYPE(STRING20):0,0\n'
    + 'FIELD:orig_revenue:LIKE(orig_revenue):TYPE(STRING20):0,0\n'
    + 'FIELD:orig_full_name:LIKE(orig_full_name):TYPE(STRING60):0,0\n'
    + 'FIELD:orig_business_name:LIKE(orig_business_name):TYPE(STRING50):0,0\n'
    + 'FIELD:orig_business_name_2:LIKE(orig_business_name_2):TYPE(STRING50):0,0\n'
    + 'FIELD:orig_years:LIKE(orig_years):TYPE(STRING20):0,0\n'
    + 'FIELD:orig_pricing_error_code:LIKE(orig_pricing_error_code):TYPE(STRING20):0,0\n'
    + 'FIELD:orig_fcra_purpose:LIKE(orig_fcra_purpose):TYPE(STRING20):0,0\n'
    + 'FIELD:orig_result_format:LIKE(orig_result_format):TYPE(STRING3):0,0\n'
    + 'FIELD:orig_dob:LIKE(orig_dob):TYPE(STRING8):0,0\n'
    + 'FIELD:orig_dob_2:LIKE(orig_dob_2):TYPE(STRING8):0,0\n'
    + 'FIELD:orig_unique_id:LIKE(orig_unique_id):TYPE(STRING32):0,0\n'
    + 'FIELD:orig_response_time:LIKE(orig_response_time):TYPE(STRING20):0,0\n'
    + 'FIELD:orig_data_source:LIKE(orig_data_source):TYPE(STRING8):0,0\n'
    + 'FIELD:orig_report_options:LIKE(orig_report_options):TYPE(STRING255):0,0\n'
    + 'FIELD:orig_end_user_name:LIKE(orig_end_user_name):TYPE(STRING80):0,0\n'
    + 'FIELD:orig_end_user_address_1:LIKE(orig_end_user_address_1):TYPE(STRING80):0,0\n'
    + 'FIELD:orig_end_user_address_2:LIKE(orig_end_user_address_2):TYPE(STRING80):0,0\n'
    + 'FIELD:orig_end_user_city:LIKE(orig_end_user_city):TYPE(STRING60):0,0\n'
    + 'FIELD:orig_end_user_state:LIKE(orig_end_user_state):TYPE(STRING2):0,0\n'
    + 'FIELD:orig_end_user_zip:LIKE(orig_end_user_zip):TYPE(STRING9):0,0\n'
    + 'FIELD:orig_login_history_id:LIKE(orig_login_history_id):TYPE(STRING20):0,0\n'
    + 'FIELD:orig_employment_state:LIKE(orig_employment_state):TYPE(STRING2):0,0\n'
    + 'FIELD:orig_end_user_industry_class:LIKE(orig_end_user_industry_class):TYPE(STRING20):0,0\n'
    + 'FIELD:orig_function_specific_data:LIKE(orig_function_specific_data):TYPE(STRING32):0,0\n'
    + 'FIELD:orig_date_added:LIKE(orig_date_added):TYPE(STRING20):0,0\n'
    + 'FIELD:orig_retail_price:LIKE(orig_retail_price):TYPE(STRING20):0,0\n'
    + 'FIELD:orig_country_code:LIKE(orig_country_code):TYPE(STRING4):0,0\n'
    + 'FIELD:orig_email:LIKE(orig_email):TYPE(STRING30):0,0\n'
    + 'FIELD:orig_email_2:LIKE(orig_email_2):TYPE(STRING30):0,0\n'
    + 'FIELD:orig_dl_number:LIKE(orig_dl_number):TYPE(STRING30):0,0\n'
    + 'FIELD:orig_dl_number_2:LIKE(orig_dl_number_2):TYPE(STRING30):0,0\n'
    + 'FIELD:orig_sub_id:LIKE(orig_sub_id):TYPE(STRING30):0,0\n'
    + 'FIELD:orig_neighbors:LIKE(orig_neighbors):TYPE(STRING20):0,0\n'
    + 'FIELD:orig_relatives:LIKE(orig_relatives):TYPE(STRING20):0,0\n'
    + 'FIELD:orig_associates:LIKE(orig_associates):TYPE(STRING20):0,0\n'
    + 'FIELD:orig_property:LIKE(orig_property):TYPE(STRING20):0,0\n'
    + 'FIELD:orig_bankruptcy:LIKE(orig_bankruptcy):TYPE(STRING1):0,0\n'
    + 'FIELD:orig_dls:LIKE(orig_dls):TYPE(STRING20):0,0\n'
    + 'FIELD:orig_mvs:LIKE(orig_mvs):TYPE(STRING20):0,0\n'
    + 'FIELD:orig_ip_address:LIKE(orig_ip_address):TYPE(STRING15):0,0'
    ;
 
  // Structured values
  EXPORT linkpaths := DATASET([
    ],{STRING linkpath;STRING compulsory;STRING optional;STRING bonus;STRING required;STRING search});
 
END;

