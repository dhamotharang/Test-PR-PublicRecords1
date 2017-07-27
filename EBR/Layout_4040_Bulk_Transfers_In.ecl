export Layout_4040_Bulk_Transfers_In := 
record
   string8 process_date;
   string10 FILE_NUMBER;
   string4 SEGMENT_CODE;
   string5 SEQUENCE_NUMBER;
   string6 orig_DATE_FILED_YYMMDD;
   string2 DATE_FILED_YY;
   string2 DATE_FILED_MM;
   string2 DATE_FILED_DD;
   string2 TYPE_CODE;
   string10 TYPE_DESC;
   string2 ACTION_CODE;
   string10 ACTION_DESC;
   string16 DOCUMENT_NUMBER;
   string20 FILING_LOCATION;
   string9 LIABILITY_AMT;
   string35 TRANSFEREE;
   string1 BULK_TRANSFER_CODE;
   string50 BULK_TRANSFER_DESC;
   string1 DISPUTE_IND;
   string2 DISPUTE_CODE;
   string8 date_filed;
   string1 lf;
end;