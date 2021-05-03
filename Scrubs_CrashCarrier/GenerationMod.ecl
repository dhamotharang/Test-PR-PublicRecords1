// Machine-readable versions of the spec file and subsets thereof
IMPORT SALT311;
EXPORT GenerationMod := MODULE(SALT311.iGenerationMod)
 
  // SALT Version info
  EXPORT salt_VERSION := 'V3.11.8';
  EXPORT salt_MODULE := 'SALT311'; // Optional override by HACK:SALTMODULE
  EXPORT salt_TOOLSMODULE := 'SALTTOOLS30'; // Optional override by HACK:SALTTOOLSMODULE
 
  // Core module configuration values
  EXPORT spc_MODULE := 'Scrubs_CrashCarrier';
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
  EXPORT spc_FILENAME := 'In_CrashCarrier';
  EXPORT spc_INGESTSTATUS := '';
  EXPORT spc_EXTERNAL_MAPPING := 'UniqueID:';
  EXPORT spc_EXTERNAL_BATCH_PARAM := ',/* MY_ */,carrier_id,crash_id,carrier_source_code,carrier_name,carrier_street,carrier_city,carrier_city_code,carrier_state,carrier_zip_code,crash_colonia,docket_number,interstate,no_id_flag,state_number,state_issuing_number';
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
    + 'MODULE:Scrubs_CrashCarrier\n'
    + 'FILENAME:In_CrashCarrier\n'
    + '//Uncomment up to NINES for internal or external adl\n'
    + '//IDFIELD:EXISTS:<NameOfIDField>\n'
    + '//RIDFIELD:<NameOfRidField>\n'
    + '//RECORDS:<NumberOfRecordsInDataFile>\n'
    + '//POPULATION:<ExpectedNumberOfEntitiesInDataFile>\n'
    + '//NINES:<Precision required 3 = 99.9%, 2 = 99% etc>\n'
    + '//Uncomment Process if doing external adl\n'
    + '//PROCESS:<ProcessName>\n'
    + '\n'
    + 'FIELDTYPE:Invalid_id:CUSTOM(Scrubs.functions.fn_numeric>0,7)\n'
    + 'FIELDTYPE:Invalid_mandatory_alpha:CUSTOM(Scrubs.functions.fn_ASCII_printable>0):LENGTHS(1..)\n'
    + 'FIELDTYPE:Invalid_alpha:CUSTOM(Scrubs.functions.fn_ASCII_printable>0) \n'
    + 'FIELDTYPE:Invalid_zip:CUSTOM(Scrubs.functions.fn_valid_zip>0)\n'
    + 'FIELDTYPE:Invalid_Numeric_Optional:ALLOW(0123456789 )\n'
    + 'FIELDTYPE:Invalid_interstate:ENUM(N|Y|X| )\n'
    + 'FIELDTYPE:Invalid_no_id_flag:ENUM(0|1)\n'
    + '\n'
    + 'FIELD:carrier_id:LIKE(Invalid_id):0,0\t\t\t\t\t\t\n'
    + 'FIELD:crash_id:LIKE(Invalid_id):0,0\t\t\t\t\t\n'
    + 'FIELD:carrier_source_code:0,0\t\t\t\n'
    + 'FIELD:carrier_name:LIKE(Invalid_mandatory_alpha):0,0\t\t\t\t\t\t\n'
    + 'FIELD:carrier_street:LIKE(Invalid_alpha):0,0\t\t\t\t\t\t\t\n'
    + 'FIELD:carrier_city:LIKE(Invalid_alpha):0,0\t\t\t\n'
    + 'FIELD:carrier_city_code:0,0\n'
    + 'FIELD:carrier_state:LIKE(Invalid_alpha):0,0\n'
    + 'FIELD:carrier_zip_code:LIKE(Invalid_alpha):0,0\n'
    + 'FIELD:crash_colonia:0,0\n'
    + '// FIELD:prefix:0,0 -- not populated by the vendor and "prefix" is a reserved word, so commenting it out\n'
    + 'FIELD:docket_number:LIKE(Invalid_Numeric_Optional):0,0\n'
    + 'FIELD:interstate:LIKE(Invalid_interstate):0,0\n'
    + 'FIELD:no_id_flag:LIKE(Invalid_no_id_flag):0,0\n'
    + 'FIELD:state_number:LIKE(Invalid_alpha):0,0\t\t\t\n'
    + 'FIELD:state_issuing_number:LIKE(Invalid_alpha):0,0'
    ;
 
  // Structured values
  EXPORT linkpaths := DATASET([
    ],{STRING linkpath;STRING compulsory;STRING optional;STRING bonus;STRING required;STRING search});
 
END;

