//Bankruptcies
//W20200326-170341 Prod
//date_first_seen = orig_filing_date
//date_last_seen = case_closing_date or date of last action in the case
//process_date = date_vendor_last_reported = date of last update

IMPORT _Control, BankruptcyV2, BankruptcyV3, data_services, STD, ut;

export FCRA_Bankruptcy(string pHostname, string pTarget, string pContact ='\' \'', STRING today = (STRING8)STD.Date.Today()) := function

filedate := today;

// BKv3_base := BankruptcyV2.file_bankruptcy_main_v3;
// Key_BKv3_FCRA_main := INDEX(BKv3_base,{string50 tmsid},{BKv3_base} - [tmsid,scrubsbits1], data_services.foreign_prod+'thor_data400::key::bankruptcyv3::fcra::main::tmsid_qa');

Key_BKv3_FCRA_main := BankruptcyV3.key_bankruptcyV3_main_full(true);

layout_filing_period :=	RECORD
		Key_BKv3_FCRA_main;
		integer4 filing_period;
END;
	
Key_BKv3_FCRA := PROJECT(Key_BKv3_FCRA_main, transform(layout_filing_period, self.filing_period := (integer4) left.date_first_seen[1..6], self := left));
Key_BKv3_FCRA_2010 := Key_BKv3_FCRA((integer4) date_first_seen[1..4] >= 2010, source = 'L');
Key_BKv3_FCRA_2010_filings := DEDUP(sort(distribute(Key_BKv3_FCRA_2010, hash(tmsid)), filing_period,filing_jurisdiction, tmsid, orig_chapter,filing_status,filer_type, local), filing_period,filing_jurisdiction, tmsid, orig_chapter, all,local);
tbl_Key_BKv3_FCRA_2010_filings := TABLE(Key_BKv3_FCRA_2010_filings, {filing_period,filing_jurisdiction, orig_chapter,filing_status,filer_type, tmsid_count := count(group)}, filing_period,filing_jurisdiction, orig_chapter,filing_status,filer_type, few);

//Despray to bctlpedata12 (one thor file and one csv file). FTP to \\Risk\inf\Data_Factory\DI_Landingzone
despray_bk_tbl := STD.File.DeSpray('~thor_data400::data_insight::data_metrics::tbl_Key_BKV3_FCRA_2010_filings_by_Chapter_'+ filedate +'.csv',
																	 pHostname, 
																	 pTarget + '/tbl_Key_BKV3_FCRA_2010_filings_by_Chapter_'+ filedate +'.csv'
																	  //charlene's team will create the monthly folder yyyymmdd otherwise HPCC creates the folder
																	 ,,,,true);

//if everything in the Sequential statement runs, it will send the Success email, else it will send the Failure email
email_alert := SEQUENTIAL(
					output(tbl_Key_BKv3_FCRA_2010_filings,,'~thor_data400::data_insight::data_metrics::tbl_Key_BKV3_FCRA_2010_filings_by_Chapter_'+ filedate +'.csv'
					,csv(heading(single), separator('|'),terminator('\r\n'),quote('\"')), overwrite, expire(10))
					,despray_bk_tbl):
					Success(FileServices.SendEmail(pContact, 'FCRA Group: FCRA_Bankruptcy Build Succeeded', workunit + ': Build complete.' + filedate)),
					Failure(FileServices.SendEmail(pContact, 'FCRA Group: FCRA_Bankruptcy Build Failed', workunit + filedate + '\n' + FAILMESSAGE)
													);
return email_alert;

end;