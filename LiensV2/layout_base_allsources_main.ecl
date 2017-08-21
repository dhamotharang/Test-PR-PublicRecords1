import liensv2;

export layout_base_allsources_main := module


export layout_filing_status := record, maxlength(10000)

string filing_status := '';
string filing_status_desc := '';

end;

export rec := record, maxlength(32766)

string50 tmsid;
string50 rmsid;
string8 process_date;
string1 record_code := '';
string8 date_vendor_removed := '';
string50 filing_jurisdiction := '';
string2 filing_state := '';
string20 orig_filing_number := '';
string50 orig_filing_type := '';
string8 orig_filing_date := '';
string10 orig_filing_time := '';
string25 case_number   := '';
string20 filing_number := '';
string125 filing_type_desc := '';
string8 filing_date := '';
string10 filing_time := '';
string8 vendor_entry_date := '';
string150 judge := '';
string175 case_title := '';
string10 filing_book := '';
string10 filing_page := '';
string8 release_date := '';
string50 amount := '';
string1 eviction := '';
string75 satisifaction_type := '';
string8 judg_satisfied_date := '';
string8 judg_vacated_date := '';
string40 tax_code := '';
string200 irs_serial_number := '';
string8 effective_date := '';
string8 lapse_date := '';
string8 accident_date := '';
string1 sherrif_indc := '';
string8 expiration_date := '';
string150 agency :='';
string20 agency_city :='';
string2 agency_state :='';
string40 agency_county :='';
string50 legal_lot := '';
string10 legal_block := '';
string10 legal_borough := '';
string20 certificate_number := '';
BOOLEAN		bCBFlag	:=	FALSE;

dataset(layout_filing_status) filing_status;

end;
end;