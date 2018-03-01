// Machine-readable versions of the spec file and subsets thereof
IMPORT SALT38;
EXPORT Aircraft_GenerationMod := MODULE(SALT38.iGenerationMod)
 
  // SALT Version info
  EXPORT salt_VERSION := 'V3.8.2';
  EXPORT salt_MODULE := 'SALT38'; // Optional override by HACK:SALTMODULE
  EXPORT salt_TOOLSMODULE := 'SALTTOOLS30'; // Optional override by HACK:SALTTOOLSMODULE
 
  // Core module configuration values
  EXPORT spc_MODULE := 'Scrubs_FAA';
  EXPORT spc_NAMESCOPE := 'Aircraft';
  EXPORT spc_PROCESS := '';
  EXPORT spc_IDNAME := ''; // cluster id (input)
  EXPORT spc_IDFIELD := ''; // cluster id (output)
  EXPORT spc_RIDFIELD := ''; // record id
  EXPORT spc_CONFIG := 'Config';
  EXPORT spc_FILEPREFIX := 'In_';
  EXPORT spc_FILENAME := 'FAA';
  EXPORT spc_INGESTSTATUS := '';
  EXPORT spc_HAS_TWOSTEP := FALSE;
  EXPORT spc_HAS_PARTITION := FALSE;
  EXPORT spc_HAS_FIELDTYPES := TRUE;
  EXPORT spc_HAS_INCREMENTAL := FALSE;
  EXPORT spc_HAS_ASOF := FALSE;
  EXPORT spc_HAS_NONCONTIGUOUS := FALSE;
  EXPORT spc_HAS_SUPERFILES := FALSE;
 
  // The entire spec file
  EXPORT spcString :=
    'OPTIONS:-gh\n'
    + 'MODULE:Scrubs_FAA\n'
    + 'FILENAME:FAA\n'
    + 'NAMESCOPE:Aircraft\n'
    + '\n'
    + 'FIELDTYPE:Invalid_Num:ALLOW(0123456789)\n'
    + 'FIELDTYPE:Invalid_Letter:ALLOW(ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz)\n'
    + 'FIELDTYPE:Invalid_Year:ALLOW(0123456789):LENGTHS(0,4)\n'
    + 'FIELDTYPE:Invalid_SSN:ALLOW(0123456789):Lengths(0,9)\n'
    + 'FIELDTYPE:Invalid_Date:CUSTOM(Scrubs.fn_valid_date>0)\n'
    + 'FIELDTYPE:Invalid_Flag:ENUM(H|I|A)\n'
    + 'FIELDTYPE:Invalid_AlphaNum:ALLOW(ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789 )\n'
    + 'FIELDTYPE:Invalid_Type:ENUM(0|1|2|3|4|5|6|7|8|9|10|11|)\n'
    + 'FIELDTYPE:Invalid_AlphaNumPunct:LENGTHS(1..)\n'
    + '\n'
    + 'FIELD:d_score:LIKE(Invalid_Num):TYPE(STRING3):0,0\n'
    + 'FIELD:best_ssn:LIKE(Invalid_SSN):TYPE(STRING9):0,0\n'
    + 'FIELD:did_out:LIKE(Invalid_Num):TYPE(STRING12):0,0\n'
    + 'FIELD:bdid_out:LIKE(Invalid_Num):TYPE(STRING12):0,0\n'
    + 'FIELD:date_first_seen:LIKE(Invalid_Date):TYPE(STRING8):0,0\n'
    + 'FIELD:date_last_seen:LIKE(Invalid_Date):TYPE(STRING8):0,0\n'
    + 'FIELD:current_flag:LIKE(Invalid_Flag):TYPE(STRING1):0,0\n'
    + 'FIELD:n_number:LIKE(Invalid_AlphaNum):TYPE(STRING8):0,0\n'
    + 'FIELD:serial_number:LIKE(Invalid_AlphaNumPunct):TYPE(STRING30):0,0\n'
    + 'FIELD:mfr_mdl_code:LIKE(Invalid_AlphaNum):TYPE(STRING12):0,0\n'
    + 'FIELD:eng_mfr_mdl:LIKE(Invalid_Num):TYPE(STRING11):0,0\n'
    + 'FIELD:year_mfr:LIKE(Invalid_Year):TYPE(STRING8):0,0\n'
    + 'FIELD:type_registrant:LIKE(Invalid_Type):TYPE(STRING15):0,0\n'
    + 'FIELD:name:TYPE(STRING50):0,0\n'
    + 'FIELD:street:TYPE(STRING33):0,0\n'
    + 'FIELD:street2:TYPE(STRING33):0,0\n'
    + 'FIELD:city:TYPE(STRING18):0,0\n'
    + 'FIELD:state:LIKE(Invalid_Letter):TYPE(STRING5):0,0\n'
    + 'FIELD:zip_code:TYPE(STRING10):0,0\n'
    + 'FIELD:region:LIKE(Invalid_AlphaNum):TYPE(STRING6):0,0\n'
    + 'FIELD:orig_county:LIKE(Invalid_Num):TYPE(STRING6):0,0\n'
    + 'FIELD:country:LIKE(Invalid_Letter):TYPE(STRING7):0,0\n'
    + 'FIELD:last_action_date:LIKE(Invalid_Date):TYPE(STRING16):0,0\n'
    + 'FIELD:cert_issue_date:LIKE(Invalid_Date):TYPE(STRING15):0,0\n'
    + 'FIELD:certification:LIKE(Invalid_AlphaNum):TYPE(STRING13):0,0\n'
    + 'FIELD:type_aircraft:LIKE(Invalid_Type):TYPE(STRING13):0,0\n'
    + 'FIELD:type_engine:LIKE(Invalid_Type):TYPE(STRING11):0,0\n'
    + 'FIELD:status_code:LIKE(Invalid_AlphaNum):TYPE(STRING11):0,0\n'
    + 'FIELD:mode_s_code:LIKE(Invalid_Num):TYPE(STRING11):0,0\n'
    + 'FIELD:fract_owner:TYPE(STRING11):0,0\n'
    + 'FIELD:aircraft_mfr_name:TYPE(STRING30):0,0\n'
    + 'FIELD:model_name:TYPE(STRING20):0,0\n'
    + 'FIELD:prim_range:TYPE(STRING10):0,0\n'
    + 'FIELD:predir:TYPE(STRING2):0,0\n'
    + 'FIELD:prim_name:TYPE(STRING28):0,0\n'
    + 'FIELD:addr_suffix:TYPE(STRING4):0,0\n'
    + 'FIELD:postdir:TYPE(STRING2):0,0\n'
    + 'FIELD:unit_desig:TYPE(STRING10):0,0\n'
    + 'FIELD:sec_range:TYPE(STRING8):0,0\n'
    + 'FIELD:p_city_name:TYPE(STRING25):0,0\n'
    + 'FIELD:v_city_name:TYPE(STRING25):0,0\n'
    + 'FIELD:st:TYPE(STRING2):0,0\n'
    + 'FIELD:zip:TYPE(STRING5):0,0\n'
    + 'FIELD:z4:TYPE(STRING4):0,0\n'
    + 'FIELD:cart:TYPE(STRING4):0,0\n'
    + 'FIELD:cr_sort_sz:TYPE(STRING1):0,0\n'
    + 'FIELD:lot:TYPE(STRING4):0,0\n'
    + 'FIELD:lot_order:TYPE(STRING1):0,0\n'
    + 'FIELD:dpbc:TYPE(STRING2):0,0\n'
    + 'FIELD:chk_digit:TYPE(STRING1):0,0\n'
    + 'FIELD:rec_type:TYPE(STRING2):0,0\n'
    + 'FIELD:ace_fips_st:TYPE(STRING2):0,0\n'
    + 'FIELD:county:TYPE(STRING3):0,0\n'
    + 'FIELD:geo_lat:TYPE(STRING10):0,0\n'
    + 'FIELD:geo_long:TYPE(STRING11):0,0\n'
    + 'FIELD:msa:TYPE(STRING4):0,0\n'
    + 'FIELD:geo_blk:TYPE(STRING7):0,0\n'
    + 'FIELD:geo_match:TYPE(STRING1):0,0\n'
    + 'FIELD:err_stat:TYPE(STRING4):0,0\n'
    + 'FIELD:title:TYPE(STRING5):0,0\n'
    + 'FIELD:fname:TYPE(STRING20):0,0\n'
    + 'FIELD:mname:TYPE(STRING20):0,0\n'
    + 'FIELD:lname:TYPE(STRING20):0,0\n'
    + 'FIELD:name_suffix:TYPE(STRING5):0,0\n'
    + 'FIELD:compname:TYPE(STRING50):0,0\n'
    + 'FIELD:lf:TYPE(STRING1):0,0\n'
    + 'FIELD:source_rec_id:TYPE(UNSIGNED8):0,0\n'
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
    + '// CONCEPT statements should be used to group together interellated fields; such as address\n'
    + '// RELATIONSHIP is used to find non-obvious relationships between the clusters\n'
    + '// SOURCEFIELD is used if a field of the file denotes a source of the records in that file\n'
    + '// LINKPATH is used to define access paths for external linking\n'
    ;
 
  // Structured values
  EXPORT linkpaths := DATASET([
    ],{STRING linkpath;STRING compulsory;STRING optional;STRING bonus;STRING required;STRING search});
 
END;
