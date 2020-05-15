// Machine-readable versions of the spec file and subsets thereof
IMPORT SALT311;
EXPORT GenerationMod := MODULE(SALT311.iGenerationMod)
 
  // SALT Version info
  EXPORT salt_VERSION := 'V3.11.11';
  EXPORT salt_MODULE := 'SALT311'; // Optional override by HACK:SALTMODULE
  EXPORT salt_TOOLSMODULE := 'SALTTOOLS30'; // Optional override by HACK:SALTTOOLSMODULE
 
  // Core module configuration values
  EXPORT spc_MODULE := 'Scrubs_Patriot';
  EXPORT spc_NAMESCOPE := '';
  EXPORT spc_PROCESS := '';
  EXPORT spc_PROCLAYOUTS := 'Process__Layouts';
  EXPORT spc_IDNAME := ''; // cluster id (input)
  EXPORT spc_IDFIELD := ''; // cluster id (output)
  EXPORT spc_RIDFIELD := ''; // record id
  EXPORT spc_CONFIG := 'Config';
  EXPORT spc_CONFIGPARAM := FALSE;
  EXPORT spc_SOURCEFIELD := 'src_key';
  EXPORT spc_FILEPREFIX := 'In_';
  EXPORT spc_FILENAME := 'Patriot';
  EXPORT spc_INGESTSTATUS := '';
  EXPORT spc_EXTERNAL_MAPPING := 'UniqueID:';
  EXPORT spc_EXTERNAL_BATCH_PARAM := ',/* MY_ */,pty_key,source,orig_pty_name,orig_vessel_name,country,name_type,addr_1,addr_2,addr_3,addr_4,addr_5,addr_6,addr_7,addr_8,addr_9,addr_10,remarks_1,remarks_2,remarks_3,remarks_4,remarks_5,remarks_6,remarks_7,remarks_8,remarks_9,remarks_10,remarks_11,remarks_12,remarks_13,remarks_14,remarks_15,remarks_16,remarks_17,remarks_18,remarks_19,remarks_20,remarks_21,remarks_22,remarks_23,remarks_24,remarks_25,remarks_26,remarks_27,remarks_28,remarks_29,remarks_30,cname,title,fname,mname,lname,suffix,a_score,prim_range,predir,prim_name,addr_suffix,postdir,unit_desig,sec_range,p_city_name,v_city_name,st,zip,zip4,cart,cr_sort_sz,lot,lot_order,dpbc,chk_digit,record_type,ace_fips_st,county,geo_lat,geo_long,msa,geo_blk,geo_match,err_stat,global_sid,record_sid,did,aid_prim_range,aid_predir,aid_prim_name,aid_addr_suffix,aid_postdir,aid_unit_desig,aid_sec_range,aid_p_city_name,aid_v_city_name,aid_st,aid_zip,aid_zip4,aid_cart,aid_cr_sort_sz,aid_lot,aid_lot_order,aid_dpbc,aid_chk_digit,aid_record_type,aid_fips_st,aid_county,aid_geo_lat,aid_geo_long,aid_msa,aid_geo_blk,aid_geo_match,aid_err_stat,append_rawaid';
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
    + 'MODULE:Scrubs_Patriot\n'
    + 'FILENAME:Patriot\n'
    + '\n'
    + 'SOURCEFIELD:src_key\n'
    + '\n'
    + 'FIELDTYPE:invalid_alpha:SPACES( ):ALLOW(ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyzÃ¯-"&\'()./,#)\n'
    + 'FIELDTYPE:invalid_alphanumeric:ALLOW(ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789Ã¯:;-.@%&*()\'#/`$!_,):SPACES( <>{}[]^=+#?|")\n'
    + 'FIELDTYPE:invalid_country_name:ALLOW(0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz()/-&\'-.,:#):SPACES( ):NOQUOTES(")\n'
    + '//FIELDTYPE:invalid_address:SPACES( .#-&/:;-()"\\>\',):ALLOW(*`@+0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz)\n'
    + 'FIELDTYPE:invalid_address:CUSTOM(Scrubs_Patriot.Fn_Allow_ws > 0, \'AlphaNumChar\')\n'
    + 'FIELDTYPE:invalid_zip:SPACES( ):ALLOW(0123456789):LENGTHS(0,5,9)\n'
    + 'FIELDTYPE:invalid_zip4:SPACES( ):ALLOW(0123456789):LENGTHS(0,4)\n'
    + 'FIELDTYPE:invalid_source:CUSTOM(Scrubs_Patriot.fn_valid_source > 0)\n'
    + 'FIELDTYPE:invalid_source_code:CUSTOM(Scrubs_Patriot.fn_valid_source_code > 0):ALLOW(0123456789/-ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz):SPACES( )\n'
    + 'FIELDTYPE:invalid_name:CUSTOM(Scrubs_Patriot.fn_valid_name >0)\n'
    + 'FIELDTYPE:invalid_name_type:ENUM(AKA|DBA|FKA|COUNTRY|ENTITY|GOOD AKA|LOW AKA|PRIMARY|STRONG AKA|STRONG FKA|STRONG NKA|WEAK AKA|WEAK FKA| )\n'
    + 'FIELDTYPE:invalid_suffix:ENUM(SR|JR|I|II|III|IV|V|VI|VII|VIII|IX|X|8TH| )\n'
    + '\n'
    + 'FIELD:pty_key:TYPE(STRING10):LIKE(invalid_source_code):0,0\n'
    + 'FIELD:source:TYPE(STRING60):LIKE(invalid_source):0,0\n'
    + 'FIELD:orig_pty_name:TYPE(STRING350):LIKE(invalid_name):0,0\n'
    + 'FIELD:orig_vessel_name:TYPE(STRING350):0,0\n'
    + 'FIELD:country:TYPE(STRING100):LIKE(invalid_country_name):0,0\n'
    + 'FIELD:name_type:TYPE(STRING10):LIKE(invalid_name_type):0,0\n'
    + 'FIELD:addr_1:TYPE(STRING50):LIKE(invalid_address):0,0\n'
    + 'FIELD:addr_2:TYPE(STRING50):LIKE(invalid_address):0,0\n'
    + 'FIELD:addr_3:TYPE(STRING50):LIKE(invalid_address):0,0\n'
    + 'FIELD:addr_4:TYPE(STRING50):LIKE(invalid_address):0,0\n'
    + 'FIELD:addr_5:TYPE(STRING50):LIKE(invalid_address):0,0\n'
    + 'FIELD:addr_6:TYPE(STRING50):LIKE(invalid_address):0,0\n'
    + 'FIELD:addr_7:TYPE(STRING50):LIKE(invalid_address):0,0\n'
    + 'FIELD:addr_8:TYPE(STRING50):LIKE(invalid_address):0,0\n'
    + 'FIELD:addr_9:TYPE(STRING50):LIKE(invalid_address):0,0\n'
    + 'FIELD:addr_10:TYPE(STRING50):LIKE(invalid_address):0,0\n'
    + 'FIELD:remarks_1:TYPE(STRING75):0,0\n'
    + 'FIELD:remarks_2:TYPE(STRING75):0,0\n'
    + 'FIELD:remarks_3:TYPE(STRING75):0,0\n'
    + 'FIELD:remarks_4:TYPE(STRING75):0,0\n'
    + 'FIELD:remarks_5:TYPE(STRING75):0,0\n'
    + 'FIELD:remarks_6:TYPE(STRING75):0,0\n'
    + 'FIELD:remarks_7:TYPE(STRING75):0,0\n'
    + 'FIELD:remarks_8:TYPE(STRING75):0,0\n'
    + 'FIELD:remarks_9:TYPE(STRING75):0,0\n'
    + 'FIELD:remarks_10:TYPE(STRING75):0,0\n'
    + 'FIELD:remarks_11:TYPE(STRING75):0,0\n'
    + 'FIELD:remarks_12:TYPE(STRING75):0,0\n'
    + 'FIELD:remarks_13:TYPE(STRING75):0,0\n'
    + 'FIELD:remarks_14:TYPE(STRING75):0,0\n'
    + 'FIELD:remarks_15:TYPE(STRING75):0,0\n'
    + 'FIELD:remarks_16:TYPE(STRING75):0,0\n'
    + 'FIELD:remarks_17:TYPE(STRING75):0,0\n'
    + 'FIELD:remarks_18:TYPE(STRING75):0,0\n'
    + 'FIELD:remarks_19:TYPE(STRING75):0,0\n'
    + 'FIELD:remarks_20:TYPE(STRING75):0,0\n'
    + 'FIELD:remarks_21:TYPE(STRING75):0,0\n'
    + 'FIELD:remarks_22:TYPE(STRING75):0,0\n'
    + 'FIELD:remarks_23:TYPE(STRING75):0,0\n'
    + 'FIELD:remarks_24:TYPE(STRING75):0,0\n'
    + 'FIELD:remarks_25:TYPE(STRING75):0,0\n'
    + 'FIELD:remarks_26:TYPE(STRING75):0,0\n'
    + 'FIELD:remarks_27:TYPE(STRING75):0,0\n'
    + 'FIELD:remarks_28:TYPE(STRING75):0,0\n'
    + 'FIELD:remarks_29:TYPE(STRING75):0,0\n'
    + 'FIELD:remarks_30:TYPE(STRING75):0,0\n'
    + 'FIELD:cname:TYPE(STRING350):LIKE(invalid_alphanumeric):0,0\n'
    + 'FIELD:title:TYPE(STRING5):LIKE(invalid_name):0,0\n'
    + 'FIELD:fname:TYPE(STRING20):LIKE(invalid_name):0,0\n'
    + 'FIELD:mname:TYPE(STRING20):LIKE(invalid_name):0,0\n'
    + 'FIELD:lname:TYPE(STRING20):LIKE(invalid_name):0,0\n'
    + 'FIELD:suffix:TYPE(STRING5):LIKE(invalid_suffix):0,0\n'
    + 'FIELD:a_score:TYPE(STRING3):0,0\n'
    + 'FIELD:prim_range:TYPE(STRING10):LIKE(invalid_address):0,0\n'
    + 'FIELD:predir:TYPE(STRING2):LIKE(invalid_address):0,0\n'
    + 'FIELD:prim_name:TYPE(STRING28):LIKE(invalid_address):0,0\n'
    + 'FIELD:addr_suffix:TYPE(STRING4):LIKE(invalid_address):0,0\n'
    + 'FIELD:postdir:TYPE(STRING2):LIKE(invalid_address):0,0\n'
    + 'FIELD:unit_desig:TYPE(STRING10):LIKE(invalid_address):0,0\n'
    + 'FIELD:sec_range:TYPE(STRING8):LIKE(invalid_address):0,0\n'
    + 'FIELD:p_city_name:TYPE(STRING25):LIKE(invalid_alpha):0,0\n'
    + 'FIELD:v_city_name:TYPE(STRING25):LIKE(invalid_alpha):0,0\n'
    + 'FIELD:st:TYPE(STRING2):LIKE(invalid_alpha):0,0\n'
    + 'FIELD:zip:TYPE(STRING5):LIKE(invalid_zip):0,0\n'
    + 'FIELD:zip4:TYPE(STRING4):LIKE(invalid_zip4):0,0\n'
    + 'FIELD:cart:TYPE(STRING4):0,0\n'
    + 'FIELD:cr_sort_sz:TYPE(STRING1):0,0\n'
    + 'FIELD:lot:TYPE(STRING4):0,0\n'
    + 'FIELD:lot_order:TYPE(STRING1):0,0\n'
    + 'FIELD:dpbc:TYPE(STRING2):0,0\n'
    + 'FIELD:chk_digit:TYPE(STRING1):0,0\n'
    + 'FIELD:record_type:TYPE(STRING2):0,0\n'
    + 'FIELD:ace_fips_st:TYPE(STRING2):0,0\n'
    + 'FIELD:county:TYPE(STRING3):0,0\n'
    + 'FIELD:geo_lat:TYPE(STRING10):0,0\n'
    + 'FIELD:geo_long:TYPE(STRING11):0,0\n'
    + 'FIELD:msa:TYPE(STRING4):0,0\n'
    + 'FIELD:geo_blk:TYPE(STRING7):0,0\n'
    + 'FIELD:geo_match:TYPE(STRING1):0,0\n'
    + 'FIELD:err_stat:TYPE(STRING4):0,0\n'
    + 'FIELD:global_sid:TYPE(UNSIGNED4):0,0\n'
    + 'FIELD:record_sid:TYPE(UNSIGNED8):0,0\n'
    + 'FIELD:did:TYPE(UNSIGNED6):0,0\n'
    + 'FIELD:aid_prim_range:TYPE(STRING10):0,0\n'
    + 'FIELD:aid_predir:TYPE(STRING2):0,0\n'
    + 'FIELD:aid_prim_name:TYPE(STRING28):0,0\n'
    + 'FIELD:aid_addr_suffix:TYPE(STRING4):0,0\n'
    + 'FIELD:aid_postdir:TYPE(STRING2):0,0\n'
    + 'FIELD:aid_unit_desig:TYPE(STRING10):0,0\n'
    + 'FIELD:aid_sec_range:TYPE(STRING8):0,0\n'
    + 'FIELD:aid_p_city_name:TYPE(STRING25):0,0\n'
    + 'FIELD:aid_v_city_name:TYPE(STRING25):0,0\n'
    + 'FIELD:aid_st:TYPE(STRING2):0,0\n'
    + 'FIELD:aid_zip:TYPE(STRING5):0,0\n'
    + 'FIELD:aid_zip4:TYPE(STRING4):0,0\n'
    + 'FIELD:aid_cart:TYPE(STRING4):0,0\n'
    + 'FIELD:aid_cr_sort_sz:TYPE(STRING1):0,0\n'
    + 'FIELD:aid_lot:TYPE(STRING4):0,0\n'
    + 'FIELD:aid_lot_order:TYPE(STRING1):0,0\n'
    + 'FIELD:aid_dpbc:TYPE(STRING2):0,0\n'
    + 'FIELD:aid_chk_digit:TYPE(STRING1):0,0\n'
    + 'FIELD:aid_record_type:TYPE(STRING2):0,0\n'
    + 'FIELD:aid_fips_st:TYPE(STRING2):0,0\n'
    + 'FIELD:aid_county:TYPE(STRING3):0,0\n'
    + 'FIELD:aid_geo_lat:TYPE(STRING10):0,0\n'
    + 'FIELD:aid_geo_long:TYPE(STRING11):0,0\n'
    + 'FIELD:aid_msa:TYPE(STRING4):0,0\n'
    + 'FIELD:aid_geo_blk:TYPE(STRING7):0,0\n'
    + 'FIELD:aid_geo_match:TYPE(STRING1):0,0\n'
    + 'FIELD:aid_err_stat:TYPE(STRING4):0,0\n'
    + 'FIELD:append_rawaid:TYPE(UNSIGNED8):0,0\n'
    + '// CONCEPT statements should be used to group together interellated fields; such as address\n'
    + '// RELATIONSHIP is used to find non-obvious relationships between the clusters\n'
    + '// SOURCEFIELD is used if a field of the file denotes a source of the records in that file\n'
    + '// LINKPATH is used to define access paths for external linking\n'
    ;
 
  // Structured values
  EXPORT linkpaths := DATASET([
    ],{STRING linkpath;STRING compulsory;STRING optional;STRING bonus;STRING required;STRING search});
 
END;

