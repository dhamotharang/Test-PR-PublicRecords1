﻿// Machine-readable versions of the spec file and subsets thereof
IMPORT SALT311;
EXPORT Base_GenerationMod := MODULE(SALT311.iGenerationMod)
 
  // SALT Version info
  EXPORT salt_VERSION := 'V3.11.4';
  EXPORT salt_MODULE := 'SALT311'; // Optional override by HACK:SALTMODULE
  EXPORT salt_TOOLSMODULE := 'SALTTOOLS30'; // Optional override by HACK:SALTTOOLSMODULE
 
  // Core module configuration values
  EXPORT spc_MODULE := 'Scrubs_Infutor_NARB';
  EXPORT spc_NAMESCOPE := 'Base';
  EXPORT spc_PROCESS := '';
  EXPORT spc_PROCLAYOUTS := 'Process__Layouts';
  EXPORT spc_IDNAME := ''; // cluster id (input)
  EXPORT spc_IDFIELD := ''; // cluster id (output)
  EXPORT spc_RIDFIELD := ''; // record id
  EXPORT spc_CONFIG := 'Config';
  EXPORT spc_CONFIGPARAM := FALSE;
  EXPORT spc_SOURCEFIELD := '';
  EXPORT spc_FILEPREFIX := 'In_';
  EXPORT spc_FILENAME := 'Infutor_NARB';
  EXPORT spc_INGESTSTATUS := '';
  EXPORT spc_EXTERNAL_MAPPING := 'UniqueID:';
  EXPORT spc_EXTERNAL_BATCH_PARAM := ',/* MY_ */,rcid,powid,proxid,seleid,orgid,ultid,did,dt_first_seen,dt_last_seen,dt_vendor_first_reported,dt_vendor_last_reported,process_date,record_type,pid,address_type_code,url,sic1,sic2,sic3,sic4,sic5,incorporation_state,email,contact_title,normcompany_type,clean_company_name,clean_phone,fname,lname,prim_range,p_city_name,v_city_name,st,zip,prep_address_line1,prep_address_line_last';
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
    + 'MODULE:Scrubs_Infutor_NARB\n'
    + 'FILENAME:Infutor_NARB\n'
    + 'NAMESCOPE:Base\n'
    + '\n'
    + '//-------------------------\n'
    + '//FIELDTYPE DEFINITIONS\n'
    + '//-------------------------\n'
    + 'FIELDTYPE:invalid_mandatory:LENGTHS(1..)\n'
    + 'FIELDTYPE:invalid_pastdate8:CUSTOM(Scrubs_Infutor_NARB.Functions.fn_past_yyyymmdd > 0)\n'
    + 'FIELDTYPE:invalid_record_type:ENUM(C|H)\n'
    + 'FIELDTYPE:invalid_numeric:CUSTOM(Scrubs_Infutor_NARB.Functions.fn_numeric > 0)\n'
    + 'FIELDTYPE:invalid_st:CUSTOM(Scrubs_Infutor_NARB.Functions.fn_verify_state>0)\n'
    + 'FIELDTYPE:invalid_zip5:CUSTOM(Scrubs_Infutor_NARB.Functions.fn_numeric>0,5)\n'
    + 'FIELDTYPE:invalid_alphanum_specials:ALLOW(0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZ @#-:./,`&\'Ã£Ã±Ã¨Ã³Ã©Ã Ã‚Ã¡Ã”Ã­Ã¶Ã‹Ãº)\n'
    + 'FIELDTYPE:invalid_phone:CUSTOM(Scrubs_Infutor_NARB.Functions.fn_verify_optional_phone>0)\n'
    + 'FIELDTYPE:invalid_rcid:CUSTOM(Scrubs_Infutor_NARB.Functions.fn_rcid > 0)\n'
    + 'FIELDTYPE:invalid_sic:CUSTOM(Scrubs.fn_valid_SicCode > 0)\n'
    + 'FIELDTYPE:invalid_url:CUSTOM(Scrubs_Infutor_NARB.Functions.fn_url > 0)\n'
    + 'FIELDTYPE:invalid_address_type_code:ENUM(F|G|H|P|R|S| )\n'
    + 'FIELDTYPE:invalid_norm_type:ENUM(B|P|T)\n'
    + 'FIELDTYPE:invalid_email:ALLOW( 0123456789AaBbCcDdEeFfGgHhIiJjKkLlMmNnOoPpQqRrSsTtUuVvWwXxYyZz-.@_,;\'&)\n'
    + '\n'
    + '\n'
    + '//--------------------------------------------------------------- \n'
    + '//FIELDS TO SCRUB -- Commented out fields are not being scrubbed\n'
    + '//---------------------------------------------------------------\n'
    + 'FIELD:rcid:TYPE(UNSIGNED6):LIKE(invalid_rcid):0,0\n'
    + 'FIELD:powid:TYPE(UNSIGNED6):LIKE(invalid_mandatory):0,0\n'
    + 'FIELD:proxid:TYPE(UNSIGNED6):LIKE(invalid_mandatory):0,0\n'
    + 'FIELD:seleid:TYPE(UNSIGNED6):LIKE(invalid_mandatory):0,0\n'
    + 'FIELD:orgid:TYPE(UNSIGNED6):LIKE(invalid_mandatory):0,0\n'
    + 'FIELD:ultid:TYPE(UNSIGNED6):LIKE(invalid_mandatory):0,0\n'
    + 'FIELD:did:TYPE(UNSIGNED6):LIKE(invalid_mandatory):0,0\n'
    + 'FIELD:dt_first_seen:TYPE(UNSIGNED4):LIKE(invalid_pastdate8):0,0\n'
    + 'FIELD:dt_last_seen:TYPE(UNSIGNED4):LIKE(invalid_pastdate8):0,0\n'
    + 'FIELD:dt_vendor_first_reported:TYPE(UNSIGNED4):LIKE(invalid_pastdate8):0,0\n'
    + 'FIELD:dt_vendor_last_reported:TYPE(UNSIGNED4):LIKE(invalid_pastdate8):0,0\n'
    + 'FIELD:process_date:TYPE(UNSIGNED4):LIKE(invalid_pastdate8):0,0\n'
    + 'FIELD:record_type:TYPE(STRING1):LIKE(invalid_record_type):0,0\n'
    + 'FIELD:pid:TYPE(STRING10):LIKE(invalid_numeric):0,0\n'
    + 'FIELD:address_type_code:TYPE(STRING1):LIKE(invalid_address_type_code):0,0\n'
    + 'FIELD:url:TYPE(STRING500):LIKE(invalid_url):0,0\n'
    + 'FIELD:sic1:TYPE(STRING8):LIKE(invalid_sic):0,0\n'
    + 'FIELD:sic2:TYPE(STRING8):LIKE(invalid_sic):0,0\n'
    + 'FIELD:sic3:TYPE(STRING8):LIKE(invalid_sic):0,0\n'
    + 'FIELD:sic4:TYPE(STRING8):LIKE(invalid_sic):0,0\n'
    + 'FIELD:sic5:TYPE(STRING8):LIKE(invalid_sic):0,0\n'
    + 'FIELD:incorporation_state:TYPE(STRING2):LIKE(invalid_st):0,0\n'
    + 'FIELD:email:TYPE(STRING500):LIKE(invalid_email):0,0\n'
    + 'FIELD:contact_title:TYPE(STRING100):LIKE(invalid_mandatory):0,0\n'
    + 'FIELD:normcompany_type:TYPE(STRING1):LIKE(invalid_norm_type):0,0\n'
    + 'FIELD:clean_company_name:TYPE(STRING100):LIKE(invalid_mandatory):0,0\n'
    + 'FIELD:clean_phone:TYPE(STRING10):LIKE(invalid_phone):0,0\n'
    + 'FIELD:fname:TYPE(STRING20):LIKE(invalid_alphanum_specials):0,0\n'
    + 'FIELD:lname:TYPE(STRING20):LIKE(invalid_alphanum_specials):0,0\n'
    + 'FIELD:prim_range:TYPE(STRING10):LIKE(invalid_mandatory):0,0\n'
    + 'FIELD:p_city_name:TYPE(STRING25):LIKE(invalid_mandatory):0,0\n'
    + 'FIELD:v_city_name:TYPE(STRING25):LIKE(invalid_mandatory):0,0\n'
    + 'FIELD:st:TYPE(STRING2):LIKE(invalid_st):0,0\n'
    + 'FIELD:zip:TYPE(STRING5):LIKE(invalid_zip5):0,0\n'
    + 'FIELD:prep_address_line1:TYPE(STRING100):LIKE(invalid_mandatory):0,0\n'
    + 'FIELD:prep_address_line_last:TYPE(STRING50):LIKE(invalid_mandatory):0,0\n'
    + '\n'
    + '\n'
    ;
 
  // Structured values
  EXPORT linkpaths := DATASET([
    ],{STRING linkpath;STRING compulsory;STRING optional;STRING bonus;STRING required;STRING search});
 
END;

