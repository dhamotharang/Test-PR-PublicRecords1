import BankruptcyV2;

d01 := output(choosen(enth(sort(BankruptcyV2.file_bankruptcy_main_v3(process_date = max(BankruptcyV2.file_bankruptcy_main_v3,process_date) and trim(trusteename,left,right) <> ''),st,local),200), 200),named('BK_main_sample_QA'));
d02 := output(choosen(enth(sort(BankruptcyV2.file_bankruptcy_search_v3(date_vendor_last_reported = max(BankruptcyV2.file_bankruptcy_search_v3,date_vendor_last_reported) and trim(orig_name,left,right) <> 'PRO SE'),st,local),500), 500),named('BK_search_sample_QA'));
export New_records_sample := parallel(d01, d02);
	