//FCRA GONG (EDA) First/Last Seen Dates
//W20200326-093806 Prod

IMPORT _Control, Gong_Neustar, data_services, MDR, STD, ut;

export FCRA_EDA_GONG(string pHostname, string pTarget, string pContact ='\' \'', STRING today = (STRING8)STD.Date.Today()) := function

filedate := today;

rs_Key_FCRA_Gong_History_did := Gong_Neustar.Key_FCRA_History_did;

FCRA_Gong_History_DIDs := DEDUP(sort(distribute(rs_Key_FCRA_Gong_History_did(did <> 0), hash(did))
																,did, -dt_last_seen,-current_record_flag,local,skew(1.0)),did, all,local);

OUTPUT(TABLE(FCRA_Gong_History_DIDs, {current_record_flag, did_count := count(group)},current_record_flag,few),all, named('FCRA_Gong_History_count_DIDs_byCurrentFlag'));

since_date := 20100101;

Gong_FCRA_key_src_first_seen 	:= DEDUP(sort(distribute(rs_Key_FCRA_Gong_History_did(did <> 0), hash(did)), src,did,dt_first_seen, local), src,did,dt_first_seen, all,local)((unsigned6) dt_first_seen >= since_date);
Gong_FCRA_key_src_last_seen 	:= DEDUP(sort(distribute(rs_Key_FCRA_Gong_History_did(did <> 0), hash(did)), src,did, -dt_last_seen, local), src,did,dt_last_seen, all,local)((unsigned6) dt_last_seen >= since_date);

rec_src_dates_first_seen := RECORD
		Gong_FCRA_key_src_first_seen.src;
		string src_desc := Mdr.sourcetools.fTranslateSource(Gong_FCRA_key_src_first_seen.src);
		unsigned6 first_seen := (unsigned6) Gong_FCRA_key_src_first_seen.dt_first_seen[1..6];
		unsigned6	did_count := count(group);
	END;
	
tbl_src_dates_first_seen := TABLE(Gong_FCRA_key_src_first_seen, rec_src_dates_first_seen, src,dt_first_seen[1..6], few);	

rec_src_dates_last_seen := RECORD
		Gong_FCRA_key_src_last_seen.src;
		string src_desc := Mdr.sourcetools.fTranslateSource(Gong_FCRA_key_src_last_seen.src);
		unsigned6 last_seen := (unsigned6) Gong_FCRA_key_src_last_seen.dt_last_seen[1..6];
		unsigned6	did_count := count(group);
	END;
	
tbl_src_dates_last_seen := TABLE(Gong_FCRA_key_src_last_seen, rec_src_dates_last_seen, src,dt_last_seen[1..6], few);	

//Despray to bctlpedata12 (one thor file and one csv file). FTP to \\Risk\inf\Data_Factory\DI_Landingzone
despray_gong_fs_tbl := STD.File.DeSpray('~thor_data400::data_insight::data_metrics::tbl_Key_GongEDA_FCRA_DIDs_FirstSeen_'+ filedate +'.csv',
																			  pHostname, 
																			  pTarget + '/tbl_Key_GongEDA_FCRA_DIDs_FirstSeen_'+ filedate +'.csv'
																			  ,,,,true);

despray_gong_ls_tbl := STD.File.DeSpray('~thor_data400::data_insight::data_metrics::tbl_Key_GongEDA_FCRA_DIDs_LastSeen_'+ filedate +'.csv',
																			  pHostname, 
																			  pTarget + '/tbl_Key_GongEDA_FCRA_DIDs_LastSeen_'+ filedate +'.csv'
																			  ,,,,true);


//if everything in the Sequential statement runs, it will send the Success email, else it will send the Failure email
email_alert := SEQUENTIAL(
					output(sort(tbl_src_dates_first_seen, src, -first_seen, skew(1.0)),,'~thor_data400::data_insight::data_metrics::tbl_Key_GongEDA_FCRA_DIDs_FirstSeen_'+ filedate +'.csv', csv(heading(single), separator('|'),terminator('\r\n'),quote('\"')), overwrite, expire(10))
					,output(sort(tbl_src_dates_last_seen, src, -last_seen, skew(1.0)),,'~thor_data400::data_insight::data_metrics::tbl_Key_GongEDA_FCRA_DIDs_LastSeen_'+ filedate +'.csv', csv(heading(single), separator('|'),terminator('\r\n'),quote('\"')), overwrite, expire(10))
					,despray_gong_fs_tbl
					,despray_gong_ls_tbl):
					Success(FileServices.SendEmail(pContact, 'FCRA Group: FCRA_EDA_GONG Build Succeeded', workunit + ': Build complete.' + filedate)),
					Failure(FileServices.SendEmail(pContact, 'FCRA Group: FCRA_EDA_GONG Build Failed', workunit + filedate + '\n' + FAILMESSAGE)
													);
return email_alert;

end;