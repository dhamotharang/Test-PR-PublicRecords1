export Layouts_FL_Marriage_In := MODULE

export Layout_Marriage_FL_Var_In := 
record
	string  EVENT_YEAR                   ;   
string  CertNumber                   ;   
string  DATE_OF_MARRIAGE_MONTH       ;   
string  DATE_OF_MARRIAGE_DAY         ;   
string  DATE_OF_MARRIAGE_YEAR        ;   
string  GROOM_NAME_FIRST             ;   
string  GROOM_NAME_MIDDLE            ;   
string  GROOM_NAME_LAST              ;   
string  GROOM_NAME_SUFFIX            ;   
string  GROOM_AGE                    ;   
string  GROOM_DOB_MONTH              ;   
string  GROOM_DOB_DAY                ;   
string  GROOM_DOB_YEAR               ;   
string  GROOM_RACE                   ;   
string  GROOM_RACE_CODE              ;   
string  GROOM_PREV_MARRIED           ;   
string  GROOM_MARRIAGE_NUMBER        ;   
string  GROOM_MARR_END_HOW           ;   
string  GROOM_MARR_END_HOW_CODE      ;   
string  GROOM_DATE_MARR_END_MONTH    ;   
string  GROOM_DATE_MARR_END_DAY      ;   
string  GROOM_DATE_MARR_END_YEAR     ;   
string  BRIDE_NAME_FIRST             ;   
string  BRIDE_NAME_MIDDLE            ;   
string  BRIDE_NAME_LAST              ;   
string  BRIDE_MAIDEN_SURNAME         ;   
string  BRIDE_AGE                    ;   
string  BRIDE_DOB_MONTH              ;   
string  BRIDE_DOB_DAY                ;   
string  BRIDE_DOB_YEAR               ;   
string  BRIDE_RACE                   ;   
string  BRIDE_RACE_CODE              ;   
string  BRIDE_PREV_MARRIED           ;   
string  BRIDE_MARRIAGE_NUMBER        ;   
string  BRIDE_MARR_END_HOW           ;   
string  BRIDE_MARR_END_HOW_CODE      ;   
string  BRIDE_DATE_MARR_END_MONTH    ;   
string  BRIDE_DATE_MARR_END_DAY      ;   
string  BRIDE_DATE_MARR_END_YEAR     ;   
string  COUNTRY_OF_MARRIAGE          ;   
string  COUNTRY_OF_MARRIAGE_CODE     ;   
string  STATE_OF_MARRIAGE            ;   
string  STATE_OF_MARRIAGE_CODE       ;   
string  city_of_marriage             ;   
string  TYPE_CEREMONY                ;   
string  TYPE_CEREMONY_CODE           ;   
string  GROOM_BIR_STATE              ;   
string  GROOM_BIR_STATE_CODE         ;   
string  GROOM_BIR_COUNTRY            ;   
string  GROOM_BIR_COUNTRY_CODE       ;   
string  GROOM_RES_STATE              ;   
string  GROOM_RES_STATE_CODE         ;   
string  GROOM_RES_COUNTRY            ;   
string  GROOM_RES_COUNTRY_CODE       ;   
string  BRIDE_BIR_COUNTRY            ;   
string  BRIDE_BIR_COUNTRY_CODE       ;   
string  BRIDE_BIR_STATE              ;   
string  BRIDE_BIR_STATE_CODE         ;   
string  BRIDE_RES_STATE              ;   
string  BRIDE_RES_STATE_CODE         ;   
string  BRIDE_RES_COUNTRY            ;   
string  BRIDE_RES_COUNTRY_CODE       ;   
string  COUNTY_ISSUING_LICENSE       ;   
string  COUNTY_ISSUING_LIC_CODE      ;   

end;
 
export Layout_Marriage_FL_In := 
record
  
	string11 certnumber;
  string24 county_issuing_lic_code;
  string41 groom_name_first;
  string41 groom_name_middle;
  string41 groom_name_last;
  string18 groom_name_suffix;
  string16 groom_DOB_month;
  string14 groom_DOB_day;
  string15 groom_DOB_year;
  string12 groom_age;
  string16 groom_race_code;
  string21 groom_res_state_code;
  string21 groom_bir_state_code;
  string24 groom_marr_end_how_code;
  string22 groom_marriage_number;
  string26 groom_Date_marr_end_month;
  string24 groom_Date_marr_end_day;
  string25 groom_Date_marr_end_year;
  string41 bride_name_first;
  string41 bride_name_middle;
  string41 bride_name_last;
  string41 bride_maiden_surname;
  string16 bride_DOB_month;
  string14 bride_DOB_day;
  string15 bride_DOB_year;
  string12 bride_age;
  string16 bride_race_code;
  string21 bride_res_state_code;
  string21 bride_bir_state_code;
  string24 bride_marr_end_how_code;
  string22 bride_marriage_number;
  string26 bride_Date_marr_end_month;
  string24 bride_Date_marr_end_day;
  string25 bride_Date_marr_end_year;
  string23 date_of_marriage_month;
  string21 date_of_marriage_day;
  string22 date_of_marriage_year;
  string19 type_ceremony_code;
  string city_of_marriage;

			
end;

end;