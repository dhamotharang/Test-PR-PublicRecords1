// Machine-readable versions of the spec file and subsets thereof
IMPORT SALT311;
EXPORT Base_6500_GenerationMod := MODULE(SALT311.iGenerationMod)
 
  // SALT Version info
  EXPORT salt_VERSION := 'V3.11.4';
  EXPORT salt_MODULE := 'SALT311'; // Optional override by HACK:SALTMODULE
  EXPORT salt_TOOLSMODULE := 'SALTTOOLS30'; // Optional override by HACK:SALTTOOLSMODULE
 
  // Core module configuration values
  EXPORT spc_MODULE := 'Scrubs_EBR';
  EXPORT spc_NAMESCOPE := 'Base_6500';
  EXPORT spc_PROCESS := '';
  EXPORT spc_PROCLAYOUTS := 'Process__Layouts';
  EXPORT spc_IDNAME := ''; // cluster id (input)
  EXPORT spc_IDFIELD := ''; // cluster id (output)
  EXPORT spc_RIDFIELD := ''; // record id
  EXPORT spc_CONFIG := 'Config';
  EXPORT spc_CONFIGPARAM := FALSE;
  EXPORT spc_SOURCEFIELD := '';
  EXPORT spc_FILEPREFIX := 'In_';
  EXPORT spc_FILENAME := 'EBR';
  EXPORT spc_INGESTSTATUS := '';
  EXPORT spc_EXTERNAL_MAPPING := 'UniqueID:';
  EXPORT spc_EXTERNAL_BATCH_PARAM := ',/* MY_ */,powid,proxid,seleid,orgid,ultid,bdid,date_first_seen,date_last_seen,process_date_first_seen,process_date_last_seen,record_type,process_date,file_number,segment_code,sequence_number,bus_cat_code,bus_cat_desc,orig_date_reported_ymd,orig_date_last_sale_ym,payment_terms,high_credit_mask,recent_high_credit,acct_bal_mask,masked_acct_bal,current_pct,dbt_01_30_pct,dbt_31_60_pct,dbt_61_90_pct,dbt_91_plus_pct,comment_code,comment_desc,date_reported,date_last_sale';
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
    + 'MODULE:Scrubs_EBR\n'
    + 'FILENAME:EBR\n'
    + 'NAMESCOPE:Base_6500\n'
    + '//--------------------------\n'
    + '//FIELDTYPE DEFINITIONS\n'
    + '//--------------------------\n'
    + 'FIELDTYPE:invalid_mandatory:LENGTHS(1..)\n'
    + 'FIELDTYPE:invalid_numeric:CUSTOM(Scrubs_EBR.Functions.fn_numeric>0)\n'
    + 'FIELDTYPE:invalid_numeric_or_allzeros:CUSTOM(Scrubs_EBR.Functions.fn_numeric_or_allzeros>0)\n'
    + 'FIELDTYPE:invalid_pastdate:CUSTOM(Scrubs_EBR.Functions.fn_past_yyyymmdd>0)\n'
    + 'FIELDTYPE:invalid_dt_first_seen:CUSTOM(Scrubs_EBR.Functions.fn_dt_first_seen>0)\n'
    + 'FIELDTYPE:invalid_dt_ccyymm:CUSTOM(Scrubs_EBR.Functions.fn_dt_ccyymm_or_200000>0)\n'
    + 'FIELDTYPE:invalid_record_type:ENUM(H|C)\n'
    + 'FIELDTYPE:invalid_segment:ENUM(6500|6500)\n'
    + 'FIELDTYPE:invalid_file_number:ALLOW(ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789):LENGTHS(9)\n'
    + 'FIELDTYPE:invalid_cat_code:ENUM(2911|2916)\n'
    + 'FIELDTYPE:invalid_cat_desc:ENUM(GOVT/SBA|GOVT/HUD)\n'
    + 'FIELDTYPE:invalid_terms:ENUM(CONTRCT|NET 30)\n'
    + 'FIELDTYPE:invalid_comment_code:ENUM( |76)\n'
    + 'FIELDTYPE:invalid_comment_desc:ENUM( |COLLECTION)\n'
    + 'FIELDTYPE:invalid_mask:ENUM( |<)\n'
    + 'FIELDTYPE:invalid_dt_mmddyy:CUSTOM(Scrubs_EBR.Functions.fn_dt_mmddyy>0)\n'
    + 'FIELDTYPE:invalid_dt_yymm:CUSTOM(Scrubs_EBR.Functions.fn_dt_yymm_or_0000>0)\n'
    + '\n'
    + '//------------------------------------------------------\n'
    + '//FIELDS:  Commented out fields are not being scrubbed\n'
    + '//------------------------------------------------------\n'
    + '// FIELD:dotid:TYPE(UNSIGNED6):0,0\n'
    + '// FIELD:dotscore:TYPE(UNSIGNED2):0,0\n'
    + '// FIELD:dotweight:TYPE(UNSIGNED2):0,0\n'
    + '// FIELD:empid:TYPE(UNSIGNED6):0,0\n'
    + '// FIELD:empscore:TYPE(UNSIGNED2):0,0\n'
    + '// FIELD:empweight:TYPE(UNSIGNED2):0,0\n'
    + 'FIELD:powid:TYPE(UNSIGNED6):LIKE(invalid_mandatory):0,0\n'
    + '// FIELD:powscore:TYPE(UNSIGNED2):0,0\n'
    + '// FIELD:powweight:TYPE(UNSIGNED2):0,0\n'
    + 'FIELD:proxid:TYPE(UNSIGNED6):LIKE(invalid_mandatory):0,0\n'
    + '// FIELD:proxscore:TYPE(UNSIGNED2):0,0\n'
    + '// FIELD:proxweight:TYPE(UNSIGNED2):0,0\n'
    + 'FIELD:seleid:TYPE(UNSIGNED6):LIKE(invalid_mandatory):0,0\n'
    + '// FIELD:selescore:TYPE(UNSIGNED2):0,0\n'
    + '// FIELD:seleweight:TYPE(UNSIGNED2):0,0\n'
    + 'FIELD:orgid:TYPE(UNSIGNED6):LIKE(invalid_mandatory):0,0\n'
    + '// FIELD:orgscore:TYPE(UNSIGNED2):0,0\n'
    + '// FIELD:orgweight:TYPE(UNSIGNED2):0,0\n'
    + 'FIELD:ultid:TYPE(UNSIGNED6):LIKE(invalid_mandatory):0,0\n'
    + '// FIELD:ultscore:TYPE(UNSIGNED2):0,0\n'
    + '// FIELD:ultweight:TYPE(UNSIGNED2):0,0\n'
    + 'FIELD:bdid:TYPE(UNSIGNED6):LIKE(invalid_numeric):0,0\n'
    + 'FIELD:date_first_seen:TYPE(STRING8):LIKE(invalid_dt_first_seen):0,0\n'
    + 'FIELD:date_last_seen:TYPE(STRING8):LIKE(invalid_pastdate):0,0\n'
    + 'FIELD:process_date_first_seen:TYPE(UNSIGNED4):LIKE(invalid_pastdate):0,0\n'
    + 'FIELD:process_date_last_seen:TYPE(UNSIGNED4):LIKE(invalid_pastdate):0,0\n'
    + 'FIELD:record_type:TYPE(STRING1):LIKE(invalid_record_type):0,0\n'
    + 'FIELD:process_date:TYPE(STRING8):LIKE(invalid_pastdate):0,0\n'
    + 'FIELD:file_number:TYPE(STRING10):LIKE(invalid_file_number):0,0\n'
    + 'FIELD:segment_code:TYPE(STRING4):LIKE(invalid_segment):0,0\n'
    + 'FIELD:sequence_number:TYPE(STRING5):LIKE(invalid_numeric_or_allzeros):0,0\n'
    + '// FIELD:payment_ind:TYPE(STRING1):0,0\n'
    + 'FIELD:bus_cat_code:TYPE(STRING4):LIKE(invalid_cat_code):0,0\n'
    + 'FIELD:bus_cat_desc:TYPE(STRING10):LIKE(invalid_cat_desc):0,0\n'
    + 'FIELD:orig_date_reported_ymd:TYPE(STRING6):LIKE(invalid_dt_mmddyy):0,0\n'
    + 'FIELD:orig_date_last_sale_ym:TYPE(STRING4):LIKE(invalid_dt_yymm):0,0\n'
    + 'FIELD:payment_terms:TYPE(STRING7):LIKE(invalid_terms):0,0\n'
    + 'FIELD:high_credit_mask:TYPE(STRING1):LIKE(invalid_mask):0,0\n'
    + 'FIELD:recent_high_credit:TYPE(STRING8):LIKE(invalid_numeric_or_allzeros):0,0\n'
    + 'FIELD:acct_bal_mask:TYPE(STRING1):LIKE(invalid_mask):0,0\n'
    + 'FIELD:masked_acct_bal:TYPE(STRING8):LIKE(invalid_numeric_or_allzeros):0,0\n'
    + 'FIELD:current_pct:TYPE(STRING3):LIKE(invalid_numeric_or_allzeros):0,0\n'
    + 'FIELD:dbt_01_30_pct:TYPE(STRING3):LIKE(invalid_numeric_or_allzeros):0,0\n'
    + 'FIELD:dbt_31_60_pct:TYPE(STRING3):LIKE(invalid_numeric_or_allzeros):0,0\n'
    + 'FIELD:dbt_61_90_pct:TYPE(STRING3):LIKE(invalid_numeric_or_allzeros):0,0\n'
    + 'FIELD:dbt_91_plus_pct:TYPE(STRING3):LIKE(invalid_numeric_or_allzeros):0,0\n'
    + 'FIELD:comment_code:TYPE(STRING2):LIKE(invalid_comment_code):0,0\n'
    + 'FIELD:comment_desc:TYPE(STRING10):LIKE(invalid_comment_desc):0,0\n'
    + '// FIELD:new_trade_flag:TYPE(STRING1):0,0\n'
    + '// FIELD:trade_type_code:TYPE(STRING1):0,0\n'
    + '// FIELD:trade_type_desc:TYPE(STRING10):0,0\n'
    + '// FIELD:dispute_ind:TYPE(STRING1):0,0\n'
    + '// FIELD:dispute_code:TYPE(STRING2):0,0\n'
    + 'FIELD:date_reported:TYPE(STRING8):LIKE(invalid_pastdate):0,0   \n'
    + 'FIELD:date_last_sale:TYPE(STRING6):LIKE(invalid_dt_ccyymm):0,0   \n'
    + '// FIELD:lf:TYPE(STRING1):0,0\n'
    ;
 
  // Structured values
  EXPORT linkpaths := DATASET([
    ],{STRING linkpath;STRING compulsory;STRING optional;STRING bonus;STRING required;STRING search});
 
END;

