// Machine-readable versions of the spec file and subsets thereof
EXPORT Airmen_GenerationMod := MODULE
 
  // SALT Version info
  EXPORT salt_VERSION := 'V3.8.0';
  EXPORT salt_MODULE := 'SALT38'; // Optional override by HACK:SALTMODULE
  EXPORT salt_TOOLSMODULE := 'SALTTOOLS30'; // Optional override by HACK:SALTTOOLSMODULE
 
  // Core module configuration values
  EXPORT spc_MODULE := 'Scrubs_FAA';
  EXPORT spc_NAMESCOPE := 'Airmen';
  EXPORT spc_PROCESS := '';
  EXPORT spc_IDNAME := ''; // cluster id (input)
  EXPORT spc_IDFIELD := ''; // cluster id (output)
  EXPORT spc_RIDFIELD := ''; // record id
 
  // The entire spec file
  EXPORT spcString :=
    'OPTIONS:-gh\n'
    + 'MODULE:Scrubs_FAA\n'
    + 'FILENAME:FAA\n'
    + 'NAMESCOPE:Airmen\n'
    + '\n'
    + 'FIELDTYPE:Invalid_Num:ALLOW(0123456789)\n'
    + 'FIELDTYPE:Invalid_Letter:ALLOW(ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz)\n'
    + 'FIELDTYPE:Invalid_MedDate:ALLOW(0123456789):LENGTHS(0,6)\n'
    + 'FIELDTYPE:Invalid_SSN:ALLOW(0123456789):Lengths(0,9)\n'
    + 'FIELDTYPE:Invalid_Date:CUSTOM(Scrubs.fn_valid_date>0)\n'
    + 'FIELDTYPE:Invalid_Flag:ENUM(H|I|A)\n'
    + 'FIELDTYPE:Invalid_LetterCode:ENUM(A|C)\n'
    + 'FIELDTYPE:Invalid_MedClass:ENUM(1|2|3|)\n'
    + 'FIELDTYPE:Invalid_AlphaNum:ALLOW(ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789)\n'
    + '\n'
    + 'FIELD:d_score:LIKE(Invalid_Num):TYPE(STRING3):0,0\n'
    + 'FIELD:best_ssn:LIKE(Invalid_SSN):TYPE(STRING9):0,0\n'
    + 'FIELD:did_out:LIKE(Invalid_Num):TYPE(STRING12):0,0\n'
    + 'FIELD:date_first_seen:LIKE(Invalid_Date):TYPE(STRING8):0,0\n'
    + 'FIELD:date_last_seen:LIKE(Invalid_Date):TYPE(STRING8):0,0\n'
    + 'FIELD:current_flag:LIKE(Invalid_Flag):TYPE(STRING1):0,0\n'
    + 'FIELD:record_type:TYPE(STRING10):0,0\n'
    + 'FIELD:letter_code:LIKE(Invalid_LetterCode):TYPE(STRING1):0,0\n'
    + 'FIELD:unique_id:LIKE(Invalid_Num):TYPE(STRING7):0,0\n'
    + 'FIELD:orig_rec_type:TYPE(STRING2):0,0\n'
    + 'FIELD:orig_fname:TYPE(STRING30):0,0\n'
    + 'FIELD:orig_lname:TYPE(STRING30):0,0\n'
    + 'FIELD:street1:TYPE(STRING33):0,0\n'
    + 'FIELD:street2:TYPE(STRING33):0,0\n'
    + 'FIELD:city:TYPE(STRING17):0,0\n'
    + 'FIELD:state:LIKE(Invalid_Letter):TYPE(STRING2):0,0\n'
    + 'FIELD:zip_code:TYPE(STRING10):0,0\n'
    + 'FIELD:country:TYPE(STRING18):0,0\n'
    + 'FIELD:region:LIKE(Invalid_Letter):TYPE(STRING2):0,0\n'
    + 'FIELD:med_class:LIKE(Invalid_MedClass):TYPE(STRING1):0,0\n'
    + 'FIELD:med_date:LIKE(Invalid_MedDate):TYPE(STRING6):0,0\n'
    + 'FIELD:med_exp_date:LIKE(Invalid_MedDate):TYPE(STRING6):0,0\n'
    + 'FIELD:prim_range:TYPE(STRING10):0,0\n'
    + 'FIELD:predir:TYPE(STRING2):0,0\n'
    + 'FIELD:prim_name:TYPE(STRING28):0,0\n'
    + 'FIELD:suffix:TYPE(STRING4):0,0\n'
    + 'FIELD:postdir:TYPE(STRING2):0,0\n'
    + 'FIELD:unit_desig:TYPE(STRING10):0,0\n'
    + 'FIELD:sec_range:TYPE(STRING8):0,0\n'
    + 'FIELD:p_city_name:TYPE(STRING25):0,0\n'
    + 'FIELD:v_city_name:TYPE(STRING25):0,0\n'
    + 'FIELD:st:TYPE(STRING2):0,0\n'
    + 'FIELD:zip:TYPE(STRING5):0,0\n'
    + 'FIELD:zip4:TYPE(STRING4):0,0\n'
    + 'FIELD:cart:TYPE(STRING4):0,0\n'
    + 'FIELD:cr_sort_sz:TYPE(STRING1):0,0\n'
    + 'FIELD:lot:TYPE(STRING4):0,0\n'
    + 'FIELD:lot_order:TYPE(STRING1):0,0\n'
    + 'FIELD:dpbc:TYPE(STRING2):0,0\n'
    + 'FIELD:chk_digit:TYPE(STRING1):0,0\n'
    + 'FIELD:rec_type:TYPE(STRING2):0,0\n'
    + 'FIELD:ace_fips_st:TYPE(STRING2):0,0\n'
    + 'FIELD:county:TYPE(STRING3):0,0\n'
    + 'FIELD:county_name:TYPE(STRING18):0,0\n'
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
    + 'FIELD:oer:TYPE(STRING2):0,0\n'
    + 'FIELD:source:TYPE(STRING2):0,0\n'
    + '// CONCEPT statements should be used to group together interellated fields; such as address\n'
    + '// RELATIONSHIP is used to find non-obvious relationships between the clusters\n'
    + '// SOURCEFIELD is used if a field of the file denotes a source of the records in that file\n'
    + '// LINKPATH is used to define access paths for external linking\n'
    ;
 
  // Structured values
  EXPORT linkpaths := DATASET([
    ],{STRING linkpath;STRING compulsory;STRING optional;STRING bonus;STRING required;STRING search});
 
END;
