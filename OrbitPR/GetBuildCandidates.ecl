
EXPORT GetBuildCandidates(
				string BuildName,
				string BuildVersion,
				string ptoken,
				string BuildInstanceID
	
				) := function



Inputrec :=  record
string BuildName { xpath('BuildName')} := BuildName ;
string BuildVersion { xpath('BuildVersion')} := BuildVersion;

string BuildInstanceID { xpath('BuildInstanceId')} := BuildInstanceID ; 
end;


 rBuilds := RECORD
		Inputrec	 RecordRequestGetBuildCandidates	{XPATH('RecordRequestGetBuildCandidates') };
	END;

rUpdateBuildRequest	:= RECORD
   string ptoken { xpath('Token')} := ptoken;
		rBuilds	OrbRequest  {XPATH('Request')};
	END;
	
	 rBuildrequest := RECORD
		rUpdateBuildRequest	Orbrequest	{XPATH('request') };
	END;


	rBuildData	:=	record
		string										ComponentType											{xpath('ComponentType')};
		string										DataType													{xpath('DataType')};
		string										Family														{xpath('Family')};
		string										Id																{xpath('Id')};
		string										Name															{xpath('Name')};
		string										Status														{xpath('Status')};
		string										Version														{xpath('Version')};
	end;

	rBuildComponents :=	record
		Dataset(rBuildData)				BuildComponent										{xpath('BuildComponent')};	
	end;
	
	rResults :=	record
		rBuildComponents					Result 														{xpath('Result')};		
		string										Status														{xpath('Status')};
		string										Message														{xpath('Message')};
		string										BuildInstanceId										{xpath('BuildInstanceId')}		;
		string										BuildName													{xpath('BuildName')}		;
		string										BuildVersion											{xpath('BuildVersion')}		;
	end;

	rGetBuildCandidates :=	record
		rResults									RecordResponseGetBuildCandidates	{xpath('RecordResponseGetBuildCandidates')}
	end;

	rResponse :=	record
		rGetBuildCandidates				Result 														{xpath('Result')};		
		string										Status														{xpath('Status')};
		string										Message														{xpath('Message')};
	end;
	
	rBuildCandidateResult := 	record
			rResponse 							GetBuildCandidatesResult					{xpath('GetBuildCandidatesResult')};
	end;	
	
	rSOAPResponse	:=
	record
		rBuildCandidateResult			XMLResponse												{xpath('GetBuildCandidatesResponse'), 		maxlength(5000000)};
	end;

 rSOAPResponse		lResponse := SOAPCALL (         
			OrbitPR.EnvironmentVariables.serviceurl,
		'GetBuildCandidates',
		rBuildrequest,
		rSOAPResponse,
		NAMESPACE(OrbitPR.EnvironmentVariables.namespace ),
		LITERAL,
		SOAPACTION(OrbitPR.EnvironmentVariables.soapactionprefix + 'PR/GetBuildCandidates'),
		LOG
	) ;	
	
			dataset(rBuildData) rv1	:=	lResponse.XMLResponse.GetBuildCandidatesResult.Result.RecordResponseGetBuildCandidates.Result.BuildComponent; 
return rv1;
end;	