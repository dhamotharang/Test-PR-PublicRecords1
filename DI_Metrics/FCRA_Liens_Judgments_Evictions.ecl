//Liens & Judgments
//For the following events, I would like the number of new events by type by month by state back to 2010. This data should be created using only data on the FCRA Roxies
//W20200326-093905 Prod

IMPORT _Control, LiensV2, data_services, STD, ut; 

export FCRA_Liens_Judgments_Evictions(string pHostname, string pTarget, string pContact ='\' \'', STRING today = (STRING8)STD.Date.Today()) := function

filedate := today;

//thor_data400::key::liensv2::fcra::20141219::main::tmsid.rmsid
Key_LiensV2_FCRA_main := LiensV2.key_liens_main_ID_FCRA;

layout_filing_period :=	RECORD
		Key_LiensV2_FCRA_main;
		integer4 filing_period;
		integer4 release_period;
		string	filing_type_name;
	END;
	
Key_LiensV2_FCRA := PROJECT(Key_LiensV2_FCRA_main, 
														transform(layout_filing_period
																			, self.filing_period := (integer4) left.orig_filing_date[1..6]
																			, self.release_period := (integer4) left.release_date[1..6]
																			, self.filing_type_name := map(left.release_date = ''	=>	left.filing_type_desc
																																			,regexfind('RELEASE',left.filing_type_desc)	=>	trim(regexreplace('RELEASE',left.filing_type_desc,''), left,right)
																																			,left.filing_type_desc)																							
																			, self := left));
																																					
Key_LiensV2_FCRA_2010 := Key_LiensV2_FCRA((integer4) orig_filing_date[1..4] >= 2010, tmsid[1..2] = 'HG');
Key_LiensV2_FCRA_2010_filings := DEDUP(sort(distribute(Key_LiensV2_FCRA_2010, hash(tmsid)), filing_period,release_period, filing_jurisdiction, tmsid,rmsid,filing_type_name, local), filing_period,filing_jurisdiction, tmsid,filing_type_name, all,local);

tbl_Key_LiensV2_FCRA_2010_filings := TABLE(Key_LiensV2_FCRA_2010_filings, {filing_period,release_period,filing_jurisdiction, filing_type_name, eviction, tmsid_count := count(group)}, filing_period,release_period,filing_jurisdiction, filing_type_name, eviction, few);

//Despray to bctlpedata12 (one thor file and one csv file). FTP to \\Risk\inf\Data_Factory\DI_Landingzone
despray_evic_tbl := STD.File.DeSpray('~thor_data400::data_insight::data_metrics::tbl_Key_LiensV2_FCRA_2010_filings_by_FilingType_'+ filedate +'.csv',
																			  pHostname, 
																			  pTarget + '/tbl_Key_LiensV2_FCRA_2010_filings_by_FilingType_'+ filedate +'.csv'
																				,,,,true);

//if everything in the Sequential statement runs, it will send the Success email, else it will send the Failure email
email_alert := SEQUENTIAL(
					output(sort(tbl_Key_LiensV2_FCRA_2010_filings, filing_period, release_period, filing_jurisdiction, filing_type_name, eviction, skew(1.0)),,'~thor_data400::data_insight::data_metrics::tbl_Key_LiensV2_FCRA_2010_filings_by_FilingType_'+ filedate +'.csv', csv(heading(single), separator('|'),terminator('\r\n'),quote('\"')), overwrite, expire(10))
					,despray_evic_tbl):
					Success(FileServices.SendEmail(pContact, 'FCRA Group: FCRA_Liens_Judgements_Evictions Build Succeeded', workunit + ': Build complete.' + filedate)),
					Failure(FileServices.SendEmail(pContact, 'FCRA Group: FCRA_Liens_Judgements_Evictions Build Failed', workunit + filedate + '\n' + FAILMESSAGE)
													);
return email_alert;

end;