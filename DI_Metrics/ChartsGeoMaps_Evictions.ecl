IMPORT _control, LiensV2, Email_DataV2, data_services, STD, ut; 
export ChartsGeoMaps_Evictions(string pHostname, string pTarget, string pContact ='\' \'', STRING today = (STRING8)STD.Date.Today()) := function

filedate := today;

//Evictions from Non FCRA Liens Key 
Key_LiensV2_main := Pull(LiensV2.key_liens_main_ID(eviction = 'Y'));

layout_filing_period :=	RECORD
		Key_LiensV2_main;
		integer4 filing_period;
	END;
	
Key_LiensV2 := PROJECT(Key_LiensV2_main, transform(layout_filing_period
																				, self.filing_period := (integer4) left.orig_filing_date[1..4]
																				, self := left));

Evics_2010 := Key_LiensV2(tmsid[1..2] = 'HG');
Evics_2010_filings := dedup(sort(distribute(Evics_2010, hash(filing_jurisdiction, tmsid, rmsid))
							, filing_jurisdiction, tmsid,rmsid, local), filing_jurisdiction, tmsid, local);

tbl_evic_st := table(Evics_2010_filings, {filing_jurisdiction, tmsid_count := count(group)}, filing_jurisdiction, few);
srt_tbl_evic_st := sort(tbl_evic_st,filing_jurisdiction);

tbl_evic_yr := table(Evics_2010_filings, {filing_jurisdiction, filing_period, tmsid_count := count(group)}, filing_period, filing_jurisdiction, many);
srt_tbl_evic_yr := sort(tbl_evic_yr,filing_period,filing_jurisdiction);

//Despray CSV to bctlpedata12 (one thor file and one csv file). FTP to \\Risk\inf\Data_Factory\DI_Landingzone
despray_state_tbl := STD.File.DeSpray('~thor_data400::data_insight::data_metrics::tbl_ChartsGeoMaps_Evictions_By_Jurisdiction_'+ filedate +'.csv',
																			pHostname, 
																			pTarget + '/tbl_ChartsGeoMaps_Evictions_By_Jurisdiction_'+ filedate +'.csv'
																			//charlene's team will create the monthly folder yyyymmdd otherwise HPCC creates the folder
																			,,,,true);

despray_year_tbl := STD.File.DeSpray('~thor_data400::data_insight::data_metrics::tbl_ChartsGeoMaps_Evictions_By_Year_Jurisdiction_'+ filedate +'.csv',
																			pHostname, 
																			pTarget + '/tbl_ChartsGeoMaps_Evictions_By_Year_Jurisdiction_'+ filedate +'.csv'
																			//charlene's team will create the monthly folder yyyymmdd otherwise HPCC creates the folder
																			,,,,true);

//Jessica's last WUIDds (prod); very similar to Non FCRA LJ&E Statistical Report (what is diff?)
//State Total Counts & Geo Map: W20190204-123033 
//Record Counts by Year & Tables: W20190204-123757

//if everything in the Sequential statement runs, it will send the Success email, else it will send the Failure email
email_alert := SEQUENTIAL(
					output(srt_tbl_evic_st,,'~thor_data400::data_insight::data_metrics::tbl_ChartsGeoMaps_Evictions_By_Jurisdiction_'+ filedate +'.csv'
					, csv(heading(single), separator('|'),terminator('\r\n'),quote('\"')), overwrite, expire(10))
					,output(srt_tbl_evic_yr,,'~thor_data400::data_insight::data_metrics::tbl_ChartsGeoMaps_Evictions_By_Year_Jurisdiction_'+ filedate +'.csv'
					, csv(heading(single), separator('|'),terminator('\r\n'),quote('\"')), overwrite, expire(10))
					,despray_state_tbl
					,despray_year_tbl):
					Success(FileServices.SendEmail(pContact, 'ChartsGeoMaps Group: ChartsGeoMaps_Evictions Build Succeeded', workunit + ': Build complete.' + filedate)),
					Failure(FileServices.SendEmail(pContact, 'ChartsGeoMaps Group: ChartsGeoMaps_Evictions Build Failed', workunit + filedate + '\n' + FAILMESSAGE)
													);
return email_alert;

end;