// Machine-readable versions of the spec file and subsets thereof
IMPORT SALT311;
EXPORT PhonesTransactionMain2_GenerationMod := MODULE(SALT311.iGenerationMod)
 
  // SALT Version info
  EXPORT salt_VERSION := 'V3.11.11';
  EXPORT salt_MODULE := 'SALT311'; // Optional override by HACK:SALTMODULE
  EXPORT salt_TOOLSMODULE := 'SALTTOOLS30'; // Optional override by HACK:SALTTOOLSMODULE
 
  // Core module configuration values
  EXPORT spc_MODULE := 'Scrubs_PhonesInfo';
  EXPORT spc_NAMESCOPE := 'PhonesTransactionMain2';
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
  EXPORT spc_EXTERNAL_BATCH_PARAM := ',/* MY_ */,phone,source,transaction_code,transaction_start_dt,transaction_start_time,transaction_end_dt,transaction_end_time,transaction_count,vendor_first_reported_dt,vendor_first_reported_time,vendor_last_reported_dt,vendor_last_reported_time,country_code,country_abbr,routing_code,dial_type,spid,carrier_name,phone_swap,ocn,alt_spid,lalt_spid,global_sid,record_sid';
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
    + 'MODULE:Scrubs_PhonesInfo\n'
    + 'FILENAME:PhonesInfo\n'
    + 'NAMESCOPE:PhonesTransactionMain2\n'
    + '\n'
    + 'FIELDTYPE:Invalid_AlphaNum:ALLOW(ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789 )\n'
    + 'FIELDTYPE:Invalid_Char:ALLOW(ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789-/\' )\n'
    + 'FIELDTYPE:Invalid_CountryCode:ENUM(1| )\n'
    + 'FIELDTYPE:Invalid_CountryAbbr:ENUM(GU|MP|PR|US|VI| )\n'
    + 'FIELDTYPE:Invalid_DialTypeCode:ENUM(T| )\n'
    + 'FIELDTYPE:Invalid_Num:ALLOW(0123456789 )\n'
    + 'FIELDTYPE:Invalid_Src:ENUM(OT|P!|PG|PK|PX)\n'
    + 'FIELDTYPE:Invalid_TransCode:ENUM(AS|DE|RE|PA|PD|SA|SD|SU)\n'
    + '\n'
    + 'FIELD:phone:LIKE(Invalid_Num):TYPE(STRING10):0,0\n'
    + 'FIELD:source:LIKE(Invalid_Src):TYPE(STRING5):0,0\n'
    + 'FIELD:transaction_code:LIKE(Invalid_TransCode):TYPE(STRING2):0,0\n'
    + 'FIELD:transaction_start_dt:LIKE(Invalid_Num):TYPE(UNSIGNED8):0,0\n'
    + 'FIELD:transaction_start_time:LIKE(Invalid_Num):TYPE(STRING6):0,0\n'
    + 'FIELD:transaction_end_dt:LIKE(Invalid_Num):TYPE(UNSIGNED8):0,0\n'
    + 'FIELD:transaction_end_time:LIKE(Invalid_Num):TYPE(STRING6):0,0\n'
    + 'FIELD:transaction_count:LIKE(Invalid_Num):TYPE(UNSIGNED8):0,0\n'
    + 'FIELD:vendor_first_reported_dt:LIKE(Invalid_Num):TYPE(UNSIGNED8):0,0\n'
    + 'FIELD:vendor_first_reported_time:LIKE(Invalid_Num):TYPE(STRING6):0,0\n'
    + 'FIELD:vendor_last_reported_dt:LIKE(Invalid_Num):TYPE(UNSIGNED8):0,0\n'
    + 'FIELD:vendor_last_reported_time:LIKE(Invalid_Num):TYPE(STRING6):0,0\n'
    + 'FIELD:country_code:LIKE(Invalid_CountryCode):TYPE(STRING3):0,0\n'
    + 'FIELD:country_abbr:LIKE(Invalid_CountryAbbr):TYPE(STRING2):0,0\n'
    + 'FIELD:routing_code:LIKE(Invalid_Num):TYPE(STRING10):0,0\n'
    + 'FIELD:dial_type:LIKE(Invalid_DialTypeCode):TYPE(STRING1):0,0\n'
    + 'FIELD:spid:LIKE(Invalid_AlphaNum):TYPE(STRING10):0,0\n'
    + 'FIELD:carrier_name:TYPE(STRING60):0,0\n'
    + 'FIELD:phone_swap:LIKE(Invalid_Num):TYPE(STRING10):0,0\n'
    + 'FIELD:ocn:LIKE(Invalid_AlphaNum):TYPE(STRING6):0,0\n'
    + 'FIELD:alt_spid:LIKE(Invalid_AlphaNum):TYPE(STRING10):0,0\n'
    + 'FIELD:lalt_spid:LIKE(Invalid_AlphaNum):TYPE(STRING10):0,0\n'
    + 'FIELD:global_sid:LIKE(Invalid_Num):TYPE(UNSIGNED4):0,0\n'
    + 'FIELD:record_sid:LIKE(Invalid_Num):TYPE(UNSIGNED8):0,0'
    ;
 
  // Structured values
  EXPORT linkpaths := DATASET([
    ],{STRING linkpath;STRING compulsory;STRING optional;STRING bonus;STRING required;STRING search});
 
END;

