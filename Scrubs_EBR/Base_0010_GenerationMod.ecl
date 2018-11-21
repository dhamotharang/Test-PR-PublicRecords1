// Machine-readable versions of the spec file and subsets thereof
IMPORT SALT311;
EXPORT Base_0010_GenerationMod := MODULE(SALT311.iGenerationMod)
 
  // SALT Version info
  EXPORT salt_VERSION := 'V3.11.4';
  EXPORT salt_MODULE := 'SALT311'; // Optional override by HACK:SALTMODULE
  EXPORT salt_TOOLSMODULE := 'SALTTOOLS30'; // Optional override by HACK:SALTTOOLSMODULE
 
  // Core module configuration values
  EXPORT spc_MODULE := 'Scrubs_EBR';
  EXPORT spc_NAMESCOPE := 'Base_0010';
  EXPORT spc_PROCESS := '';
  EXPORT spc_PROCLAYOUTS := 'Process__Layouts';
  EXPORT spc_IDNAME := ''; // cluster id (input)
  EXPORT spc_IDFIELD := ''; // cluster id (output)
  EXPORT spc_RIDFIELD := ''; // record id
  EXPORT spc_CONFIG := 'Config';
  EXPORT spc_CONFIGPARAM := FALSE;
  EXPORT spc_SOURCEFIELD := '';
  EXPORT spc_FILEPREFIX := 'In_';
  EXPORT spc_FILENAME := 'EBR';
  EXPORT spc_INGESTSTATUS := '';
  EXPORT spc_EXTERNAL_MAPPING := 'UniqueID:';
  EXPORT spc_EXTERNAL_BATCH_PARAM := ',/* MY_ */,powid,proxid,seleid,orgid,ultid,bdid,date_first_seen,date_last_seen,process_date_first_seen,process_date_last_seen,record_type,process_date,file_number,orig_extract_date_mdy,company_name,phone_number,sic_code,business_desc,extract_date,file_estab_date,prep_addr_line1,prep_addr_last_line,source_rec_id,clean_address_prim_name,clean_address_p_city_name,clean_address_v_city_name,clean_address_st,clean_address_zip';
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
    + 'MODULE:Scrubs_EBR\n'
    + 'FILENAME:EBR\n'
    + 'NAMESCOPE:Base_0010\n'
    + '//-------------------------- \n'
    + '//FIELDTYPE DEFINITIONS\n'
    + '//--------------------------\n'
    + 'FIELDTYPE:invalid_mandatory:CUSTOM(Scrubs_EBR.Functions.fn_populated_strings>0)\n'
    + 'FIELDTYPE:invalid_pastdate:CUSTOM(Scrubs_EBR.Functions.fn_past_yyyymmdd>0)\n'
    + 'FIELDTYPE:invalid_pastdate_slashes:CUSTOM(Scrubs_EBR.Functions.fn_past_withslashes>0)\n'
    + 'FIELDTYPE:invalid_bdid:CUSTOM(Scrubs_EBR.Functions.fn_numeric>0)\n'
    + 'FIELDTYPE:invalid_record_type:ENUM(H|C)\n'
    + 'FIELDTYPE:invalid_file_number:ALLOW(ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789):LENGTHS(9)\n'
    + 'FIELDTYPE:invalid_phone:CUSTOM(Scrubs_EBR.Functions.fn_verify_phone>0)\n'
    + 'FIELDTYPE:invalid_sic:CUSTOM(Scrubs_EBR.Functions.fn_sic_code>0)\n'
    + 'FIELDTYPE:invalid_ccyymm:CUSTOM(Scrubs_EBR.Functions.fn_dt_ccyymm_or_200000>0)\n'
    + 'FIELDTYPE:invalid_dt_first_seen:CUSTOM(Scrubs_EBR.Functions.fn_dt_first_seen>0)\n'
    + 'FIELDTYPE:invalid_numeric:CUSTOM(Scrubs_EBR.Functions.fn_numeric>0)\n'
    + 'FIELDTYPE:invalid_state:CUSTOM(Scrubs_EBR.Functions.fn_verify_state>0)\n'
    + 'FIELDTYPE:invalid_zip5:CUSTOM(Scrubs_EBR.Functions.fn_verify_zip5>0)\n'
    + '\n'
    + '//------------------------------------------------------\n'
    + '//FIELDS:  Commented out fields are not being scrubbed\n'
    + '//------------------------------------------------------\n'
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
    + 'FIELD:bdid:TYPE(UNSIGNED6):LIKE(invalid_bdid):0,0\n'
    + 'FIELD:date_first_seen:TYPE(STRING8):LIKE(invalid_dt_first_seen):0,0\n'
    + 'FIELD:date_last_seen:TYPE(STRING8):LIKE(invalid_pastdate):0,0\n'
    + 'FIELD:process_date_first_seen:TYPE(UNSIGNED4):LIKE(invalid_pastdate):0,0\n'
    + 'FIELD:process_date_last_seen:TYPE(UNSIGNED4):LIKE(invalid_pastdate):0,0\n'
    + 'FIELD:record_type:TYPE(STRING1):LIKE(invalid_record_type):0,0\n'
    + 'FIELD:process_date:TYPE(STRING8):LIKE(invalid_pastdate):0,0\n'
    + 'FIELD:file_number:TYPE(STRING10):LIKE(invalid_file_number):0,0\n'
    + '// FIELD:segment_code:TYPE(STRING4):0,0\n'
    + '// FIELD:sequence_number:TYPE(STRING5):0,0\n'
    + 'FIELD:orig_extract_date_mdy:TYPE(STRING8):LIKE(invalid_pastdate_slashes):0,0\n'
    + '// FIELD:orig_file_estab_date_mmyy:TYPE(STRING6):0,0\n'
    + '// FIELD:file_estab_flag:TYPE(STRING1):0,0\n'
    + 'FIELD:company_name:TYPE(STRING40):LIKE(invalid_mandatory):0,0\n'
    + '// FIELD:street_address:TYPE(STRING30):0,0\n'
    + '// FIELD:city:TYPE(STRING28):0,0\n'
    + '// FIELD:state_code:TYPE(STRING2):0,0\n'
    + '// FIELD:state_name:TYPE(STRING20):0,0\n'
    + '// FIELD:orig_zip:TYPE(STRING5):0,0\n'
    + '// FIELD:orig_zip_4:TYPE(STRING4):0,0\n'
    + 'FIELD:phone_number:TYPE(STRING10):LIKE(invalid_phone):0,0\n'
    + 'FIELD:sic_code:TYPE(STRING4):LIKE(invalid_sic):0,0\n'
    + 'FIELD:business_desc:TYPE(STRING40):LIKE(invalid_mandatory):0,0\n'
    + '// FIELD:dispute_ind:TYPE(STRING1):0,0\n'
    + 'FIELD:extract_date:TYPE(STRING8):LIKE(invalid_pastdate):0,0\n'
    + 'FIELD:file_estab_date:TYPE(STRING6):LIKE(invalid_ccyymm):0,0\n'
    + '// FIELD:append_rawaid:TYPE(UNSIGNED8):0,0\n'
    + '// FIELD:append_aceaid:TYPE(UNSIGNED8):0,0\n'
    + 'FIELD:prep_addr_line1:TYPE(STRING100):LIKE(invalid_mandatory):0,0\n'
    + 'FIELD:prep_addr_last_line:TYPE(STRING50):LIKE(invalid_mandatory):0,0\n'
    + 'FIELD:source_rec_id:TYPE(UNSIGNED8):LIKE(invalid_numeric):0,0\n'
    + '// FIELD:clean_address_prim_range:TYPE(STRING10):0,0\n'
    + '// FIELD:clean_address_predir:TYPE(STRING2):0,0\n'
    + 'FIELD:clean_address_prim_name:TYPE(STRING28):LIKE(invalid_mandatory):0,0\n'
    + '// FIELD:clean_address_addr_suffix:TYPE(STRING4):0,0\n'
    + '// FIELD:clean_address_postdir:TYPE(STRING2):0,0\n'
    + '// FIELD:clean_address_unit_desig:TYPE(STRING10):0,0\n'
    + '// FIELD:clean_address_sec_range:TYPE(STRING8):0,0\n'
    + 'FIELD:clean_address_p_city_name:TYPE(STRING25):LIKE(invalid_mandatory):0,0\n'
    + 'FIELD:clean_address_v_city_name:TYPE(STRING25):LIKE(invalid_mandatory):0,0\n'
    + 'FIELD:clean_address_st:TYPE(STRING2):LIKE(invalid_state):0,0\n'
    + 'FIELD:clean_address_zip:TYPE(STRING5):LIKE(invalid_zip5):0,0\n'
    + '// FIELD:clean_address_zip4:TYPE(STRING4):0,0\n'
    + '// FIELD:clean_address_cart:TYPE(STRING4):0,0\n'
    + '// FIELD:clean_address_cr_sort_sz:TYPE(STRING1):0,0\n'
    + '// FIELD:clean_address_lot:TYPE(STRING4):0,0\n'
    + '// FIELD:clean_address_lot_order:TYPE(STRING1):0,0\n'
    + '// FIELD:clean_address_dbpc:TYPE(STRING2):0,0\n'
    + '// FIELD:clean_address_chk_digit:TYPE(STRING1):0,0\n'
    + '// FIELD:clean_address_rec_type:TYPE(STRING2):0,0\n'
    + '// FIELD:clean_address_county:TYPE(STRING5):0,0\n'
    + '// FIELD:clean_address_geo_lat:TYPE(STRING10):0,0\n'
    + '// FIELD:clean_address_geo_long:TYPE(STRING11):0,0\n'
    + '// FIELD:clean_address_msa:TYPE(STRING4):0,0\n'
    + '// FIELD:clean_address_geo_blk:TYPE(STRING7):0,0\n'
    + '// FIELD:clean_address_geo_match:TYPE(STRING1):0,0\n'
    + '// FIELD:clean_address_err_stat:TYPE(STRING4):0,0\n'
    + '\n'
    + '\n'
    ;
 
  // Structured values
  EXPORT linkpaths := DATASET([
    ],{STRING linkpath;STRING compulsory;STRING optional;STRING bonus;STRING required;STRING search});
 
END;

