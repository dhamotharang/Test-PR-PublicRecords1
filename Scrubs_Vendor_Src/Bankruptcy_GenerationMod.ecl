// Machine-readable versions of the spec file and subsets thereof
IMPORT SALT311;
EXPORT Bankruptcy_GenerationMod := MODULE(SALT311.iGenerationMod)
 
  // SALT Version info
  EXPORT salt_VERSION := 'V3.11.6';
  EXPORT salt_MODULE := 'SALT311'; // Optional override by HACK:SALTMODULE
  EXPORT salt_TOOLSMODULE := 'SALTTOOLS30'; // Optional override by HACK:SALTTOOLSMODULE
 
  // Core module configuration values
  EXPORT spc_MODULE := 'Scrubs_Vendor_Src';
  EXPORT spc_NAMESCOPE := 'Bankruptcy';
  EXPORT spc_PROCESS := '';
  EXPORT spc_PROCLAYOUTS := 'Process__Layouts';
  EXPORT spc_IDNAME := ''; // cluster id (input)
  EXPORT spc_IDFIELD := ''; // cluster id (output)
  EXPORT spc_RIDFIELD := ''; // record id
  EXPORT spc_CONFIG := 'Config';
  EXPORT spc_CONFIGPARAM := FALSE;
  EXPORT spc_SOURCEFIELD := '';
  EXPORT spc_FILEPREFIX := 'In_';
  EXPORT spc_FILENAME := 'Bankruptcy';
  EXPORT spc_INGESTSTATUS := '';
  EXPORT spc_EXTERNAL_MAPPING := 'UniqueID:';
  EXPORT spc_EXTERNAL_BATCH_PARAM := ',/* MY_ */,lncourtcode,court_code,court_name,address1,address2,city,state,zip,phone';
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
    + 'MODULE:Scrubs_Vendor_Src\n'
    + 'FILENAME:Bankruptcy\n'
    + 'NAMESCOPE:Bankruptcy\n'
    + '\n'
    + 'FIELDTYPE:Invalid_lncourtcode:ALLOW(1234567ACDEFGHIJKLMNOPRSTUVWXYZ)\n'
    + 'FIELDTYPE:Invalid_court_code:ALLOW(12ABCDEFGHIJKLMNOPRSTUVWXYZ)\n'
    + 'FIELDTYPE:Invalid_court_name:ALLOW( -ABCDEFGHIJKLMNOPRSTUVWXY)\n'
    + 'FIELDTYPE:Invalid_address1:ALLOW( ,.0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZ)\n'
    + 'FIELDTYPE:Invalid_address2:ALLOW( #,-.0123456789ABCDEFGHIKLMNOPRSTUVWX)\n'
    + 'FIELDTYPE:Invalid_city:ALLOW( ABCDEFGHIJKLMNOPQRSTUVWXY)\n'
    + 'FIELDTYPE:Invalid_state:ALLOW(ACDEFGHIJKLMNOPRSTUVWXYZ)\n'
    + 'FIELDTYPE:Invalid_zip:ALLOW(0123456789)\n'
    + 'FIELDTYPE:Invalid_phone:ALLOW(0123456789)\n'
    + '\n'
    + '\n'
    + 'FIELD:lncourtcode:LIKE(Invalid_lncourtcode):TYPE(STRING):0,0\n'
    + 'FIELD:court_code:LIKE(Invalid_court_code):TYPE(STRING):0,0\n'
    + 'FIELD:court_name:LIKE(Invalid_court_name):TYPE(STRING):0,0\n'
    + 'FIELD:address1:LIKE(Invalid_address1):TYPE(STRING):0,0\n'
    + 'FIELD:address2:LIKE(Invalid_address2):TYPE(STRING):0,0\n'
    + 'FIELD:city:LIKE(Invalid_city):TYPE(STRING):0,0\n'
    + 'FIELD:state:LIKE(Invalid_state):TYPE(STRING):0,0\n'
    + 'FIELD:zip:LIKE(Invalid_zip):TYPE(STRING):0,0\n'
    + 'FIELD:phone:LIKE(Invalid_phone):TYPE(STRING):0,0\n'
    ;
 
  // Structured values
  EXPORT linkpaths := DATASET([
    ],{STRING linkpath;STRING compulsory;STRING optional;STRING bonus;STRING required;STRING search});
 
END;

