IMPORT _control,UCCV2, data_services, STD; 
export ChartsGeoMaps_UCC(string pHostname, string pTarget, string pContact ='\' \'', STRING today = (STRING8)STD.Date.Today()) := function

filedate := today;

//Filing Type
ucc_base := UCCV2.File_UCC_Main_Base;
tbl_ucc  := table(ucc_base, {orig_filing_type, total:=count(group)}, orig_filing_type, few);
srt_tbl  := sort(tbl_ucc,-total);

//Geo Map
tbl_map := table(ucc_base,{filing_jurisdiction, total:=count(group)}, filing_jurisdiction, few);
srt_map := sort(tbl_map, filing_jurisdiction);

//Despray CSV to bctlpedata12 (one thor file and one csv file). FTP to \\Risk\inf\Data_Factory\DI_Landingzone
despray_ucc_tbl := STD.File.DeSpray('~thor_data400::data_insight::data_metrics::tbl_ChartsGeoMaps_UCC_By_Filing_Type_'+ filedate +'.csv',
																		pHostname, 
																		pTarget+ '/tbl_ChartsGeoMaps_UCC_By_Filing_Type_'+ filedate +'.csv'
																		,,,,true);

despray_map_tbl := STD.File.DeSpray('~thor_data400::data_insight::data_metrics::tbl_ChartsGeoMaps_UCC_By_State_'+ filedate +'.csv',
																		pHostname, 
																		pTarget+ '/tbl_ChartsGeoMaps_UCC_By_State_'+ filedate +'.csv'
																		,,,,true);

//Jessica's last WUID: W20190122-144107

//if everything in the Sequential statement runs, it will send the Success email, else it will send the Failure email
email_alert := SEQUENTIAL(
					//Filing Type
					output(srt_tbl,,'~thor_data400::data_insight::data_metrics::tbl_ChartsGeoMaps_UCC_By_Filing_Type_'+ filedate +'.csv', csv(heading(single), separator('|'),terminator('\r\n'),quote('\"')), overwrite, expire(10))
					,despray_ucc_tbl
					//Geo Map
					,output(srt_map,,'~thor_data400::data_insight::data_metrics::tbl_ChartsGeoMaps_UCC_By_State_'+ filedate +'.csv', csv(heading(single), separator('|'),terminator('\r\n'),quote('\"')), overwrite, expire(10))
					,despray_map_tbl):
					Success(FileServices.SendEmail(pContact, 'ChartsGeoMaps Group: ChartsGeoMaps_UCC Build Succeeded', workunit + ': Build complete.' + filedate)),
					Failure(FileServices.SendEmail(pContact, 'ChartsGeoMaps Group: ChartsGeoMaps_UCC Build Failed', workunit + filedate + '\n' + FAILMESSAGE)
													);
return email_alert;

end;