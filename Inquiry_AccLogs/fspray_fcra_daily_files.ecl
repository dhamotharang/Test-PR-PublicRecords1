import Versioncontrol, _Control, std;

EXPORT fspray_fcra_daily_files := module
	
	pServerIP		:= _control.IPAddress.bctlpedata10;
	rootDir 		:= '/data/inquiry_data_01/';
	readyDir		:= rootDir + 'spray_ready/';
	sprayingDir	:= rootDir + 'spraying/';
	doneDir 		:= rootDir + 'done_fcra/';
	errorDir 		:= rootDir + 'error/';

	GetFileList(string path, string pFilenameExp) := function
		pFileList  :=  nothor(FileServices.Remotedirectory(pServerIP,path,pFilenameExp));
		return pFileList;
	end;

	filters := ['banko_batch_fcra*.txt','fcra_log_accounting_log_*.txt','banko_fcra*.txt','batch_fcra*.cat','riskwise_fcra*.txt'];
	
	GetFiles(string path) := function
		files 	:=  GetFileList(path, filters[1])
							+	GetFileList(path, filters[2])
							+ GetFileList(path, filters[3])
							+ GetFileList(path, filters[4])
							+ GetFileList(path, filters[5]);
		return files;
	end;
	
	emails := 'jose.bello@lexisnexisrisk.com, debendra.kumar@lexisnexisrisk.com, Sudhir.Kasavajjala@lexisnexisrisk.com, Fernando.Incarnacao@lexisnexisrisk.com, Wenhong.Ma@lexisnexisrisk.com';
					
	export _spray := sequential(
					nothor(apply(GetFiles(readyDir), STD.File.MoveExternalFile(pServerIP, readyDir + name, sprayingDir + name)))
				 ,Inquiry_AccLogs.fSprayInputFiles(GetFiles(sprayingDir), true)
				 ,nothor(apply(GetFiles(sprayingDir), STD.File.MoveExternalFile(pServerIP, sprayingDir + name, doneDir + name)))				 
				 ,notify('Spray Complete','*')
					) : SUCCESS(FileServices.SendEmail(emails,'FCRA Logs Spray Complete - Inquiry Tracking, Score and Attribute', thorlib.wuid())),
								Failure(FileServices.SendEmail(emails, 'FCRA Input Logs Spray Fail', thorlib.wuid()
                + '\n  *  Please go to bctlpedata10 inquiry_data_01 spray_ready to see what files need to be sprayed. May need gunzip. Resubmit WU.'+'\n' + FAILMESSAGE));
								
end;