// Machine-readable versions of the spec file and subsets thereof
IMPORT SALT311;
EXPORT GenerationMod := MODULE(SALT311.iGenerationMod)
 
  // SALT Version info
  EXPORT salt_VERSION := 'V3.11.4';
  EXPORT salt_MODULE := 'SALT311'; // Optional override by HACK:SALTMODULE
  EXPORT salt_TOOLSMODULE := 'SALTTOOLS30'; // Optional override by HACK:SALTTOOLSMODULE
 
  // Core module configuration values
  EXPORT spc_MODULE := 'Scrubs_NeustarWireless';
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
  EXPORT spc_FILENAME := 'NeustarWireless';
  EXPORT spc_INGESTSTATUS := '';
  EXPORT spc_EXTERNAL_MAPPING := 'UniqueID:';
  EXPORT spc_EXTERNAL_BATCH_PARAM := ',/* MY_ */,phone,fname,mname,lname,salutation,suffix,gender,dob,house,pre_dir,street,street_type,post_dir,apt_type,apt_nbr,zip,plus4,dpc,z4_type,crte,city,state,dpvcmra,dpvconf,fips_state,fips_county,census_tract,census_block_group,cbsa,match_code,latitude,longitude,email,filler1,filler2,verified,activity_status,prepaid,cord_cutter';
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
    '//SALT:  _SPC;\n'
    + 'OPTIONS:-gh\n'
    + 'MODULE:Scrubs_NeustarWireless\n'
    + 'FILENAME:NeustarWireless\n'
    + '\n'
    + 'FIELDTYPE:invalid_phone:SPACES( ):ALLOW(0123456789):LENGTHS(10)\n'
    + 'FIELDTYPE:invalid_fname:SPACES( ):LENGTHS(0..15)\n'
    + 'FIELDTYPE:invalid_mname:SPACES( ):LENGTHS(0,1)\n'
    + 'FIELDTYPE:invalid_lname:SPACES( ):LENGTHS(0..20)\n'
    + 'FIELDTYPE:invalid_gender:SPACES( ):ENUM(F|M|)\n'
    + 'FIELDTYPE:invalid_dob:SPACES( ):ALLOW(0123456789):LENGTHS(0,8)\n'
    + 'FIELDTYPE:invalid_predir_postdir:SPACES( ):ALLOW(ENSW)\n'
    + 'FIELDTYPE:invalid_street_type:SPACES( ):ALLOW(ABCDEFGHIJKLMNOPQRSTUVWXYZ)\n'
    + 'FIELDTYPE:invalid_apt_type:SPACES( ):ALLOW(#ABCDEFGHIJKLMNOPQRSTUVWXYZ)\n'
    + 'FIELDTYPE:invalid_zip:SPACES( ):ALLOW(0123456789):LENGTHS(5,0)\n'
    + 'FIELDTYPE:invalid_plus4:SPACES( ):ALLOW(0123456789):LENGTHS(4,0)\n'
    + 'FIELDTYPE:invalid_dpc:SPACES( ):ALLOW(0123456789)\n'
    + 'FIELDTYPE:invalid_z4_type:SPACES( ):ALLOW(FGHPRS)\n'
    + 'FIELDTYPE:invalid_city:SPACES( ):ALLOW( ABCDEFGHIJKLMNOPQRSTUVWXYZ)\n'
    + 'FIELDTYPE:invalid_state:ENUM(AL|AK|AZ|AR|CA|CO|CT|DE|DC|FL|GA|HI|ID|IL|IN|IA|KS|KY|LA|ME|MD|MA|MI|MN|MS|MO|MT|NE|NV|NH|NJ|NM|NY|NC|ND|OH|OK|OR|PA|RI|SC|SD|TN|TX|UT|VT|VA|WA|WV|WI|WY|AA|AP|AE|AS|GU|MP|PR|VI|PW|)\n'
    + 'FIELDTYPE:invalid_fips_state:SPACES( ):ALLOW(0123456789):LENGTHS(2,0)\n'
    + 'FIELDTYPE:invalid_fips_county:SPACES( ):ALLOW(0123456789):LENGTHS(3,0)\n'
    + 'FIELDTYPE:invalid_cbsa:SPACES( ):ALLOW(0123456789)\n'
    + 'FIELDTYPE:invalid_lat_long:SPACES( ):ALLOW(-.0123456789)\n'
    + 'FIELDTYPE:invalid_email:ALLOW(@.ABCDEFGHIJKLMNOPQRSTUVWXYZ)\n'
    + 'FIELDTYPE:invalid_verified:ALLOW(ABCDE)\n'
    + 'FIELDTYPE:invalid_activity_status:SPACES( ):ENUM(A1|A2|A3|A4|A5|A6|A7|I1|I2|I3|I4|I5|I6|I7|U)\n'
    + 'FIELDTYPE:invalid_Y_N:ENUM(Y|N)\n'
    + '\n'
    + 'FIELD:phone:LIKE(invalid_phone):TYPE(STRING):0,0\n'
    + 'FIELD:fname:TYPE(STRING):0,0\n'
    + 'FIELD:mname:TYPE(STRING):0,0\n'
    + 'FIELD:lname:TYPE(STRING):0,0\n'
    + 'FIELD:salutation:TYPE(STRING):0,0\n'
    + 'FIELD:suffix:TYPE(STRING):0,0\n'
    + 'FIELD:gender:LIKE(invalid_gender):TYPE(STRING):0,0\n'
    + 'FIELD:dob:LIKE(invalid_dob):TYPE(STRING):0,0\n'
    + 'FIELD:house:TYPE(STRING):0,0\n'
    + 'FIELD:pre_dir:LIKE(invalid_predir_postdir):TYPE(STRING):0,0\n'
    + 'FIELD:street:TYPE(STRING):0,0\n'
    + 'FIELD:street_type:LIKE(invalid_street_type):TYPE(STRING):0,0\n'
    + 'FIELD:post_dir:LIKE(invalid_predir_postdir):TYPE(STRING):0,0\n'
    + 'FIELD:apt_type:LIKE(invalid_apt_type):TYPE(STRING):0,0\n'
    + 'FIELD:apt_nbr:TYPE(STRING):0,0\n'
    + 'FIELD:zip:LIKE(invalid_zip):TYPE(STRING):0,0\n'
    + 'FIELD:plus4:LIKE(invalid_plus4):TYPE(STRING):0,0\n'
    + 'FIELD:dpc:LIKE(invalid_dpc):TYPE(STRING):0,0\n'
    + 'FIELD:z4_type:LIKE(invalid_z4_type):TYPE(STRING):0,0\n'
    + 'FIELD:crte:TYPE(STRING):0,0\n'
    + 'FIELD:city:LIKE(invalid_city):TYPE(STRING):0,0\n'
    + 'FIELD:state:LIKE(invalid_state):TYPE(STRING):0,0\n'
    + 'FIELD:dpvcmra:TYPE(STRING):0,0\n'
    + 'FIELD:dpvconf:TYPE(STRING):0,0\n'
    + 'FIELD:fips_state:LIKE(invalid_fips_state):TYPE(STRING):0,0\n'
    + 'FIELD:fips_county:LIKE(invalid_fips_county):TYPE(STRING):0,0\n'
    + 'FIELD:census_tract:TYPE(STRING):0,0\n'
    + 'FIELD:census_block_group:TYPE(STRING):0,0\n'
    + 'FIELD:cbsa:LIKE(invalid_cbsa):TYPE(STRING):0,0\n'
    + 'FIELD:match_code:TYPE(STRING):0,0\n'
    + 'FIELD:latitude:LIKE(invalid_lat_long):TYPE(STRING):0,0\n'
    + 'FIELD:longitude:LIKE(invalid_lat_long):TYPE(STRING):0,0\n'
    + 'FIELD:email:LIKE(invalid_email):TYPE(STRING):0,0\n'
    + 'FIELD:filler1:TYPE(STRING):0,0\n'
    + 'FIELD:filler2:TYPE(STRING):0,0\n'
    + 'FIELD:verified:LIKE(invalid_verified):TYPE(STRING):0,0\n'
    + 'FIELD:activity_status:LIKE(invalid_activity_status):TYPE(STRING):0,0\n'
    + 'FIELD:prepaid:LIKE(invalid_Y_N):TYPE(STRING):0,0\n'
    + 'FIELD:cord_cutter:LIKE(invalid_Y_N):TYPE(STRING):0,0\n'
    + '\n'
    ;
 
  // Structured values
  EXPORT linkpaths := DATASET([
    ],{STRING linkpath;STRING compulsory;STRING optional;STRING bonus;STRING required;STRING search});
 
END;

