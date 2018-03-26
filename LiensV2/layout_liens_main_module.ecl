export layout_liens_main_module := module 

export layout_filing_status := record, maxlength(10000)

string filing_status := '';
string filing_status_desc := '';

end;

export layout_liens_main := record, maxlength(32766)

string50 tmsid;
string50 rmsid;
string process_date;
string record_code := '';
string date_vendor_removed := '';
string filing_jurisdiction := '';
string filing_state := '';
string20 orig_filing_number := '';
string orig_filing_type := '';
string orig_filing_date := '';
string orig_filing_time := '';
string case_number   := '';
string20 filing_number := '';
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
string agency :='';
string agency_city :='';
string agency_state :='';
string agency_county :='';
string legal_lot := '';
string legal_block := '';
string legal_borough := '';
string certificate_number := '';
BOOLEAN	bCBFlag	:=	FALSE;
unsigned8 persistent_record_id :=0 ; 

dataset(layout_filing_status) filing_status;
	STRING2		Filing_Type_ID		:=	'';
	STRING8		Collection_Date	:=	'';
	STRING45	CaseLinkID						:=	'';
	STRING50 TMSID_old							:=	'';
	STRING50 RMSID_old							:=	'';
	BOOLEAN		CaseLinkID_Prop_Flag	:=	FALSE;
end;
end;	
