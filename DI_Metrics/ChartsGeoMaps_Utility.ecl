IMPORT _control,UtilFile, data_services, STD;
export ChartsGeoMaps_Utility(string pHostname, string pTarget, string pContact ='\' \'', STRING today = (STRING8)STD.Date.Today()) := function

filedate := today;

utility_full := dataset(data_services.foreign_prod +'thor_data400::base::utility_file', UtilFile.layout_util.base, flat);
utility_did := dataset(data_services.foreign_prod + 'thor_data400::base::utility_DID', UtilFile.Layout_DID_Out, flat);

//All by Address State
tbl_util_st  := table(utility_full, {st, total:=count(group)}, st, few);
srt_util_tbl := sort(tbl_util_st, -total);

//All by Address State & Adddress Type; B=Billing; S=Service
tbl_addr_type := table(utility_full, {st, addr_type, total:=count(group)}, st, addr_type, few);
srt_addr_tbl := sort(tbl_addr_type, -total);

//Despray CSV to bctlpedata12 (one thor file and one csv file). FTP to \\Risk\inf\Data_Factory\DI_Landingzone
despray_util_tbl := STD.File.DeSpray('~thor_data400::data_insight::data_metrics::tbl_ChartsGeoMaps_Utility_By_State_'+ filedate +'.csv',
																			pHostname, 
																			pTarget+ '/tbl_ChartsGeoMaps_Utility_By_State_'+ filedate +'.csv'
																			,,,,true);

/*despray_addr_tbl := STD.File.DeSpray('~thor_data400::data_insight::data_metrics::tbl_ChartsGeoMaps_Utility_By_State_AddrType_'+ filedate +'.csv',
																			pHostname, 
																			pTarget+ '/tbl_ChartsGeoMaps_Utility_By_State_AddrType_'+ filedate +'.csv'
																			,,,,true);*/

//Jessica's last WUID: W20171023-154040, a salt profile

//if everything in the Sequential statement runs, it will send the Success email, else it will send the Failure email
email_alert := SEQUENTIAL(
					output(srt_util_tbl,,'~thor_data400::data_insight::data_metrics::tbl_ChartsGeoMaps_Utility_By_State_'+ filedate +'.csv', csv(heading(single), separator('|'),terminator('\r\n'),quote('\"')), overwrite, expire(10))
					//,output(srt_addr_tbl,,'~thor_data400::data_insight::data_metrics::tbl_ChartsGeoMaps_Utility_By_State_AddrType_'+ filedate +'.csv', csv(heading(single), separator('|'),terminator('\r\n'),quote('\"')), overwrite, expire(10))
					,despray_util_tbl
					//,despray_addr_tbl
					):
					Success(FileServices.SendEmail(pContact, 'ChartsGeoMaps Group: ChartsGeoMaps_Utility Build Succeeded', workunit + ': Build complete.' + filedate)),
					Failure(FileServices.SendEmail(pContact, 'ChartsGeoMaps Group: ChartsGeoMaps_Utility Build Failed', workunit + filedate + '\n' + FAILMESSAGE)
					);
return email_alert;

end;