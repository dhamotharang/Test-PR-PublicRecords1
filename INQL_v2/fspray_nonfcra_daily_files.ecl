import Versioncontrol, std;

EXPORT fspray_nonfcra_daily_files := module
	
	GetFileList(string path, string pFilenameExp) := function
		pFileList  :=  nothor(FileServices.Remotedirectory(INQL_v2._Constants.LZ,path,pFilenameExp));
		return pFileList;
	end;	
	
	GetFiles(string path) := function
		pFiles := GetFileList(path, INQL_v2._Constants.nonfcra_filters[1])
						+	GetFileList(path, INQL_v2._Constants.nonfcra_filters[2])
						+ GetFileList(path, INQL_v2._Constants.nonfcra_filters[3])
						+ GetFileList(path, INQL_v2._Constants.nonfcra_filters[4])
						+ GetFileList(path, INQL_v2._Constants.nonfcra_filters[5])
						+ GetFileList(path, INQL_v2._Constants.nonfcra_filters[6])
						+ GetFileList(path, INQL_v2._Constants.nonfcra_filters[7])
						+ GetFileList(path, INQL_v2._Constants.nonfcra_filters[8])
						+ GetFileList(path, INQL_v2._Constants.nonfcra_filters[9])
						+ GetFileList(path, INQL_v2._Constants.nonfcra_filters[10])
						+ GetFileList(path, INQL_v2._Constants.nonfcra_filters[11]);
		return pFiles;
	end;
	
	export _spray := sequential(
					nothor(apply(GetFiles(INQL_v2._Constants.READYDIR), STD.File.MoveExternalFile(INQL_v2._Constants.LZ, INQL_v2._Constants.READYDIR + name, INQL_v2._Constants.SPRAYINGDIR + name)))
				 ,INQL_v2.fSpray(GetFiles(INQL_v2._Constants.SPRAYINGDIR), false)
				 ,nothor(apply(GetFiles(INQL_v2._Constants.SPRAYINGDIR), STD.File.MoveExternalFile(INQL_v2._Constants.LZ, INQL_v2._Constants.SPRAYINGDIR + name, INQL_v2._Constants.DONEDIR + name)))
				 ,notify(INQL_v2._Constants.NON_FCRA_DAILY_BASE_EVENTNAME, '*') //Starting the base building process.
					) : SUCCESS(FileServices.SendEmail(INQL_v2.email_notification_lists.BuildSuccess,'Non-FCRA Logs Spray Complete - Inquiry Tracking, Case Connect, Score and Attribute', thorlib.wuid())),
							Failure(FileServices.SendEmail(INQL_v2.email_notification_lists.BuildFailure,'Non-FCRA Logs Spray Fail', thorlib.wuid() + ' - '
							+ '\n  *  Please go to bctlpedata10 inquiry_data_01 spray_ready to see what files need to be sprayed. May need gunzip. Resubmit WU. '+ FAILMESSAGE));

end;
