import LiensV2, ut;

rlayout_liens_main := record, maxlength(32766)
/*
string50 tmsid;
string50 rmsid;
string50 orig_rmsid;    // Hogan Only
string8 process_date;
string1 record_code := '';
string185 date_vendor_removed := '';
string46 filing_jurisdiction := '';
string8 filing_state := '';
string20 orig_filing_number := '';
string50 orig_filing_type := '';
string10 orig_filing_date := '';
string4 orig_filing_time := '';
string20 case_number   := '';
string20 filing_number := '';
string114 filing_type_desc := '';
string10 filing_date := '';
string4 filing_time := '';
string10 vendor_entry_date := '';
string139 judge := '';
string170 case_title := '';
string6 filing_book := '';
string6 filing_page := '';
string10 release_date := '';
string30 amount := '';
string1 eviction := '';
string50 satisifaction_type := '';
string8 judg_satisfied_date := '';
string8 judg_vacated_date := '';
string30 tax_code := '';
string150 irs_serial_number := '';
string10 effective_date := '';
string8 lapse_date := '';
string8 accident_date := '';
string1 sherrif_indc := '';
string8 expiration_date := '';
string100 agency :='';
string12 agency_city :='';
string2 agency_state :='';
string30 agency_county :='';
string5 legal_lot := '';
string5 legal_block := '';
string8 legal_borough := '';
string20 certificate_number := '';
unsigned8 persistent_record_id :=0 ; 
string20 source_file;
*/


string50 tmsid;
string50 rmsid;
string50 orig_rmsid;    // Hogan Only
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
unsigned8 persistent_record_id :=0; 
string20 source_file;
end;

main_file_ca_federal  := project(LiensV2.file_CA_federal_main, transform(rlayout_liens_main, self.source_file := 'CA FEDERAL'; self := LEFT; self := []));
main_file_chicago_law := project(LiensV2.file_chicago_law_main, transform(rlayout_liens_main, self.source_file := 'CHICAGO LAW'; self := LEFT; self := []));
main_file_hogan 			:= project(LiensV2.file_hogan_main, transform(rlayout_liens_main, self.source_file := 'HOGAN'; self := LEFT; self := []));
main_file_ilfdln      := project(LiensV2.file_ILFDLN_main, transform(rlayout_liens_main, self.source_file := 'ILFDLN'; self := LEFT; self := []));
main_file_ma          := project(LiensV2.file_MA_main, transform(rlayout_liens_main, self.source_file := 'MA'; self := LEFT; self := []));
main_file_nyc         := project(LiensV2.file_NYC_main, transform(rlayout_liens_main, self.source_file := 'NYC'; self := LEFT; self := []));
main_file_nyfdln      := project(LiensV2.file_NYFDLN_main, transform(rlayout_liens_main, self.source_file := 'NYFDLN'; self := LEFT; self := []));
main_file_sa          := project(LiensV2.file_SA_main, transform(rlayout_liens_main, self.source_file := 'SA'; self := LEFT; self := []));
main_file_superior    := project(LiensV2.file_Superior_main, transform(rlayout_liens_main, self.source_file := 'SUPERIOR'; self := LEFT; self := []));



EXPORT file_Liens_main := 	main_file_ca_federal +
																main_file_chicago_law +
																main_file_hogan +
																main_file_ilfdln +
																main_file_ma +
																main_file_nyc	+
																main_file_nyfdln	+ 
																main_file_sa 	+
																main_file_superior;