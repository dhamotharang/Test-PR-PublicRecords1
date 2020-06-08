// Machine-readable versions of the spec file and subsets thereof
IMPORT SALT311;
EXPORT InputB_GenerationMod := MODULE(SALT311.iGenerationMod)
 
  // SALT Version info
  EXPORT salt_VERSION := 'V3.11.11';
  EXPORT salt_MODULE := 'SALT311'; // Optional override by HACK:SALTMODULE
  EXPORT salt_TOOLSMODULE := 'SALTTOOLS30'; // Optional override by HACK:SALTTOOLSMODULE
 
  // Core module configuration values
  EXPORT spc_MODULE := 'Scrubs_OneKey';
  EXPORT spc_NAMESCOPE := 'InputB';
  EXPORT spc_PROCESS := '';
  EXPORT spc_PROCLAYOUTS := 'Process__Layouts';
  EXPORT spc_IDNAME := ''; // cluster id (input)
  EXPORT spc_IDFIELD := ''; // cluster id (output)
  EXPORT spc_RIDFIELD := ''; // record id
  EXPORT spc_CONFIG := 'Config';
  EXPORT spc_CONFIGPARAM := FALSE;
  EXPORT spc_SOURCEFIELD := '';
  EXPORT spc_FILEPREFIX := 'In_';
  EXPORT spc_FILENAME := 'OneKey';
  EXPORT spc_INGESTSTATUS := '';
  EXPORT spc_EXTERNAL_MAPPING := 'UniqueID:';
  EXPORT spc_EXTERNAL_BATCH_PARAM := ',/* MY_ */,hcp_hce_id,ok_indv_id,ska_uid,ims_id,frst_nm,mid_nm,last_nm,sfx_cd,gender_cd,prim_prfsn_cd,prim_prfsn_desc,prim_spcl_cd,prim_spcl_desc,hce_prfsnl_stat_cd,hce_prfsnl_stat_desc,excld_rsn_desc,npi,deactv_dt,xref_hce_id,city_nm,st_cd,zip5_cd';
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
    + 'MODULE:Scrubs_OneKey\n'
    + 'FILENAME:OneKey\n'
    + 'NAMESCOPE:InputB\n'
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
    + 'FIELDTYPE:invalid_numeric_nonzero:CUSTOM(Scrubs_OneKey.Functions.fn_numeric_nonzero>0)\n'
    + 'FIELDTYPE:invalid_mandatory:CUSTOM(Scrubs_OneKey.Functions.fn_populated_strings>0)\n'
    + '\n'
    + 'FIELDTYPE:invalid_ok_wkp_id:CUSTOM(Scrubs_OneKey.Functions.fn_onekey_id>0)\n'
    + 'FIELDTYPE:invalid_frst_nm:CUSTOM(Scrubs_OneKey.Functions.fn_populated_strings>0,mid_nm,last_nm)\n'
    + 'FIELDTYPE:invalid_mid_nm:CUSTOM(Scrubs_OneKey.Functions.fn_populated_strings>0,frst_nm,last_nm)\n'
    + 'FIELDTYPE:invalid_last_nm:CUSTOM(Scrubs_OneKey.Functions.fn_populated_strings>0,frst_nm,mid_nm)\n'
    + 'FIELDTYPE:invalid_prim_prfsn_cd:CUSTOM(Scrubs_OneKey.Functions.fn_str1_xor_str2>0,prim_prfsn_desc)\n'
    + 'FIELDTYPE:invalid_prim_prfsn_desc:CUSTOM(Scrubs_OneKey.Functions.fn_str1_xor_str2>0,prim_prfsn_cd)\n'
    + 'FIELDTYPE:invalid_prim_spcl_cd:CUSTOM(Scrubs_OneKey.Functions.fn_str1_xor_str2>0,prim_spcl_desc)\n'
    + 'FIELDTYPE:invalid_prim_spcl_desc:CUSTOM(Scrubs_OneKey.Functions.fn_str1_xor_str2>0,prim_spcl_cd)\n'
    + 'FIELDTYPE:invalid_hce_prfsnl_stat_cd:CUSTOM(Scrubs_OneKey.Functions.fn_str1_xor_str2>0,hce_prfsnl_stat_desc)\n'
    + 'FIELDTYPE:invalid_hce_prfsnl_stat_desc:CUSTOM(Scrubs_OneKey.Functions.fn_str1_xor_str2>0,hce_prfsnl_stat_cd)\n'
    + 'FIELDTYPE:invalid_excld_rsn_desc:CUSTOM(Scrubs_OneKey.Functions.fn_str1_xor_str2>0,hce_prfsnl_stat_cd)\n'
    + 'FIELDTYPE:invalid_deactv_dt:CUSTOM(Scrubs_OneKey.Functions.fn_mm_dd_yyyy>0)\n'
    + 'FIELDTYPE:invalid_city_nm:CUSTOM(Scrubs_OneKey.Functions.fn_str1_xor_str2_xor_str3>0,st_cd,zip5_cd)\n'
    + 'FIELDTYPE:invalid_st_cd:CUSTOM(Scrubs_OneKey.Functions.fn_Valid_StateAbbrev>0)\n'
    + 'FIELDTYPE:invalid_zip5_cd:CUSTOM(Scrubs_OneKey.Functions.fn_numeric_optional>0,5)\n'
    + '\n'
    + '\n'
    + '//FIELD DEFINITIONS\n'
    + 'FIELD:hcp_hce_id:TYPE(STRING15):LIKE(invalid_numeric_nonzero):0,0\n'
    + 'FIELD:ok_indv_id:TYPE(STRING32):LIKE(invalid_ok_wkp_id):0,0\n'
    + 'FIELD:ska_uid:TYPE(STRING15):LIKE(invalid_numeric_nonzero):0,0\n'
    + 'FIELD:ims_id:TYPE(STRING7):0,0\n'
    + 'FIELD:frst_nm:TYPE(STRING40):LIKE(invalid_frst_nm):0,0\n'
    + 'FIELD:mid_nm:TYPE(STRING40):LIKE(invalid_mid_nm):0,0\n'
    + 'FIELD:last_nm:TYPE(STRING40):LIKE(invalid_last_nm):0,0\n'
    + 'FIELD:sfx_cd:TYPE(STRING10):0,0\n'
    + 'FIELD:gender_cd:TYPE(STRING10):0,0\n'
    + 'FIELD:prim_prfsn_cd:TYPE(STRING10):LIKE(invalid_prim_prfsn_cd):0,0\n'
    + 'FIELD:prim_prfsn_desc:TYPE(STRING50):LIKE(invalid_prim_prfsn_desc):0,0\n'
    + 'FIELD:prim_spcl_cd:TYPE(STRING10):LIKE(invalid_prim_spcl_cd):0,0\n'
    + 'FIELD:prim_spcl_desc:TYPE(STRING75):LIKE(invalid_prim_spcl_desc):0,0\n'
    + 'FIELD:hce_prfsnl_stat_cd:TYPE(STRING10):LIKE(invalid_hce_prfsnl_stat_cd):0,0\n'
    + 'FIELD:hce_prfsnl_stat_desc:TYPE(STRING50):LIKE(invalid_hce_prfsnl_stat_desc):0,0\n'
    + 'FIELD:excld_rsn_desc:TYPE(STRING150):LIKE(invalid_excld_rsn_desc):0,0\n'
    + 'FIELD:npi:TYPE(STRING25):0,0\n'
    + 'FIELD:deactv_dt:TYPE(STRING10):LIKE(invalid_deactv_dt):0,0\n'
    + 'FIELD:xref_hce_id:TYPE(STRING15):0,0\n'
    + 'FIELD:city_nm:TYPE(STRING50):LIKE(invalid_city_nm):0,0\n'
    + 'FIELD:st_cd:TYPE(STRING2):LIKE(invalid_st_cd):0,0\n'
    + 'FIELD:zip5_cd:TYPE(STRING5):LIKE(invalid_zip5_cd):0,0\n'
    + '// CONCEPT statements should be used to group together interellated fields; such as address\n'
    + '// RELATIONSHIP is used to find non-obvious relationships between the clusters\n'
    + '// SOURCEFIELD is used if a field of the file denotes a source of the records in that file\n'
    + '// LINKPATH is used to define access paths for external linking\n'
    ;
 
  // Structured values
  EXPORT linkpaths := DATASET([
    ],{STRING linkpath;STRING compulsory;STRING optional;STRING bonus;STRING required;STRING search});
 
END;

