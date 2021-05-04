//FCRA_PersonHeaderKeys & Prof Licenses
//W20200326-094002 Prod

IMPORT _Control, data_services, Header, header_quick, doxie, mdr, STD, watchdog;

export FCRA_People_Header_and_Prof_Licenses(string pHostname, string pTarget, string pContact ='\' \'', STRING today = (STRING8)STD.Date.Today()) := function

filedate := today;

rs_Key_DID_FCRA_PHDR := Doxie.Key_FCRA_Header;
ds_FCRA_Header_Quick := header_quick.Key_Did_FCRA;
base_wdog_best := watchdog.file_best;

Layout_PHDR_short :=	RECORD
		unsigned6 did;
		string2 src;
		unsigned3 dt_first_seen;
		unsigned3 dt_last_seen;
		unsigned3 dt_vendor_last_reported;
		unsigned3 dt_vendor_first_reported;
		unsigned3 dt_nonglb_last_seen;
 END;
	 
Key_DID_FCRA_PHDR := PROJECT(rs_Key_DID_FCRA_PHDR, Layout_PHDR_short) + PROJECT(ds_FCRA_Header_Quick, Layout_PHDR_short);

//DID count overall:
Key_DID_FCRA_PHDR_dedup := DEDUP(sort(distribute(Key_DID_FCRA_PHDR(did <> 0), hash(did)),did, local,skew(1.0)),did, all);

srt_wdog_best := sort(distribute(base_wdog_best, hash(did)),did,local);

//DID count overall, by Header segment:
DIDs_bySegments := JOIN(Key_DID_FCRA_PHDR_dedup, srt_wdog_best
											 ,left.did = right.did
											 ,transform({Key_DID_FCRA_PHDR_dedup, STRING10 adl_ind}, self.adl_ind := right.adl_ind; self := left)
											 ,LEFT OUTER);
															 
//DID count by Vendor/Source:
Key_DID_FCRA_PHDR_dedup_vendor := DEDUP(sort(distribute(Key_DID_FCRA_PHDR(did <> 0), hash(src, did)),src, did, local,skew(1.0)),src, did, all,local);
tbl_FCRA_PHDR_DID_by_vendor := TABLE(Key_DID_FCRA_PHDR_dedup_vendor, {src, did_count := count(group)}, src, FEW); 																				

//For Data Metrics: number of unique LexIDs, by month, with a First/Last Seen date, across all FCRA header sources, since 2010
since_date := 201001;

PHDR_FCRA_key_src_first_reported 	:= DEDUP(sort(distribute(Key_DID_FCRA_PHDR(did <> 0), hash(did)), src,did,dt_vendor_first_reported, local), src,did,dt_vendor_first_reported, all,local)((integer) dt_vendor_first_reported >= since_date);
PHDR_FCRA_key_src_last_reported 	:= DEDUP(sort(distribute(Key_DID_FCRA_PHDR(did <> 0), hash(did)), src,did, -dt_vendor_last_reported, local), src,did,dt_vendor_last_reported, all,local)((integer) dt_vendor_last_reported >= since_date);

rec_src_dates_first_reported :=	RECORD
		PHDR_FCRA_key_src_first_reported.src;
		string src_desc := Mdr.sourcetools.fTranslateSource(PHDR_FCRA_key_src_first_reported.src);
		PHDR_FCRA_key_src_first_reported.dt_vendor_first_reported;
		unsigned6	did_count := count(group);
	END;
	
tbl_src_dates_first_reported := TABLE(PHDR_FCRA_key_src_first_reported, rec_src_dates_first_reported, src,dt_vendor_first_reported, few);	

rec_src_dates_last_reported := RECORD
		PHDR_FCRA_key_src_last_reported.src;
		string src_desc := Mdr.sourcetools.fTranslateSource(PHDR_FCRA_key_src_last_reported.src);
		PHDR_FCRA_key_src_last_reported.dt_vendor_last_reported;
		unsigned6	did_count := count(group);
	END;
	
tbl_src_dates_last_reported := TABLE(PHDR_FCRA_key_src_last_reported, rec_src_dates_last_reported, src,dt_vendor_last_reported, few);	

PHDR_FCRA_key_src_first_seen 	:= DEDUP(sort(distribute(Key_DID_FCRA_PHDR(did <> 0), hash(did)), src,did,dt_first_seen, local), src,did,dt_first_seen, all,local)((integer) dt_first_seen >= since_date);
PHDR_FCRA_key_src_last_seen 	:= DEDUP(sort(distribute(Key_DID_FCRA_PHDR(did <> 0), hash(did)), src,did, -dt_last_seen, local), src,did,dt_last_seen, all,local)((integer) dt_last_seen >= since_date);

rec_src_dates_first_seen :=	RECORD
		PHDR_FCRA_key_src_first_seen.src;
		string src_desc := Mdr.sourcetools.fTranslateSource(PHDR_FCRA_key_src_first_seen.src);
		PHDR_FCRA_key_src_first_seen.dt_first_seen;
		unsigned6	did_count := count(group);
	END;
	
tbl_src_dates_first_seen := TABLE(PHDR_FCRA_key_src_first_seen, rec_src_dates_first_seen, src,dt_first_seen, few);	
srt_tbl_src_dates_first_seen := sort(tbl_src_dates_first_seen, src, -dt_first_seen);

