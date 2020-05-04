// Machine-readable versions of the spec file and subsets thereof
IMPORT SALT311;
EXPORT Companies_GenerationMod := MODULE(SALT311.iGenerationMod)
 
  // SALT Version info
  EXPORT salt_VERSION := 'V3.11.9';
  EXPORT salt_MODULE := 'SALT311'; // Optional override by HACK:SALTMODULE
  EXPORT salt_TOOLSMODULE := 'SALTTOOLS30'; // Optional override by HACK:SALTTOOLSMODULE
 
  // Core module configuration values
  EXPORT spc_MODULE := 'Scrubs_Sheila_Greco';
  EXPORT spc_NAMESCOPE := 'Companies';
  EXPORT spc_PROCESS := '';
  EXPORT spc_PROCLAYOUTS := 'Process__Layouts';
  EXPORT spc_IDNAME := ''; // cluster id (input)
  EXPORT spc_IDFIELD := ''; // cluster id (output)
  EXPORT spc_RIDFIELD := ''; // record id
  EXPORT spc_CONFIG := 'Config';
  EXPORT spc_CONFIGPARAM := FALSE;
  EXPORT spc_SOURCEFIELD := '';
  EXPORT spc_FILEPREFIX := 'In_';
  EXPORT spc_FILENAME := 'Sheila_Greco';
  EXPORT spc_INGESTSTATUS := '';
  EXPORT spc_EXTERNAL_MAPPING := 'UniqueID:';
  EXPORT spc_EXTERNAL_BATCH_PARAM := ',/* MY_ */,dotid,dotscore,dotweight,empid,empscore,empweight,powid,powscore,powweight,proxid,proxscore,proxweight,seleid,selescore,seleweight,orgid,orgscore,orgweight,ultid,ultscore,ultweight,source_rec_id,bdid,bdid_score,raw_aid,ace_aid,dt_first_seen,dt_last_seen,dt_vendor_first_reported,dt_vendor_last_reported,record_type,rawfields_maincompanyid,rawfields_companyname,rawfields_ticker,rawfields_fortunerank,rawfields_primaryindustry,rawfields_address1,rawfields_address2,rawfields_city,rawfields_state,rawfields_zip,rawfields_country,rawfields_region,rawfields_phone,rawfields_extension,rawfields_weburl,rawfields_sales,rawfields_employees,rawfields_competitors,rawfields_divisionname,rawfields_siccode,rawfields_auditor,rawfields_entrydate,rawfields_lastupdate,rawfields_entrystaffid,rawfields_description,clean_address_prim_range,clean_address_predir,clean_address_prim_name,clean_address_addr_suffix,clean_address_postdir,clean_address_unit_desig,clean_address_sec_range,clean_address_p_city_name,clean_address_v_city_name,clean_address_st,clean_address_zip,clean_address_zip4,clean_address_cart,clean_address_cr_sort_sz,clean_address_lot,clean_address_lot_order,clean_address_dbpc,clean_address_chk_digit,clean_address_rec_type,clean_address_fips_state,clean_address_fips_county,clean_address_geo_lat,clean_address_geo_long,clean_address_msa,clean_address_geo_blk,clean_address_geo_match,clean_address_err_stat,clean_dates_entrydate,clean_dates_lastupdate,clean_phones_phone,global_sid,record_sid';
  EXPORT spc_HAS_TWOSTEP := FALSE;
  EXPORT spc_HAS_PARTITION := FALSE;
  EXPORT spc_HAS_FIELDTYPES := FALSE;
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
    + 'MODULE:Scrubs_Sheila_Greco\n'
    + 'FILENAME:Sheila_Greco\n'
    + 'NAMESCOPE:Companies\n'
    + '\n'
    + '\n'
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
    + 'FIELD:source_rec_id:TYPE(UNSIGNED8):0,0\n'
    + 'FIELD:bdid:TYPE(UNSIGNED6):0,0\n'
    + 'FIELD:bdid_score:TYPE(UNSIGNED1):0,0\n'
    + 'FIELD:raw_aid:TYPE(UNSIGNED8):0,0\n'
    + 'FIELD:ace_aid:TYPE(UNSIGNED8):0,0\n'
    + 'FIELD:dt_first_seen:TYPE(UNSIGNED4):0,0\n'
    + 'FIELD:dt_last_seen:TYPE(UNSIGNED4):0,0\n'
    + 'FIELD:dt_vendor_first_reported:TYPE(UNSIGNED4):0,0\n'
    + 'FIELD:dt_vendor_last_reported:TYPE(UNSIGNED4):0,0\n'
    + 'FIELD:record_type:TYPE(STRING1):0,0\n'
    + 'FIELD:rawfields_maincompanyid:TYPE(STRING):0,0\n'
    + 'FIELD:rawfields_companyname:TYPE(STRING):0,0\n'
    + 'FIELD:rawfields_ticker:TYPE(STRING):0,0\n'
    + 'FIELD:rawfields_fortunerank:TYPE(STRING):0,0\n'
    + 'FIELD:rawfields_primaryindustry:TYPE(STRING):0,0\n'
    + 'FIELD:rawfields_address1:TYPE(STRING):0,0\n'
    + 'FIELD:rawfields_address2:TYPE(STRING):0,0\n'
    + 'FIELD:rawfields_city:TYPE(STRING):0,0\n'
    + 'FIELD:rawfields_state:TYPE(STRING):0,0\n'
    + 'FIELD:rawfields_zip:TYPE(STRING):0,0\n'
    + 'FIELD:rawfields_country:TYPE(STRING):0,0\n'
    + 'FIELD:rawfields_region:TYPE(STRING):0,0\n'
    + 'FIELD:rawfields_phone:TYPE(STRING):0,0\n'
    + 'FIELD:rawfields_extension:TYPE(STRING):0,0\n'
    + 'FIELD:rawfields_weburl:TYPE(STRING):0,0\n'
    + 'FIELD:rawfields_sales:TYPE(STRING):0,0\n'
    + 'FIELD:rawfields_employees:TYPE(STRING):0,0\n'
    + 'FIELD:rawfields_competitors:TYPE(STRING):0,0\n'
    + 'FIELD:rawfields_divisionname:TYPE(STRING):0,0\n'
    + 'FIELD:rawfields_siccode:TYPE(STRING):0,0\n'
    + 'FIELD:rawfields_auditor:TYPE(STRING):0,0\n'
    + 'FIELD:rawfields_entrydate:TYPE(STRING):0,0\n'
    + 'FIELD:rawfields_lastupdate:TYPE(STRING):0,0\n'
    + 'FIELD:rawfields_entrystaffid:TYPE(STRING):0,0\n'
    + 'FIELD:rawfields_description:TYPE(STRING):0,0\n'
    + 'FIELD:clean_address_prim_range:TYPE(STRING10):0,0\n'
    + 'FIELD:clean_address_predir:TYPE(STRING2):0,0\n'
    + 'FIELD:clean_address_prim_name:TYPE(STRING28):0,0\n'
    + 'FIELD:clean_address_addr_suffix:TYPE(STRING4):0,0\n'
    + 'FIELD:clean_address_postdir:TYPE(STRING2):0,0\n'
    + 'FIELD:clean_address_unit_desig:TYPE(STRING10):0,0\n'
    + 'FIELD:clean_address_sec_range:TYPE(STRING8):0,0\n'
    + 'FIELD:clean_address_p_city_name:TYPE(STRING25):0,0\n'
    + 'FIELD:clean_address_v_city_name:TYPE(STRING25):0,0\n'
    + 'FIELD:clean_address_st:TYPE(STRING2):0,0\n'
    + 'FIELD:clean_address_zip:TYPE(STRING5):0,0\n'
    + 'FIELD:clean_address_zip4:TYPE(STRING4):0,0\n'
    + 'FIELD:clean_address_cart:TYPE(STRING4):0,0\n'
    + 'FIELD:clean_address_cr_sort_sz:TYPE(STRING1):0,0\n'
    + 'FIELD:clean_address_lot:TYPE(STRING4):0,0\n'
    + 'FIELD:clean_address_lot_order:TYPE(STRING1):0,0\n'
    + 'FIELD:clean_address_dbpc:TYPE(STRING2):0,0\n'
    + 'FIELD:clean_address_chk_digit:TYPE(STRING1):0,0\n'
    + 'FIELD:clean_address_rec_type:TYPE(STRING2):0,0\n'
    + 'FIELD:clean_address_fips_state:TYPE(STRING2):0,0\n'
    + 'FIELD:clean_address_fips_county:TYPE(STRING3):0,0\n'
    + 'FIELD:clean_address_geo_lat:TYPE(STRING10):0,0\n'
    + 'FIELD:clean_address_geo_long:TYPE(STRING11):0,0\n'
    + 'FIELD:clean_address_msa:TYPE(STRING4):0,0\n'
    + 'FIELD:clean_address_geo_blk:TYPE(STRING7):0,0\n'
    + 'FIELD:clean_address_geo_match:TYPE(STRING1):0,0\n'
    + 'FIELD:clean_address_err_stat:TYPE(STRING4):0,0\n'
    + 'FIELD:clean_dates_entrydate:TYPE(UNSIGNED4):0,0\n'
    + 'FIELD:clean_dates_lastupdate:TYPE(UNSIGNED4):0,0\n'
    + 'FIELD:clean_phones_phone:TYPE(STRING10):0,0\n'
    + 'FIELD:global_sid:TYPE(UNSIGNED4):0,0\n'
    + 'FIELD:record_sid:TYPE(UNSIGNED8):0,0\n'
    ;
 
  // Structured values
  EXPORT linkpaths := DATASET([
    ],{STRING linkpath;STRING compulsory;STRING optional;STRING bonus;STRING required;STRING search});
 
END;

