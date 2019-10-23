import std;

EXPORT CreateBuild(
				string MasterBuildName,
				string BuildVersion,
				string ptoken,
		dataset(Layouts.rPlatformStatus) platformupdates = dataset([],Layouts.rPlatformStatus),

				string Excludefrom_Scorecard = '1',
				string NewCoverage_Area = '1' ,
				string Skipped_Build = '0'
	
				) := module



//Create Build instance
GetTimeDate := Std.Date.SecondsToString(Std.Date.CurrentSeconds(TRUE), '%F%H%M%S%u');
Inputrec := record
string ActualStartDate { xpath('ActualStartDate' )} := GetTimeDate[1..10]+'T'+GetTimeDate[11..12]+':'+GetTimeDate[13..14]+':'+GetTimeDate[15..16]+'Z';
string BuildName { xpath('BuildName')} := MasterBuildName ;
string BuildVersion { xpath('BuildVersion')} := BuildVersion;
string ExcludefromScorecard { xpath('ExcludeFromScorecard' )} := Excludefrom_Scorecard;
string MasterBuild_Name { xpath('MasterBuildName')} := MasterBuildName;
string NewCoverageArea {xpath('NewCoverageArea' )} := NewCoverage_Area;
string SkippedBuild {xpath('SkippedBuild' )} := Skipped_Build;
dataset(Layouts.rPlatformStatus) PlatformStatusUpdates {xpath('Platforms/RecordRequestCreateBuildPlatform' )} := platformupdates ; 

end;

 rBuilds := RECORD
		Inputrec	 RecordRequestCreateBuild	{XPATH('RecordRequestCreateBuild') };
	END;

rCreateBuildRequest	:= RECORD
   string ptoken { xpath('Token')} := ptoken;
		rBuilds		OrbRequest {XPATH('Request')};
	END;
	
	 rBuildrequest := RECORD
		rCreateBuildRequest Orbrequest	{XPATH('request') };
	END;

	
rStatus := RECORD
	STRING	Status {XPATH('CreateBuildResponse/CreateBuildResult/Result/RecordResponseCreateBuild/Status')};
	STRING	Message {XPATH('CreateBuildResponse/CreateBuildResult/Result/RecordResponseCreateBuild/Message')};
	STRING BuildId {XPATH('CreateBuildResponse/CreateBuildResult/Result/RecordResponseCreateBuild/Result/BuildId')};

	end;
	
export retcode := SOAPCALL ( 
         
			Orbit3.EnvironmentVariables.serviceurl,
		'CreateBuild',
		rBuildrequest,
		rStatus,
		NAMESPACE(Orbit3.EnvironmentVariables.namespace ),
		LITERAL,
		SOAPACTION(Orbit3.EnvironmentVariables.soapactionprefix + 'PR/CreateBuild'),
		LOG
	) ;	

end;	