//--- Marriage & Divorce Chart & Geo Map ---//

IMPORT _control,marriage_divorce_v2, data_services, STD, ut;
export ChartsGeoMaps_Marriage_Divorce(string pHostname, string pTarget, string pContact ='\' \'', STRING today = (STRING8)STD.Date.Today()) := function

filedate := today;

//3' for marriages and '7' for divorces
mdv_base := marriage_divorce_v2.file_mar_div_base;
mar_recs := mdv_base(filing_type = '3');
div_recs := mdv_base(filing_type = '7');

//chart tables
mar_age_table := table(mar_recs, {party1_age, total:=count(group)},party1_age,few);
div_age_table := table(div_recs, {party1_age, total:=count(group)},party1_age,few);

//map tables
mar_state_tbl := table(mar_recs,{state_origin, total:=count(group)}, state_origin,few);
div_state_tbl := table(div_recs,{state_origin, total:=count(group)}, state_origin,few);

//Despray CSV to bctlpedata12 (one thor file and one csv file). FTP to \\Risk\inf\Data_Factory\DI_Landingzone
despray_mar_age_tbl := STD.File.DeSpray('~thor_data400::data_insight::data_metrics::tbl_ChartsGeoMaps_MarriageByAgeChart_'+ filedate +'.csv',
																				pHostname, 
																				pTarget+ '/tbl_ChartsGeoMaps_MarriageByAgeChart_'+ filedate +'.csv'
																				,,,,true);

despray_mar_state_tbl := STD.File.DeSpray('~thor_data400::data_insight::data_metrics::tbl_ChartsGeoMaps_MarriagesByState_'+ filedate +'.csv',
																					pHostname, 
																					pTarget+ '/tbl_ChartsGeoMaps_MarriagesByState_'+ filedate +'.csv'
																					,,,,true);

despray_div_age_tbl := STD.File.DeSpray('~thor_data400::data_insight::data_metrics::tbl_ChartsGeoMaps_DivorcesByAgeChart_'+ filedate +'.csv',
																				pHostname, 
																				pTarget+ '/tbl_ChartsGeoMaps_DivorcesByAgeChart_'+ filedate +'.csv'
																				,,,,true);

despray_div_state_tbl := STD.File.DeSpray('~thor_data400::data_insight::data_metrics::tbl_ChartsGeoMaps_DivorcesByState_'+ filedate +'.csv',
																					pHostname, 
																					pTarget+ '/tbl_ChartsGeoMaps_DivorcesByState_'+ filedate +'.csv'
																					,,,,true);

/* Jessica's last wuids
W20190219-133141-prod (divorce by age)
W20190219-131741-prod (divorce by state)
W20190219-133238-prod (marriage by age)
W20190219-131704-prod (marriage by state)
*/

//if everything in the Sequential statement runs, it will send the Success email, else it will send the Failure email
email_alert := SEQUENTIAL(
					output(sort(mar_age_table, party1_age),,'~thor_data400::data_insight::data_metrics::tbl_ChartsGeoMaps_MarriageByAgeChart_'+ filedate +'.csv', csv(heading(single), separator('|'),terminator('\r\n'),quote('\"')), overwrite, expire(10))
					,output(sort(div_age_table, party1_age),,'~thor_data400::data_insight::data_metrics::tbl_ChartsGeoMaps_DivorcesByAgeChart_'+ filedate +'.csv', csv(heading(single), separator('|'),terminator('\r\n'),quote('\"')), overwrite, expire(10))
					,output(sort(mar_state_tbl, state_origin),,'~thor_data400::data_insight::data_metrics::tbl_ChartsGeoMaps_MarriagesByState_'+ filedate +'.csv', csv(heading(single), separator('|'),terminator('\r\n'),quote('\"')), overwrite, expire(10))
					,output(sort(div_state_tbl, state_origin),,'~thor_data400::data_insight::data_metrics::tbl_ChartsGeoMaps_DivorcesByState_'+ filedate +'.csv', csv(heading(single), separator('|'),terminator('\r\n'),quote('\"')), overwrite, expire(10))					
					,despray_mar_age_tbl
					,despray_div_age_tbl
					,despray_mar_state_tbl
					,despray_div_state_tbl):
					Success(FileServices.SendEmail(pContact, 'ChartsGeoMaps Group: ChartsGeoMaps_Marriage_Divorce Build Succeeded', workunit + ': Build complete.' + filedate)),
					Failure(FileServices.SendEmail(pContact, 'ChartsGeoMaps Group: ChartsGeoMaps_Marriage_Divorce Build Failed', workunit + filedate + '\n' + FAILMESSAGE)
													);
return email_alert;

end;