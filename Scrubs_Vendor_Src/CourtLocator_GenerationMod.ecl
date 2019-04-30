// Machine-readable versions of the spec file and subsets thereof
IMPORT SALT311;
EXPORT CourtLocator_GenerationMod := MODULE(SALT311.iGenerationMod)
 
  // SALT Version info
  EXPORT salt_VERSION := 'V3.11.6';
  EXPORT salt_MODULE := 'SALT311'; // Optional override by HACK:SALTMODULE
  EXPORT salt_TOOLSMODULE := 'SALTTOOLS30'; // Optional override by HACK:SALTTOOLSMODULE
 
  // Core module configuration values
  EXPORT spc_MODULE := 'Scrubs_Vendor_Src';
  EXPORT spc_NAMESCOPE := 'CourtLocator';
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
  EXPORT spc_EXTERNAL_BATCH_PARAM := ',/* MY_ */,fipscode,statefips,countyfips,courtid,consolidatedcourtid,masterid,stateofservice,countyofservice,courtname,phone,address1,address2,city,state,zipcode,zip4,mailaddress1,mailaddress2,mailcity,mailctate,mailzipcode,mailzip4';
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
    + 'NAMESCOPE:CourtLocator\n'
    + '// Uncomment up to NINES for internal or external adl\n'
    + '// IDFIELD:EXISTS:<NameOfIDField>\n'
    + '// RIDFIELD:<NameOfRidField>\n'
    + '// RECORDS:<NumberOfRecordsInDataFile>\n'
    + '// POPULATION:<ExpectedNumberOfEntitiesInDataFile>\n'
    + '// NINES:<Precision required 3 = 99.9%, 2 = 99% etc>\n'
    + '// Uncomment Process if doing external adl\n'
    + '// PROCESS:<ProcessName>\n'
    + '// FIELDTYPE statements can be used to clean up (or check the cleaning) of individual fields\n'
    + 'FIELDTYPE:fipscode:ALLOW(0123456789)\n'
    + 'FIELDTYPE:statefips:ALLOW(0123456789LA)\n'
    + 'FIELDTYPE:countyfips:ALLOW(0123456789)\n'
    + 'FIELDTYPE:courtid:ALLOW(0123456789)\n'
    + 'FIELDTYPE:consolidatedcourtid:ALLOW(0123456789)\n'
    + 'FIELDTYPE:masterid:ALLOW(0123456789 ABCDEFGHIJKLMNOPQRSTUVWXYZ abcdefghijklmnopqrstuvwxyz)\n'
    + 'FIELDTYPE:stateofservice:ALLOW(ABCDEFGHIJKLMNOPQRSTUVWXYZ abcdefghijklmnopqrstuvwxyz)\n'
    + 'FIELDTYPE:countyofservice:ALLOW( ()\'.-ABCDEFGHIJKLMNOPQRSTUVWXYZ abcdefghijklmnopqrstuvwxyz)\n'
    + 'FIELDTYPE:courtname:ALLOW( ()&#-.,/\\\'0123456789 ABCDEFGHIJKLMNOPQRSTUVWXYZ abcdefghijklmnopqrstuvwxyz\t)\n'
    + 'FIELDTYPE:phone:ALLOW(0123456789)\n'
    + 'FIELDTYPE:address1:ALLOW( ()$\'/#,&-.:;0123456789 ABCDEFGHIJKLMNOPQRSTUVWXYZ abcdefghijklmnopqrstuvwxyz\t)\n'
    + 'FIELDTYPE:address2:ALLOW( ()#&\',-./:;0123456789 ABCDEFGHIJKLMNOPQRSTUVWXYZ abcdefghijklmnopqrstuvwxyz\t)\n'
    + 'FIELDTYPE:city:ALLOW( /&-\'.,ABCDEFGHIJKLMNOPQRSTUVWXYZ abcdefghijklmnopqrstuvwxyz)\n'
    + 'FIELDTYPE:state:ALLOW(ACDEFGHIJKLMNOPRSTUVWXYZ)\n'
    + 'FIELDTYPE:zipcode:ALLOW(0123456789)\n'
    + 'FIELDTYPE:zip4:ALLOW(-0123456789)\n'
    + 'FIELDTYPE:mailaddress1:ALLOW( ()&\'/#,-.;:0123456789 ABCDEFGHIJKLMNOPQRSTUVWXYZ abcdefghijklmnopqrstuvwxyz\t)\n'
    + 'FIELDTYPE:mailaddress2:ALLOW( #&\',-./:;0123456789 ABCDEFGHIJKLMNOPQRSTUVWXYZ abcdefghijklmnopqrstuvwxyz\t)\n'
    + 'FIELDTYPE:mailcity:ALLOW( /&-\'.ABCDEFGHIJKLMNOPQRSTUVWXYZ abcdefghijklmnopqrstuvwxyz)\n'
    + 'FIELDTYPE:mailctate:ALLOW(ABCDEFGHIJKLMNOPQRSTUVWXYZ abcdefghijklmnopqrstuvwxyz)\n'
    + 'FIELDTYPE:mailzipcode:ALLOW(0123456789)\n'
    + 'FIELDTYPE:mailzip4:ALLOW(0123456789)\n'
    + '\n'
    + '// BESTTYPE statements declare methods of generating the best value for a given cluster; this can also improve linking\n'
    + '// FUZZY can be used to create new types of FUZZY linking\n'
    + '// Remember to generate specificities and update the 0,0 placeholders below before running any sort of linking.\n'
    + '// If the actual specificity for a field is <1, round it up to 1 rather than down to 0.  If your cluster is running\n'
    + '// a shared repository, calling SALTTOOLS30.mac_Patch_SPC from the bottom of BWR_Specificities may be a convenience.\n'
    + 'FIELD:fipscode:LIKE(fipscode):TYPE(STRING5):0,0\n'
    + 'FIELD:statefips:LIKE(statefips):TYPE(STRING2):0,0\n'
    + 'FIELD:countyfips:LIKE(countyfips):TYPE(STRING3):0,0\n'
    + 'FIELD:courtid:LIKE(courtid):TYPE(STRING):0,0\n'
    + 'FIELD:consolidatedcourtid:LIKE(consolidatedcourtid):TYPE(STRING):0,0\n'
    + 'FIELD:masterid:LIKE(masterid):TYPE(STRING):0,0\n'
    + 'FIELD:stateofservice:LIKE(stateofservice):TYPE(STRING):0,0\n'
    + 'FIELD:countyofservice:LIKE(countyofservice):TYPE(STRING):0,0\n'
    + 'FIELD:courtname:LIKE(courtname):TYPE(STRING):0,0\n'
    + 'FIELD:phone:LIKE(phone):TYPE(STRING):0,0\n'
    + 'FIELD:address1:LIKE(address1):TYPE(STRING):0,0\n'
    + 'FIELD:address2:LIKE(address2):TYPE(STRING):0,0\n'
    + 'FIELD:city:LIKE(city):TYPE(STRING):0,0\n'
    + 'FIELD:state:LIKE(state):TYPE(STRING):0,0\n'
    + 'FIELD:zipcode:LIKE(zipcode):TYPE(STRING5):0,0\n'
    + 'FIELD:zip4:LIKE(zip4):TYPE(STRING4):0,0\n'
    + 'FIELD:mailaddress1:LIKE(mailaddress1):TYPE(STRING):0,0\n'
    + 'FIELD:mailaddress2:LIKE(mailaddress2):TYPE(STRING):0,0\n'
    + 'FIELD:mailcity:LIKE(mailcity):TYPE(STRING):0,0\n'
    + 'FIELD:mailctate:LIKE(mailctate):TYPE(STRING):0,0\n'
    + 'FIELD:mailzipcode:LIKE(mailzipcode):TYPE(STRING5):0,0\n'
    + 'FIELD:mailzip4:LIKE(mailzip4):TYPE(STRING4):0,0\n'
    + '// CONCEPT statements should be used to group together interellated fields; such as address\n'
    + '// RELATIONSHIP is used to find non-obvious relationships between the clusters\n'
    + '// SOURCEFIELD is used if a field of the file denotes a source of the records in that file\n'
    + '// LINKPATH is used to define access paths for external linking\n'
    ;
 
  // Structured values
  EXPORT linkpaths := DATASET([
    ],{STRING linkpath;STRING compulsory;STRING optional;STRING bonus;STRING required;STRING search});
 
END;

