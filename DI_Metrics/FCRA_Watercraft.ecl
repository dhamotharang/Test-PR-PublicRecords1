//New watercraft (not people, but unique boats): There isn't an existing field that provides a unique identifier for a craft. Hull Number is not always populated.

IMPORT _Control, watercraft, data_services, doxie, Std, ut;

export FCRA_Watercraft(string pHostname, string pTarget, string pContact ='\' \'', STRING today = (STRING8)STD.Date.Today()) := function

filedate := today;

Key_Boats_FCRA_wid := Watercraft.key_watercraft_wid(true);

Key_Boats_FCRA_wid_2010 := PROJECT(Key_Boats_FCRA_wid(source_code = 'AW', (integer4) registration_date[1..4] >= 2010)
																	, transform({Key_Boats_FCRA_wid, integer4 first_registration, string	wid}
																							, self.first_registration := (integer4) left.registration_date[1..6]
																							, self.hull_number := IF(left.hull_number = '' or regexfind('NONE',left.hull_number), left.registration_number, left.hull_number)
																							, self.wid := TRIM((string) (self.hull_number + left.watercraft_make_description + left.model_year + left.watercraft_class_code + left.hull_type_description + (integer) left.watercraft_length), all);
																							, self := left));

Key_Boats_FCRA_wid_2010_IDs := DEDUP(sort(distribute(Key_Boats_FCRA_wid_2010, hash(wid)), wid, registration_date, state_origin, watercraft_class_description, local), wid, all,local);

tbl_Key_Boats_FCRA_wid_2010_IDs := TABLE(Key_Boats_FCRA_wid_2010_IDs, {first_registration, state_origin, watercraft_class_description, wid_count := count(group)}, first_registration, state_origin, watercraft_class_description, few);

//Despray to bctlpedata12 (one thor file and one csv file). FTP to \\Risk\inf\Data_Factory\DI_Landingzone
despray_boat_tbl := STD.File.DeSpray('~thor_data400::data_insight::data_metrics::tbl_FCRA_Boats_wid_2010_IDs_FirstSeen_'+ filedate +'.csv',
																		 pHostname, 
																		 pTarget + '/tbl_FCRA_Boats_wid_2010_IDs_FirstSeen_'+ filedate +'.csv'
																		 ,,,,true);
			
//if everything in the Sequential statement runs, it will send the Success email, else it will send the Failure email
email_alert := SEQUENTIAL(
					output(sort(tbl_Key_Boats_FCRA_wid_2010_IDs, -first_registration, state_origin, watercraft_class_description,  skew(1.0)),,'~thor_data400::data_insight::data_metrics::tbl_FCRA_Boats_wid_2010_IDs_FirstSeen_'+ filedate +'.csv', csv(heading(single), separator('|'),terminator('\r\n'),quote('\"')),overwrite,expire(10))
					,despray_boat_tbl):
					Success(FileServices.SendEmail(pContact, 'FCRA Group: FCRA_Watercraft Build Succeeded', workunit + ': Build complete.' + filedate)),
					Failure(FileServices.SendEmail(pContact, 'FCRA Group: FCRA_Watercraft Build Failed', workunit + filedate + '\n' + FAILMESSAGE)
													);
return email_alert;

end;