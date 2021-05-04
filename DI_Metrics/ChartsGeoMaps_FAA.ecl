//--- FAA Aircraft Chart ---//

IMPORT _control,FAA, data_services, STD, ut; 
export ChartsGeoMaps_FAA(string pHostname, string pTarget, string pContact ='\' \'', STRING today = (STRING8)STD.Date.Today()) := function

filedate := today;

//FAA Aircraft Base File
faa_aircraft := faa.file_aircraft_registration_out;

faa_tbl_rec := record
	faa_aircraft.type_aircraft;
	string aircraft_type_desc := '';
 END;

//Add Aircraft Type Description 
faa_tbl_rec xAirCraftType(faa_aircraft le) := TRANSFORM
	self.aircraft_type_desc := MAP(le.type_aircraft = '1' => 'Glider',
																 le.type_aircraft = '2' => 'Balloon',
																 le.type_aircraft = '3' => 'Blimp/Dirigible', 
																 le.type_aircraft = '4' => 'Fixed wing single engine',
																 le.type_aircraft = '5' => 'Fixed wing multi engine',
																 le.type_aircraft = '6' => 'Rotorcraft',
																 le.type_aircraft = '7' => 'Weight-shift-control',
																 le.type_aircraft = '8' => 'Powered Parachute',
																 le.type_aircraft = '9' => 'Gyroplane',
																 '');
	self := le;
end;

faa_acft_type := project(faa_aircraft,xAirCraftType(left));
faa_acft_tbl  := table(faa_acft_type, {type_aircraft, aircraft_type_desc, total:=count(group)}, type_aircraft, aircraft_type_desc, few);
srt_acft_tbl  := sort(faa_acft_tbl, type_aircraft);

//Despray CSV to bctlpedata12 (one thor file and one csv file). FTP to \\Risk\inf\Data_Factory\DI_Landingzone
despray_faa_acft_tbl := STD.File.DeSpray('~thor_data400::data_insight::data_metrics::tbl_ChartsGeoMaps_FAA_Aircraft_By_Type_'+ filedate +'.csv',
																				 pHostname, 
																				 pTarget+ '/tbl_ChartsGeoMaps_FAA_Aircraft_By_Type_'+ filedate +'.csv'
																				 ,,,,true);

/*//Aircraf Type Codes from Codes V3
	cv3 := Codes.File_Codes_V3_In; 
	faa_engine_type := cv3(file_name='FAA_AIRCRAFT_REF',field_name='TYPE_AIRCRAFT');
	output(faa_engine_type, all);
//Jessica's last wuid: W20190220-121416-dataland
*/

//if everything in the Sequential statement runs, it will send the Success email, else it will send the Failure email
email_alert := SEQUENTIAL(
					output(srt_acft_tbl,,'~thor_data400::data_insight::data_metrics::tbl_ChartsGeoMaps_FAA_Aircraft_By_Type_'+ filedate +'.csv', csv(heading(single), separator('|'),terminator('\r\n'),quote('\"')), overwrite, expire(10))
					,despray_faa_acft_tbl):
					Success(FileServices.SendEmail(pContact, 'ChartsGeoMaps Group: ChartsGeoMaps_FAA Build Succeeded', workunit + ': Build complete.' + filedate)),
					Failure(FileServices.SendEmail(pContact, 'ChartsGeoMaps Group: ChartsGeoMaps_FAA Build Failed', workunit + filedate + '\n' + FAILMESSAGE)
													);
return email_alert;

end;