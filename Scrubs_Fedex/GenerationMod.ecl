// Machine-readable versions of the spec file and subsets thereof
IMPORT SALT311;
EXPORT GenerationMod := MODULE(SALT311.iGenerationMod)
 
  // SALT Version info
  EXPORT salt_VERSION := 'V3.11.9';
  EXPORT salt_MODULE := 'SALT311'; // Optional override by HACK:SALTMODULE
  EXPORT salt_TOOLSMODULE := 'SALTTOOLS30'; // Optional override by HACK:SALTTOOLSMODULE
 
  // Core module configuration values
  EXPORT spc_MODULE := 'Scrubs_Fedex';
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
  EXPORT spc_FILENAME := 'Fedex';
  EXPORT spc_INGESTSTATUS := '';
  EXPORT spc_EXTERNAL_MAPPING := 'UniqueID:';
  EXPORT spc_EXTERNAL_BATCH_PARAM := ',/* MY_ */,file_date,record_id,record_type,first_name,middle_initial,last_name,full_name,company_name,address_line1,address_line2,city,state,zip,country,phone,append_prepaddr1,append_prepaddr2,append_rawaid,nametype,business_indicator,prim_range,predir,prim_name,addr_suffix,postdir,unit_desig,sec_range,p_city_name,v_city_name,st,zip5,zip6,zip4,cart,cr_sort_sz,lot,lot_order,dbpc,chk_digit,rec_type,county,geo_lat,geo_long,msa,geo_blk,geo_match,err_stat';
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
    + 'MODULE:Scrubs_Fedex\n'
    + 'FILENAME:Fedex\n'
    + '\n'
    + 'FIELDTYPE:Invalid_No:ALLOW(0123456789)\n'
    + 'FIELDTYPE:Invalid_Float:ALLOW(0123456789 .-/)\n'
    + 'FIELDTYPE:Invalid_Alpha:ALLOW(ABCDEFGHIJKLMNOPQRSTUVWXYZ )\n'
    + 'FIELDTYPE:Invalid_AlphaChar:ALLOW(ABCDEFGHIJKLMNOPQRSTUVWXYZ \'-.:)\n'
    + 'FIELDTYPE:Invalid_AlphaNum:ALLOW(0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZ )\n'
    + 'FIELDTYPE:Invalid_AlphaNumChar:ALLOW(0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZ .,-/:#\')\n'
    + 'FIELDTYPE:Invalid_ID:CUSTOM(fn_valid_id > 0)\n'
    + 'FIELDTYPE:Invalid_Dir:ALLOW(NSEW)\n'
    + 'FIELDTYPE:Invalid_Date:CUSTOM(Scrubs.fn_valid_date > 0)\n'
    + 'FIELDTYPE:Invalid_Phone:LIKE(Invalid_No):LENGTHS(0,10,11)\n'
    + 'FIELDTYPE:Invalid_Zip:LIKE(Invalid_No):LENGTHS(0,5)\n'
    + 'FIELDTYPE:Invalid_State:LIKE(Invalid_Alpha):LENGTHS(0,2)\n'
    + '\n'
    + 'FIELD:file_date:TYPE(STRING):LIKE(Invalid_Date):0,0\n'
    + 'FIELD:record_id:TYPE(STRING):LIKE(Invalid_ID):0,0\n'
    + 'FIELD:record_type:TYPE(STRING):LIKE(Invalid_Alpha):0,0\n'
    + 'FIELD:first_name:TYPE(STRING):LIKE(Invalid_AlphaChar):0,0\n'
    + 'FIELD:middle_initial:TYPE(STRING):LIKE(Invalid_Alpha):0,0\n'
    + 'FIELD:last_name:TYPE(STRING):LIKE(Invalid_AlphaChar):0,0\n'
    + 'FIELD:full_name:TYPE(STRING):LIKE(Invalid_AlphaChar):0,0\n'
    + 'FIELD:company_name:TYPE(STRING):LIKE(Invalid_AlphaChar):0,0\n'
    + 'FIELD:address_line1:TYPE(STRING):LIKE(Invalid_AlphaNumChar):0,0\n'
    + 'FIELD:address_line2:TYPE(STRING):LIKE(Invalid_AlphaNumChar):0,0\n'
    + 'FIELD:city:TYPE(STRING):LIKE(Invalid_AlphaChar):0,0\n'
    + 'FIELD:state:TYPE(STRING):LIKE(Invalid_State):0,0\n'
    + 'FIELD:zip:TYPE(STRING):LIKE(Invalid_Zip):0,0\n'
    + 'FIELD:country:TYPE(STRING):LIKE(Invalid_State):0,0\n'
    + 'FIELD:phone:TYPE(STRING):LIKE(Invalid_Phone):0,0\n'
    + 'FIELD:append_prepaddr1:TYPE(STRING100):LIKE(Invalid_AlphaNumChar):0,0\n'
    + 'FIELD:append_prepaddr2:TYPE(STRING50):LIKE(Invalid_AlphaNumChar):0,0\n'
    + 'FIELD:append_rawaid:TYPE(UNSIGNED8):LIKE(Invalid_No):0,0\n'
    + 'FIELD:nametype:TYPE(STRING1):LIKE(Invalid_Alpha):0,0\n'
    + 'FIELD:business_indicator:TYPE(STRING1):LIKE(Invalid_Alpha):0,0\n'
    + 'FIELD:prim_range:TYPE(STRING10):LIKE(Invalid_No):0,0\n'
    + 'FIELD:predir:TYPE(STRING2):LIKE(Invalid_Dir):0,0\n'
    + 'FIELD:prim_name:TYPE(STRING28):LIKE(Invalid_AlphaNum):0,0\n'
    + 'FIELD:addr_suffix:TYPE(STRING4):LIKE(Invalid_Alpha):0,0\n'
    + 'FIELD:postdir:TYPE(STRING2):LIKE(Invalid_Dir):0,0\n'
    + 'FIELD:unit_desig:TYPE(STRING10):LIKE(Invalid_Alpha):0,0\n'
    + 'FIELD:sec_range:TYPE(STRING8):LIKE(Invalid_AlphaNum):0,0\n'
    + 'FIELD:p_city_name:TYPE(STRING25):LIKE(Invalid_Alpha):0,0\n'
    + 'FIELD:v_city_name:TYPE(STRING25):LIKE(Invalid_Alpha):0,0\n'
    + 'FIELD:st:TYPE(STRING2):LIKE(Invalid_State):0,0\n'
    + 'FIELD:zip5:TYPE(STRING5):LIKE(Invalid_Zip):0,0\n'
    + 'FIELD:zip6:TYPE(STRING6):LIKE(Invalid_No):0,0\n'
    + 'FIELD:zip4:TYPE(STRING4):LIKE(Invalid_No):0,0\n'
    + 'FIELD:cart:TYPE(STRING4):LIKE(Invalid_AlphaNum):0,0\n'
    + 'FIELD:cr_sort_sz:TYPE(STRING1):LIKE(Invalid_Alpha):0,0\n'
    + 'FIELD:lot:TYPE(STRING4):LIKE(Invalid_No):0,0\n'
    + 'FIELD:lot_order:TYPE(STRING1):LIKE(Invalid_Alpha):0,0\n'
    + 'FIELD:dbpc:TYPE(STRING2):LIKE(Invalid_No):0,0\n'
    + 'FIELD:chk_digit:TYPE(STRING1):LIKE(Invalid_No):0,0\n'
    + 'FIELD:rec_type:TYPE(STRING2):LIKE(Invalid_Alpha):0,0\n'
    + 'FIELD:county:TYPE(STRING5):LIKE(Invalid_No):0,0\n'
    + 'FIELD:geo_lat:TYPE(STRING10):LIKE(Invalid_Float):0,0\n'
    + 'FIELD:geo_long:TYPE(STRING11):LIKE(Invalid_Float):0,0\n'
    + 'FIELD:msa:TYPE(STRING4):LIKE(Invalid_No):0,0\n'
    + 'FIELD:geo_blk:TYPE(STRING7):LIKE(Invalid_No):0,0\n'
    + 'FIELD:geo_match:TYPE(STRING1):LIKE(Invalid_No):0,0\n'
    + 'FIELD:err_stat:TYPE(STRING4):LIKE(Invalid_AlphaNum):0,0\n'
    ;
 
  // Structured values
  EXPORT linkpaths := DATASET([
    ],{STRING linkpath;STRING compulsory;STRING optional;STRING bonus;STRING required;STRING search});
 
END;

