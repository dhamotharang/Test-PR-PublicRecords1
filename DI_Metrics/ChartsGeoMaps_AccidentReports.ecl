IMPORT _control,FLAccidents_Ecrash, data_services, STD; 
export ChartsGeoMaps_AccidentReports(string pHostname, string pTarget, string pContact ='\' \'', STRING today = (STRING8)STD.Date.Today()) := function

filedate := today;

Base_Ecrash := PULL(FLAccidents_Ecrash.key_EcrashV2_accnbrv1);
ddp_ecrash_did := dedup(sort(distribute(Base_Ecrash, hash(did)), did, local), did, local);
tbl_ecrash_did := table(ddp_ecrash_did, {jurisdiction_state, lexid_count := count(group)}, jurisdiction_state, few);
srt_ecrash_tbl := sort(tbl_ecrash_did,jurisdiction_state);

//Despray CSV to bctlpedata12 (one thor file and one csv file). FTP to \\Risk\inf\Data_Factory\DI_Landingzone
despray_acc_tbl := STD.File.DeSpray('~thor_data400::data_insight::data_metrics::tbl_ChartsGeoMaps_Ecrash_Accidents_By_State_'+ filedate +'.csv',
																		pHostname, 
																		pTarget+ '/tbl_ChartsGeoMaps_Ecrash_Accidents_By_State_'+ filedate +'.csv'
																		,,,,true);

//last wuid unknown

//if everything in the Sequential statement runs, it will send the Success email, else it will send the Failure email
email_alert := SEQUENTIAL(
					output(srt_ecrash_tbl,,'~thor_data400::data_insight::data_metrics::tbl_ChartsGeoMaps_Ecrash_Accidents_By_State_'+ filedate +'.csv', csv(heading(single), separator('|'),terminator('\r\n'),quote('\"')), overwrite, expire(10))
					,despray_acc_tbl):
					Success(FileServices.SendEmail(pContact, 'ChartsGeoMaps Group: ChartsGeoMaps_AccidentReports Build Succeeded', workunit + ': Build complete.' + filedate)),
					Failure(FileServices.SendEmail(pContact, 'ChartsGeoMaps Group: ChartsGeoMaps_AccidentReports Build Failed', workunit + filedate + '\n' + FAILMESSAGE)
													);
return email_alert;

end;

