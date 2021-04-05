// Machine-readable versions of the spec file and subsets thereof
IMPORT SALT311;
EXPORT GenerationMod := MODULE(SALT311.iGenerationMod)
 
  // SALT Version info
  EXPORT salt_VERSION := 'V3.11.7';
  EXPORT salt_MODULE := 'SALT311'; // Optional override by HACK:SALTMODULE
  EXPORT salt_TOOLSMODULE := 'SALTTOOLS30'; // Optional override by HACK:SALTTOOLSMODULE
 
  // Core module configuration values
  EXPORT spc_MODULE := 'Scrubs_DL_MI';
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
  EXPORT spc_FILENAME := 'In_MI';
  EXPORT spc_INGESTSTATUS := '';
  EXPORT spc_EXTERNAL_MAPPING := 'UniqueID:';
  EXPORT spc_EXTERNAL_BATCH_PARAM := ',/* MY_ */,process_date,code,customer_dln_pid,last_name,first_name,middle_name,name_suffix,street_address,city,state,zipcode,date_of_birth,gender,county,dln_pid_indicator,mailing_street_address,mailing_city,mailing_state,mailing_zipcode,blob,clean_name_prefix,clean_fname,clean_mname,clean_lname,clean_name_suffix,clean_name_score';
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
    + 'MODULE:Scrubs_DL_MI\n'
    + 'FILENAME:In_MI\n'
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
    + '\n'
    + 'FIELDTYPE:invalid_past_date:LENGTHS(8):CUSTOM(Scrubs.fn_valid_pastDate>0)\n'
    + 'FIELDTYPE:invalid_code:ENUM(A|C|)\n'
    + 'FIELDTYPE:invalid_numeric:ALLOW(0123456789)\n'
    + 'FIELDTYPE:invalid_dl_number_check:CUSTOM(Scrubs_DL_MI.Functions.fn_check_dl_number>0)\n'
    + 'FIELDTYPE:invalid_gender:ENUM(F|M|U|)\n'
    + 'FIELDTYPE:invalid_dln_pid_indi:ENUM(D|P|)\n'
    + 'FIELDTYPE:invalid_name:CUSTOM(scrubs.functions.fn_populated_strings>0,middle_name,last_name)\n'
    + 'FIELDTYPE:invalid_city:ALLOW(ABCDEFGHIJKLMNOPQRSTUVWXYZ )\n'
    + 'FIELDTYPE:invalid_street:ALLOW(/#-,.0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZ )\n'
    + 'FIELDTYPE:invalid_state:CUSTOM(Scrubs_DL_MI.Functions.fn_verify_state>0)\n'
    + 'FIELDTYPE:invalid_zip:CUSTOM(Scrubs.Functions.fn_verify_zip59>0)\n'
    + 'FIELDTYPE:invalid_clean_name:CUSTOM(scrubs.functions.fn_populated_strings>0,clean_mname,clean_lname)\n'
    + '\n'
    + 'FIELD:process_date:TYPE(STRING8):LIKE(invalid_past_date):0,0\n'
    + 'FIELD:code:TYPE(STRING1):LIKE(invalid_code):0,0\n'
    + 'FIELD:customer_dln_pid:TYPE(STRING13):LIKE(invalid_dl_number_check):0,0\n'
    + 'FIELD:last_name:TYPE(STRING50):0,0\n'
    + 'FIELD:first_name:TYPE(STRING50):LIKE(invalid_name):0,0\n'
    + 'FIELD:middle_name:TYPE(STRING50):0,0\n'
    + 'FIELD:name_suffix:TYPE(STRING6):0,0\n'
    + 'FIELD:street_address:TYPE(STRING36):LIKE(invalid_street):0,0\n'
    + 'FIELD:city:TYPE(STRING19):LIKE(invalid_city):0,0\n'
    + 'FIELD:state:TYPE(STRING2):LIKE(invalid_state):0,0\n'
    + 'FIELD:zipcode:TYPE(STRING5):LIKE(invalid_zip):0,0\n'
    + 'FIELD:date_of_birth:TYPE(STRING8):LIKE(invalid_past_date):0,0\n'
    + 'FIELD:gender:TYPE(STRING1):LIKE(invalid_gender):0,0\n'
    + 'FIELD:county:TYPE(STRING2):LIKE(invalid_numeric):0,0\n'
    + 'FIELD:dln_pid_indicator:TYPE(STRING1):LIKE(invalid_dln_pid_indi):0,0\n'
    + 'FIELD:mailing_street_address:TYPE(STRING36):LIKE(invalid_street):0,0\n'
    + 'FIELD:mailing_city:TYPE(STRING19):LIKE(invalid_city):0,0\n'
    + 'FIELD:mailing_state:TYPE(STRING2):LIKE(invalid_state):0,0\n'
    + 'FIELD:mailing_zipcode:TYPE(STRING5):LIKE(invalid_zip):0,0\n'
    + 'FIELD:blob:TYPE(STRING5):0,0\n'
    + 'FIELD:clean_name_prefix:TYPE(STRING5):0,0\n'
    + 'FIELD:clean_fname:TYPE(STRING20):LIKE(invalid_clean_name):0,0\n'
    + 'FIELD:clean_mname:TYPE(STRING20):0,0\n'
    + 'FIELD:clean_lname:TYPE(STRING20):0,0\n'
    + 'FIELD:clean_name_suffix:TYPE(STRING5):0,0\n'
    + 'FIELD:clean_name_score:TYPE(STRING3):0,0\n'
    + '// CONCEPT statements should be used to group together interellated fields; such as address\n'
    + '// RELATIONSHIP is used to find non-obvious relationships between the clusters\n'
    + '// SOURCEFIELD is used if a field of the file denotes a source of the records in that file\n'
    + '// LINKPATH is used to define access paths for external linking'
    ;
 
  // Structured values
  EXPORT linkpaths := DATASET([
    ],{STRING linkpath;STRING compulsory;STRING optional;STRING bonus;STRING required;STRING search});
 
END;

