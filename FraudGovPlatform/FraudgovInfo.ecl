﻿IMPORT PromoteSupers,FraudGovPlatform;
EXPORT fraudgovInfo(
		string pversion = '', 
		string pstatus  = ''
):= 
module
	
		SHARED fn := filenames().OutputF.FraudgovInfoFn;

		SHARED fi_d := dataset(fn,FraudGovPlatform.Layouts.OutputF.FraudgovInfoRec,flat,opt);
		EXPORT PreviousVersion := fi_d[1].PreviousVersion;
		EXPORT Status := fi_d[1].Status;
		SHARED IsNew 	:= if(nothor(fileservices.fileExists(fn)), PreviousVersion <> pversion, true);


		PromoteSupers.MAC_SF_BuildProcess(
				dataset([{PreviousVersion, pversion, pstatus}],FraudGovPlatform.Layouts.OutputF.FraudgovInfoRec), 
				fn,
				PostNewfraudgov,
				2
				,,
				true);
				
		EXPORT postStatus := if(	IsNew
			,sequential(PostNewfraudgov, output('fraudgov_build_version Changed', named('fraudgovInfoChanged')))
			,sequential(output('fraudgov_build_version Not Changed', named('fraudgovInfoNotChanged'))));

		PromoteSupers.MAC_SF_BuildProcess(
				dataset([{pversion, pversion, pstatus}],FraudGovPlatform.Layouts.OutputF.FraudgovInfoRec), 
				fn,
				Finishfraudgov,
				2
				,,
				true);

		EXPORT postFinish := sequential(Finishfraudgov, output('fraudgov_build_version Finished', named('fraudgovInfoFinished')));

END;