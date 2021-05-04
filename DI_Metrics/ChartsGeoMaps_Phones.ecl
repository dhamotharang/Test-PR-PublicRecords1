IMPORT _control,Phonesplus_v2, data_services, STD;
export ChartsGeoMaps_Phones(string pHostname, string pTarget, string pContact ='\' \'', STRING today = (STRING8)STD.Date.Today()) := function

filedate := today;

pplus_base  := Phonesplus_v2.File_Phonesplus_Base;
tbl_phn_typ := table(pplus_base, {append_phone_type, total:=count(group)}, append_phone_type, few);
srt_phn_tbl := sort(tbl_phn_typ, -total);

//Despray CSV to bctlpedata12 (one thor file and one csv file). FTP to \\Risk\inf\Data_Factory\DI_Landingzone
despray_phone_tbl := STD.File.DeSpray('~thor_data400::data_insight::data_metrics::tbl_ChartsGeoMaps_Phones_By_Phone_Type_'+ filedate +'.csv',
																			pHostname, 
																			pTarget+ '/tbl_ChartsGeoMaps_Phones_By_Phone_Type_'+ filedate +'.csv'
																			,,,,true);

//Jessica's last WUID: W20190219-132052

//if everything in the Sequential statement runs, it will send the Success email, else it will send the Failure email
email_alert := SEQUENTIAL(
					output(srt_phn_tbl,,'~thor_data400::data_insight::data_metrics::tbl_ChartsGeoMaps_Phones_By_Phone_Type_'+ filedate +'.csv', csv(heading(single), separator('|'),terminator('\r\n'),quote('\"')), overwrite, expire(10))
					,despray_phone_tbl):
					Success(FileServices.SendEmail(pContact, 'ChartsGeoMaps Group: ChartsGeoMaps_Phones Build Succeeded', workunit + ': Build complete.' + filedate)),
					Failure(FileServices.SendEmail(pContact, 'ChartsGeoMaps Group: ChartsGeoMaps_Phones Build Failed', workunit + filedate + '\n' + FAILMESSAGE)
													);
return email_alert;

end;