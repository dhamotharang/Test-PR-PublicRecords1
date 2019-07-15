// Machine-readable versions of the spec file and subsets thereof
IMPORT SALT39;
EXPORT GenerationMod := MODULE(SALT39.iGenerationMod)
 
  // SALT Version info
  EXPORT salt_VERSION := 'V3.9.0';
  EXPORT salt_MODULE := 'SALT39'; // Optional override by HACK:SALTMODULE
  EXPORT salt_TOOLSMODULE := 'SALTTOOLS30'; // Optional override by HACK:SALTTOOLSMODULE
 
  // Core module configuration values
  EXPORT spc_MODULE := 'Scrubs_Inql_fcra_Accurint';
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
  EXPORT spc_EXTERNAL_BATCH_PARAM := ',/* MY_ */,orig_end_user_id,orig_loginid,orig_billing_code,orig_transaction_id,orig_transaction_type,orig_neighbors,orig_relatives,orig_associates,orig_property,orig_company_id,orig_reference_code,orig_fname,orig_mname,orig_lname,orig_address,orig_city,orig_state,orig_zip,orig_zip4,orig_phone,orig_ssn,orig_free,orig_record_count,orig_price,orig_bankruptcy,orig_transaction_code,orig_dateadded,orig_full_name,orig_billingdate,orig_business_name,orig_pricing_error_code,orig_dl_purpose,orig_result_format,orig_dob,orig_unique_id,orig_dls,orig_mvs,orig_function_name,orig_response_time,orig_data_source,orig_glb_purpose,orig_report_options,orig_unused,orig_login_history_id,orig_aseid,orig_years,orig_ip_address,orig_source_code,orig_retail_price,inquiry_type,lex_id,reprice_batch_number,user_changed,date_changed,fcra_purpose,orig_address_2,orig_city_2,orig_state_2,orig_zip_2,orig_zip4_2,orig_jobid,orig_acctno,orig_end_user_name,orig_end_user_address_1,orig_end_user_address_2,orig_end_user_city,orig_end_user_state,orig_end_user_zip';
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
    + 'MODULE:Scrubs_Inql_fcra_Accurint\n'
    + 'FILENAME:FILE\n'
    + '\n'
    + 'FIELDTYPE:DEFAULT:LEFTTRIM:NOQUOTES("\')\n'
    + 'FIELDTYPE:ALPHA:ALLOW(ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz):\n'
    + 'FIELDTYPE:NAME:ALLOW(ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz-,\'.):\n'
    + 'FIELDTYPE:NUMBER:ALLOW(0123456789):\n'
    + 'FIELDTYPE:ALPHANUM:ALLOW(ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789):\n'
    + 'FIELDTYPE:WORDBAG:ALLOW(ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789<>{}[]-^=!+&,./:|#_@$;):SPACES( ):ONFAIL(CLEAN):\n'
    + '\n'
    + 'FIELDTYPE:orig_end_user_id:SPACES( ):ALLOW():LEFTTRIM:LENGTHS(0):WORDS(0):ONFAIL(CLEAN)\n'
    + 'FIELDTYPE:orig_loginid:SPACES( ):LIKE(WORDBAG):WORDS(1):ONFAIL(CLEAN)\n'
    + 'FIELDTYPE:orig_billing_code:SPACES( ):LIKE(WORDBAG):LEFTTRIM:WORDS(1,2):ONFAIL(CLEAN)\n'
    + 'FIELDTYPE:orig_transaction_id:SPACES( ):ALLOW(0123456789ABR):LEFTTRIM:WORDS(1):ONFAIL(CLEAN)\n'
    + 'FIELDTYPE:orig_transaction_type:SPACES( ):ALLOW(I):LEFTTRIM:LENGTHS(1):WORDS(1):ONFAIL(CLEAN)\n'
    + 'FIELDTYPE:orig_neighbors:SPACES( ):ALLOW(0):LEFTTRIM:LENGTHS(1):WORDS(1):ONFAIL(CLEAN)\n'
    + 'FIELDTYPE:orig_relatives:SPACES( ):ALLOW(0):LEFTTRIM:LENGTHS(1):WORDS(1):ONFAIL(CLEAN)\n'
    + 'FIELDTYPE:orig_associates:SPACES( ):ALLOW(0):LEFTTRIM:LENGTHS(1):WORDS(1):ONFAIL(CLEAN)\n'
    + 'FIELDTYPE:orig_property:SPACES( ):ALLOW(01):LEFTTRIM:LENGTHS(1):WORDS(1):ONFAIL(CLEAN)\n'
    + 'FIELDTYPE:orig_company_id:SPACES( ):LIKE(NUMBER):WORDS(1):ONFAIL(CLEAN)\n'
    + 'FIELDTYPE:orig_reference_code:SPACES( ):LIKE(WORDBAG):ONFAIL(CLEAN)\n'
    + 'FIELDTYPE:orig_fname:SPACES( ):LIKE(NAME):WORDS(1,0,2):ONFAIL(CLEAN)\n'
    + 'FIELDTYPE:orig_mname:SPACES( ):LIKE(NAME):WORDS(0,1):ONFAIL(CLEAN)\n'
    + 'FIELDTYPE:orig_lname:SPACES( ):LIKE(NAME):WORDS(1,0,2,3):ONFAIL(CLEAN)\n'
    + 'FIELDTYPE:orig_address:SPACES( ):LIKE(WORDBAG):ONFAIL(CLEAN)\n'
    + 'FIELDTYPE:orig_city:SPACES( ):LIKE(ALPHA):WORDS(0,1,2,3):ONFAIL(CLEAN)\n'
    + 'FIELDTYPE:orig_state:SPACES( ):LIKE(ALPHA):LEFTTRIM:LENGTHS(0,2):WORDS(0,1):ONFAIL(CLEAN)\n'
    + 'FIELDTYPE:orig_zip:SPACES( ):LIKE(NUMBER):LEFTTRIM:LENGTHS(0,5):WORDS(0,1):ONFAIL(CLEAN)\n'
    + 'FIELDTYPE:orig_zip4:SPACES( ):LIKE(NUMBER):LEFTTRIM:LENGTHS(0,4):WORDS(0,1):ONFAIL(CLEAN)\n'
    + 'FIELDTYPE:orig_phone:SPACES( ):LIKE(NUMBER):LEFTTRIM:LENGTHS(0):WORDS(0):ONFAIL(CLEAN)\n'
    + 'FIELDTYPE:orig_ssn:SPACES( ):LIKE(NUMBER):LEFTTRIM:LENGTHS(9,0):WORDS(1,0):ONFAIL(CLEAN)\n'
    + 'FIELDTYPE:orig_free:SPACES( ):ALLOW(04):LEFTTRIM:LENGTHS(1):WORDS(1):ONFAIL(CLEAN)\n'
    + 'FIELDTYPE:orig_record_count:SPACES( ):LIKE(NUMBER):LEFTTRIM:LENGTHS(1,2):WORDS(1):ONFAIL(CLEAN)\n'
    + 'FIELDTYPE:orig_price:SPACES( ):TYPE(NUMBERFIELD):LEFTTRIM:LENGTHS(9,8):WORDS(1):ONFAIL(CLEAN)\n'
    + 'FIELDTYPE:orig_bankruptcy:SPACES( ):ALLOW(01):LEFTTRIM:LENGTHS(1):WORDS(1):ONFAIL(CLEAN)\n'
    + 'FIELDTYPE:orig_transaction_code:SPACES( ):LIKE(NUMBER):LEFTTRIM:LENGTHS(0,3):WORDS(0,1):ONFAIL(CLEAN)\n'
    + 'FIELDTYPE:orig_dateadded:SPACES( ):ALLOW( 0123456789:AMOPct):LEFTTRIM:LENGTHS(26):WORDS(4):ONFAIL(CLEAN)\n'
    + 'FIELDTYPE:orig_full_name:SPACES( ):ALLOW():LEFTTRIM:LENGTHS(0):WORDS(0):ONFAIL(CLEAN)\n'
    + 'FIELDTYPE:orig_billingdate:SPACES( ):ALLOW( 0123456789:AMOPct):LEFTTRIM:LENGTHS(26,0):WORDS(4,0):ONFAIL(CLEAN)\n'
    + 'FIELDTYPE:orig_business_name:SPACES( ):ALLOW():LEFTTRIM:LENGTHS(0):WORDS(0):ONFAIL(CLEAN)\n'
    + 'FIELDTYPE:orig_pricing_error_code:SPACES( ):ALLOW(-012):LEFTTRIM:LENGTHS(1,2):WORDS(1):ONFAIL(CLEAN)\n'
    + 'FIELDTYPE:orig_dl_purpose:SPACES( ):ALLOW(0134):LEFTTRIM:LENGTHS(1):WORDS(1):ONFAIL(CLEAN)\n'
    + 'FIELDTYPE:orig_result_format:SPACES( ):ALLOW(0cn):LEFTTRIM:LENGTHS(1,2):WORDS(1):ONFAIL(CLEAN)\n'
    + 'FIELDTYPE:orig_dob:SPACES( ):LIKE(NUMBER):LEFTTRIM:LENGTHS(0,8):WORDS(0,1):ONFAIL(CLEAN)\n'
    + 'FIELDTYPE:orig_unique_id:SPACES( ):LIKE(ALPHANUM):LEFTTRIM:WORDS(1,0):ONFAIL(CLEAN)\n'
    + 'FIELDTYPE:orig_dls:SPACES( ):ALLOW(0):LEFTTRIM:LENGTHS(1):WORDS(1):ONFAIL(CLEAN)\n'
    + 'FIELDTYPE:orig_mvs:SPACES( ):ALLOW(0):LEFTTRIM:LENGTHS(1):WORDS(1):ONFAIL(CLEAN)\n'
    + 'FIELDTYPE:orig_function_name:SPACES( ):LIKE(WORDBAG):LEFTTRIM:WORDS(1):ONFAIL(CLEAN)\n'
    + 'FIELDTYPE:orig_response_time:SPACES( ):TYPE(NUMBERFIELD):LEFTTRIM:LENGTHS(4):WORDS(1):ONFAIL(CLEAN)\n'
    + 'FIELDTYPE:orig_data_source:SPACES( ):ALLOW():LEFTTRIM:LENGTHS(0):WORDS(0):ONFAIL(CLEAN)\n'
    + 'FIELDTYPE:orig_glb_purpose:SPACES( ):LIKE(NUMBER):LEFTTRIM:LENGTHS(1,2):WORDS(1):ONFAIL(CLEAN)\n'
    + 'FIELDTYPE:orig_report_options:SPACES( ):LIKE(WORDBAG):LEFTTRIM:WORDS(1,4):ONFAIL(CLEAN)\n'
    + 'FIELDTYPE:orig_unused:SPACES( ):ALLOW():LEFTTRIM:LENGTHS(0):WORDS(0):ONFAIL(CLEAN)\n'
    + 'FIELDTYPE:orig_login_history_id:SPACES( ):LIKE(NUMBER):LEFTTRIM:LENGTHS(1,10,9):WORDS(1):ONFAIL(CLEAN)\n'
    + 'FIELDTYPE:orig_aseid:SPACES( ):ALLOW(38):LEFTTRIM:LENGTHS(1):WORDS(1):ONFAIL(CLEAN)\n'
    + 'FIELDTYPE:orig_years:SPACES( ):ALLOW():LEFTTRIM:LENGTHS(0):WORDS(0):ONFAIL(CLEAN)\n'
    + 'FIELDTYPE:orig_ip_address:SPACES( ):TYPE(NUMBERFIELD):LEFTTRIM:WORDS(1):ONFAIL(CLEAN)\n'
    + 'FIELDTYPE:orig_source_code:SPACES( ):ALLOW(012):LEFTTRIM:LENGTHS(1,3):WORDS(1):ONFAIL(CLEAN)\n'
    + 'FIELDTYPE:orig_retail_price:SPACES( ):TYPE(NUMBERFIELD):LEFTTRIM:WORDS(0,1):ONFAIL(CLEAN)\n'
    + 'FIELDTYPE:inquiry_type:SPACES( ):ALLOW():LEFTTRIM:LENGTHS(0):WORDS(0):ONFAIL(CLEAN)\n'
    + 'FIELDTYPE:lex_id:SPACES( ):ALLOW():LEFTTRIM:LENGTHS(0):WORDS(0):ONFAIL(CLEAN)\n'
    + 'FIELDTYPE:reprice_batch_number:SPACES( ):ALLOW():LEFTTRIM:LENGTHS(0):WORDS(0):ONFAIL(CLEAN)\n'
    + 'FIELDTYPE:user_changed:SPACES( ):ALLOW():LEFTTRIM:LENGTHS(0):WORDS(0):ONFAIL(CLEAN)\n'
    + 'FIELDTYPE:date_changed:SPACES( ):ALLOW():LEFTTRIM:LENGTHS(0):WORDS(0):ONFAIL(CLEAN)\n'
    + 'FIELDTYPE:fcra_purpose:SPACES( ):ALLOW(01235):LEFTTRIM:LENGTHS(1,2):WORDS(1):ONFAIL(CLEAN)\n'
    + 'FIELDTYPE:orig_address_2:SPACES( ):LIKE(WORDBAG):LEFTTRIM:LENGTHS(0):WORDS(0):ONFAIL(CLEAN)\n'
    + 'FIELDTYPE:orig_city_2:SPACES( ):ALLOW():LEFTTRIM:LENGTHS(0):WORDS(0):ONFAIL(CLEAN)\n'
    + 'FIELDTYPE:orig_state_2:SPACES( ):ALLOW():LEFTTRIM:LENGTHS(0):WORDS(0):ONFAIL(CLEAN)\n'
    + 'FIELDTYPE:orig_zip_2:SPACES( ):ALLOW():LEFTTRIM:LENGTHS(0):WORDS(0):ONFAIL(CLEAN)\n'
    + 'FIELDTYPE:orig_zip4_2:SPACES( ):ALLOW():LEFTTRIM:LENGTHS(0):WORDS(0):ONFAIL(CLEAN)\n'
    + 'FIELDTYPE:orig_jobid:SPACES( ):LIKE(NUMBER):LEFTTRIM:LENGTHS(8,0):WORDS(1,0):ONFAIL(CLEAN)\n'
    + 'FIELDTYPE:orig_acctno:SPACES( ):LIKE(NUMBER):WORDS(1,0):ONFAIL(CLEAN)\n'
    + 'FIELDTYPE:orig_end_user_name:SPACES( ):LIKE(NAME):LEFTTRIM:WORDS(0,1):ONFAIL(CLEAN)\n'
    + 'FIELDTYPE:orig_end_user_address_1:SPACES( ):LIKE(WORDBAG):ONFAIL(CLEAN)\n'
    + 'FIELDTYPE:orig_end_user_address_2:SPACES( ):ALLOW():LEFTTRIM:LENGTHS(0):WORDS(0):ONFAIL(CLEAN)\n'
    + 'FIELDTYPE:orig_end_user_city:SPACES( ):LIKE(ALPHA):LEFTTRIM:WORDS(0,1,2):ONFAIL(CLEAN)\n'
    + 'FIELDTYPE:orig_end_user_state:SPACES( ):LIKE(ALPHA):LEFTTRIM:LENGTHS(0,2):WORDS(0,1):ONFAIL(CLEAN)\n'
    + 'FIELDTYPE:orig_end_user_zip:SPACES( ):LIKE(NUMBER):LEFTTRIM:LENGTHS(0,5):WORDS(0,1):ONFAIL(CLEAN)\n'
    + '\n'
    + '\n'
    + 'FIELD:orig_end_user_id:LIKE(orig_end_user_id):TYPE(STRING):0,0\n'
    + 'FIELD:orig_loginid:LIKE(orig_loginid):TYPE(STRING):0,0\n'
    + 'FIELD:orig_billing_code:LIKE(orig_billing_code):TYPE(STRING):0,0\n'
    + 'FIELD:orig_transaction_id:LIKE(orig_transaction_id):TYPE(STRING):0,0\n'
    + 'FIELD:orig_transaction_type:LIKE(orig_transaction_type):TYPE(STRING):0,0\n'
    + 'FIELD:orig_neighbors:LIKE(orig_neighbors):TYPE(STRING):0,0\n'
    + 'FIELD:orig_relatives:LIKE(orig_relatives):TYPE(STRING):0,0\n'
    + 'FIELD:orig_associates:LIKE(orig_associates):TYPE(STRING):0,0\n'
    + 'FIELD:orig_property:LIKE(orig_property):TYPE(STRING):0,0\n'
    + 'FIELD:orig_company_id:LIKE(orig_company_id):TYPE(STRING):0,0\n'
    + 'FIELD:orig_reference_code:LIKE(orig_reference_code):TYPE(STRING):0,0\n'
    + 'FIELD:orig_fname:LIKE(orig_fname):TYPE(STRING):0,0\n'
    + 'FIELD:orig_mname:LIKE(orig_mname):TYPE(STRING):0,0\n'
    + 'FIELD:orig_lname:LIKE(orig_lname):TYPE(STRING):0,0\n'
    + 'FIELD:orig_address:LIKE(orig_address):TYPE(STRING):0,0\n'
    + 'FIELD:orig_city:LIKE(orig_city):TYPE(STRING):0,0\n'
    + 'FIELD:orig_state:LIKE(orig_state):TYPE(STRING):0,0\n'
    + 'FIELD:orig_zip:LIKE(orig_zip):TYPE(STRING):0,0\n'
    + 'FIELD:orig_zip4:LIKE(orig_zip4):TYPE(STRING):0,0\n'
    + 'FIELD:orig_phone:LIKE(orig_phone):TYPE(STRING):0,0\n'
    + 'FIELD:orig_ssn:LIKE(orig_ssn):TYPE(STRING):0,0\n'
    + 'FIELD:orig_free:LIKE(orig_free):TYPE(STRING):0,0\n'
    + 'FIELD:orig_record_count:LIKE(orig_record_count):TYPE(STRING):0,0\n'
    + 'FIELD:orig_price:LIKE(orig_price):TYPE(STRING):0,0\n'
    + 'FIELD:orig_bankruptcy:LIKE(orig_bankruptcy):TYPE(STRING):0,0\n'
    + 'FIELD:orig_transaction_code:LIKE(orig_transaction_code):TYPE(STRING):0,0\n'
    + 'FIELD:orig_dateadded:LIKE(orig_dateadded):TYPE(STRING):0,0\n'
    + 'FIELD:orig_full_name:LIKE(orig_full_name):TYPE(STRING):0,0\n'
    + 'FIELD:orig_billingdate:LIKE(orig_billingdate):TYPE(STRING):0,0\n'
    + 'FIELD:orig_business_name:LIKE(orig_business_name):TYPE(STRING):0,0\n'
    + 'FIELD:orig_pricing_error_code:LIKE(orig_pricing_error_code):TYPE(STRING):0,0\n'
    + 'FIELD:orig_dl_purpose:LIKE(orig_dl_purpose):TYPE(STRING):0,0\n'
    + 'FIELD:orig_result_format:LIKE(orig_result_format):TYPE(STRING):0,0\n'
    + 'FIELD:orig_dob:LIKE(orig_dob):TYPE(STRING):0,0\n'
    + 'FIELD:orig_unique_id:LIKE(orig_unique_id):TYPE(STRING):0,0\n'
    + 'FIELD:orig_dls:LIKE(orig_dls):TYPE(STRING):0,0\n'
    + 'FIELD:orig_mvs:LIKE(orig_mvs):TYPE(STRING):0,0\n'
    + 'FIELD:orig_function_name:LIKE(orig_function_name):TYPE(STRING):0,0\n'
    + 'FIELD:orig_response_time:LIKE(orig_response_time):TYPE(STRING):0,0\n'
    + 'FIELD:orig_data_source:LIKE(orig_data_source):TYPE(STRING):0,0\n'
    + 'FIELD:orig_glb_purpose:LIKE(orig_glb_purpose):TYPE(STRING):0,0\n'
    + 'FIELD:orig_report_options:LIKE(orig_report_options):TYPE(STRING):0,0\n'
    + 'FIELD:orig_unused:LIKE(orig_unused):TYPE(STRING):0,0\n'
    + 'FIELD:orig_login_history_id:LIKE(orig_login_history_id):TYPE(STRING):0,0\n'
    + 'FIELD:orig_aseid:LIKE(orig_aseid):TYPE(STRING):0,0\n'
    + 'FIELD:orig_years:LIKE(orig_years):TYPE(STRING):0,0\n'
    + 'FIELD:orig_ip_address:LIKE(orig_ip_address):TYPE(STRING):0,0\n'
    + 'FIELD:orig_source_code:LIKE(orig_source_code):TYPE(STRING):0,0\n'
    + 'FIELD:orig_retail_price:LIKE(orig_retail_price):TYPE(STRING):0,0\n'
    + 'FIELD:inquiry_type:LIKE(inquiry_type):TYPE(STRING):0,0\n'
    + 'FIELD:lex_id:LIKE(lex_id):TYPE(STRING):0,0\n'
    + 'FIELD:reprice_batch_number:LIKE(reprice_batch_number):TYPE(STRING):0,0\n'
    + 'FIELD:user_changed:LIKE(user_changed):TYPE(STRING):0,0\n'
    + 'FIELD:date_changed:LIKE(date_changed):TYPE(STRING):0,0\n'
    + 'FIELD:fcra_purpose:LIKE(fcra_purpose):TYPE(STRING):0,0\n'
    + 'FIELD:orig_address_2:LIKE(orig_address_2):TYPE(STRING):0,0\n'
    + 'FIELD:orig_city_2:LIKE(orig_city_2):TYPE(STRING):0,0\n'
    + 'FIELD:orig_state_2:LIKE(orig_state_2):TYPE(STRING):0,0\n'
    + 'FIELD:orig_zip_2:LIKE(orig_zip_2):TYPE(STRING):0,0\n'
    + 'FIELD:orig_zip4_2:LIKE(orig_zip4_2):TYPE(STRING):0,0\n'
    + 'FIELD:orig_jobid:LIKE(orig_jobid):TYPE(STRING):0,0\n'
    + 'FIELD:orig_acctno:LIKE(orig_acctno):TYPE(STRING):0,0\n'
    + 'FIELD:orig_end_user_name:LIKE(orig_end_user_name):TYPE(STRING):0,0\n'
    + 'FIELD:orig_end_user_address_1:LIKE(orig_end_user_address_1):TYPE(STRING):0,0\n'
    + 'FIELD:orig_end_user_address_2:LIKE(orig_end_user_address_2):TYPE(STRING):0,0\n'
    + 'FIELD:orig_end_user_city:LIKE(orig_end_user_city):TYPE(STRING):0,0\n'
    + 'FIELD:orig_end_user_state:LIKE(orig_end_user_state):TYPE(STRING):0,0\n'
    + 'FIELD:orig_end_user_zip:LIKE(orig_end_user_zip):TYPE(STRING):0,0\n'
    ;
 
  // Structured values
  EXPORT linkpaths := DATASET([
    ],{STRING linkpath;STRING compulsory;STRING optional;STRING bonus;STRING required;STRING search});
 
END;

