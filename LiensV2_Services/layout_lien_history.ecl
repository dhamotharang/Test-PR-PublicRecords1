import liensv2, FFD;

export layout_lien_history := record
	liensv2.Layout_liens_base_module.layout_liens_base.filing_number;
	string50 filing_type_desc;
	string8 orig_filing_date;
	string8 filing_date;
	string10 filing_time;
	string10 filing_book;
	string10 filing_page;
	string60 agency;
	string2 agency_state;
	string35 agency_city;
	string35 agency_county;
	unsigned8 persistent_record_id := 0;
	FFD.Layouts.CommonRawRecordElements;
end;