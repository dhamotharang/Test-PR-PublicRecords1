import dnb_feinv2;

d01 := output(choosen(DNB_FEINv2.File_DNB_Fein_base_main(date_vendor_last_reported = max(DNB_FEINv2.File_DNB_Fein_base_main,date_vendor_last_reported)), 100), named('dnbfein_main_sample_QA'));

export New_records_sample := d01 ;
	

