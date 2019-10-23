// Machine-readable versions of the spec file and subsets thereof
IMPORT SALT310;
EXPORT Base_GenerationMod := MODULE(SALT310.iGenerationMod)
 
  // SALT Version info
  EXPORT salt_VERSION := 'V3.10.1';
  EXPORT salt_MODULE := 'SALT310'; // Optional override by HACK:SALTMODULE
  EXPORT salt_TOOLSMODULE := 'SALTTOOLS30'; // Optional override by HACK:SALTTOOLSMODULE
 
  // Core module configuration values
  EXPORT spc_MODULE := 'Scrubs_QA_Data';
  EXPORT spc_NAMESCOPE := 'Base';
  EXPORT spc_PROCESS := '';
  EXPORT spc_PROCLAYOUTS := 'Process__Layouts';
  EXPORT spc_IDNAME := ''; // cluster id (input)
  EXPORT spc_IDFIELD := ''; // cluster id (output)
  EXPORT spc_RIDFIELD := ''; // record id
  EXPORT spc_CONFIG := 'Config';
  EXPORT spc_CONFIGPARAM := FALSE;
  EXPORT spc_SOURCEFIELD := '';
  EXPORT spc_FILEPREFIX := 'In_';
  EXPORT spc_FILENAME := 'QA_Data';
  EXPORT spc_INGESTSTATUS := '';
  EXPORT spc_EXTERNAL_MAPPING := 'UniqueID:';
  EXPORT spc_EXTERNAL_BATCH_PARAM := ',/* MY_ */,powid,proxid,seleid,orgid,ultid,did,dt_first_seen,dt_last_seen,dt_vendor_first_reported,dt_vendor_last_reported,record_type,rawtrans_masteraddressid,rawtrans_date,rawtrans_category,rawaddr_databasematchcode,rawaddr_homebusinessflag,rawaddr_masteraddressid,prep_trans_line1,prep_trans_line_last,prep_addr_line1,prep_addr_line_last,trans_address_prim_name,trans_address_p_city_name,trans_address_v_city_name,trans_address_st,trans_address_zip,addr_address_prim_name,addr_address_p_city_name,addr_address_v_city_name,addr_address_st,addr_address_zip,clean_person_type,clean_person_name_fname,clean_person_name_lname,clean_phone,clean_company,nametype,source_rec_id';
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
    + 'MODULE:Scrubs_QA_Data\n'
    + 'FILENAME:QA_Data\n'
    + 'NAMESCOPE:Base \n'
    + '\n'
    + '//--------------------------\n'
    + '//FIELDTYPE DEFINITIONS\n'
    + '//--------------------------\n'
    + 'FIELDTYPE:invalid_mandatory:LENGTHS(1..)\n'
    + 'FIELDTYPE:invalid_pastdate8:CUSTOM(Scrubs_QA_Data.Functions.fn_past_yyyymmdd > 0)\n'
    + 'FIELDTYPE:invalid_date_time:CUSTOM(Scrubs_QA_Data.Functions.fn_date_time > 0)\n'
    + 'FIELDTYPE:invalid_record_type:ENUM(C|H)\n'
    + 'FIELDTYPE:invalid_numeric:CUSTOM(Scrubs_QA_Data.Functions.fn_numeric > 0)\n'
    + 'FIELDTYPE:invalid_numeric_or_blank:CUSTOM(Scrubs_QA_Data.Functions.fn_numeric_or_blank > 0)\n'
    + 'FIELDTYPE:invalid_db_match:ENUM(I|B|L| )\n'
    + 'FIELDTYPE:invalid_home_business:ENUM(Y|N| )\n'
    + 'FIELDTYPE:invalid_st:CUSTOM(Scrubs_QA_Data.Functions.fn_verify_state>0)\n'
    + 'FIELDTYPE:invalid_zip5:CUSTOM(Scrubs_QA_Data.Functions.fn_numeric>0,5)\n'
    + 'FIELDTYPE:invalid_person_type:ENUM(AC|AP|TC|TP| )\n'
    + 'FIELDTYPE:invalid_alphanum_specials:ALLOW(0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZ @#-:./,`&\'Ã£Ã±Ã¨Ã³Ã©Ã Ã‚Ã¡Ã”Ã­Ã¶Ã‹Ãº)\n'
    + 'FIELDTYPE:invalid_phone:CUSTOM(Scrubs_QA_Data.Functions.fn_verify_optional_phone>0)\n'
    + 'FIELDTYPE:invalid_nametype:ENUM(B| )\n'
    + 'FIELDTYPE:invalid_src_rid:CUSTOM(Scrubs_QA_Data.Functions.fn_src_rid > 0)\n'
    + '\n'
    + '//--------------------------------------------------------------- \n'
    + '//FIELDS TO SCRUB -- Commented out fields are not being scrubbed\n'
    + '//---------------------------------------------------------------\n'
    + '// FIELD:dotid:TYPE(UNSIGNED6):0,0\n'
    + '// FIELD:dotscore:TYPE(UNSIGNED2):0,0\n'
    + '// FIELD:dotweight:TYPE(UNSIGNED2):0,0\n'
    + '// FIELD:empid:TYPE(UNSIGNED6):0,0\n'
    + '// FIELD:empscore:TYPE(UNSIGNED2):0,0\n'
    + '// FIELD:empweight:TYPE(UNSIGNED2):0,0\n'
    + 'FIELD:powid:TYPE(UNSIGNED6):LIKE(invalid_mandatory):0,0\n'
    + '// FIELD:powscore:TYPE(UNSIGNED2):0,0\n'
    + '// FIELD:powweight:TYPE(UNSIGNED2):0,0\n'
    + 'FIELD:proxid:TYPE(UNSIGNED6):LIKE(invalid_mandatory):0,0\n'
    + '// FIELD:proxscore:TYPE(UNSIGNED2):0,0\n'
    + '// FIELD:proxweight:TYPE(UNSIGNED2):0,0\n'
    + 'FIELD:seleid:TYPE(UNSIGNED6):LIKE(invalid_mandatory):0,0\n'
    + '// FIELD:selescore:TYPE(UNSIGNED2):0,0\n'
    + '// FIELD:seleweight:TYPE(UNSIGNED2):0,0\n'
    + 'FIELD:orgid:TYPE(UNSIGNED6):LIKE(invalid_mandatory):0,0\n'
    + '// FIELD:orgscore:TYPE(UNSIGNED2):0,0\n'
    + '// FIELD:orgweight:TYPE(UNSIGNED2):0,0\n'
    + 'FIELD:ultid:TYPE(UNSIGNED6):LIKE(invalid_mandatory):0,0\n'
    + '// FIELD:ultscore:TYPE(UNSIGNED2):0,0\n'
    + '// FIELD:ultweight:TYPE(UNSIGNED2):0,0\n'
    + 'FIELD:did:TYPE(UNSIGNED6):LIKE(invalid_mandatory):0,0\n'
    + '// FIELD:did_score:TYPE(UNSIGNED1):0,0\n'
    + 'FIELD:dt_first_seen:TYPE(UNSIGNED4):LIKE(invalid_pastdate8):0,0\n'
    + 'FIELD:dt_last_seen:TYPE(UNSIGNED4):LIKE(invalid_pastdate8):0,0\n'
    + 'FIELD:dt_vendor_first_reported:TYPE(UNSIGNED4):LIKE(invalid_pastdate8):0,0\n'
    + 'FIELD:dt_vendor_last_reported:TYPE(UNSIGNED4):LIKE(invalid_pastdate8):0,0\n'
    + 'FIELD:record_type:TYPE(STRING1):LIKE(invalid_record_type):0,0\n'
    + 'FIELD:rawtrans_masteraddressid:TYPE(STRING):LIKE(invalid_numeric_or_blank):0,0\n'
    + 'FIELD:rawtrans_date:TYPE(STRING):LIKE(invalid_date_time):0,0\n'
    + 'FIELD:rawtrans_category:TYPE(STRING):LIKE(invalid_mandatory):0,0\n'
    + '// FIELD:rawtrans_subcategory:TYPE(STRING):0,0\n'
    + '// FIELD:rawtrans_name:TYPE(STRING):0,0\n'
    + '// FIELD:rawtrans_company:TYPE(STRING):0,0\n'
    + '// FIELD:rawtrans_addressone:TYPE(STRING):0,0\n'
    + '// FIELD:rawtrans_addresstwo:TYPE(STRING):0,0\n'
    + '// FIELD:rawtrans_city:TYPE(STRING):0,0\n'
    + '// FIELD:rawtrans_state:TYPE(STRING):0,0\n'
    + '// FIELD:rawtrans_postalcode:TYPE(STRING):0,0\n'
    + '// FIELD:rawaddr_firstname:TYPE(STRING):0,0\n'
    + '// FIELD:rawaddr_middleinitial:TYPE(STRING):0,0\n'
    + '// FIELD:rawaddr_lastname:TYPE(STRING):0,0\n'
    + '// FIELD:rawaddr_company:TYPE(STRING):0,0\n'
    + '// FIELD:rawaddr_other:TYPE(STRING):0,0\n'
    + '// FIELD:rawaddr_phone:TYPE(STRING):0,0\n'
    + 'FIELD:rawaddr_databasematchcode:TYPE(STRING):LIKE(invalid_db_match):0,0\n'
    + 'FIELD:rawaddr_homebusinessflag:TYPE(STRING):LIKE(invalid_home_business):0,0\n'
    + '// FIELD:rawaddr_addressone:TYPE(STRING):0,0\n'
    + '// FIELD:rawaddr_addresstwo:TYPE(STRING):0,0\n'
    + '// FIELD:rawaddr_streetnumber:TYPE(STRING):0,0\n'
    + '// FIELD:rawaddr_predirection:TYPE(STRING):0,0\n'
    + '// FIELD:rawaddr_streetname:TYPE(STRING):0,0\n'
    + '// FIELD:rawaddr_streettype:TYPE(STRING):0,0\n'
    + '// FIELD:rawaddr_postdirection:TYPE(STRING):0,0\n'
    + '// FIELD:rawaddr_extension:TYPE(STRING):0,0\n'
    + '// FIELD:rawaddr_extensionnumber:TYPE(STRING):0,0\n'
    + '// FIELD:rawaddr_village:TYPE(STRING):0,0\n'
    + '// FIELD:rawaddr_city:TYPE(STRING):0,0\n'
    + '// FIELD:rawaddr_state:TYPE(STRING):0,0\n'
    + '// FIELD:rawaddr_zipplus4:TYPE(STRING):0,0\n'
    + '// FIELD:rawaddr_zipcode:TYPE(STRING):0,0\n'
    + '// FIELD:rawaddr_zipaddon:TYPE(STRING):0,0\n'
    + '// FIELD:rawaddr_carrierroute:TYPE(STRING):0,0\n'
    + '// FIELD:rawaddr_pmb:TYPE(STRING):0,0\n'
    + '// FIELD:rawaddr_pmbdesignator:TYPE(STRING):0,0\n'
    + '// FIELD:rawaddr_deliverypoint:TYPE(STRING):0,0\n'
    + '// FIELD:rawaddr_deliverypointcheckdigit:TYPE(STRING):0,0\n'
    + '// FIELD:rawaddr_cmra:TYPE(STRING):0,0\n'
    + '// FIELD:rawaddr_dpv:TYPE(STRING):0,0\n'
    + '// FIELD:rawaddr_dpvfootnote:TYPE(STRING):0,0\n'
    + '// FIELD:rawaddr_congressdistrict:TYPE(STRING):0,0\n'
    + '// FIELD:rawaddr_county:TYPE(STRING):0,0\n'
    + '// FIELD:rawaddr_countynumber:TYPE(STRING):0,0\n'
    + '// FIELD:rawaddr_statenumber:TYPE(STRING):0,0\n'
    + '// FIELD:rawaddr_latitude:TYPE(STRING):0,0\n'
    + '// FIELD:rawaddr_longitude:TYPE(STRING):0,0\n'
    + '// FIELD:rawaddr_censustract:TYPE(STRING):0,0\n'
    + '// FIELD:rawaddr_blocknumber:TYPE(STRING):0,0\n'
    + '// FIELD:rawaddr_blockgroup:TYPE(STRING):0,0\n'
    + 'FIELD:rawaddr_masteraddressid:TYPE(STRING):LIKE(invalid_numeric):0,0\n'
    + '// FIELD:trans_rawaid:TYPE(UNSIGNED8):0,0\n'
    + '// FIELD:trans_aceaid:TYPE(UNSIGNED8):0,0\n'
    + '// FIELD:addr_rawaid:TYPE(UNSIGNED8):0,0\n'
    + '// FIELD:addr_aceaid:TYPE(UNSIGNED8):0,0\n'
    + 'FIELD:prep_trans_line1:TYPE(STRING100):LIKE(invalid_mandatory):0,0\n'
    + 'FIELD:prep_trans_line_last:TYPE(STRING50):LIKE(invalid_mandatory):0,0\n'
    + 'FIELD:prep_addr_line1:TYPE(STRING100):LIKE(invalid_mandatory):0,0\n'
    + 'FIELD:prep_addr_line_last:TYPE(STRING50):LIKE(invalid_mandatory):0,0\n'
    + '// FIELD:trans_address_prim_range:TYPE(STRING10):0,0\n'
    + '// FIELD:trans_address_predir:TYPE(STRING2):0,0\n'
    + 'FIELD:trans_address_prim_name:TYPE(STRING28):LIKE(invalid_mandatory):0,0\n'
    + '// FIELD:trans_address_addr_suffix:TYPE(STRING4):0,0\n'
    + '// FIELD:trans_address_postdir:TYPE(STRING2):0,0\n'
    + '// FIELD:trans_address_unit_desig:TYPE(STRING10):0,0\n'
    + '// FIELD:trans_address_sec_range:TYPE(STRING8):0,0\n'
    + 'FIELD:trans_address_p_city_name:TYPE(STRING25):LIKE(invalid_mandatory):0,0\n'
    + 'FIELD:trans_address_v_city_name:TYPE(STRING25):LIKE(invalid_mandatory):0,0\n'
    + 'FIELD:trans_address_st:TYPE(STRING2):LIKE(invalid_st):0,0\n'
    + 'FIELD:trans_address_zip:TYPE(STRING5):LIKE(invalid_zip5):0,0\n'
    + '// FIELD:trans_address_zip4:TYPE(STRING4):0,0\n'
    + '// FIELD:trans_address_cart:TYPE(STRING4):0,0\n'
    + '// FIELD:trans_address_cr_sort_sz:TYPE(STRING1):0,0\n'
    + '// FIELD:trans_address_lot:TYPE(STRING4):0,0\n'
    + '// FIELD:trans_address_lot_order:TYPE(STRING1):0,0\n'
    + '// FIELD:trans_address_dbpc:TYPE(STRING2):0,0\n'
    + '// FIELD:trans_address_chk_digit:TYPE(STRING1):0,0\n'
    + '// FIELD:trans_address_rec_type:TYPE(STRING2):0,0\n'
    + '// FIELD:trans_address_fips_state:TYPE(STRING2):0,0\n'
    + '// FIELD:trans_address_fips_county:TYPE(STRING3):0,0\n'
    + '// FIELD:trans_address_geo_lat:TYPE(STRING10):0,0\n'
    + '// FIELD:trans_address_geo_long:TYPE(STRING11):0,0\n'
    + '// FIELD:trans_address_msa:TYPE(STRING4):0,0\n'
    + '// FIELD:trans_address_geo_blk:TYPE(STRING7):0,0\n'
    + '// FIELD:trans_address_geo_match:TYPE(STRING1):0,0\n'
    + '// FIELD:trans_address_err_stat:TYPE(STRING4):0,0\n'
    + '// FIELD:trans_address_fips_state_county:TYPE(STRING5):0,0\n'
    + '// FIELD:addr_address_prim_range:TYPE(STRING10):0,0\n'
    + '// FIELD:addr_address_predir:TYPE(STRING2):0,0\n'
    + 'FIELD:addr_address_prim_name:TYPE(STRING28):LIKE(invalid_mandatory):0,0\n'
    + '// FIELD:addr_address_addr_suffix:TYPE(STRING4):0,0\n'
    + '// FIELD:addr_address_postdir:TYPE(STRING2):0,0\n'
    + '// FIELD:addr_address_unit_desig:TYPE(STRING10):0,0\n'
    + '// FIELD:addr_address_sec_range:TYPE(STRING8):0,0\n'
    + 'FIELD:addr_address_p_city_name:TYPE(STRING25):LIKE(invalid_mandatory):0,0\n'
    + 'FIELD:addr_address_v_city_name:TYPE(STRING25):LIKE(invalid_mandatory):0,0\n'
    + 'FIELD:addr_address_st:TYPE(STRING2):LIKE(invalid_st):0,0\n'
    + 'FIELD:addr_address_zip:TYPE(STRING5):LIKE(invalid_zip5):0,0\n'
    + '// FIELD:addr_address_zip4:TYPE(STRING4):0,0\n'
    + '// FIELD:addr_address_cart:TYPE(STRING4):0,0\n'
    + '// FIELD:addr_address_cr_sort_sz:TYPE(STRING1):0,0\n'
    + '// FIELD:addr_address_lot:TYPE(STRING4):0,0\n'
    + '// FIELD:addr_address_lot_order:TYPE(STRING1):0,0\n'
    + '// FIELD:addr_address_dbpc:TYPE(STRING2):0,0\n'
    + '// FIELD:addr_address_chk_digit:TYPE(STRING1):0,0\n'
    + '// FIELD:addr_address_rec_type:TYPE(STRING2):0,0\n'
    + '// FIELD:addr_address_fips_state:TYPE(STRING2):0,0\n'
    + '// FIELD:addr_address_fips_county:TYPE(STRING3):0,0\n'
    + '// FIELD:addr_address_geo_lat:TYPE(STRING10):0,0\n'
    + '// FIELD:addr_address_geo_long:TYPE(STRING11):0,0\n'
    + '// FIELD:addr_address_msa:TYPE(STRING4):0,0\n'
    + '// FIELD:addr_address_geo_blk:TYPE(STRING7):0,0\n'
    + '// FIELD:addr_address_geo_match:TYPE(STRING1):0,0\n'
    + '// FIELD:addr_address_err_stat:TYPE(STRING4):0,0\n'
    + '// FIELD:addr_address_fips_state_county:TYPE(STRING5):0,0\n'
    + 'FIELD:clean_person_type:TYPE(STRING2):LIKE(invalid_person_type):0,0\n'
    + '// FIELD:clean_person_name_title:TYPE(STRING5):0,0\n'
    + 'FIELD:clean_person_name_fname:TYPE(STRING20):LIKE(invalid_alphanum_specials):0,0\n'
    + '// FIELD:clean_person_name_mname:TYPE(STRING20):0,0\n'
    + 'FIELD:clean_person_name_lname:TYPE(STRING20):LIKE(invalid_alphanum_specials):0,0\n'
    + '// FIELD:clean_person_name_name_suffix:TYPE(STRING5):0,0\n'
    + '// FIELD:clean_person_name_name_score:TYPE(STRING3):0,0\n'
    + 'FIELD:clean_phone:TYPE(STRING10):LIKE(invalid_phone):0,0\n'
    + 'FIELD:clean_company:TYPE(STRING80):LIKE(invalid_mandatory):0,0\n'
    + 'FIELD:nametype:TYPE(STRING1):LIKE(invalid_nametype):0,0\n'
    + 'FIELD:source_rec_id:TYPE(UNSIGNED8):LIKE(invalid_src_rid):0,0\n'
    + '\n'
    ;
 
  // Structured values
  EXPORT linkpaths := DATASET([
    ],{STRING linkpath;STRING compulsory;STRING optional;STRING bonus;STRING required;STRING search});
 
END;

