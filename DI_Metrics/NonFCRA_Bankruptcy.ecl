//NonFCRA Bankruptcies
//W20200806-092200 Prod
//date_first_seen = orig_filing_date
//date_last_seen = case_closing_date or date of last action in the case
//process_date = date_vendor_last_reported = date of last update

IMPORT _control, BankruptcyV2, BankruptcyV3, data_services, STD, ut;
export NonFCRA_Bankruptcy(string pHostname, string pTarget, string pContact ='\' \'', STRING today = (STRING8)STD.Date.Today()) := function

filedate := today;

Key_BKv3_Non_FCRA_main := PULL(BankruptcyV3.key_bankruptcyV3_main_full(false));

layout_filing_period := RECORD
		Key_BKv3_Non_FCRA_main;
		integer4 filing_period;
END;
	
Key_BKv3_Non_FCRA := PROJECT(Key_BKv3_Non_FCRA_main, transform(layout_filing_period
					, self.filing_period := (integer4) left.date_first_seen[1..6]
					, self := left));
Key_BKv3_Non_FCRA_2010 := Key_BKv3_Non_FCRA((integer4) date_first_seen[1..4] >= 2010, source = 'L');
Key_BKv3_Non_FCRA_2010_filings := DEDUP(sort(distribute(Key_BKv3_Non_FCRA_2010, hash (filing_period, filing_jurisdiction, tmsid)), filing_period, filing_jurisdiction, tmsid, orig_chapter, filing_status, filer_type, local), filing_period, filing_jurisdiction, tmsid, orig_chapter, local);
tbl_Key_BKv3_Non_FCRA_2010_filings := TABLE(Key_BKv3_Non_FCRA_2010_filings, {filing_period,filing_jurisdiction, orig_chapter,filing_status,filer_type, tmsid_count := count(group)}, filing_period,filing_jurisdiction, orig_chapter,filing_status,filer_type, MANY);
srt_tbl_Key_BKv3_Non_FCRA_2010_filings := sort(tbl_Key_BKv3_Non_FCRA_2010_filings, -filing_period, filing_jurisdiction, orig_chapter, filing_status, filer_type, skew(1.0));

//Despray to bctlpedata12 (one thor file and one csv file). FTP to \\Risk\inf\Data_Factory\DI_Landingzone
despray_bk_tbl := STD.File.DeSpray('~thor_data400::data_insight::data_metrics::tbl_Key_BKv3_Non_FCRA_2010_Filings_by_Chapter_'+ filedate +'.csv',
																	 pHostname, 
																	 pTarget + '/tbl_Key_BKv3_Non_FCRA_2010_Filings_by_Chapter_'+ filedate +'.csv'
																	 //charlene's team will create the monthly folder yyyymmdd otherwise HPCC creates the folder
																	 ,,,,true);

//if everything in the Sequential statement runs, it will send the Success email, else it will send the Failure email
email_alert := SEQUENTIAL(
					output(srt_tbl_Key_BKv3_Non_FCRA_2010_filings,,'~thor_data400::data_insight::data_metrics::tbl_Key_BKv3_Non_FCRA_2010_Filings_by_Chapter_'+ filedate +'.csv'
					,csv(heading(single), separator('|'),terminator('\r\n'),quote('\"')), overwrite, expire(10))
					,despray_bk_tbl):
					Success(FileServices.SendEmail(pContact, 'NonFCRA Group: NonFCRA_Bankruptcy Build Succeeded', workunit + ': Build complete.' + filedate)),
					Failure(FileServices.SendEmail(pContact, 'NonFCRA Group: NonFCRA_Bankruptcy Build Failed', workunit + filedate + '\n' + FAILMESSAGE)
													);
return email_alert;

end;