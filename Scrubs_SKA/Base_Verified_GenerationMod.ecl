// Machine-readable versions of the spec file and subsets thereof
IMPORT SALT311;
EXPORT Base_Verified_GenerationMod := MODULE(SALT311.iGenerationMod)
 
  // SALT Version info
  EXPORT salt_VERSION := 'V3.11.6';
  EXPORT salt_MODULE := 'SALT311'; // Optional override by HACK:SALTMODULE
  EXPORT salt_TOOLSMODULE := 'SALTTOOLS30'; // Optional override by HACK:SALTTOOLSMODULE
 
  // Core module configuration values
  EXPORT spc_MODULE := 'Scrubs_SKA';
  EXPORT spc_NAMESCOPE := 'Base_Verified';
  EXPORT spc_PROCESS := '';
  EXPORT spc_PROCLAYOUTS := 'Process__Layouts';
  EXPORT spc_IDNAME := ''; // cluster id (input)
  EXPORT spc_IDFIELD := ''; // cluster id (output)
  EXPORT spc_RIDFIELD := ''; // record id
  EXPORT spc_CONFIG := 'Config';
  EXPORT spc_CONFIGPARAM := FALSE;
  EXPORT spc_SOURCEFIELD := '';
  EXPORT spc_FILEPREFIX := 'In_';
  EXPORT spc_FILENAME := 'SKA';
  EXPORT spc_INGESTSTATUS := '';
  EXPORT spc_EXTERNAL_MAPPING := 'UniqueID:';
  EXPORT spc_EXTERNAL_BATCH_PARAM := ',/* MY_ */,id_ska,bdid,ttl,first_name,middle,last_name,t1,do,deptcode,dept_expl,key_file,company1,address1,city,state,zip,address2,city2,state2,zip2,fips,phone,spec,spec_expl,spec2,spec2_expl,spec3,spec3_expl,persid,owner,emailavail,title,fname,mname,lname,name_suffix,name_score,mail_prim_range,mail_predir,mail_prim_name,mail_addr_suffix,mail_postdir,mail_unit_desig,mail_sec_range,mail_p_city_name,mail_v_city_name,mail_st,mail_zip,mail_zip4,mail_cart,mail_cr_sort_sz,mail_lot,mail_lot_order,mail_dbpc,mail_chk_digit,mail_rec_type,mail_ace_fips_state,mail_county,mail_geo_lat,mail_geo_long,mail_msa,mail_geo_blk,mail_geo_match,mail_err_stat,alt_prim_range,alt_predir,alt_prim_name,alt_addr_suffix,alt_postdir,alt_unit_desig,alt_sec_range,alt_p_city_name,alt_v_city_name,alt_st,alt_zip,alt_zip4,alt_cart,alt_cr_sort_sz,alt_lot,alt_lot_order,alt_dbpc,alt_chk_digit,alt_rec_type,alt_ace_fips_state,alt_county,alt_geo_lat,alt_geo_long,alt_msa,alt_geo_blk,alt_geo_match,alt_err_stat,lf,dotid,dotscore,dotweight,empid,empscore,empweight,powid,powscore,powweight,proxid,proxscore,proxweight,seleid,selescore,seleweight,orgid,orgscore,orgweight,ultid,ultscore,ultweight,source_rec_id';
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
    + 'MODULE:Scrubs_SKA\n'
    + 'FILENAME:SKA\n'
    + 'NAMESCOPE:Base_Verified\n'
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
    + '//FIELDTYPE DEFINITIONS\n'
    + 'FIELDTYPE:invalid_numeric:CUSTOM(Scrubs_SKA.Functions.fn_numeric>0)\n'
    + 'FIELDTYPE:invalid_mandatory:CUSTOM(Scrubs_SKA.Functions.fn_populated_strings>0)\n'
    + 'FIELDTYPE:invalid_boolean:ENUM(N|Y|)\n'
    + 'FIELDTYPE:invalid_pastdate8:CUSTOM(Scrubs_SKA.Functions.fn_past_yyyymmdd>0)\n'
    + 'FIELDTYPE:invalid_direction:ALLOW(ENSW)\n'
    + 'FIELDTYPE:invalid_geo_coord:CUSTOM(Scrubs_SKA.Functions.fn_geo_coord>0)\n'
    + '\n'
    + 'FIELDTYPE:invalid_deptcode:CUSTOM(Scrubs_SKA.Functions.fn_alpha_opt>0,3)\n'
    + 'FIELDTYPE:invalid_dept_expl:CUSTOM(Scrubs_SKA.Functions.fn_str1_xor_str2>0,deptcode)\n'
    + 'FIELDTYPE:invalid_state:CUSTOM(Scrubs_SKA.Functions.fn_verify_state>0)\n'
    + 'FIELDTYPE:invalid_zip:CUSTOM(Scrubs_SKA.Functions.fn_verify_zip>0)\n'
    + 'FIELDTYPE:invalid_address2:CUSTOM(Scrubs_SKA.Functions.fn_str1_only_if_str2>0,address1)\n'
    + 'FIELDTYPE:invalid_city2:CUSTOM(Scrubs_SKA.Functions.fn_str1_xor_str2>0,address2)\n'
    + 'FIELDTYPE:invalid_state2:CUSTOM(Scrubs_SKA.Functions.fn_str1_xor_str2>0,address2)\n'
    + 'FIELDTYPE:invalid_zip2:CUSTOM(Scrubs_SKA.Functions.fn_str1_xor_str2>0,address2)\n'
    + 'FIELDTYPE:invalid_fips:CUSTOM(Scrubs_SKA.Functions.fn_numeric>0,5)\n'
    + 'FIELDTYPE:invalid_phone:CUSTOM(Scrubs_SKA.Functions.fn_verify_phone>0)\n'
    + 'FIELDTYPE:invalid_spec:CUSTOM(Scrubs_SKA.Functions.fn_alpha_opt>0,3)\n'
    + 'FIELDTYPE:invalid_spec_expl:CUSTOM(Scrubs_SKA.Functions.fn_str1_xor_str2>0,spec)\n'
    + 'FIELDTYPE:invalid_spec2:CUSTOM(Scrubs_SKA.Functions.fn_alpha_opt>0,3)\n'
    + 'FIELDTYPE:invalid_spec2_expl:CUSTOM(Scrubs_SKA.Functions.fn_spec_expl>0,spec2)\n'
    + 'FIELDTYPE:invalid_spec3:CUSTOM(Scrubs_SKA.Functions.fn_alpha_opt>0,3)\n'
    + 'FIELDTYPE:invalid_spec3_expl:CUSTOM(Scrubs_SKA.Functions.fn_spec_expl>0,spec3)\n'
    + 'FIELDTYPE:invalid_owner:CUSTOM(Scrubs_SKA.Functions.fn_alpha>0,3)\n'
    + 'FIELDTYPE:invalid_mail_p_city_name:CUSTOM(Scrubs_SKA.Functions.fn_populated_strings>0,mail_v_city_name)\n'
    + 'FIELDTYPE:invalid_mail_v_city_name:CUSTOM(Scrubs_SKA.Functions.fn_populated_strings>0,mail_p_city_name)\n'
    + 'FIELDTYPE:invalid_mail_st:CUSTOM(Scrubs_SKA.Functions.fn_verify_state>0)\n'
    + 'FIELDTYPE:invalid_mail_zip:CUSTOM(Scrubs_SKA.Functions.fn_numeric>0,5)\n'
    + 'FIELDTYPE:invalid_mail_zip4:CUSTOM(Scrubs_SKA.Functions.fn_numeric_opt>0,4)\n'
    + 'FIELDTYPE:invalid_mail_ace_fips_state:CUSTOM(Scrubs_SKA.Functions.fn_numeric>0,2)\n'
    + 'FIELDTYPE:invalid_alt_prim_name:CUSTOM(Scrubs_SKA.Functions.fn_str1_xor_str2>0,address2)\n'
    + 'FIELDTYPE:invalid_alt_p_city_name:CUSTOM(Scrubs_SKA.Functions.fn_str1_xor_str2_xor_str3>0,alt_st,alt_zip)\n'
    + 'FIELDTYPE:invalid_alt_v_city_name:CUSTOM(Scrubs_SKA.Functions.fn_str1_xor_str2_xor_str3>0,alt_st,alt_zip)\n'
    + 'FIELDTYPE:invalid_alt_st:CUSTOM(Scrubs_SKA.Functions.fn_str1_xor_str2_xor_str3>0,alt_p_city_name,alt_zip)\n'
    + 'FIELDTYPE:invalid_alt_zip:CUSTOM(Scrubs_SKA.Functions.fn_str1_xor_str2_xor_str3>0,alt_v_city_name,alt_st)\n'
    + 'FIELDTYPE:invalid_alt_zip4:CUSTOM(Scrubs_SKA.Functions.fn_numeric_opt>0,4)\n'
    + 'FIELDTYPE:invalid_alt_ace_fips_state:CUSTOM(Scrubs_SKA.Functions.fn_numeric_opt>0,2)\n'
    + '\n'
    + '\n'
    + '//FIELD DEFINITIONS\n'
    + 'FIELD:id_ska:TYPE(STRING7):LIKE(invalid_numeric):0,0\n'
    + 'FIELD:bdid:TYPE(UNSIGNED6):LIKE(invalid_numeric):0,0\n'
    + 'FIELD:ttl:TYPE(STRING5):0,0\n'
    + 'FIELD:first_name:TYPE(STRING30):LIKE(invalid_mandatory):0,0\n'
    + 'FIELD:middle:TYPE(STRING1):0,0\n'
    + 'FIELD:last_name:TYPE(STRING30):LIKE(invalid_mandatory):0,0\n'
    + 'FIELD:t1:TYPE(STRING31):LIKE(invalid_mandatory):0,0\n'
    + 'FIELD:do:TYPE(STRING3):LIKE(invalid_boolean):0,0\n'
    + 'FIELD:deptcode:TYPE(STRING3):LIKE(invalid_deptcode):0,0\n'
    + 'FIELD:dept_expl:TYPE(STRING31):LIKE(invalid_dept_expl):0,0\n'
    + 'FIELD:key_file:TYPE(STRING40):0,0\n'
    + 'FIELD:company1:TYPE(STRING100):LIKE(invalid_mandatory):0,0\n'
    + 'FIELD:address1:TYPE(STRING80):LIKE(invalid_mandatory):0,0\n'
    + 'FIELD:city:TYPE(STRING30):LIKE(invalid_mandatory):0,0\n'
    + 'FIELD:state:TYPE(STRING2):LIKE(invalid_state):0,0\n'
    + 'FIELD:zip:TYPE(STRING10):LIKE(invalid_zip):0,0\n'
    + 'FIELD:address2:TYPE(STRING80):LIKE(invalid_address2):0,0\n'
    + 'FIELD:city2:TYPE(STRING30):LIKE(invalid_city2):0,0\n'
    + 'FIELD:state2:TYPE(STRING2):LIKE(invalid_state2):0,0\n'
    + 'FIELD:zip2:TYPE(STRING10):LIKE(invalid_zip2):0,0\n'
    + 'FIELD:fips:TYPE(STRING5):LIKE(invalid_fips):0,0\n'
    + 'FIELD:phone:TYPE(STRING12):LIKE(invalid_phone):0,0\n'
    + 'FIELD:spec:TYPE(STRING3):LIKE(invalid_spec):0,0\n'
    + 'FIELD:spec_expl:TYPE(STRING31):LIKE(invalid_spec_expl):0,0\n'
    + 'FIELD:spec2:TYPE(STRING3):LIKE(invalid_spec2):0,0\n'
    + 'FIELD:spec2_expl:TYPE(STRING40):LIKE(invalid_spec2_expl):0,0\n'
    + 'FIELD:spec3:TYPE(STRING3):LIKE(invalid_spec3):0,0\n'
    + 'FIELD:spec3_expl:TYPE(STRING40):LIKE(invalid_spec3_expl):0,0\n'
    + 'FIELD:persid:TYPE(STRING10):LIKE(invalid_numeric):0,0\n'
    + 'FIELD:owner:TYPE(STRING3):LIKE(invalid_owner):0,0\n'
    + 'FIELD:emailavail:TYPE(STRING1):LIKE(invalid_boolean):0,0\n'
    + 'FIELD:title:TYPE(STRING5):0,0\n'
    + 'FIELD:fname:TYPE(STRING20):LIKE(invalid_mandatory):0,0\n'
    + 'FIELD:mname:TYPE(STRING20):0,0\n'
    + 'FIELD:lname:TYPE(STRING20):LIKE(invalid_mandatory):0,0\n'
    + 'FIELD:name_suffix:TYPE(STRING5):0,0\n'
    + 'FIELD:name_score:TYPE(STRING3):0,0\n'
    + 'FIELD:mail_prim_range:TYPE(STRING10):0,0\n'
    + 'FIELD:mail_predir:TYPE(STRING2):LIKE(invalid_direction):0,0\n'
    + 'FIELD:mail_prim_name:TYPE(STRING28):LIKE(invalid_mandatory):0,0\n'
    + 'FIELD:mail_addr_suffix:TYPE(STRING4):0,0\n'
    + 'FIELD:mail_postdir:TYPE(STRING2):LIKE(invalid_direction):0,0\n'
    + 'FIELD:mail_unit_desig:TYPE(STRING10):0,0\n'
    + 'FIELD:mail_sec_range:TYPE(STRING8):0,0\n'
    + 'FIELD:mail_p_city_name:TYPE(STRING25):LIKE(invalid_mail_p_city_name):0,0\n'
    + 'FIELD:mail_v_city_name:TYPE(STRING25):LIKE(invalid_mail_v_city_name):0,0\n'
    + 'FIELD:mail_st:TYPE(STRING2):LIKE(invalid_mail_st):0,0\n'
    + 'FIELD:mail_zip:TYPE(STRING5):LIKE(invalid_mail_zip):0,0\n'
    + 'FIELD:mail_zip4:TYPE(STRING4):LIKE(invalid_mail_zip4):0,0\n'
    + 'FIELD:mail_cart:TYPE(STRING4):0,0\n'
    + 'FIELD:mail_cr_sort_sz:TYPE(STRING1):0,0\n'
    + 'FIELD:mail_lot:TYPE(STRING4):0,0\n'
    + 'FIELD:mail_lot_order:TYPE(STRING1):0,0\n'
    + 'FIELD:mail_dbpc:TYPE(STRING2):0,0\n'
    + 'FIELD:mail_chk_digit:TYPE(STRING1):0,0\n'
    + 'FIELD:mail_rec_type:TYPE(STRING2):0,0\n'
    + 'FIELD:mail_ace_fips_state:TYPE(STRING2):LIKE(invalid_mail_ace_fips_state):0,0\n'
    + 'FIELD:mail_county:TYPE(STRING3):0,0\n'
    + 'FIELD:mail_geo_lat:TYPE(STRING10):LIKE(invalid_geo_coord):0,0\n'
    + 'FIELD:mail_geo_long:TYPE(STRING11):LIKE(invalid_geo_coord):0,0\n'
    + 'FIELD:mail_msa:TYPE(STRING4):0,0\n'
    + 'FIELD:mail_geo_blk:TYPE(STRING7):0,0\n'
    + 'FIELD:mail_geo_match:TYPE(STRING1):0,0\n'
    + 'FIELD:mail_err_stat:TYPE(STRING4):0,0\n'
    + 'FIELD:alt_prim_range:TYPE(STRING10):0,0\n'
    + 'FIELD:alt_predir:TYPE(STRING2):LIKE(invalid_direction):0,0\n'
    + 'FIELD:alt_prim_name:TYPE(STRING28):LIKE(invalid_alt_prim_name):0,0\n'
    + 'FIELD:alt_addr_suffix:TYPE(STRING4):0,0\n'
    + 'FIELD:alt_postdir:TYPE(STRING2):LIKE(invalid_direction):0,0\n'
    + 'FIELD:alt_unit_desig:TYPE(STRING10):0,0\n'
    + 'FIELD:alt_sec_range:TYPE(STRING8):0,0\n'
    + 'FIELD:alt_p_city_name:TYPE(STRING25):LIKE(invalid_alt_p_city_name):0,0\n'
    + 'FIELD:alt_v_city_name:TYPE(STRING25):LIKE(invalid_alt_v_city_name):0,0\n'
    + 'FIELD:alt_st:TYPE(STRING2):LIKE(invalid_alt_st):0,0\n'
    + 'FIELD:alt_zip:TYPE(STRING5):LIKE(invalid_alt_zip):0,0\n'
    + 'FIELD:alt_zip4:TYPE(STRING4):LIKE(invalid_alt_zip4):0,0\n'
    + 'FIELD:alt_cart:TYPE(STRING4):0,0\n'
    + 'FIELD:alt_cr_sort_sz:TYPE(STRING1):0,0\n'
    + 'FIELD:alt_lot:TYPE(STRING4):0,0\n'
    + 'FIELD:alt_lot_order:TYPE(STRING1):0,0\n'
    + 'FIELD:alt_dbpc:TYPE(STRING2):0,0\n'
    + 'FIELD:alt_chk_digit:TYPE(STRING1):0,0\n'
    + 'FIELD:alt_rec_type:TYPE(STRING2):0,0\n'
    + 'FIELD:alt_ace_fips_state:TYPE(STRING2):LIKE(invalid_alt_ace_fips_state):0,0\n'
    + 'FIELD:alt_county:TYPE(STRING3):0,0\n'
    + 'FIELD:alt_geo_lat:TYPE(STRING10):0,0\n'
    + 'FIELD:alt_geo_long:TYPE(STRING11):0,0\n'
    + 'FIELD:alt_msa:TYPE(STRING4):0,0\n'
    + 'FIELD:alt_geo_blk:TYPE(STRING7):0,0\n'
    + 'FIELD:alt_geo_match:TYPE(STRING1):0,0\n'
    + 'FIELD:alt_err_stat:TYPE(STRING4):0,0\n'
    + 'FIELD:lf:TYPE(STRING1):0,0\n'
    + 'FIELD:dotid:TYPE(UNSIGNED6):0,0\n'
    + 'FIELD:dotscore:TYPE(UNSIGNED2):0,0\n'
    + 'FIELD:dotweight:TYPE(UNSIGNED2):0,0\n'
    + 'FIELD:empid:TYPE(UNSIGNED6):0,0\n'
    + 'FIELD:empscore:TYPE(UNSIGNED2):0,0\n'
    + 'FIELD:empweight:TYPE(UNSIGNED2):0,0\n'
    + 'FIELD:powid:TYPE(UNSIGNED6):0,0\n'
    + 'FIELD:powscore:TYPE(UNSIGNED2):0,0\n'
    + 'FIELD:powweight:TYPE(UNSIGNED2):0,0\n'
    + 'FIELD:proxid:TYPE(UNSIGNED6):0,0\n'
    + 'FIELD:proxscore:TYPE(UNSIGNED2):0,0\n'
    + 'FIELD:proxweight:TYPE(UNSIGNED2):0,0\n'
    + 'FIELD:seleid:TYPE(UNSIGNED6):0,0\n'
    + 'FIELD:selescore:TYPE(UNSIGNED2):0,0\n'
    + 'FIELD:seleweight:TYPE(UNSIGNED2):0,0\n'
    + 'FIELD:orgid:TYPE(UNSIGNED6):0,0\n'
    + 'FIELD:orgscore:TYPE(UNSIGNED2):0,0\n'
    + 'FIELD:orgweight:TYPE(UNSIGNED2):0,0\n'
    + 'FIELD:ultid:TYPE(UNSIGNED6):0,0\n'
    + 'FIELD:ultscore:TYPE(UNSIGNED2):0,0\n'
    + 'FIELD:ultweight:TYPE(UNSIGNED2):0,0\n'
    + 'FIELD:source_rec_id:TYPE(UNSIGNED8):LIKE(invalid_numeric):0,0\n'
    + '// CONCEPT statements should be used to group together interellated fields; such as address\n'
    + '// RELATIONSHIP is used to find non-obvious relationships between the clusters\n'
    + '// SOURCEFIELD is used if a field of the file denotes a source of the records in that file\n'
    + '// LINKPATH is used to define access paths for external linking\n'
    + '\n'
    ;
 
  // Structured values
  EXPORT linkpaths := DATASET([
    ],{STRING linkpath;STRING compulsory;STRING optional;STRING bonus;STRING required;STRING search});
 
END;

