Import Data_Services, liensv2, Doxie, ut;

get_recs := LiensV2.file_liens_fcra_main;

new_layout_liens_main := RECORD, MAXLENGTH(32766)
	STRING50 tmsid;
	STRING50 rmsid;
	STRING process_date;
	STRING record_code := '';
	STRING date_vendor_removed := '';
	STRING filing_jurisdiction := '';
	STRING filing_state := '';
	STRING20 orig_filing_number := '';
	STRING orig_filing_type := '';
	STRING orig_filing_date := '';
	STRING orig_filing_time := '';
	STRING case_number   := '';
	STRING20 filing_number := '';
	STRING filing_type_desc := '';
	STRING filing_date := '';
	STRING filing_time := '';
	STRING vendor_entry_date := '';
	STRING judge := '';
	STRING case_title := '';
	STRING filing_book := '';
	STRING filing_page := '';
	STRING release_date := '';
	STRING amount := '';
	STRING eviction := '';
	STRING satisifaction_type := '';
	STRING judg_satisfied_date := '';
	STRING judg_vacated_date := '';
	STRING tax_code := '';
	STRING irs_serial_number := '';
	STRING effective_date := '';
	STRING lapse_date := '';
	STRING accident_date := '';
	STRING sherrif_indc := '';
	STRING expiration_date := '';
	STRING agency :='';
	STRING agency_city :='';
	STRING agency_state :='';
	STRING agency_county :='';
	STRING legal_lot := '';
	STRING legal_block := '';
	STRING legal_borough := '';
	STRING certificate_number := '';
	BOOLEAN	bCBFlag	:=	FALSE;
	UNSIGNED8 persistent_record_id :=0 ; 
	DATASET(Liensv2.layout_liens_main_module.layout_filing_status) filing_status;
END;

get_recs_newLayout	:=	PROJECT(get_recs,new_layout_liens_main);
dist_id := distribute(get_recs_newLayout, hash(TMSID,RMSID));
sort_id := sort(dist_id, TMSID, RMSID,local);

export 	key_liens_main_ID_FCRA := index(sort_id,{tmsid,RMSID},{sort_id},
Data_Services.Data_location.Prefix('Liensv2')+'thor_data400::key::liensv2::fcra::main::TMSID.RMSID_' + doxie.Version_SuperKey);