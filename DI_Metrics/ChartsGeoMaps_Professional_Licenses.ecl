IMPORT _control,Prof_LicenseV2, data_services, STD;
export ChartsGeoMaps_Professional_Licenses(string pHostname, string pTarget, string pContact ='\' \'', STRING today = (STRING8)STD.Date.Today()) := function

filedate := today;

ds_prof_lic := Prof_LicenseV2.File_Proflic_Base_Tiers;
tbl_profs_cat := table(ds_prof_lic, {category2, total:=count(group)}, category2, few);
srt_profs_tbl := sort(tbl_profs_cat, -total);

//Despray CSV to bctlpedata12 (one thor file and one csv file). FTP to \\Risk\inf\Data_Factory\DI_Landingzone
despray_profs_tbl := STD.File.DeSpray('~thor_data400::data_insight::data_metrics::tbl_ChartsGeoMaps_Prof_Licenses_By_License_Type_'+ filedate +'.csv',
																			pHostname, 
																			pTarget+ '/tbl_ChartsGeoMaps_Prof_Licenses_By_License_Type_'+ filedate +'.csv'
																			,,,,true);

//Jessica's last WUID: W20190219-131538

//if everything in the Sequential statement runs, it will send the Success email, else it will send the Failure email
email_alert := SEQUENTIAL(
					output(srt_profs_tbl,,'~thor_data400::data_insight::data_metrics::tbl_ChartsGeoMaps_Prof_Licenses_By_License_Type_'+ filedate +'.csv', csv(heading(single), separator('|'),terminator('\r\n'),quote('\"')), overwrite, expire(10))
					,despray_profs_tbl):
					Success(FileServices.SendEmail(pContact, 'ChartsGeoMaps Group: ChartsGeoMaps_Professional_Licenses Build Succeeded', workunit + ': Build complete.' + filedate)),
					Failure(FileServices.SendEmail(pContact, 'ChartsGeoMaps Group: ChartsGeoMaps_Professional_Licenses Build Failed', workunit + filedate + '\n' + FAILMESSAGE)
													);
return email_alert;

end;