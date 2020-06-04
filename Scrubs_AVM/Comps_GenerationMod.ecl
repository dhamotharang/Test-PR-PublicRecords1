// Machine-readable versions of the spec file and subsets thereof
IMPORT SALT311;
EXPORT Comps_GenerationMod := MODULE(SALT311.iGenerationMod)
 
  // SALT Version info
  EXPORT salt_VERSION := 'V3.11.9';
  EXPORT salt_MODULE := 'SALT311'; // Optional override by HACK:SALTMODULE
  EXPORT salt_TOOLSMODULE := 'SALTTOOLS30'; // Optional override by HACK:SALTTOOLSMODULE
 
  // Core module configuration values
  EXPORT spc_MODULE := 'Scrubs_AVM';
  EXPORT spc_NAMESCOPE := 'Comps';
  EXPORT spc_PROCESS := '';
  EXPORT spc_PROCLAYOUTS := 'Process__Layouts';
  EXPORT spc_IDNAME := ''; // cluster id (input)
  EXPORT spc_IDFIELD := ''; // cluster id (output)
  EXPORT spc_RIDFIELD := ''; // record id
  EXPORT spc_CONFIG := 'Config';
  EXPORT spc_CONFIGPARAM := FALSE;
  EXPORT spc_SOURCEFIELD := '';
  EXPORT spc_FILEPREFIX := 'In_';
  EXPORT spc_FILENAME := 'AVM';
  EXPORT spc_INGESTSTATUS := '';
  EXPORT spc_EXTERNAL_MAPPING := 'UniqueID:';
  EXPORT spc_EXTERNAL_BATCH_PARAM := ',/* MY_ */,seq,ln_fares_id,unformatted_apn,prim_range,predir,prim_name,suffix,postdir,unit_desig,sec_range,p_city_name,st,zip,zip4,lat,long,geo_blk,fips_code,land_use_code,sales_price,sales_price_code,recording_date,assessed_value_year,assessed_total_value,market_total_value,lot_size,building_area,year_built,no_of_stories,no_of_rooms,no_of_bedrooms,no_of_baths';
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
    + 'MODULE:Scrubs_AVM\n'
    + 'FILENAME:AVM\n'
    + 'NAMESCOPE:Comps\n'
    + '\n'
    + 'FIELDTYPE:Invalid_Date:CUSTOM(Scrubs.fn_valid_date>0)\n'
    + 'FIELDTYPE:Invalid_AlphaNum:ALLOW(ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789)\n'
    + 'FIELDTYPE:Invalid_Chars:ALLOW(ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789 .+/)\n'
    + 'FIELDTYPE:Invalid_Alpha:ALLOW(ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz)\n'
    + 'FIELDTYPE:Invalid_Num:ALLOW(0123456789 .)\n'
    + 'FIELDTYPE:Invalid_Comps:ALLOW(0123456789OAD)\n'
    + 'FIELDTYPE:Invalid_SalesPriceCode:ENUM(A|Q|U|F|Z|D|C|P|X|)\n'
    + 'FIELDTYPE:Invalid_LandUseCode:ENUM(1|2|)\n'
    + '\n'
    + '\n'
    + 'FIELD:seq:LIKE(Invalid_Num):TYPE(UNSIGNED8):0,0\n'
    + 'FIELD:ln_fares_id:LIKE(Invalid_Comps):TYPE(STRING12):0,0\n'
    + 'FIELD:unformatted_apn:LIKE(Invalid_AlphaNum):TYPE(STRING45):0,0\n'
    + 'FIELD:prim_range:TYPE(STRING10):0,0\n'
    + 'FIELD:predir:TYPE(STRING2):0,0\n'
    + 'FIELD:prim_name:TYPE(STRING28):0,0\n'
    + 'FIELD:suffix:TYPE(STRING4):0,0\n'
    + 'FIELD:postdir:TYPE(STRING2):0,0\n'
    + 'FIELD:unit_desig:TYPE(STRING10):0,0\n'
    + 'FIELD:sec_range:TYPE(STRING8):0,0\n'
    + 'FIELD:p_city_name:TYPE(STRING25):0,0\n'
    + 'FIELD:st:LIKE(Invalid_Alpha):TYPE(STRING2):0,0\n'
    + 'FIELD:zip:LIKE(Invalid_Num):TYPE(STRING5):0,0\n'
    + 'FIELD:zip4:LIKE(Invalid_Num):TYPE(STRING4):0,0\n'
    + 'FIELD:lat:TYPE(STRING10):0,0\n'
    + 'FIELD:long:TYPE(STRING11):0,0\n'
    + 'FIELD:geo_blk:TYPE(STRING7):0,0\n'
    + 'FIELD:fips_code:LIKE(Invalid_Num):TYPE(STRING5):0,0\n'
    + 'FIELD:land_use_code:LIKE(Invalid_LandUseCode):TYPE(STRING4):0,0\n'
    + 'FIELD:sales_price:LIKE(Invalid_Num):TYPE(STRING11):0,0\n'
    + 'FIELD:sales_price_code:LIKE(Invalid_SalesPriceCode):TYPE(STRING1):0,0\n'
    + 'FIELD:recording_date:LIKE(Invalid_Date):TYPE(STRING8):0,0\n'
    + 'FIELD:assessed_value_year:LIKE(Invalid_Num):TYPE(STRING4):0,0\n'
    + 'FIELD:assessed_total_value:LIKE(Invalid_Num):TYPE(STRING11):0,0\n'
    + 'FIELD:market_total_value:LIKE(Invalid_Num):TYPE(STRING11):0,0\n'
    + 'FIELD:lot_size:LIKE(Invalid_Chars):TYPE(STRING30):0,0\n'
    + 'FIELD:building_area:LIKE(Invalid_Num):TYPE(STRING9):0,0\n'
    + 'FIELD:year_built:LIKE(Invalid_Num):TYPE(STRING4):0,0\n'
    + 'FIELD:no_of_stories:LIKE(Invalid_Chars):TYPE(STRING5):0,0\n'
    + 'FIELD:no_of_rooms:LIKE(Invalid_Num):TYPE(STRING5):0,0\n'
    + 'FIELD:no_of_bedrooms:LIKE(Invalid_Num):TYPE(STRING5):0,0\n'
    + 'FIELD:no_of_baths:LIKE(Invalid_Num):TYPE(STRING7):0,0\n'
    ;
 
  // Structured values
  EXPORT linkpaths := DATASET([
    ],{STRING linkpath;STRING compulsory;STRING optional;STRING bonus;STRING required;STRING search});
 
END;

