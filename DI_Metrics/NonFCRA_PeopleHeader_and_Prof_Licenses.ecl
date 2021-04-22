//NonFCRA_PersonHeaderKeys & Prof Licenses
//W20200806-095657 Prod

IMPORT _Control, doxie, header_quick, watchdog, data_services, mdr, std, ut;
EXPORT NonFCRA_PeopleHeader_and_Prof_Licenses(string pHostname, string pTarget, string pContact ='\' \'', STRING today = (STRING8)STD.Date.Today()) := function
#OPTION('multiplePersistInstances',FALSE); 

filedate := today;

//person header key
rs_Key_DID_PHDR := PULL(doxie.key_header);
//quick header key
ds_Header_Quick := PULL(header_quick.key_DID);
//watchdog base file
base_wdog_best := watchdog.file_best;

Layout_PHDR_short := RECORD
		unsigned6 did;
		string2 src;
		unsigned3 dt_first_seen;
		unsigned3 dt_last_seen;
		unsigned3 dt_vendor_last_reported;
		unsigned3 dt_vendor_first_reported;
		unsigned3 dt_nonglb_last_seen;
	 END;
	 
Key_DID_PHDR := PROJECT(rs_Key_DID_PHDR, Layout_PHDR_short) + PROJECT(ds_Header_Quick, Layout_PHDR_short);

//DID count overall:
Key_DID_PHDR_dedup := DEDUP(sort(distribute(Key_DID_PHDR(did <> 0), hash(did)),did, local, skew(1.0)), did, local);

srt_best_file  := sort(distribute(base_wdog_best, hash(did)),did,local,skew(1.0));

//DID count overall, by Header segment:
DIDs_bySegments := JOIN(Key_DID_PHDR_dedup,srt_best_file,
						left.did = right.did
						,transform({Key_DID_PHDR_dedup, STRING10 adl_ind}, self.adl_ind := right.adl_ind; self := left)
						,LEFT OUTER);

//DID count by Vendor/Source:
Key_DID_PHDR_dedup_vendor := DEDUP(sort(distribute(Key_DID_PHDR(did <> 0), hash(src, did)),src, did, local,skew(1.0)),src, did, local);
tbl_PHDR_DID_by_vendor := TABLE(Key_DID_PHDR_dedup_vendor, {src, did_count := count(group)}, src, FEW); 																				

//For Data Metrics:  number of unique LexIDs, by month, with a First/Last Seen date, across all FCRA header sources, since 2010
since_date := 201001;

PHDR_key_src_first_reported := DEDUP(sort(distribute(Key_DID_PHDR(did <> 0), hash(src, did)), src, did, -dt_vendor_first_reported, local), src,did,dt_vendor_first_reported, local)((integer) dt_vendor_first_reported >= since_date);
PHDR_key_src_last_reported 	:= DEDUP(sort(distribute(Key_DID_PHDR(did <> 0), hash(src, did)), src, did, -dt_vendor_last_reported, local), src,did,dt_vendor_last_reported, local)((integer) dt_vendor_last_reported >= since_date);

rec_src_dates_first_reported := RECORD
		PHDR_key_src_first_reported.src;
		string src_desc := Mdr.sourcetools.fTranslateSource(PHDR_key_src_first_reported.src);
		PHDR_key_src_first_reported.dt_vendor_first_reported;
		unsigned6	did_count := count(group);
	END;
	
tbl_src_dates_first_reported := TABLE(PHDR_key_src_first_reported, rec_src_dates_first_reported, src,dt_vendor_first_reported, MANY);	

rec_src_dates_last_reported := RECORD
		PHDR_key_src_last_reported.src;
		string src_desc := Mdr.sourcetools.fTranslateSource(PHDR_key_src_last_reported.src);
		PHDR_key_src_last_reported.dt_vendor_last_reported;
		unsigned6	did_count := count(group);
	END;
	
tbl_src_dates_last_reported := TABLE(PHDR_key_src_last_reported, rec_src_dates_last_reported, src,dt_vendor_last_reported, MANY);	


PHDR_key_src_first_seen := DEDUP(sort(distribute(Key_DID_PHDR(did <> 0), hash(src, did)), src, did, -dt_first_seen, local), src,did,dt_first_seen, local)((integer) dt_first_seen >= since_date);
PHDR_key_src_last_seen 	:= DEDUP(sort(distribute(Key_DID_PHDR(did <> 0), hash(src, did)), src, did, -dt_last_seen, local), src,did,dt_last_seen, local)((integer) dt_last_seen >= since_date);

rec_src_dates_first_seen := RECORD
		PHDR_key_src_first_seen.src;
		string src_desc := Mdr.sourcetools.fTranslateSource(PHDR_key_src_first_seen.src);
		PHDR_key_src_first_seen.dt_first_seen;
		unsigned6	did_count := count(group);
	END;
	
tbl_src_dates_first_seen := TABLE(PHDR_key_src_first_seen, rec_src_dates_first_seen, src,dt_first_seen, MANY);	
srt_tbl_src_dates_first_seen := sort(tbl_src_dates_first_seen,src,-dt_first_seen);

