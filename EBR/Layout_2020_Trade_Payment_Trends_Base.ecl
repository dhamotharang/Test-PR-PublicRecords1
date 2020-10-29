import dx_common;

export Layout_2020_Trade_Payment_Trends_Base := 
record
  Layout_Base;
  string8   process_date;
  string10  FILE_NUMBER;
  string4   SEGMENT_CODE;
  string5   SEQUENCE_NUMBER;
  string2   TREND_MM;
  string2   TREND_YY;
  string3   DBT;
  string1   ACCT_BAL_MASK;
  string8   ACCT_BAL;
  string3   CURRENT_BALANCE_PCT;
  string3   DBT_01_30_PCT;
  string3   DBT_31_60_PCT;
  string3   DBT_61_90_PCT;
  string3   DBT_91_PLUS_PCT;
  dx_common.layout_metadata - [global_sid, record_sid];
end;