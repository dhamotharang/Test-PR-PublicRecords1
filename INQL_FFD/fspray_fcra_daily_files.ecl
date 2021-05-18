import Versioncontrol, std;

EXPORT fspray_fcra_daily_files := module
	
	GetFileList(string path, string pFilenameExp) := function
		pFileList  :=  nothor(FileServices.Remotedirectory(INQL_FFD._Constants.LZ,path,pFilenameExp));
		return pFileList;
	end;	
	
	GetFiles(string path) := function
		pFiles 	:=  GetFileList(path, INQL_FFD._Constants.fcra_filters[1]);
		return pFiles;
	end;
					
	export _spray := sequential(
					nothor(apply(GetFiles(INQL_FFD._Constants.READYDIR), STD.File.MoveExternalFile(INQL_FFD._Constants.LZ, INQL_FFD._Constants.READYDIR + name, INQL_FFD._Constants.SPRAYINGDIR + name)))
				 ,INQL_FFD.fSpray(GetFiles(INQL_FFD._Constants.sprayingDir), true)
				 ,nothor(apply(GetFiles(INQL_FFD._Constants.SPRAYINGDIR), STD.File.MoveExternalFile(INQL_FFD._Constants.LZ, INQL_FFD._Constants.SPRAYINGDIR + name, INQL_FFD._Constants.DONEDIR + name)))
				 ,nothor(apply(GetFiles(INQL_FFD._Constants.READYENCRYPTEDDIR), STD.File.MoveExternalFile(INQL_FFD._Constants.LZ, INQL_FFD._Constants.READYENCRYPTEDDIR + name, INQL_FFD._Constants.SPRAYINGENCRYPTEDDIR + name)))
				 ,INQL_FFD.fSpray(GetFiles(INQL_FFD._Constants.SPRAYINGENCRYPTEDDIR), true, true)
				 ,nothor(apply(GetFiles(INQL_FFD._Constants.SPRAYINGENCRYPTEDDIR), STD.File.MoveExternalFile(INQL_FFD._Constants.LZ, INQL_FFD._Constants.SPRAYINGENCRYPTEDDIR + name, INQL_FFD._Constants.DONEDIR + name)))
				 				 
				 ,notify(INQL_FFD._CRON_ECL('BASE BUILD',true,true).EVENT_NAME, '*') //Starting the base building process.
				 ,notify(INQL_FFD._CRON_ECL('FILES SCRUB',true,true).EVENT_NAME, '*') //Starting the daily files scrub.
					) : SUCCESS(FileServices.SendEmail(INQL_FFD.email_notification_lists.BuildSuccess,'FCRA Logs Spray Complete - Inquiry History', thorlib.wuid())),
							Failure(FileServices.SendEmail(INQL_FFD.email_notification_lists.BuildFailure, 'FCRA Input Logs Spray Fail - Inquiry History', thorlib.wuid()
                + '\n  *  Please go to bctlpedata10 inquiry_history_data_01 spray_ready to see what files need to be sprayed. May need gunzip. Resubmit WU.'+'\n' + FAILMESSAGE));
								
end;