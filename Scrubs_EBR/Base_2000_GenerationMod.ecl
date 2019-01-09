// Machine-readable versions of the spec file and subsets thereof
IMPORT SALT311;
EXPORT Base_2000_GenerationMod := MODULE(SALT311.iGenerationMod)
 
  // SALT Version info
  EXPORT salt_VERSION := 'V3.11.4';
  EXPORT salt_MODULE := 'SALT311'; // Optional override by HACK:SALTMODULE
  EXPORT salt_TOOLSMODULE := 'SALTTOOLS30'; // Optional override by HACK:SALTTOOLSMODULE
 
  // Core module configuration values
  EXPORT spc_MODULE := 'Scrubs_EBR';
  EXPORT spc_NAMESCOPE := 'Base_2000';
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
  EXPORT spc_EXTERNAL_BATCH_PARAM := ',/* MY_ */,powid,proxid,seleid,orgid,ultid,bdid,date_first_seen,date_last_seen,process_date_first_seen,process_date_last_seen,record_type,process_date,file_number,segment_code,sequence_number,payment_indicator,business_category_code,business_category_description,orig_date_reported_ymd,orig_date_last_sale_ym,payment_terms,high_credit_mask,recent_high_credit,account_balance_mask,masked_account_balance,current_percent,debt_01_30_percent,debt_31_60_percent,debt_61_90_percent,debt_91_plus_percent,new_trade_flag,trade_type_code,trade_type_desc,date_reported,date_last_sale';
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
    + 'NAMESCOPE:Base_2000\n'
    + '//--------------------------      \n'
    + '//FIELDTYPE DEFINITIONS\n'
    + '//--------------------------         \n'
    + 'FIELDTYPE:invalid_mandatory:LENGTHS(1..)\n'
    + 'FIELDTYPE:invalid_numeric:CUSTOM(Scrubs_EBR.Functions.fn_numeric>0)\n'
    + 'FIELDTYPE:invalid_numeric_or_allzeros:CUSTOM(Scrubs_EBR.Functions.fn_numeric_or_allzeros>0)\n'
    + 'FIELDTYPE:invalid_pastdate:CUSTOM(Scrubs_EBR.Functions.fn_past_yyyymmdd>0)\n'
    + 'FIELDTYPE:invalid_dt_first_seen:CUSTOM(Scrubs_EBR.Functions.fn_dt_first_seen>0)\n'
    + 'FIELDTYPE:invalid_dt_yymmdd:CUSTOM(Scrubs_EBR.Functions.fn_dt_yymmdd>0)\n'
    + 'FIELDTYPE:invalid_dt_ccyymm_or_200000:CUSTOM(Scrubs_EBR.Functions.fn_dt_ccyymm_or_200000>0)\n'
    + 'FIELDTYPE:invalid_dt_yymm_or_0000:CUSTOM(Scrubs_EBR.Functions.fn_dt_yymm_or_0000>0)\n'
    + 'FIELDTYPE:invalid_record_type:ENUM(H|C)\n'
    + 'FIELDTYPE:invalid_segment:ENUM(2000|2010)\n'
    + 'FIELDTYPE:invalid_payment_indicator:ENUM( |+|-|=)\n'
    + 'FIELDTYPE:invalid_mask:ENUM( |-|<|+)\n'
    + 'FIELDTYPE:invalid_flag:ENUM( |Y)\n'
    + 'FIELDTYPE:invalid_trade_code:ENUM(A|C|F|L|N|R|S|T)\n'
    + 'FIELDTYPE:invalid_trade_desc:ENUM(AGED|COLLECTION|ADDITIONAL|LEASING|NEW|CONTINUOUS|OTHER|TELECOM)\n'
    + 'FIELDTYPE:invalid_file_number:ALLOW(ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789):LENGTHS(9)\n'
    + '\n'
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
    + 'FIELD:payment_indicator:TYPE(STRING1):LIKE(invalid_payment_indicator):0,0\n'
    + 'FIELD:business_category_code:TYPE(STRING4):LIKE(invalid_numeric):0,0\n'
    + 'FIELD:business_category_description:TYPE(STRING10):LIKE(invalid_mandatory):0,0\n'
    + 'FIELD:orig_date_reported_ymd:TYPE(STRING6):LIKE(invalid_dt_yymmdd):0,0\n'
    + 'FIELD:orig_date_last_sale_ym:TYPE(STRING4):LIKE(invalid_dt_yymm_or_0000):0,0\n'
    + 'FIELD:payment_terms:TYPE(STRING7):LIKE(invalid_mandatory):0,0\n'
    + 'FIELD:high_credit_mask:TYPE(STRING1):LIKE(invalid_mask):0,0 \n'
    + 'FIELD:recent_high_credit:TYPE(STRING8):LIKE(invalid_numeric_or_allzeros):0,0\n'
    + 'FIELD:account_balance_mask:TYPE(STRING1):LIKE(invalid_mask):0,0 \n'
    + 'FIELD:masked_account_balance:TYPE(STRING8):LIKE(invalid_numeric_or_allzeros):0,0\n'
    + 'FIELD:current_percent:TYPE(STRING3):LIKE(invalid_numeric_or_allzeros):0,0\n'
    + 'FIELD:debt_01_30_percent:TYPE(STRING3):LIKE(invalid_numeric_or_allzeros):0,0\n'
    + 'FIELD:debt_31_60_percent:TYPE(STRING3):LIKE(invalid_numeric_or_allzeros):0,0\n'
    + 'FIELD:debt_61_90_percent:TYPE(STRING3):LIKE(invalid_numeric_or_allzeros):0,0\n'
    + 'FIELD:debt_91_plus_percent:TYPE(STRING3):LIKE(invalid_numeric_or_allzeros):0,0\n'
    + '// FIELD:comment_code:TYPE(STRING2):0,0\n'
    + '// FIELD:comment_description:TYPE(STRING10):0,0\n'
    + 'FIELD:new_trade_flag:TYPE(STRING1):LIKE(invalid_flag):0,0\n'
    + 'FIELD:trade_type_code:TYPE(STRING1):LIKE(invalid_trade_code):0,0\n'
    + 'FIELD:trade_type_desc:TYPE(STRING10):LIKE(invalid_trade_desc):0,0\n'
    + '// FIELD:dispute_indicator:TYPE(STRING1):0,0\n'
    + '// FIELD:dispute_code:TYPE(STRING2):0,0\n'
    + 'FIELD:date_reported:TYPE(STRING8):LIKE(invalid_pastdate):0,0\n'
    + 'FIELD:date_last_sale:TYPE(STRING6):LIKE(invalid_dt_ccyymm_or_200000):0,0\n'
    + '// FIELD:lf:TYPE(STRING1):0,0\n'
    ;
 
  // Structured values
  EXPORT linkpaths := DATASET([
    ],{STRING linkpath;STRING compulsory;STRING optional;STRING bonus;STRING required;STRING search});
 
END;

