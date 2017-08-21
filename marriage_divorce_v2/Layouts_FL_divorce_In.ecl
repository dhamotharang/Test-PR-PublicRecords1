export Layouts_FL_divorce_In := MODULE

export Layout_Divorce_FL_Var_In := 
record
	string  EVENT_YEAR               ; 
string  CERTNUMBER                   ; 
string  TYPE_OF_REPORT               ; 
string  type_of_report_code          ; 
string  COUNTY_ISSUING_REPORT        ; 
string  COUNTY_ISSUING_CODE          ; 
string  DATE_OF_FINAL_JUDGMENTMM     ; 
string  DATE_OF_FINAL_JUDGMENTDD     ; 
string  DATE_OF_FINAL_JUDGMENTYY     ; 
string  DATE_FILED_RECMM             ; 
string  DATE_FILED_RECDD             ; 
string  DATE_FILED_RECYY             ; 
string  HUSB_NAME_FIRST              ; 
string  HUSB_NAME_MIDDLE             ; 
string  HUSB_NAME_LAST               ; 
string  HUSB_NAME_SUFFIX             ; 
string  HUSB_RES_STATE               ; 
string  HUSB_RES_STATE_CODE          ; 
string  HUSB_RES_COUNTRY             ; 
string  HUSB_RES_COUNTRY_CODE        ; 
string  WIFE_NAME_FIRST              ; 
string  WIFE_NAME_MIDDLE             ; 
string  WIFE_NAME_LAST               ; 
string  WIFE_MAIDEN_SURNAME          ; 
string  WIFE_RES_STATE               ; 
string  WIFE_RES_STATE_CODE          ; 
string  WIFE_RES_COUNTRY             ; 
string  WIFE_RES_COUNTRY_CODE        ; 
string  MARR_STATE                   ; 
string  MARR_STATE_CODE              ; 
string  MARR_COUNTRY                 ; 
string  MARR_COUNTRY_CODE            ; 
string  DATE_OF_MARRIAGE_MONTH       ; 
string  DATE_OF_MARRIAGE_DAY         ; 
string  DATE_OF_MARRIAGE_YEAR        ; 
string  LIVING_CHILD_UNDER18         ; 
string  DOCKET_VOL_PAGE              ; 

end;

export Layout_Divorce_FL_In := 
record
	
  string11 certnumber;
  string41 county_issuing_report;
  string25 date_of_final_judgmentMM;
  string25 date_of_final_judgmentDD;
  string25 date_of_final_judgmentYY;
  string17 date_filed_recMM;
  string17 date_filed_recDD;
  string17 date_filed_recYY;
  string41 husb_name_first;
  string41 husb_name_middle;
  string41 husb_name_last;
  string17 husb_name_suffix;
  string20 husb_res_state_code;
  string41 wife_name_first;
  string41 wife_name_middle;
  string41 wife_name_last;
  string41 wife_maiden_surname;
  string20 wife_res_state_code;
  string23 date_of_marriage_month;
  string21 date_of_marriage_day;
  string22 date_of_marriage_year;
  string16 marr_state_code;
  string21 living_child_under18;
  string41 type_of_report;
  string docket_vol_page;

end;
end;