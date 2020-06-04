// Machine-readable versions of the spec file and subsets thereof
IMPORT SALT311;
EXPORT GenerationMod := MODULE(SALT311.iGenerationMod)
 
  // SALT Version info
  EXPORT salt_VERSION := 'V3.11.9';
  EXPORT salt_MODULE := 'SALT311'; // Optional override by HACK:SALTMODULE
  EXPORT salt_TOOLSMODULE := 'SALTTOOLS30'; // Optional override by HACK:SALTTOOLSMODULE
 
  // Core module configuration values
  EXPORT spc_MODULE := 'Scrubs_American_Student_List';
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
  EXPORT spc_FILENAME := 'American_Student_List';
  EXPORT spc_INGESTSTATUS := '';
  EXPORT spc_EXTERNAL_MAPPING := 'UniqueID:';
  EXPORT spc_EXTERNAL_BATCH_PARAM := ',/* MY_ */,key,ssn,did,process_date,date_first_seen,date_last_seen,date_vendor_first_reported,date_vendor_last_reported,historical_flag,full_name,first_name,last_name,address_1,address_2,city,state,zip,zip_4,crrt_code,delivery_point_barcode,zip4_check_digit,address_type_code,address_type,county_number,county_name,gender_code,gender,age,birth_date,dob_formatted,telephone,class,college_class,college_name,ln_college_name,college_major,new_college_major,college_code,college_code_exploded,college_type,college_type_exploded,head_of_household_first_name,head_of_household_gender_code,head_of_household_gender,income_level_code,income_level,new_income_level_code,new_income_level,file_type,tier,school_size_code,competitive_code,tuition_code,title,fname,mname,lname,name_suffix,name_score,rawaid,prim_range,predir,prim_name,addr_suffix,postdir,unit_desig,sec_range,p_city_name,v_city_name,st,z5,zip4,cart,cr_sort_sz,lot,lot_order,dpbc,chk_digit,rec_type,county,ace_fips_st,fips_county,geo_lat,geo_long,msa,geo_blk,geo_match,err_stat,tier2,source';
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
    + 'MODULE:Scrubs_American_Student_List \n'
    + 'FILENAME:American_Student_List\n'
    + '//Uncomment up to NINES for internal or external adl\n'
    + '//IDFIELD:EXISTS:<NameOfIDField>\n'
    + '//RIDFIELD:<NameOfRidField>\n'
    + '//RECORDS:<NumberOfRecordsInDataFile>\n'
    + '//POPULATION:<ExpectedNumberOfEntitiesInDataFile>\n'
    + '//NINES:<Precision required 3 = 99.9%, 2 = 99% etc>\n'
    + '//Uncomment Process if doing external adl\n'
    + '//PROCESS:<ProcessName>\n'
    + '//FIELDTYPE statements can be used to clean up (or check the cleaning) of individual fields\n'
    + '//BESTTYPE statements declare methods of generating the best value for a given cluster; this can also improve linking\n'
    + '//FUZZY can be used to create new types of FUZZY linking\n'
    + '\n'
    + 'FIELDTYPE:invalid_nums:ALLOW(0123456789):SPACES( )\n'
    + 'FIELDTYPE:invalid_gender:ENUM(MALE|FEMALE|)\n'
    + 'FIELDTYPE:invalid_gender_code:ENUM(1|2|)\n'
    + 'FIELDTYPE:invalid_alpha:SPACES( ):ALLOW(ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz-)\n'
    + 'FIELDTYPE:invalid_address:SPACES( ):ALLOW(\',./#-&/0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZ)\n'
    + 'FIELDTYPE:invalid_csz:SPACES( ):ALLOW( ,-\'ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789)\n'
    + 'FIELDTYPE:invalid_county_name:ALLOW(ABCDEFGHIJKLMNOPQRSTUVWXYZ\'):SPACES( -):WORDS(1,2,3,4,5)\n'
    + 'FIELDTYPE:invalid_zip:ALLOW(0123456789):LENGTHS(0,5,9)\n'
    + 'FIELDTYPE:invalid_date:CUSTOM(Scrubs.fn_valid_date>0)\n'
    + 'FIELDTYPE:invalid_suffix:SPACES( ):ALLOW(ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz):ENUM(SR|JR|I|II|III|IV|V|VI|VII|VIII|IX|X|)\n'
    + 'FIELDTYPE:invalid_college_class:ENUM(FR|GR|JR|SO|SR|UN|)\n'
    + 'FIELDTYPE:invalid_college_code:ENUM(1|2|4|)\n'
    + 'FIELDTYPE:invalid_code_code_exploded:ENUM(FOUR YEAR COLLEGE|GRADUATE SCHOOL|TWO YEAR COLLEGE|UNDERGRADUATE SCHOOL|)\n'
    + 'FIELDTYPE:invalid_college_type_exploded:ENUM(CHURCH/RELIGIOUS SCHOOL|PRIVATE SCHOOL|PUBLIC/STATE SCHOOL|)\n'
    + 'FIELDTYPE:invalid_address_type:ENUM(GENERAL DELIVERY|HIGH-RISE DWELLING|POST OFFICE BOX|RURAL ROUTE|SINGLE FAMILY DWELLING|)\n'
    + 'FIELDTYPE:invalid_college_type:ENUM(N|P|R|S|)\n'
    + 'FIELDTYPE:invalid_income_lvl_code:ENUM(A|B|C|D|E|F|G|H|I|J|K|T|)\n'
    + 'FIELDTYPE:invalid_new_income_lvl_code:ENUM(A|B|C|D|E|F|G|H|I|J|K|T|L|M|N|O|)\n'
    + 'FIELDTYPE:invalid_income:ALLOW($,+-0123456789OVER):SPACES( )\n'
    + '\n'
    + '\n'
    + '\n'
    + 'FIELD:key:TYPE(INTEGER8):0,0\n'
    + 'FIELD:ssn:TYPE(STRING9):LIKE(invalid_nums):0,0\n'
    + 'FIELD:did:TYPE(UNSIGNED6):0,0\n'
    + 'FIELD:process_date:TYPE(STRING8):LIKE(invalid_date):0,0\n'
    + 'FIELD:date_first_seen:TYPE(STRING8):LIKE(invalid_date):0,0\n'
    + 'FIELD:date_last_seen:TYPE(STRING8):LIKE(invalid_date):0,0\n'
    + 'FIELD:date_vendor_first_reported:TYPE(STRING8):LIKE(invalid_date):0,0\n'
    + 'FIELD:date_vendor_last_reported:TYPE(STRING8):LIKE(invalid_date):0,0\n'
    + 'FIELD:historical_flag:TYPE(STRING1):0,0\n'
    + 'FIELD:full_name:TYPE(STRING40):LIKE(invalid_alpha):0,0\n'
    + 'FIELD:first_name:TYPE(STRING20):LIKE(invalid_alpha):0,0\n'
    + 'FIELD:last_name:TYPE(STRING20):LIKE(invalid_alpha):0,0\n'
    + 'FIELD:address_1:TYPE(STRING30):LIKE(invalid_address):0,0\n'
    + 'FIELD:address_2:TYPE(STRING30):LIKE(invalid_address):0,0\n'
    + 'FIELD:city:TYPE(STRING16):LIKE(invalid_alpha):0,0\n'
    + 'FIELD:state:TYPE(STRING2):0,0\n'
    + 'FIELD:zip:TYPE(STRING5):LIKE(invalid_zip):0,0\n'
    + 'FIELD:zip_4:TYPE(STRING4):0,0\n'
    + 'FIELD:crrt_code:TYPE(STRING4):0,0\n'
    + 'FIELD:delivery_point_barcode:TYPE(STRING2):0,0\n'
    + 'FIELD:zip4_check_digit:TYPE(STRING1):0,0\n'
    + 'FIELD:address_type_code:TYPE(STRING1):0,0\n'
    + 'FIELD:address_type:TYPE(STRING30):LIKE(invalid_address_type):0,0\n'
    + 'FIELD:county_number:TYPE(STRING3):LIKE(invalid_nums):0,0\n'
    + 'FIELD:county_name:TYPE(STRING20):LIKE(invalid_county_name):0,0\n'
    + 'FIELD:gender_code:TYPE(STRING1):LIKE(invalid_gender_code):0,0\n'
    + 'FIELD:gender:TYPE(STRING6):LIKE(invalid_gender):0,0\n'
    + 'FIELD:age:TYPE(STRING2):LIKE(invalid_nums):0,0\n'
    + 'FIELD:birth_date:TYPE(STRING6):LIKE(invalid_nums):0,0\n'
    + 'FIELD:dob_formatted:TYPE(STRING8):LIKE(invalid_date):0,0\n'
    + 'FIELD:telephone:TYPE(STRING10):LIKE(invalid_nums):0,0\n'
    + 'FIELD:class:TYPE(STRING2):0,0\n'
    + 'FIELD:college_class:TYPE(STRING2):LIKE(invalid_college_class):0,0\n'
    + 'FIELD:college_name:TYPE(STRING50):0,0\n'
    + 'FIELD:ln_college_name:TYPE(STRING50):0,0\n'
    + 'FIELD:college_major:TYPE(STRING1):0,0\n'
    + 'FIELD:new_college_major:TYPE(STRING1):0,0\n'
    + 'FIELD:college_code:TYPE(STRING1):LIKE(invalid_college_code):0,0\n'
    + 'FIELD:college_code_exploded:TYPE(STRING20):LIKE(invalid_code_code_exploded):0,0\n'
    + 'FIELD:college_type:TYPE(STRING1):LIKE(invalid_college_type):0,0\n'
    + 'FIELD:college_type_exploded:TYPE(STRING25):LIKE(invalid_college_type_exploded):0,0\n'
    + 'FIELD:head_of_household_first_name:TYPE(STRING11):0,0\n'
    + 'FIELD:head_of_household_gender_code:TYPE(STRING1):LIKE(invalid_gender_code):0,0\n'
    + 'FIELD:head_of_household_gender:TYPE(STRING6):LIKE(invalid_gender):0,0\n'
    + 'FIELD:income_level_code:TYPE(STRING1):LIKE(invalid_income_lvl_code):0,0\n'
    + 'FIELD:income_level:TYPE(STRING20):0,0\n'
    + 'FIELD:new_income_level_code:TYPE(STRING1):LIKE(invalid_new_income_lvl_code):0,0\n'
    + 'FIELD:new_income_level:TYPE(STRING20):0,0\n'
    + 'FIELD:file_type:TYPE(STRING1):0,0\n'
    + 'FIELD:tier:TYPE(STRING1):0,0\n'
    + 'FIELD:school_size_code:TYPE(STRING1):0,0\n'
    + 'FIELD:competitive_code:TYPE(STRING1):0,0\n'
    + 'FIELD:tuition_code:TYPE(STRING1):0,0\n'
    + 'FIELD:title:TYPE(STRING5):0,0\n'
    + 'FIELD:fname:TYPE(STRING20):0,0\n'
    + 'FIELD:mname:TYPE(STRING20):0,0\n'
    + 'FIELD:lname:TYPE(STRING20):0,0\n'
    + 'FIELD:name_suffix:TYPE(STRING5):LIKE(invalid_suffix):0,0\n'
    + 'FIELD:name_score:TYPE(STRING3):0,0\n'
    + 'FIELD:rawaid:TYPE(UNSIGNED8):0,0\n'
    + 'FIELD:prim_range:TYPE(STRING10):LIKE(invalid_address):0,0\n'
    + 'FIELD:predir:TYPE(STRING2):LIKE(invalid_address):0,0\n'
    + 'FIELD:prim_name:TYPE(STRING28):LIKE(invalid_address):0,0\n'
    + 'FIELD:addr_suffix:TYPE(STRING4):LIKE(invalid_address):0,0\n'
    + 'FIELD:postdir:TYPE(STRING2):LIKE(invalid_address):0,0\n'
    + 'FIELD:unit_desig:TYPE(STRING10):LIKE(invalid_address):0,0\n'
    + 'FIELD:sec_range:TYPE(STRING8):LIKE(invalid_address):0,0\n'
    + 'FIELD:p_city_name:TYPE(STRING25):LIKE(invalid_csz):0,0\n'
    + 'FIELD:v_city_name:TYPE(STRING25):LIKE(invalid_csz):0,0\n'
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
    + 'FIELD:county:TYPE(STRING5):0,0\n'
    + 'FIELD:ace_fips_st:TYPE(STRING2):0,0\n'
    + 'FIELD:fips_county:TYPE(STRING3):0,0\n'
    + 'FIELD:geo_lat:TYPE(STRING10):0,0\n'
    + 'FIELD:geo_long:TYPE(STRING11):0,0\n'
    + 'FIELD:msa:TYPE(STRING4):0,0\n'
    + 'FIELD:geo_blk:TYPE(STRING7):0,0\n'
    + 'FIELD:geo_match:TYPE(STRING1):0,0\n'
    + 'FIELD:err_stat:TYPE(STRING4):0,0\n'
    + 'FIELD:tier2:TYPE(STRING5):0,0\n'
    + 'FIELD:source:TYPE(STRING2):0,0\n'
    ;
 
  // Structured values
  EXPORT linkpaths := DATASET([
    ],{STRING linkpath;STRING compulsory;STRING optional;STRING bonus;STRING required;STRING search});
 
END;

