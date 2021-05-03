IMPORT _control, DriversV2, data_services, STD; 
export ChartsGeoMaps_DriversLicenses(string pHostname, string pTarget, string pContact ='\' \'', STRING today = (STRING8)STD.Date.Today()) := function

filedate := today;

base_dls := DriversV2.File_DL_Search;
ddp_dls_dids := dedup(sort(distribute(base_dls, hash(did)), did, local), did, local);
tbl_dls_dids := table(ddp_dls_dids, {orig_state, did_count := count(group)}, orig_state, few);
srt_tbl_dids := sort(tbl_dls_dids, orig_state);

//Despray CSV to bctlpedata12 (one thor file and one csv file). FTP to \\Risk\inf\Data_Factory\DI_Landingzone
despray_dls_tbl := STD.File.DeSpray('~thor_data400::data_insight::data_metrics::tbl_ChartsGeoMaps_Drivers_Licenses_by_State_'+ filedate +'.csv',
																		pHostname, 
																		pTarget+ '/tbl_ChartsGeoMaps_Drivers_Licenses_by_State_'+ filedate +'.csv'
																		,,,,true);

//Jessica's last WUID: W20190219-124007

//if everything in the Sequential statement runs, it will send the Success email, else it will send the Failure email
email_alert := SEQUENTIAL(
					output(srt_tbl_dids,,'~thor_data400::data_insight::data_metrics::tbl_ChartsGeoMaps_Drivers_Licenses_by_State_'+ filedate +'.csv', csv(heading(single), separator('|'),terminator('\r\n'),quote('\"')), overwrite, expire(10))
					,despray_dls_tbl):
					Success(FileServices.SendEmail(pContact, 'ChartsGeoMaps Group: ChartsGeoMaps_DriversLicenses Build Succeeded', workunit + ': Build complete.' + filedate)),
					Failure(FileServices.SendEmail(pContact, 'ChartsGeoMaps Group: ChartsGeoMaps_DriversLicenses Build Failed', workunit + filedate + '\n' + FAILMESSAGE)
													);
return email_alert;

end;