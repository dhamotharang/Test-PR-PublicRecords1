// Machine-readable versions of the spec file and subsets thereof
IMPORT SALT311;
EXPORT GenerationMod := MODULE(SALT311.iGenerationMod)
 
  // SALT Version info
  EXPORT salt_VERSION := 'V3.11.6';
  EXPORT salt_MODULE := 'SALT311'; // Optional override by HACK:SALTMODULE
  EXPORT salt_TOOLSMODULE := 'SALTTOOLS30'; // Optional override by HACK:SALTTOOLSMODULE
 
  // Core module configuration values
  EXPORT spc_MODULE := 'Scrubs_DunnData_Email';
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
  EXPORT spc_FILENAME := 'DunnData_Email';
  EXPORT spc_INGESTSTATUS := '';
  EXPORT spc_EXTERNAL_MAPPING := 'UniqueID:';
  EXPORT spc_EXTERNAL_BATCH_PARAM := ',/* MY_ */,dtmatch,email,name_full,address1,address2,city,state,zip5,zip_ext,ipaddr,datestamp,url,lastdate,em_src_cnt,num_emails,num_indiv';
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
    + 'MODULE:Scrubs_DunnData_Email\n'
    + 'FILENAME:DunnData_Email\n'
    + '\n'
    + 'FIELDTYPE:invalid_alpha:ALLOW(ABCDEFGHIJKLMNOPQRSTUVWXYZ\'):SPACES( -.,):LEFTTRIM:LENGTHS(0..)\n'
    + 'FIELDTYPE:invalid_alnum:ALLOW(ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789\'):SPACES( -.,):LEFTTRIM:LENGTHS(0..)\n'
    + 'FIELDTYPE:invalid_date:ALLOW(0123456789):LEFTTRIM:LENGTHS(0..8)\n'
    + 'FIELDTYPE:invalid_name:SPACES( ):ALLOW( ABCDEFGHIJKLMNOPQRSTUVWXYZ):LEFTTRIM:WORDS(2,3)\n'
    + 'FIELDTYPE:invalid_address1:SPACES( ):ALLOW( 0123456789ABCDEFGHIJKLMNOPRSTUVWXYZ):LEFTTRIM:LENGTHS(0..)\n'
    + 'FIELDTYPE:invalid_address2:SPACES( ):ALLOW( #-0123456789ABCDEFGHIJKLMNOPRSTUVW):LEFTTRIM:LENGTHS(0..)\n'
    + 'FIELDTYPE:invalid_city:SPACES( ):ALLOW( ABCDEFGHIJKLMNOPQRSTUVWXY):LEFTTRIM:LENGTHS(0..)\n'
    + 'FIELDTYPE:invalid_zip:ALLOW(0123456789):LEFTTRIM:LENGTHS(0,5)\n'
    + 'FIELDTYPE:invalid_state:ALLOW(ABCDEFGHIJKLMNOPQRSTUVWXYZ):LEFTTRIM:LENGTHS(2,0)\n'
    + 'FIELDTYPE:invalid_ip:SPACES( ):ALLOW(.0123456789):LEFTTRIM:LENGTHS(0..)\n'
    + 'FIELDTYPE:invalid_datestamp:SPACES( ):ALLOW( -./0123456789:):LEFTTRIM:LENGTHS(19,8,0,16,23,10)\n'
    + 'FIELDTYPE:invalid_url:SPACES( ):ALLOW(-./01234:ABCDEFGHIJKLMNOPQRSTUVWXYZ_):LEFTTRIM:LENGTHS(0..)\n'
    + 'FIELDTYPE:invalid_lastdate:SPACES( ):ALLOW(/0123456789):LEFTTRIM:LENGTHS(10,0)\n'
    + '\n'
    + '\n'
    + 'FIELD:dtmatch:TYPE(STRING32):0,0\n'
    + 'FIELD:email:TYPE(STRING60):0,0\n'
    + 'FIELD:name_full:LIKE(invalid_name):TYPE(STRING50):0,0\n'
    + 'FIELD:address1:LIKE(invalid_address1):TYPE(STRING50):0,0\n'
    + 'FIELD:address2:LIKE(invalid_address2):TYPE(STRING50):0,0\n'
    + 'FIELD:city:LIKE(invalid_city):TYPE(STRING20):0,0\n'
    + 'FIELD:state:LIKE(invalid_state):TYPE(STRING2):0,0\n'
    + 'FIELD:zip5:LIKE(invalid_zip):TYPE(STRING5):0,0\n'
    + 'FIELD:zip_ext:TYPE(STRING4):0,0\n'
    + 'FIELD:ipaddr:LIKE(invalid_ip):TYPE(STRING25):0,0\n'
    + 'FIELD:datestamp:LIKE(invalid_datestamp):TYPE(STRING25):0,0\n'
    + 'FIELD:url:LIKE(invalid_url):TYPE(STRING100):0,0\n'
    + 'FIELD:lastdate:LIKE(invalid_lastdate):TYPE(STRING10):0,0\n'
    + 'FIELD:em_src_cnt:TYPE(STRING8):0,0\n'
    + 'FIELD:num_emails:TYPE(STRING8):0,0\n'
    + 'FIELD:num_indiv:TYPE(STRING8):0,0\n'
    + '// CONCEPT statements should be used to group together interellated fields; such as address\n'
    + '// RELATIONSHIP is used to find non-obvious relationships between the clusters\n'
    + '// SOURCEFIELD is used if a field of the file denotes a source of the records in that file\n'
    + '// LINKPATH is used to define access paths for external linking\n'
    ;
 
  // Structured values
  EXPORT linkpaths := DATASET([
    ],{STRING linkpath;STRING compulsory;STRING optional;STRING bonus;STRING required;STRING search});
 
END;