rec_src_dates_last_seen := RECORD
		PHDR_key_src_last_seen.src;
		string src_desc := Mdr.sourcetools.fTranslateSource(PHDR_key_src_last_seen.src);
		PHDR_key_src_last_seen.dt_last_seen;
		unsigned6	did_count := count(group);
	END;
	
tbl_src_dates_last_seen := TABLE(PHDR_key_src_last_seen, rec_src_dates_last_seen, src,dt_last_seen, MANY);	
srt_tbl_src_dates_last_seen := sort(tbl_src_dates_last_seen,src,-dt_last_seen);

//Despray to bctlpedata12 (one thor file and one csv file). FTP to \\Risk\inf\Data_Factory\DI_Landingzone
despray_hdr_vnd_tbl := STD.File.DeSpray('~thor_data400::data_insight::data_metrics::Key_DID_PHDR_countDIDs_by_vendor_'+ filedate +'.csv',
																				pHostname, 
																				pTarget +'/Key_DID_PHDR_countDIDs_by_vendor_'+ filedate +'.csv'
																				,,,,true);

despray_hdr_fs_tbl := STD.File.DeSpray('~thor_data400::data_insight::data_metrics::tbl_Key_PHdr_Non_FCRA_DIDs_FirstSeen_'+ filedate +'.csv',
																				pHostname, 
																				pTarget +'/tbl_Key_PHdr_Non_FCRA_DIDs_FirstSeen_'+ filedate +'.csv'
																				,,,,true);

despray_hdr_ls_tbl := STD.File.DeSpray('~thor_data400::data_insight::data_metrics::tbl_Key_PHdr_Non_FCRA_DIDs_LastSeen_'+ filedate +'.csv',
																				pHostname, 
																				pTarget +'/tbl_Key_PHdr_Non_FCRA_DIDs_LastSeen_'+ filedate +'.csv'
																				,,,,true);
																				
despray_pls_fs_tbl := STD.File.DeSpray('~thor_data400::data_insight::data_metrics::tbl_Key_PHdr_PLs_Non_FCRA_DIDs_FirstSeen_'+ filedate +'.csv',
																			 pHostname, 
																			 pTarget +'/tbl_Key_PHdr_PLs_Non_FCRA_DIDs_FirstSeen_'+ filedate +'.csv'
																			 ,,,,true);

despray_pls_ls_tbl := STD.File.DeSpray('~thor_data400::data_insight::data_metrics::tbl_Key_PHdr_PLs_Non_FCRA_DIDs_LastSeen_'+ filedate +'.csv',
																			 pHostname, 
																			 pTarget +'/tbl_Key_PHdr_PLs_Non_FCRA_DIDs_LastSeen_'+ filedate +'.csv'
																			 ,,,,true);

//if everything in the Sequential statement runs, it will send the Success email, else it will send the Failure email
email_alert := SEQUENTIAL(
					output(tbl_PHDR_DID_by_vendor,,'~thor_data400::data_insight::data_metrics::Key_DID_PHDR_countDIDs_by_vendor_'+ filedate +'.csv', csv(heading(single), separator('|'),terminator('\r\n'),quote('\"')), overwrite, expire(10))
					,output(srt_tbl_src_dates_first_seen,,'~thor_data400::data_insight::data_metrics::tbl_Key_PHdr_Non_FCRA_DIDs_FirstSeen_'+ filedate +'.csv', csv(heading(single), separator('|'),terminator('\r\n'),quote('\"')), overwrite, expire(10))
					,output(srt_tbl_src_dates_last_seen,,'~thor_data400::data_insight::data_metrics::tbl_Key_PHdr_Non_FCRA_DIDs_LastSeen_'+ filedate +'.csv', csv(heading(single), separator('|'),terminator('\r\n'),quote('\"')), overwrite, expire(10))
					,output(srt_tbl_src_dates_first_seen(src='PL'),,'~thor_data400::data_insight::data_metrics::tbl_Key_PHdr_PLs_Non_FCRA_DIDs_FirstSeen_'+ filedate +'.csv', csv(heading(single), separator('|'),terminator('\r\n'),quote('\"')), overwrite, expire(10))
					,output(srt_tbl_src_dates_last_seen(src='PL'),,'~thor_data400::data_insight::data_metrics::tbl_Key_PHdr_PLs_Non_FCRA_DIDs_LastSeen_'+ filedate +'.csv', csv(heading(single), separator('|'),terminator('\r\n'),quote('\"')), overwrite, expire(10))
					,despray_hdr_vnd_tbl
					,despray_hdr_fs_tbl
					,despray_hdr_ls_tbl
					,despray_pls_fs_tbl
					,despray_pls_ls_tbl):
					Success(FileServices.SendEmail(pContact, 'NonFCRA Group: NonFCRA_PeopleHeader_and_Prof_Licenses Build Succeeded', workunit + ': Build complete.' + filedate)),
					Failure(FileServices.SendEmail(pContact, 'NonFCRA Group: NonFCRA_PeopleHeader_and_Prof_Licenses Build Failed', workunit + filedate + '\n' + FAILMESSAGE)
													);
return email_alert;

end;