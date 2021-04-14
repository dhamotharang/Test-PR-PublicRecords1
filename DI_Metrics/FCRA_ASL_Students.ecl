//Student Lists: data does not count well when trying to get it as source in Person Header by date first/last seen; see FCRA_AlloyKeys and FCRA_AmericanStudentKeys
//Prod W20200325-145314
 
IMPORT _Control, American_student_list, alloymedia_student_list, data_services, STD, ut;

export FCRA_ASL_Students(string pHostname, string pTarget, string pContact ='\' \'', STRING today = (STRING8)STD.Date.Today()) := function

filedate := today;
	
//FCRA Alloy Media Student Key
Key_DID_FCRA_AlloyStudent := PULL(AlloyMedia_student_list.Key_DID_FCRA);
FCRA_AlloySL_LexIDs := dedup(sort(distribute(Key_DID_FCRA_AlloyStudent(did <> 0), hash(did)),did, local,skew(1.0)),did, all);

//FCRA American Student Keys: there are 2 DID keys: this one contains historical records, the other only current records
Key_DID_FCRA_AmericanSL := PULL(American_student_list.key_DID_FCRA);
FCRA_AmericanSL_LexIDs := DEDUP(sort(distribute(Key_DID_FCRA_AmericanSL(did <> 0), hash(did)),did, local,skew(1.0)),did, all);

//Combined Student List:
rec_All_Students := RECORD
 unsigned6 DID;
 string50 LN_COLLEGE_NAME;
 string8 date_vendor_first_reported;
 string8	date_vendor_last_reported;
END;

All_Students := PROJECT(FCRA_AlloySL_LexIDs, rec_All_Students) + PROJECT(FCRA_AmericanSL_LexIDs, rec_All_Students); 
All_Students_LexIDs := DEDUP(sort(distribute(All_Students(did <> 0), hash(did)),did, local,skew(1.0)),did, all);
All_Students_All_Schools := DEDUP(sort(distribute(All_Students(LN_COLLEGE_NAME <> ''), hash(LN_COLLEGE_NAME)),LN_COLLEGE_NAME, local,skew(1.0)),LN_COLLEGE_NAME, all);

//No High Scool (college only):
All_Students_No_HighSchool := PROJECT(FCRA_AlloySL_LexIDs(file_type<>'M'),rec_All_Students) + 
														PROJECT(FCRA_AmericanSL_LexIDs(file_type<>'M' OR college_code <>'' OR college_major <>''),rec_All_Students);

All_Students_No_HighSchool_LexIDs := DEDUP(sort(distribute(All_Students_No_HighSchool(did <> 0), hash(did)),did, local,skew(1.0)),did, all);
tbl_FCRA_Students_College_LexID := TABLE(All_Students_No_HighSchool_LexIDs, {LN_COLLEGE_NAME, did_count := count(group)}, LN_COLLEGE_NAME, few);
srt_tbl_FCRA_Students_College_LexID := sort(tbl_FCRA_Students_College_LexID, ln_college_name, skew(1.0));

//Despray to bctlpedata12 (one thor file and one csv file). FTP to \\Risk\inf\Data_Factory\DI_Landingzone
despray_fcra_student_tbl := STD.File.DeSpray('~thor_data400::data_insight::data_metrics::tbl_FCRA_Students_College_LexID_'+ filedate +'.csv',
																						 pHostname, 
																						 pTarget + '/tbl_FCRA_Students_College_LexID_'+ filedate +'.csv' 
																						 //charlene's team will create the monthly folder yyyymmdd otherwise HPCC creates the folder
																						 ,,,,true);

//if everything in the Sequential statement runs, it will send the Success email, else it will send the Failure email
email_alert := SEQUENTIAL(
					output(srt_tbl_FCRA_Students_College_LexID,,'~thor_data400::data_insight::data_metrics::tbl_FCRA_Students_College_LexID_'+ filedate +'.csv'
					,csv(heading(single), separator('|'),terminator('\r\n'),quote('\"')), overwrite, expire(10))
					,despray_fcra_student_tbl):
					Success(FileServices.SendEmail(pContact, 'FCRA Group: FCRA_ASL_Students Build Succeeded', workunit + ': Build complete.' + filedate)),
					Failure(FileServices.SendEmail(pContact, 'FCRA Group:  FCRA_ASL_Students Build Failed', workunit + filedate + '\n' + FAILMESSAGE)
													);
return email_alert;

end;