// Machine-readable versions of the spec file and subsets thereof
EXPORT RawFileNonFCRA_GenerationMod := MODULE
 
  // SALT Version info
  EXPORT salt_VERSION := 'V3.8.0';
  EXPORT salt_MODULE := 'SALT38'; // Optional override by HACK:SALTMODULE
  EXPORT salt_TOOLSMODULE := 'SALTTOOLS30'; // Optional override by HACK:SALTTOOLSMODULE
 
  // Core module configuration values
  EXPORT spc_MODULE := 'Scrubs_ConsumerStatement';
  EXPORT spc_NAMESCOPE := 'RawFileNonFCRA';
  EXPORT spc_PROCESS := '';
  EXPORT spc_IDNAME := ''; // cluster id (input)
  EXPORT spc_IDFIELD := ''; // cluster id (output)
  EXPORT spc_RIDFIELD := ''; // record id
 
  // The entire spec file
  EXPORT spcString :=
    'OPTIONS:-gh\n'
    + 'MODULE:Scrubs_ConsumerStatement\n'
    + 'FILENAME:ConsumerStatement\n'
    + 'NAMESCOPE:RawFileNonFCRA\n'
    + '\n'
    + 'FIELDTYPE:Invalid_Number:ALLOW(0123456789)\n'
    + 'FIELDTYPE:Invalid_Date:ALLOW(0123456789 :-)\n'
    + 'FIELDTYPE:Invalid_Phone:ALLOW(0123456789):LENGTHS(0,10)\n'
    + 'FIELDTYPE:Invalid_Name:ALLOW(ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz-\' )\n'
    + 'FIELDTYPE:Invalid_State:CUSTOM(Scrubs.fn_Valid_StateAbbrev>0)\n'
    + '\n'
    + 'FIELD:statement_id:LIKE(Invalid_Number):TYPE(INTEGER8):0,0\n'
    + 'FIELD:orig_fname:LIKE(Invalid_Name):TYPE(STRING30):0,0\n'
    + 'FIELD:orig_lname:LIKE(Invalid_Name):TYPE(STRING30):0,0\n'
    + 'FIELD:orig_mname:LIKE(Invalid_Name):TYPE(STRING30):0,0\n'
    + 'FIELD:orig_cname:LIKE(Invalid_Name):TYPE(STRING100):0,0\n'
    + 'FIELD:orig_address:TYPE(STRING100):0,0\n'
    + 'FIELD:orig_city:TYPE(STRING30):0,0\n'
    + 'FIELD:orig_st:LIKE(Invalid_State):TYPE(STRING2):0,0\n'
    + 'FIELD:orig_zip:LIKE(Invalid_Number):TYPE(STRING5):0,0\n'
    + 'FIELD:orig_zip4:LIKE(Invalid_Number):TYPE(STRING4):0,0\n'
    + 'FIELD:phone:LIKE(Invalid_Phone):TYPE(STRING10):0,0\n'
    + 'FIELD:title:TYPE(STRING5):0,0\n'
    + 'FIELD:fname:LIKE(Invalid_Name):TYPE(STRING20):0,0\n'
    + 'FIELD:mname:LIKE(Invalid_Name):TYPE(STRING20):0,0\n'
    + 'FIELD:lname:LIKE(Invalid_Name):TYPE(STRING20):0,0\n'
    + 'FIELD:name_suffix:TYPE(STRING5):0,0\n'
    + 'FIELD:name_score:TYPE(STRING3):0,0\n'
    + 'FIELD:prim_range:TYPE(STRING10):0,0\n'
    + 'FIELD:predir:TYPE(STRING2):0,0\n'
    + 'FIELD:prim_name:TYPE(STRING28):0,0\n'
    + 'FIELD:addr_suffix:TYPE(STRING4):0,0\n'
    + 'FIELD:postdir:TYPE(STRING2):0,0\n'
    + 'FIELD:unit_desig:TYPE(STRING10):0,0\n'
    + 'FIELD:sec_range:TYPE(STRING8):0,0\n'
    + 'FIELD:p_city_name:TYPE(STRING25):0,0\n'
    + 'FIELD:v_city_name:TYPE(STRING25):0,0\n'
    + 'FIELD:st:LIKE(Invalid_State):TYPE(STRING2):0,0\n'
    + 'FIELD:zip:LIKE(Invalid_Number):TYPE(STRING5):0,0\n'
    + 'FIELD:zip4:LIKE(Invalid_Number):TYPE(STRING4):0,0\n'
    + 'FIELD:cart:TYPE(STRING4):0,0\n'
    + 'FIELD:cr_sort_sz:TYPE(STRING1):0,0\n'
    + 'FIELD:lot:TYPE(STRING4):0,0\n'
    + 'FIELD:lot_order:TYPE(STRING1):0,0\n'
    + 'FIELD:dbpc:TYPE(STRING2):0,0\n'
    + 'FIELD:chk_digit:TYPE(STRING1):0,0\n'
    + 'FIELD:rec_type:TYPE(STRING2):0,0\n'
    + 'FIELD:county:TYPE(STRING5):0,0\n'
    + 'FIELD:geo_lat:TYPE(STRING10):0,0\n'
    + 'FIELD:geo_long:TYPE(STRING11):0,0\n'
    + 'FIELD:msa:TYPE(STRING4):0,0\n'
    + 'FIELD:geo_blk:TYPE(STRING7):0,0\n'
    + 'FIELD:geo_match:TYPE(STRING1):0,0\n'
    + 'FIELD:err_stat:TYPE(STRING4):0,0\n'
    + 'FIELD:date_submitted:LIKE(Invalid_Date):TYPE(STRING20):0,0\n'
    + 'FIELD:date_created:LIKE(Invalid_Date):TYPE(STRING20):0,0\n'
    + 'FIELD:did:LIKE(Invalid_Number):TYPE(UNSIGNED6):0,0\n'
    + 'FIELD:consumer_text:TYPE(STRING):0,0\n'
    + 'FIELD:override_flag:LIKE(Invalid_Number):TYPE(INTEGER8):0,0\n'
    + '// CONCEPT statements should be used to group together interellated fields; such as address\n'
    + '// RELATIONSHIP is used to find non-obvious relationships between the clusters\n'
    + '// SOURCEFIELD is used if a field of the file denotes a source of the records in that file\n'
    + '// LINKPATH is used to define access paths for external linking\n'
    ;
 
  // Structured values
  EXPORT linkpaths := DATASET([
    ],{STRING linkpath;STRING compulsory;STRING optional;STRING bonus;STRING required;STRING search});
 
END;
