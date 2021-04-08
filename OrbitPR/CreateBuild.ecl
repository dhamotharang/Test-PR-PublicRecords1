import ut;

EXPORT CreateBuild(
				string MasterBuildName,
				string BuildVersion,
				string ptoken,

				string Excludefrom_Scorecard = '1',
				string NewCoverage_Area = '1' ,
				string Skipped_Build = '0'
	
				) := module



//Create Build instance

Inputrec := record
string ActualStartDate { xpath('ActualStartDate' )} := ut.GetTimeDate()[1..10]+'T'+ut.GetTimeDate()[11..12]+':'+ut.GetTimeDate()[13..14]+':'+ut.GetTimeDate()[15..16]+'Z';
string BuildName { xpath('BuildName')} := MasterBuildName ;
string BuildVersion { xpath('BuildVersion')} := BuildVersion;
string ExcludefromScorecard { xpath('ExcludeFromScorecard' )} := Excludefrom_Scorecard;
string MasterBuild_Name { xpath('MasterBuildName')} := MasterBuildName;
string NewCoverageArea {xpath('NewCoverageArea' )} := NewCoverage_Area;
string SkippedBuild {xpath('SkippedBuild' )} := Skipped_Build;

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
         
			OrbitPR.EnvironmentVariables.serviceurl,
		'CreateBuild',
		rBuildrequest,
		rStatus,
		NAMESPACE(OrbitPR.EnvironmentVariables.namespace ),
		LITERAL,
		SOAPACTION(OrbitPR.EnvironmentVariables.soapactionprefix + 'PR/CreateBuild'),
		LOG
	) ;	

end;	