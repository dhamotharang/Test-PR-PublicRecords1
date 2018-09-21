// Machine-readable versions of the spec file and subsets thereof
IMPORT SALT311;
EXPORT GenerationMod := MODULE(SALT311.iGenerationMod)
 
  // SALT Version info
  EXPORT salt_VERSION := 'V3.11.4';
  EXPORT salt_MODULE := 'SALT311'; // Optional override by HACK:SALTMODULE
  EXPORT salt_TOOLSMODULE := 'SALTTOOLS30'; // Optional override by HACK:SALTTOOLSMODULE
 
  // Core module configuration values
  EXPORT spc_MODULE := 'Acquireweb_Email';
  EXPORT spc_NAMESCOPE := '';
  EXPORT spc_PROCESS := '';
  EXPORT spc_PROCLAYOUTS := 'Process__Layouts';
  EXPORT spc_IDNAME := ''; // cluster id (input)
  EXPORT spc_IDFIELD := ''; // cluster id (output)
  EXPORT spc_RIDFIELD := 'RCID'; // record id
  EXPORT spc_CONFIG := 'Config';
  EXPORT spc_CONFIGPARAM := FALSE;
  EXPORT spc_SOURCEFIELD := '';
  EXPORT spc_FILEPREFIX := 'In_';
  EXPORT spc_FILENAME := 'Acquireweb';
  EXPORT spc_INGESTSTATUS := '';
  EXPORT spc_EXTERNAL_MAPPING := 'UniqueID:RCID';
  EXPORT spc_EXTERNAL_BATCH_PARAM := ',/* MY_ */,awid,firstname,lastname,address1,address2,city,state,zip,zip4,emailid,email,activecode,did,did_score,aid,clean_title,clean_fname,clean_mname,clean_lname,clean_name_suffix,clean_prim_range,clean_predir,clean_prim_name,clean_addr_suffix,clean_postdir,clean_unit_desig,clean_sec_range,clean_p_city_name,clean_v_city_name,clean_st,clean_zip,clean_zip4,clean_cart,clean_cr_sort_sz,clean_lot,clean_lot_order,clean_dbpc,clean_chk_digit,clean_rec_type,clean_county,clean_geo_lat,clean_geo_long,clean_msa,clean_geo_blk,clean_geo_match,clean_err_stat,date_first_seen,date_last_seen,date_vendor_first_reported,date_vendor_last_reported,current_rec';
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
    '//SALT:  _SPC;\n'
    + 'OPTIONS:-gn\n'
    + 'MODULE:Acquireweb_Email\n'
    + 'FILENAME:Acquireweb\n'
    + '\n'
    + '//IDFIELD:EXISTS:AWID\n'
    + 'RIDFIELD:RCID:GENERATE\n'
    + 'INGESTFILE:Individual_update:NAMED(Acquireweb_Email.prep_ingest)\n'
    + '\n'
    + 'FIELD:awid:TYPE(STRING):0,0\n'
    + 'FIELD:firstname:TYPE(STRING):0,0\n'
    + 'FIELD:lastname:TYPE(STRING):0,0\n'
    + 'FIELD:address1:DERIVED:TYPE(STRING):0,0\n'
    + 'FIELD:address2:DERIVED:TYPE(STRING):0,0\n'
    + 'FIELD:city:TYPE(STRING):0,0\n'
    + 'FIELD:state:TYPE(STRING):0,0\n'
    + 'FIELD:zip:TYPE(STRING):0,0\n'
    + 'FIELD:zip4:TYPE(STRING):0,0\n'
    + 'FIELD:emailid:DERIVED:TYPE(STRING):0,0\n'
    + 'FIELD:email:TYPE(STRING):0,0\n'
    + 'FIELD:activecode:DERIVED:TYPE(STRING):0,0\n'
    + 'FIELD:did:DERIVED:TYPE(UNSIGNED8):0,0\n'
    + 'FIELD:did_score:DERIVED:TYPE(UNSIGNED8):0,0\n'
    + 'FIELD:aid:DERIVED:TYPE(UNSIGNED8):0,0\n'
    + 'FIELD:clean_title:DERIVED:TYPE(STRING5):0,0\n'
    + 'FIELD:clean_fname:DERIVED:TYPE(STRING20):0,0\n'
    + 'FIELD:clean_mname:DERIVED:TYPE(STRING20):0,0\n'
    + 'FIELD:clean_lname:DERIVED:TYPE(STRING20):0,0\n'
    + 'FIELD:clean_name_suffix:DERIVED:TYPE(STRING5):0,0\n'
    + 'FIELD:clean_prim_range:DERIVED:TYPE(STRING10):0,0\n'
    + 'FIELD:clean_predir:DERIVED:TYPE(STRING2):0,0\n'
    + 'FIELD:clean_prim_name:DERIVED:TYPE(STRING28):0,0\n'
    + 'FIELD:clean_addr_suffix:DERIVED:TYPE(STRING4):0,0\n'
    + 'FIELD:clean_postdir:DERIVED:TYPE(STRING2):0,0\n'
    + 'FIELD:clean_unit_desig:DERIVED:TYPE(STRING10):0,0\n'
    + 'FIELD:clean_sec_range:DERIVED:TYPE(STRING8):0,0\n'
    + 'FIELD:clean_p_city_name:DERIVED:TYPE(STRING25):0,0\n'
    + 'FIELD:clean_v_city_name:DERIVED:TYPE(STRING25):0,0\n'
    + 'FIELD:clean_st:DERIVED:TYPE(STRING2):0,0\n'
    + 'FIELD:clean_zip:DERIVED:TYPE(STRING5):0,0\n'
    + 'FIELD:clean_zip4:DERIVED:TYPE(STRING4):0,0\n'
    + 'FIELD:clean_cart:DERIVED:TYPE(STRING4):0,0\n'
    + 'FIELD:clean_cr_sort_sz:DERIVED:TYPE(STRING1):0,0\n'
    + 'FIELD:clean_lot:DERIVED:TYPE(STRING4):0,0\n'
    + 'FIELD:clean_lot_order:DERIVED:TYPE(STRING1):0,0\n'
    + 'FIELD:clean_dbpc:DERIVED:TYPE(STRING2):0,0\n'
    + 'FIELD:clean_chk_digit:DERIVED:TYPE(STRING1):0,0\n'
    + 'FIELD:clean_rec_type:DERIVED:TYPE(STRING2):0,0\n'
    + 'FIELD:clean_county:DERIVED:TYPE(STRING5):0,0\n'
    + 'FIELD:clean_geo_lat:DERIVED:TYPE(STRING10):0,0\n'
    + 'FIELD:clean_geo_long:DERIVED:TYPE(STRING11):0,0\n'
    + 'FIELD:clean_msa:DERIVED:TYPE(STRING4):0,0\n'
    + 'FIELD:clean_geo_blk:DERIVED:TYPE(STRING7):0,0\n'
    + 'FIELD:clean_geo_match:DERIVED:TYPE(STRING1):0,0\n'
    + 'FIELD:clean_err_stat:DERIVED:TYPE(STRING4):0,0\n'
    + 'FIELD:date_first_seen:TYPE(STRING8):RECORDDATE(FIRST):0,0\n'
    + 'FIELD:date_last_seen:TYPE(STRING8):RECORDDATE(LAST):0,0\n'
    + 'FIELD:date_vendor_first_reported:TYPE(STRING8):RECORDDATE(FIRST):0,0\n'
    + 'FIELD:date_vendor_last_reported:TYPE(STRING8):RECORDDATE(LAST):0,0\n'
    + 'FIELD:current_rec:DERIVED:TYPE(BOOLEAN1):0,0\n'
    + '\n'
    + '// CONCEPT statements should be used to group together interellated fields; such as address\n'
    + '// RELATIONSHIP is used to find non-obvious relationships between the clusters\n'
    + '// SOURCEFIELD is used if a field of the file denotes a source of the records in that file\n'
    + '// LINKPATH is used to define access paths for external linking\n'
    ;
 
  // Structured values
  EXPORT linkpaths := DATASET([
    ],{STRING linkpath;STRING compulsory;STRING optional;STRING bonus;STRING required;STRING search});
 
END;

