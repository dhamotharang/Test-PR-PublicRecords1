IMPORT _control, watercraft, data_services, STD;
export ChartsGeoMaps_Watercraft(string pHostname, string pTarget, string pContact ='\' \'', STRING today = (STRING8)STD.Date.Today()) := function

filedate := today;

boat_main := watercraft.file_base_main_prod;

veh_tbl  := table(boat_main, {vehicle_type_description, total:=count(group)},vehicle_type_description,few);
srt_veh_tbl := sort(veh_tbl,-total);

prp_tbl := table(boat_main, {propulsion_description, total:=count(group)},propulsion_description,few);
srt_prp_tbl := sort(prp_tbl,-total);

//Despray CSV to bctlpedata12 (one thor file and one csv file). FTP to \\Risk\inf\Data_Factory\DI_Landingzone
despray_veh_tbl := STD.File.DeSpray('~thor_data400::data_insight::data_metrics::tbl_ChartsGeoMaps_Watercraft_By_Vehicle_Type_'+ filedate +'.csv',
																		pHostname, 
																		pTarget+ '/tbl_ChartsGeoMaps_Watercraft_By_Vehicle_Type_'+ filedate +'.csv'
																		,,,,true);

despray_prp_tbl := STD.File.DeSpray('~thor_data400::data_insight::data_metrics::tbl_ChartsGeoMaps_Watercraft_By_Propulsion_Type_'+ filedate +'.csv',
																		pHostname, 
																		pTarget+ '/tbl_ChartsGeoMaps_Watercraft_By_Propulsion_Type_'+ filedate +'.csv'
																		,,,,true);

/*
Jessica's Feb 2019 WUIDs (prod): 
 W20190219-133332 - vehile type
 W20190219-133432 - propulsion desc*/

//if everything in the Sequential statement runs, it will send the Success email, else it will send the Failure email
email_alert := SEQUENTIAL(
					output(srt_veh_tbl,,'~thor_data400::data_insight::data_metrics::tbl_ChartsGeoMaps_Watercraft_By_Vehicle_Type_'+ filedate +'.csv', csv(heading(single), separator('|'),terminator('\r\n'),quote('\"')), overwrite, expire(10))
					,output(srt_prp_tbl,,'~thor_data400::data_insight::data_metrics::tbl_ChartsGeoMaps_Watercraft_By_Propulsion_Type_'+ filedate +'.csv', csv(heading(single), separator('|'),terminator('\r\n'),quote('\"')), overwrite, expire(10))
					,despray_veh_tbl
					,despray_prp_tbl):
					Success(FileServices.SendEmail(pContact, 'ChartsGeoMaps Group: ChartsGeoMaps_Watercraft Build Succeeded', workunit + ': Build complete.' + filedate)),
					Failure(FileServices.SendEmail(pContact, 'ChartsGeoMaps Group: ChartsGeoMaps_Watercraft Build Failed', workunit + filedate + '\n' + FAILMESSAGE)
													);
return email_alert;

end;