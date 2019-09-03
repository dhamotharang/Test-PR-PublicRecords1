export SubmitStat (dataset pScrubResult, string pProfileName, string pProfileType, string pProfileVersion, string pFiletype = '') := function

	import Lib_FileServices, Lib_ThorLib, Lib_StringLib, _Control;
	
	#uniquename(clean)
	#uniquename(profileType)
	#uniquename(profileName)
	#uniquename(profileVersion)
	#uniquename(thorFilename)
	#uniquename(destFilename)
	#uniquename(saveToFile)
	#uniquename(desprayToServer)
	#uniquename(submitStatToOrbit)
	
	string %clean%(string s) := 
		stringlib.stringfindreplace(
		stringlib.stringfindreplace(
		stringlib.stringfindreplace(
		stringlib.stringfindreplace(
			stringlib.stringfilterout(s, ' ')
		,'&','_')
		,'-','_')
		,'::','_')
		,':','_');
	
	%profileType% := %clean%(if(pProfileType = '', 'type', pProfileType));
	%profileName% := %clean%(if(pProfileName = '', 'profile', pProfileName));
	%profileVersion% := %clean%(if(pProfileVersion = '', 'version', pProfileVersion));
	%thorFilename% := Orbit3SOA.EnvironmentVariables.statLogicalFilePrefix + %profileType% + '::' + %profileName% + '::' + %profileVersion% + '::' + thorlib.wuid() + '.csv';
	%destFilename% := Orbit3SOA.EnvironmentVariables.statLandingZoneFilePrefix + %profileType% + '-' + %profileName% + '-' + %profileVersion% + '-' + thorlib.wuid() + '.csv';

	%saveToFile% := output(pScrubResult,, %thorFilename%, csv(heading(single),separator(','),terminator('\r\n'),quote('"'),maxlength(65535),notrim),named('StatData'+pFiletype),OVERWRITE); 	
	%desprayToServer% := Lib_FileServices.FileServices.Despray(%thorFilename%, Orbit3SOA.EnvironmentVariables.statLandingZoneServer, %destFilename%,,,,true);

	inputRec := record
		string token {xpath('token')} := Orbit3SOA.GetToken();
		string profileName {xpath('profileName')} := %profileName%;
		string profileTypeName {xpath('profileTypeName')} := %profileType%;
		string version {xpath('version')} := %profileVersion%;
		string wuid {xpath('wuid')} := thorlib.wuid();
	end;
	
	outputRec := record
		string faultcode {xpath('Fault/faultcode')};
		string faultstring {xpath('Fault/faultstring')};
	end;

	%submitStatToOrbit% := output(SOAPCALL(
		Orbit3SOA.EnvironmentVariables.serviceurl,
		'SubmitStat',
		InputRec,
		DATASET(outputRec),
		RETRY(3),
		TIMELIMIT(60),
		NAMESPACE(Orbit3SOA.EnvironmentVariables.namespace),
		LITERAL,
		SOAPACTION(Orbit3SOA.EnvironmentVariables.soapactionprefix + 'SubmitStat')
	), NAMED('SubmitStatError'+pFiletype),OVERWRITE);
	
	return 
			sequential(%saveToFile%,%desprayToServer%,%submitStatToOrbit%);
		
end;

