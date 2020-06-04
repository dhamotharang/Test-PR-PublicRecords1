// Machine-readable versions of the spec file and subsets thereof
IMPORT SALT311;
EXPORT GenerationMod := MODULE(SALT311.iGenerationMod)
 
  // SALT Version info
  EXPORT salt_VERSION := 'V3.11.7';
  EXPORT salt_MODULE := 'SALT311'; // Optional override by HACK:SALTMODULE
  EXPORT salt_TOOLSMODULE := 'SALTTOOLS30'; // Optional override by HACK:SALTTOOLSMODULE
 
  // Core module configuration values
  EXPORT spc_MODULE := 'Scrubs_DL_CT';
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
  EXPORT spc_FILENAME := 'In_CT';
  EXPORT spc_INGESTSTATUS := '';
  EXPORT spc_EXTERNAL_MAPPING := 'UniqueID:';
  EXPORT spc_EXTERNAL_BATCH_PARAM := ',/* MY_ */,append_process_date,credentialstate,credentialnumber,lastname,firstname,middleinitial,gender,height,eyecolor,date_birth,resiaddrstreet,residencycity,residencystate,residencyzip,mailaddrstreet,mailingcity,mailingstate,mailingzip,credentialtype,credential_class,endorsements,restrictions,expdate,lastissuerenewaldate,date_noncdl,originaldate_cdl,statusnoncdl,licensestatuscdl,originaldate_lp,originaldate_id,cancelstate,canceldate,cdlmedicertissuedate,cdlmedicertexpdate,clean_name_prefix,clean_name_first,clean_name_middle,clean_name_last,clean_name_suffix,clean_name_score';
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
    + 'MODULE:Scrubs_DL_CT\n'
    + 'FILENAME:In_CT\n'
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
    + 'FIELDTYPE:invalid_credentialstate:ENUM(CT|CT)\n'
    + 'FIELDTYPE:invalid_credentialnumber:CUSTOM(Scrubs_DL_CT.Functions.fn_check_dl_number>0,9)\n'
    + 'FIELDTYPE:invalid_name:CUSTOM(Scrubs_DL_CT.Functions.fn_valid_name>0,firstname,middleinitial)\n'
    + 'FIELDTYPE:invalid_sex:ENUM(F|M|U|)\n'
    + 'FIELDTYPE:invalid_height:CUSTOM(Scrubs_DL_CT.Functions.fn_verify_height>0)\n'
    + 'FIELDTYPE:invalid_eye_color:CUSTOM(Scrubs_DL_CT.Functions.fn_check_eye_color>0)\n'
    + 'FIELDTYPE:invalid_past_date:CUSTOM(Scrubs_DL_CT.Functions.fn_check_past_date>0)\n'
    + 'FIELDTYPE:invalid_general_date:CUSTOM(Scrubs_DL_CT.Functions.fn_check_general_date>0)\n'
    + 'FIELDTYPE:invalid_city:ALLOW(\\ABCDEFGHIJKLMNOPQRSTUVWXYZ )\n'
    + 'FIELDTYPE:invalid_street:ALLOW(/\\#-.0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZ )\n'
    + 'FIELDTYPE:invalid_state:CUSTOM(Scrubs_DL_CT.Functions.fn_verify_state>0)\n'
    + 'FIELDTYPE:invalid_zip:CUSTOM(Scrubs_DL_CT.Functions.fn_verify_zip>0)\n'
    + 'FIELDTYPE:invalid_credentialtype:ENUM(CDL|ID|LP|LIC|)\n'
    + 'FIELDTYPE:invalid_class:CUSTOM(Scrubs_DL_CT.Functions.fn_class>0)\n'
    + 'FIELDTYPE:invalid_endorsements:ALLOW(AFHMNPQSTVX )\n'
    + 'FIELDTYPE:invalid_restrictions:ALLOW(3BCDEFGJKLMNOQRTUVWYZ )\n'
    + 'FIELDTYPE:invalid_status:CUSTOM(Scrubs_DL_CT.Functions.fn_check_status_code>0)\n'
    + 'FIELDTYPE:invalid_status_cdl:CUSTOM(Scrubs_DL_CT.Functions.fn_check_cdl_status_code>0)\n'
    + 'FIELDTYPE:invalid_clean_name:CUSTOM(Scrubs_DL_CT.Functions.fn_valid_name>0,clean_name_first,clean_name_middle)\n'
    + '\n'
    + '\n'
    + '//FIELD DEFINITIONS\n'
    + 'FIELD:append_process_date:TYPE(STRING8):LIKE(invalid_past_date):0,0\n'
    + 'FIELD:credentialstate:TYPE(STRING2):LIKE(invalid_credentialstate):0,0\n'
    + 'FIELD:credentialnumber:TYPE(STRING25):LIKE(invalid_credentialnumber):0,0\n'
    + 'FIELD:lastname:TYPE(STRING40):LIKE(invalid_name):0,0\n'
    + 'FIELD:firstname:TYPE(STRING40):0,0\n'
    + 'FIELD:middleinitial:TYPE(STRING35):0,0\n'
    + 'FIELD:gender:TYPE(STRING1):LIKE(invalid_sex):0,0\n'
    + 'FIELD:height:TYPE(STRING3):LIKE(invalid_height):0,0\n'
    + 'FIELD:eyecolor:TYPE(STRING3):LIKE(invalid_eye_color):0,0\n'
    + 'FIELD:date_birth:TYPE(STRING8):LIKE(invalid_past_date):0,0\n'
    + 'FIELD:resiaddrstreet:TYPE(STRING35):LIKE(invalid_street):0,0\n'
    + 'FIELD:residencycity:TYPE(STRING20):LIKE(invalid_city):0,0\n'
    + 'FIELD:residencystate:TYPE(STRING2):LIKE(invalid_state):0,0\n'
    + 'FIELD:residencyzip:TYPE(STRING9):LIKE(invalid_zip):0,0\n'
    + 'FIELD:mailaddrstreet:TYPE(STRING35):LIKE(invalid_street):0,0\n'
    + 'FIELD:mailingcity:TYPE(STRING20):LIKE(invalid_city):0,0\n'
    + 'FIELD:mailingstate:TYPE(STRING2):LIKE(invalid_state):0,0\n'
    + 'FIELD:mailingzip:TYPE(STRING9):LIKE(invalid_zip):0,0\n'
    + 'FIELD:credentialtype:TYPE(STRING3):LIKE(invalid_credentialtype):0,0\n'
    + 'FIELD:credential_class:TYPE(STRING1):LIKE(invalid_class):0,0\n'
    + 'FIELD:endorsements:TYPE(STRING5):LIKE(invalid_endorsements):0,0\n'
    + 'FIELD:restrictions:TYPE(STRING12):LIKE(invalid_restrictions):0,0\n'
    + 'FIELD:expdate:TYPE(STRING8):LIKE(invalid_general_date):0,0\n'
    + 'FIELD:lastissuerenewaldate:TYPE(STRING8):LIKE(invalid_past_date):0,0\n'
    + 'FIELD:date_noncdl:TYPE(STRING8):LIKE(invalid_past_date):0,0\n'
    + 'FIELD:originaldate_cdl:TYPE(STRING8):LIKE(invalid_past_date):0,0\n'
    + 'FIELD:statusnoncdl:TYPE(STRING3):LIKE(invalid_status):0,0\n'
    + 'FIELD:licensestatuscdl:TYPE(STRING3):LIKE(invalid_status_cdl):0,0\n'
    + 'FIELD:originaldate_lp:TYPE(STRING8):LIKE(invalid_past_date):0,0\n'
    + 'FIELD:originaldate_id:TYPE(STRING8):LIKE(invalid_past_date):0,0\n'
    + 'FIELD:cancelstate:TYPE(STRING2):LIKE(invalid_state):0,0\n'
    + 'FIELD:canceldate:TYPE(STRING8):LIKE(invalid_past_date):0,0\n'
    + 'FIELD:cdlmedicertissuedate:TYPE(STRING8):LIKE(invalid_past_date):0,0\n'
    + 'FIELD:cdlmedicertexpdate:TYPE(STRING8):LIKE(invalid_general_date):0,0\n'
    + 'FIELD:clean_name_prefix:TYPE(STRING5):0,0\n'
    + 'FIELD:clean_name_first:TYPE(STRING20):0,0\n'
    + 'FIELD:clean_name_middle:TYPE(STRING20):0,0\n'
    + 'FIELD:clean_name_last:TYPE(STRING20):LIKE(invalid_clean_name):0,0\n'
    + 'FIELD:clean_name_suffix:TYPE(STRING5):0,0\n'
    + 'FIELD:clean_name_score:TYPE(STRING3):0,0\n'
    + '// CONCEPT statements should be used to group together interellated fields; such as address\n'
    + '// RELATIONSHIP is used to find non-obvious relationships between the clusters\n'
    + '// SOURCEFIELD is used if a field of the file denotes a source of the records in that file\n'
    + '// LINKPATH is used to define access paths for external linking\n'
    ;
 
  // Structured values
  EXPORT linkpaths := DATASET([
    ],{STRING linkpath;STRING compulsory;STRING optional;STRING bonus;STRING required;STRING search});
 
END;

