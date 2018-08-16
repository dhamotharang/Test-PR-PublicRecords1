// Machine-readable versions of the spec file and subsets thereof
IMPORT SALT311;
EXPORT GenerationMod := MODULE(SALT311.iGenerationMod)
 
  // SALT Version info
  EXPORT salt_VERSION := 'V3.11.4';
  EXPORT salt_MODULE := 'SALT311'; // Optional override by HACK:SALTMODULE
  EXPORT salt_TOOLSMODULE := 'SALTTOOLS30'; // Optional override by HACK:SALTTOOLSMODULE
 
  // Core module configuration values
  EXPORT spc_MODULE := 'Scrubs_PCNSR';
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
  EXPORT spc_FILENAME := 'PCNSR';
  EXPORT spc_INGESTSTATUS := '';
  EXPORT spc_EXTERNAL_MAPPING := 'UniqueID:';
  EXPORT spc_EXTERNAL_BATCH_PARAM := ',/* MY_ */,title,fname,mname,lname,name_suffix,name_score,fname_orig,mname_orig,lname_orig,name_suffix_orig,title_orig,prim_range,predir,prim_name,addr_suffix,postdir,unit_desig,sec_range,p_city_name,v_city_name,st,zip,zip4,cart,cr_sort_sz,lot,lot_order,dbpc,chk_digit,rec_type,county,geo_lat,geo_long,msa,geo_blk,geo_match,err_stat,hhid,did,did_score,phone_fordid,gender,date_of_birth,address_type,demographic_level_indicator,length_of_residence,location_type,dqi2_occupancy_count,delivery_unit_size,household_arrival_date,area_code,phone_number,telephone_number_type,phone2_number,telephone2_number_type,time_zone,refresh_date,name_address_verification_source,drop_indicator,do_not_mail_flag,do_not_call_flag,business_file_hit_flag,spouse_title,spouse_fname,spouse_mname,spouse_lname,spouse_name_suffix,spouse_fname_orig,spouse_mname_orig,spouse_lname_orig,spouse_name_suffix_orig,spouse_title_orig,spouse_gender,spouse_date_of_birth,spouse_indicator,household_income,find_income_in_1000s,phhincomeunder25k,phhincome50kplus,phhincome200kplus,medianhhincome,own_rent,homeowner_source_code,telephone_acquisition_date,recency_date,source';
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
    + 'MODULE:Scrubs_PCNSR\n'
    + 'FILENAME:PCNSR\n'
    + '\n'
    + 'FIELDTYPE:Invalid_Char:ALLOW(ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789\\(\\)-.\'/& )\n'
    + 'FIELDTYPE:Invalid_Num:ALLOW(-0123456789. )\n'
    + 'FIELDTYPE:Invalid_CRSORT:ENUM(D|B|C|A|)\n'
    + 'FIELDTYPE:Invalid_LotOrder:ENUM(A|D|)\n'
    + 'FIELDTYPE:Invalid_RecType:ENUM(S|H|HD|P|SD|F|R|RD|UD|G|GD|)\n'
    + 'FIELDTYPE:Invalid_DemographicIndicator:ENUM(B|Z|N|)\n'
    + 'FIELDTYPE:Invalid_Gender:ENUM(M|F|U|)\n'
    + 'FIELDTYPE:Invalid_LocationType:ENUM(S|M|U|T|R|N|)\n'
    + 'FIELDTYPE:Invalid_TelephoneNumberType:ENUM(V|G|U|F|B|T|O|C|M|D|P|)\n'
    + 'FIELDTYPE:Invalid_TimeZone:ENUM(E|C|P|M|H|A|)\n'
    + 'FIELDTYPE:Invalid_YN:ENUM(Y|N|)\n'
    + 'FIELDTYPE:Invalid_HomeownerCode:ENUM(R|I|D|P|O|)\n'
    + 'FIELDTYPE:Invalid_Source:ENUM(T|P|)\n'
    + '\n'
    + 'FIELD:title:LIKE(Invalid_Char):TYPE(STRING5):0,0\n'
    + 'FIELD:fname:LIKE(Invalid_Char):TYPE(STRING20):0,0\n'
    + 'FIELD:mname:LIKE(Invalid_Char):TYPE(STRING20):0,0\n'
    + 'FIELD:lname:LIKE(Invalid_Char):TYPE(STRING20):0,0\n'
    + 'FIELD:name_suffix:TYPE(STRING5):0,0\n'
    + 'FIELD:name_score:LIKE(Invalid_Char):TYPE(STRING3):0,0\n'
    + 'FIELD:fname_orig:LIKE(Invalid_Char):TYPE(STRING15):0,0\n'
    + 'FIELD:mname_orig:LIKE(Invalid_Char):TYPE(STRING1):0,0\n'
    + 'FIELD:lname_orig:LIKE(Invalid_Char):TYPE(STRING20):0,0\n'
    + 'FIELD:name_suffix_orig:LIKE(Invalid_Char):TYPE(STRING2):0,0\n'
    + 'FIELD:title_orig:LIKE(Invalid_Char):TYPE(STRING1):0,0\n'
    + 'FIELD:prim_range:TYPE(STRING10):0,0\n'
    + 'FIELD:predir:TYPE(STRING2):0,0\n'
    + 'FIELD:prim_name:TYPE(STRING28):0,0\n'
    + 'FIELD:addr_suffix:TYPE(STRING4):0,0\n'
    + 'FIELD:postdir:TYPE(STRING2):0,0\n'
    + 'FIELD:unit_desig:TYPE(STRING10):0,0\n'
    + 'FIELD:sec_range:TYPE(STRING8):0,0\n'
    + 'FIELD:p_city_name:TYPE(STRING25):0,0\n'
    + 'FIELD:v_city_name:TYPE(STRING25):0,0\n'
    + 'FIELD:st:LIKE(Invalid_Char):TYPE(STRING2):0,0\n'
    + 'FIELD:zip:LIKE(Invalid_Num):TYPE(STRING5):0,0\n'
    + 'FIELD:zip4:LIKE(Invalid_Num):TYPE(STRING4):0,0\n'
    + 'FIELD:cart:LIKE(Invalid_Char):TYPE(STRING4):0,0\n'
    + 'FIELD:cr_sort_sz:LIKE(Invalid_CRSORT):TYPE(STRING1):0,0\n'
    + 'FIELD:lot:LIKE(Invalid_Num):TYPE(STRING4):0,0\n'
    + 'FIELD:lot_order:LIKE(Invalid_LotOrder):TYPE(STRING1):0,0\n'
    + 'FIELD:dbpc:LIKE(Invalid_Num):TYPE(STRING2):0,0\n'
    + 'FIELD:chk_digit:LIKE(Invalid_Num):TYPE(STRING1):0,0\n'
    + 'FIELD:rec_type:LIKE(Invalid_RecType):TYPE(STRING2):0,0\n'
    + 'FIELD:county:LIKE(Invalid_Num):TYPE(STRING5):0,0\n'
    + 'FIELD:geo_lat:LIKE(Invalid_Num):TYPE(STRING10):0,0\n'
    + 'FIELD:geo_long:LIKE(Invalid_Num):TYPE(STRING11):0,0\n'
    + 'FIELD:msa:LIKE(Invalid_Num):TYPE(STRING4):0,0\n'
    + 'FIELD:geo_blk:LIKE(Invalid_Num):TYPE(STRING7):0,0\n'
    + 'FIELD:geo_match:LIKE(Invalid_Num):TYPE(STRING1):0,0\n'
    + 'FIELD:err_stat:LIKE(Invalid_Char):TYPE(STRING4):0,0\n'
    + 'FIELD:hhid:LIKE(Invalid_Num):TYPE(UNSIGNED8):0,0\n'
    + 'FIELD:did:LIKE(Invalid_Num):TYPE(UNSIGNED6):0,0\n'
    + 'FIELD:did_score:LIKE(Invalid_Num):TYPE(UNSIGNED1):0,0\n'
    + 'FIELD:phone_fordid:LIKE(Invalid_Num):TYPE(STRING10):0,0\n'
    + 'FIELD:gender:LIKE(Invalid_Gender):TYPE(STRING1):0,0\n'
    + 'FIELD:date_of_birth:LIKE(Invalid_Num):TYPE(STRING6):0,0\n'
    + 'FIELD:address_type:LIKE(Invalid_Num):TYPE(STRING1):0,0\n'
    + 'FIELD:demographic_level_indicator:LIKE(Invalid_DemographicIndicator):TYPE(STRING1):0,0\n'
    + 'FIELD:length_of_residence:LIKE(Invalid_Num):TYPE(STRING2):0,0\n'
    + 'FIELD:location_type:LIKE(Invalid_LocationType):TYPE(STRING1):0,0\n'
    + 'FIELD:dqi2_occupancy_count:LIKE(Invalid_Num):TYPE(STRING2):0,0\n'
    + 'FIELD:delivery_unit_size:LIKE(Invalid_Num):TYPE(STRING2):0,0\n'
    + 'FIELD:household_arrival_date:LIKE(Invalid_Num):TYPE(STRING4):0,0\n'
    + 'FIELD:area_code:LIKE(Invalid_Num):TYPE(STRING3):0,0\n'
    + 'FIELD:phone_number:LIKE(Invalid_Num):TYPE(STRING7):0,0\n'
    + 'FIELD:telephone_number_type:LIKE(Invalid_TelephoneNumberType):TYPE(STRING1):0,0\n'
    + 'FIELD:phone2_number:LIKE(Invalid_Num):TYPE(STRING10):0,0\n'
    + 'FIELD:telephone2_number_type:LIKE(Invalid_TelephoneNumberType):TYPE(STRING1):0,0\n'
    + 'FIELD:time_zone:LIKE(Invalid_TimeZone):TYPE(STRING1):0,0\n'
    + 'FIELD:refresh_date:LIKE(Invalid_Num):TYPE(STRING6):0,0\n'
    + 'FIELD:name_address_verification_source:LIKE(Invalid_YN):TYPE(STRING1):0,0\n'
    + 'FIELD:drop_indicator:LIKE(Invalid_Num):TYPE(STRING1):0,0\n'
    + 'FIELD:do_not_mail_flag:LIKE(Invalid_Num):TYPE(STRING1):0,0\n'
    + 'FIELD:do_not_call_flag:LIKE(Invalid_Num):TYPE(STRING1):0,0\n'
    + 'FIELD:business_file_hit_flag:LIKE(Invalid_YN):TYPE(STRING1):0,0\n'
    + 'FIELD:spouse_title:LIKE(Invalid_Char):TYPE(STRING5):0,0\n'
    + 'FIELD:spouse_fname:LIKE(Invalid_Char):TYPE(STRING20):0,0\n'
    + 'FIELD:spouse_mname:LIKE(Invalid_Char):TYPE(STRING20):0,0\n'
    + 'FIELD:spouse_lname:LIKE(Invalid_Char):TYPE(STRING20):0,0\n'
    + 'FIELD:spouse_name_suffix:LIKE(Invalid_Char):TYPE(STRING5):0,0\n'
    + 'FIELD:spouse_fname_orig:LIKE(Invalid_Char):TYPE(STRING15):0,0\n'
    + 'FIELD:spouse_mname_orig:LIKE(Invalid_Char):TYPE(STRING1):0,0\n'
    + 'FIELD:spouse_lname_orig:LIKE(Invalid_Char):TYPE(STRING20):0,0\n'
    + 'FIELD:spouse_name_suffix_orig:LIKE(Invalid_Char):TYPE(STRING2):0,0\n'
    + 'FIELD:spouse_title_orig:LIKE(Invalid_Char):TYPE(STRING1):0,0\n'
    + 'FIELD:spouse_gender:TYPE(STRING1):0,0\n'
    + 'FIELD:spouse_date_of_birth:LIKE(Invalid_Num):TYPE(STRING6):0,0\n'
    + 'FIELD:spouse_indicator:TYPE(STRING1):0,0\n'
    + 'FIELD:household_income:TYPE(STRING1):0,0\n'
    + 'FIELD:find_income_in_1000s:LIKE(Invalid_Num):TYPE(STRING6):0,0\n'
    + 'FIELD:phhincomeunder25k:LIKE(Invalid_Num):TYPE(STRING6):0,0\n'
    + 'FIELD:phhincome50kplus:LIKE(Invalid_Num):TYPE(STRING6):0,0\n'
    + 'FIELD:phhincome200kplus:LIKE(Invalid_Num):TYPE(STRING6):0,0\n'
    + 'FIELD:medianhhincome:LIKE(Invalid_Num):TYPE(STRING10):0,0\n'
    + 'FIELD:own_rent:LIKE(Invalid_Num):TYPE(STRING1):0,0\n'
    + 'FIELD:homeowner_source_code:LIKE(Invalid_HomeownerCode):TYPE(STRING1):0,0\n'
    + 'FIELD:telephone_acquisition_date:LIKE(Invalid_Num):TYPE(STRING6):0,0\n'
    + 'FIELD:recency_date:LIKE(Invalid_Num):TYPE(STRING6):0,0\n'
    + 'FIELD:source:LIKE(Invalid_Source):TYPE(STRING1):0,0\n'
    ;
 
  // Structured values
  EXPORT linkpaths := DATASET([
    ],{STRING linkpath;STRING compulsory;STRING optional;STRING bonus;STRING required;STRING search});
 
END;

