import bankruptcyv2, address, ut, data_services;


kfMain	 := dedup(sort(dataset('~thor_data400::base::override::fcra::qa::bankrupt_main',FCRA.layout_main_ffid_v3,csv(separator('\t'),quote('\"'),terminator('\r\n')),opt),-flag_file_id),except flag_file_id,keep(1));


file_in_sort := sort(distribute(kfMain,hash(tmsid)),TMSID,-(unsigned)id,-date_created, date_modified,court_code,court_name,court_location,case_number,orig_case_number,
							-date_filed,filing_status,orig_chapter,orig_filing_date,assets_no_asset_indicator,filer_type,-meeting_date,meeting_time,address_341,
							claims_deadline, complaint_deadline,judge_name,judges_identification,filing_jurisdiction,assets,liabilities, CaseType, 
							AssocCode, SplitCase ,FiledInError,reopen_date,case_closing_date,-date_last_seen ,date_first_seen,local);
		 

MainLayoutPlus := record
	bankruptcyv2.layout_bankruptcy_main_v3.layout_bankruptcy_main_filing;
	string20 flag_file_id;
end;


MainLayoutPlus tmakefatrecord(layout_main_ffid_v3 L) := transform

  self.status   := row(L,bankruptcyV2.Layout_bankruptcy_main_v3.layout_status);
  self.comments := row(L,bankruptcyV2.Layout_bankruptcy_main_v3.layout_comments);
  self := L;

end;

file_flat := project(file_in_sort, tmakefatrecord(left));



export key_override_bkv3_main_ffid := index (file_flat, {flag_file_id}, {file_flat}, 
data_services.data_location.prefix('fcra_overrides')+'thor_data400::key::override::fcra::bankrupt_filing::qa::ffid_v3');