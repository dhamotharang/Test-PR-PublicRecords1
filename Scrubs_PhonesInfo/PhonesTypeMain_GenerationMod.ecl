// Machine-readable versions of the spec file and subsets thereof
IMPORT SALT311;
EXPORT PhonesTypeMain_GenerationMod := MODULE(SALT311.iGenerationMod)
 
  // SALT Version info
  EXPORT salt_VERSION := 'V3.11.11';
  EXPORT salt_MODULE := 'SALT311'; // Optional override by HACK:SALTMODULE
  EXPORT salt_TOOLSMODULE := 'SALTTOOLS30'; // Optional override by HACK:SALTTOOLSMODULE
 
  // Core module configuration values
  EXPORT spc_MODULE := 'Scrubs_PhonesInfo';
  EXPORT spc_NAMESCOPE := 'PhonesTypeMain';
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
  EXPORT spc_EXTERNAL_BATCH_PARAM := ',/* MY_ */,phone,source,vendor_first_reported_dt,vendor_first_reported_time,vendor_last_reported_dt,vendor_last_reported_time,reference_id,reply_code,local_routing_number,account_owner,carrier_name,carrier_category,local_area_transport_area,point_code,serv,line,spid,operator_fullname,high_risk_indicator,prepaid,global_sid,record_sid';
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
    + 'NAMESCOPE:PhonesTypeMain\n'
    + '\n'
    + 'FIELDTYPE:Invalid_AlphaNum:ALLOW(ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789 )\n'
    + 'FIELDTYPE:Invalid_CharCat:ENUM(CAP|CLEC|GENERAL|IC|ILEC|INTL|IPES|L RESELLER|PCS|RBOC|ULEC|W RESELLER|WIRELESS| )\n'
    + 'FIELDTYPE:Invalid_Indic:ALLOW(1| )\n'
    + 'FIELDTYPE:Invalid_Num:ALLOW(0123456789)\n'
    + 'FIELDTYPE:Invalid_Src:ENUM(L6|P!|PB|PK)\n'
    + 'FIELDTYPE:Invalid_Type:ALLOW(0123 )\n'
    + '\n'
    + 'FIELD:phone:LIKE(Invalid_Num):TYPE(STRING10):0,0\n'
    + 'FIELD:source:LIKE(Invalid_Src):TYPE(STRING5):0,0\n'
    + 'FIELD:vendor_first_reported_dt:LIKE(Invalid_Num):TYPE(UNSIGNED8):0,0\n'
    + 'FIELD:vendor_first_reported_time:LIKE(Invalid_Num):TYPE(STRING6):0,0\n'
    + 'FIELD:vendor_last_reported_dt:LIKE(Invalid_Num):TYPE(UNSIGNED8):0,0\n'
    + 'FIELD:vendor_last_reported_time:LIKE(Invalid_Num):TYPE(STRING6):0,0\n'
    + 'FIELD:reference_id:LIKE(Invalid_AlphaNum):TYPE(STRING30):0,0\n'
    + 'FIELD:reply_code:LIKE(Invalid_Num):TYPE(STRING3):0,0\n'
    + 'FIELD:local_routing_number:LIKE(Invalid_Num):TYPE(STRING10):0,0\n'
    + 'FIELD:account_owner:LIKE(Invalid_AlphaNum):TYPE(STRING6):0,0\n'
    + 'FIELD:carrier_name:TYPE(STRING60):0,0\n'
    + 'FIELD:carrier_category:LIKE(Invalid_CharCat):TYPE(STRING10):0,0\n'
    + 'FIELD:local_area_transport_area:LIKE(Invalid_Num):TYPE(STRING5):0,0\n'
    + 'FIELD:point_code:TYPE(STRING10):0,0\n'
    + 'FIELD:serv:LIKE(Invalid_Type):TYPE(STRING1):0,0\n'
    + 'FIELD:line:LIKE(Invalid_Type):TYPE(STRING1):0,0\n'
    + 'FIELD:spid:LIKE(Invalid_AlphaNum):TYPE(STRING10):0,0\n'
    + 'FIELD:operator_fullname:TYPE(STRING60):0,0\n'
    + 'FIELD:high_risk_indicator:LIKE(Invalid_Indic):TYPE(STRING2):0,0\n'
    + 'FIELD:prepaid:LIKE(Invalid_Indic):TYPE(STRING2):0,0\n'
    + 'FIELD:global_sid:LIKE(Invalid_Num):TYPE(UNSIGNED4):0,0\n'
    + 'FIELD:record_sid:LIKE(Invalid_Num):TYPE(UNSIGNED8):0,0'
    ;
 
  // Structured values
  EXPORT linkpaths := DATASET([
    ],{STRING linkpath;STRING compulsory;STRING optional;STRING bonus;STRING required;STRING search});
 
END;

