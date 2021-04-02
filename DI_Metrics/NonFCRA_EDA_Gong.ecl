//NonFCRA GONG (EDA) First/Last Seen Dates
//W20200806-094037 Prod

IMPORT _Control, Gong_Neustar, MDR, STD, ut;
export NonFCRA_EDA_GONG(string pHostname, string pTarget, string pContact ='\' \'', STRING today = (STRING8)STD.Date.Today()) := function

filedate := today;

Key_Non_FCRA_Gong_History_did := PULL(Gong_Neustar.Key_History_did);
rs_Key_Non_FCRA_Gong_History_did := Key_Non_FCRA_Gong_History_did;

Non_FCRA_Gong_History_DIDs := DEDUP(sort(distribute(rs_Key_Non_FCRA_Gong_History_did(did <> 0)
													, hash(did))
										,did, -dt_last_seen,-current_record_flag,local,skew(1.0))
									,did, local);

since_date := 20100101;

Gong_Non_FCRA_key_src_first_seen 	:= DEDUP(sort(distribute(rs_Key_Non_FCRA_Gong_History_did(did <> 0), hash(src,did)), src,did,dt_first_seen, local), src,did,dt_first_seen, local)((unsigned6) dt_first_seen >= since_date);
Gong_Non_FCRA_key_src_last_seen 	:= DEDUP(sort(distribute(rs_Key_Non_FCRA_Gong_History_did(did <> 0), hash(src,did)), src,did, -dt_last_seen, local), src,did,dt_last_seen, local)((unsigned6) dt_last_seen >= since_date);

rec_src_dates_first_seen := RECORD
		Gong_Non_FCRA_key_src_first_seen.src;
		string src_desc := Mdr.sourcetools.fTranslateSource(Gong_Non_FCRA_key_src_first_seen.src);
		unsigned6 first_seen := (unsigned6) Gong_Non_FCRA_key_src_first_seen.dt_first_seen[1..6];
		unsigned6	did_count := count(group);
	END;
	
tbl_src_dates_first_seen := TABLE(Gong_Non_FCRA_key_src_first_seen, rec_src_dates_first_seen, src,dt_first_seen[1..6], MANY);	

rec_src_dates_last_seen := RECORD
		Gong_Non_FCRA_key_src_last_seen.src;
		string src_desc := Mdr.sourcetools.fTranslateSource(Gong_Non_FCRA_key_src_last_seen.src);
		unsigned6 last_seen := (unsigned6) Gong_Non_FCRA_key_src_last_seen.dt_last_seen[1..6];
		unsigned6	did_count := count(group);
	END;
	
tbl_src_dates_last_seen := TABLE(Gong_Non_FCRA_key_src_last_seen, rec_src_dates_last_seen, src,dt_last_seen[1..6], MANY);	


//Despray to bctlpedata12 (one thor file and one csv file). FTP to \\Risk\inf\Data_Factory\DI_Landingzone
despray_gong_fs_tbl := STD.File.DeSpray('~thor_data400::data_insight::data_metrics::tbl_Key_GongEDA_Non_FCRA_DIDs_FirstSeen_'+ filedate +'.csv',
																			    pHostname,  
																				pTarget + '/tbl_Key_GongEDA_Non_FCRA_DIDs_FirstSeen_'+ filedate +'.csv'
																				,,,,true);

despray_gong_ls_tbl := STD.File.DeSpray('~thor_data400::data_insight::data_metrics::tbl_Key_GongEDA_Non_FCRA_DIDs_LastSeen_'+ filedate +'.csv',
																			  pHostname,  
																			  pTarget + '/tbl_Key_GongEDA_Non_FCRA_DIDs_LastSeen_'+ filedate +'.csv'
																				,,,,true);

//if everything in the Sequential statement runs, it will send the Success email, else it will send the Failure email
email_alert := SEQUENTIAL(
					output(sort(tbl_src_dates_first_seen, -src, first_seen, skew(1.0)),,'~thor_data400::data_insight::data_metrics::tbl_Key_GongEDA_Non_FCRA_DIDs_FirstSeen_'+ filedate +'.csv', csv(heading(single), separator('|'),terminator('\r\n'),quote('\"')), overwrite, expire(10))
					,output(sort(tbl_src_dates_last_seen, -src, last_seen, skew(1.0)),,'~thor_data400::data_insight::data_metrics::tbl_Key_GongEDA_Non_FCRA_DIDs_LastSeen_'+ filedate +'.csv', csv(heading(single), separator('|'),terminator('\r\n'),quote('\"')), overwrite, expire(10))
					,despray_gong_fs_tbl
					,despray_gong_ls_tbl):
					Success(FileServices.SendEmail(pContact, 'NonFCRA Group: NonFCRA_EDA_GONG Build Succeeded', workunit + ': Build complete.' + filedate)),
					Failure(FileServices.SendEmail(pContact, 'NonFCRA Group: NonFCRA_EDA_GONG Build Failed', workunit + filedate + '\n' + FAILMESSAGE)
													);
return email_alert;

end;
