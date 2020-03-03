// Machine-readable versions of the spec file and subsets thereof
IMPORT SALT311;
EXPORT alias_counties_GenerationMod := MODULE(SALT311.iGenerationMod)
 
  // SALT Version info
  EXPORT salt_VERSION := 'V3.11.9';
  EXPORT salt_MODULE := 'SALT311'; // Optional override by HACK:SALTMODULE
  EXPORT salt_TOOLSMODULE := 'SALTTOOLS30'; // Optional override by HACK:SALTTOOLSMODULE
 
  // Core module configuration values
  EXPORT spc_MODULE := 'Scrubs_Crim';
  EXPORT spc_NAMESCOPE := 'alias_counties';
  EXPORT spc_PROCESS := '';
  EXPORT spc_PROCLAYOUTS := 'Process__Layouts';
  EXPORT spc_IDNAME := ''; // cluster id (input)
  EXPORT spc_IDFIELD := ''; // cluster id (output)
  EXPORT spc_RIDFIELD := ''; // record id
  EXPORT spc_CONFIG := 'Config';
  EXPORT spc_CONFIGPARAM := FALSE;
  EXPORT spc_SOURCEFIELD := 'vendor';
  EXPORT spc_FILEPREFIX := 'In_';
  EXPORT spc_FILENAME := 'crim';
  EXPORT spc_INGESTSTATUS := '';
  EXPORT spc_EXTERNAL_MAPPING := 'UniqueID:';
  EXPORT spc_EXTERNAL_BATCH_PARAM := ',/* MY_ */,recordid,statecode,akaname,akalastname,akafirstname,akamiddlename,akasuffix,akadob,sourcename,vendor';
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
    + 'MODULE:Scrubs_Crim\n'
    + 'FILENAME:crim\n'
    + 'NAMESCOPE:alias_counties\n'
    + 'SOURCEFIELD:vendor\n'
    + '\n'
    + 'FIELDTYPE:Invalid_Record_ID:ALLOW(ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789_ )\n'
    + 'FIELDTYPE:Invalid_State:ALLOW(ABCDEFGHIJKLMNOPQRSTUVWXYZ)\n'
    + 'FIELDTYPE:Invalid_Date:CUSTOM(Scrubs.fn_valid_date>0)\n'
    + 'FIELDTYPE:AKA_Search:CUSTOM(Scrubs_Crim.fn_FindAKA>0)\n'
    + '\n'
    + 'FIELD:recordid:LIKE(Invalid_Record_ID):TYPE(STRING40):0,0\n'
    + 'FIELD:statecode:LIKE(Invalid_State):TYPE(STRING2):0,0\n'
    + 'FIELD:akaname:LIKE(AKA_Search):TYPE(STRING115):0,0\n'
    + 'FIELD:akalastname:LIKE(AKA_Search):TYPE(STRING50):0,0\n'
    + 'FIELD:akafirstname:LIKE(AKA_Search):TYPE(STRING50):0,0\n'
    + 'FIELD:akamiddlename:LIKE(AKA_Search):TYPE(STRING40):0,0\n'
    + 'FIELD:akasuffix:TYPE(STRING15):0,0\n'
    + 'FIELD:akadob:LIKE(Invalid_Date):TYPE(STRING8):0,0\n'
    + 'FIELD:sourcename:TYPE(STRING100):0,0\n'
    + 'FIELD:vendor:TYPE(STRING10):0,0\n'
    + '//CONCEPT statements should be used to group together interellated fields; such as address\n'
    + '//RELATIONSHIP is used to find non-obvious relationships between the clusters\n'
    + '//SOURCEFIELD is used if a field of the file denotes a source of the records in that file\n'
    + '//LINKPATH is used to define access paths for external linking\n'
    ;
 
  // Structured values
  EXPORT linkpaths := DATASET([
    ],{STRING linkpath;STRING compulsory;STRING optional;STRING bonus;STRING required;STRING search});
 
END;

