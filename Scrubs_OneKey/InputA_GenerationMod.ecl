// Machine-readable versions of the spec file and subsets thereof
IMPORT SALT311;
EXPORT InputA_GenerationMod := MODULE(SALT311.iGenerationMod)
 
  // SALT Version info
  EXPORT salt_VERSION := 'V3.11.11';
  EXPORT salt_MODULE := 'SALT311'; // Optional override by HACK:SALTMODULE
  EXPORT salt_TOOLSMODULE := 'SALTTOOLS30'; // Optional override by HACK:SALTTOOLSMODULE
 
  // Core module configuration values
  EXPORT spc_MODULE := 'Scrubs_OneKey';
  EXPORT spc_NAMESCOPE := 'InputA';
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
  EXPORT spc_EXTERNAL_BATCH_PARAM := ',/* MY_ */,hcp_hce_id,ok_indv_id,ska_uid,frst_nm,mid_nm,last_nm,sfx_cd,gender_cd,prim_prfsn_cd,prim_prfsn_desc,prim_spcl_cd,prim_spcl_desc,sec_spcl_cd,sec_spcl_desc,tert_spcl_cd,tert_spcl_desc,sub_spcl_cd,sub_spcl_desc,titl_typ_id,titl_typ_desc,hco_hce_id,ok_wkp_id,ska_id,bus_nm,dba_nm,addr_id,str_front_id,addr_ln_1_txt,addr_ln_2_txt,city_nm,st_cd,zip5_cd,zip4_cd,fips_cnty_cd,fips_cnty_desc,telephn_nbr,cot_id,cot_clas_id,cot_clas_desc,cot_fclt_typ_id,cot_fclt_typ_desc,cot_spcl_id,cot_spcl_desc,email_ind_flag,hcp_affil_xid,delta_cd';
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
    + 'NAMESCOPE:InputA\n'
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
    + 'FIELDTYPE:invalid_source:ENUM(SK|09)\n'
    + 'FIELDTYPE:invalid_record_type:ENUM(C|H)\n'
    + 'FIELDTYPE:invalid_frst_nm:CUSTOM(Scrubs_OneKey.Functions.fn_populated_strings>0,mid_nm,last_nm)\n'
    + 'FIELDTYPE:invalid_mid_nm:CUSTOM(Scrubs_OneKey.Functions.fn_populated_strings>0,frst_nm,last_nm)\n'
    + 'FIELDTYPE:invalid_last_nm:CUSTOM(Scrubs_OneKey.Functions.fn_populated_strings>0,frst_nm,mid_nm)\n'
    + 'FIELDTYPE:invalid_prim_prfsn_cd:CUSTOM(Scrubs_OneKey.Functions.fn_str1_xor_str2>0,prim_prfsn_desc)\n'
    + 'FIELDTYPE:invalid_prim_prfsn_desc:CUSTOM(Scrubs_OneKey.Functions.fn_str1_xor_str2>0,prim_prfsn_cd)\n'
    + 'FIELDTYPE:invalid_prim_spcl_cd:CUSTOM(Scrubs_OneKey.Functions.fn_str1_xor_str2>0,prim_spcl_desc)\n'
    + 'FIELDTYPE:invalid_prim_spcl_desc:CUSTOM(Scrubs_OneKey.Functions.fn_str1_xor_str2>0,prim_spcl_cd)\n'
    + 'FIELDTYPE:invalid_sec_spcl_cd:CUSTOM(Scrubs_OneKey.Functions.fn_str1_xor_str2>0,sec_spcl_desc)\n'
    + 'FIELDTYPE:invalid_sec_spcl_desc:CUSTOM(Scrubs_OneKey.Functions.fn_str1_xor_str2>0,sec_spcl_cd)\n'
    + 'FIELDTYPE:invalid_tert_spcl_cd:CUSTOM(Scrubs_OneKey.Functions.fn_str1_xor_str2>0,tert_spcl_desc)\n'
    + 'FIELDTYPE:invalid_tert_spcl_desc:CUSTOM(Scrubs_OneKey.Functions.fn_str1_xor_str2>0,tert_spcl_cd)\n'
    + 'FIELDTYPE:invalid_sub_spcl_cd:CUSTOM(Scrubs_OneKey.Functions.fn_str1_xor_str2>0,sub_spcl_desc)\n'
    + 'FIELDTYPE:invalid_sub_spcl_desc:CUSTOM(Scrubs_OneKey.Functions.fn_str1_xor_str2>0,sub_spcl_cd)\n'
    + 'FIELDTYPE:invalid_titl_typ_id:CUSTOM(Scrubs_OneKey.Functions.fn_str1_xor_str2>0,titl_typ_desc)\n'
    + 'FIELDTYPE:invalid_titl_typ_desc:CUSTOM(Scrubs_OneKey.Functions.fn_str1_xor_str2>0,titl_typ_id)\n'
    + 'FIELDTYPE:invalid_ok_wkp_id:CUSTOM(Scrubs_OneKey.Functions.fn_onekey_id>0)\n'
    + 'FIELDTYPE:invalid_city_nm:CUSTOM(Scrubs_OneKey.Functions.fn_populated_strings>0)\n'
    + 'FIELDTYPE:invalid_st_cd:CUSTOM(Scrubs_OneKey.Functions.fn_Valid_StateAbbrev>0)\n'
    + 'FIELDTYPE:invalid_zip5_cd:CUSTOM(Scrubs_OneKey.Functions.fn_numeric>0,5)\n'
    + 'FIELDTYPE:invalid_hcp_affil_xid:CUSTOM(Scrubs_OneKey.Functions.fn_hcp_affil_xid>0,hcp_hce_id,hco_hce_id,titl_typ_id)\n'
    + 'FIELDTYPE:invalid_delta_cd:ENUM(D|I|U|)\n'
    + '\n'
    + '\n'
    + '//FIELD DEFINITIONS\n'
    + 'FIELD:hcp_hce_id:TYPE(STRING15):LIKE(invalid_numeric_nonzero):0,0\n'
    + 'FIELD:ok_indv_id:TYPE(STRING32):0,0\n'
    + 'FIELD:ska_uid:TYPE(STRING15):0,0\n'
    + 'FIELD:frst_nm:TYPE(STRING40):LIKE(invalid_frst_nm):0,0\n'
    + 'FIELD:mid_nm:TYPE(STRING40):LIKE(invalid_mid_nm):0,0\n'
    + 'FIELD:last_nm:TYPE(STRING40):LIKE(invalid_last_nm):0,0\n'
    + 'FIELD:sfx_cd:TYPE(STRING10):0,0\n'
    + 'FIELD:gender_cd:TYPE(STRING10):0,0\n'
    + 'FIELD:prim_prfsn_cd:TYPE(STRING10):LIKE(invalid_prim_prfsn_cd):0,0\n'
    + 'FIELD:prim_prfsn_desc:TYPE(STRING50):LIKE(invalid_prim_prfsn_desc):0,0\n'
    + 'FIELD:prim_spcl_cd:TYPE(STRING10):LIKE(invalid_prim_spcl_cd):0,0\n'
    + 'FIELD:prim_spcl_desc:TYPE(STRING75):LIKE(invalid_prim_spcl_desc):0,0\n'
    + 'FIELD:sec_spcl_cd:TYPE(STRING10):LIKE(invalid_sec_spcl_cd):0,0\n'
    + 'FIELD:sec_spcl_desc:TYPE(STRING75):LIKE(invalid_sec_spcl_desc):0,0\n'
    + 'FIELD:tert_spcl_cd:TYPE(STRING10):LIKE(invalid_tert_spcl_cd):0,0\n'
    + 'FIELD:tert_spcl_desc:TYPE(STRING75):LIKE(invalid_tert_spcl_desc):0,0\n'
    + 'FIELD:sub_spcl_cd:TYPE(STRING10):LIKE(invalid_sub_spcl_cd):0,0\n'
    + 'FIELD:sub_spcl_desc:TYPE(STRING50):LIKE(invalid_sub_spcl_desc):0,0\n'
    + 'FIELD:titl_typ_id:TYPE(STRING10):LIKE(invalid_titl_typ_id):0,0\n'
    + 'FIELD:titl_typ_desc:TYPE(STRING50):LIKE(invalid_titl_typ_desc):0,0\n'
    + 'FIELD:hco_hce_id:TYPE(STRING15):LIKE(invalid_numeric_nonzero):0,0\n'
    + 'FIELD:ok_wkp_id:TYPE(STRING35):LIKE(invalid_ok_wkp_id):0,0\n'
    + 'FIELD:ska_id:TYPE(STRING15):LIKE(invalid_numeric_nonzero):0,0\n'
    + 'FIELD:bus_nm:TYPE(STRING150):LIKE(invalid_mandatory):0,0\n'
    + 'FIELD:dba_nm:TYPE(STRING150):0,0\n'
    + 'FIELD:addr_id:TYPE(STRING10):0,0\n'
    + 'FIELD:str_front_id:TYPE(STRING10):0,0\n'
    + 'FIELD:addr_ln_1_txt:TYPE(STRING80):0,0\n'
    + 'FIELD:addr_ln_2_txt:TYPE(STRING80):0,0\n'
    + 'FIELD:city_nm:TYPE(STRING50):LIKE(invalid_city_nm):0,0\n'
    + 'FIELD:st_cd:TYPE(STRING2):LIKE(invalid_st_cd):0,0\n'
    + 'FIELD:zip5_cd:TYPE(STRING5):LIKE(invalid_zip5_cd):0,0\n'
    + 'FIELD:zip4_cd:TYPE(STRING4):0,0\n'
    + 'FIELD:fips_cnty_cd:TYPE(STRING10):0,0\n'
    + 'FIELD:fips_cnty_desc:TYPE(STRING50):0,0\n'
    + 'FIELD:telephn_nbr:TYPE(STRING15):0,0\n'
    + 'FIELD:cot_id:TYPE(STRING15):0,0\n'
    + 'FIELD:cot_clas_id:TYPE(STRING15):0,0\n'
    + 'FIELD:cot_clas_desc:TYPE(STRING50):0,0\n'
    + 'FIELD:cot_fclt_typ_id:TYPE(STRING15):0,0\n'
    + 'FIELD:cot_fclt_typ_desc:TYPE(STRING50):0,0\n'
    + 'FIELD:cot_spcl_id:TYPE(STRING15):0,0\n'
    + 'FIELD:cot_spcl_desc:TYPE(STRING50):0,0\n'
    + 'FIELD:email_ind_flag:TYPE(STRING1):0,0\n'
    + 'FIELD:hcp_affil_xid:TYPE(STRING50):LIKE(invalid_hcp_affil_xid):0,0\n'
    + 'FIELD:delta_cd:TYPE(STRING1):LIKE(invalid_delta_cd):0,0\n'
    + '// CONCEPT statements should be used to group together interellated fields; such as address\n'
    + '// RELATIONSHIP is used to find non-obvious relationships between the clusters\n'
    + '// SOURCEFIELD is used if a field of the file denotes a source of the records in that file\n'
    + '// LINKPATH is used to define access paths for external linking\n'
    ;
 
  // Structured values
  EXPORT linkpaths := DATASET([
    ],{STRING linkpath;STRING compulsory;STRING optional;STRING bonus;STRING required;STRING search});
 
END;

