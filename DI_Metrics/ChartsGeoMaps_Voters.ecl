//----- Voter By Political Party Status Chart -- Run this in PROD!! -----//

IMPORT _control, VotersV2, data_services, STD, ut;
export ChartsGeoMaps_Voters (string pHostname, string pTarget, string pContact ='\' \'', STRING today = (STRING8)STD.Date.Today()) := function

filedate := today;

voter_base := VotersV2.File_Voters_Base;
tbl_vparty := table(voter_base, {politicalparty_exp, total:=count(group)},politicalparty_exp, few);
srt_v_tbl  := sort(tbl_vparty, politicalparty_exp);

//Despray CSV to bctlpedata12 (one thor file and one csv file). FTP to \\Risk\inf\Data_Factory\DI_Landingzone
despray_voter_tbl := STD.File.DeSpray('~thor_data400::data_insight::data_metrics::tbl_ChartsGeoMaps_Voters_By_Political_Party_'+ filedate +'.csv',
																			pHostname, 
																			pTarget+ '/tbl_ChartsGeoMaps_Voters_By_Political_Party_'+ filedate +'.csv'
																			,,,,true);

////Jessica's last wuid: W20190219-124113-Prod

//if everything in the Sequential statement runs, it will send the Success email, else it will send the Failure email
email_alert := SEQUENTIAL(
					output(srt_v_tbl,,'~thor_data400::data_insight::data_metrics::tbl_ChartsGeoMaps_Voters_By_Political_Party_'+ filedate +'.csv', csv(heading(single), separator('|'),terminator('\r\n'),quote('\"')), overwrite, expire(10))
					,despray_voter_tbl):
					Success(FileServices.SendEmail(pContact, 'ChartsGeoMaps Group: ChartsGeoMaps_Voters Build Succeeded', workunit + ': Build complete.' + filedate)),
					Failure(FileServices.SendEmail(pContact, 'ChartsGeoMaps Group: ChartsGeoMaps_Voters Build Failed', workunit + filedate + '\n' + FAILMESSAGE)
													);
return email_alert;

end;