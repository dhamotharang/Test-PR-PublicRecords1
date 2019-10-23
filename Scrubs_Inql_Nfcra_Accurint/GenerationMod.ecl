// Machine-readable versions of the spec file and subsets thereof
IMPORT SALT39;
EXPORT GenerationMod := MODULE(SALT39.iGenerationMod)
 
  // SALT Version info
  EXPORT salt_VERSION := 'V3.9.0';
  EXPORT salt_MODULE := 'SALT39'; // Optional override by HACK:SALTMODULE
  EXPORT salt_TOOLSMODULE := 'SALTTOOLS30'; // Optional override by HACK:SALTTOOLSMODULE
 
  // Core module configuration values
  EXPORT spc_MODULE := 'Scrubs_Inql_Nfcra_Accurint';
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
  EXPORT spc_EXTERNAL_BATCH_PARAM := ',/* MY_ */,orig_end_user_id,orig_loginid,orig_billing_code,orig_transaction_id,orig_transaction_type,orig_neighbors,orig_relatives,orig_associates,orig_property,orig_company_id,orig_reference_code,orig_fname,orig_mname,orig_lname,orig_address,orig_city,orig_state,orig_zip,orig_zip4,orig_phone,orig_ssn,orig_free,orig_record_count,orig_price,orig_bankruptcy,orig_transaction_code,orig_dateadded,orig_full_name,orig_billingdate,orig_business_name,orig_pricing_error_code,orig_dl_purpose,orig_result_format,orig_dob,orig_unique_id,orig_dls,orig_mvs,orig_function_name,orig_response_time,orig_data_source,orig_glb_purpose,orig_report_options,orig_unused,orig_login_history_id,orig_aseid,orig_years,orig_ip_address,orig_source_code,orig_retail_price';
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
    + 'MODULE:Scrubs_Inql_Nfcra_Accurint\n'
    + 'FILENAME:FILE\n'
    + '\n'
    + 'FIELDTYPE:DEFAULT:LEFTTRIM:NOQUOTES("\')\n'
    + 'FIELDTYPE:ALPHA:ALLOW(ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz):\n'
    + 'FIELDTYPE:NAME:ALLOW(ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz-,\'.):\n'
    + 'FIELDTYPE:NUMBER:ALLOW(0123456789):\n'
    + 'FIELDTYPE:WORDBAG:ALLOW(ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789<>{}[]-^=!+&,./:|#_@$):SPACES( ):ONFAIL(CLEAN):\n'
    + '\n'
    + 'FIELDTYPE:orig_end_user_id:SPACES( ):LIKE(NUMBER):ONFAIL(CLEAN)\n'
    + 'FIELDTYPE:orig_loginid:LIKE(WORDBAG):WORDS(1):ONFAIL(CLEAN)\n'
    + 'FIELDTYPE:orig_billing_code:LIKE(WORDBAG):ONFAIL(CLEAN)\n'
    + 'FIELDTYPE:orig_transaction_id:SPACES( ):ALLOW(0123456789ABIRT):WORDS(1):ONFAIL(CLEAN)\n'
    + 'FIELDTYPE:orig_transaction_type:SPACES( ):ALLOW(IRSTY):LENGTHS(1):WORDS(1):ONFAIL(CLEAN)\n'
    + 'FIELDTYPE:orig_neighbors:SPACES( ):ALLOW(01):LENGTHS(1):WORDS(1):ONFAIL(CLEAN)\n'
    + 'FIELDTYPE:orig_relatives:SPACES( ):ALLOW(0123):LENGTHS(1,2):WORDS(1):ONFAIL(CLEAN)\n'
    + 'FIELDTYPE:orig_associates:SPACES( ):ALLOW(01):LENGTHS(1):WORDS(1):ONFAIL(CLEAN)\n'
    + 'FIELDTYPE:orig_property:SPACES( ):ALLOW(01):LENGTHS(1):WORDS(1):ONFAIL(CLEAN)\n'
    + 'FIELDTYPE:orig_company_id:SPACES( ):LIKE(NUMBER):LENGTHS(7):WORDS(1):ONFAIL(CLEAN)\n'
    + 'FIELDTYPE:orig_reference_code:LIKE(WORDBAG):ONFAIL(CLEAN)\n'
    + 'FIELDTYPE:orig_fname:SPACES( ):LIKE(NAME):WORDS(0..2):ONFAIL(CLEAN)\n'
    + 'FIELDTYPE:orig_mname:SPACES( ):LIKE(NAME):WORDS(0..2):ONFAIL(CLEAN)\n'
    + 'FIELDTYPE:orig_lname:SPACES( ):LIKE(NAME):WORDS(0..2):ONFAIL(CLEAN)\n'
    + 'FIELDTYPE:orig_address:LIKE(WORDBAG):ONFAIL(CLEAN)\n'
    + 'FIELDTYPE:orig_city:SPACES( ):LIKE(ALPHA):WORDS(0..3):ONFAIL(CLEAN)\n'
    + 'FIELDTYPE:orig_state:SPACES( ):LIKE(ALPHA):LENGTHS(0..2):WORDS(0,1):ONFAIL(CLEAN)\n'
    + 'FIELDTYPE:orig_zip:SPACES( ):LIKE(NUMBER):LENGTHS(0,5):WORDS(0,1):ONFAIL(CLEAN)\n'
    + 'FIELDTYPE:orig_zip4:SPACES( ):LIKE(NUMBER):LENGTHS(0,4):WORDS(0,1):ONFAIL(CLEAN)\n'
    + 'FIELDTYPE:orig_phone:SPACES( ):TYPE(NUMBERFIELD):LENGTHS(0,10,11,12):WORDS(0,1):ONFAIL(CLEAN)\n'
    + 'FIELDTYPE:orig_ssn:SPACES( ):LIKE(NUMBER):LENGTHS(0..9):WORDS(0,1):ONFAIL(CLEAN)\n'
    + 'FIELDTYPE:orig_free:SPACES( ):ALLOW(02346):LENGTHS(1):WORDS(1):ONFAIL(CLEAN)\n'
    + 'FIELDTYPE:orig_record_count:SPACES( ):LIKE(NUMBER):LENGTHS(1,2,3):WORDS(1):ONFAIL(CLEAN)\n'
    + 'FIELDTYPE:orig_price:SPACES( ):TYPE(NUMBERFIELD):WORDS(1):ONFAIL(CLEAN)\n'
    + 'FIELDTYPE:orig_bankruptcy:SPACES( ):ALLOW(01):LENGTHS(1):WORDS(1):ONFAIL(CLEAN)\n'
    + 'FIELDTYPE:orig_transaction_code:SPACES( ):LIKE(NUMBER):LENGTHS(3,5):WORDS(1):ONFAIL(CLEAN)\n'
    + 'FIELDTYPE:orig_dateadded:SPACES( ):ALLOW( 0123456789:AMPSep):LENGTHS(26):WORDS(4):ONFAIL(CLEAN)\n'
    + 'FIELDTYPE:orig_full_name:SPACES( ):LIKE(NAME):WORDS(0..3):ONFAIL(CLEAN)\n'
    + 'FIELDTYPE:orig_billingdate:SPACES( ):ALLOW():LENGTHS(0):WORDS(0):ONFAIL(CLEAN)\n'
    + 'FIELDTYPE:orig_business_name:LIKE(WORDBAG):ONFAIL(CLEAN)\n'
    + 'FIELDTYPE:orig_pricing_error_code:SPACES( ):ALLOW(-0123):LENGTHS(1,2):WORDS(1):ONFAIL(CLEAN)\n'
    + 'FIELDTYPE:orig_dl_purpose:SPACES( ):LIKE(NUMBER):LENGTHS(1):WORDS(1):ONFAIL(CLEAN)\n'
    + 'FIELDTYPE:orig_result_format:SPACES( ):ALLOW(0CNcn):LENGTHS(1,2):WORDS(1):ONFAIL(CLEAN)\n'
    + 'FIELDTYPE:orig_dob:SPACES( ):LIKE(NUMBER):LENGTHS(0..8):WORDS(0,1):ONFAIL(CLEAN)\n'
    + 'FIELDTYPE:orig_unique_id:LIKE(WORDBAG):WORDS(1,0):ONFAIL(CLEAN)\n'
    + 'FIELDTYPE:orig_dls:SPACES( ):ALLOW(01):LENGTHS(1):WORDS(1):ONFAIL(CLEAN)\n'
    + 'FIELDTYPE:orig_mvs:SPACES( ):ALLOW(012):LENGTHS(1):WORDS(1):ONFAIL(CLEAN)\n'
    + 'FIELDTYPE:orig_function_name:LIKE(WORDBAG):WORDS(1,0):ONFAIL(CLEAN)\n'
    + 'FIELDTYPE:orig_response_time:SPACES( ):TYPE(NUMBERFIELD):LENGTHS(4):WORDS(1):ONFAIL(CLEAN)\n'
    + 'FIELDTYPE:orig_data_source:SPACES( ):ALLOW(ABDLRSTVaceilmo):WORDS(0,1):ONFAIL(CLEAN)\n'
    + 'FIELDTYPE:orig_glb_purpose:SPACES( ):LIKE(NUMBER):WORDS(1):ONFAIL(CLEAN)\n'
    + 'FIELDTYPE:orig_report_options:SPACES( ):ALLOW( ,-.012349:acdeiu):WORDS(1,3):ONFAIL(CLEAN)\n'
    + 'FIELDTYPE:orig_unused:SPACES( ):ALLOW(1):LENGTHS(0,1):WORDS(0,1):ONFAIL(CLEAN)\n'
    + 'FIELDTYPE:orig_login_history_id:SPACES( ):LIKE(NUMBER):WORDS(1):ONFAIL(CLEAN)\n'
    + 'FIELDTYPE:orig_aseid:SPACES( ):ALLOW(36):LENGTHS(1):WORDS(1):ONFAIL(CLEAN)\n'
    + 'FIELDTYPE:orig_years:SPACES( ):ALLOW(0125):LENGTHS(0,2):WORDS(0,1):ONFAIL(CLEAN)\n'
    + 'FIELDTYPE:orig_ip_address:SPACES( ):TYPE(NUMBERFIELD):WORDS(1):ONFAIL(CLEAN)\n'
    + 'FIELDTYPE:orig_source_code:SPACES( ):ALLOW(01234):WORDS(1):ONFAIL(CLEAN)\n'
    + 'FIELDTYPE:orig_retail_price:SPACES( ):TYPE(NUMBERFIELD):WORDS(1):ONFAIL(CLEAN)\n'
    + '\n'
    + '// Uncomment up to NINES for internal or external adl\n'
    + '// IDFIELD:EXISTS:<NameOfIDField>\n'
    + '// RIDFIELD:<NameOfRidField>\n'
    + '// RECORDS:<NumberOfRecordsInDataFile>\n'
    + '// POPULATION:<ExpectedNumberOfEntitiesInDataFile>\n'
    + '// NINES:<Precision required 3 = 99.9%, 2 = 99% etc>\n'
    + '// Uncomment Process if doing external adl\n'
    + '// PROCESS:<ProcessName>\n'
    + '// FIELDTYPE statements can be used to clean up (or check the cleaning) of individual fields\n'
    + '// BESTTYPE statements declare methods of generating the best value for a given cluster; this can also improve linking\n'
    + '// FUZZY can be used to create new types of FUZZY linking\n'
    + '// Remember to generate specificities and update the 0,0 placeholders below before running any sort of linking.\n'
    + '// If the actual specificity for a field is <1, round it up to 1 rather than down to 0.  If your cluster is running\n'
    + '// a shared repository, calling SALTTOOLS30.mac_Patch_SPC from the bottom of BWR_Specificities may be a convenience.\n'
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
    + 'FIELD:orig_price:LIKE(orig_price):TYPE(NUMBERFIELD):0,0\n'
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
    + '\n'
    + '// CONCEPT statements should be used to group together interellated fields; such as address\n'
    + '// RELATIONSHIP is used to find non-obvious relationships between the clusters\n'
    + '// SOURCEFIELD is used if a field of the file denotes a source of the records in that file\n'
    + '// LINKPATH is used to define access paths for external linking\n'
    + '\n'
    ;
 
  // Structured values
  EXPORT linkpaths := DATASET([
    ],{STRING linkpath;STRING compulsory;STRING optional;STRING bonus;STRING required;STRING search});
 
END;

