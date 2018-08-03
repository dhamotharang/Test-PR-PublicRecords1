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
				
		EXPORT postNewStatus := if(	IsNew
			,sequential(WriteFile, output('fraudgov_build_version Changed', named('fraudgovInfoChanged')))
			,sequential(output('fraudgov_build_version Not Changed', named('fraudgovInfoNotChanged'))));

		PromoteSupers.MAC_SF_BuildProcess(
				dataset([{pVersion, pVersion, pStatus}],FraudGovPlatform.Layouts.OutputF.FraudgovInfoRec), 
				fn,
				FixFile,
				2
				,,
				true);
				
		EXPORT fixStatus := sequential(FixFile, output('fraudgov_build_version Fixed', named('fraudgovInfoFixed')));
END;