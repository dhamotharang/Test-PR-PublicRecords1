//Note : Valid PlatformStatus to be passed --  BUILD_IN_PROGRESS,ON_DEVELOPMENT,NO_QA,QA_IN_PROGRESS,PASSED_QA,FAILED_QA,NA,VERIFIED_IN_PRODUCTION,PASSED_QA_NO_ROXIE_RELEASE

import ut;

EXPORT UpdateBuildInstanceold(
				string MasterBuildName,
				string BuildVersion,
				string ptoken,
			  string BuildStatus =  'BUILD_IN_PROGRESS',
				dataset(Layouts.rPlatformStatus) platformupdates = dataset([],Layouts.rPlatformStatus),
				string NewCoverage_Area = '1',
				string Excludefrom_Scorecard = '1',
				string Skipped_Build = '0'
				) := module



Inputrec :=  record
string BuildName { xpath('BuildName')} := MasterBuildName ;
string BuildVersion { xpath('BuildVersion')} := BuildVersion;
string BuildStatus { xpath('BuildStatus')} := BuildStatus;
string NewCoverageArea {xpath('NewCoverageArea' )} := NewCoverage_Area;
string ExcludefromScorecard { xpath('ExcludeFromScorecard' )} := Excludefrom_Scorecard;
string SkippedBuild {xpath('SkippedBuild' )} := Skipped_Build;
dataset(Layouts.rPlatformStatus) PlatformStatusUpdates {xpath('PlatformStatusUpdates/PlatformStatusUpdate' )} := platformupdates ; 
end;


 rBuilds := RECORD
		Inputrec	 RecordRequestUpdateBuildInstance	{XPATH('RecordRequestUpdateBuildInstance') };
	END;

rUpdateBuildRequest	:= RECORD
   string ptoken { xpath('Token')} := ptoken;
		rBuilds	OrbRequest  {XPATH('Request')};
	END;
	
	 rBuildrequest := RECORD
		rUpdateBuildRequest	Orbrequest	{XPATH('request') };
	END;


	rStatus := RECORD
		STRING	Status	{XPATH('UpdateBuildInstanceResponse/UpdateBuildInstanceResult/Result/RecordResponseUpdateBuildInstance/Status')};
	  STRING	Message {XPATH('UpdateBuildInstanceResponse/UpdateBuildInstanceResult/Result/RecordResponseUpdateBuildInstance/Message')};

end;

export retcode := SOAPCALL (         
			OrbitPR.EnvironmentVariables.serviceurl(false),
		'UpdateBuildInstance',
		rBuildrequest,
		rStatus,
		NAMESPACE(OrbitPR.EnvironmentVariables.namespace ),
		LITERAL,
		SOAPACTION(OrbitPR.EnvironmentVariables.soapactionprefix + 'PR/UpdateBuildInstance'),
		LOG
	) ;	
end;	