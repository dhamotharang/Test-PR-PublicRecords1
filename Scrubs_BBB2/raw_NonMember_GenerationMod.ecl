// Machine-readable versions of the spec file and subsets thereof
IMPORT SALT311;
EXPORT raw_NonMember_GenerationMod := MODULE(SALT311.iGenerationMod)
 
  // SALT Version info
  EXPORT salt_VERSION := 'V3.11.7';
  EXPORT salt_MODULE := 'SALT311'; // Optional override by HACK:SALTMODULE
  EXPORT salt_TOOLSMODULE := 'SALTTOOLS30'; // Optional override by HACK:SALTTOOLSMODULE
 
  // Core module configuration values
  EXPORT spc_MODULE := 'Scrubs_BBB2';
  EXPORT spc_NAMESCOPE := 'raw_NonMember';
  EXPORT spc_PROCESS := '';
  EXPORT spc_PROCLAYOUTS := 'Process__Layouts';
  EXPORT spc_IDNAME := ''; // cluster id (input)
  EXPORT spc_IDFIELD := ''; // cluster id (output)
  EXPORT spc_RIDFIELD := ''; // record id
  EXPORT spc_CONFIG := 'Config';
  EXPORT spc_CONFIGPARAM := FALSE;
  EXPORT spc_SOURCEFIELD := '';
  EXPORT spc_FILEPREFIX := 'In_';
  EXPORT spc_FILENAME := 'BBB2';
  EXPORT spc_INGESTSTATUS := '';
  EXPORT spc_EXTERNAL_MAPPING := 'UniqueID:';
  EXPORT spc_EXTERNAL_BATCH_PARAM := ',/* MY_ */,bbb_id,company_name,address,country,phone,phone_type,listing_month,listing_day,listing_year,http_link,non_member_title,non_member_category';
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
    + 'MODULE:Scrubs_BBB2\n'
    + 'FILENAME:BBB2\n'
    + 'NAMESCOPE:raw_NonMember\n'
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
    + 'FIELDTYPE:invalid_bbb_id:CUSTOM(Scrubs_BBB2.Functions.fn_numeric>0)\n'
    + 'FIELDTYPE:invalid_chk_blanks:CUSTOM(Scrubs_BBB2.Functions.fn_chk_blanks>0) \n'
    + 'FIELDTYPE:invalid_chk_addr:CUSTOM(Scrubs_BBB2.Functions.fn_chk_blank_addr>0)\n'
    + 'FIELDTYPE:invalid_country:ENUM(US|USA|)\n'
    + 'FIELDTYPE:invalid_phone:CUSTOM(Scrubs_BBB2.functions.fn_verify_phone>0)\n'
    + 'FIELDTYPE:invalid_phone_type:ENUM(main|MAIN|)\n'
    + 'FIELDTYPE:invalid_listing_year:CUSTOM(Scrubs_BBB2.Functions.fn_valid_general_yyyymmdd>0,listing_month,listing_day) \n'
    + 'FIELDTYPE:invalid_http_link:CUSTOM(Scrubs_BBB2.Functions.fn_url>0)\n'
    + ' \n'
    + '\n'
    + '\n'
    + 'FIELD:bbb_id:TYPE(STRING):LIKE(invalid_bbb_id):0,0\n'
    + 'FIELD:company_name:TYPE(STRING):LIKE(invalid_chk_blanks):0,0\n'
    + 'FIELD:address:TYPE(STRING):LIKE(invalid_chk_addr):0,0\n'
    + 'FIELD:country:TYPE(STRING):LIKE(invalid_country):0,0\n'
    + 'FIELD:phone:TYPE(STRING):LIKE(invalid_phone):0,0\n'
    + 'FIELD:phone_type:TYPE(STRING):LIKE(invalid_phone_type):0,0\n'
    + 'FIELD:listing_month:TYPE(STRING):0,0\n'
    + 'FIELD:listing_day:TYPE(STRING):0,0\n'
    + 'FIELD:listing_year:TYPE(STRING):LIKE(invalid_listing_year):0,0\n'
    + 'FIELD:http_link:TYPE(STRING):LIKE(invalid_http_link):0,0\n'
    + 'FIELD:non_member_title:TYPE(STRING):LIKE(invalid_chk_blanks):0,0\n'
    + 'FIELD:non_member_category:TYPE(STRING):LIKE(invalid_chk_blanks):0,0\n'
    + '// CONCEPT statements should be used to group together interellated fields; such as address\n'
    + '// RELATIONSHIP is used to find non-obvious relationships between the clusters\n'
    + '// SOURCEFIELD is used if a field of the file denotes a source of the records in that file\n'
    + '// LINKPATH is used to define access paths for external linking\n'
    ;
 
  // Structured values
  EXPORT linkpaths := DATASET([
    ],{STRING linkpath;STRING compulsory;STRING optional;STRING bonus;STRING required;STRING search});
 
END;

