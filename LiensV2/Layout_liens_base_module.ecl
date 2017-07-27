import address;

export Layout_liens_base_module := module

export layout_party_info := record, maxlength(40000)

string orig_full_debtorname := '';
string orig_name := ''; 
string orig_lname := '';
string orig_fname := '';
string orig_mname := '';
string orig_suffix := '';
string9 tax_id := '';
string9 ssn := '';
address.Layout_Clean_Name;
string cname := '';
string orig_address1 := '';
string orig_address2 := '';
string orig_city := '';
string orig_state := '';
string orig_zip5 := '';
string orig_zip4 := '';
string orig_county := '';
string orig_country :='';
address.Layout_Clean182;
string phone := '';
string name_type := '';
string12 DID  := '';
string12 BDID := '';
end;

export layout_filing_status := record

string filing_status_type := '';
string filing_status_desc := '';

end;

export layout_liens_base := record, maxlength(100000)

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
string8  date_first_seen := '';
string8  date_last_seen := '';
string8  date_vendor_first_reported := '';
string8  date_vendor_last_reported := '';

dataset(layout_party_info) party;
dataset(layout_filing_status) filing_status;
end;
end;

