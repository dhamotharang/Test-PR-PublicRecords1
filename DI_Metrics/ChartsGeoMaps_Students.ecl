IMPORT _control,American_student_list, data_services, STD;
export ChartsGeoMaps_Students(string pHostname, string pTarget, string pContact ='\' \'', STRING today = (STRING8)STD.Date.Today()) := function

filedate := today;

//AmericanStudentKeys, includes ASL and OKC sourced student records
//there are 2 DID keys: this one contains historical records, the other only current records
Key_Students_DID := pull(American_student_list.key_DID);
dedup_DID_key 	 := dedup(sort(distribute(Key_Students_DID, hash(did)),did,local),did, local);
tbl_student_DIDs := table(dedup_DID_key, {class, did_count := count(group)}, class, few);
srt_tbl_asl_dids := sort(tbl_student_DIDs,-class);

//Despray CSV to bctlpedata12 (one thor file and one csv file). FTP to \\Risk\inf\Data_Factory\DI_Landingzone
despray_class_tbl := STD.File.DeSpray('~thor_data400::data_insight::data_metrics::tbl_ChartsGeoMaps_Student_LexIDs_By_Class_Year_'+ filedate +'.csv',
																			pHostname, 
																			pTarget+ '/tbl_ChartsGeoMaps_Student_LexIDs_By_Class_Year_'+ filedate +'.csv'
																			,,,,true);

//Jessica's last WUID: W20190219-124239-prod
//ASL Base only includes ASL records, OKC records are now in production via the Non FCRA keys
//Base_ASL := jmills.File_american_student_DID_v2; 

//if everything in the Sequential statement runs, it will send the Success email, else it will send the Failure email
email_alert := SEQUENTIAL(
					output(srt_tbl_asl_dids,,'~thor_data400::data_insight::data_metrics::tbl_ChartsGeoMaps_Student_LexIDs_By_Class_Year_'+ filedate +'.csv', csv(heading(single), separator('|'),terminator('\r\n'),quote('\"')), overwrite, expire(10))
					,despray_class_tbl):
					Success(FileServices.SendEmail(pContact, 'ChartsGeoMaps Group: ChartsGeoMaps_Students Build Succeeded', workunit + ': Build complete.' + filedate)),
					Failure(FileServices.SendEmail(pContact, 'ChartsGeoMaps Group: ChartsGeoMaps_Students Build Failed', workunit + filedate + '\n' + FAILMESSAGE)
													);
return email_alert;

end;