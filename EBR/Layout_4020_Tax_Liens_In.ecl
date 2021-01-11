export Layout_4020_Tax_Liens_In := 
record
   string8 process_date;
   string10 FILE_NUMBER;
   string4 SEGMENT_CODE;
   string5 SEQUENCE_NUMBER;
   string6 orig_Date_Filed_YMD;
   string2 Type_Code;
   string10 Type_Description;
   string2 Action_Code;
   string10 Action_Description;
   string16 Document_Number;
   string20 Filing_Location;
   string9 Liability_Amount;
   string1 Tax_Lien_Code;
   string50 Tax_Lien_Description;
   string1 Dispute_Indicator;
   string2 Dispute_Code;
   string8 date_filed;
   string1 lf := '';
end;
