﻿export Layout_Liens_temp_base := record, maxlength(10000)

string50 tmsid;
string50 rmsid;
string10 orig_rmsid := '';
string process_date;
string1 ADDDELFLAG := '';
string record_code := '';
string date_vendor_removed := '';
string filing_jurisdiction := '';
string filing_state := '';
string20 orig_filing_number := '';
string orig_filing_type := '';
string orig_filing_date := '';
string orig_filing_time := '';
string filing_status := '';
string filing_status_desc := '';
string case_number   := '';
string20 filing_number := '';
string2 filing_type	:= '';
string filing_type_desc := '';
string filing_date := '';
string filing_time := '';
string vendor_entry_date := '';
string judge := '';
string case_title := '';
string filing_book := '';
string filing_page := '';
string release_date := '';
string amount := '';
string eviction := '';
string satisifaction_type := '';
string judg_satisfied_date := '';
string judg_vacated_date := '';
string tax_code := '';
string irs_serial_number := '';
string effective_date := '';
string lapse_date := '';
string accident_date := '';
string sherrif_indc := '';
string expiration_date := '';
string orig_full_debtorname := '';
string debtor_name := ''; 
string debtor_lname := '';
string debtor_fname := '';
string debtor_mname := '';
string debtor_suffix := '';
string9 debtor_tax_id := '';
string9 debtor_ssn := '';
string debtor_address1 := '';
string debtor_address2 := '';
string debtor_city := '';
string debtor_state := '';
string debtor_zip5 := '';
string debtor_zip4 := '';
string debtor_county := '';
string debtor_country :='';
string creditor_name :='';
string creditor_lname := '';
string creditor_fname := '';
string creditor_mname := '';
string creditor_address1 :='';
string creditor_address2 :='';
string creditor_city :='';
string creditor_state :='';
string creditor_zip5 :='';
string creditor_zip4 :='';
string creditor_country :='';
string atty_Name :='';
string atty_lname := '';
string atty_fname := '';
string atty_mname := '';
string atty_address1 :='';
string atty_address2 :='';
string atty_city :='';
string atty_state :='';
string atty_zip5 :='';
string atty_zip4 :='';
string atty_phone :='';
string thd_name :='';
string thd_lname :='';
string thd_fname :='';
string thd_mname :='';
string thd_address1 :=''; 
string thd_address2 :='';    
string thd_city :=''; 
string thd_state :=''; 
string thd_zip5 :='';
string thd_zip4 :='';
string agency :='';
string agency_city :='';
string agency_state :='';
string agency_county :='';
string legal_lot := '';
string legal_block := '';
string legal_borough := '';
string certificate_number := '';
BOOLEAN	bCBFlag	:=	FALSE;
liensv2.layout_clean_name.clean_debtor_name;
liensv2.Layout_clean_name.clean_creditor_name;
liensv2.Layout_clean_name.clean_attorney_name;
liensv2.Layout_clean_name.clean_third_party_name;
liensv2.Layout_clean182.clean_debtor_addr;
liensv2.Layout_clean182.clean_creditor_addr;
liensv2.Layout_clean182.clean_attorney_addr;
liensv2.Layout_clean182.clean_third_party_addr;
string  clean_debtor_cname := '';
string  clean_creditor_cname := '';
string  clean_atty_cname := '';
string  clean_thd_cname := '';
string  thd_phone := '' ;
STRING8	DOB	:=	'';
string2 Filing_Type_ID	:= '';
STRING8	Collection_Date	:=	'';
STRING45	CaseLinkID	:=	'';
string50 TMSID_old	:=	'';
string50 RMSID_old	:=	'';
BOOLEAN	CaseLinkID_Prop_Flag	:=	FALSE;
// DF-24061	VC
string7   AgencyID     :='';
String1   AgencyID_src :=''; 
unsigned4 global_sid   :=0 ;
unsigned8 record_sid   :=0 ;

end;


