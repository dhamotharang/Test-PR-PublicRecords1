import Versioncontrol, _Control, std;

EXPORT fspray_fcra_daily_files := module
	
	pServerIP		:= _control.IPAddress.bctlpedata10;
	rootDir 		:= '/data/inquiry_data_01/';
	readyDir		:= rootDir + 'spray_ready/';
	sprayingDir	:= rootDir + 'spraying/';
	doneDir 		:= rootDir + 'done/';
	errorDir 		:= rootDir + 'error/';

	GetFileList(string path, string pFilenameExp) := function
		pFileList  :=  nothor(FileServices.Remotedirectory(pServerIP,path,pFilenameExp));
		return pFileList;
	end;

	filters := ['banko_batch_fcra*.txt','fcra_log_accounting_log_*.txt','banko_fcra*.txt','batch_fcra*.cat','riskwise_fcra*.txt'];
	
	GetFiles(string path) := function
		pFiles 	:=  GetFileList(path, filters[1])
							+	GetFileList(path, filters[2])
							+ GetFileList(path, filters[3])
							+ GetFileList(path, filters[4])
							+ GetFileList(path, filters[5]);
		return pFiles;
	end;
					
	export _spray := sequential(
					nothor(apply(GetFiles(readyDir), STD.File.MoveExternalFile(pServerIP, readyDir + name, sprayingDir + name)))
				 ,INQL_v2.fSpray(GetFiles(sprayingDir), true)
				 ,nothor(apply(GetFiles(sprayingDir), STD.File.MoveExternalFile(pServerIP, sprayingDir + name, doneDir + name)))
					);		
end;