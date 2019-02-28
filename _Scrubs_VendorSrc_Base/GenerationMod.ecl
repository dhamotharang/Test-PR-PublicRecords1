// Machine-readable versions of the spec file and subsets thereof
IMPORT SALT311;
EXPORT GenerationMod := MODULE(SALT311.iGenerationMod)
 
  // SALT Version info
  EXPORT salt_VERSION := 'V3.11.6';
  EXPORT salt_MODULE := 'SALT311'; // Optional override by HACK:SALTMODULE
  EXPORT salt_TOOLSMODULE := 'SALTTOOLS30'; // Optional override by HACK:SALTTOOLSMODULE
 
  // Core module configuration values
  EXPORT spc_MODULE := '_Scrubs_VendorSrc_Base';
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
  EXPORT spc_FILENAME := 'Base';
  EXPORT spc_INGESTSTATUS := '';
  EXPORT spc_EXTERNAL_MAPPING := 'UniqueID:';
  EXPORT spc_EXTERNAL_BATCH_PARAM := ',/* MY_ */,item_source,source_code,display_name,description,status,data_notes,coverage_1,coverage_2,orbit_item_name,orbit_source,orbit_number,website,notes,date_added,input_file_id,market_restrict_flag,clean_phone,clean_fax,prepped_addr1,prepped_addr2,v_prim_name,v_zip,v_zip4,prim_range,predir,prim_name,addr_suffix,postdir,unit_desig,sec_range,p_city_name,v_city_name,st,zip,zip4,cart,cr_sort_sz,lot,lot_order,dbpc,chk_digit,rec_type,county,geo_lat,geo_long,msa,geo_blk,geo_match,err_stat';
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
    + 'MODULE:_Scrubs_VendorSrc_Base\n'
    + 'FILENAME:Base\n'
    + '\n'
    + '\n'
    + 'FIELDTYPE:Invalid_source:ALLOW(()!@.0123456789ABCDEFGHIJKLMNOPRSTUVWXYZ_ )\n'
    + 'FIELDTYPE:Invalid_display_name:ALLOW( &(),-./0123456789ABCDEFGHIJKLMNOPRSTUVWXYZ )\n'
    + 'FIELDTYPE:Invalid_description:ALLOW( &\'(),-.0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZ )\n'
    + '\n'
    + '// FIELDTYPE:Invalid_status:ALLOW( ,\'-0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZ)\n'
    + '// FIELDTYPE:Invalid_empty:ALLOW()\n'
    + 'FIELDTYPE:Invalid_coverage:ALLOW( ABCDEFGHIJKLMNOPQRSTUVWXYZ)\n'
    + '// FIELDTYPE:Invalid_orbit_item_name:ALLOW( &()*,-/012ABCDEFGHIJKLMNOPQRSTUVWXYZ)\n'
    + '// FIELDTYPE:Invalid_orbit:ALLOW(0123456789)\n'
    + 'FIELDTYPE:Invalid_website:ALLOW( &-./0123456789:=?@ABCDEFGHIJKLMNOPQRSTUVWXYZ_)\n'
    + 'FIELDTYPE:Invalid_date_added:ALLOW(0129)\n'
    + '// FIELDTYPE:Invalid_input_file_id:ALLOW(ABCDEFHILMNOPRSTUVY)\n'
    + 'FIELDTYPE:Invalid_market_restrict_flag:ALLOW(ENOSTY)\n'
    + 'FIELDTYPE:Invalid_clean_phone:ALLOW(0123456789)\n'
    + 'FIELDTYPE:Invalid_prepped_addr1:ALLOW( &#,-.0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZ)\n'
    + 'FIELDTYPE:Invalid_prepped_addr2:ALLOW( ,-0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZ)\n'
    + '// FIELDTYPE:Invalid_v_prim_name:ALLOW()\n'
    + 'FIELDTYPE:Invalid_v_zip:ALLOW()\n'
    + 'FIELDTYPE:Invalid_v_zip4:ALLOW()\n'
    + '// FIELDTYPE:Invalid_prim_range:ALLOW(0123456789AB)\n'
    + '// FIELDTYPE:Invalid_predir:ALLOW(ENSW)\n'
    + '// FIELDTYPE:Invalid_prim_name:ALLOW( &0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZ)\n'
    + '// FIELDTYPE:Invalid_addr_suffix:ALLOW(ABCDEHIKLNOPQRSTVWXYZ)\n'
    + '// FIELDTYPE:Invalid_postdir:ALLOW(ENSW)\n'
    + '// FIELDTYPE:Invalid_unit_desig:ALLOW(-ABCDEFGILMNOPRSTUX)\n'
    + '// FIELDTYPE:Invalid_sec_range:ALLOW(-0123456789ABCDEFGHIJKLMNOPRSTUVWY)\n'
    + 'FIELDTYPE:Invalid_city_name:ALLOW( 0123456ABCDEFGHIJKLMNOPQRSTUVWXYZ)\n'
    + 'FIELDTYPE:Invalid_st:ALLOW(ACDEFGHIJKLMNOPRSTUVWXYZ)\n'
    + '// FIELDTYPE:Invalid_cart:ALLOW(0123456789BCHR)\n'
    + '// FIELDTYPE:Invalid_cr_sort_sz:ALLOW(BCD)\n'
    + '// FIELDTYPE:Invalid_lot_order:ALLOW(AD)\n'
    + 'FIELDTYPE:Invalid_numbers:ALLOW(0123456789)\n'
    + '// FIELDTYPE:Invalid_rec_type:ALLOW(DFHPRSU)\n'
    + 'FIELDTYPE:Invalid_geo_lat:ALLOW(.0123456789)\n'
    + 'FIELDTYPE:Invalid_geo_long:ALLOW(-.0123456789)\n'
    + 'FIELDTYPE:Invalid_msa:ALLOW(0)\n'
    + 'FIELDTYPE:Invalid_geo_match:ALLOW(0145)\n'
    + 'FIELDTYPE:Invalid_err_stat:ALLOW(0123456789ABES)\n'
    + '\n'
    + '\n'
    + '\n'
    + '\n'
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
    + 'FIELD:item_source:LIKE(Invalid_source):TYPE(STRING):0,0\n'
    + 'FIELD:source_code:LIKE(Invalid_source):TYPE(STRING75):0,0\n'
    + 'FIELD:display_name:LIKE(Invalid_display_name):TYPE(STRING):0,0\n'
    + 'FIELD:description:LIKE(Invalid_description):TYPE(STRING):0,0\n'
    + 'FIELD:status:TYPE(STRING):0,0\n'
    + 'FIELD:data_notes:TYPE(STRING):0,0\n'
    + 'FIELD:coverage_1:LIKE(Invalid_coverage):TYPE(STRING):0,0\n'
    + 'FIELD:coverage_2:LIKE(Invalid_coverage):TYPE(STRING):0,0\n'
    + 'FIELD:orbit_item_name:TYPE(STRING):0,0\n'
    + 'FIELD:orbit_source:TYPE(STRING):0,0\n'
    + 'FIELD:orbit_number:TYPE(STRING):0,0\n'
    + 'FIELD:website:LIKE(Invalid_website):TYPE(STRING):0,0\n'
    + 'FIELD:notes:TYPE(STRING):0,0\n'
    + 'FIELD:date_added:LIKE(Invalid_date_added):TYPE(STRING):0,0\n'
    + 'FIELD:input_file_id:TYPE(STRING):0,0\n'
    + 'FIELD:market_restrict_flag:LIKE(Invalid_market_restrict_flag):TYPE(STRING):0,0\n'
    + 'FIELD:clean_phone:LIKE(Invalid_clean_phone):TYPE(STRING10):0,0\n'
    + 'FIELD:clean_fax:TYPE(STRING10):0,0\n'
    + 'FIELD:prepped_addr1:LIKE(Invalid_prepped_addr1):TYPE(STRING65):0,0\n'
    + 'FIELD:prepped_addr2:LIKE(Invalid_prepped_addr2):TYPE(STRING35):0,0\n'
    + 'FIELD:v_prim_name:TYPE(STRING28):0,0\n'
    + 'FIELD:v_zip:TYPE(STRING5):0,0\n'
    + 'FIELD:v_zip4:TYPE(STRING4):0,0\n'
    + 'FIELD:prim_range:TYPE(STRING):0,0\n'
    + 'FIELD:predir:TYPE(STRING):0,0\n'
    + 'FIELD:prim_name:TYPE(STRING):0,0\n'
    + 'FIELD:addr_suffix:TYPE(STRING):0,0\n'
    + 'FIELD:postdir:TYPE(STRING):0,0\n'
    + 'FIELD:unit_desig:TYPE(STRING):0,0\n'
    + 'FIELD:sec_range:TYPE(STRING):0,0\n'
    + 'FIELD:p_city_name:LIKE(Invalid_city_name):TYPE(STRING):0,0\n'
    + 'FIELD:v_city_name:LIKE(Invalid_city_name):TYPE(STRING):0,0\n'
    + 'FIELD:st:LIKE(Invalid_st):TYPE(STRING):0,0\n'
    + 'FIELD:zip:LIKE(Invalid_numbers):TYPE(STRING):0,0\n'
    + 'FIELD:zip4:LIKE(Invalid_numbers):TYPE(STRING):0,0\n'
    + 'FIELD:cart:TYPE(STRING):0,0\n'
    + 'FIELD:cr_sort_sz:TYPE(STRING):0,0\n'
    + 'FIELD:lot:LIKE(Invalid_numbers):TYPE(STRING):0,0\n'
    + 'FIELD:lot_order:TYPE(STRING):0,0\n'
    + 'FIELD:dbpc:LIKE(Invalid_numbers):TYPE(STRING):0,0\n'
    + 'FIELD:chk_digit:LIKE(Invalid_numbers):TYPE(STRING):0,0\n'
    + 'FIELD:rec_type:TYPE(STRING):0,0\n'
    + 'FIELD:county:LIKE(Invalid_numbers):TYPE(STRING):0,0\n'
    + 'FIELD:geo_lat:LIKE(Invalid_geo_lat):TYPE(STRING):0,0\n'
    + 'FIELD:geo_long:LIKE(Invalid_geo_long):TYPE(STRING):0,0\n'
    + 'FIELD:msa:LIKE(Invalid_msa):TYPE(STRING):0,0\n'
    + 'FIELD:geo_blk:LIKE(Invalid_numbers):TYPE(STRING):0,0\n'
    + 'FIELD:geo_match:LIKE(Invalid_geo_match):TYPE(STRING):0,0\n'
    + 'FIELD:err_stat:LIKE(Invalid_err_stat):TYPE(STRING):0,0\n'
    + '// CONCEPT statements should be used to group together interellated fields; such as address\n'
    + '// RELATIONSHIP is used to find non-obvious relationships between the clusters\n'
    + '// SOURCEFIELD is used if a field of the file denotes a source of the records in that file\n'
    + '// LINKPATH is used to define access paths for external linking\n'
    ;
 
  // Structured values
  EXPORT linkpaths := DATASET([
    ],{STRING linkpath;STRING compulsory;STRING optional;STRING bonus;STRING required;STRING search});
 
END;

