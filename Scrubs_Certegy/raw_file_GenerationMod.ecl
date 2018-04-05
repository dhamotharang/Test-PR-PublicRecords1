// Machine-readable versions of the spec file and subsets thereof
EXPORT raw_file_GenerationMod := MODULE
 
  // SALT Version info
  EXPORT salt_VERSION := 'V3.8.0';
  EXPORT salt_MODULE := 'SALT38'; // Optional override by HACK:SALTMODULE
  EXPORT salt_TOOLSMODULE := 'SALTTOOLS30'; // Optional override by HACK:SALTTOOLSMODULE
 
  // Core module configuration values
  EXPORT spc_MODULE := 'Scrubs_Certegy';
  EXPORT spc_NAMESCOPE := 'raw_file';
  EXPORT spc_PROCESS := '';
  EXPORT spc_IDNAME := ''; // cluster id (input)
  EXPORT spc_IDFIELD := ''; // cluster id (output)
  EXPORT spc_RIDFIELD := ''; // record id
 
  // The entire spec file
  EXPORT spcString :=
    'OPTIONS:-gh\n'
    + 'MODULE:Scrubs_Certegy\n'
    + 'FILENAME:Certegy\n'
    + 'NAMESCOPE:raw_file \n'
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
    + 'FIELDTYPE:invalid_dl_state:CUSTOM(Scrubs_Certegy.functions.fn_verify_state>0)\n'
    + 'FIELDTYPE:invalid_dl_num:ALLOW(*0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZ)\n'
    + 'FIELDTYPE:invalid_ssn:CUSTOM(Scrubs_Certegy.functions.fn_valid_ssn>0)\n'
    + 'FIELDTYPE:invalid_dl_issue_dte:CUSTOM(Scrubs_Certegy.functions.fn_past_date>0)\n'
    + 'FIELDTYPE:invalid_dl_expire_dte:CUSTOM(Scrubs_Certegy.functions.fn_general_date>0)\n'
    + 'FIELDTYPE:invalid_house_bldg_num:ALLOW( -/0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZ)\n'
    + 'FIELDTYPE:invalid_street_suffix:ALLOW(ABCDEFGHIJKLMNOPQRSTUVWXYZ)\n'
    + 'FIELDTYPE:invalid_apt_num:ALLOW( /-0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZ)\n'
    + 'FIELDTYPE:invalid_unit_desc:ALLOW(#ABCDEFGHIJKLMNOPQRSTUVWXYZ)\n'
    + 'FIELDTYPE:invalid_street_post_dir:ALLOW(ENSW)\n'
    + 'FIELDTYPE:invalid_street_pre_dir:ALLOW(ENSW)\n'
    + 'FIELDTYPE:invalid_state:CUSTOM(Scrubs_Certegy.functions.fn_verify_state>0)\n'
    + 'FIELDTYPE:invalid_zip:CUSTOM(Scrubs_Certegy.functions.fn_verify_zip5>0)\n'
    + 'FIELDTYPE:invalid_zip4:CUSTOM(Scrubs_Certegy.functions.fn_verify_zip4>0)\n'
    + 'FIELDTYPE:invalid_dob:CUSTOM(Scrubs_Certegy.functions.fn_past_date>0)\n'
    + 'FIELDTYPE:invalid_deceased_dte:CUSTOM(Scrubs_Certegy.functions.fn_deceased_dte>0,deceased_dte,dob)\n'
    + 'FIELDTYPE:invalid_home_tel_area:CUSTOM(Scrubs_Certegy.functions.fn_CleanPhone>0,home_tel_area,home_tel_num)\n'
    + 'FIELDTYPE:invalid_home_tel_num:CUSTOM(Scrubs_Certegy.functions.fn_CleanPhone>0,home_tel_area,home_tel_num)\n'
    + 'FIELDTYPE:invalid_work_tel_area:CUSTOM(Scrubs_Certegy.functions.fn_CleanPhone>0,work_tel_area,work_tel_num)\n'
    + 'FIELDTYPE:invalid_work_tel_num:CUSTOM(Scrubs_Certegy.functions.fn_CleanPhone>0,work_tel_area,work_tel_num)\n'
    + 'FIELDTYPE:invalid_work_tel_ext:CUSTOM(Scrubs_Certegy.functions.fn_tel_ext>0,work_tel_ext)\n'
    + 'FIELDTYPE:invalid_upd_dte_time:CUSTOM(Scrubs_Certegy.functions.fn_past_date>0)\n'
    + 'FIELDTYPE:invalid_first_name:CUSTOM(Scrubs_Certegy.functions.fn_chk_blank_names>0,first_name,mid_name,last_name)\n'
    + 'FIELDTYPE:invalid_mid_name:CUSTOM(Scrubs_Certegy.functions.fn_chk_blank_names>0,first_name,mid_name,last_name)\n'
    + 'FIELDTYPE:invalid_last_name:CUSTOM(Scrubs_Certegy.functions.fn_chk_blank_names>0,first_name,mid_name,last_name)\n'
    + 'FIELDTYPE:invalid_gen_delivery:CUSTOM(Scrubs_Certegy.functions.fn_gen_del>0)\n'
    + 'FIELDTYPE:invalid_street_name:ALLOW( .-/0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZ)\n'
    + 'FIELDTYPE:invalid_city:ALLOW( ABCDEFGHIJKLMNOPQRSTUVWXYZ)\n'
    + '\n'
    + 'FIELD:dl_state:TYPE(STRING2):LIKE(invalid_dl_state):0,0\n'
    + 'FIELD:dl_num:TYPE(STRING24):LIKE(invalid_dl_num):0,0\n'
    + 'FIELD:ssn:TYPE(STRING9):LIKE(invalid_ssn):0,0\n'
    + 'FIELD:dl_issue_dte:TYPE(STRING10):LIKE(invalid_dl_issue_dte):0,0\n'
    + 'FIELD:dl_expire_dte:TYPE(STRING10):LIKE(invalid_dl_expire_dte):0,0\n'
    + 'FIELD:house_bldg_num:TYPE(STRING10):LIKE(invalid_house_bldg_num):0,0\n'
    + 'FIELD:street_suffix:TYPE(STRING4):LIKE(invalid_street_suffix):0,0\n'
    + 'FIELD:apt_num:TYPE(STRING10):LIKE(invalid_apt_num):0,0\n'
    + 'FIELD:unit_desc:TYPE(STRING4):LIKE(invalid_unit_desc):0,0\n'
    + 'FIELD:street_post_dir:TYPE(STRING2):LIKE(invalid_street_post_dir):0,0\n'
    + 'FIELD:street_pre_dir:TYPE(STRING2):LIKE(invalid_street_pre_dir):0,0\n'
    + 'FIELD:state:TYPE(STRING2):LIKE(invalid_state):0,0\n'
    + 'FIELD:zip:TYPE(STRING5):LIKE(invalid_zip):0,0\n'
    + 'FIELD:zip4:TYPE(STRING4):LIKE(invalid_zip4):0,0\n'
    + 'FIELD:dob:TYPE(STRING10):LIKE(invalid_dob):0,0\n'
    + 'FIELD:deceased_dte:TYPE(STRING10):LIKE(invalid_deceased_dte):0,0\n'
    + 'FIELD:home_tel_area:TYPE(STRING3):LIKE(invalid_home_tel_area):0,0\n'
    + 'FIELD:home_tel_num:TYPE(STRING7):LIKE(invalid_home_tel_num):0,0\n'
    + 'FIELD:work_tel_area:TYPE(STRING3):LIKE(invalid_work_tel_area):0,0\n'
    + 'FIELD:work_tel_num:TYPE(STRING7):LIKE(invalid_work_tel_num):0,0\n'
    + 'FIELD:work_tel_ext:TYPE(STRING5):LIKE(invalid_work_tel_ext):0,0\n'
    + 'FIELD:upd_dte_time:TYPE(STRING26):LIKE(invalid_upd_dte_time):0,0\n'
    + 'FIELD:first_name:TYPE(STRING20):LIKE(invalid_first_name):0,0\n'
    + 'FIELD:mid_name:TYPE(STRING20):LIKE(invalid_mid_name):0,0\n'
    + 'FIELD:last_name:TYPE(STRING35):LIKE(invalid_last_name):0,0\n'
    + 'FIELD:gen_delivery:TYPE(STRING20):LIKE(invalid_gen_delivery):0,0\n'
    + 'FIELD:street_name:TYPE(STRING35):LIKE(invalid_street_name):0,0\n'
    + 'FIELD:city:TYPE(STRING25):LIKE(invalid_city):0,0\n'
    + 'FIELD:foreign_cntry:TYPE(STRING25):0,0 \n'
    + '// CONCEPT statements should be used to group together interellated fields; such as address\n'
    + '// RELATIONSHIP is used to find non-obvious relationships between the clusters\n'
    + '// SOURCEFIELD is used if a field of the file denotes a source of the records in that file\n'
    + '// LINKPATH is used to define access paths for external linking\n'
    ;
 
  // Structured values
  EXPORT linkpaths := DATASET([
    ],{STRING linkpath;STRING compulsory;STRING optional;STRING bonus;STRING required;STRING search});
 
END;
