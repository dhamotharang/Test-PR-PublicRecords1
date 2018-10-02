// Machine-readable versions of the spec file and subsets thereof
IMPORT SALT38;
EXPORT GenerationMod := MODULE(SALT38.iGenerationMod)
 
  // SALT Version info
  EXPORT salt_VERSION := 'V3.8.2';
  EXPORT salt_MODULE := 'SALT38'; // Optional override by HACK:SALTMODULE
  EXPORT salt_TOOLSMODULE := 'SALTTOOLS30'; // Optional override by HACK:SALTTOOLSMODULE
 
  // Core module configuration values
  EXPORT spc_MODULE := 'RealSource';
  EXPORT spc_NAMESCOPE := '';
  EXPORT spc_PROCESS := '';
  EXPORT spc_IDNAME := ''; // cluster id (input)
  EXPORT spc_IDFIELD := ''; // cluster id (output)
  EXPORT spc_RIDFIELD := 'RCID'; // record id
  EXPORT spc_CONFIG := 'Config';
  EXPORT spc_FILEPREFIX := 'In_';
  EXPORT spc_FILENAME := 'RealSource';
  EXPORT spc_INGESTSTATUS := '';
  EXPORT spc_HAS_TWOSTEP := FALSE;
  EXPORT spc_HAS_PARTITION := FALSE;
  EXPORT spc_HAS_FIELDTYPES := FALSE;
  EXPORT spc_HAS_INCREMENTAL := FALSE;
  EXPORT spc_HAS_ASOF := FALSE;
  EXPORT spc_HAS_NONCONTIGUOUS := FALSE;
  EXPORT spc_HAS_SUPERFILES := FALSE;
 
  // The entire spec file
  EXPORT spcString :=
    '//SALT:  _spc;\n'
    + 'OPTIONS:-gn\n'
    + 'MODULE:RealSource\n'
    + 'FILENAME:RealSource\n'
    + '\n'
    + 'RIDFIELD:RCID:GENERATE\n'
    + 'INGESTFILE:RealSource_update:NAMED(RealSource.prep_ingest_file)\n'
    + '\n'
    + 'FIELD:firstname:TYPE(STRING):0,0\n'
    + 'FIELD:middleinit:TYPE(STRING):0,0\n'
    + 'FIELD:lastname:TYPE(STRING):0,0\n'
    + 'FIELD:suffix:DERIVED:TYPE(STRING):0,0\n'
    + 'FIELD:address:DERIVED:TYPE(STRING):0,0\n'
    + 'FIELD:city:TYPE(STRING):0,0\n'
    + 'FIELD:state:TYPE(STRING2):0,0\n'
    + 'FIELD:ZipCode:TYPE(STRING5):0,0\n'
    + 'FIELD:ZipPlus4:TYPE(STRING4):0,0\n'
    + 'FIELD:phone:DERIVED:TYPE(STRING):0,0\n'
    + 'FIELD:dob:TYPE(STRING8):0,0\n'
    + 'FIELD:email:TYPE(STRING):0,0\n'
    + 'FIELD:ipaddr:DERIVED:TYPE(STRING):0,0\n'
    + 'FIELD:datestamp:DERIVED:TYPE(STRING10):0,0\n'
    + 'FIELD:url:TYPE(STRING):0,0\n'
    + 'FIELD:persistent_record_id:DERIVED:TYPE(UNSIGNED8):0,0\n'
    + 'FIELD:did:DERIVED:TYPE(UNSIGNED8):0,0\n'
    + 'FIELD:did_score:DERIVED:TYPE(UNSIGNED8):0,0\n'
    + 'FIELD:clean_title:DERIVED:TYPE(STRING5):0,0\n'
    + 'FIELD:clean_fname:DERIVED:TYPE(STRING20):0,0\n'
    + 'FIELD:clean_mname:DERIVED:TYPE(STRING20):0,0\n'
    + 'FIELD:clean_lname:DERIVED:TYPE(STRING20):0,0\n'
    + 'FIELD:clean_name_suffix:DERIVED:TYPE(STRING5):0,0\n'
    + 'FIELD:clean_name_score:DERIVED:TYPE(STRING3):0,0\n'
    + 'FIELD:rawaid:DERIVED:TYPE(UNSIGNED8):0,0\n'
    + 'FIELD:append_prep_address_situs:DERIVED:TYPE(STRING77):0,0\n'
    + 'FIELD:append_prep_address_last_situs:DERIVED:TYPE(STRING54):0,0\n'
    + 'FIELD:prim_range:DERIVED:TYPE(STRING10):0,0\n'
    + 'FIELD:predir:DERIVED:TYPE(STRING2):0,0\n'
    + 'FIELD:prim_name:DERIVED:TYPE(STRING28):0,0\n'
    + 'FIELD:addr_suffix:DERIVED:TYPE(STRING4):0,0\n'
    + 'FIELD:postdir:DERIVED:TYPE(STRING2):0,0\n'
    + 'FIELD:unit_desig:DERIVED:TYPE(STRING10):0,0\n'
    + 'FIELD:sec_range:DERIVED:TYPE(STRING8):0,0\n'
    + 'FIELD:p_city_name:DERIVED:TYPE(STRING25):0,0\n'
    + 'FIELD:v_city_name:DERIVED:TYPE(STRING25):0,0\n'
    + 'FIELD:st:DERIVED:TYPE(STRING2):0,0\n'
    + 'FIELD:zip:DERIVED:TYPE(STRING5):0,0\n'
    + 'FIELD:zip4:DERIVED:TYPE(STRING4):0,0\n'
    + 'FIELD:cart:DERIVED:TYPE(STRING4):0,0\n'
    + 'FIELD:cr_sort_sz:DERIVED:TYPE(STRING1):0,0\n'
    + 'FIELD:lot:DERIVED:TYPE(STRING4):0,0\n'
    + 'FIELD:lot_order:DERIVED:TYPE(STRING1):0,0\n'
    + 'FIELD:dbpc:DERIVED:TYPE(STRING2):0,0\n'
    + 'FIELD:chk_digit:DERIVED:TYPE(STRING1):0,0\n'
    + 'FIELD:rec_type:DERIVED:TYPE(STRING2):0,0\n'
    + 'FIELD:county:DERIVED:TYPE(STRING5):0,0\n'
    + 'FIELD:geo_lat:DERIVED:TYPE(STRING10):0,0\n'
    + 'FIELD:geo_long:DERIVED:TYPE(STRING11):0,0\n'
    + 'FIELD:msa:DERIVED:TYPE(STRING4):0,0\n'
    + 'FIELD:geo_blk:DERIVED:TYPE(STRING7):0,0\n'
    + 'FIELD:geo_match:DERIVED:TYPE(STRING1):0,0\n'
    + 'FIELD:err_stat:DERIVED:TYPE(STRING4):0,0\n'
    + 'FIELD:process_date:TYPE(STRING8):RECORDDATE(LAST):0,0\n'
    + 'FIELD:date_first_seen:TYPE(STRING8):RECORDDATE(FIRST):0,0\n'
    + 'FIELD:date_last_seen:TYPE(STRING8):RECORDDATE(LAST):0,0\n'
    + 'FIELD:date_vendor_first_reported:TYPE(STRING8):RECORDDATE(FIRST):0,0\n'
    + 'FIELD:date_vendor_last_reported:TYPE(STRING8):RECORDDATE(LAST):0,0\n'
    + 'FIELD:clean_cname:DERIVED:TYPE(STRING):0,0\n'
    + 'FIELD:current_rec:DERIVED:TYPE(BOOLEAN1):0,0\n'
    + '\n'
    + '//Future BIP addition\n'
    + '// FIELD:dotid:DERIVED:TYPE(UNSIGNED6):0,0\n'
    + '// FIELD:dotscore:DERIVED:TYPE(UNSIGNED2):0,0\n'
    + '// FIELD:dotweight:DERIVED:TYPE(UNSIGNED2):0,0\n'
    + '// FIELD:empid:DERIVED:TYPE(UNSIGNED6):0,0\n'
    + '// FIELD:empscore:DERIVED:TYPE(UNSIGNED2):0,0\n'
    + '// FIELD:empweight:DERIVED:TYPE(UNSIGNED2):0,0\n'
    + '// FIELD:powid:DERIVED:TYPE(UNSIGNED6):0,0\n'
    + '// FIELD:powscore:DERIVED:TYPE(UNSIGNED2):0,0\n'
    + '// FIELD:powweight:DERIVED:TYPE(UNSIGNED2):0,0\n'
    + '// FIELD:proxid:DERIVED:TYPE(UNSIGNED6):0,0\n'
    + '// FIELD:proxscore:DERIVED:TYPE(UNSIGNED2):0,0\n'
    + '// FIELD:proxweight:DERIVED:TYPE(UNSIGNED2):0,0\n'
    + '// FIELD:seleid:DERIVED:TYPE(UNSIGNED6):0,0\n'
    + '// FIELD:selescore:DERIVED:TYPE(UNSIGNED2):0,0\n'
    + '// FIELD:seleweight:DERIVED:TYPE(UNSIGNED2):0,0\n'
    + '// FIELD:orgid:DERIVED:TYPE(UNSIGNED6):0,0\n'
    + '// FIELD:orgscore:DERIVED:TYPE(UNSIGNED2):0,0\n'
    + '// FIELD:orgweight:DERIVED:TYPE(UNSIGNED2):0,0\n'
    + '// FIELD:ultid:DERIVED:TYPE(UNSIGNED6):0,0\n'
    + '// FIELD:ultscore:DERIVED:TYPE(UNSIGNED2):0,0\n'
    + '// FIELD:ultweight:DERIVED:TYPE(UNSIGNED2):0,0\n'
    + '\n'
    + '// CONCEPT statements should be used to group together interellated fields; such as address\n'
    + '// RELATIONSHIP is used to find non-obvious relationships between the clusters\n'
    + '// SOURCEFIELD is used if a field of the file denotes a source of the records in that file\n'
    + '// LINKPATH is used to define access paths for external linking'
    ;
 
  // Structured values
  EXPORT linkpaths := DATASET([
    ],{STRING linkpath;STRING compulsory;STRING optional;STRING bonus;STRING required;STRING search});
 
END;
