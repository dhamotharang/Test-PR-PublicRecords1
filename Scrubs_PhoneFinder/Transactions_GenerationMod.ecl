// Machine-readable versions of the spec file and subsets thereof
IMPORT SALT311;
EXPORT Transactions_GenerationMod := MODULE(SALT311.iGenerationMod)
 
  // SALT Version info
  EXPORT salt_VERSION := 'V3.11.11';
  EXPORT salt_MODULE := 'SALT311'; // Optional override by HACK:SALTMODULE
  EXPORT salt_TOOLSMODULE := 'SALTTOOLS30'; // Optional override by HACK:SALTTOOLSMODULE
 
  // Core module configuration values
  EXPORT spc_MODULE := 'Scrubs_PhoneFinder';
  EXPORT spc_NAMESCOPE := 'Transactions';
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
  EXPORT spc_EXTERNAL_BATCH_PARAM := ',/* MY_ */,transaction_id,transaction_date,user_id,product_code,company_id,source_code,batch_job_id,batch_acctno,response_time,reference_code,phonefinder_type,submitted_lexid,submitted_phonenumber,submitted_firstname,submitted_lastname,submitted_middlename,submitted_streetaddress1,submitted_city,submitted_state,submitted_zip,phonenumber,data_source,royalty_used,carrier,risk_indicator,phone_type,phone_status,ported_count,last_ported_date,otp_count,last_otp_date,spoof_count,last_spoof_date,phone_forwarded,date_added,identity_count,phone_verified,verification_type,phone_star_rating,filename';
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
    + 'NAMESCOPE:Transactions\n'
    + '\n'
    + 'FIELDTYPE:Invalid_Binary:ALLOW(01\\\\N)\n'
    + 'FIELDTYPE:Invalid_No:ALLOW(0123456789\\\\N)\n'
    + 'FIELDTYPE:Invalid_ID:ALLOW(0123456789R\\\\N)\n'
    + 'FIELDTYPE:Invalid_Code:ALLOW(0123456789\\(\\). -\\\\N)\n'
    + 'FIELDTYPE:Invalid_Alpha:ALLOW(ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz\\\\ )\n'
    + 'FIELDTYPE:Invalid_AlphaChar:ALLOW(ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789\\\\(\\\\)_[] .,:;#/-&\\\\\'*)\n'
    + 'FIELDTYPE:Invalid_Rating:ALLOW(0123456789\\\\N| )\n'
    + 'FIELDTYPE:Invalid_Risk:ENUM(PASS|FAIL|WARN|\\\\N|)\n'
    + 'FIELDTYPE:Invalid_Phone_Type:ENUM(POSSIBLE WIRELESS|LANDLINE|POSSIBLE VOIP|OTHER UNKNOWN|PAGER|CABLE|OTHER/UNKNOWN|\\\\N|)\n'
    + 'FIELDTYPE:Invalid_Phone_Status:ENUM(ACTIVE|INACTIVE|NOT AVAILABLE|\\\\N|)\n'
    + 'FIELDTYPE:Invalid_Forward:ENUM(FORWARDED|NOT FORWARDED|\\\\N|)\n'
    + 'FIELDTYPE:Invalid_State:LIKE(Invalid_Alpha):LENGTHS(0,2)\n'
    + 'FIELDTYPE:Invalid_Zip:LIKE(Invalid_No):LENGTHS(0,2,5)\n'
    + 'FIELDTYPE:Invalid_Phone:LIKE(Invalid_No):LENGTHS(0,2,9,10)\n'
    + 'FIELDTYPE:Invalid_Date:CUSTOM(Scrubs_PhoneFinder.Functions.Split_Date > 0)\n'
    + 'FIELDTYPE:Invalid_File:CUSTOM(Scrubs_PhoneFinder.Functions.Check_File > 0)\n'
    + '\n'
    + 'FIELD:transaction_id:TYPE(STRING16):LIKE(Invalid_ID):0,0\n'
    + 'FIELD:transaction_date:TYPE(STRING20):LIKE(Invalid_Date):0,0\n'
    + 'FIELD:user_id:TYPE(STRING60):0,0\n'
    + 'FIELD:product_code:TYPE(STRING8):LIKE(Invalid_Alpha):0,0\n'
    + 'FIELD:company_id:TYPE(STRING16):LIKE(Invalid_No):0,0\n'
    + 'FIELD:source_code:TYPE(STRING8):LIKE(Invalid_Code):0,0\n'
    + 'FIELD:batch_job_id:TYPE(STRING20):LIKE(Invalid_Code):0,0\n'
    + 'FIELD:batch_acctno:TYPE(INTEGER5):LIKE(Invalid_No):0,0\n'
    + 'FIELD:response_time:TYPE(INTEGER5):LIKE(Invalid_No):0,0\n'
    + 'FIELD:reference_code:TYPE(STRING60):LIKE(Invalid_AlphaChar):0,0\n'
    + 'FIELD:phonefinder_type:TYPE(STRING32):LIKE(Invalid_Alpha):0,0\n'
    + 'FIELD:submitted_lexid:TYPE(STRING32):LIKE(Invalid_Code):0,0\n'
    + 'FIELD:submitted_phonenumber:TYPE(STRING15):LIKE(Invalid_Code):0,0\n'
    + 'FIELD:submitted_firstname:TYPE(STRING20):LIKE(Invalid_AlphaChar):0,0\n'
    + 'FIELD:submitted_lastname:TYPE(STRING20):LIKE(Invalid_AlphaChar):0,0\n'
    + 'FIELD:submitted_middlename:TYPE(STRING20):LIKE(Invalid_AlphaChar):0,0\n'
    + 'FIELD:submitted_streetaddress1:TYPE(STRING128):0,0\n'
    + 'FIELD:submitted_city:TYPE(STRING64):LIKE(Invalid_AlphaChar):0,0\n'
    + 'FIELD:submitted_state:TYPE(STRING16):LIKE(Invalid_State):0,0\n'
    + 'FIELD:submitted_zip:TYPE(STRING10):LIKE(Invalid_Zip):0,0\n'
    + 'FIELD:phonenumber:TYPE(STRING15):LIKE(Invalid_Phone):0,0\n'
    + 'FIELD:data_source:TYPE(STRING30):LIKE(Invalid_Binary):0,0\n'
    + 'FIELD:royalty_used:TYPE(STRING30):LIKE(Invalid_Alpha):0,0\n'
    + 'FIELD:carrier:TYPE(STRING30):LIKE(Invalid_AlphaChar):0,0\n'
    + 'FIELD:risk_indicator:TYPE(STRING16):LIKE(Invalid_Risk):0,0\n'
    + 'FIELD:phone_type:TYPE(STRING32):LIKE(Invalid_Phone_Type):0,0\n'
    + 'FIELD:phone_status:TYPE(STRING32):LIKE(Invalid_Phone_Status):0,0\n'
    + 'FIELD:ported_count:TYPE(INTEGER5):LIKE(Invalid_No):0,0\n'
    + 'FIELD:last_ported_date:TYPE(STRING20):LIKE(Invalid_Date):0,0\n'
    + 'FIELD:otp_count:TYPE(INTEGER5):LIKE(Invalid_No):0,0\n'
    + 'FIELD:last_otp_date:TYPE(STRING20):LIKE(Invalid_Date):0,0\n'
    + 'FIELD:spoof_count:TYPE(INTEGER5):LIKE(Invalid_No):0,0\n'
    + 'FIELD:last_spoof_date:TYPE(STRING20):LIKE(Invalid_Date):0,0\n'
    + 'FIELD:phone_forwarded:TYPE(STRING32):LIKE(Invalid_Forward):0,0\n'
    + 'FIELD:date_added:TYPE(STRING20):0,0\n'
    + 'FIELD:identity_count:TYPE(INTEGER5):LIKE(Invalid_No):0,0\n'
    + 'FIELD:phone_verified:TYPE(STRING5):LIKE(Invalid_Code):0,0\n'
    + 'FIELD:verification_type:TYPE(STRING32):LIKE(Invalid_AlphaChar):0,0\n'
    + 'FIELD:phone_star_rating:TYPE(STRING5):LIKE(Invalid_Rating):0,0\n'
    + 'FIELD:filename:TYPE(STRING255):0,0\n'
    ;
 
  // Structured values
  EXPORT linkpaths := DATASET([
    ],{STRING linkpath;STRING compulsory;STRING optional;STRING bonus;STRING required;STRING search});
 
END;

