export Layout_Liens_NYFDLN := 
record
 string50 RMSID;
   string50 TMSID;
   string8    process_date;
   string200 ORIG_NAME;
   string200  NAME;
   string8    LIEN_DATE;
   string18   AMOUNT;
   string60   ADDRESS1;
   string60   ADDRESS2;
   string30   CITY;
   string2    STATE;
   string5    ZIP5;
   string4    ZIP4;
   string2    LEVYING_OFFICE;
   string12   LEVYING_OFFICE_CITY ;
   string182  clean_debtor_address;
   string20   filing_type ;
   string2    filing_jurisdiction;
   string73   clean_debtor_pname ;
   string200  clean_debtor_cname ;
  
end;
