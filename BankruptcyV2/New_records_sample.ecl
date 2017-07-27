import BankruptcyV2;

d01 := output(choosen(BankruptcyV2.file_bankruptcy_main(process_date = max(BankruptcyV2.file_bankruptcy_main,process_date)), 100),named('BK_main_sample_QA'));
d02 := output(choosen(BankruptcyV2.file_bankruptcy_search(date_vendor_last_reported = max(BankruptcyV2.file_bankruptcy_search,date_vendor_last_reported)), 100),named('BK_search_sample_QA'));
export New_records_sample := parallel(d01, d02);
	