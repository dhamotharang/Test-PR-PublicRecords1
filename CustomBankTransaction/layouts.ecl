import address, AID;

EXPORT layouts := module

EXPORT layout_in := record

 string                ssn         ;
 string                brth_dt                ;
 string                frst_nm                ;
 string                mdl_nm               ;
 string                last_nm                ;
 string                addr_line_tx      ;
 string                city_tx  ;
 string                state_cd              ;
 string                zip_cd   ;
 string                Q01_last_ATM_visit_dt                ;
 string                Q02_atm_last_deposit_dt           ;
 string                Q03_atm_last_withdrawal_dt   ;
 string                Q04_ATM_last_deposit_amt       ;
 string                Q05_ATM_last_withdrawal_amt               ;
 string                Q06_cosigner_dob          ;
 string                Q07_last_ach_dep_dt   ;
 string                Q08_last_ach_dep_amt               ;
 string                Q09_last_dep_dt             ;
 string                Q10_last_dep_amt         ;
 string                Q11_debit_signature_last_dt    ;
 string                Q12_debit_signature_last_amt  ;
 string                Q13_debit_pin_last_dt ;
 string                Q14_debit_pin_last_amt               ;
 string                Q15_personal_bnkr_nm              ;
 string                Q16_opn_yr       ;
 string                Q17_bk_ctr_addr            ;
 string                Q18_last_chk_amt          ;
 string                Q19_cobrand_card         ;
 string                Q20_chase_com_login_cnt         ;
 string                Q21_car_model                ;
 string                Q22_atm_most_visited_addr    ;
 end;

EXPORT new_layout_in := record

 string                ssn         ;
 string                brth_dt                ;
 string                frst_nm                ;
 string                mdl_nm               ;
 string                last_nm                ;
 string                suffix_nm              ;
 string                addr_line_tx      ;
 string                city_tx  ;
 string                state_cd              ;
 string                zip_cd   ;
 string                Q01_last_ATM_visit_dt                ;
 string                Q02_atm_last_deposit_dt           ;
 string                Q03_atm_last_withdrawal_dt   ;
 string                Q04_ATM_last_deposit_amt       ;
 string                Q05_ATM_last_withdrawal_amt                ;
 string                Q06_cosigner_dob          ;
 /*string                Q07_last_ach_dep_dt   ;
 string                Q08_last_ach_dep_amt               ;
 string                Q09_last_dep_dt             ;
 string                Q10_last_dep_amt         ;
 string                Q11_debit_signature_last_dt    ;
 string                Q12_debit_signature_last_amt  ;
 string                Q13_debit_pin_last_dt ;
 string                Q14_debit_pin_last_amt               ;
 string                Q15_personal_bnkr_nm              ;*/
 string                Q16_opn_yr       ;
 string                Q17_bk_ctr_addr            ;
 //string                Q18_last_chk_amt          ;
 //string                Q19_cobrand_card         ;
 string                Q20_chase_com_login_cnt         ;
 //string                Q21_car_model                ;
 string                Q22_atm_most_visited_addr    ;
 string                tripleg_origapt := '';
 string                tripleg_destapt := '';
 string                tripleg_dprt_dt := '';
 string                tripleg_airline1 := '';
 /*string              flag1;
 string                flag2;
 string                flag3;
 string                flag4;
 string                flag5;*/
 end;

export layout_in_20140204 := record

string8 Sequence_Number;
string1 filler1;
string10 ECI_Number;
string1 filler2;
string9 SSN;
string1 filler3;
string8 DOB;
string1 filler4;
string32 Last_Name; 
string1 filler5;
string32 First_Name;
string1 filler6;
string32 Middle_Name;
string1 filler7;
string64 Current_Address_Street;
string1 filler8;
string25 Current_Address_City;
string1 filler9;
string2 Current_Address_State;
string1 filler10;
string5 Current_Address_Zip;
string1 filler11;
string5 Current_Address_Country_Code;
string1 filler12;
string4 Account_Number;
string1 filler13;
string32 Product_Type;
string1 filler14;
string10 Original_Open_Date;
string1 filler15;
string8 Branch_Location_Number;
string2 filler16;

end;

export layout_branch_addr_lookup := record

string branch_number;
string address;
string city;
string state;
string zip;

end;

export preclean := record

