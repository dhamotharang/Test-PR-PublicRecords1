// Machine-readable versions of the spec file and subsets thereof
IMPORT SALT39;
EXPORT LIDBProcessed_GenerationMod := MODULE(SALT39.iGenerationMod)
 
  // SALT Version info
  EXPORT salt_VERSION := 'V3.9.0';
  EXPORT salt_MODULE := 'SALT39'; // Optional override by HACK:SALTMODULE
  EXPORT salt_TOOLSMODULE := 'SALTTOOLS30'; // Optional override by HACK:SALTTOOLSMODULE
 
  // Core module configuration values
  EXPORT spc_MODULE := 'Scrubs_PhonesInfo';
  EXPORT spc_NAMESCOPE := 'LIDBProcessed';
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
  EXPORT spc_EXTERNAL_BATCH_PARAM := ',/* MY_ */,reference_id,dt_first_reported,dt_last_reported,phone,reply_code,local_routing_number,account_owner,carrier_name,carrier_category,local_area_transport_area,point_code,serv,line,spid,operator_fullname,activation_dt,number_in_service,high_risk_indicator,prepaid';
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
    + 'NAMESCOPE:LIDBProcessed\n'
    + '\n'
    + 'FIELDTYPE:Invalid_Num:ALLOW(0123456789 )\n'
    + 'FIELDTYPE:Invalid_AccOwn:ALLOW(ABHGCDFE0123456789 )\n'
    + 'FIELDTYPE:Invalid_RefID:ALLOW(MGP0123456789 )\n'
    + 'FIELDTYPE:Invalid_Char:ALLOW(ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789 \\(\\)&-.,/-#@\'!*)\n'
    + 'FIELDTYPE:Invalid_Binary:ALLOW(1 )\n'
    + 'FIELDTYPE:Invalid_Num_In_Service:ENUM(1A|2A|3A|4A|7A|10A|12A|1I|2I|3I|4I|7I|10I|12I|U| )\n'
    + 'FIELDTYPE:Invalid_Line_Serv:ALLOW(0123 )\n'
    + '\n'
    + 'FIELD:reference_id:LIKE(Invalid_RefID):TYPE(STRING):0,0\n'
    + 'FIELD:dt_first_reported:LIKE(Invalid_Num):TYPE(UNSIGNED8):0,0\n'
    + 'FIELD:dt_last_reported:LIKE(Invalid_Num):TYPE(UNSIGNED8):0,0\n'
    + 'FIELD:phone:LIKE(Invalid_Num):TYPE(STRING10):0,0\n'
    + 'FIELD:reply_code:LIKE(Invalid_Num):TYPE(STRING3):0,0\n'
    + 'FIELD:local_routing_number:LIKE(Invalid_Num):TYPE(STRING10):0,0\n'
    + 'FIELD:account_owner:LIKE(Invalid_AccOwn):TYPE(STRING4):0,0\n'
    + 'FIELD:carrier_name:LIKE(Invalid_Char):TYPE(STRING55):0,0\n'
    + 'FIELD:carrier_category:LIKE(Invalid_Char):TYPE(STRING10):0,0\n'
    + 'FIELD:local_area_transport_area:TYPE(STRING5):0,0\n'
    + 'FIELD:point_code:TYPE(STRING9):0,0\n'
    + 'FIELD:serv:LIKE(Invalid_Line_Serv):TYPE(STRING1):0,0\n'
    + 'FIELD:line:LIKE(Invalid_Line_Serv):TYPE(STRING1):0,0\n'
    + 'FIELD:spid:LIKE(Invalid_Num):TYPE(STRING):0,0\n'
    + 'FIELD:operator_fullname:LIKE(Invalid_Char):TYPE(STRING):0,0\n'
    + 'FIELD:activation_dt:LIKE(Invalid_Num):TYPE(UNSIGNED8):0,0\n'
    + 'FIELD:number_in_service:LIKE(Invalid_Num_In_Service):TYPE(STRING5):0,0\n'
    + 'FIELD:high_risk_indicator:LIKE(Invalid_Binary):TYPE(STRING2):0,0\n'
    + 'FIELD:prepaid:LIKE(Invalid_Binary):TYPE(STRING2):0,0\n'
    ;
 
  // Structured values
  EXPORT linkpaths := DATASET([
    ],{STRING linkpath;STRING compulsory;STRING optional;STRING bonus;STRING required;STRING search});
 
END;

