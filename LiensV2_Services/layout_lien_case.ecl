import liensv2,FFD;

export layout_lien_case := record
  liensv2.layout_liens_main_module.layout_liens_main.tmsid;
	liensv2.layout_liens_main_module.layout_liens_main.rmsid;
	string50 filing_jurisdiction;
	string21 filing_jurisdiction_name := '';
	string2  filing_state;
	liensv2.layout_liens_main_module.layout_liens_main.orig_filing_number;
	string30 orig_filing_type;
	string8  orig_filing_date;
	string10 orig_filing_time;
	string25 case_number;
	string40 certificate_number;
	string20 tax_code;
	string11 irs_serial_number;
	string8  release_date;
	string15 amount;
	string15 eviction;
	string8  judg_satisfied_date;
	string8  judg_vacated_date;
	string100 judge;
	string6 legal_lot;
	string6 legal_block;
	boolean multiple_debtor := false;
	dataset(liensv2.Layout_liens_main_module.layout_filing_status) filing_status{maxcount(10)};
	unsigned8 persistent_record_id := 0;
	FFD.Layouts.CommonRawRecordElements;
end;