string                ssn         ;
 string                brth_dt                ;
 string                frst_nm                ;
 string                mdl_nm               ;
 string                last_nm                ;
 string                suffix_nm              ;
 string                addr_line_tx      ;
 string                city_tx  ;
 string                state_cd              ;
 string                zip_cd   ;
 string                Q01_last_ATM_visit_dt                ;
 string                Q02_atm_last_deposit_dt           ;
 string                Q03_atm_last_withdrawal_dt   ;
 string                Q04_ATM_last_deposit_amt       ;
 string                Q05_ATM_last_withdrawal_amt                ;
 string                Q06_cosigner_dob          ;
 string                Q07_last_ach_dep_dt   ;
 string                Q08_last_ach_dep_amt               ;
 string                Q09_last_dep_dt             ;
 string                Q10_last_dep_amt         ;
 string                Q11_debit_signature_last_dt    ;
 string                Q12_debit_signature_last_amt  ;
 string                Q13_debit_pin_last_dt ;
 string                Q14_debit_pin_last_amt               ;
 string                Q15_personal_bnkr_nm              ;
 string                Q16_opn_yr       ;
 string                Q17_bk_ctr_addr            ;
 string                Q18_last_chk_amt          ;
 string                Q19_cobrand_card         ;
 string                Q20_chase_com_login_cnt         ;
 string                Q21_car_model                ;
 string                Q22_atm_most_visited_addr    ;
 string                tripleg_origapt := '';
 string                tripleg_destapt := '';
 string                tripleg_dprt_dt := '';
 string                tripleg_airline1 := '';
 string              flag1;
 string                flag2;
 string                flag3;
 string                flag4;
 string                flag5;
 string address1;
 string address2;
 string Q17_bk_ctr_address1;
 string Q17_bk_ctr_address2;
 string Q22_atm_most_visited_address1;
 string Q22_atm_most_visited_address2;
 string8 open_date;
// AID.Common.xAID							Append_RawAID;
 string8         process_date := '';
 string8         date_vendor_first_reported := '';
 string8         date_vendor_last_reported := '';  
 string8         date_first_seen := '';
 string8         date_last_seen := '';      
end;

export base := record
 
 string                ssn         ;
 string8                brth_dt                ;
 string                frst_nm                ;
 string                mdl_nm               ;
 string                last_nm                ;
 string                suffix_nm              ;
 string                addr_line_tx      ;
 string                city_tx  ;
 string                state_cd              ;
 string                zip_cd   ;
 string8                Q01_last_ATM_visit_dt                ;
 string8                Q02_atm_last_deposit_dt           ;
 string8                Q03_atm_last_withdrawal_dt   ;
 decimal8_2                Q04_ATM_last_deposit_amt       ;
 decimal8_2                Q05_ATM_last_withdrawal_amt                ;
 string8                Q06_cosigner_dob          ;
 string8                Q07_last_ach_dep_dt   ;
 decimal8_2                Q08_last_ach_dep_amt               ;
 string8                Q09_last_dep_dt             ;
 decimal8_2                Q10_last_dep_amt         ;
 string8                Q11_debit_signature_last_dt    ;
 decimal8_2                Q12_debit_signature_last_amt  ;
 string8                Q13_debit_pin_last_dt ;
 decimal8_2                Q14_debit_pin_last_amt               ;
 string                Q15_personal_bnkr_nm              ;
 string4                Q16_opn_yr       ;
 string                Q17_bk_ctr_addr            ;
 decimal8_2                Q18_last_chk_amt          ;
 string                Q19_cobrand_card         ;
 string8                Q20_chase_com_login_cnt         ;
 string                Q21_car_model                ;
 string                Q22_atm_most_visited_addr    ;
 string                tripleg_origapt := '';
 string                tripleg_destapt := '';
 string8                tripleg_dprt_dt := '';
 string                tripleg_airline1 := '';
 string              flag1;
 string                flag2;
 string                flag3;
 string                flag4;
 string                flag5;
 string8         process_date := '';
 string8         date_vendor_first_reported := '';
 string8         date_vendor_last_reported := '';
 string8         date_first_seen := '';
 string8         date_last_seen := '';
 string5         title;
	string20        fname;
	string20        mname;
	string20        lname;
	string5         name_suffix;
Address.Layout_Clean182_fips;
 //AID.Common.xAID							Append_RawAID;  
 Address.Layout_Clean182_fips   Q17_bk_ctr_addr_clean;
 Address.Layout_Clean182_fips   Q22_atm_most_visited_addr_clean;
	unsigned8 nid:=0;
	unsigned6  did := 0;
	unsigned1  did_score := 0;
	
end;

end;