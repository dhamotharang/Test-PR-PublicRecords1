//# of new LexIDs added to the PAW file 
//W20200326-093934 Prod
//For the following events, I would like the number of new events by type by month by state back to 2010. This data should be created using only data on the FCRA Roxies

IMPORT _Control, data_services, PAW, STD, ut;

export FCRA_PAW(string pHostname, string pTarget, string pContact ='\' \'', STRING today = (STRING8)STD.Date.Today()) := function

filedate := today;

Key_PAW_FCRA := PAW.Key_DID_FCRA;

Key_PAW_FCRA_2010 := PROJECT(Key_PAW_FCRA((integer4) dt_first_seen[1..4] >= 2010) //between 2010 and 2016)
															, transform({Key_PAW_FCRA, integer4 first_seen}
																					, self.first_seen := (integer4) left.dt_first_seen[1..6]
																					, self.state := IF(left.state = '',left.company_state,left.state)
																					, self.company_title := stringlib.stringcleanspaces(left.company_title)
																					, self := left));

Key_PAW_FCRA_2010_DIDs := DEDUP(sort(distribute(Key_PAW_FCRA_2010, hash(did)), did,dt_first_seen, local), did, all,local);
tbl_Key_PAW_FCRA_2010_DIDs := TABLE(Key_PAW_FCRA_2010_DIDs, {first_seen, state, did_count := count(group)}, first_seen,state, few);

//Despray to bctlpedata12 (one thor file and one csv file). FTP to \\Risk\inf\Data_Factory\DI_Landingzone
despray_paw_tbl := STD.File.DeSpray('~thor_data400::data_insight::data_metrics::tbl_Key_PAW_FCRA_2010_DIDs_'+ filedate +'.csv',
																		pHostname, 
																		pTarget + '/tbl_Key_PAW_FCRA_2010_DIDs_'+ filedate +'.csv'
																		,,,,true);

//if everything in the Sequential statement runs, it will send the Success email, else it will send the Failure email
email_alert := SEQUENTIAL(
					output(sort(tbl_Key_PAW_FCRA_2010_DIDs, -first_seen, state, skew(1.0)),,'~thor_data400::data_insight::data_metrics::tbl_Key_PAW_FCRA_2010_DIDs_'+ filedate +'.csv', csv(heading(single), separator('|'),terminator('\r\n'),quote('\"')), overwrite, expire(10))
					,despray_paw_tbl):
					Success(FileServices.SendEmail(pContact, 'FCRA Group: FCRA_PAW Build Succeeded', workunit + ': Build complete.' + filedate)),
					Failure(FileServices.SendEmail(pContact, 'FCRA Group: FCRA_PAW Build Failed', workunit + filedate + '\n' + FAILMESSAGE)
													);
return email_alert;

end;