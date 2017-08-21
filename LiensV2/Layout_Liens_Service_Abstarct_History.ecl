export Layout_Liens_Service_Abstarct_History := record

  
 string8 process_date;
  string50 TMSID ;
  string50 RMSID ;
string24 ADF ;
string20 AMOUNT;
string109 ATTORNEY;
string80 CITE_ID;
string90 CREDITOR;
string150 CREDITOR_ADDRESS ;
string150 CREDITOR_CITY_STATE_ZIP  ;
string150 orig_CREDITOR_ADDRESS;

string10 DATE_LAST_TRANS;

string90 DEBTOR;
string160 DEBTOR_ADDRESS ;
string160 orig_DEBTOR_ADDRESS;
string160 DEBTOR_CITY_STATE_ZIP  ;
string20  ssn ;
string20 fein ;


string21 DOCKET_NUMBER;
string181 FILE_CODE;
string6 FILE_ID;
string10 FILING_DATE;
string10 PERFECTED_DATE ;
string70 PUBLICATION_2 ;
string70 PUBLICATION_3 ;
string20 SERIAL_NUMBER;
string65 STATUS ;
string10 STATUS_DATE ;
string20 TAX_CODE ;
string2080 TEXT ;
string21 TYPE;
string120 VDI;
string10 _REPORT_NO;


  string182 clean_debtor_addr ; 
  string182 clean_credtor_addr ;
  string73 clean_debtor_pname ;
  string90 clean_debtor_cname ;
  string73 clean_credtor_pname ;
  string90 clean_credtor_cname;
  string73    clean_atty_pname  ;
  string109  clean_atty_cname;


end;