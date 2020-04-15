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
    'OPTIONS:-gh\n'
    + 'MODULE:Scrubs_Fedex\n'
    + 'FILENAME:Fedex\n'
    + '\n'
    + 'FIELD:file_date:TYPE(STRING):0,0\n'
    + 'FIELD:record_id:TYPE(STRING):0,0\n'
    + 'FIELD:record_type:TYPE(STRING):0,0\n'
    + 'FIELD:first_name:TYPE(STRING):0,0\n'
    + 'FIELD:middle_initial:TYPE(STRING):0,0\n'
    + 'FIELD:last_name:TYPE(STRING):0,0\n'
    + 'FIELD:full_name:TYPE(STRING):0,0\n'
    + 'FIELD:company_name:TYPE(STRING):0,0\n'
    + 'FIELD:address_line1:TYPE(STRING):0,0\n'
    + 'FIELD:address_line2:TYPE(STRING):0,0\n'
    + 'FIELD:city:TYPE(STRING):0,0\n'
    + 'FIELD:state:TYPE(STRING):0,0\n'
    + 'FIELD:zip:TYPE(STRING):0,0\n'
    + 'FIELD:country:TYPE(STRING):0,0\n'
    + 'FIELD:phone:TYPE(STRING):0,0\n'
    + 'FIELD:append_prepaddr1:TYPE(STRING100):0,0\n'
    + 'FIELD:append_prepaddr2:TYPE(STRING50):0,0\n'
    + 'FIELD:append_rawaid:TYPE(UNSIGNED8):0,0\n'
    + 'FIELD:nametype:TYPE(STRING1):0,0\n'
    + 'FIELD:business_indicator:TYPE(STRING1):0,0\n'
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
    + 'FIELD:zip5:TYPE(STRING5):0,0\n'
    + 'FIELD:zip6:TYPE(STRING6):0,0\n'
    + 'FIELD:zip4:TYPE(STRING4):0,0\n'
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
    ;
 
  // Structured values
  EXPORT linkpaths := DATASET([
    ],{STRING linkpath;STRING compulsory;STRING optional;STRING bonus;STRING required;STRING search});
 
END;

