﻿IMPORT PromoteSupers,FraudGovPlatform;
EXPORT fraudgovInfo(
		string pVersion = '', 
		string pStatus  = ''
):= 
module
	
		SHARED fn := filenames().OutputF.FraudgovInfoFn;

		SHARED fi_d := dataset(fn,FraudGovPlatform.Layouts.OutputF.FraudgovInfoRec,flat,opt);
		EXPORT PreviousVersion := if(fi_d[1].PreviousVersion != '', fi_d[1].PreviousVersion, pVersion);
		EXPORT CurrentStatus := fi_d[1].Status;
		SHARED IsNew 	:= if(nothor(fileservices.fileExists(fn)), PreviousVersion <> pVersion or CurrentStatus <> pStatus, true);


		PromoteSupers.MAC_SF_BuildProcess(
				dataset([{PreviousVersion, pVersion, pStatus}],FraudGovPlatform.Layouts.OutputF.FraudgovInfoRec), 
				fn,
				WriteFile,
				2
				,,
				true);
				
		EXPORT postNewStatus := if(	IsNew,WriteFile);

		PromoteSupers.MAC_SF_BuildProcess(
				dataset([{pVersion, pVersion, pStatus}],FraudGovPlatform.Layouts.OutputF.FraudgovInfoRec), 
				fn,
				WritePreviousVersion,
				2
				,,
				true);
				
		EXPORT SetPreviousVersion := sequential(WritePreviousVersion, output('fraudgov_build_version Fixed', named('fraudgovInfoFixed')));
END;