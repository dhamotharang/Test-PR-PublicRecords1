// Machine-readable versions of the spec file and subsets thereof
IMPORT SALT311;
EXPORT GenerationMod := MODULE(SALT311.iGenerationMod)

  // SALT Version info
  EXPORT salt_VERSION := 'V3.11.6';
  EXPORT salt_MODULE := 'SALT311'; // Optional override by HACK:SALTMODULE
  EXPORT salt_TOOLSMODULE := 'SALTTOOLS30'; // Optional override by HACK:SALTTOOLSMODULE

  // Core module configuration values
  EXPORT spc_MODULE := 'Scrubs_Marriage_Divorce_V2';
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
  EXPORT spc_FILENAME := 'Marriage_Divorce_V2_Profile';
  EXPORT spc_INGESTSTATUS := '';
  EXPORT spc_EXTERNAL_MAPPING := 'UniqueID:';
  EXPORT spc_EXTERNAL_BATCH_PARAM := ',/* MY_ */,dt_first_seen,dt_last_seen,dt_vendor_first_reported,dt_vendor_last_reported,record_id,filing_type,filing_subtype,vendor,source_file,process_date,state_origin,party1_type,party1_name_format,party1_name,party1_alias,party1_dob,party1_birth_state,party1_age,party1_race,party1_addr1,party1_csz,party1_county,party1_previous_marital_status,party1_how_marriage_ended,party1_times_married,party1_last_marriage_end_dt,party2_type,party2_name_format,party2_name,party2_alias,party2_dob,party2_birth_state,party2_age,party2_race,party2_addr1,party2_csz,party2_county,party2_previous_marital_status,party2_how_marriage_ended,party2_times_married,party2_last_marriage_end_dt,number_of_children,marriage_filing_dt,marriage_dt,marriage_city,marriage_county,place_of_marriage,type_of_ceremony,marriage_filing_number,marriage_docket_volume,divorce_filing_dt,divorce_dt,divorce_docket_volume,divorce_filing_number,divorce_city,divorce_county,grounds_for_divorce,marriage_duration_cd,marriage_duration,persistent_record_id';
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
    'MODULE:Scrubs_Marriage_Divorce_V2\n'
    + 'FILENAME:Marriage_Divorce_V2_Profile\n'
    + '//Uncomment up to NINES for internal or external adl\n'
    + '//IDFIELD:EXISTS:<NameOfIDField>\n'
    + '//RIDFIELD:<NameOfRidField>\n'
    + '//RECORDS:<NumberOfRecordsInDataFile>\n'
    + '//POPULATION:<ExpectedNumberOfEntitiesInDataFile>\n'
    + '//NINES:<Precision required 3 = 99.9%, 2 = 99% etc>\n'
    + '//Uncomment Process if doing external adl\n'
    + '//PROCESS:<ProcessName>\n'
    + 'FIELDTYPE:Nums:ALLOW(0123456789)\n'
    + 'FIELDTYPE:lowercase:ALLOW(abcdefghijklmnopqrstuvwxyz)\n'
    + 'FIELDTYPE:uppercase:ALLOW(ABCDEFGHIJKLMNOPQRSTUVWXYZ)\n'
    + 'FIELDTYPE:alphas:ALLOW(ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz)\n'
    + 'FIELDTYPE:lowercaseandnums:ALLOW(abcdefghijklmnopqrstuvwxyz0123456789)\n'
    + 'FIELDTYPE:uppercaseandnums:ALLOW(ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789)\n'
    + 'FIELDTYPE:alphasandnums:ALLOW(ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789)\n'
    + 'FIELDTYPE:allupper:ALLOW(ABCDEFGHIJKLMNOPQRSTUVWXYZ)\n'
    + 'FIELDTYPE:allupperandnums:ALLOW(ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789)\n'
    + 'FIELDTYPE:allalphaandnums:ALLOW(ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789)\n'
    + '\n'
    + 'FIELDTYPE:invalid_blank:LENGTHS(0)\n'
    + 'FIELDTYPE:invalid_alpha:CAPS:ALLOW(ABCDEFGHIJKLMNOPQRSTUVWXYZ):SPACES( -):LENGTHS(0..)\n'
    + 'FIELDTYPE:invalid_Num:ALLOW(0123456789):LENGTHS(0..)\n'
    + 'FIELDTYPE:invalid_date:LIKE(Nums):SPACES( -/):LENGTHS(0,1,6,7,8,9,10)\n'
    + 'FIELDTYPE:invalid_name:LIKE(allalphaandnums):SPACES( -,./\\#:;&*"\'`_()[]{}!?):LENGTHS(0..)\n'
    + 'FIELDTYPE:invalid_vendor:LIKE(uppercaseandnums):SPACES( -):LENGTHS(0..)\n'
    + 'FIELDTYPE:invalid_source_file:LIKE(uppercase):SPACES( -_/):LENGTHS(0..)\n'
    + 'FIELDTYPE:invalid_party_type:CAPS:ALLOW(ABCDEFGHIJKLMNOPQRSTUVWXYZ):LENGTHS(0,1)\n'
    + 'FIELDTYPE:invalid_filing_type:LIKE(invalid_Num):LENGTHS(0..)\n'
    + 'FIELDTYPE:invalid_name_format:ENUM(L|F|)\n'
    + 'FIELDTYPE:invalid_age:LIKE(Nums):LENGTHS(0,1,2,3)\n'
    + 'FIELDTYPE:invalid_race:LIKE(uppercase):SPACES( -,/&):LENGTHS(0..)\n'
    + 'FIELDTYPE:invalid_address:CAPS:LIKE(allupperandnums):SPACES( -&/\\#%.;,\'_"*()%?=@):LENGTHS(0..)\n'
    + 'FIELDTYPE:invalid_city:LIKE(alphas):SPACES( -,&\\/.:#;\'):LENGTHS(0..)\n'
    + 'FIELDTYPE:invalid_county:LIKE(alphas):SPACES( -,&\\/.:#();):LENGTHS(0..)\n'
    + 'FIELDTYPE:invalid_state:LIKE(uppercase):LENGTHS(0,2)\n'
    + 'FIELDTYPE:invalid_filing_number:LIKE(allalphaandnums):SPACES( -.*/):LENGTHS(0..)\n'
    + 'FIELDTYPE:invalid_docket_volume:LIKE(allalphaandnums):SPACES( -/,*()#."):LENGTHS(0..)\n'
    + '\n'
    + 'FIELD:dt_first_seen:LIKE(invalid_date):TYPE(unsigned3):0,0\n'
    + 'FIELD:dt_last_seen:LIKE(invalid_date):TYPE(unsigned3):0,0\n'
    + 'FIELD:dt_vendor_first_reported:LIKE(invalid_date):TYPE(unsigned3):0,0\n'
    + 'FIELD:dt_vendor_last_reported:LIKE(invalid_date):TYPE(unsigned3):0,0\n'
    + 'FIELD:record_id:LIKE(invalid_Num):TYPE(unsigned6):0,0\n'
    + 'FIELD:filing_type:LIKE(invalid_filing_type):TYPE(STRING1):0,0\n'
    + 'FIELD:filing_subtype:TYPE(STRING25):0,0\n'
    + 'FIELD:vendor:LIKE(invalid_vendor):TYPE(STRING5):0,0\n'
    + 'FIELD:source_file:LIKE(invalid_source_file):TYPE(STRING25):0,0\n'
    + 'FIELD:process_date:LIKE(invalid_date):TYPE(STRING8):0,0\n'
    + 'FIELD:state_origin:LIKE(invalid_state):TYPE(STRING2):0,0\n'
    + 'FIELD:party1_type:LIKE(invalid_party_type):TYPE(STRING1):0,0\n'
    + 'FIELD:party1_name_format:LIKE(invalid_name_format):TYPE(STRING1):0,0\n'
    + 'FIELD:party1_name:LIKE(invalid_name):TYPE(STRING70):0,0\n'
    + 'FIELD:party1_alias:LIKE(invalid_name):TYPE(STRING70):0,0\n'
    + 'FIELD:party1_dob:LIKE(invalid_date):TYPE(STRING8):0,0\n'
    + 'FIELD:party1_birth_state:LIKE(invalid_state):TYPE(STRING2):0,0\n'
    + '// FIELD:party1_age:LIKE(invalid_age):TYPE(STRING3):0,0\n'
    + 'FIELD:party1_age:TYPE(STRING3):0,0\n'
    + 'FIELD:party1_race:LIKE(invalid_race):TYPE(STRING30):0,0\n'
    + 'FIELD:party1_addr1:LIKE(invalid_address):TYPE(STRING50):0,0\n'
    + 'FIELD:party1_csz:TYPE(STRING50):0,0\n'
    + 'FIELD:party1_county:LIKE(invalid_county):TYPE(STRING35):0,0\n'
    + 'FIELD:party1_previous_marital_status:TYPE(STRING20):0,0\n'
    + 'FIELD:party1_how_marriage_ended:TYPE(STRING20):0,0\n'
    + 'FIELD:party1_times_married:TYPE(STRING2):0,0\n'
    + 'FIELD:party1_last_marriage_end_dt:LIKE(invalid_date):TYPE(STRING8):0,0\n'
    + 'FIELD:party2_type:LIKE(invalid_party_type):TYPE(STRING1):0,0\n'
    + 'FIELD:party2_name_format:LIKE(invalid_name_format):TYPE(STRING1):0,0\n'
    + 'FIELD:party2_name:LIKE(invalid_name):TYPE(STRING70):0,0\n'
    + 'FIELD:party2_alias:TYPE(STRING70):0,0\n'
    + 'FIELD:party2_dob:LIKE(invalid_date):TYPE(STRING8):0,0\n'
    + 'FIELD:party2_birth_state:LIKE(invalid_state):TYPE(STRING2):0,0\n'
    + '// FIELD:party2_age:LIKE(invalid_age):TYPE(STRING3):0,0\n'
    + 'FIELD:party2_age:TYPE(STRING3):0,0\n'
    + 'FIELD:party2_race:TYPE(STRING30):0,0\n'
    + 'FIELD:party2_addr1:LIKE(invalid_address):TYPE(STRING50):0,0\n'
    + 'FIELD:party2_csz:TYPE(STRING50):0,0\n'
    + 'FIELD:party2_county:LIKE(invalid_county):TYPE(STRING35):0,0\n'
    + 'FIELD:party2_previous_marital_status:TYPE(STRING20):0,0\n'
    + 'FIELD:party2_how_marriage_ended:TYPE(STRING20):0,0\n'
    + 'FIELD:party2_times_married:TYPE(STRING2):0,0\n'
    + 'FIELD:party2_last_marriage_end_dt:LIKE(invalid_date):TYPE(STRING8):0,0\n'
    + 'FIELD:number_of_children:TYPE(STRING2):0,0\n'
    + 'FIELD:marriage_filing_dt:LIKE(invalid_date):TYPE(STRING8):0,0\n'
    + 'FIELD:marriage_dt:LIKE(invalid_date):TYPE(STRING8):0,0\n'
    + 'FIELD:marriage_city:LIKE(invalid_city):TYPE(STRING30):0,0\n'
    + 'FIELD:marriage_county:LIKE(invalid_county):TYPE(STRING35):0,0\n'
    + 'FIELD:place_of_marriage:TYPE(STRING10):0,0\n'
    + 'FIELD:type_of_ceremony:TYPE(STRING10):0,0\n'
    + 'FIELD:marriage_filing_number:LIKE(invalid_filing_number):TYPE(STRING25):0,0\n'
    + 'FIELD:marriage_docket_volume:LIKE(invalid_docket_volume):TYPE(STRING30):0,0\n'
    + 'FIELD:divorce_filing_dt:LIKE(invalid_date):TYPE(STRING8):0,0\n'
    + 'FIELD:divorce_dt:LIKE(invalid_date):TYPE(STRING8):0,0\n'
    + 'FIELD:divorce_docket_volume:LIKE(invalid_docket_volume):TYPE(STRING30):0,0\n'
    + 'FIELD:divorce_filing_number:LIKE(invalid_filing_number):TYPE(STRING25):0,0\n'
    + 'FIELD:divorce_city:LIKE(invalid_city):TYPE(STRING30):0,0\n'
    + 'FIELD:divorce_county:LIKE(invalid_county):TYPE(STRING35):0,0\n'
    + 'FIELD:grounds_for_divorce:TYPE(STRING50):0,0\n'
    + 'FIELD:marriage_duration_cd:TYPE(STRING1):0,0\n'
    + 'FIELD:marriage_duration:TYPE(STRING3):0,0\n'
    + 'FIELD:persistent_record_id:TYPE(UNSIGNED8):0,0'
    ;

  // Structured values
  EXPORT linkpaths := DATASET([
    ],{STRING linkpath;STRING compulsory;STRING optional;STRING bonus;STRING required;STRING search});

END;
