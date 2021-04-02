// Machine-readable versions of the spec file and subsets thereof
IMPORT SALT311;
EXPORT CarrierReferenceMain_GenerationMod := MODULE(SALT311.iGenerationMod)
 
  // SALT Version info
  EXPORT salt_VERSION := 'V3.11.11';
  EXPORT salt_MODULE := 'SALT311'; // Optional override by HACK:SALTMODULE
  EXPORT salt_TOOLSMODULE := 'SALTTOOLS30'; // Optional override by HACK:SALTTOOLSMODULE
 
  // Core module configuration values
  EXPORT spc_MODULE := 'Scrubs_PhonesInfo';
  EXPORT spc_NAMESCOPE := 'CarrierReferenceMain';
  EXPORT spc_PROCESS := '';
  EXPORT spc_PROCLAYOUTS := 'Process__Layouts';
  EXPORT spc_IDNAME := ''; // cluster id (input)
  EXPORT spc_IDFIELD := ''; // cluster id (output)
  EXPORT spc_RIDFIELD := ''; // record id
  EXPORT spc_CONFIG := 'Config';
  EXPORT spc_CONFIGPARAM := FALSE;
  EXPORT spc_SOURCEFIELD := '';
  EXPORT spc_FILEPREFIX := 'In_';
  EXPORT spc_FILENAME := 'PhonesInfo';
  EXPORT spc_INGESTSTATUS := '';
  EXPORT spc_EXTERNAL_MAPPING := 'UniqueID:';
  EXPORT spc_EXTERNAL_BATCH_PARAM := ',/* MY_ */,dt_first_reported,dt_last_reported,dt_start,dt_end,ocn,carrier_name,serv,line,prepaid,high_risk_indicator,activation_dt,number_in_service,spid,operator_full_name,is_current,override_file,data_type,ocn_state,overall_ocn,target_ocn,overall_target_ocn,ocn_abbr_name,rural_lec_indicator,small_ilec_indicator,category,carrier_address1,carrier_address2,carrier_floor,carrier_room,carrier_city,carrier_state,carrier_zip,carrier_phone,affiliated_to,overall_company,contact_function,contact_name,contact_title,contact_address1,contact_address2,contact_city,contact_state,contact_zip,contact_phone,contact_fax,contact_email,contact_information,prim_range,predir,prim_name,addr_suffix,postdir,unit_desig,sec_range,p_city_name,v_city_name,st,z5,zip4,cart,cr_sort_sz,lot,lot_order,dpbc,chk_digit,rec_type,ace_fips_st,fips_county,geo_lat,geo_long,msa,geo_blk,geo_match,err_stat,append_rawaid,address_type,privacy_indicator';
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
    + 'MODULE:Scrubs_PhonesInfo\n'
    + 'FILENAME:PhonesInfo\n'
    + 'NAMESCOPE:CarrierReferenceMain\n'
    + '\n'
    + 'FIELDTYPE:Invalid_Alpha:SPACES( ):ALLOW(ABCDEFGHIJKLMNOPQRSTUVWXYZ)\n'
    + 'FIELDTYPE:Invalid_AlphaNum:SPACES( ):ALLOW(ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789)\n'
    + 'FIELDTYPE:Invalid_Char:SPACES( ):ALLOW(ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789&-/\',.)\n'
    + 'FIELDTYPE:Invalid_Date:CUSTOM(Scrubs.fn_valid_date>0)\n'
    + 'FIELDTYPE:Invalid_Email:SPACES( ):ALLOW(ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789-@=.)\n'
    + 'FIELDTYPE:Invalid_Flag:SPACES( ):ALLOW(1)\n'
    + 'FIELDTYPE:Invalid_Indicator:SPACES( ):ALLOW(X)\n'
    + 'FIELDTYPE:Invalid_Ocn_Name:ALLOW(ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789):LENGTHS(1..)\n'
    + 'FIELDTYPE:Invalid_NotBlank:LENGTHS(1..)\n'
    + 'FIELDTYPE:Invalid_Num:SPACES( ):ALLOW(0123456789)\n'
    + 'FIELDTYPE:Invalid_SpecialChar:SPACES( ):ALLOW(ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789:/@&#-,&.\')\n'
    + 'FIELDTYPE:Invalid_Type:ALLOW(0123):LENGTHS(1)\n'
    + '\n'
    + 'FIELD:dt_first_reported:LIKE(Invalid_Date):TYPE(STRING8):0,0\n'
    + 'FIELD:dt_last_reported:LIKE(Invalid_Date):TYPE(STRING8):0,0\n'
    + 'FIELD:dt_start:LIKE(Invalid_Date):TYPE(STRING8):0,0\n'
    + 'FIELD:dt_end:LIKE(Invalid_Date):TYPE(STRING8):0,0\n'
    + 'FIELD:ocn:LIKE(Invalid_Ocn_Name):TYPE(STRING8):0,0\n'
    + 'FIELD:carrier_name:LIKE(Invalid_NotBlank):TYPE(STRING60):0,0\n'
    + 'FIELD:serv:LIKE(Invalid_Type):TYPE(STRING1):0,0\n'
    + 'FIELD:line:LIKE(Invalid_Type):TYPE(STRING1):0,0\n'
    + 'FIELD:prepaid:LIKE(Invalid_Flag):TYPE(STRING2):0,0\n'
    + 'FIELD:high_risk_indicator:LIKE(Invalid_Flag):TYPE(STRING2):0,0\n'
    + 'FIELD:activation_dt:TYPE(UNSIGNED8):0,0\n'
    + 'FIELD:number_in_service:TYPE(STRING5):0,0\n'
    + 'FIELD:spid:LIKE(Invalid_Ocn_Name):TYPE(STRING10):0,0\n'
    + 'FIELD:operator_full_name:LIKE(Invalid_NotBlank):TYPE(STRING60):0,0\n'
    + 'FIELD:is_current:TYPE(BOOLEAN1):0,0\n'
    + 'FIELD:override_file:LIKE(Invalid_Alpha):TYPE(STRING1):0,0\n'
    + 'FIELD:data_type:LIKE(Invalid_Alpha):TYPE(STRING1):0,0\n'
    + 'FIELD:ocn_state:LIKE(Invalid_Alpha):TYPE(STRING2):0,0\n'
    + 'FIELD:overall_ocn:LIKE(Invalid_AlphaNum):TYPE(STRING4):0,0\n'
    + 'FIELD:target_ocn:LIKE(Invalid_AlphaNum):TYPE(STRING4):0,0\n'
    + 'FIELD:overall_target_ocn:LIKE(Invalid_AlphaNum):TYPE(STRING4):0,0\n'
    + 'FIELD:ocn_abbr_name:TYPE(STRING25):0,0\n'
    + 'FIELD:rural_lec_indicator:LIKE(Invalid_Indicator):TYPE(STRING1):0,0\n'
    + 'FIELD:small_ilec_indicator:LIKE(Invalid_Indicator):TYPE(STRING1):0,0\n'
    + 'FIELD:category:LIKE(Invalid_Alpha):TYPE(STRING10):0,0\n'
    + 'FIELD:carrier_address1:TYPE(STRING30):0,0\n'
    + 'FIELD:carrier_address2:TYPE(STRING30):0,0\n'
    + 'FIELD:carrier_floor:TYPE(STRING15):0,0\n'
    + 'FIELD:carrier_room:TYPE(STRING15):0,0\n'
    + 'FIELD:carrier_city:LIKE(Invalid_Char):TYPE(STRING30):0,0\n'
    + 'FIELD:carrier_state:LIKE(Invalid_Alpha):TYPE(STRING2):0,0\n'
    + 'FIELD:carrier_zip:LIKE(Invalid_AlphaNum):TYPE(STRING9):0,0\n'
    + 'FIELD:carrier_phone:LIKE(Invalid_Num):TYPE(STRING10):0,0\n'
    + 'FIELD:affiliated_to:TYPE(STRING80):0,0\n'
    + 'FIELD:overall_company:TYPE(STRING45):0,0\n'
    + 'FIELD:contact_function:TYPE(STRING20):0,0\n'
    + 'FIELD:contact_name:TYPE(STRING60):0,0\n'
    + 'FIELD:contact_title:TYPE(STRING30):0,0\n'
    + 'FIELD:contact_address1:TYPE(STRING30):0,0\n'
    + 'FIELD:contact_address2:TYPE(STRING30):0,0\n'
    + 'FIELD:contact_city:LIKE(Invalid_Char):TYPE(STRING30):0,0\n'
    + 'FIELD:contact_state:LIKE(Invalid_Alpha):TYPE(STRING2):0,0\n'
    + 'FIELD:contact_zip:LIKE(Invalid_AlphaNum):TYPE(STRING9):0,0\n'
    + 'FIELD:contact_phone:LIKE(Invalid_Num):TYPE(STRING10):0,0\n'
    + 'FIELD:contact_fax:LIKE(Invalid_Num):TYPE(STRING10):0,0\n'
    + 'FIELD:contact_email:LIKE(Invalid_Email):TYPE(STRING60):0,0\n'
    + 'FIELD:contact_information:TYPE(STRING70):0,0\n'
    + '\n'
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
    + 'FIELD:z5:TYPE(STRING5):0,0\n'
    + 'FIELD:zip4:TYPE(STRING4):0,0\n'
    + 'FIELD:cart:TYPE(STRING4):0,0\n'
    + 'FIELD:cr_sort_sz:TYPE(STRING1):0,0\n'
    + 'FIELD:lot:TYPE(STRING4):0,0\n'
    + 'FIELD:lot_order:TYPE(STRING1):0,0\n'
    + 'FIELD:dpbc:TYPE(STRING2):0,0\n'
    + 'FIELD:chk_digit:TYPE(STRING1):0,0\n'
    + 'FIELD:rec_type:TYPE(STRING2):0,0\n'
    + 'FIELD:ace_fips_st:TYPE(STRING2):0,0\n'
    + 'FIELD:fips_county:TYPE(STRING3):0,0\n'
    + 'FIELD:geo_lat:TYPE(STRING10):0,0\n'
    + 'FIELD:geo_long:TYPE(STRING11):0,0\n'
    + 'FIELD:msa:TYPE(STRING4):0,0\n'
    + 'FIELD:geo_blk:TYPE(STRING7):0,0\n'
    + 'FIELD:geo_match:TYPE(STRING1):0,0\n'
    + 'FIELD:err_stat:TYPE(STRING4):0,0\n'
    + '\n'
    + 'FIELD:append_rawaid:TYPE(UNSIGNED8):0,0\n'
    + 'FIELD:address_type:TYPE(STRING5):0,0\n'
    + 'FIELD:privacy_indicator:TYPE(STRING5):0,0'
    ;
 
  // Structured values
  EXPORT linkpaths := DATASET([
    ],{STRING linkpath;STRING compulsory;STRING optional;STRING bonus;STRING required;STRING search});
 
END;

