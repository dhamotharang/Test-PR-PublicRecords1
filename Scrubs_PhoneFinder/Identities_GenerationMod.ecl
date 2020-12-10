// Machine-readable versions of the spec file and subsets thereof
IMPORT SALT311;
EXPORT Identities_GenerationMod := MODULE(SALT311.iGenerationMod)
 
  // SALT Version info
  EXPORT salt_VERSION := 'V3.11.11';
  EXPORT salt_MODULE := 'SALT311'; // Optional override by HACK:SALTMODULE
  EXPORT salt_TOOLSMODULE := 'SALTTOOLS30'; // Optional override by HACK:SALTTOOLSMODULE
 
  // Core module configuration values
  EXPORT spc_MODULE := 'Scrubs_PhoneFinder';
  EXPORT spc_NAMESCOPE := 'Identities';
  EXPORT spc_PROCESS := '';
  EXPORT spc_PROCLAYOUTS := 'Process__Layouts';
  EXPORT spc_IDNAME := ''; // cluster id (input)
  EXPORT spc_IDFIELD := ''; // cluster id (output)
  EXPORT spc_RIDFIELD := ''; // record id
  EXPORT spc_CONFIG := 'Config';
  EXPORT spc_CONFIGPARAM := FALSE;
  EXPORT spc_SOURCEFIELD := '';
  EXPORT spc_FILEPREFIX := 'In_';
  EXPORT spc_FILENAME := 'PhoneFinder';
  EXPORT spc_INGESTSTATUS := '';
  EXPORT spc_EXTERNAL_MAPPING := 'UniqueID:';
  EXPORT spc_EXTERNAL_BATCH_PARAM := ',/* MY_ */,transaction_id,sequence_number,lexid,full_name,full_address,city,state,zip,verified_carrier,date_added,filename';
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
    + 'MODULE:Scrubs_PhoneFinder\n'
    + 'FILENAME:PhoneFinder\n'
    + 'NAMESCOPE:Identities\n'
    + '\n'
    + '\n'
    + 'FIELDTYPE:Invalid_No:ALLOW(0123456789\\\\N)\n'
    + 'FIELDTYPE:Invalid_ID:ALLOW(0123456789R\\\\N)\n'
    + 'FIELDTYPE:Invalid_State:ALLOW(ABCDEFGHIJKLMNOPQRSTUVWXYZ\\\\ ):LENGTHS(0,2)\n'
    + 'FIELDTYPE:Invalid_AlphaChar:ALLOW(0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZ&#\\\\(\\\\)_\\|:;* .,/+-@\\\\\')\n'
    + 'FIELDTYPE:Invalid_AlphaNumChar:ALLOW(0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZ&#\\\\(\\\\)_\\|:;* .,/+-@\\\\\')\n'
    + 'FIELDTYPE:Invalid_Zip:LIKE(Invalid_No):LENGTHS(0,2,5)\n'
    + 'FIELDTYPE:Invalid_Date:CUSTOM(Scrubs_PhoneFinder.Functions.Split_Date > 0)\n'
    + 'FIELDTYPE:Invalid_File:CUSTOM(Scrubs_PhoneFinder.Functions.Check_File > 0)\n'
    + '\n'
    + 'FIELD:transaction_id:TYPE(STRING16):LIKE(Invalid_ID):0,0R\n'
    + 'FIELD:sequence_number:TYPE(INTEGER5):LIKE(Invalid_No):0,0\n'
    + 'FIELD:lexid:TYPE(STRING32):LIKE(Invalid_No):0,0\n'
    + 'FIELD:full_name:TYPE(STRING128):LIKE(Invalid_AlphaChar):0,0\n'
    + 'FIELD:full_address:TYPE(STRING128):LIKE(Invalid_AlphaNumChar):0,0\n'
    + 'FIELD:city:TYPE(STRING64):LIKE(Invalid_AlphaChar):0,0\n'
    + 'FIELD:state:TYPE(STRING16):LIKE(Invalid_State):0,0\n'
    + 'FIELD:zip:TYPE(STRING10):LIKE(Invalid_Zip):0,0\n'
    + 'FIELD:verified_carrier:TYPE(INTEGER1):LIKE(Invalid_No):0,0\n'
    + 'FIELD:date_added:TYPE(STRING20):LIKE(Invalid_Date):0,0\n'
    + 'FIELD:filename:TYPE(STRING255):LIKE(Invalid_File):0,0\n'
    ;
 
  // Structured values
  EXPORT linkpaths := DATASET([
    ],{STRING linkpath;STRING compulsory;STRING optional;STRING bonus;STRING required;STRING search});
 
END;

