﻿// Machine-readable versions of the spec file and subsets thereof
IMPORT SALT311;
EXPORT ColValDesc_GenerationMod := MODULE(SALT311.iGenerationMod)
 
  // SALT Version info
  EXPORT salt_VERSION := 'V3.11.8';
  EXPORT salt_MODULE := 'SALT311'; // Optional override by HACK:SALTMODULE
  EXPORT salt_TOOLSMODULE := 'SALTTOOLS30'; // Optional override by HACK:SALTTOOLSMODULE
 
  // Core module configuration values
  EXPORT spc_MODULE := 'Scrubs_MBS';
  EXPORT spc_NAMESCOPE := 'ColValDesc';
  EXPORT spc_PROCESS := '';
  EXPORT spc_PROCLAYOUTS := 'Process__Layouts';
  EXPORT spc_IDNAME := ''; // cluster id (input)
  EXPORT spc_IDFIELD := ''; // cluster id (output)
  EXPORT spc_RIDFIELD := ''; // record id
  EXPORT spc_CONFIG := 'Config';
  EXPORT spc_CONFIGPARAM := FALSE;
  EXPORT spc_SOURCEFIELD := '';
  EXPORT spc_FILEPREFIX := 'In_';
  EXPORT spc_FILENAME := 'ColValDesc';
  EXPORT spc_INGESTSTATUS := '';
  EXPORT spc_EXTERNAL_MAPPING := 'UniqueID:';
  EXPORT spc_EXTERNAL_BATCH_PARAM := ',/* MY_ */,column_value_desc_id,table_column_id,desc_value,status,description';
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
    + 'MODULE:Scrubs_MBS\n'
    + 'FILENAME:ColValDesc\n'
    + 'NAMESCOPE:ColValDesc\n'
    + '// Uncomment up to NINES for internal or external adl\n'
    + '// IDFIELD:EXISTS:<NameOfIDField>\n'
    + '// RIDFIELD:<NameOfRidField>\n'
    + '// RECORDS:<NumberOfRecordsInDataFile>\n'
    + '// POPULATION:<ExpectedNumberOfEntitiesInDataFile>\n'
    + '// NINES:<Precision required 3 = 99.9%, 2 = 99% etc>\n'
    + '// Uncomment Process if doing external adl\n'
    + '// PROCESS:<ProcessName>\n'
    + '// FIELDTYPE statements can be used to clean up (or check the cleaning) of individual fields\n'
    + '// BESTTYPE statements declare methods of generating the best value for a given cluster; this can also improve linking\n'
    + '// FUZZY can be used to create new types of FUZZY linking\n'
    + 'FIELDTYPE:invalid_text:ALLOW(\\ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789):SPACES( <>{}[]-^=\'`!+&,./#()_:%,):ONFAIL(BLANK)\n'
    + 'FIELDTYPE:invalid_alpha:ALLOW(\\NABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz):ONFAIL(BLANK)\n'
    + 'FIELDTYPE:invalid_alphanumeric:ALLOW(\\ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789):SPACES( <>{}[]-^=\'`!+&,./#()_):ONFAIL(BLANK)\n'
    + 'FIELDTYPE:invalid_email:ALLOW(\\-_.0123456789@ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz):ONFAIL(BLANK)\n'
    + 'FIELDTYPE:invalid_date:ALLOW(\\N0123456789):SPACES( ./:-):LEFTTRIM:ONFAIL(BLANK)\n'
    + 'FIELDTYPE:invalid_numeric:ALLOW(0123456789):ONFAIL(BLANK)\n'
    + 'FIELDTYPE:invalid_numeric_string:ALLOW(\\N-0123456789):ONFAIL(BLANK)\n'
    + 'FIELDTYPE:invalid_real:ALLOW(-.,0123456789):ONFAIL(BLANK)\n'
    + 'FIELDTYPE:invalid_real_string:ALLOW(\\N-.,0123456789):ONFAIL(BLANK)\n'
    + 'FIELDTYPE:invalid_zip:ALLOW(\\N-0123456789):SPACES( -):LEFTTRIM:LENGTHS(2,5,9,10):ONFAIL(BLANK)\n'
    + 'FIELDTYPE:invalid_state:ALLOW(\\ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz):LEFTTRIM:LENGTHS(2):ONFAIL(BLANK)\n'
    + 'FIELDTYPE:invalid_ssn:ALLOW(\\N0123456789):SPACES( -):LEFTTRIM:LENGTHS(2,9..):ONFAIL(BLANK)\n'
    + 'FIELDTYPE:invalid_phone:ALLOW(\\N0123456789):SPACES( +#()-):LEFTTRIM:LENGTHS(2,10..):ONFAIL(BLANK)\n'
    + 'FIELDTYPE:invalid_ip:ALLOW(\\N.x0123456789):SPACES( .):LEFTTRIM:ONFAIL(BLANK)\n'
    + 'FIELDTYPE:invalid_name:ALLOW(\\NABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz):LEFTTRIM:SPACES( \'):ONFAIL(BLANK)\n'
    + '\n'
    + '// Remember to generate specificities and upda\n'
    + '// Remember to generate specificities and update the 0,0 placeholders below before running any sort of linking.\n'
    + '// If the actual specificity for a field is <1, round it up to 1 rather than down to 0.  If your cluster is running\n'
    + '// a shared repository, calling SALTTOOLS30.mac_Patch_SPC from the bottom of BWR_Specificities may be a convenience.\n'
    + 'FIELD:column_value_desc_id:TYPE(UNSIGNED3):LIKE(invalid_numeric):0,0\n'
    + 'FIELD:table_column_id:TYPE(UNSIGNED3):LIKE(invalid_numeric):0,0\n'
    + 'FIELD:desc_value:TYPE(QSTRING192):LIKE(invalid_text):0,0\n'
    + 'FIELD:status:TYPE(UNSIGNED2):LIKE(invalid_numeric):0,0\n'
    + 'FIELD:description:TYPE(QSTRING225):LIKE(invalid_text):0,0\n'
    + '// CONCEPT statements should be used to group together interellated fields; such as address\n'
    + '// RELATIONSHIP is used to find non-obvious relationships between the clusters\n'
    + '// SOURCEFIELD is used if a field of the file denotes a source of the records in that file\n'
    + '// LINKPATH is used to define access paths for external linking \n'
    ;
 
  // Structured values
  EXPORT linkpaths := DATASET([
    ],{STRING linkpath;STRING compulsory;STRING optional;STRING bonus;STRING required;STRING search});
 
END;

