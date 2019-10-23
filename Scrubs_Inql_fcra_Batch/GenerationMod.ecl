// Machine-readable versions of the spec file and subsets thereof
IMPORT SALT39;
EXPORT GenerationMod := MODULE(SALT39.iGenerationMod)
 
  // SALT Version info
  EXPORT salt_VERSION := 'V3.9.0';
  EXPORT salt_MODULE := 'SALT39'; // Optional override by HACK:SALTMODULE
  EXPORT salt_TOOLSMODULE := 'SALTTOOLS30'; // Optional override by HACK:SALTTOOLSMODULE
 
  // Core module configuration values
  EXPORT spc_MODULE := 'Scrubs_Inql_fcra_Batch';
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
  EXPORT spc_EXTERNAL_BATCH_PARAM := ',/* MY_ */,orig_datetime_stamp,orig_global_company_id,orig_company_id,orig_product_cd,orig_method,orig_vertical,orig_function_name,orig_transaction_type,orig_login_history_id,orig_job_id,orig_sequence_number,orig_first_name,orig_middle_name,orig_last_name,orig_ssn,orig_dob,orig_dl_num,orig_dl_state,orig_address1_addressline1,orig_address1_addressline2,orig_address1_prim_range,orig_address1_predir,orig_address1_prim_name,orig_address1_suffix,orig_address1_postdir,orig_address1_unit_desig,orig_address1_sec_range,orig_address1_city,orig_address1_st,orig_address1_z5,orig_address1_z4,orig_address2_addressline1,orig_address2_addressline2,orig_address2_prim_range,orig_address2_predir,orig_address2_prim_name,orig_address2_suffix,orig_address2_postdir,orig_address2_unit_desig,orig_address2_sec_range,orig_address2_city,orig_address2_st,orig_address2_z5,orig_address2_z4,orig_bdid,orig_bdl,orig_did,orig_company_name,orig_fein,orig_phone,orig_work_phone,orig_company_phone,orig_reference_code,orig_ip_address_initiated,orig_ip_address_executed,orig_charter_number,orig_ucc_original_filing_number,orig_email_address,orig_domain_name,orig_full_name,orig_dl_purpose,orig_glb_purpose,orig_fcra_purpose,orig_process_id';
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
    + 'MODULE:Scrubs_Inql_fcra_Batch\n'
    + 'FILENAME:FILE\n'
    + '\n'
    + 'FIELDTYPE:DEFAULT:LEFTTRIM:NOQUOTES("\')\n'
    + 'FIELDTYPE:ALPHA:ALLOW(ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz):\n'
    + 'FIELDTYPE:NAME:ALLOW(ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz-,\'.):\n'
    + 'FIELDTYPE:NUMBER:ALLOW(0123456789):\n'
    + 'FIELDTYPE:ALPHANUM:ALLOW(ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789_):\n'
    + 'FIELDTYPE:WORDBAG:ALLOW(ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789<>{}[]-^=!+&,./:|#_@$;):SPACES( ):ONFAIL(CLEAN):\n'
    + '\n'
    + 'FIELDTYPE:orig_datetime_stamp:SPACES( ):LIKE(NUMBER):LEFTTRIM:WORDS(1):ONFAIL(CLEAN)\n'
    + 'FIELDTYPE:orig_global_company_id:SPACES( ):LIKE(NUMBER):LEFTTRIM:WORDS(1):ONFAIL(CLEAN)\n'
    + 'FIELDTYPE:orig_company_id:SPACES( ):LIKE(NUMBER):LEFTTRIM:WORDS(1):ONFAIL(CLEAN)\n'
    + 'FIELDTYPE:orig_product_cd:SPACES( ):ALLOW(CDOPRTU_):LEFTTRIM:LENGTHS(0):WORDS(0):ONFAIL(CLEAN)\n'
    + 'FIELDTYPE:orig_method:SPACES( ):ALLOW(Bacht):LEFTTRIM:LENGTHS(5):WORDS(1):ONFAIL(CLEAN)\n'
    + 'FIELDTYPE:orig_vertical:SPACES( ):ALLOW(ACEILRTV):LEFTTRIM:LENGTHS(0):WORDS(0):ONFAIL(CLEAN)\n'
    + 'FIELDTYPE:orig_function_name:SPACES( ):LIKE(ALPHANUM):LEFTTRIM:WORDS(1):ONFAIL(CLEAN)\n'
    + 'FIELDTYPE:orig_transaction_type:SPACES( ):ALLOW(ACEINOPRSTY_):LEFTTRIM:LENGTHS(0):WORDS(0):ONFAIL(CLEAN)\n'
    + 'FIELDTYPE:orig_login_history_id:SPACES( ):ALLOW(DGHILNORSTY_):LEFTTRIM:LENGTHS(0):WORDS(0):ONFAIL(CLEAN)\n'
    + 'FIELDTYPE:orig_job_id:SPACES( ):LIKE(NUMBER):LEFTTRIM:WORDS(1):ONFAIL(CLEAN)\n'
    + 'FIELDTYPE:orig_sequence_number:SPACES( ):LIKE(NUMBER):LEFTTRIM:WORDS(1):ONFAIL(CLEAN)\n'
    + 'FIELDTYPE:orig_first_name:SPACES( ):LIKE(NAME):WORDS(1,2,0):ONFAIL(CLEAN)\n'
    + 'FIELDTYPE:orig_middle_name:SPACES( ):LIKE(NAME):WORDS(0,1,2):ONFAIL(CLEAN)\n'
    + 'FIELDTYPE:orig_last_name:SPACES( ):LIKE(NAME):WORDS(1,0,2,3):ONFAIL(CLEAN)\n'
    + 'FIELDTYPE:orig_ssn:SPACES( ):LIKE(NUMBER):LEFTTRIM:LENGTHS(9,0):WORDS(1,0):ONFAIL(CLEAN)\n'
    + 'FIELDTYPE:orig_dob:SPACES( ):ALLOW(0123456789BO):LEFTTRIM:LENGTHS(0,8):WORDS(0,1):ONFAIL(CLEAN)\n'
    + 'FIELDTYPE:orig_dl_num:SPACES( ):ALLOW(DLMNU_):LEFTTRIM:LENGTHS(0):WORDS(0):ONFAIL(CLEAN)\n'
    + 'FIELDTYPE:orig_dl_state:SPACES( ):ALLOW(ADELST_):LEFTTRIM:LENGTHS(0):WORDS(0):ONFAIL(CLEAN)\n'
    + 'FIELDTYPE:orig_address1_addressline1:SPACES( ):LIKE(WORDBAG):ONFAIL(CLEAN)\n'
    + 'FIELDTYPE:orig_address1_addressline2:SPACES( ):LIKE(WORDBAG):LEFTTRIM:ONFAIL(CLEAN)\n'
    + 'FIELDTYPE:orig_address1_prim_range:SPACES( ):LIKE(ALPHANUM):WORDS(1,0):ONFAIL(CLEAN)\n'
    + 'FIELDTYPE:orig_address1_predir:SPACES( ):ALLOW(1DEINRSW_):LEFTTRIM:LENGTHS(0,1,2):WORDS(0,1):ONFAIL(CLEAN)\n'
    + 'FIELDTYPE:orig_address1_prim_name:SPACES( ):LIKE(ALPHANUM):ONFAIL(CLEAN)\n'
    + 'FIELDTYPE:orig_address1_suffix:SPACES( ):LIKE(ALPHA):WORDS(1,0):ONFAIL(CLEAN)\n'
    + 'FIELDTYPE:orig_address1_postdir:SPACES( ):LIKE(ALPHANUM):LEFTTRIM:WORDS(0,1):ONFAIL(CLEAN)\n'
    + 'FIELDTYPE:orig_address1_unit_desig:SPACES( ):LIKE(ALPHANUM):LEFTTRIM:WORDS(0,1):ONFAIL(CLEAN)\n'
    + 'FIELDTYPE:orig_address1_sec_range:SPACES( ):LIKE(ALPHANUM):LEFTTRIM:WORDS(0,1):ONFAIL(CLEAN)\n'
    + 'FIELDTYPE:orig_address1_city:SPACES( ):LIKE(ALPHA):LEFTTRIM:WORDS(1,2,0,3):ONFAIL(CLEAN)\n'
    + 'FIELDTYPE:orig_address1_st:SPACES( ):LIKE(ALPHA):LEFTTRIM:LENGTHS(2,0):WORDS(1,0):ONFAIL(CLEAN)\n'
    + 'FIELDTYPE:orig_address1_z5:SPACES( ):LIKE(NUMBER):LEFTTRIM:LENGTHS(5,0):WORDS(1,0):ONFAIL(CLEAN)\n'
    + 'FIELDTYPE:orig_address1_z4:SPACES( ):LIKE(NUMBER):LEFTTRIM:LENGTHS(4,0):WORDS(1,0):ONFAIL(CLEAN)\n'
    + 'FIELDTYPE:orig_address2_addressline1:SPACES( ):ALLOW(12ADEILNRS_):LEFTTRIM:LENGTHS(0):WORDS(0):ONFAIL(CLEAN)\n'
    + 'FIELDTYPE:orig_address2_addressline2:SPACES( ):ALLOW(2ADEILNRS_):LEFTTRIM:LENGTHS(0):WORDS(0):ONFAIL(CLEAN)\n'
    + 'FIELDTYPE:orig_address2_prim_range:SPACES( ):ALLOW(2ADEGIMNPRS_):LEFTTRIM:LENGTHS(0):WORDS(0):ONFAIL(CLEAN)\n'
    + 'FIELDTYPE:orig_address2_predir:SPACES( ):ALLOW(2ADEIPRS_):LEFTTRIM:LENGTHS(0):WORDS(0):ONFAIL(CLEAN)\n'
    + 'FIELDTYPE:orig_address2_prim_name:SPACES( ):ALLOW(2ADEIMNPRS_):LEFTTRIM:LENGTHS(0):WORDS(0):ONFAIL(CLEAN)\n'
    + 'FIELDTYPE:orig_address2_suffix:SPACES( ):ALLOW(2ADEFIRSUX_):LEFTTRIM:LENGTHS(0):WORDS(0):ONFAIL(CLEAN)\n'
    + 'FIELDTYPE:orig_address2_postdir:SPACES( ):ALLOW(2ADEIOPRST_):LEFTTRIM:LENGTHS(0):WORDS(0):ONFAIL(CLEAN)\n'
    + 'FIELDTYPE:orig_address2_unit_desig:SPACES( ):ALLOW(2ADEGINRSTU_):LEFTTRIM:LENGTHS(0):WORDS(0):ONFAIL(CLEAN)\n'
    + 'FIELDTYPE:orig_address2_sec_range:SPACES( ):ALLOW(2ACDEGNRS_):LEFTTRIM:LENGTHS(0):WORDS(0):ONFAIL(CLEAN)\n'
    + 'FIELDTYPE:orig_address2_city:SPACES( ):ALLOW(2ACDEIRSTY_):LEFTTRIM:LENGTHS(0):WORDS(0):ONFAIL(CLEAN)\n'
    + 'FIELDTYPE:orig_address2_st:SPACES( ):ALLOW(2ADERST_):LEFTTRIM:LENGTHS(0):WORDS(0):ONFAIL(CLEAN)\n'
    + 'FIELDTYPE:orig_address2_z5:SPACES( ):ALLOW(25ADERSZ_):LEFTTRIM:LENGTHS(0):WORDS(0):ONFAIL(CLEAN)\n'
    + 'FIELDTYPE:orig_address2_z4:SPACES( ):ALLOW(24ADERSZ_):LEFTTRIM:LENGTHS(0):WORDS(0):ONFAIL(CLEAN)\n'
    + 'FIELDTYPE:orig_bdid:SPACES( ):ALLOW(04):LEFTTRIM:LENGTHS(3,0):WORDS(1,0):ONFAIL(CLEAN)\n'
    + 'FIELDTYPE:orig_bdl:SPACES( ):ALLOW(BDL):LEFTTRIM:LENGTHS(0):WORDS(0):ONFAIL(CLEAN)\n'
    + 'FIELDTYPE:orig_did:SPACES( ):LIKE(NUMBER):LEFTTRIM:LENGTHS(12,0):WORDS(1,0):ONFAIL(CLEAN)\n'
    + 'FIELDTYPE:orig_company_name:SPACES( ):LIKE(NAME):LEFTTRIM:LENGTHS(0):WORDS(0):ONFAIL(CLEAN)\n'
    + 'FIELDTYPE:orig_fein:SPACES( ):LIKE(NUMBER):LEFTTRIM:LENGTHS(9,0):WORDS(1,0):ONFAIL(CLEAN)\n'
    + 'FIELDTYPE:orig_phone:SPACES( ):ALLOW(0123456789HNOP):LEFTTRIM:LENGTHS(0,10):WORDS(0,1):ONFAIL(CLEAN)\n'
    + 'FIELDTYPE:orig_work_phone:SPACES( ):ALLOW(EHKNOPRW_):LEFTTRIM:LENGTHS(0):WORDS(0):ONFAIL(CLEAN)\n'
    + 'FIELDTYPE:orig_company_phone:SPACES( ):ALLOW(ACEHMNOPY_):LEFTTRIM:LENGTHS(0):WORDS(0):ONFAIL(CLEAN)\n'
    + 'FIELDTYPE:orig_reference_code:SPACES( ):ALLOW(CDEFNOR_):LEFTTRIM:LENGTHS(0):WORDS(0):ONFAIL(CLEAN)\n'
    + 'FIELDTYPE:orig_ip_address_initiated:SPACES( ):ALLOW(ADEINPRST_):LEFTTRIM:LENGTHS(0):WORDS(0):ONFAIL(CLEAN)\n'
    + 'FIELDTYPE:orig_ip_address_executed:SPACES( ):TYPE(NUMBERFIELD):LEFTTRIM:WORDS(1):ONFAIL(CLEAN)\n'
    + 'FIELDTYPE:orig_charter_number:SPACES( ):ALLOW(ABCEHMNRTU_):LEFTTRIM:LENGTHS(0):WORDS(0):ONFAIL(CLEAN)\n'
    + 'FIELDTYPE:orig_ucc_original_filing_number:SPACES( ):LIKE(NAME):LEFTTRIM:LENGTHS(0):WORDS(0):ONFAIL(CLEAN)\n'
    + 'FIELDTYPE:orig_email_address:SPACES( ):ALLOW(ADEILMRS_):LEFTTRIM:LENGTHS(0):WORDS(0):ONFAIL(CLEAN)\n'
    + 'FIELDTYPE:orig_domain_name:SPACES( ):ALLOW(ADEIMNO_):LEFTTRIM:LENGTHS(0):WORDS(0):ONFAIL(CLEAN)\n'
    + 'FIELDTYPE:orig_full_name:SPACES( ):ALLOW(AEFLMNU_):LEFTTRIM:LENGTHS(0):WORDS(0):ONFAIL(CLEAN)\n'
    + 'FIELDTYPE:orig_dl_purpose:SPACES( ):LIKE(NUMBER):LEFTTRIM:LENGTHS(1):WORDS(1):ONFAIL(CLEAN)\n'
    + 'FIELDTYPE:orig_glb_purpose:SPACES( ):LIKE(NUMBER):LEFTTRIM:LENGTHS(1,2):WORDS(1):ONFAIL(CLEAN)\n'
    + 'FIELDTYPE:orig_fcra_purpose:SPACES( ):ALLOW(012R):LEFTTRIM:LENGTHS(1):WORDS(1):ONFAIL(CLEAN)\n'
    + 'FIELDTYPE:orig_process_id:SPACES( ):LIKE(NUMBER):LEFTTRIM:WORDS(1):ONFAIL(CLEAN)\n'
    + '\n'
    + 'FIELD:orig_datetime_stamp:LIKE(orig_datetime_stamp):TYPE(STRING):0,0\n'
    + 'FIELD:orig_global_company_id:LIKE(orig_global_company_id):TYPE(STRING):0,0\n'
    + 'FIELD:orig_company_id:LIKE(orig_company_id):TYPE(STRING):0,0\n'
    + 'FIELD:orig_product_cd:LIKE(orig_product_cd):TYPE(STRING):0,0\n'
    + 'FIELD:orig_method:LIKE(orig_method):TYPE(STRING):0,0\n'
    + 'FIELD:orig_vertical:LIKE(orig_vertical):TYPE(STRING):0,0\n'
    + 'FIELD:orig_function_name:LIKE(orig_function_name):TYPE(STRING):0,0\n'
    + 'FIELD:orig_transaction_type:LIKE(orig_transaction_type):TYPE(STRING):0,0\n'
    + 'FIELD:orig_login_history_id:LIKE(orig_login_history_id):TYPE(STRING):0,0\n'
    + 'FIELD:orig_job_id:LIKE(orig_job_id):TYPE(STRING20):0,0\n'
    + 'FIELD:orig_sequence_number:LIKE(orig_sequence_number):TYPE(STRING):0,0\n'
    + 'FIELD:orig_first_name:LIKE(orig_first_name):TYPE(STRING):0,0\n'
    + 'FIELD:orig_middle_name:LIKE(orig_middle_name):TYPE(STRING):0,0\n'
    + 'FIELD:orig_last_name:LIKE(orig_last_name):TYPE(STRING):0,0\n'
    + 'FIELD:orig_ssn:LIKE(orig_ssn):TYPE(STRING):0,0\n'
    + 'FIELD:orig_dob:LIKE(orig_dob):TYPE(STRING):0,0\n'
    + 'FIELD:orig_dl_num:LIKE(orig_dl_num):TYPE(STRING):0,0\n'
    + 'FIELD:orig_dl_state:LIKE(orig_dl_state):TYPE(STRING):0,0\n'
    + 'FIELD:orig_address1_addressline1:LIKE(orig_address1_addressline1):TYPE(STRING):0,0\n'
    + 'FIELD:orig_address1_addressline2:LIKE(orig_address1_addressline2):TYPE(STRING):0,0\n'
    + 'FIELD:orig_address1_prim_range:LIKE(orig_address1_prim_range):TYPE(STRING):0,0\n'
    + 'FIELD:orig_address1_predir:LIKE(orig_address1_predir):TYPE(STRING):0,0\n'
    + 'FIELD:orig_address1_prim_name:LIKE(orig_address1_prim_name):TYPE(STRING):0,0\n'
    + 'FIELD:orig_address1_suffix:LIKE(orig_address1_suffix):TYPE(STRING):0,0\n'
    + 'FIELD:orig_address1_postdir:LIKE(orig_address1_postdir):TYPE(STRING):0,0\n'
    + 'FIELD:orig_address1_unit_desig:LIKE(orig_address1_unit_desig):TYPE(STRING):0,0\n'
    + 'FIELD:orig_address1_sec_range:LIKE(orig_address1_sec_range):TYPE(STRING):0,0\n'
    + 'FIELD:orig_address1_city:LIKE(orig_address1_city):TYPE(STRING):0,0\n'
    + 'FIELD:orig_address1_st:LIKE(orig_address1_st):TYPE(STRING):0,0\n'
    + 'FIELD:orig_address1_z5:LIKE(orig_address1_z5):TYPE(STRING):0,0\n'
    + 'FIELD:orig_address1_z4:LIKE(orig_address1_z4):TYPE(STRING):0,0\n'
    + 'FIELD:orig_address2_addressline1:LIKE(orig_address2_addressline1):TYPE(STRING):0,0\n'
    + 'FIELD:orig_address2_addressline2:LIKE(orig_address2_addressline2):TYPE(STRING):0,0\n'
    + 'FIELD:orig_address2_prim_range:LIKE(orig_address2_prim_range):TYPE(STRING):0,0\n'
    + 'FIELD:orig_address2_predir:LIKE(orig_address2_predir):TYPE(STRING):0,0\n'
    + 'FIELD:orig_address2_prim_name:LIKE(orig_address2_prim_name):TYPE(STRING):0,0\n'
    + 'FIELD:orig_address2_suffix:LIKE(orig_address2_suffix):TYPE(STRING):0,0\n'
    + 'FIELD:orig_address2_postdir:LIKE(orig_address2_postdir):TYPE(STRING):0,0\n'
    + 'FIELD:orig_address2_unit_desig:LIKE(orig_address2_unit_desig):TYPE(STRING):0,0\n'
    + 'FIELD:orig_address2_sec_range:LIKE(orig_address2_sec_range):TYPE(STRING):0,0\n'
    + 'FIELD:orig_address2_city:LIKE(orig_address2_city):TYPE(STRING):0,0\n'
    + 'FIELD:orig_address2_st:LIKE(orig_address2_st):TYPE(STRING):0,0\n'
    + 'FIELD:orig_address2_z5:LIKE(orig_address2_z5):TYPE(STRING):0,0\n'
    + 'FIELD:orig_address2_z4:LIKE(orig_address2_z4):TYPE(STRING):0,0\n'
    + 'FIELD:orig_bdid:LIKE(orig_bdid):TYPE(STRING):0,0\n'
    + 'FIELD:orig_bdl:LIKE(orig_bdl):TYPE(STRING):0,0\n'
    + 'FIELD:orig_did:LIKE(orig_did):TYPE(STRING):0,0\n'
    + 'FIELD:orig_company_name:LIKE(orig_company_name):TYPE(STRING):0,0\n'
    + 'FIELD:orig_fein:LIKE(orig_fein):TYPE(STRING):0,0\n'
    + 'FIELD:orig_phone:LIKE(orig_phone):TYPE(STRING):0,0\n'
    + 'FIELD:orig_work_phone:LIKE(orig_work_phone):TYPE(STRING):0,0\n'
    + 'FIELD:orig_company_phone:LIKE(orig_company_phone):TYPE(STRING):0,0\n'
    + 'FIELD:orig_reference_code:LIKE(orig_reference_code):TYPE(STRING):0,0\n'
    + 'FIELD:orig_ip_address_initiated:LIKE(orig_ip_address_initiated):TYPE(STRING):0,0\n'
    + 'FIELD:orig_ip_address_executed:LIKE(orig_ip_address_executed):TYPE(STRING):0,0\n'
    + 'FIELD:orig_charter_number:LIKE(orig_charter_number):TYPE(STRING):0,0\n'
    + 'FIELD:orig_ucc_original_filing_number:LIKE(orig_ucc_original_filing_number):TYPE(STRING):0,0\n'
    + 'FIELD:orig_email_address:LIKE(orig_email_address):TYPE(STRING):0,0\n'
    + 'FIELD:orig_domain_name:LIKE(orig_domain_name):TYPE(STRING):0,0\n'
    + 'FIELD:orig_full_name:LIKE(orig_full_name):TYPE(STRING):0,0\n'
    + 'FIELD:orig_dl_purpose:LIKE(orig_dl_purpose):TYPE(STRING):0,0\n'
    + 'FIELD:orig_glb_purpose:LIKE(orig_glb_purpose):TYPE(STRING):0,0\n'
    + 'FIELD:orig_fcra_purpose:LIKE(orig_fcra_purpose):TYPE(STRING):0,0\n'
    + 'FIELD:orig_process_id:LIKE(orig_process_id):TYPE(STRING):0,0\n'
    ;
 
  // Structured values
  EXPORT linkpaths := DATASET([
    ],{STRING linkpath;STRING compulsory;STRING optional;STRING bonus;STRING required;STRING search});
 
END;

