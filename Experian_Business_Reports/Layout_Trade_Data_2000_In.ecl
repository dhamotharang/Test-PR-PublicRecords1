export Layout_Trade_Data_2000_In := record
string8  process_date;
string10 FILE_NUMBER;
string4  SEGMENT_CODE;
string5  SEQUENCE_NUMBER;
string6  FILLER1;
string1  PAYMENT_IND;
string4  BUS_CAT_CODE;
string10 BUS_CAT_DESC;
string6  DATE_REPORTED_YMD;
string4  DATE_LAST_SALE_YM;
string7  PAYMENT_TERMS;
string1  HIGH_CREDIT_MASK;
string8  RECENT_HIGH_CREDIT;
string1  ACCT_BAL_MASK;
string8  MASKED_ACCT_BAL;
string3  CURRENT_PCT;
string3  DBT_01_30_PCT;
string3  DBT_31_60_PCT;
string3  DBT_61_90_PCT;
string3  DBT_91_PLUS_PCT;
string2  COMMENT_CODE;
string10 COMMENT_DESC;
string1  NEW_TRADE_FLAG;
string1  TRADE_TYPE_CODE;
string10 TRADE_TYPE_DESC;
string1  DISPUTE_IND;
string2  DISPUTE_CODE;
string966 FILLER2;
string1  lf;
end;
