import dx_common;

export Layout_2025_Trade_Quarterly_Averages_Base := 
record
  Layout_Base;
  string8   process_date;
  string10  FILE_NUMBER;
  string4   SEGMENT_CODE;
  string5   SEQUENCE_NUMBER;
  string1   QUARTER;
  string2   QUARTER_YY;
  string3   DEBT;
  string1   ACCOUNT_BALANCE_MASK;
  string8   ACCOUNT_BALANCE;
  string3   CURRENT_BALANCE_PERCENT;
  string3   DEBT_01_30_PERCENT;
  string3   DEBT_31_60_PERCENT;
  string3   DEBT_61_90_PERCENT;
  string3   DEBT_91_PLUS_PERCENT;
  dx_common.layout_metadata - [global_sid, record_sid];
end;