// Machine-readable versions of the spec file and subsets thereof
IMPORT SALT39;
EXPORT GenerationMod := MODULE(SALT39.iGenerationMod)
 
  // SALT Version info
  EXPORT salt_VERSION := 'V3.9.0';
  EXPORT salt_MODULE := 'SALT39'; // Optional override by HACK:SALTMODULE
  EXPORT salt_TOOLSMODULE := 'SALTTOOLS30'; // Optional override by HACK:SALTTOOLSMODULE
 
  // Core module configuration values
  EXPORT spc_MODULE := 'Scrubs_DL_MA';
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
  EXPORT spc_FILENAME := 'In_MA';
  EXPORT spc_INGESTSTATUS := '';
  EXPORT spc_EXTERNAL_MAPPING := 'UniqueID:';
  EXPORT spc_EXTERNAL_BATCH_PARAM := ',/* MY_ */,pers_surrogate,filler1,license_licno,filler2,license_bdate_yyyymmdd,license_edate_yyyymmdd,license_lic_class,license_height,license_sex,license_last_name,license_first_name,license_middle_name,licmail_street1,licmail_street2,licmail_city,licmail_state,licmail_zip,licresi_street1,licresi_street2,licresi_city,licresi_state,licresi_zip,issue_date_yyyymmdd,license_status,clean_status,process_date';
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
    + 'MODULE:Scrubs_DL_MA\n'
    + 'FILENAME:In_MA\n'
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
    + '//FIELDTYPE DEFINITIONS\n'
    + 'FIELDTYPE:invalid_mandatory:LENGTHS(1..)\n'
    + 'FIELDTYPE:invalid_alpha:ALLOW(ABCDEFGHIJKLMNOPQRSTUVWXYZ)\n'
    + 'FIELDTYPE:invalid_alpha_specials:ALLOW(ABCDEFGHIJKLMNOPQRSTUVWXYZ @-.,#)\n'
    + 'FIELDTYPE:invalid_numeric:ALLOW(0123456789)\n'
    + 'FIELDTYPE:invalid_alpha_num:ALLOW(0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZ)\n'
    + 'FIELDTYPE:invalid_empty:LENGTHS(0)\n'
    + 'FIELDTYPE:invalid_wordbag:CAPS:ALLOW(ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789):SPACES( <>{}[]()-^=!+&,./#*\'\\|")\n'
    + 'FIELDTYPE:invalid_8date:LENGTHS(0,8):CUSTOM(Scrubs.fn_valid_GeneralDate>0)\n'
    + 'FIELDTYPE:invalid_8pastdate:LENGTHS(8):CUSTOM(Scrubs.fn_valid_pastDate>0)\n'
    + 'FIELDTYPE:invalid_08pastdate:LENGTHS(0,8):CUSTOM(Scrubs.fn_valid_pastDate>0)\n'
    + '\n'
    + 'FIELDTYPE:invalid_pers_surrogate:LENGTHS(9,10):LIKE(invalid_numeric)\n'
    + 'FIELDTYPE:invalid_license_licno:LENGTHS(9):CUSTOM(Scrubs_DL_MA.Functions.fn_verify_licno>0)\n'
    + 'FIELDTYPE:invalid_license_lic_class:LENGTHS(1,2):CUSTOM(Scrubs_DL_MA.Functions.fn_verify_lic_class>0)\n'
    + 'FIELDTYPE:invalid_license_height:CUSTOM(Scrubs_DL_MA.Functions.fn_verify_height>0)\n'
    + 'FIELDTYPE:invalid_license_sex:ENUM(F|M|U)\n'
    + 'FIELDTYPE:invalid_license_name:LIKE(invalid_wordbag):CUSTOM(Scrubs_DL_MA.Functions.fn_valid_name>0,license_first_name,license_middle_name)\n'
    + 'FIELDTYPE:invalid_licmail_state:LENGTHS(2):CUSTOM(Scrubs_DL_MA.Functions.fn_verify_state>0)\n'
    + 'FIELDTYPE:invalid_mailzip:LENGTHS(9):CUSTOM(Scrubs_DL_MA.Functions.fn_verify_zip>0,licmail_state)\n'
    + 'FIELDTYPE:invalid_licresi_state:LENGTHS(0,2):CUSTOM(Scrubs_DL_MA.Functions.fn_verify_state>0)\n'
    + 'FIELDTYPE:invalid_resizip:LENGTHS(0,9):CUSTOM(Scrubs_DL_MA.Functions.fn_verify_zip>0,licresi_state)\n'
    + 'FIELDTYPE:invalid_license_status:ALLOW(/ACENPRSTUVX):LENGTHS(3,7)\n'
    + '\n'
    + '\n'
    + '//FIELD DEFINITIONS\n'
    + 'FIELD:pers_surrogate:TYPE(STRING10):LIKE(invalid_pers_surrogate):0,0\n'
    + 'FIELD:filler1:TYPE(STRING1):0,0\n'
    + 'FIELD:license_licno:TYPE(STRING9):LIKE(invalid_license_licno):0,0\n'
    + 'FIELD:filler2:TYPE(STRING1):0,0\n'
    + 'FIELD:license_bdate_yyyymmdd:TYPE(STRING8):LIKE(invalid_8pastdate):0,0\n'
    + 'FIELD:license_edate_yyyymmdd:TYPE(STRING8):LIKE(invalid_8date):0,0\n'
    + 'FIELD:license_lic_class:TYPE(STRING2):LIKE(invalid_license_lic_class):0,0\n'
    + 'FIELD:license_height:TYPE(STRING3):LIKE(invalid_license_height):0,0\n'
    + 'FIELD:license_sex:TYPE(STRING1):LIKE(invalid_license_sex):0,0\n'
    + 'FIELD:license_last_name:TYPE(STRING16):LIKE(invalid_license_name):0,0\n'
    + 'FIELD:license_first_name:TYPE(STRING12):LIKE(invalid_wordbag):0,0\n'
    + 'FIELD:license_middle_name:TYPE(STRING8):LIKE(invalid_wordbag):0,0\n'
    + 'FIELD:licmail_street1:TYPE(STRING20):0,0\n'
    + 'FIELD:licmail_street2:TYPE(STRING20):0,0\n'
    + 'FIELD:licmail_city:TYPE(STRING15):0,0\n'
    + 'FIELD:licmail_state:TYPE(STRING2):LIKE(invalid_licmail_state):0,0\n'
    + 'FIELD:licmail_zip:TYPE(STRING9):LIKE(invalid_mailzip):0,0\n'
    + 'FIELD:licresi_street1:TYPE(STRING20):LIKE(invalid_wordbag):0,0\n'
    + 'FIELD:licresi_street2:TYPE(STRING20):LIKE(invalid_wordbag):0,0\n'
    + 'FIELD:licresi_city:TYPE(STRING15):LIKE(invalid_wordbag):0,0\n'
    + 'FIELD:licresi_state:TYPE(STRING2):LIKE(invalid_licresi_state):0,0\n'
    + 'FIELD:licresi_zip:TYPE(STRING9):LIKE(invalid_resizip):0,0\n'
    + 'FIELD:issue_date_yyyymmdd:TYPE(STRING8):LIKE(invalid_08pastdate):0,0\n'
    + 'FIELD:license_status:TYPE(STRING7):LIKE(invalid_license_status):0,0\n'
    + 'FIELD:clean_status:TYPE(STRING3):0,0\n'
    + 'FIELD:process_date:TYPE(STRING8):LIKE(invalid_8pastdate):0,0\n'
    + '// CONCEPT statements should be used to group together interellated fields; such as address\n'
    + '// RELATIONSHIP is used to find non-obvious relationships between the clusters\n'
    + '// SOURCEFIELD is used if a field of the file denotes a source of the records in that file\n'
    + '// LINKPATH is used to define access paths for external linking\n'
    ;
 
  // Structured values
  EXPORT linkpaths := DATASET([
    ],{STRING linkpath;STRING compulsory;STRING optional;STRING bonus;STRING required;STRING search});
 
END;