rec_src_dates_last_seen :=	RECORD
		PHDR_FCRA_key_src_last_seen.src;
		string src_desc := Mdr.sourcetools.fTranslateSource(PHDR_FCRA_key_src_last_seen.src);
		PHDR_FCRA_key_src_last_seen.dt_last_seen;
		unsigned6	did_count := count(group);
	END;
	
tbl_src_dates_last_seen := TABLE(PHDR_FCRA_key_src_last_seen, rec_src_dates_last_seen, src,dt_last_seen, few);	
srt_tbl_src_dates_last_seen := sort(tbl_src_dates_last_seen, src, -dt_last_seen);

//Despray to bctlpedata12 (one thor file and one csv file). FTP to \\Risk\inf\Data_Factory\DI_Landingzone
despray_phdr_DIDs_Vendor_tbl := STD.File.DeSpray('~thor_data400::data_insight::data_metrics::tbl_FCRA_PHDR_countDIDs_by_vendor_'+ filedate+ '.csv',
																							 pHostname, 
																							 pTarget +  '/tbl_FCRA_PHDR_countDIDs_by_vendor_'+ filedate+ '.csv'
																							 ,,,,true);

despray_phdr_firstseen_tbl := STD.File.DeSpray('~thor_data400::data_insight::data_metrics::tbl_FCRA_PHdr_DIDs_FirstSeen_'+ filedate+ '.csv',
																							 pHostname, 
																							 pTarget +  '/tbl_FCRA_PHdr_DIDs_FirstSeen_'+ filedate+ '.csv'
																							 ,,,,true);

despray_phdr_lasttseen_tbl := STD.File.DeSpray('~thor_data400::data_insight::data_metrics::tbl_FCRA_PHdr_DIDs_LastSeen_'+ filedate+ '.csv',
																							 pHostname, 
																							 pTarget +  '/tbl_FCRA_PHdr_DIDs_LastSeen_'+ filedate+ '.csv'
																							 ,,,,true);

despray_ProLic_firstseen_tbl := STD.File.DeSpray('~thor_data400::data_insight::data_metrics::tbl_FCRA_PHdr_PLs_DIDs_FirstSeen_'+ filedate+ '.csv',
																							 pHostname, 
																							 pTarget +  '/tbl_FCRA_PHdr_PLs_DIDs_FirstSeen_'+ filedate+ '.csv'
																							 ,,,,true);

despray_ProLic_lasttseen_tbl := STD.File.DeSpray('~thor_data400::data_insight::data_metrics::tbl_FCRA_PHdr_PLs_DIDs_LastSeen_'+ filedate+ '.csv',
																							 pHostname, 
																							 pTarget +  '/tbl_FCRA_PHdr_PLs_DIDs_LastSeen_'+ filedate+ '.csv'
																							 ,,,,true);

//if everything in the Sequential statement runs, it will send the Success email, else it will send the Failure email
email_alert := SEQUENTIAL(
					output(tbl_FCRA_PHDR_DID_by_vendor,,'~thor_data400::data_insight::data_metrics::tbl_FCRA_PHDR_countDIDs_by_vendor_'+ filedate+ '.csv', csv(heading(single), separator('|'),terminator('\r\n'),quote('\"')),overwrite,expire(10))
					,output(srt_tbl_src_dates_first_seen,,'~thor_data400::data_insight::data_metrics::tbl_FCRA_PHdr_DIDs_FirstSeen_'+ filedate+ '.csv', csv(heading(single), separator('|'),terminator('\r\n'),quote('\"')),overwrite,expire(10))
					,output(srt_tbl_src_dates_last_seen,,'~thor_data400::data_insight::data_metrics::tbl_FCRA_PHdr_DIDs_LastSeen_'+ filedate+ '.csv', csv(heading(single), separator('|'),terminator('\r\n'),quote('\"')),overwrite,expire(10))
					,output(srt_tbl_src_dates_first_seen(src='PL'),,'~thor_data400::data_insight::data_metrics::tbl_FCRA_PHdr_PLs_DIDs_FirstSeen_'+ filedate+ '.csv', csv(heading(single), separator('|'),terminator('\r\n'),quote('\"')),overwrite,expire(10))
					,output(srt_tbl_src_dates_last_seen(src='PL'),,'~thor_data400::data_insight::data_metrics::tbl_FCRA_PHdr_PLs_DIDs_LastSeen_'+ filedate+ '.csv', csv(heading(single), separator('|'),terminator('\r\n'),quote('\"')),overwrite,expire(10))
					,despray_phdr_DIDs_Vendor_tbl
					,despray_phdr_firstseen_tbl
					,despray_phdr_lasttseen_tbl
					,despray_ProLic_firstseen_tbl
					,despray_ProLic_lasttseen_tbl):
					Success(FileServices.SendEmail(pContact, 'FCRA Group: FCRA_People_Header_and_Prof_Licenses Build Succeeded', workunit + ': Build complete.' + filedate)),
					Failure(FileServices.SendEmail(pContact, 'FCRA Group: FCRA_People_Header_and_Prof_Licenses Build Failed', workunit + filedate + '\n' + FAILMESSAGE)
													);
return email_alert;

end;