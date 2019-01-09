// Machine-readable versions of the spec file and subsets thereof
IMPORT SALT311;
EXPORT Base_2015_GenerationMod := MODULE(SALT311.iGenerationMod)
 
  // SALT Version info
  EXPORT salt_VERSION := 'V3.11.4';
  EXPORT salt_MODULE := 'SALT311'; // Optional override by HACK:SALTMODULE
  EXPORT salt_TOOLSMODULE := 'SALTTOOLS30'; // Optional override by HACK:SALTTOOLSMODULE
 
  // Core module configuration values
  EXPORT spc_MODULE := 'Scrubs_EBR';
  EXPORT spc_NAMESCOPE := 'Base_2015';
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
  EXPORT spc_EXTERNAL_BATCH_PARAM := ',/* MY_ */,powid,proxid,seleid,orgid,ultid,bdid,date_first_seen,date_last_seen,process_date_first_seen,process_date_last_seen,record_type,process_date,file_number,segment_code,trade_count1,debt1,high_credit_mask1,recent_high_credit1,account_balance_mask1,masked_account_balance1,current_balance_percent1,debt_01_30_percent1,debt_31_60_percent1,debt_61_90_percent1,debt_91_plus_percent1,trade_count2,debt2,high_credit_mask2,recent_high_credit2,account_balance_mask2,masked_account_balance2,current_balance_percent2,debt_01_30_percent2,debt_31_60_percent2,debt_61_90_percent2,debt_91_plus_percent2,trade_count3,debt3,high_credit_mask3,recent_high_credit3,account_balance_mask3,masked_account_balance3,current_balance_percent3,debt_01_30_percent3,debt_31_60_percent3,debt_61_90_percent3,debt_91_plus_percent3,highest_credit_median,orig_account_balance_regular_tradelines,orig_account_balance_new,orig_account_balance_combined,aged_trades_count,account_balance_regular_tradelines,account_balance_new,account_balance_combined';
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
    + 'NAMESCOPE:Base_2015\n'
    + '//--------------------------\n'
    + '//FIELDTYPE DEFINITIONS\n'
    + '//--------------------------\n'
    + 'FIELDTYPE:invalid_mandatory:LENGTHS(1..)\n'
    + 'FIELDTYPE:invalid_numeric:CUSTOM(Scrubs_EBR.Functions.fn_numeric>0)\n'
    + 'FIELDTYPE:invalid_numeric_or_allzeros:CUSTOM(Scrubs_EBR.Functions.fn_numeric_or_allzeros>0)\n'
    + 'FIELDTYPE:invalid_pastdate:CUSTOM(Scrubs_EBR.Functions.fn_past_yyyymmdd>0)\n'
    + 'FIELDTYPE:invalid_dt_first_seen:CUSTOM(Scrubs_EBR.Functions.fn_dt_first_seen>0)\n'
    + 'FIELDTYPE:invalid_account_balance:CUSTOM(Scrubs_EBR.Functions.fn_account_balance>0)\n'
    + 'FIELDTYPE:invalid_record_type:ENUM(H|C)\n'
    + 'FIELDTYPE:invalid_segment:ENUM(2015|2015)\n'
    + 'FIELDTYPE:invalid_mask:ENUM( |-|<|+)\n'
    + 'FIELDTYPE:invalid_file_number:ALLOW(ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789):LENGTHS(9)\n'
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
    + '// FIELD:sequence_number:TYPE(STRING5):0,0\n'
    + 'FIELD:trade_count1:TYPE(STRING3):LIKE(invalid_numeric_or_allzeros):0,0\n'
    + 'FIELD:debt1:TYPE(STRING3):LIKE(invalid_numeric_or_allzeros):0,0\n'
    + 'FIELD:high_credit_mask1:TYPE(STRING1):LIKE(invalid_mask):0,0 \n'
    + 'FIELD:recent_high_credit1:TYPE(STRING8):LIKE(invalid_numeric_or_allzeros):0,0\n'
    + 'FIELD:account_balance_mask1:TYPE(STRING1):LIKE(invalid_mask):0,0 \n'
    + 'FIELD:masked_account_balance1:TYPE(STRING8):LIKE(invalid_numeric_or_allzeros):0,0\n'
    + 'FIELD:current_balance_percent1:TYPE(STRING3):LIKE(invalid_numeric_or_allzeros):0,0\n'
    + 'FIELD:debt_01_30_percent1:TYPE(STRING3):LIKE(invalid_numeric_or_allzeros):0,0\n'
    + 'FIELD:debt_31_60_percent1:TYPE(STRING3):LIKE(invalid_numeric_or_allzeros):0,0\n'
    + 'FIELD:debt_61_90_percent1:TYPE(STRING3):LIKE(invalid_numeric_or_allzeros):0,0\n'
    + 'FIELD:debt_91_plus_percent1:TYPE(STRING3):LIKE(invalid_numeric_or_allzeros):0,0\n'
    + 'FIELD:trade_count2:TYPE(STRING3):LIKE(invalid_numeric_or_allzeros):0,0\n'
    + 'FIELD:debt2:TYPE(STRING3):LIKE(invalid_numeric_or_allzeros):0,0\n'
    + 'FIELD:high_credit_mask2:TYPE(STRING1):LIKE(invalid_mask):0,0 \n'
    + 'FIELD:recent_high_credit2:TYPE(STRING8):LIKE(invalid_numeric_or_allzeros):0,0\n'
    + 'FIELD:account_balance_mask2:TYPE(STRING1):LIKE(invalid_mask):0,0 \n'
    + 'FIELD:masked_account_balance2:TYPE(STRING8):LIKE(invalid_numeric_or_allzeros):0,0\n'
    + 'FIELD:current_balance_percent2:TYPE(STRING3):LIKE(invalid_numeric_or_allzeros):0,0\n'
    + 'FIELD:debt_01_30_percent2:TYPE(STRING3):LIKE(invalid_numeric_or_allzeros):0,0\n'
    + 'FIELD:debt_31_60_percent2:TYPE(STRING3):LIKE(invalid_numeric_or_allzeros):0,0\n'
    + 'FIELD:debt_61_90_percent2:TYPE(STRING3):LIKE(invalid_numeric_or_allzeros):0,0\n'
    + 'FIELD:debt_91_plus_percent2:TYPE(STRING3):LIKE(invalid_numeric_or_allzeros):0,0\n'
    + 'FIELD:trade_count3:TYPE(STRING3):LIKE(invalid_numeric_or_allzeros):0,0\n'
    + 'FIELD:debt3:TYPE(STRING3):LIKE(invalid_numeric_or_allzeros):0,0\n'
    + 'FIELD:high_credit_mask3:TYPE(STRING1):LIKE(invalid_mask):0,0\n'
    + 'FIELD:recent_high_credit3:TYPE(STRING8):LIKE(invalid_numeric_or_allzeros):0,0\n'
    + 'FIELD:account_balance_mask3:TYPE(STRING1):LIKE(invalid_mask):0,0 \n'
    + 'FIELD:masked_account_balance3:TYPE(STRING8):LIKE(invalid_numeric_or_allzeros):0,0\n'
    + 'FIELD:current_balance_percent3:TYPE(STRING3):LIKE(invalid_numeric_or_allzeros):0,0\n'
    + 'FIELD:debt_01_30_percent3:TYPE(STRING3):LIKE(invalid_numeric_or_allzeros):0,0\n'
    + 'FIELD:debt_31_60_percent3:TYPE(STRING3):LIKE(invalid_numeric_or_allzeros):0,0\n'
    + 'FIELD:debt_61_90_percent3:TYPE(STRING3):LIKE(invalid_numeric_or_allzeros):0,0\n'
    + 'FIELD:debt_91_plus_percent3:TYPE(STRING3):LIKE(invalid_numeric_or_allzeros):0,0\n'
    + 'FIELD:highest_credit_median:TYPE(STRING8):LIKE(invalid_numeric_or_allzeros):0,0\n'
    + 'FIELD:orig_account_balance_regular_tradelines:TYPE(STRING8):LIKE(invalid_account_balance):0,0\n'
    + 'FIELD:orig_account_balance_new:TYPE(STRING8):LIKE(invalid_account_balance):0,0\n'
    + 'FIELD:orig_account_balance_combined:TYPE(STRING8):LIKE(invalid_account_balance):0,0\n'
    + 'FIELD:aged_trades_count:TYPE(STRING3):LIKE(invalid_numeric_or_allzeros):0,0\n'
    + 'FIELD:account_balance_regular_tradelines:TYPE(STRING8):LIKE(invalid_numeric_or_allzeros):0,0\n'
    + 'FIELD:account_balance_new:TYPE(STRING8):LIKE(invalid_numeric_or_allzeros):0,0\n'
    + 'FIELD:account_balance_combined:TYPE(STRING8):LIKE(invalid_numeric_or_allzeros):0,0\n'
    + '// FIELD:lf:TYPE(STRING1):0,0\n'
    ;
 
  // Structured values
  EXPORT linkpaths := DATASET([
    ],{STRING linkpath;STRING compulsory;STRING optional;STRING bonus;STRING required;STRING search});
 
END;

