// Machine-readable versions of the spec file and subsets thereof
IMPORT SALT39;
EXPORT In_Port_Daily_GenerationMod := MODULE(SALT39.iGenerationMod)
 
  // SALT Version info
  EXPORT salt_VERSION := 'V3.9.0';
  EXPORT salt_MODULE := 'SALT39'; // Optional override by HACK:SALTMODULE
  EXPORT salt_TOOLSMODULE := 'SALTTOOLS30'; // Optional override by HACK:SALTTOOLSMODULE
 
  // Core module configuration values
  EXPORT spc_MODULE := 'Scrubs_PhonesInfo';
  EXPORT spc_NAMESCOPE := 'In_Port_Daily';
  EXPORT spc_PROCESS := '';
  EXPORT spc_PROCLAYOUTS := 'Process__Layouts';
  EXPORT spc_IDNAME := ''; // cluster id (input)
  EXPORT spc_IDFIELD := ''; // cluster id (output)
  EXPORT spc_RIDFIELD := ''; // record id
  EXPORT spc_CONFIG := 'Config';
  EXPORT spc_CONFIGPARAM := FALSE;
  EXPORT spc_SOURCEFIELD := '';
  EXPORT spc_FILEPREFIX := 'In_';
  EXPORT spc_FILENAME := 'PhonesInfo';
  EXPORT spc_INGESTSTATUS := '';
  EXPORT spc_EXTERNAL_MAPPING := 'UniqueID:';
  EXPORT spc_EXTERNAL_BATCH_PARAM := ',/* MY_ */,action_code,country_code,phone,dial_type,spid,service_type,routing_code,porting_dt,country_abbr,filename';
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
    'options:-gh \n'
    + 'MODULE:Scrubs_PhonesInfo\n'
    + 'FILENAME:PhonesInfo\n'
    + 'NAMESCOPE:In_Port_Daily\n'
    + '\n'
    + 'FIELDTYPE:Invalid_Action_Code:ALLOW(AUD#cE)\n'
    + 'FIELDTYPE:Invalid_Num:ALLOW(0123456789)\n'
    + 'FIELDTYPE:Invalid_Num_Blank:ALLOW(0123456789 )\n'
    + 'FIELDTYPE:Invalid_DCT:ALLOW(ECTBN)\n'
    + 'FIELDTYPE:Invalid_TOS:ALLOW(MGOU)\n'
    + 'FIELDTYPE:Invalid_Port_Date:ALLOW(0123456789 /:-)\n'
    + 'FIELDTYPE:Invalid_ISO2:ALLOW(ABCDEFGHIJKLMNOPQRSTUVWXYZ)\n'
    + 'FIELDTYPE:Invalid_Filename:ALLOW(ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789_.:)\n'
    + '\n'
    + '\n'
    + 'FIELD:action_code:LIKE(Invalid_Action_Code):TYPE(STRING1):0,0\n'
    + 'FIELD:country_code:LIKE(Invalid_Num):TYPE(STRING3):0,0\n'
    + 'FIELD:phone:LIKE(Invalid_Num):TYPE(STRING12):0,0\n'
    + 'FIELD:dial_type:LIKE(Invalid_DCT):TYPE(STRING1):0,0\n'
    + 'FIELD:spid:LIKE(Invalid_Num):TYPE(STRING6):0,0\n'
    + 'FIELD:service_type:LIKE(Invalid_TOS):TYPE(STRING1):0,0\n'
    + 'FIELD:routing_code:LIKE(Invalid_Num_Blank):TYPE(STRING10):0,0\n'
    + 'FIELD:porting_dt:LIKE(Invalid_Port_Date):TYPE(STRING):0,0\n'
    + 'FIELD:country_abbr:LIKE(Invalid_ISO2):TYPE(STRING2):0,0\n'
    + 'FIELD:filename:LIKE(Invalid_Filename):TYPE(STRING255):0,0\n'
    ;
 
  // Structured values
  EXPORT linkpaths := DATASET([
    ],{STRING linkpath;STRING compulsory;STRING optional;STRING bonus;STRING required;STRING search});
 
END;

