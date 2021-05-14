/*	Student Lists: 	This data does not count well when trying to get it as source in Person Header by date first/last seen.
	See FCRA_AlloyKeys and FCRA_AmericanStudentKeys.*/
//W20200806-092127	Prod 

IMPORT _control, data_services, alloymedia_student_list, american_student_list, STD, ut;
export NonFCRA_ASL_Students(string pHostname, string pTarget, string pContact ='\' \'', STRING today = (STRING8)STD.Date.Today()) := function

filedate := today;

//NonFCRA Alloy Student Data
Key_DID_AlloyStudent := PULL(AlloyMedia_student_list.Key_DID);
AlloySL_DIDs := DEDUP(sort(distribute(Key_DID_AlloyStudent(did <> 0), hash(did)),did, local,skew(1.0)),did,  local); 

//NonFCRA AmericanStudentKeys, includes ASL and OKC sourced student records
//there are 2 DID keys: this one contains historical records, the other only current records
Key_DID_AmericanSL := PULL(American_student_list.key_DID);
AmericanSL_DIDs := DEDUP(sort(distribute(Key_DID_AmericanSL(did <> 0), hash(did)),did, local,skew(1.0)),did, local); 

//Combined Student List:
rec_All_Students := RECORD
	unsigned6 DID;
	string50 LN_COLLEGE_NAME;
	string8 date_vendor_first_reported;
	string8	date_vendor_last_reported;
 end;

All_Students := PROJECT(AlloySL_DIDs, rec_All_Students) + PROJECT(AmericanSL_DIDs, rec_All_Students); 
All_Students_DIDs := DEDUP(sort(distribute(All_Students(did <> 0), hash(did)),did, local,skew(1.0)),did, local); 
All_Students_Schools := DEDUP(sort(distribute(All_Students(LN_COLLEGE_NAME <> ''), hash(LN_COLLEGE_NAME)),LN_COLLEGE_NAME, local,skew(1.0)),LN_COLLEGE_NAME, local);  

//No High Scool (college only):
All_Students_No_HighSchool := PROJECT(AlloySL_DIDs(file_type<>'M'),rec_All_Students) 
														+ PROJECT(AmericanSL_DIDs(file_type<>'M' OR college_code <>'' OR college_major <>''),rec_All_Students);
															
All_Students_No_HighSchool_DIDs := DEDUP(sort(distribute(All_Students_No_HighSchool(did <> 0), hash(did)),did, local,skew(1.0)),did, local);  
tbl_All_Students_No_HighSchool_DIDs := TABLE(All_Students_No_HighSchool_DIDs, {LN_COLLEGE_NAME, did_count := count(group)}, LN_COLLEGE_NAME, few);
srt_tbl_All_Students_No_HighSchool_DIDs := sort(tbl_All_Students_No_HighSchool_DIDs, LN_COLLEGE_NAME, skew(1.0));

//Despray CSV to bctlpedata12 (one thor file and one csv file). FTP to \\Risk\inf\Data_Factory\DI_Landingzone
despray_student_tbl := STD.File.DeSpray('~thor_data400::data_insight::data_metrics::tbl_NonFCRA_Students_College_LexID_'+ filedate +'.csv', 
																				pHostname, 
																				pTarget + '/tbl_NonFCRA_Students_College_LexID_'+ filedate +'.csv' 
																				//charlene's team will create the monthly folder yyyymmdd otherwise HPCC creates the folder
																				,,,,true);

//if everything in the Sequential statement runs, it will send the Success email, else it will send the Failure email
email_alert := SEQUENTIAL(
					output(srt_tbl_All_Students_No_HighSchool_DIDs,,'~thor_data400::data_insight::data_metrics::tbl_NonFCRA_Students_College_LexID_'+ filedate +'.csv'
					,csv(heading(single), separator('|'),terminator('\r\n'),quote('\"')), overwrite, expire(10))
					,despray_student_tbl):
					Success(FileServices.SendEmail(pContact, 'NonFCRA Group: NonFCRA_ASL_Students Build Succeeded', workunit + ': Build complete.' + filedate)),
					Failure(FileServices.SendEmail(pContact, 'NonFCRA Group:  NonFCRA_ASL_Students Build Failed', workunit + filedate + '\n' + FAILMESSAGE)
													);
return email_alert;

end;