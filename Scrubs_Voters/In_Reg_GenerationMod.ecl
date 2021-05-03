// Machine-readable versions of the spec file and subsets thereof
IMPORT SALT311;
EXPORT In_Reg_GenerationMod := MODULE(SALT311.iGenerationMod)
 
  // SALT Version info
  EXPORT salt_VERSION := 'V3.11.4';
  EXPORT salt_MODULE := 'SALT311'; // Optional override by HACK:SALTMODULE
  EXPORT salt_TOOLSMODULE := 'SALTTOOLS30'; // Optional override by HACK:SALTTOOLSMODULE
 
  // Core module configuration values
  EXPORT spc_MODULE := 'Scrubs_Voters';
  EXPORT spc_NAMESCOPE := 'In_Reg';
  EXPORT spc_PROCESS := '';
  EXPORT spc_PROCLAYOUTS := 'Process__Layouts';
  EXPORT spc_IDNAME := ''; // cluster id (input)
  EXPORT spc_IDFIELD := ''; // cluster id (output)
  EXPORT spc_RIDFIELD := ''; // record id
  EXPORT spc_CONFIG := 'Config';
  EXPORT spc_CONFIGPARAM := FALSE;
  EXPORT spc_SOURCEFIELD := '';
  EXPORT spc_FILEPREFIX := 'In_';
  EXPORT spc_FILENAME := 'Voters';
  EXPORT spc_INGESTSTATUS := '';
  EXPORT spc_EXTERNAL_MAPPING := 'UniqueID:';
  EXPORT spc_EXTERNAL_BATCH_PARAM := ',/* MY_ */,active_status,agecat,changedate,countycode,distcode,dob,EMID_number,file_acquired_date,first_name,gender,gendersurnamguess,home_phone,idcode,lastdatevote,last_name,marriedappend,middle_name,political_party,race,regdate,res_addr1,res_city,res_state,res_zip,schoolcode,source_voterid,statehouse,statesenate,state_code,timezonetbl,ushouse,voter_status,work_phone';
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
    + 'MODULE:Scrubs_Voters\n'
    + 'FILENAME:Voters\n'
    + 'NAMESCOPE:In_Reg\n'
    + '// Uncomment up to NINES for internal or external adl\n'
    + '// IDFIELD:EXISTS:<NameOfIDField>\n'
    + '// RIDFIELD:<NameOfRidField>\n'
    + '// RECORDS:<NumberOfRecordsInDataFile>\n'
    + '// POPULATION:<ExpectedNumberOfEntitiesInDataFile>\n'
    + '\n'
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
    + 'FIELDTYPE:invalid_agecat:CUSTOM(Scrubs_Voters.Functions.fn_valid_agecat>0)\n'
    + 'FIELDTYPE:invalid_alphanum:CUSTOM(Scrubs_Voters.Functions.fn_non_empty_alphanum>0)\n'
    + 'FIELDTYPE:invalid_alphanum_empty:ALLOW(0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz )\n'
    + 'FIELDTYPE:invalid_alphanum_empty_specials:ALLOW(0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz()@#-:./,`&\'Ã£Ã±Ã¨Ã³Ã©Ã Ã‚Ã¡Ã”Ã­Ã¶Ã‹Ãº )\n'
    + 'FIELDTYPE:invalid_alphanum_specials:CUSTOM(Scrubs_Voters.Functions.fn_non_empty_alphanum_specials>0)\n'
    + 'FIELDTYPE:invalid_alphanumquot_empty:ALLOW(0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz" )\n'
    + 'FIELDTYPE:invalid_boolean_yn_empty:ENUM(N|Y|)\n'
    + 'FIELDTYPE:invalid_changedate:CUSTOM(Scrubs_Voters.Functions.fn_optional_past_yyyymmdd>0)\n'
    + 'FIELDTYPE:invalid_dob:CUSTOM(Scrubs_Voters.Functions.fn_valid_generic_date>0)\n'
    + 'FIELDTYPE:invalid_gender:ENUM(F|M|U|N|)\n'
    + 'FIELDTYPE:invalid_lastdatevote:CUSTOM(Scrubs_Voters.Functions.fn_valid_generic_date>0)\n'
    + 'FIELDTYPE:invalid_last_name:CUSTOM(Scrubs_Voters.Functions.fn_populated_strings>0,first_name,middle_name)\n'
    + 'FIELDTYPE:invalid_mandatory:CUSTOM(Scrubs_Voters.Functions.fn_populated_strings>0)\n'
    + 'FIELDTYPE:invalid_numeric:CUSTOM(Scrubs_Voters.Functions.fn_numeric>0)\n'
    + 'FIELDTYPE:invalid_nums_empty:ALLOW(0123456789)\n'
    + 'FIELDTYPE:invalid_pastdate8:CUSTOM(Scrubs_Voters.Functions.fn_past_yyyymmdd>0)\n'
    + 'FIELDTYPE:invalid_percentage:CUSTOM(Scrubs_Voters.Functions.fn_range_numeric>0,0,100)\n'
    + 'FIELDTYPE:invalid_phone:CUSTOM(Scrubs_Voters.Functions.fn_verify_optional_phone>0)\n'
    + 'FIELDTYPE:invalid_race:CUSTOM(Scrubs_Voters.Functions.fn_race>0)\n'
    + 'FIELDTYPE:invalid_regdate:CUSTOM(Scrubs_Voters.Functions.fn_valid_generic_date>0)\n'
    + 'FIELDTYPE:invalid_source_state:CUSTOM(Scrubs_Voters.Functions.fn_verify_state>0)\n'
    + 'FIELDTYPE:invalid_st:CUSTOM(Scrubs_Voters.Functions.fn_verify_state>0)\n'
    + '\n'
    + '//FIELD DEFINITIONS\n'
    + 'FIELD:active_status:TYPE(STRING1):LIKE(invalid_alphanum_empty):0,0\n'
    + 'FIELD:agecat:TYPE(STRING2):LIKE(invalid_agecat):0,0\n'
    + 'FIELD:changedate:TYPE(STRING10):LIKE(invalid_changedate):0,0\n'
    + 'FIELD:countycode:TYPE(STRING5):LIKE(invalid_alphanum_empty):0,0\n'
    + 'FIELD:distcode:TYPE(STRING5):LIKE(invalid_alphanum_empty):0,0\n'
    + 'FIELD:dob:TYPE(STRING8):LIKE(invalid_dob):0,0\n'
    + 'FIELD:EMID_number:TYPE(STRING13):LIKE(invalid_alphanum):0,0\n'
    + 'FIELD:file_acquired_date:TYPE(STRING8):LIKE(invalid_pastdate8):0,0\n'
    + 'FIELD:first_name:TYPE(STRING30):LIKE(invalid_alphanum_specials):0,0\n'
    + 'FIELD:gender:TYPE(STRING1):LIKE(invalid_gender):0,0\n'
    + 'FIELD:gendersurnamguess:TYPE(STRING1):LIKE(invalid_alphanum_empty):0,0\n'
    + 'FIELD:home_phone:TYPE(STRING10):LIKE(invalid_phone):0,0\n'
    + 'FIELD:idcode:TYPE(STRING1):LIKE(invalid_alphanum_empty):0,0\n'
    + 'FIELD:lastdatevote:TYPE(STRING8):LIKE(invalid_lastdatevote):0,0\n'
    + 'FIELD:last_name:TYPE(STRING30):LIKE(invalid_last_name):0,0\n'
    + 'FIELD:marriedappend:TYPE(STRING2):LIKE(invalid_boolean_yn_empty):0,0\n'
    + 'FIELD:middle_name:TYPE(STRING30):LIKE(invalid_alphanum_empty_specials):0,0\n'
    + '// FIELD:political_party:TYPE(STRING2):LIKE(invalid_numeric):0,0\n'
    + 'FIELD:political_party:TYPE(STRING2):LIKE(invalid_nums_empty):0,0\n'
    + 'FIELD:race:TYPE(STRING2):LIKE(invalid_race):0,0\n'
    + 'FIELD:regdate:TYPE(STRING8):LIKE(invalid_regdate):0,0\n'
    + 'FIELD:res_addr1:TYPE(STRING40):LIKE(invalid_mandatory):0,0\n'
    + 'FIELD:res_city:TYPE(STRING40):LIKE(invalid_mandatory):0,0\n'
    + 'FIELD:res_state:TYPE(STRING2):LIKE(invalid_st):0,0\n'
    + 'FIELD:res_zip:TYPE(STRING9):LIKE(invalid_mandatory):0,0\n'
    + 'FIELD:schoolcode:TYPE(STRING5):LIKE(invalid_alphanum_empty):0,0\n'
    + 'FIELD:source_voterid:TYPE(STRING12):LIKE(invalid_alphanum):0,0\n'
    + 'FIELD:statehouse:TYPE(STRING3):LIKE(invalid_alphanum_empty):0,0\n'
    + 'FIELD:statesenate:TYPE(STRING3):LIKE(invalid_alphanumquot_empty):0,0\n'
    + 'FIELD:state_code:TYPE(STRING2):LIKE(invalid_source_state):0,0\n'
    + 'FIELD:timezonetbl:TYPE(STRING3):LIKE(invalid_nums_empty):0,0\n'
    + 'FIELD:ushouse:TYPE(STRING3):LIKE(invalid_alphanum_empty):0,0\n'
    + 'FIELD:voter_status:TYPE(STRING2):LIKE(invalid_alphanum_empty):0,0\n'
    + 'FIELD:work_phone:TYPE(STRING10):LIKE(invalid_phone):0,0\n'
    ;
 
  // Structured values
  EXPORT linkpaths := DATASET([
    ],{STRING linkpath;STRING compulsory;STRING optional;STRING bonus;STRING required;STRING search});
 
END;

