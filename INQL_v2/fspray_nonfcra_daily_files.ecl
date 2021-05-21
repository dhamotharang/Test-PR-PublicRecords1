import Versioncontrol, std,INQL_V2,_CONTROL,wk_ut;

EXPORT fspray_nonfcra_daily_files := module
	
GetFileList(string path, string source='') := function
		pFileList  :=  IF(source='idm',nothor(STD.File.Remotedirectory(INQL_v2._Constants.LZ,path))(REGEXFIND('_InquiryTracking.csv',name,NOCASE)),
                       IF(source='sba',nothor(STD.File.Remotedirectory(INQL_v2._Constants.LZ,path))(REGEXFIND('delta_shell_inquiry_nonfcra_(.*).txt',name,NOCASE)),
					   IF(source='riskwise',nothor(STD.File.Remotedirectory(INQL_v2._Constants.LZ,path))(REGEXFIND('riskwise_accounting_log_(.*).txt',name,NOCASE)),
					   IF(source='batch',nothor(STD.File.Remotedirectory(INQL_v2._Constants.LZ,path))(REGEXFIND('batch_non_fcra_(.*).cat',name,NOCASE)),
					   IF(source='transaction',nothor(STD.File.Remotedirectory(INQL_v2._Constants.LZ,path))(REGEXFIND('transaction_desc_(.*).txt',name,NOCASE)),
					   IF(source='accurint',nothor(STD.File.Remotedirectory(INQL_v2._Constants.LZ,path))(REGEXFIND('accurint_accounting_log_(.*).txt',name,NOCASE)),
					   IF(source='custom',nothor(STD.File.Remotedirectory(INQL_v2._Constants.LZ,path))(REGEXFIND('custom_log_accounting_log_(.*).txt',name,NOCASE)),
                       nothor(STD.File.Remotedirectory(INQL_v2._Constants.LZ,path))(REGEXFIND(source,name,NOCASE)))))))));

	return  project(pFileList,TRANSFORM({recordof(pFileList),string source},SELF.source:=source,SELF:=LEFT));	
end;	

GetFiles(string path) := function
	        	pFiles := GetFileList(path, 'accurint')
						+ GetFileList(path, 'bridger')
						+ GetFileList(path, 'custom')
						+ GetFileList(path, 'idm')
						+ GetFileList(path, 'sba')
						+ GetFileList(path, 'riskwise')
						+ GetFileList(path, 'batch')
						+ GetFileList(path, 'transaction')
						+ GetFileList(path, 'ida');
		return pFiles;
	end;


	export _spray := sequential(
				 nothor(apply(GetFiles(INQL_v2._Constants.READYDIR), STD.File.MoveExternalFile(INQL_v2._Constants.LZ, INQL_v2._Constants.READYDIR + name, INQL_v2._Constants.SPRAYINGDIR + name)))
				 ,INQL_v2.fSpray(GetFiles(INQL_v2._Constants.SPRAYINGDIR), false)
			     ,wk_ut.CreateWuid('notify(INQL_v2._CRON_ECL(\'FIDO CHANGE REPORT\',FALSE,true).EVENT_NAME, \'*\');','thor400_36',INQL_V2._constants.PROD_ESP)
				 ,nothor(apply(GetFiles(INQL_v2._Constants.SPRAYINGDIR), STD.File.MoveExternalFile(INQL_v2._Constants.LZ, INQL_v2._Constants.SPRAYINGDIR + name, INQL_v2._Constants.DONE_NONFCRA_DIR + name)))
				 ,notify(inql_v2._CRON_ECL('BASE PREP',false,true).EVENT_NAME,'*')//Starting the base building process.
				 ) : SUCCESS(FileServices.SendEmail(INQL_v2.email_notification_lists.BuildSuccess,'Non-FCRA Logs Spray Complete - Inquiry Tracking, Case Connect, Score and Attribute', thorlib.wuid())),
						  	Failure(FileServices.SendEmail(INQL_v2.email_notification_lists.BuildFailure,'Non-FCRA Logs Spray Fail', thorlib.wuid() + ' - '
							+ '\n  *  Please go to bctlpedata10 inquiry_data_01 spray_ready to see what files need to be sprayed. May need gunzip. Resubmit WU. '+ FAILMESSAGE));

end;