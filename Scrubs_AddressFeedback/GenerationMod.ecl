// Machine-readable versions of the spec file and subsets thereof
IMPORT SALT311;
EXPORT GenerationMod := MODULE(SALT311.iGenerationMod)
 
  // SALT Version info
  EXPORT salt_VERSION := 'V3.11.9';
  EXPORT salt_MODULE := 'SALT311'; // Optional override by HACK:SALTMODULE
  EXPORT salt_TOOLSMODULE := 'SALTTOOLS30'; // Optional override by HACK:SALTTOOLSMODULE
 
  // Core module configuration values
  EXPORT spc_MODULE := 'Scrubs_AddressFeedback';
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
  EXPORT spc_FILENAME := 'AddressFeedback';
  EXPORT spc_INGESTSTATUS := '';
  EXPORT spc_EXTERNAL_MAPPING := 'UniqueID:';
  EXPORT spc_EXTERNAL_BATCH_PARAM := ',/* MY_ */,did,did_score,raw_aid,hhid,address_feedback_id,login_history_id,phone_number,unique_id,fname,lname,mname,orig_street_pre_direction,orig_street_post_direction,orig_street_number,orig_street_name,orig_street_suffix,orig_unit_number,orig_unit_designation,orig_zip5,orig_zip4,orig_city,orig_state,street_pre_direction,street_post_direction,street_number,street_name,street_suffix,unit_number,unit_designation,zip5,zip4,city,state,alt_phone,other_info,address_contact_type,feedback_source,date_time_added,loginid,companyid';
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
    + 'MODULE:Scrubs_AddressFeedback\n'
    + 'FILENAME:AddressFeedback\n'
    + '\n'
    + 'FIELDTYPE:Invalid_No:ALLOW(0123456789)\n'
    + 'FIELDTYPE:Invalid_Alpha:ALLOW(ABCDEFGHIJKLMNOPQRSTUVWXYZ )\n'
    + 'FIELDTYPE:Invalid_AlphaChar:ALLOW(ABCDEFGHIJKLMNOPQRSTUVWXYZ \'-)\n'
    + 'FIELDTYPE:Invalid_AlphaNum:ALLOW(0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZ )\n'
    + 'FIELDTYPE:Invalid_AlphaNumChar:ALLOW(0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZ .,-/:#)\n'
    + 'FIELDTYPE:Invalid_Date:CUSTOM(Scrubs.fn_valid_date > 0)\n'
    + 'FIELDTYPE:Invalid_Dir:ALLOW(NSEW)\n'
    + 'FIELDTYPE:Invalid_Phone:LIKE(Invalid_No):LENGTHS(0,10,11)\n'
    + 'FIELDTYPE:Invalid_Zip:LIKE(Invalid_No):LENGTHS(0,5)\n'
    + 'FIELDTYPE:Invalid_State:LIKE(Invalid_Alpha):LENGTHS(0,2)\n'
    + '\n'
    + 'FIELD:did:TYPE(UNSIGNED6):0,0\n'
    + 'FIELD:did_score:TYPE(UNSIGNED1):0,0\n'
    + 'FIELD:raw_aid:TYPE(UNSIGNED8):0,0\n'
    + 'FIELD:hhid:TYPE(UNSIGNED6):0,0\n'
    + 'FIELD:address_feedback_id:TYPE(STRING):LIKE(Invalid_No):0,0\n'
    + 'FIELD:login_history_id:TYPE(STRING):LIKE(Invalid_No):0,0\n'
    + 'FIELD:phone_number:TYPE(STRING10):LIKE(Invalid_Phone):0,0\n'
    + 'FIELD:unique_id:TYPE(STRING):LIKE(Invalid_No):0,0\n'
    + 'FIELD:fname:TYPE(STRING):LIKE(Invalid_AlphaChar):0,0\n'
    + 'FIELD:lname:TYPE(STRING):LIKE(Invalid_AlphaChar):0,0\n'
    + 'FIELD:mname:TYPE(STRING):LIKE(Invalid_Alpha):0,0\n'
    + 'FIELD:orig_street_pre_direction:TYPE(STRING2):LIKE(Invalid_Dir):0,0\n'
    + 'FIELD:orig_street_post_direction:TYPE(STRING2):LIKE(Invalid_Dir):0,0\n'
    + 'FIELD:orig_street_number:TYPE(STRING10):LIKE(Invalid_No):0,0\n'
    + 'FIELD:orig_street_name:TYPE(STRING28):LIKE(Invalid_AlphaNum):0,0\n'
    + 'FIELD:orig_street_suffix:TYPE(STRING4):LIKE(Invalid_Alpha):0,0\n'
    + 'FIELD:orig_unit_number:TYPE(STRING8):LIKE(Invalid_AlphaNum):0,0\n'
    + 'FIELD:orig_unit_designation:TYPE(STRING10):LIKE(Invalid_Alpha):0,0\n'
    + 'FIELD:orig_zip5:TYPE(STRING5):LIKE(Invalid_Zip):0,0\n'
    + 'FIELD:orig_zip4:TYPE(STRING4):LIKE(Invalid_No):0,0\n'
    + 'FIELD:orig_city:TYPE(STRING25):LIKE(Invalid_AlphaChar):0,0\n'
    + 'FIELD:orig_state:TYPE(STRING2):LIKE(Invalid_State):0,0\n'
    + 'FIELD:street_pre_direction:TYPE(STRING2):LIKE(Invalid_Dir):0,0\n'
    + 'FIELD:street_post_direction:TYPE(STRING2):LIKE(Invalid_Dir):0,0\n'
    + 'FIELD:street_number:TYPE(STRING10):LIKE(Invalid_No):0,0\n'
    + 'FIELD:street_name:TYPE(STRING28):LIKE(Invalid_AlphaNum):0,0\n'
    + 'FIELD:street_suffix:TYPE(STRING4):LIKE(Invalid_Alpha):0,0\n'
    + 'FIELD:unit_number:TYPE(STRING8):LIKE(Invalid_AlphaNum):0,0\n'
    + 'FIELD:unit_designation:TYPE(STRING10):LIKE(Invalid_Alpha):0,0\n'
    + 'FIELD:zip5:TYPE(STRING5):LIKE(Invalid_Zip):0,0\n'
    + 'FIELD:zip4:TYPE(STRING4):LIKE(Invalid_No):0,0\n'
    + 'FIELD:city:TYPE(STRING25):LIKE(Invalid_AlphaChar):0,0\n'
    + 'FIELD:state:TYPE(STRING2):LIKE(Invalid_State):0,0\n'
    + 'FIELD:alt_phone:TYPE(STRING):LIKE(Invalid_Phone):0,0\n'
    + 'FIELD:other_info:TYPE(STRING):0,0\n'
    + 'FIELD:address_contact_type:TYPE(STRING):LIKE(Invalid_No):0,0\n'
    + 'FIELD:feedback_source:TYPE(STRING):LIKE(Invalid_No):0,0\n'
    + 'FIELD:date_time_added:TYPE(STRING):LIKE(Invalid_Date):0,0\n'
    + 'FIELD:loginid:TYPE(STRING):LIKE(Invalid_No):0,0\n'
    + 'FIELD:companyid:TYPE(STRING):LIKE(Invalid_No):0,0\n'
    ;
 
  // Structured values
  EXPORT linkpaths := DATASET([
    ],{STRING linkpath;STRING compulsory;STRING optional;STRING bonus;STRING required;STRING search});
 
END;

