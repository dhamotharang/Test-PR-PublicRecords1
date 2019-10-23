// Machine-readable versions of the spec file and subsets thereof
IMPORT SALT311;
EXPORT Orbit_GenerationMod := MODULE(SALT311.iGenerationMod)
 
  // SALT Version info
  EXPORT salt_VERSION := 'V3.11.6';
  EXPORT salt_MODULE := 'SALT311'; // Optional override by HACK:SALTMODULE
  EXPORT salt_TOOLSMODULE := 'SALTTOOLS30'; // Optional override by HACK:SALTTOOLSMODULE
 
  // Core module configuration values
  EXPORT spc_MODULE := 'Scrubs_Vendor_Src';
  EXPORT spc_NAMESCOPE := 'Orbit';
  EXPORT spc_PROCESS := '';
  EXPORT spc_PROCLAYOUTS := 'Process__Layouts';
  EXPORT spc_IDNAME := ''; // cluster id (input)
  EXPORT spc_IDFIELD := ''; // cluster id (output)
  EXPORT spc_RIDFIELD := ''; // record id
  EXPORT spc_CONFIG := 'Config';
  EXPORT spc_CONFIGPARAM := FALSE;
  EXPORT spc_SOURCEFIELD := '';
  EXPORT spc_FILEPREFIX := 'In_';
  EXPORT spc_FILENAME := 'Vendor_Src';
  EXPORT spc_INGESTSTATUS := '';
  EXPORT spc_EXTERNAL_MAPPING := 'UniqueID:';
  EXPORT spc_EXTERNAL_BATCH_PARAM := ',/* MY_ */,item_id,item_name,item_description,status_name,item_source_code,source_id,source_name,source_address1,source_address2,source_city,source_state,source_zip,source_phone,source_website,unused_source_sourcecodes,unused_fcra,unused_fcra_comments,market_restrict_flag,unused_market_comments,unused_contact_category_name,unused_contact_name,unused_contact_phone,unused_contact_email';
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
    + 'FILENAME:Vendor_Src\n'
    + 'NAMESCOPE:Orbit\n'
    + '// Uncomment up to NINES for internal or external adl\n'
    + '// IDFIELD:EXISTS:<NameOfIDField>\n'
    + '// RIDFIELD:<NameOfRidField>\n'
    + '// RECORDS:<NumberOfRecordsInDataFile>\n'
    + '// POPULATION:<ExpectedNumberOfEntitiesInDataFile>\n'
    + '// NINES:<Precision required 3 = 99.9%, 2 = 99% etc>\n'
    + '// Uncomment Process if doing external adl\n'
    + '// PROCESS:<ProcessName>\n'
    + '// FIELDTYPE statements can be used to clean up (or check the cleaning) of individual fields\n'
    + 'FIELDTYPE:item_id:ALLOW( 0123456789)\n'
    + 'FIELDTYPE:item_name:ALLOW( ()%@$&*,.-/#\'+_0123456789 ABCDEFGHIJKLMNOPQRSTUVWXYZ abcdefghijklmnopqrstuvwxyz\t)\n'
    + 'FIELDTYPE:item_description:ALLOW( ()&\',-./+_:$0123456789 ABCDEFGHIJKLMNOPQRSTUVWXYZ abcdefghijklmnopqrstuvwxyz\t)\n'
    + 'FIELDTYPE:status_name:ALLOW( \'-ABCDEFGHIJKLMNOPQRSTUVWXYZ abcdefghijklmnopqrstuvwxyz)\n'
    + 'FIELDTYPE:item_source_code:ALLOW( ()!#$%&*+,-./;<>?@[\\]^{|}~:_=0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZ abcdefghijklmnopqrstuvwxyz)\n'
    + 'FIELDTYPE:source_id:ALLOW( 0123456789)\n'
    + 'FIELDTYPE:source_name:ALLOW( ()&,-./_\'0123456789 ABCDEFGHIJKLMNOPQRSTUVWXYZ abcdefghijklmnopqrstuvwxyz\t)\n'
    + 'FIELDTYPE:source_address1:ALLOW( ()\'#&,-./:0123456789 ABCDEFGHIJKLMNOPQRSTUVWXYZ abcdefghijklmnopqrstuvwxyz\t)\n'
    + 'FIELDTYPE:source_address2:ALLOW( \'#,-._0123456789:0123456789 ABCDEFGHIJKLMNOPQRSTUVWXYZ abcdefghijklmnopqrstuvwxyz\t)\n'
    + 'FIELDTYPE:source_city:ALLOW( .ABCDEFGHIJKLMNOPQRSTUVWXYZ abcdefghijklmnopqrstuvwxyz)\n'
    + 'FIELDTYPE:source_state:ALLOW( ABCDEFGHIJKLMNOPQRSTUVWXYZ abcdefghijklmnopqrstuvwxyz)\n'
    + 'FIELDTYPE:source_zip:ALLOW( -0123456789ai)\n'
    + 'FIELDTYPE:source_phone:ALLOW( ()-./#0123456789?aenotwxpN)\n'
    + 'FIELDTYPE:source_website:ALLOW( ~&,-./0123456789:=?@\\_ABCDEFGHIJKLMNOPQRSTUVWXYZ abcdefghijklmnopqrstuvwxyz)\n'
    + 'FIELDTYPE:unused_source_sourcecodes:ALLOW()\n'
    + 'FIELDTYPE:unused_fcra:ALLOW()\n'
    + 'FIELDTYPE:unused_fcra_comments:ALLOW()\n'
    + 'FIELDTYPE:market_restrict_flag:ALLOW( NSYeost)\n'
    + 'FIELDTYPE:unused_market_comments:ALLOW()\n'
    + 'FIELDTYPE:unused_contact_category_name:ALLOW()\n'
    + 'FIELDTYPE:unused_contact_name:ALLOW()\n'
    + 'FIELDTYPE:unused_contact_phone:ALLOW()\n'
    + 'FIELDTYPE:unused_contact_email:ALLOW()\n'
    + '\n'
    + '// BESTTYPE statements declare methods of generating the best value for a given cluster; this can also improve linking\n'
    + '// FUZZY can be used to create new types of FUZZY linking\n'
    + '// Remember to generate specificities and update the 0,0 placeholders below before running any sort of linking.\n'
    + '// If the actual specificity for a field is <1, round it up to 1 rather than down to 0.  If your cluster is running\n'
    + '// a shared repository, calling SALTTOOLS30.mac_Patch_SPC from the bottom of BWR_Specificities may be a convenience.\n'
    + 'FIELD:item_id:LIKE(item_id):TYPE(STRING):0,0\n'
    + 'FIELD:item_name:LIKE(item_name):TYPE(STRING):0,0\n'
    + 'FIELD:item_description:LIKE(item_description):TYPE(STRING):0,0\n'
    + 'FIELD:status_name:LIKE(status_name):TYPE(STRING):0,0\n'
    + 'FIELD:item_source_code:LIKE(item_source_code):TYPE(STRING):0,0\n'
    + 'FIELD:source_id:LIKE(source_id):TYPE(STRING):0,0\n'
    + 'FIELD:source_name:LIKE(source_name):TYPE(STRING):0,0\n'
    + 'FIELD:source_address1:LIKE(source_address1):TYPE(STRING):0,0\n'
    + 'FIELD:source_address2:LIKE(source_address2):TYPE(STRING):0,0\n'
    + 'FIELD:source_city:LIKE(source_city):TYPE(STRING):0,0\n'
    + 'FIELD:source_state:LIKE(source_state):TYPE(STRING):0,0\n'
    + 'FIELD:source_zip:LIKE(source_zip):TYPE(STRING):0,0\n'
    + 'FIELD:source_phone:LIKE(source_phone):TYPE(STRING):0,0\n'
    + 'FIELD:source_website:LIKE(source_website):TYPE(STRING):0,0\n'
    + 'FIELD:unused_source_sourcecodes:LIKE(unused_source_sourcecodes):TYPE(STRING):0,0\n'
    + 'FIELD:unused_fcra:LIKE(unused_fcra):TYPE(STRING):0,0\n'
    + 'FIELD:unused_fcra_comments:LIKE(unused_fcra_comments):TYPE(STRING):0,0\n'
    + 'FIELD:market_restrict_flag:LIKE(market_restrict_flag):TYPE(STRING):0,0\n'
    + 'FIELD:unused_market_comments:LIKE(unused_market_comments):TYPE(STRING):0,0\n'
    + 'FIELD:unused_contact_category_name:LIKE():TYPE(STRING):0,0\n'
    + 'FIELD:unused_contact_name:LIKE(unused_contact_category_name):TYPE(STRING):0,0\n'
    + 'FIELD:unused_contact_phone:LIKE(unused_contact_phone):TYPE(STRING):0,0\n'
    + 'FIELD:unused_contact_email:LIKE(unused_contact_email):TYPE(STRING):0,0\n'
    + '// CONCEPT statements should be used to group together interellated fields; such as address\n'
    + '// RELATIONSHIP is used to find non-obvious relationships between the clusters\n'
    + '// SOURCEFIELD is used if a field of the file denotes a source of the records in that file\n'
    + '// LINKPATH is used to define access paths for external linking\n'
    ;
 
  // Structured values
  EXPORT linkpaths := DATASET([
    ],{STRING linkpath;STRING compulsory;STRING optional;STRING bonus;STRING required;STRING search});
 
END;

