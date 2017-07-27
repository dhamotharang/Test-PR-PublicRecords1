export Layout_Trade_Payment_Totals_2015_In := record
string8  process_date;
string10 FILE_NUMBER;
string4  SEGMENT_CODE;
string5  SEQUENCE_NUMBER;
string6  FILLER1;
// Continuously Reported Totals
string3 TRADE_COUNT_1;
string3 DBT_1;
string1 HIGH_CREDIT_MASK_1;
string8 RECENT_HIGH_CREDIT_1;
string1 ACCT_BAL_MASK_1;
string8 MASKED_ACCT_BAL_1;
string3 CURRENT_BALANCE_PCT_1;
string3 DBT_01_30_PCT_1;
string3 DBT_31_60_PCT_1;
string3 DBT_61_90_PCT_1;
string3 DBT_91_PLUS_PCT_1;
// Newly Reported Totals
string3 TRADE_COUNT_2;
string3 DBT_2;
string1 HIGH_CREDIT_MASK_2;
string8 RECENT_HIGH_CREDIT_2;
string1 ACCT_BAL_MASK_2;
string8 MASKED_ACCT_BAL_2;
string3 CURRENT_BALANCE_PCT_2;
string3 DBT_01_30_PCT_2;
string3 DBT_31_60_PCT_2;
string3 DBT_61_90_PCT_2;
string3 DBT_91_PLUS_PCT_2;
// Trade Line Totals
string3 TRADE_COUNT_3;
string3 DBT_3;
string1 HIGH_CREDIT_MASK_3;
string8 RECENT_HIGH_CREDIT_3;
string1 ACCT_BAL_MASK_3;
string8 MASKED_ACCT_BAL_3;
string3 CURRENT_BALANCE_PCT_3;
string3 DBT_01_30_PCT_3;
string3 DBT_31_60_PCT_3;
string3 DBT_61_90_PCT_3;
string3 DBT_91_PLUS_PCT_3;
//
string3 HIGHEST_CREDIT_MED;
//
string938 FILLER2;
string1 lf;
end;
