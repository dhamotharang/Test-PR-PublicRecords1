export Layout_Liens_Service_Abstarct_History := record

  
 string8 process_date;
  string50 TMSID ;
  string50 RMSID ;
string24 ADF;
string12 AMOUNT;
string50 ATTORNEY;
string44 CITE_ID;
string75 CREDITOR;

string131 CREDITOR_ADDRESS ;
string131 CREDITOR_CITY_STATE_ZIP ;
string131 orig_CREDITOR_ADDRESS;
//string131 cre_unknown ;

string10 DATE_LAST_TRANS;

string82  DEBTOR;
string100 DEBTOR_ADDRESS;
string132 DEBTOR_CITY_STATE_ZIP ;
string132 orig_DEBTOR_ADDRESS;
string20  ssn;
string20 fein;
//string100 deb_unknown;

string20 DOCKET_NUMBER;
string181 FILE_CODE;
string6 FILE_ID;
string10 FILING_DATE;
string10 PERFECTED_DATE;
string35 PUBLICATION_2;
string46 PUBLICATION_3;
string10 SERIAL_NUMBER;
string12 STATUS;
string10 STATUS_DATE;
string4 TAX_CODE;
string2023 TEXT;
string16 TYPE;
string107 VDI;
string10 _REPORT_NO;
 
string182 clean_debtor_addr ; 
  string182 clean_credtor_addr ;
  string73 clean_debtor_pname ;
  string82 clean_debtor_cname ;
  string73 clean_credtor_pname ;
  string75 clean_credtor_cname;
 string73    clean_atty_pname  ;
string50  clean_atty_cname;

end;