//----- Criminal Chart by Data Type -- Run this in PROD!! -----//

IMPORT _control,Hygenics_crim, data_services, STD, ut;
export ChartsGeoMaps_Criminal(string pHostname, string pTarget, string pContact ='\' \'', STRING today = (STRING8)STD.Date.Today()) := function

filedate := today;

CrimOffender	:= Hygenics_crim.File_Moxie_Crim_Offender2_Dev;
// CourtOffenses	:= Hygenics_crim.File_Moxie_Court_Offenses_Dev;
// DOCOffenses		:= Hygenics_crim.File_Moxie_DOC_Offenses_Dev;
// DOCPunishment	:= Hygenics_crim.File_Moxie_DOC_Punishment_Dev;

crim_tbl := table(CrimOffender, {data_type, total:=count(group)}, data_type,few);

//Despray CSV to bctlpedata12 (one thor file and one csv file). FTP to \\Risk\inf\Data_Factory\DI_Landingzone
despray_crim_tbl := STD.File.DeSpray('~thor_data400::data_insight::data_metrics::tbl_ChartsGeoMaps_CrimChart_ByDataType_'+ filedate +'.csv',
																						pHostname, 
																						pTarget+ '/tbl_ChartsGeoMaps_CrimChart_ByDataType_'+ filedate +'.csv'
																						,,,,true);

//Jessica's last wuid: W20190219-123845-Prod

//if everything in the Sequential statement runs, it will send the Success email, else it will send the Failure email
email_alert := SEQUENTIAL(
					output(sort(crim_tbl,data_type),,'~thor_data400::data_insight::data_metrics::tbl_ChartsGeoMaps_CrimChart_ByDataType_'+ filedate +'.csv', csv(heading(single), separator('|'),terminator('\r\n'),quote('\"')), overwrite, expire(10))
					,despray_crim_tbl):
					Success(FileServices.SendEmail(pContact, 'ChartsGeoMaps Group: ChartsGeoMaps_Criminal Build Succeeded', workunit + ': Build complete.' + filedate)),
					Failure(FileServices.SendEmail(pContact, 'ChartsGeoMaps Group: ChartsGeoMaps_Criminal Build Failed', workunit + filedate + '\n' + FAILMESSAGE)
													);
return email_alert;

end;