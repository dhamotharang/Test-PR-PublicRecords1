// Machine-readable versions of the spec file and subsets thereof
IMPORT SALT311;
EXPORT GenerationMod := MODULE(SALT311.iGenerationMod)
 
  // SALT Version info
  EXPORT salt_VERSION := 'V3.11.7';
  EXPORT salt_MODULE := 'SALT311'; // Optional override by HACK:SALTMODULE
  EXPORT salt_TOOLSMODULE := 'SALTTOOLS30'; // Optional override by HACK:SALTTOOLSMODULE
 
  // Core module configuration values
  EXPORT spc_MODULE := 'Scrubs_DL_OH';
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
  EXPORT spc_FILENAME := 'In_oh';
  EXPORT spc_INGESTSTATUS := '';
  EXPORT spc_EXTERNAL_MAPPING := 'UniqueID:';
  EXPORT spc_EXTERNAL_BATCH_PARAM := ',/* MY_ */,process_date,key_number,license_number,license_class,donor_flag,hair_color,eye_color,weight_l,height_feet,height_inches,sex_gender,permanent_license_issue_date,license_expiration_date,restriction_codes,endorsement_codes,first_name,middle_name,last_name,street_address,city,state,zip_code,county_number,birth_date,clean_name_prefix,clean_fname,clean_mname,clean_lname';
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
    + 'MODULE:Scrubs_DL_OH\n'
    + 'FILENAME:In_oh\n'
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
    + 'FIELDTYPE:invalid_8pastdate:LENGTHS(8):CUSTOM(Scrubs.fn_valid_pastDate>0)\n'
    + 'FIELDTYPE:invalid_numeric:ALLOW(0123456789)\n'
    + 'FIELDTYPE:invalid_dl_number_check:CUSTOM(Scrubs_DL_OH.Functions.fn_check_dl_number>0)\n'
    + 'FIELDTYPE:invalid_license_class:ENUM(A|B|C|D|I|M1|M2|M3|M4|T|)\n'
    + 'FIELDTYPE:invalid_donor_flag:ENUM(F|U|Y|)\n'
    + 'FIELDTYPE:invalid_hair_color:CUSTOM(Scrubs_DL_OH.Functions.fn_check_hair_color>0)\n'
    + 'FIELDTYPE:invalid_eye_color:CUSTOM(Scrubs_DL_OH.Functions.fn_check_eye_color>0)\n'
    + 'FIELDTYPE:invalid_wgt:CUSTOM(Scrubs_DL_OH.Functions.fn_verify_weight>0)\n'
    + 'FIELDTYPE:invalid_height:CUSTOM(Scrubs_DL_OH.Functions.fn_verify_height>0,height_inches)\n'
    + 'FIELDTYPE:invalid_gender:ENUM(F|M|U|)\n'
    + 'FIELDTYPE:invalid_endorsements:ALLOW(23HMNOPQRSTX )\n'
    + 'FIELDTYPE:invalid_restrictions:ALLOW(0123456789ABCDEFGHIJKLMNOPVWXZ )\n'
    + 'FIELDTYPE:invalid_alpha_num_bnk:ALLOW(0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZ )\n'
    + 'FIELDTYPE:invalid_8generaldate:LENGTHS(8):CUSTOM(Scrubs.fn_valid_GeneralDate>0)\n'
    + 'FIELDTYPE:invalid_name:CUSTOM(scrubs.functions.fn_populated_strings>0,middle_name,last_name)\n'
    + 'FIELDTYPE:invalid_city:ALLOW(ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789/\'@-.,#` )\n'
    + 'FIELDTYPE:invalid_street:ALLOW(\\-/#,.\'=%:`&(;)0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZ )\n'
    + 'FIELDTYPE:invalid_state:CUSTOM(Scrubs_DL_OH.Functions.fn_verify_state>0)\n'
    + 'FIELDTYPE:invalid_zip:CUSTOM(Scrubs_DL_OH.Functions.fn_verify_zip>0)\n'
    + 'FIELDTYPE:invalid_clean_name:CUSTOM(scrubs.functions.fn_populated_strings>0,clean_mname,clean_lname)\n'
    + '\n'
    + 'FIELD:process_date:TYPE(STRING8):LIKE(invalid_8pastdate):0,0\n'
    + 'FIELD:key_number:TYPE(STRING9):LIKE(invalid_dl_number_check):0,0\n'
    + 'FIELD:license_number:TYPE(STRING8):LIKE(invalid_dl_number_check):0,0\n'
    + 'FIELD:license_class:TYPE(STRING2):LIKE(invalid_license_class):0,0\n'
    + 'FIELD:donor_flag:TYPE(STRING1):LIKE(invalid_donor_flag):0,0\n'
    + 'FIELD:hair_color:TYPE(STRING3):LIKE(invalid_hair_color):0,0\n'
    + 'FIELD:eye_color:TYPE(STRING3):LIKE(invalid_eye_color):0,0\n'
    + 'FIELD:weight_l:TYPE(STRING3):LIKE(invalid_wgt):0,0\n'
    + 'FIELD:height_feet:TYPE(STRING1):LIKE(invalid_height):0,0\n'
    + 'FIELD:height_inches:TYPE(STRING2):0,0\n'
    + 'FIELD:sex_gender:TYPE(STRING1):LIKE(invalid_gender):0,0\n'
    + 'FIELD:permanent_license_issue_date:TYPE(STRING8):LIKE(invalid_8pastdate):0,0\n'
    + 'FIELD:license_expiration_date:TYPE(STRING8):LIKE(invalid_8generaldate):0,0\n'
    + 'FIELD:restriction_codes:TYPE(STRING42):LIKE(invalid_restrictions):0,0\n'
    + 'FIELD:endorsement_codes:TYPE(STRING10):LIKE(invalid_endorsements):0,0\n'
    + 'FIELD:first_name:TYPE(STRING40):LIKE(invalid_name):0,0\n'
    + 'FIELD:middle_name:TYPE(STRING40):0,0\n'
    + 'FIELD:last_name:TYPE(STRING40):0,0\n'
    + 'FIELD:street_address:TYPE(STRING30):LIKE(invalid_street):0,0\n'
    + 'FIELD:city:TYPE(STRING20):LIKE(invalid_city):0,0\n'
    + 'FIELD:state:TYPE(STRING2):LIKE(invalid_state):0,0\n'
    + 'FIELD:zip_code:TYPE(STRING11):LIKE(invalid_zip):0,0\n'
    + 'FIELD:county_number:TYPE(STRING2):LIKE(invalid_numeric):0,0\n'
    + 'FIELD:birth_date:TYPE(STRING8):LIKE(invalid_8pastdate):0,0\n'
    + 'FIELD:clean_name_prefix:TYPE(STRING5):0,0\n'
    + 'FIELD:clean_fname:TYPE(STRING20):LIKE(invalid_clean_name):0,0\n'
    + 'FIELD:clean_mname:TYPE(STRING20):0,0\n'
    + 'FIELD:clean_lname:TYPE(STRING20):0,0\n'
    + '// CONCEPT statements should be used to group together interellated fields; such as address\n'
    + '// RELATIONSHIP is used to find non-obvious relationships between the clusters\n'
    + '// SOURCEFIELD is used if a field of the file denotes a source of the records in that file\n'
    + '// LINKPATH is used to define access paths for external linking\n'
    ;
 
  // Structured values
  EXPORT linkpaths := DATASET([
    ],{STRING linkpath;STRING compulsory;STRING optional;STRING bonus;STRING required;STRING search});
 
END;

