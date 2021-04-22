IMPORT _control,VehicleV2, data_services, STD;
export ChartsGeoMaps_Vehicles(string pHostname, string pTarget, string pContact ='\' \'', STRING today = (STRING8)STD.Date.Today()) := function

filedate := today;

veh_main := VehicleV2.file_VehicleV2_Main;
veh_party := VehicleV2.file_vehicleV2_party;

//By Vehicle Make
veh_tbl  := table(veh_main, {vina_make_desc, total:=count(group)},vina_make_desc,few);
srt_veh_tbl := sort(veh_tbl,-total);

//Geo Map
ddp_party := dedup(sort(distribute(veh_party, hash(append_did)), append_did, local), append_did, local);
veh_map_tbl := table(ddp_party, {state_origin, did_count := count(group)}, state_origin, few);
srt_veh_map := sort(veh_map_tbl, state_origin);

//Despray CSV to bctlpedata12 (one thor file and one csv file). FTP to \\Risk\inf\Data_Factory\DI_Landingzone
despray_veh_tbl := STD.File.DeSpray('~thor_data400::data_insight::data_metrics::tbl_ChartsGeoMaps_Vehicle_By_Make_Desc_'+ filedate +'.csv',
																		pHostname, 
																		pTarget+ '/tbl_ChartsGeoMaps_Vehicle_By_Make_Desc_'+ filedate +'.csv'
																		,,,,true);

despray_map_tbl := STD.File.DeSpray('~thor_data400::data_insight::data_metrics::tbl_ChartsGeoMaps_Vehicles_By_State_'+ filedate +'.csv',
																		pHostname, 
																		pTarget+ '/tbl_ChartsGeoMaps_Vehicles_By_State_'+ filedate +'.csv'
																		,,,,true);

//Jessica's last wuid: W20181217-091659 - prod

//if everything in the Sequential statement runs, it will send the Success email, else it will send the Failure email
email_alert := SEQUENTIAL(
					//Vehicle Make
					output(srt_veh_tbl,,'~thor_data400::data_insight::data_metrics::tbl_ChartsGeoMaps_Vehicle_By_Make_Desc_'+ filedate +'.csv', csv(heading(single), separator('|'),terminator('\r\n'),quote('\"')), overwrite, expire(10))
					,despray_veh_tbl
					//Geo Map
					,output(srt_veh_map,,'~thor_data400::data_insight::data_metrics::tbl_ChartsGeoMaps_Vehicles_By_State_'+ filedate +'.csv', csv(heading(single), separator('|'),terminator('\r\n'),quote('\"')), overwrite, expire(10))
					,despray_map_tbl):
					Success(FileServices.SendEmail(pContact, 'ChartsGeoMaps Group: ChartsGeoMaps_Vehicles Build Succeeded', workunit + ': Build complete.' + filedate)),
					Failure(FileServices.SendEmail(pContact, 'ChartsGeoMaps Group: ChartsGeoMaps_Vehicles Build Failed', workunit + filedate + '\n' + FAILMESSAGE)
													);
return email_alert;

end;
