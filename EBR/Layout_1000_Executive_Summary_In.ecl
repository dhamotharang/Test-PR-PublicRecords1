export Layout_1000_Executive_Summary_In := 
record
   string8     process_date;
   string10    FILE_NUMBER;
   string4     SEGMENT_CODE;
   string5     SEQUENCE_NUMBER;
   string3     CURRENT_DBT;
   string3     PREDICTED_DBT;
   string3     CONF_PERCENT;
   string1     CONF_SLOPE;
   string6     orig_PREDICTED_DBT_DATE_MMDDYY;
   string3     AVERAGE_INDUSTRY_DBT;
   string3     AVERAGE_ALL_INDUSTRIES_DBT;
   string8     LOW_BALANCE;
   string8     HIGH_BALANCE;
   string8     CURRENT_ACCOUNT_BALANCE;
   string8     HIGH_CREDIT_EXTENDED;
   string8     MEDIAN_CREDIT_EXTENDED;
   string1     PAYMENT_PERFORMANCE;
   string1     PAYMENT_TREND;
   string20    INDUSTRY_DESCRIPTION;
   string8     predicted_dbt_date;
   string1     lf := '';
end;
