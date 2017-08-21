export Layout_Liens_CL_History := record

string20 RMSID ;
 string20 TMSID ;
 string8 process_date ;
string1 file_type ;
string30 file_type_desc ;
string274 ATTORNEY;
string8 CALL;
string170 CASE_NAME;
string13 CASE_NUMBER;
string76 CITE_ID;
string46 COUNTY;
string46 COURT;
string76 COURT_2;
string250 DECEDENT;
string31 DISPOSITION;
string34 DOCKET;
string13 FILE_CODE;
string6 FILE_ID;
string8 FILING_DATE;
string30 I_AMOUNT;
string139 JUDGE;
string15 JUDGMENT_AMOUNT;
string31 LIEN_DOC__;
string24 ORIG_CASE__;
string8 ORIG_FILING_DATE;
string8 ORIG_JUDG_DATE;
string3 PAGE;
string32 RELEASE_DOC__;
string114 TYPE;
string19 VDI;
  string1803 orig_debtor;
  string1803 orig_full_debtor_name;
  string100 DEBTOR;
  string100 ADDRESS;
  string100 city_state_zip;
  string100 SSN;
   string100 FEIN;
  string675 CREDITOR;

string398   clean_creditor_cnames1 ;
string398   clean_creditor_cnames2 ;
string398   clean_creditor_cnames3 ;
string398   clean_creditor_cnames4 ;
string398   clean_creditor_cnames5 ;
string398   clean_creditor_cnames6 ;
string398   clean_creditor_cnames7 ;
string398   clean_creditor_cnames8 ;
string398   clean_creditor_cnames9 ;
string398   clean_creditor_cnames10 ;

string73 clean_creditor_pnames1 ;
string73 clean_creditor_pnames2;
string73 clean_creditor_pnames3 ;
string73 clean_creditor_pnames4 ;
string73 clean_creditor_pnames5 ;
string73 clean_creditor_pnames6 ;
string73 clean_creditor_pnames7;
string73 clean_creditor_pnames8 ;
string73 clean_creditor_pnames9 ;
string73 clean_creditor_pnames10 ;
string100 clean_debtor_cname ;
string73  clean_debtor_pname ;
string182 clean_debtor_addr;
string274 clean_atty_cname ;
string73  clean_atty_pname ;
end ;