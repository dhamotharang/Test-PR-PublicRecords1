// Machine-readable versions of the spec file and subsets thereof
EXPORT party_GenerationMod := MODULE
 
  // SALT Version info
  EXPORT salt_VERSION := 'V3.8.0';
  EXPORT salt_MODULE := 'SALT38'; // Optional override by HACK:SALTMODULE
  EXPORT salt_TOOLSMODULE := 'SALTTOOLS30'; // Optional override by HACK:SALTTOOLSMODULE
 
  // Core module configuration values
  EXPORT spc_MODULE := 'Scrubs_SANCTNKeys';
  EXPORT spc_NAMESCOPE := 'party';
  EXPORT spc_PROCESS := '';
  EXPORT spc_IDNAME := ''; // cluster id (input)
  EXPORT spc_IDFIELD := ''; // cluster id (output)
  EXPORT spc_RIDFIELD := ''; // record id
 
  // The entire spec file
  EXPORT spcString :=
    'OPTIONS:-gh\n'
    + 'MODULE:Scrubs_SANCTNKeys\n'
    + 'FILENAME:SANCTNKeys\n'
    + 'NAMESCOPE:party\n'
    + '\n'
    + 'FIELDTYPE:Invalid_Batch:ALLOW(ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789-_):LENGTHS(1..)\n'
    + 'FIELDTYPE:Non_Blank:LENGTHS(1..)\n'
    + 'FIELDTYPE:Invalid_Num:ALLOW(0123456789)\n'
    + 'FIELDTYPE:Invalid_SSN:ALLOW(0123456789-xX)\n'
    + 'FIELDTYPE:Invalid_Zip:CUSTOM(Scrubs.fn_Valid_Zip>0)\n'
    + 'FIELDTYPE:Invalid_Money:ALLOW(0123456789.)\n'
    + 'FIELDTYPE:Invalid_Char:ALLOW(ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz)\n'
    + 'FIELDTYPE:Invalid_State:CUSTOM(Scrubs.fn_Valid_StateAbbrev>0)\n'
    + '\n'
    + 'FIELD:batch_number:LIKE(Invalid_Batch):TYPE(STRING8):0,0\n'
    + 'FIELD:incident_number:LIKE(Invalid_Num):TYPE(STRING8):0,0\n'
    + 'FIELD:party_number:LIKE(Invalid_Num):TYPE(STRING8):0,0\n'
    + 'FIELD:record_type:TYPE(STRING1):0,0\n'
    + 'FIELD:order_number:LIKE(Invalid_Num):TYPE(STRING4):0,0\n'
    + 'FIELD:party_name:LIKE(Non_Blank):TYPE(STRING45):0,0\n'
    + 'FIELD:party_position:TYPE(STRING45):0,0\n'
    + 'FIELD:party_vocation:TYPE(STRING45):0,0\n'
    + 'FIELD:party_firm:TYPE(STRING70):0,0\n'
    + 'FIELD:inaddress:TYPE(STRING45):0,0\n'
    + 'FIELD:incity:TYPE(STRING45):0,0\n'
    + 'FIELD:instate:TYPE(STRING20):0,0\n'
    + 'FIELD:inzip:LIKE(Invalid_Zip):TYPE(STRING10):0,0\n'
    + 'FIELD:ssnumber:LIKE(Invalid_SSN):TYPE(STRING11):0,0\n'
    + 'FIELD:fines_levied:LIKE(Invalid_Money):TYPE(STRING10):0,0\n'
    + 'FIELD:restitution:LIKE(Invalid_Money):TYPE(STRING10):0,0\n'
    + 'FIELD:ok_for_fcr:TYPE(STRING1):0,0\n'
    + 'FIELD:party_text:TYPE(STRING255):0,0\n'
    + 'FIELD:title:TYPE(STRING5):0,0\n'
    + 'FIELD:fname:TYPE(STRING20):0,0\n'
    + 'FIELD:mname:TYPE(STRING20):0,0\n'
    + 'FIELD:lname:TYPE(STRING20):0,0\n'
    + 'FIELD:name_suffix:TYPE(STRING5):0,0\n'
    + 'FIELD:name_score:TYPE(STRING3):0,0\n'
    + 'FIELD:cname:TYPE(STRING45):0,0\n'
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
    + 'FIELD:zip5:TYPE(STRING5):0,0\n'
    + 'FIELD:zip4:TYPE(STRING4):0,0\n'
    + 'FIELD:fips_state:TYPE(STRING2):0,0\n'
    + 'FIELD:fips_county:TYPE(STRING3):0,0\n'
    + 'FIELD:addr_rec_type:TYPE(STRING2):0,0\n'
    + 'FIELD:geo_lat:TYPE(STRING10):0,0\n'
    + 'FIELD:geo_long:TYPE(STRING11):0,0\n'
    + 'FIELD:cbsa:TYPE(STRING4):0,0\n'
    + 'FIELD:geo_blk:TYPE(STRING7):0,0\n'
    + 'FIELD:geo_match:TYPE(STRING1):0,0\n'
    + 'FIELD:cart:TYPE(STRING4):0,0\n'
    + 'FIELD:cr_sort_sz:TYPE(STRING1):0,0\n'
    + 'FIELD:lot:TYPE(STRING4):0,0\n'
    + 'FIELD:lot_order:TYPE(STRING1):0,0\n'
    + 'FIELD:dpbc:TYPE(STRING2):0,0\n'
    + 'FIELD:chk_digit:TYPE(STRING1):0,0\n'
    + 'FIELD:err_stat:TYPE(STRING4):0,0\n'
    + 'FIELD:dotid:LIKE(Invalid_Num):TYPE(UNSIGNED6):0,0\n'
    + 'FIELD:dotscore:LIKE(Invalid_Num):TYPE(UNSIGNED2):0,0\n'
    + 'FIELD:dotweight:LIKE(Invalid_Num):TYPE(UNSIGNED2):0,0\n'
    + 'FIELD:empid:LIKE(Invalid_Num):TYPE(UNSIGNED6):0,0\n'
    + 'FIELD:empscore:LIKE(Invalid_Num):TYPE(UNSIGNED2):0,0\n'
    + 'FIELD:empweight:LIKE(Invalid_Num):TYPE(UNSIGNED2):0,0\n'
    + 'FIELD:powid:LIKE(Invalid_Num):TYPE(UNSIGNED6):0,0\n'
    + 'FIELD:powscore:LIKE(Invalid_Num):TYPE(UNSIGNED2):0,0\n'
    + 'FIELD:powweight:LIKE(Invalid_Num):TYPE(UNSIGNED2):0,0\n'
    + 'FIELD:proxid:LIKE(Invalid_Num):TYPE(UNSIGNED6):0,0\n'
    + 'FIELD:proxscore:LIKE(Invalid_Num):TYPE(UNSIGNED2):0,0\n'
    + 'FIELD:proxweight:LIKE(Invalid_Num):TYPE(UNSIGNED2):0,0\n'
    + 'FIELD:seleid:LIKE(Invalid_Num):TYPE(UNSIGNED6):0,0\n'
    + 'FIELD:selescore:LIKE(Invalid_Num):TYPE(UNSIGNED2):0,0\n'
    + 'FIELD:seleweight:LIKE(Invalid_Num):TYPE(UNSIGNED2):0,0\n'
    + 'FIELD:orgid:LIKE(Invalid_Num):TYPE(UNSIGNED6):0,0\n'
    + 'FIELD:orgscore:LIKE(Invalid_Num):TYPE(UNSIGNED2):0,0\n'
    + 'FIELD:orgweight:LIKE(Invalid_Num):TYPE(UNSIGNED2):0,0\n'
    + 'FIELD:ultid:LIKE(Invalid_Num):TYPE(UNSIGNED6):0,0\n'
    + 'FIELD:ultscore:LIKE(Invalid_Num):TYPE(UNSIGNED2):0,0\n'
    + 'FIELD:ultweight:LIKE(Invalid_Num):TYPE(UNSIGNED2):0,0\n'
    + 'FIELD:source_rec_id:LIKE(Invalid_Num):TYPE(UNSIGNED8):0,0\n'
    + 'FIELD:did:LIKE(Invalid_Num):TYPE(UNSIGNED6):0,0\n'
    + 'FIELD:did_score:LIKE(Invalid_Num):TYPE(UNSIGNED3):0,0\n'
    + 'FIELD:bdid:LIKE(Invalid_Num):TYPE(UNSIGNED6):0,0\n'
    + 'FIELD:bdid_score:LIKE(Invalid_Num):TYPE(UNSIGNED3):0,0\n'
    + 'FIELD:ssn_appended:LIKE(Invalid_Num):TYPE(STRING9):0,0\n'
    + 'FIELD:dba_name:TYPE(STRING60):0,0\n'
    + 'FIELD:contact_name:TYPE(STRING30):0,0\n'
    + 'FIELD:enh_did_src:TYPE(STRING1):0,0\n'
    + '//CONCEPT statements should be used to group together interellated fields; such as address\n'
    + '//RELATIONSHIP is used to find non-obvious relationships between the clusters\n'
    + '//SOURCEFIELD is used if a field of the file denotes a source of the records in that file\n'
    + '//LINKPATH is used to define access paths for external linking\n'
    ;
 
  // Structured values
  EXPORT linkpaths := DATASET([
    ],{STRING linkpath;STRING compulsory;STRING optional;STRING bonus;STRING required;STRING search});
 
END;
