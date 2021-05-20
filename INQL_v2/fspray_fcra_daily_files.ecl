import Inquiry_AccLogs;

EXPORT fspray_fcra_daily_files := module

export _spray := Inquiry_AccLogs.fspray_fcra_daily_files._spray;

end;


// import Versioncontrol, std,_CONTROL,INQL_V2;

// EXPORT fspray_fcra_daily_files := module
	

// GetFileList(string path, string source='') := function
// 		pFileList  :=  IF(source='accurint',nothor(STD.File.Remotedirectory(INQL_v2._Constants.LZ,path))(REGEXFIND('fcra_log_accounting_log_(.*).txt',name,NOCASE)),
// 					   IF(source='batch',nothor(STD.File.Remotedirectory(INQL_v2._Constants.LZ,path))(REGEXFIND('batch_fcra_(.*).cat',name,NOCASE)),
// 					   IF(source='riskwise',nothor(STD.File.Remotedirectory(INQL_v2._Constants.LZ,path))(REGEXFIND('riskwise_fcra_accounting_log_(.*).txt',name,NOCASE)),
//                        nothor(STD.File.Remotedirectory(INQL_v2._Constants.LZ,path))(REGEXFIND(source,name,NOCASE)))));

// 	return  project(pFileList,TRANSFORM({recordof(pFileList),string source},SELF.source:=source,SELF:=LEFT));	
// end;	


// GetFiles(string path) := function
// 	        	pFiles := GetFileList(path, 'accurint')
// 						+ GetFileList(path, 'batch')
// 						+ GetFileList(path, 'riskwise');
// 		return pFiles;
// 	end;

					
// 	export _spray := sequential(
// 				  nothor(apply(GetFiles(INQL_v2._Constants.READYDIR), STD.File.MoveExternalFile(INQL_v2._Constants.LZ, INQL_v2._Constants.READYDIR + name, INQL_v2._Constants.SPRAYINGDIR + name)))
// 				 ,INQL_v2.fSpray(GetFiles(INQL_v2._Constants.sprayingDir), true)
// 				 ,nothor(apply(GetFiles(INQL_v2._Constants.SPRAYINGDIR), STD.File.MoveExternalFile(INQL_v2._Constants.LZ, INQL_v2._Constants.SPRAYINGDIR + name, INQL_v2._Constants.DONE_FCRA_DIR + name)))
// 				 ,notify(inql_v2._CRON_ECL('BASE PREP',true,true).EVENT_NAME,'*')//Starting the base building process.
// 				 ) : SUCCESS(FileServices.SendEmail(INQL_v2.email_notification_lists.BuildSuccess,'FCRA Logs Spray Complete - Inquiry Tracking, Score and Attribute', thorlib.wuid())),
// 							Failure(FileServices.SendEmail(INQL_v2.email_notification_lists.BuildFailure, 'FCRA Input Logs Spray Fail', thorlib.wuid()
//                             + '\n  *  Please go to bctlpedata10 inquiry_data_01 spray_ready to see what files need to be sprayed. May need gunzip. Resubmit WU.'+'\n' + FAILMESSAGE));
			
// end;

