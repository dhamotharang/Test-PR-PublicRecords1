import address;
export Layout_5000_Bank_Details_In := 
record
   string8 process_date;
   string10 FILE_NUMBER;
   string4 SEGMENT_CODE;
   string5 SEQUENCE_NUMBER;
   string30 NAME;
   string30 STREET_ADDRESS;
   string20 CITY;
   string2 STATE_CODE;
   string20 STATE_DESC;
   string5 ZIP_CODE;
   string10 TELEPHONE;
   string1 RELATIONSHIP_CODE;
   string21 RELATIONSHIP_DESC;
   string1 BAL_RANGE_CODE;
   string1 ACCT_BAL_RANGE_CODE;
   string1 NBR_FIG_IN_BAL;
   string13 ACCT_BAL_TOTAL;
   string1 ACCT_RATING_CODE;
   string6 DATE_ACCT_OPENED_YMD;
   string6 DATE_ACCT_CLOSED_YMD;
   string8 NAME_ADDR_KEY;
   string1 DISPUTE_IND;
   string2 DISPUTE_CODE;
   address.Layout_Clean182;
   string1 lf;
end;
