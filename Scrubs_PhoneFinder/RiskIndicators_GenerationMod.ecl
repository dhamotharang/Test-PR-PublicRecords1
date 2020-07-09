﻿// Machine-readable versions of the spec file and subsets thereof
IMPORT SALT311;
EXPORT RiskIndicators_GenerationMod := MODULE(SALT311.iGenerationMod)
 
  // SALT Version info
  EXPORT salt_VERSION := 'V3.11.9';
  EXPORT salt_MODULE := 'SALT311'; // Optional override by HACK:SALTMODULE
  EXPORT salt_TOOLSMODULE := 'SALTTOOLS30'; // Optional override by HACK:SALTTOOLSMODULE
 
  // Core module configuration values
  EXPORT spc_MODULE := 'Scrubs_PhoneFinder';
  EXPORT spc_NAMESCOPE := 'RiskIndicators';
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
  EXPORT spc_EXTERNAL_BATCH_PARAM := ',/* MY_ */,transaction_id,phone_id,sequence_number,date_added,risk_indicator_id,risk_indicator_level,risk_indicator_text,risk_indicator_category,filename';
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
    + 'NAMESCOPE:RiskIndicators\n'
    + '\n'
    + 'FIELDTYPE:Invalid_No:ALLOW(0123456789\\\\N)\n'
    + 'FIELDTYPE:Invalid_ID:ALLOW(0123456789R\\\\N)\n'
    + 'FIELDTYPE:Invalid_Alpha:ALLOW(ABCDEFGHIJKLMNOPQRSTUVWXYZ\\\\ )\n'
    + 'FIELDTYPE:Invalid_AlphaChar:ALLOW(ABCDEFGHIJKLMNOPQRSTUVWXYZ .,/-\\\\\')\n'
    + 'FIELDTYPE:Invalid_Risk:CUSTOM(Scrubs_PhoneFinder.Functions.Risk_Check > 0)\n'
    + 'FIELDTYPE:Invalid_Date:CUSTOM(Scrubs_PhoneFinder.Functions.Split_Date > 0)\n'
    + 'FIELDTYPE:Invalid_File:CUSTOM(Scrubs_PhoneFinder.Functions.Check_File > 0)\n'
    + '\n'
    + 'FIELD:transaction_id:TYPE(STRING16):LIKE(Invalid_ID):0,0\n'
    + 'FIELD:phone_id:TYPE(INTEGER5):LIKE(Invalid_No):0,0\n'
    + 'FIELD:sequence_number:TYPE(INTEGER5):LIKE(Invalid_No):0,0\n'
    + 'FIELD:date_added:TYPE(STRING20):LIKE(Invalid_Date):0,0\n'
    + 'FIELD:risk_indicator_id:TYPE(INTEGER5):LIKE(Invalid_No):0,0\n'
    + 'FIELD:risk_indicator_level:TYPE(STRING16):LIKE(Invalid_Alpha):0,0\n'
    + 'FIELD:risk_indicator_text:TYPE(STRING256):0,0\n'
    + 'FIELD:risk_indicator_category:TYPE(STRING32):LIKE(Invalid_Risk):0,0\n'
    + 'FIELD:filename:TYPE(STRING255):LIKE(Invalid_File):0,0\n'
    ;
 
  // Structured values
  EXPORT linkpaths := DATASET([
    ],{STRING linkpath;STRING compulsory;STRING optional;STRING bonus;STRING required;STRING search});
 
END;

