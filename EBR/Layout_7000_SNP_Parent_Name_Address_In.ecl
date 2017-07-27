import address;
export Layout_7000_SNP_Parent_Name_Address_In := 
record
   string8 process_date;
   string10 FILE_NUMBER;
   string4 SEGMENT_CODE;
   string5 SEQUENCE_NUMBER;
   string40 CO_NAME;
   string40 CO_ADDRESS;
   string20 CO_CITY;
   string2 CO_STATE_CODE;
   string20 CO_STATE_DESC;
   string5 CO_ZIP;
   address.Layout_Clean182 clean_parent_address;
   string1 lf;
end;