// Machine-readable versions of the spec file and subsets thereof
IMPORT SALT311;
EXPORT GenerationMod := MODULE(SALT311.iGenerationMod)
 
  // SALT Version info
  EXPORT salt_VERSION := 'V3.11.4';
  EXPORT salt_MODULE := 'SALT311'; // Optional override by HACK:SALTMODULE
  EXPORT salt_TOOLSMODULE := 'SALTTOOLS30'; // Optional override by HACK:SALTTOOLSMODULE
 
  // Core module configuration values
  EXPORT spc_MODULE := 'NeustarWireless_IngestMain';
  EXPORT spc_NAMESCOPE := '';
  EXPORT spc_PROCESS := '';
  EXPORT spc_PROCLAYOUTS := 'Process__Layouts';
  EXPORT spc_IDNAME := ''; // cluster id (input)
  EXPORT spc_IDFIELD := ''; // cluster id (output)
  EXPORT spc_RIDFIELD := 'RCID'; // record id
  EXPORT spc_CONFIG := 'Config';
  EXPORT spc_CONFIGPARAM := FALSE;
  EXPORT spc_SOURCEFIELD := '';
  EXPORT spc_FILEPREFIX := 'In_';
  EXPORT spc_FILENAME := 'Main';
  EXPORT spc_INGESTSTATUS := '';
  EXPORT spc_EXTERNAL_MAPPING := 'UniqueID:RCID';
  EXPORT spc_EXTERNAL_BATCH_PARAM := ',/* MY_ */,phone,fname,lname,apt_nbr,latitude,longitude,nid,date_vendor_first_reported,date_vendor_last_reported';
  EXPORT spc_HAS_TWOSTEP := FALSE;
  EXPORT spc_HAS_PARTITION := FALSE;
  EXPORT spc_HAS_FIELDTYPES := FALSE;
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
    '//If a change is made to this file, modify the ingest.ecl generated as follows to avoid output name conflict\n'
    + '//replace NAMED(\'UpdateStats\') with NAMED(\'MainUpdateStats\')\n'
    + '//replace NAMED(\'ValidityStatistics\') with NAMED(\'MainValidityStatistics\')\n'
    + 'OPTIONS:-gn\n'
    + 'MODULE:NeustarWireless_IngestMain\n'
    + 'RIDFIELD:RCID:GENERATE\n'
    + 'FILENAME:Main\n'
    + '\n'
    + 'FIELD:phone:TYPE(STRING10):0,0\n'
    + 'FIELD:fname:TYPE(STRING15):0,0\n'
    + 'FIELD:lname:TYPE(STRING20):0,0\n'
    + 'FIELD:apt_nbr:TYPE(STRING8):0,0\n'
    + 'FIELD:latitude:TYPE(STRING11):0,0\n'
    + 'FIELD:longitude:TYPE(STRING11):0,0\n'
    + 'FIELD:nid:TYPE(UNSIGNED8):0,0\n'
    + 'FIELD:date_vendor_first_reported:RECORDDATE(FIRST):0,0\n'
    + 'FIELD:date_vendor_last_reported:RECORDDATE(LAST):0,0\n'
    + '\n'
    + 'SOURCERIDFIELD:phone\n'
    + '\n'
    + 'INGESTFILE:NeustarWirelessMain:NAMED(Prep_Main_Ingest)\n'
    ;
 
  // Structured values
  EXPORT linkpaths := DATASET([
    ],{STRING linkpath;STRING compulsory;STRING optional;STRING bonus;STRING required;STRING search});
 
END;

