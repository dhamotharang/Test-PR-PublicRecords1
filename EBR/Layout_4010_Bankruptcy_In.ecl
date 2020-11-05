export Layout_4010_Bankruptcy_In := 
record
   string8 process_date;
   string10 FILE_NUMBER;
   string4 SEGMENT_CODE;
   string5 SEQUENCE_NUMBER;
   string6 orig_DATE_FILED_YYMMDD;
   string2 TYPE_CODE;
   string10 TYPE_DESC;
   string2 ACTION_CODE;
   string10 ACTION_DESC;
   string16 DOCUMENT_NUMBER;
   string9 LIABILITY_AMT;
   string9 ASSET_AMT;
   string1 DISPUTE_IND;
   string2 DISPUTE_CODE;
   string8 date_filed;
   string1 lf := '';
end;