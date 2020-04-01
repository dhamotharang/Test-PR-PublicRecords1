IMPORT STD, Ecrash_Common;
fileservices := STD.File;
Email := STD.System.Email;

EXPORT Send_Email (STRING buildSeq = mod_Utilities.strSysDate + (STRING) mod_Utilities.SysTime, 
                   STRING buildType = 'INSURANCE_NACCIDENTS_INQUIRY',
                   STRING fileName = FileNames.VEHICLE_INCIDENT_FILE_NAME, 
									          STRING emailTarget = Ecrash_Common.Constants.BuildEmailTarget
                   )	:= MODULE

 SHARED BuildMsg := 'NAccidentsInquiry :  ' + buildType + ' ';
	SHARED buildDateMsg := 'Build Date =  ' + buildSeq;
	
	EXPORT BuildBaseMacrosFailed := Email.Sendemail(emailTarget, BuildMsg + ' Base Build Macros Failed; ' + buildDateMsg, workunit + '\n' + failmessage);
	EXPORT BuildDBCountsFailed := Email.Sendemail(emailTarget, BuildMsg + ' Database Extracts Counts for DB exports Build Failed; ' + buildDateMsg, workunit + '\n' + failmessage);
	EXPORT BuildFailed := Email.Sendemail(emailTarget, BuildMsg + ' Base Build Failed; ' + buildDateMsg, workunit + '\n' + failmessage); 
	EXPORT SprayFailed := Email.Sendemail(emailTarget, BuildMsg +  filename + ' Spray Failed; ' + buildDateMsg, workunit + '\n' + failmessage);
	EXPORT EmptyFile := Email.Sendemail(emailTarget, BuildMsg + filename +  ' Spray File Size Zero; ' + buildDateMsg, workunit);
	EXPORT FileMissing := Email.Sendemail(emailTarget, BuildMsg + filename + ' Spray File Missing; ' + buildDateMsg, workunit);	
																																					
END;