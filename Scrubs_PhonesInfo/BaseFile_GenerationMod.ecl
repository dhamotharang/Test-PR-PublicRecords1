// Machine-readable versions of the spec file and subsets thereof
IMPORT SALT311;
EXPORT BaseFile_GenerationMod := MODULE(SALT311.iGenerationMod)
 
  // SALT Version info
  EXPORT salt_VERSION := 'V3.11.4';
  EXPORT salt_MODULE := 'SALT311'; // Optional override by HACK:SALTMODULE
  EXPORT salt_TOOLSMODULE := 'SALTTOOLS30'; // Optional override by HACK:SALTTOOLSMODULE
 
  // Core module configuration values
  EXPORT spc_MODULE := 'Scrubs_PhonesInfo';
  EXPORT spc_NAMESCOPE := 'BaseFile';
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
  EXPORT spc_EXTERNAL_BATCH_PARAM := ',/* MY_ */,reference_id,source,dt_first_reported,dt_last_reported,phone,phonetype,reply_code,local_routing_number,account_owner,carrier_name,carrier_category,local_area_transport_area,point_code,country_code,dial_type,routing_code,porting_dt,porting_time,country_abbr,vendor_first_reported_dt,vendor_first_reported_time,vendor_last_reported_dt,vendor_last_reported_time,port_start_dt,port_start_time,port_end_dt,port_end_time,remove_port_dt,is_ported,serv,line,spid,operator_fullname,number_in_service,high_risk_indicator,prepaid,phone_swap,swap_start_dt,swap_start_time,swap_end_dt,swap_end_time,deact_code,deact_start_dt,deact_start_time,deact_end_dt,deact_end_time,react_start_dt,react_start_time,react_end_dt,react_end_time,is_deact,is_react,call_forward_dt,caller_id';
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
    'OPTIONS:-gh \n'
    + 'MODULE:Scrubs_PhonesInfo\n'
    + 'FILENAME:PhonesInfo\n'
    + 'NAMESCOPE:BaseFile \n'
    + '\n'
    + 'FIELDTYPE:Invalid_Phone:ALLOW(0123456789)\n'
    + 'FIELDTYPE:Invalid_Source:ENUM(PX|PK|PJ|PG|PB):LENGTHS(1..)\n'
    + 'FIELDTYPE:Invalid_Date:CUSTOM(Scrubs.fn_valid_date>0)\n'
    + 'FIELDTYPE:Invalid_Future_Date:CUSTOM(Scrubs.fn_valid_date>0,\'future\')\n'
    + 'FIELDTYPE:Invalid_Phone_Type:ENUM(LC|CL| )\n'
    + 'FIELDTYPE:Invalid_Num:ALLOW(0123456789)\n'
    + 'FIELDTYPE:Invalid_Num_Blank:ALLOW(0123456789 \\t )\n'
    + 'FIELDTYPE:Invalid_Char:ALLOW(ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789 .-:*&/_;\'"()!+,@|#)\n'
    + 'FIELDTYPE:Invalid_State:ALLOW(ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz )\n'
    + 'FIELDTYPE:Invalid_Dial_Type:ALLOW(TBN )\n'
    + 'FIELDTYPE:Invalid_ISO2:ALLOW(ABCDEFGHIJKLMNOPQRSTUVWXYZ)\n'
    + 'FIELDTYPE:Invalid_Zero_Three:ALLOW(0123)\n'
    + 'FIELDTYPE:Invalid_Deact:ENUM(DE|SU| )\n'
    + 'FIELDTYPE:Invalid_Num_In_Service:ALLOW(0123456789AIU)\n'
    + 'FIELDTYPE:Invalid_YN:ALLOW(PYN0123456789 )\n'
    + '\n'
    + '\n'
    + 'FIELD:reference_id:TYPE(STRING30):0,0\n'
    + 'FIELD:source:LIKE(Invalid_Source):TYPE(STRING5):0,0\n'
    + 'FIELD:dt_first_reported:LIKE(Invalid_Date):TYPE(UNSIGNED8):0,0\n'
    + 'FIELD:dt_last_reported:LIKE(Invalid_Date):TYPE(UNSIGNED8):0,0\n'
    + 'FIELD:phone:LIKE(Invalid_Phone):TYPE(STRING10):0,0\n'
    + 'FIELD:phonetype:LIKE(Invalid_Phone_Type):TYPE(STRING2):0,0\n'
    + 'FIELD:reply_code:LIKE(Invalid_Num):TYPE(STRING3):0,0\n'
    + 'FIELD:local_routing_number:LIKE(Invalid_Num):TYPE(STRING10):0,0\n'
    + 'FIELD:account_owner:LIKE(Invalid_Char):TYPE(STRING6):0,0\n'
    + 'FIELD:carrier_name:TYPE(STRING60):0,0\n'
    + 'FIELD:carrier_category:LIKE(Invalid_Char):TYPE(STRING10):0,0\n'
    + 'FIELD:local_area_transport_area:LIKE(Invalid_Num):TYPE(STRING5):0,0\n'
    + 'FIELD:point_code:TYPE(STRING10):0,0\n'
    + 'FIELD:country_code:LIKE(Invalid_Num):TYPE(STRING3):0,0\n'
    + 'FIELD:dial_type:LIKE(Invalid_Dial_Type):TYPE(STRING1):0,0\n'
    + 'FIELD:routing_code:LIKE(Invalid_Num):TYPE(STRING10):0,0\n'
    + 'FIELD:porting_dt:LIKE(Invalid_Date):TYPE(UNSIGNED8):0,0\n'
    + 'FIELD:porting_time:LIKE(Invalid_Num):TYPE(STRING6):0,0\n'
    + 'FIELD:country_abbr:LIKE(Invalid_ISO2):TYPE(STRING2):0,0\n'
    + 'FIELD:vendor_first_reported_dt:LIKE(Invalid_Date):TYPE(UNSIGNED8):0,0\n'
    + 'FIELD:vendor_first_reported_time:LIKE(Invalid_Num):TYPE(STRING6):0,0\n'
    + 'FIELD:vendor_last_reported_dt:LIKE(Invalid_Date):TYPE(UNSIGNED8):0,0\n'
    + 'FIELD:vendor_last_reported_time:LIKE(Invalid_Num):TYPE(STRING6):0,0\n'
    + 'FIELD:port_start_dt:LIKE(Invalid_Date):TYPE(UNSIGNED8):0,0\n'
    + 'FIELD:port_start_time:LIKE(Invalid_Num):TYPE(STRING6):0,0\n'
    + 'FIELD:port_end_dt:LIKE(Invalid_Future_Date):TYPE(UNSIGNED8):0,0\n'
    + 'FIELD:port_end_time:LIKE(Invalid_Num):TYPE(STRING6):0,0\n'
    + 'FIELD:remove_port_dt:LIKE(Invalid_Future_Date):TYPE(UNSIGNED8):0,0\n'
    + 'FIELD:is_ported:TYPE(BOOLEAN1):0,0\n'
    + 'FIELD:serv:LIKE(Invalid_Zero_Three):TYPE(STRING1):0,0\n'
    + 'FIELD:line:LIKE(Invalid_Zero_Three):TYPE(STRING1):0,0\n'
    + 'FIELD:spid:LIKE(Invalid_Num):TYPE(STRING10):0,0\n'
    + 'FIELD:operator_fullname:LIKE(Invalid_Char):TYPE(STRING60):0,0\n'
    + 'FIELD:number_in_service:LIKE(Invalid_Num_In_Service):TYPE(STRING5):0,0\n'
    + 'FIELD:high_risk_indicator:LIKE(Invalid_YN):TYPE(STRING2):0,0\n'
    + 'FIELD:prepaid:LIKE(Invalid_YN):TYPE(STRING2):0,0\n'
    + 'FIELD:phone_swap:LIKE(Invalid_Num):TYPE(STRING10):0,0\n'
    + 'FIELD:swap_start_dt:LIKE(Invalid_Date):TYPE(UNSIGNED8):0,0\n'
    + 'FIELD:swap_start_time:LIKE(Invalid_Num):TYPE(STRING6):0,0\n'
    + 'FIELD:swap_end_dt:LIKE(Invalid_Future_Date):TYPE(UNSIGNED8):0,0\n'
    + 'FIELD:swap_end_time:LIKE(Invalid_Num):TYPE(STRING6):0,0\n'
    + 'FIELD:deact_code:LIKE(Invalid_Deact):TYPE(STRING2):0,0\n'
    + 'FIELD:deact_start_dt:LIKE(Invalid_Date):TYPE(UNSIGNED8):0,0\n'
    + 'FIELD:deact_start_time:LIKE(Invalid_Num):TYPE(STRING6):0,0\n'
    + 'FIELD:deact_end_dt:LIKE(Invalid_Future_Date):TYPE(UNSIGNED8):0,0\n'
    + 'FIELD:deact_end_time:LIKE(Invalid_Num):TYPE(STRING6):0,0\n'
    + 'FIELD:react_start_dt:LIKE(Invalid_Date):TYPE(UNSIGNED8):0,0\n'
    + 'FIELD:react_start_time:LIKE(Invalid_Num):TYPE(STRING6):0,0\n'
    + 'FIELD:react_end_dt:LIKE(Invalid_Future_Date):TYPE(UNSIGNED8):0,0\n'
    + 'FIELD:react_end_time:LIKE(Invalid_Num):TYPE(STRING6):0,0\n'
    + 'FIELD:is_deact:LIKE(Invalid_YN):TYPE(STRING2):0,0\n'
    + 'FIELD:is_react:LIKE(Invalid_YN):TYPE(STRING2):0,0\n'
    + 'FIELD:call_forward_dt:LIKE(Invalid_Date):TYPE(UNSIGNED8):0,0\n'
    + 'FIELD:caller_id:LIKE(Invalid_Char):TYPE(STRING15):0,0\n'
    ;
 
  // Structured values
  EXPORT linkpaths := DATASET([
    ],{STRING linkpath;STRING compulsory;STRING optional;STRING bonus;STRING required;STRING search});
 
END;

