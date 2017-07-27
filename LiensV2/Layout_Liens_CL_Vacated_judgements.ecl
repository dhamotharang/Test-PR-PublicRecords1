export Layout_Liens_CL_Vacated_judgements := record

  

   string  process_date ;
   string RMSID;
   string TMSID;

  string state_code;
  string jurisdiction_code;
  string filing_jurisdiction;
  string case_number;
  string filing_type;
  string filing_type_desc;
  string filing_date;
  string entry_date_time;

  string judge_casetitle;
  string orig_name_suffix ;
  string orig_name_type_code ;
  string orig_name ;
  string orig_entity ;
  string orig_ssnORTaxId ;

  string name_suffix  ;
  string name_type_code ;
  string name  ;
  string entity  ;
  string address  ;
  string city  ;
  string state  ;
  string zip_code  ;
  string ssnORTaxId  ;
  string amount  ;
  string plantiff  ; // 024
  string plantiff_attorney  ; //022
   string orig_judgment_date  ; //126
  
  
 
  string clean_debtor_address ;
  string  clean_debtor_pname ;
  string  clean_debtor_cname ;
 string   clean_plantiff_cnames1 ;
  string  clean_plantiff_cnames2 ;
  string  clean_plantiff_cnames3 ;
  string  clean_plantiff_cnames4 ;
  string  clean_plantiff_cnames5 ;

  string  clean_plantiff_pnames1 ;
  string  clean_plantiff_pnames2 ;
  string  clean_plantiff_pnames3 ;
  string  clean_plantiff_pnames4 ;
  string  clean_plantiff_pnames5 ;
  string  clean_atty_pname ;
  string clean_atty_cname ;
 
end;
