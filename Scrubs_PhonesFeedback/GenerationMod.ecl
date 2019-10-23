// Machine-readable versions of the spec file and subsets thereof
IMPORT SALT311;
EXPORT GenerationMod := MODULE(SALT311.iGenerationMod)
 
  // SALT Version info
  EXPORT salt_VERSION := 'V3.11.4';
  EXPORT salt_MODULE := 'SALT311'; // Optional override by HACK:SALTMODULE
  EXPORT salt_TOOLSMODULE := 'SALTTOOLS30'; // Optional override by HACK:SALTTOOLSMODULE
 
  // Core module configuration values
  EXPORT spc_MODULE := 'Scrubs_PhonesFeedback';
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
  EXPORT spc_FILENAME := 'PhonesFeedback';
  EXPORT spc_INGESTSTATUS := '';
  EXPORT spc_EXTERNAL_MAPPING := 'UniqueID:';
  EXPORT spc_EXTERNAL_BATCH_PARAM := ',/* MY_ */,did,did_score,hhid,phone_number,login_history_id,fname,lname,mname,street_pre_direction,street_post_direction,street_number,street_name,street_suffix,unit_number,unit_designation,zip5,zip4,city,state,alt_phone,other_info,phone_contact_type,feedback_source,date_time_added,loginid,customerid';
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
    + 'MODULE:Scrubs_PhonesFeedback\n'
    + 'FILENAME:PhonesFeedback\n'
    + '\n'
    + 'FIELDTYPE:Invalid_Num:ALLOW(0123456789)\n'
    + 'FIELDTYPE:Invalid_Direction:ENUM(N|S|E|W|NE|NW|SW|SE|)\n'
    + 'FIELDTYPE:Invalid_State:ALLOW(ABCDEFGHIJKLMNOPQRSTUVWXYZ):LENGTHS(0,2)\n'
    + '\n'
    + 'FIELD:did:LIKE(Invalid_Num):TYPE(UNSIGNED6):0,0\n'
    + 'FIELD:did_score:LIKE(Invalid_Num):TYPE(UNSIGNED1):0,0\n'
    + 'FIELD:hhid:LIKE(Invalid_Num):TYPE(UNSIGNED6):0,0\n'
    + 'FIELD:phone_number:LIKE(Invalid_Num):TYPE(STRING10):0,0\n'
    + 'FIELD:login_history_id:LIKE(Invalid_Num):TYPE(STRING):0,0\n'
    + 'FIELD:fname:TYPE(STRING):0,0\n'
    + 'FIELD:lname:TYPE(STRING):0,0\n'
    + 'FIELD:mname:TYPE(STRING):0,0\n'
    + 'FIELD:street_pre_direction:LIKE(Invalid_Direction):TYPE(STRING):0,0\n'
    + 'FIELD:street_post_direction:LIKE(Invalid_Direction):TYPE(STRING):0,0\n'
    + 'FIELD:street_number:TYPE(STRING):0,0\n'
    + 'FIELD:street_name:TYPE(STRING):0,0\n'
    + 'FIELD:street_suffix:TYPE(STRING):0,0\n'
    + 'FIELD:unit_number:TYPE(STRING):0,0\n'
    + 'FIELD:unit_designation:TYPE(STRING):0,0\n'
    + 'FIELD:zip5:LIKE(Invalid_Num):TYPE(STRING):0,0\n'
    + 'FIELD:zip4:LIKE(Invalid_Num):TYPE(STRING):0,0\n'
    + 'FIELD:city:TYPE(STRING):0,0\n'
    + 'FIELD:state:LIKE(Invalid_State):TYPE(STRING):0,0\n'
    + 'FIELD:alt_phone:LIKE(Invalid_Num):TYPE(STRING):0,0\n'
    + 'FIELD:other_info:TYPE(STRING):0,0\n'
    + 'FIELD:phone_contact_type:LIKE(Invalid_Num):TYPE(STRING):0,0\n'
    + 'FIELD:feedback_source:LIKE(Invalid_Num):TYPE(STRING):0,0\n'
    + 'FIELD:date_time_added:TYPE(STRING):0,0\n'
    + 'FIELD:loginid:TYPE(STRING):0,0\n'
    + 'FIELD:customerid:TYPE(STRING):0,0\n'
    ;
 
  // Structured values
  EXPORT linkpaths := DATASET([
    ],{STRING linkpath;STRING compulsory;STRING optional;STRING bonus;STRING required;STRING search});
 
END;

