// Machine-readable versions of the spec file and subsets thereof
IMPORT SALT311;
EXPORT GenerationMod := MODULE(SALT311.iGenerationMod)
 
  // SALT Version info
  EXPORT salt_VERSION := 'V3.11.9';
  EXPORT salt_MODULE := 'SALT311'; // Optional override by HACK:SALTMODULE
  EXPORT salt_TOOLSMODULE := 'SALTTOOLS30'; // Optional override by HACK:SALTTOOLSMODULE
 
  // Core module configuration values
  EXPORT spc_MODULE := 'Scrubs_Watercraft_Search';
  EXPORT spc_NAMESCOPE := '';
  EXPORT spc_PROCESS := '';
  EXPORT spc_PROCLAYOUTS := 'Process__Layouts';
  EXPORT spc_IDNAME := ''; // cluster id (input)
  EXPORT spc_IDFIELD := ''; // cluster id (output)
  EXPORT spc_RIDFIELD := ''; // record id
  EXPORT spc_CONFIG := 'Config';
  EXPORT spc_CONFIGPARAM := FALSE;
  EXPORT spc_SOURCEFIELD := 'source_code';
  EXPORT spc_FILEPREFIX := 'In_';
  EXPORT spc_FILENAME := 'Watercraft_Search';
  EXPORT spc_INGESTSTATUS := '';
  EXPORT spc_EXTERNAL_MAPPING := 'UniqueID:';
  EXPORT spc_EXTERNAL_BATCH_PARAM := ',/* MY_ */,date_first_seen,date_last_seen,date_vendor_first_reported,date_vendor_last_reported,watercraft_key,sequence_key,state_origin,source_code,dppa_flag,orig_name,orig_name_type_code,orig_name_type_description,orig_name_first,orig_name_middle,orig_name_last,orig_name_suffix,orig_address_1,orig_address_2,orig_city,orig_state,orig_zip,orig_fips,orig_province,orig_country,dob,orig_ssn,orig_fein,gender,phone_1,phone_2,title,fname,mname,lname,name_suffix,name_cleaning_score,company_name,prim_range,predir,prim_name,suffix,postdir,unit_desig,sec_range,p_city_name,v_city_name,st,zip5,zip4,county,cart,cr_sort_sz,lot,lot_order,dpbc,chk_digit,rec_type,ace_fips_st,ace_fips_county,geo_lat,geo_long,msa,geo_blk,geo_match,err_stat,bdid,fein,did,did_score,ssn,history_flag,rawaid,reg_owner_name_2,persistent_record_id,source_rec_id,dotscore,dotweight,empid,empscore,empweight,powid,powscore,powweight,proxid,proxscore,proxweight,seleid,selescore,seleweight,orgid,orgscore,orgweight,ultid,ultscore,ultweight';
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
    'MODULE:Scrubs_Watercraft_Search\n'
    + 'FILENAME:Watercraft_Search\n'
    + 'OPTIONS:-gh\n'
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
    + 'SOURCEFIELD:source_code\n'
    + '\n'
    + 'FIELDTYPE:invalid_alpha:CAPS:ALLOW(ABCDEFGHIJKLMNOPQRSTUVWXYZ\'):SPACES( -):LENGTHS(0..)\n'
    + 'FIELDTYPE:invalid_name:CAPS:ALLOW(ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789\'):SPACES( -,&\\/.:;_):LENGTHS(0..)\n'
    + 'FIELDTYPE:invalid_company:CAPS:ALLOW(ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789\'):SPACES( -,&\\/.:#;()"):LENGTHS(0..)\n'
    + 'FIELDTYPE:invalid_numeric:ALLOW(0123456789):LENGTHS(0..)\n'
    + 'FIELDTYPE:invalid_address:CAPS:ALLOW(ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789\'):SPACES( -&/\\#.;,):LENGTHS(0..)\n'
    + 'FIELDTYPE:invalid_state:ALLOW(ABCDEFGHIJKLMNOPQRSTUVWXYZ):LENGTHS(2,0)\n'
    + 'FIELDTYPE:invalid_zip:ALLOW(0123456789X):SPACES( -):LENGTHS(10,9,6,5,0)\n'
    + 'FIELDTYPE:invalid_date:ALLOW(0123456789):SPACES(?)\n'
    + 'FIELDTYPE:invalid_dppa_flag:ENUM(Y|N):LENGTHS(1,0)\n'
    + 'FIELDTYPE:invalid_history_flag:ENUM(H|U|E| ):LENGTHS(1,0)\n'
    + 'FIELDTYPE:invalid_owner_type:ENUM(O|R|B| ):LENGTHS(1,0)\n'
    + 'FIELDTYPE:invalid_fips:ALLOW(0123456789):LENGTHS(0..)\n'
    + 'FIELDTYPE:invalid_ssn_fein:ALLOW(0123456789):LENGTHS(9,0)\n'
    + 'FIELDTYPE:invalid_phone:ALLOW(0123456789):SPACES( ):LENGTHS(10,0)\n'
    + 'FIELDTYPE:invalid_blank:LENGTHS(1..)\n'
    + 'FIELDTYPE:invalid_source_code:ALLOW(ABCDEFGHIJKLMNOPQRSTUVWXYZ[]):LENGTHS(2)\n'
    + '\n'
    + '\n'
    + 'FIELD:date_first_seen:LIKE(invalid_date):TYPE(STRING8):0,0\n'
    + 'FIELD:date_last_seen:LIKE(invalid_date):TYPE(STRING8):0,0\n'
    + 'FIELD:date_vendor_first_reported:LIKE(invalid_date):TYPE(STRING8):0,0\n'
    + 'FIELD:date_vendor_last_reported:LIKE(invalid_date):TYPE(STRING8):0,0\n'
    + 'FIELD:watercraft_key:LIKE(invalid_blank):TYPE(STRING30):0,0\n'
    + 'FIELD:sequence_key:TYPE(STRING30):0,0\n'
    + 'FIELD:state_origin:LIKE(invalid_state):TYPE(STRING2):0,0\n'
    + 'FIELD:source_code:LIKE(invalid_source_code):TYPE(STRING2):0,0\n'
    + 'FIELD:dppa_flag:LIKE(invalid_dppa_flag):TYPE(STRING1):0,0\n'
    + 'FIELD:orig_name:TYPE(STRING100):0,0\n'
    + 'FIELD:orig_name_type_code:LIKE(invalid_owner_type):TYPE(STRING1):0,0\n'
    + 'FIELD:orig_name_type_description:TYPE(STRING20):0,0\n'
    + 'FIELD:orig_name_first:TYPE(STRING25):0,0\n'
    + 'FIELD:orig_name_middle:TYPE(STRING25):0,0\n'
    + 'FIELD:orig_name_last:TYPE(STRING25):0,0\n'
    + 'FIELD:orig_name_suffix:TYPE(STRING10):0,0\n'
    + 'FIELD:orig_address_1:TYPE(STRING60):0,0\n'
    + 'FIELD:orig_address_2:TYPE(STRING60):0,0\n'
    + 'FIELD:orig_city:TYPE(STRING25):0,0\n'
    + 'FIELD:orig_state:TYPE(STRING2):0,0\n'
    + 'FIELD:orig_zip:TYPE(STRING10):0,0\n'
    + 'FIELD:orig_fips:TYPE(STRING5):0,0\n'
    + 'FIELD:orig_province:TYPE(STRING30):0,0\n'
    + 'FIELD:orig_country:TYPE(STRING30):0,0\n'
    + 'FIELD:dob:LIKE(invalid_date):TYPE(STRING8):0,0\n'
    + 'FIELD:orig_ssn:TYPE(STRING9):0,0\n'
    + 'FIELD:orig_fein:TYPE(STRING9):0,0\n'
    + 'FIELD:gender:TYPE(STRING1):0,0\n'
    + 'FIELD:phone_1:LIKE(invalid_phone):TYPE(STRING10):0,0\n'
    + 'FIELD:phone_2:LIKE(invalid_phone):TYPE(STRING10):0,0\n'
    + 'FIELD:title:TYPE(STRING5):0,0\n'
    + 'FIELD:fname:LIKE(invalid_name):TYPE(STRING20):0,0\n'
    + 'FIELD:mname:LIKE(invalid_name):TYPE(STRING20):0,0\n'
    + 'FIELD:lname:LIKE(invalid_name):TYPE(STRING20):0,0\n'
    + 'FIELD:name_suffix:LIKE(invalid_name):TYPE(STRING5):0,0\n'
    + 'FIELD:name_cleaning_score:TYPE(STRING3):0,0\n'
    + 'FIELD:company_name:LIKE(invalid_company):TYPE(STRING60):0,0\n'
    + 'FIELD:prim_range:LIKE(invalid_address):TYPE(STRING10):0,0\n'
    + 'FIELD:predir:LIKE(invalid_address):TYPE(STRING2):0,0\n'
    + 'FIELD:prim_name:LIKE(invalid_address):TYPE(STRING28):0,0\n'
    + 'FIELD:suffix:LIKE(invalid_address):TYPE(STRING4):0,0\n'
    + 'FIELD:postdir:LIKE(invalid_address):TYPE(STRING2):0,0\n'
    + 'FIELD:unit_desig:LIKE(invalid_address):TYPE(STRING10):0,0\n'
    + 'FIELD:sec_range:LIKE(invalid_address):TYPE(STRING8):0,0\n'
    + 'FIELD:p_city_name:LIKE(invalid_alpha):TYPE(STRING25):0,0\n'
    + 'FIELD:v_city_name:LIKE(invalid_alpha):TYPE(STRING25):0,0\n'
    + 'FIELD:st:LIKE(invalid_state):TYPE(STRING2):0,0\n'
    + 'FIELD:zip5:LIKE(invalid_numeric):TYPE(STRING5):0,0\n'
    + 'FIELD:zip4:LIKE(invalid_numeric):TYPE(STRING4):0,0\n'
    + 'FIELD:county:TYPE(STRING3):0,0\n'
    + 'FIELD:cart:TYPE(STRING4):0,0\n'
    + 'FIELD:cr_sort_sz:TYPE(STRING1):0,0\n'
    + 'FIELD:lot:TYPE(STRING4):0,0\n'
    + 'FIELD:lot_order:TYPE(STRING1):0,0\n'
    + 'FIELD:dpbc:TYPE(STRING2):0,0\n'
    + 'FIELD:chk_digit:TYPE(STRING1):0,0\n'
    + 'FIELD:rec_type:TYPE(STRING2):0,0\n'
    + 'FIELD:ace_fips_st:LIKE(invalid_fips):TYPE(STRING2):0,0\n'
    + 'FIELD:ace_fips_county:TYPE(STRING3):0,0\n'
    + 'FIELD:geo_lat:TYPE(STRING10):0,0\n'
    + 'FIELD:geo_long:TYPE(STRING11):0,0\n'
    + 'FIELD:msa:TYPE(STRING4):0,0\n'
    + 'FIELD:geo_blk:TYPE(STRING7):0,0\n'
    + 'FIELD:geo_match:TYPE(STRING1):0,0\n'
    + 'FIELD:err_stat:TYPE(STRING4):0,0\n'
    + 'FIELD:bdid:LIKE(invalid_numeric):TYPE(STRING12):0,0\n'
    + 'FIELD:fein:LIKE(invalid_ssn_fein):TYPE(STRING9):0,0\n'
    + 'FIELD:did:LIKE(invalid_numeric):TYPE(STRING12):0,0\n'
    + 'FIELD:did_score:TYPE(STRING3):0,0\n'
    + 'FIELD:ssn:LIKE(invalid_ssn_fein):TYPE(STRING9):0,0\n'
    + 'FIELD:history_flag:LIKE(invalid_history_flag):TYPE(STRING1):0,0\n'
    + 'FIELD:rawaid:LIKE(invalid_numeric):TYPE(UNSIGNED8):0,0\n'
    + 'FIELD:reg_owner_name_2:TYPE(STRING100):0,0\n'
    + 'FIELD:persistent_record_id:LIKE(invalid_numeric):TYPE(UNSIGNED8):0,0\n'
    + 'FIELD:source_rec_id:LIKE(invalid_numeric):TYPE(UNSIGNED8):0,0\n'
    + '/*FIELD:dotid:TYPE(UNSIGNED6):0,0\n'
    + 'FIELD:dotscore:TYPE(UNSIGNED2):0,0\n'
    + 'FIELD:dotweight:TYPE(UNSIGNED2):0,0\n'
    + 'FIELD:empid:TYPE(UNSIGNED6):0,0\n'
    + 'FIELD:empscore:TYPE(UNSIGNED2):0,0\n'
    + 'FIELD:empweight:TYPE(UNSIGNED2):0,0\n'
    + 'FIELD:powid:TYPE(UNSIGNED6):0,0\n'
    + 'FIELD:powscore:TYPE(UNSIGNED2):0,0\n'
    + 'FIELD:powweight:TYPE(UNSIGNED2):0,0\n'
    + 'FIELD:proxid:TYPE(UNSIGNED6):0,0\n'
    + 'FIELD:proxscore:TYPE(UNSIGNED2):0,0\n'
    + 'FIELD:proxweight:TYPE(UNSIGNED2):0,0\n'
    + 'FIELD:seleid:TYPE(UNSIGNED6):0,0\n'
    + 'FIELD:selescore:TYPE(UNSIGNED2):0,0\n'
    + 'FIELD:seleweight:TYPE(UNSIGNED2):0,0\n'
    + 'FIELD:orgid:TYPE(UNSIGNED6):0,0\n'
    + 'FIELD:orgscore:TYPE(UNSIGNED2):0,0\n'
    + 'FIELD:orgweight:TYPE(UNSIGNED2):0,0\n'
    + 'FIELD:ultid:TYPE(UNSIGNED6):0,0\n'
    + 'FIELD:ultscore:TYPE(UNSIGNED2):0,0\n'
    + 'FIELD:ultweight:TYPE(UNSIGNED2):0,0*/\n'
    + '\n'
    + '//CONCEPT statements should be used to group together interellated fields; such as address\n'
    + '//RELATIONSHIP is used to find non-obvious relationships between the clusters\n'
    + '//SOURCEFIELD is used if a field of the file denotes a source of the records in that file\n'
    + '//LINKPATH is used to define access paths for external linking\n'
    ;
 
  // Structured values
  EXPORT linkpaths := DATASET([
    ],{STRING linkpath;STRING compulsory;STRING optional;STRING bonus;STRING required;STRING search});
 
END;

