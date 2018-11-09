import Versioncontrol, _Control, std;

EXPORT fspray_nonfcra_daily_files := module

	pServerIP		:= _control.IPAddress.bctlpedata10;
	rootDir 		:= '/data/inquiry_data_01/';
	readyDir		:= rootDir + 'spray_ready/';
	sprayingDir	:= rootDir + 'spraying/';
	doneDir 		:= rootDir + 'done_nonfcra/';
	errorDir 		:= rootDir + 'error/';
	
	GetFileList(string path, string pFilenameExp) := function
		pFileList  :=  nothor(FileServices.Remotedirectory(pServerIP,path,pFilenameExp));
		return pFileList;
	end;
	
	filters := ['accurint*.txt','banko_batch_non*.txt','banko_non*.txt','bridger*.cat','custom*.txt','deconfliction*.txt','*InquiryTracking.csv','delta_shell*.txt','riskwise_acc*.txt','transaction_desc*.txt','batch_non_fcra*.cat'];
	
	GetFiles(string path) := function
		files :=  GetFileList(path, filters[1])
						+	GetFileList(path, filters[2])
						+ GetFileList(path, filters[3])
						+ GetFileList(path, filters[4])
						+ GetFileList(path, filters[5])
						+ GetFileList(path, filters[6])
						+ GetFileList(path, filters[7])
						+ GetFileList(path, filters[8])
						+ GetFileList(path, filters[9])
						+ GetFileList(path, filters[10])
						+ GetFileList(path, filters[11]);
		return files;
	end;
	
	emails := 'jose.bello@lexisnexisrisk.com, debendra.kumar@lexisnexisrisk.com, Sudhir.Kasavajjala@lexisnexisrisk.com, Fernando.Incarnacao@lexisnexisrisk.com, Wenhong.Ma@lexisnexisrisk.com';
	
	export _spray := sequential(
					nothor(apply(GetFiles(readyDir), STD.File.MoveExternalFile(pServerIP, readyDir + name, sprayingDir + name)))
				 ,Inquiry_AccLogs.fSprayInputFiles(GetFiles(sprayingDir), false)
				 ,Inquiry_AccLogs.FIDO_change_report.proc_FIDO_chg_report
				 ,nothor(apply(GetFiles(sprayingDir), STD.File.MoveExternalFile(pServerIP, sprayingDir + name, doneDir + name)))
			 	 // ,Inquiry_AccLogs.Inquiry_daily_SuperfileContents(false)
				 ,notify('Spray Complete','*')
					) : SUCCESS(FileServices.SendEmail(emails,'Non-FCRA Logs Spray Complete - Inquiry Tracking, Case Connect, Score and Attribute', thorlib.wuid())),
							Failure(FileServices.SendEmail(emails,'Non-FCRA Logs Spray Fail', thorlib.wuid() + ' - '
							+ '\n  *  Please go to bctlpedata10 inquiry_data_01 spray_ready to see what files need to be sprayed. May need gunzip. Resubmit WU. '+ FAILMESSAGE));

end;
