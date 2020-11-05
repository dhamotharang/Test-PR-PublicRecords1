export Layout_2000_Trade_In := 
record
   string8 process_date;
   string10 FILE_NUMBER;
   string4 SEGMENT_CODE;
   string5 SEQUENCE_NUMBER;
   string1 PAYMENT_INDICATOR;
   string4 BUSINESS_CATEGORY_CODE;
   string10 BUSINESS_CATEGORY_DESCRIPTION;
   string6 orig_DATE_REPORTED_YMD;
   string4 orig_DATE_LAST_SALE_YM;
   string7 PAYMENT_TERMS;
   string1 HIGH_CREDIT_MASK;
   string8 RECENT_HIGH_CREDIT;
   string1 ACCOUNT_BALANCE_MASK;
   string8 MASKED_ACCOUNT_BALANCE;
   string3 CURRENT_PERCENT;
   string3 DEBT_01_30_PERCENT;
   string3 DEBT_31_60_PERCENT;
   string3 DEBT_61_90_PERCENT;
   string3 DEBT_91_PLUS_PERCENT;
   string2 COMMENT_CODE;
   string10 COMMENT_DESCRIPTION;
   string1 NEW_TRADE_FLAG;
   string1 TRADE_TYPE_CODE;
   string10 TRADE_TYPE_DESC;
   string1 DISPUTE_INDICATOR;
   string2 DISPUTE_CODE;
   string8 date_reported;
   string6 date_last_sale;
   string1 lf := '';
end;