// Machine-readable versions of the spec file and subsets thereof
IMPORT SALT311;
EXPORT GenerationMod := MODULE(SALT311.iGenerationMod)
 
  // SALT Version info
  EXPORT salt_VERSION := 'V3.11.4';
  EXPORT salt_MODULE := 'SALT311'; // Optional override by HACK:SALTMODULE
  EXPORT salt_TOOLSMODULE := 'SALTTOOLS30'; // Optional override by HACK:SALTTOOLSMODULE
 
  // Core module configuration values
  EXPORT spc_MODULE := 'Scrubs_DoNotMail';
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
  EXPORT spc_FILENAME := 'DoNotMail';
  EXPORT spc_INGESTSTATUS := '';
  EXPORT spc_EXTERNAL_MAPPING := 'UniqueID:';
  EXPORT spc_EXTERNAL_BATCH_PARAM := ',/* MY_ */,title,fname,mname,lname,name_suffix,name_score,prim_range,predir,prim_name,addr_suffix,postdir,unit_desig,sec_range,p_city_name,v_city_name,st,zip,zip4,cart,cr_sort_sz,lot,lot_order,dpbc,chk_digit,rec_type,ace_fips_st,fips_county,geo_lat,geo_long,msa,geo_match,err_stat';
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
    + 'MODULE:Scrubs_DoNotMail\n'
    + 'FILENAME:DoNotMail \n'
    + '\n'
    + 'FIELDTYPE:Invalid_Char:ALLOW(ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789.-\'/ &)\n'
    + 'FIELDTYPE:Invalid_Num:ALLOW(0123456789 )\n'
    + 'FIELDTYPE:Invalid_Dir:ENUM(W|E|N|S|SW|NE|NW|SE|)\n'
    + 'FIELDTYPE:Invalid_State:ALLOW(ABCDEFGHIJKLMNOPQRSTUVWXYZ)\n'
    + 'FIELDTYPE:Invalid_CR:ENUM(D|B|C|)\n'
    + 'FIELDTYPE:Invalid_LotOrder:ENUM(A|D|)\n'
    + 'FIELDTYPE:Invalid_RecType:ENUM(S|H|P|HD|SD|M|F|R|UD|G|RD|)\n'
    + 'FIELDTYPE:Invalid_ErrStat:ALLOW(0S281E4A9365BCD7F)\n'
    + '\n'
    + '\n'
    + 'FIELD:title:LIKE(Invalid_Char):TYPE(STRING5):0,0\n'
    + 'FIELD:fname:LIKE(Invalid_Char):TYPE(STRING20):0,0\n'
    + 'FIELD:mname:LIKE(Invalid_Char):TYPE(STRING20):0,0\n'
    + 'FIELD:lname:LIKE(Invalid_Char):TYPE(STRING20):0,0\n'
    + 'FIELD:name_suffix:LIKE(Invalid_Char):TYPE(STRING5):0,0\n'
    + 'FIELD:name_score:LIKE(Invalid_Num):TYPE(STRING3):0,0\n'
    + 'FIELD:prim_range:LIKE(Invalid_Char):TYPE(STRING10):0,0\n'
    + 'FIELD:predir:LIKE(Invalid_Dir):TYPE(STRING2):0,0\n'
    + 'FIELD:prim_name:LIKE(Invalid_Char):TYPE(STRING28):0,0\n'
    + 'FIELD:addr_suffix:LIKE(Invalid_Char):TYPE(STRING4):0,0\n'
    + 'FIELD:postdir:LIKE(Invalid_Dir):TYPE(STRING2):0,0\n'
    + 'FIELD:unit_desig:LIKE(Invalid_Char):TYPE(STRING10):0,0\n'
    + 'FIELD:sec_range:LIKE(Invalid_Char):TYPE(STRING8):0,0\n'
    + 'FIELD:p_city_name:LIKE(Invalid_Char):TYPE(STRING25):0,0\n'
    + 'FIELD:v_city_name:LIKE(Invalid_Char):TYPE(STRING25):0,0\n'
    + 'FIELD:st:LIKE(Invalid_State):TYPE(STRING2):0,0\n'
    + 'FIELD:zip:LIKE(Invalid_Num):TYPE(STRING5):0,0\n'
    + 'FIELD:zip4:LIKE(Invalid_Num):TYPE(STRING4):0,0\n'
    + 'FIELD:cart:LIKE(Invalid_Char):TYPE(STRING4):0,0\n'
    + 'FIELD:cr_sort_sz:LIKE(Invalid_CR):TYPE(STRING1):0,0\n'
    + 'FIELD:lot:LIKE(Invalid_Num):TYPE(STRING4):0,0\n'
    + 'FIELD:lot_order:LIKE(Invalid_LotOrder):TYPE(STRING1):0,0\n'
    + 'FIELD:dpbc:LIKE(Invalid_Num):TYPE(STRING2):0,0\n'
    + 'FIELD:chk_digit:LIKE(Invalid_Num):TYPE(STRING1):0,0\n'
    + 'FIELD:rec_type:LIKE(Invalid_RecType):TYPE(STRING2):0,0\n'
    + 'FIELD:ace_fips_st:LIKE(Invalid_Num):TYPE(STRING2):0,0\n'
    + 'FIELD:fips_county:LIKE(Invalid_Num):TYPE(STRING3):0,0\n'
    + 'FIELD:geo_lat:TYPE(STRING10):0,0\n'
    + 'FIELD:geo_long:TYPE(STRING11):0,0\n'
    + 'FIELD:msa:TYPE(STRING4):0,0\n'
    + 'FIELD:geo_match:LIKE(Invalid_Num):TYPE(STRING1):0,0\n'
    + 'FIELD:err_stat:TYPE(STRING4):0,0\n'
    + '// CONCEPT statements should be used to group together interellated fields; such as address\n'
    + '// RELATIONSHIP is used to find non-obvious relationships between the clusters\n'
    + '// SOURCEFIELD is used if a field of the file denotes a source of the records in that file\n'
    + '// LINKPATH is used to define access paths for external linking\n'
    ;
 
  // Structured values
  EXPORT linkpaths := DATASET([
    ],{STRING linkpath;STRING compulsory;STRING optional;STRING bonus;STRING required;STRING search});
 
END;

