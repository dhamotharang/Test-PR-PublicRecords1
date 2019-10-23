// Machine-readable versions of the spec file and subsets thereof
IMPORT SALT39;
EXPORT GenerationMod := MODULE(SALT39.iGenerationMod)
 
  // SALT Version info
  EXPORT salt_VERSION := 'V3.9.0';
  EXPORT salt_MODULE := 'SALT39'; // Optional override by HACK:SALTMODULE
  EXPORT salt_TOOLSMODULE := 'SALTTOOLS30'; // Optional override by HACK:SALTTOOLSMODULE
 
  // Core module configuration values
  EXPORT spc_MODULE := 'Scrubs_Inql_Nfcra_Banko';
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
  EXPORT spc_FILENAME := 'File';
  EXPORT spc_INGESTSTATUS := '';
  EXPORT spc_EXTERNAL_MAPPING := 'UniqueID:';
  EXPORT spc_EXTERNAL_BATCH_PARAM := ',/* MY_ */,orig_transaction_id,orig_function_name,orig_company_id,orig_login_id,orig_billing_code,orig_record_count,orig_fcra_purpose,orig_glb_purpose,orig_dppa_purpose,orig_ip_address,orig_reference_code,orig_login_history_id,orig_date_added,orig_price,orig_pricing_error_code,orig_free,orig_business_name,orig_name_first,orig_name_last,orig_ssn,orig_case_number,orig_address,orig_city,orig_state,orig_zip,orig_dob,orig_phone,orig_tmsid,orig_unique_id,orig_out_tmsid,orig_out_business_name,orig_out_first_name,orig_out_last_name,orig_out_ssn,orig_out_address,orig_out_city,orig_out_state,orig_out_zip,orig_out_case_number,orig_transaction_type';
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
    + 'MODULE:Scrubs_Inql_Nfcra_Banko\n'
    + 'FILENAME:File\n'
    + '\n'
    + 'FIELDTYPE:DEFAULT:LEFTTRIM:NOQUOTES("\')\n'
    + 'FIELDTYPE:ALPHA:ALLOW(ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz):\n'
    + 'FIELDTYPE:NAME:ALLOW(ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz-,\'.):\n'
    + 'FIELDTYPE:NUMBER:ALLOW(0123456789):\n'
    + 'FIELDTYPE:WORDBAG:ALLOW(ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789<>{}[]-^=!+&,./:|#_@$):SPACES( ):ONFAIL(CLEAN):\n'
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
    + 'FIELD:orig_transaction_id:TYPE(STRING):0,0\n'
    + 'FIELD:orig_function_name:TYPE(STRING):0,0\n'
    + 'FIELD:orig_company_id:TYPE(STRING):0,0\n'
    + 'FIELD:orig_login_id:TYPE(STRING):0,0\n'
    + 'FIELD:orig_billing_code:TYPE(STRING):0,0\n'
    + 'FIELD:orig_record_count:TYPE(STRING):0,0\n'
    + 'FIELD:orig_fcra_purpose:TYPE(STRING):0,0\n'
    + 'FIELD:orig_glb_purpose:TYPE(STRING):0,0\n'
    + 'FIELD:orig_dppa_purpose:TYPE(STRING):0,0\n'
    + 'FIELD:orig_ip_address:TYPE(STRING):0,0\n'
    + 'FIELD:orig_reference_code:TYPE(STRING):0,0\n'
    + 'FIELD:orig_login_history_id:TYPE(STRING):0,0\n'
    + 'FIELD:orig_date_added:TYPE(STRING):0,0\n'
    + 'FIELD:orig_price:TYPE(STRING):0,0\n'
    + 'FIELD:orig_pricing_error_code:TYPE(STRING):0,0\n'
    + 'FIELD:orig_free:TYPE(STRING):0,0\n'
    + 'FIELD:orig_business_name:TYPE(STRING):0,0\n'
    + 'FIELD:orig_name_first:TYPE(STRING):0,0\n'
    + 'FIELD:orig_name_last:TYPE(STRING):0,0\n'
    + 'FIELD:orig_ssn:TYPE(STRING):0,0\n'
    + 'FIELD:orig_case_number:TYPE(STRING):0,0\n'
    + 'FIELD:orig_address:TYPE(STRING):0,0\n'
    + 'FIELD:orig_city:TYPE(STRING):0,0\n'
    + 'FIELD:orig_state:TYPE(STRING):0,0\n'
    + 'FIELD:orig_zip:TYPE(STRING):0,0\n'
    + 'FIELD:orig_dob:TYPE(STRING):0,0\n'
    + 'FIELD:orig_phone:TYPE(STRING):0,0\n'
    + 'FIELD:orig_tmsid:TYPE(STRING):0,0\n'
    + 'FIELD:orig_unique_id:TYPE(STRING):0,0\n'
    + 'FIELD:orig_out_tmsid:TYPE(STRING):0,0\n'
    + 'FIELD:orig_out_business_name:TYPE(STRING):0,0\n'
    + 'FIELD:orig_out_first_name:TYPE(STRING):0,0\n'
    + 'FIELD:orig_out_last_name:TYPE(STRING):0,0\n'
    + 'FIELD:orig_out_ssn:TYPE(STRING):0,0\n'
    + 'FIELD:orig_out_address:TYPE(STRING):0,0\n'
    + 'FIELD:orig_out_city:TYPE(STRING):0,0\n'
    + 'FIELD:orig_out_state:TYPE(STRING):0,0\n'
    + 'FIELD:orig_out_zip:TYPE(STRING):0,0\n'
    + 'FIELD:orig_out_case_number:TYPE(STRING):0,0\n'
    + 'FIELD:orig_transaction_type:TYPE(STRING):0,0\n'
    + '// CONCEPT statements should be used to group together interellated fields; such as address\n'
    + '// RELATIONSHIP is used to find non-obvious relationships between the clusters\n'
    + '// SOURCEFIELD is used if a field of the file denotes a source of the records in that file\n'
    + '// LINKPATH is used to define access paths for external linking\n'
    ;
 
  // Structured values
  EXPORT linkpaths := DATASET([
    ],{STRING linkpath;STRING compulsory;STRING optional;STRING bonus;STRING required;STRING search});
 
END;

