// Machine-readable versions of the spec file and subsets thereof
IMPORT SALT311;
EXPORT Base_GenerationMod := MODULE(SALT311.iGenerationMod)
 
  // SALT Version info
  EXPORT salt_VERSION := 'V3.11.6';
  EXPORT salt_MODULE := 'SALT311'; // Optional override by HACK:SALTMODULE
  EXPORT salt_TOOLSMODULE := 'SALTTOOLS30'; // Optional override by HACK:SALTTOOLSMODULE
 
  // Core module configuration values
  EXPORT spc_MODULE := 'Scrubs_Vendor_Src';
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
  EXPORT spc_FILENAME := 'Vendor_Src';
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
    + 'MODULE:Scrubs_Vendor_Src\n'
    + 'FILENAME:Vendor_Src\n'
    + 'NAMESCOPE:Base\n'
    + '// Uncomment up to NINES for internal or external adl\n'
    + '// IDFIELD:EXISTS:<NameOfIDField>\n'
    + '// RIDFIELD:<NameOfRidField>\n'
    + '// RECORDS:<NumberOfRecordsInDataFile>\n'
    + '// POPULATION:<ExpectedNumberOfEntitiesInDataFile>\n'
    + '// NINES:<Precision required 3 = 99.9%, 2 = 99% etc>\n'
    + '// Uncomment Process if doing external adl\n'
    + '// PROCESS:<ProcessName>\n'
    + '// FIELDTYPE statements can be used to clean up (or check the cleaning) of individual fields\n'
    + 'FIELDTYPE:item_source:ALLOW( \\:~=+^%"|#!*${}[]?\'&<>@/,();-!.0123456789abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ_)\n'
    + 'FIELDTYPE:source_code:ALLOW( \\:~=+^%"|#!*${}[]?\'&<>@/,();-!.0123456789abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ_)\n'
    + 'FIELDTYPE:display_name:ALLOW( :+@%"\\*_$\';#&(),--./0123456789abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ)\n'
    + 'FIELDTYPE:description:ALLOW( ~@=<>:+[]%"\\*_$\';#/&(),-.0123456789abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ)\n'
    + 'FIELDTYPE:status:ALLOW( \\&()#/,\'-.0123456789abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ)\n'
    + 'FIELDTYPE:data_notes:ALLOW()\n'
    + 'FIELDTYPE:coverage_1:ALLOW( ()-\'.abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ)\n'
    + 'FIELDTYPE:coverage_2:ALLOW( ()-\'.abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ)\n'
    + 'FIELDTYPE:orbit_item_name:ALLOW( :%$&()*,+-/\'._0123456789abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ)\n'
    + 'FIELDTYPE:orbit_source:ALLOW(0123456789)\n'
    + 'FIELDTYPE:orbit_number:ALLOW(0123456789)\n'
    + 'FIELDTYPE:website:ALLOW( ()%\\"~&-./,#0123456789:=?@abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ_)\n'
    + 'FIELDTYPE:notes:ALLOW()\n'
    + 'FIELDTYPE:date_added:ALLOW(0123456789)\n'
    + 'FIELDTYPE:input_file_id:ALLOW(0123456789abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ)\n'
    + 'FIELDTYPE:market_restrict_flag:ALLOW(ENOSTY)\n'
    + 'FIELDTYPE:clean_phone:ALLOW(0123456789)\n'
    + 'FIELDTYPE:clean_fax:ALLOW()\n'
    + 'FIELDTYPE:prepped_addr1:ALLOW( _[]?$`"():/&#\',-.;0123456789abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ)\n'
    + 'FIELDTYPE:prepped_addr2:ALLOW( _[]?$`"():/&#\',-.;0123456789abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ)\n'
    + 'FIELDTYPE:v_prim_name:ALLOW()\n'
    + 'FIELDTYPE:v_zip:ALLOW()\n'
    + 'FIELDTYPE:v_zip4:ALLOW()\n'
    + 'FIELDTYPE:prim_range:ALLOW( -/.0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZ)\n'
    + 'FIELDTYPE:predir:ALLOW(ENSW)\n'
    + 'FIELDTYPE:prim_name:ALLOW( -\'/&$.0123456789abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ)\n'
    + 'FIELDTYPE:addr_suffix:ALLOW( abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ)\n'
    + 'FIELDTYPE:postdir:ALLOW(ENSW)\n'
    + 'FIELDTYPE:unit_desig:ALLOW( #-abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ)\n'
    + 'FIELDTYPE:sec_range:ALLOW( &-./0123456789abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ)\n'
    + 'FIELDTYPE:p_city_name:ALLOW( /0123456789abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ)\n'
    + 'FIELDTYPE:v_city_name:ALLOW( /0123456789abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ)\n'
    + 'FIELDTYPE:st:ALLOW(abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ)\n'
    + 'FIELDTYPE:zip:ALLOW(0123456789)\n'
    + 'FIELDTYPE:zip4:ALLOW(0123456789)\n'
    + 'FIELDTYPE:cart:ALLOW(0123456789BCHR)\n'
    + 'FIELDTYPE:cr_sort_sz:ALLOW(BCD)\n'
    + 'FIELDTYPE:lot:ALLOW(0123456789)\n'
    + 'FIELDTYPE:lot_order:ALLOW(AD)\n'
    + 'FIELDTYPE:dbpc:ALLOW(0123456789)\n'
    + 'FIELDTYPE:chk_digit:ALLOW(0123456789)\n'
    + 'FIELDTYPE:rec_type:ALLOW(DFHPRSU)\n'
    + 'FIELDTYPE:county:ALLOW(0123456789)\n'
    + 'FIELDTYPE:geo_lat:ALLOW(.0123456789)\n'
    + 'FIELDTYPE:geo_long:ALLOW(-.0123456789)\n'
    + 'FIELDTYPE:msa:ALLOW(0)\n'
    + 'FIELDTYPE:geo_blk:ALLOW(0123456789)\n'
    + 'FIELDTYPE:geo_match:ALLOW(0145)\n'
    + 'FIELDTYPE:err_stat:ALLOW(0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZ)\n'
    + '// BESTTYPE statements declare methods of generating the best value for a given cluster; this can also improve linking\n'
    + '// FUZZY can be used to create new types of FUZZY linking\n'
    + '// Remember to generate specificities and update the 0,0 placeholders below before running any sort of linking.\n'
    + '// If the actual specificity for a field is <1, round it up to 1 rather than down to 0.  If your cluster is running\n'
    + '// a shared repository, calling SALTTOOLS30.mac_Patch_SPC from the bottom of BWR_Specificities may be a convenience.\n'
    + 'FIELD:item_source:LIKE(item_source):TYPE(STRING):0,0\n'
    + 'FIELD:source_code:LIKE(source_code):TYPE(STRING75):0,0\n'
    + 'FIELD:display_name:LIKE(display_name):TYPE(STRING):0,0\n'
    + 'FIELD:description:LIKE(description):TYPE(STRING):0,0\n'
    + 'FIELD:status:LIKE(status):TYPE(STRING):0,0\n'
    + 'FIELD:data_notes:LIKE(data_notes):TYPE(STRING):0,0\n'
    + 'FIELD:coverage_1:LIKE(coverage_1):TYPE(STRING):0,0\n'
    + 'FIELD:coverage_2:LIKE(coverage_2):TYPE(STRING):0,0\n'
    + 'FIELD:orbit_item_name:LIKE(orbit_item_name):TYPE(STRING):0,0\n'
    + 'FIELD:orbit_source:LIKE(orbit_source):TYPE(STRING):0,0\n'
    + 'FIELD:orbit_number:LIKE(orbit_number):TYPE(STRING):0,0\n'
    + 'FIELD:website:LIKE(website):TYPE(STRING):0,0\n'
    + 'FIELD:notes:LIKE(notes):TYPE(STRING):0,0\n'
    + 'FIELD:date_added:LIKE(date_added):TYPE(STRING):0,0\n'
    + 'FIELD:input_file_id:LIKE(input_file_id):TYPE(STRING):0,0\n'
    + 'FIELD:market_restrict_flag:LIKE(market_restrict_flag):TYPE(STRING):0,0\n'
    + 'FIELD:clean_phone:LIKE(clean_phone):TYPE(STRING10):0,0\n'
    + 'FIELD:clean_fax:LIKE(clean_fax):TYPE(STRING10):0,0\n'
    + 'FIELD:prepped_addr1:LIKE(prepped_addr1):TYPE(STRING65):0,0\n'
    + 'FIELD:prepped_addr2:LIKE(prepped_addr2):TYPE(STRING35):0,0\n'
    + 'FIELD:v_prim_name:LIKE(v_prim_name):TYPE(STRING28):0,0\n'
    + 'FIELD:v_zip:LIKE(v_zip):TYPE(STRING5):0,0\n'
    + 'FIELD:v_zip4:LIKE(v_zip4):TYPE(STRING4):0,0\n'
    + 'FIELD:prim_range:LIKE(prim_range):TYPE(STRING):0,0\n'
    + 'FIELD:predir:LIKE(predir):TYPE(STRING):0,0\n'
    + 'FIELD:prim_name:LIKE(prim_name):TYPE(STRING):0,0\n'
    + 'FIELD:addr_suffix:LIKE(addr_suffix):TYPE(STRING):0,0\n'
    + 'FIELD:postdir:LIKE(postdir):TYPE(STRING):0,0\n'
    + 'FIELD:unit_desig:LIKE(unit_desig):TYPE(STRING):0,0\n'
    + 'FIELD:sec_range:LIKE(sec_range):TYPE(STRING):0,0\n'
    + 'FIELD:p_city_name:LIKE(p_city_name):TYPE(STRING):0,0\n'
    + 'FIELD:v_city_name:LIKE(v_city_name):TYPE(STRING):0,0\n'
    + 'FIELD:st:LIKE(st):TYPE(STRING):0,0\n'
    + 'FIELD:zip:LIKE(zip):TYPE(STRING):0,0\n'
    + 'FIELD:zip4:LIKE(zip4):TYPE(STRING):0,0\n'
    + 'FIELD:cart:LIKE(cart):TYPE(STRING):0,0\n'
    + 'FIELD:cr_sort_sz:LIKE(cr_sort_sz):TYPE(STRING):0,0\n'
    + 'FIELD:lot:LIKE(lot):TYPE(STRING):0,0\n'
    + 'FIELD:lot_order:LIKE(lot_order):TYPE(STRING):0,0\n'
    + 'FIELD:dbpc:LIKE(dbpc):TYPE(STRING):0,0\n'
    + 'FIELD:chk_digit:LIKE(chk_digit):TYPE(STRING):0,0\n'
    + 'FIELD:rec_type:LIKE(rec_type):TYPE(STRING):0,0\n'
    + 'FIELD:county:LIKE(county):TYPE(STRING):0,0\n'
    + 'FIELD:geo_lat:LIKE(geo_lat):TYPE(STRING):0,0\n'
    + 'FIELD:geo_long:LIKE(geo_long):TYPE(STRING):0,0\n'
    + 'FIELD:msa:LIKE(msa):TYPE(STRING):0,0\n'
    + 'FIELD:geo_blk:LIKE(geo_blk):TYPE(STRING):0,0\n'
    + 'FIELD:geo_match:LIKE(geo_match):TYPE(STRING):0,0\n'
    + 'FIELD:err_stat:LIKE(err_stat):TYPE(STRING):0,0\n'
    + '// CONCEPT statements should be used to group together interellated fields; such as address\n'
    + '// RELATIONSHIP is used to find non-obvious relationships between the clusters\n'
    + '// SOURCEFIELD is used if a field of the file denotes a source of the records in that file\n'
    + '// LINKPATH is used to define access paths for external linking\n'
    ;
 
  // Structured values
  EXPORT linkpaths := DATASET([
    ],{STRING linkpath;STRING compulsory;STRING optional;STRING bonus;STRING required;STRING search});
 
END;

