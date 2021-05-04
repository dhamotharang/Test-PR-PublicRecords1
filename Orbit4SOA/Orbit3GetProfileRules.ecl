//Sample --> profile type:= 'PublicRecords',pProfileName :='LN_Property_Deeds'

EXPORT Orbit3GetProfileRules (string pProfileType, string pProfileName) := function

	import Orbit3SOA;

	string passPercentagePath := TRIM(CASE(pProfileType, 
		'Scrubs' => 'DynamicProperties/Property[Key="PassPercentage"]/Value',
		'ScrubsAlerts' => 'DynamicProperties/Property[Key="PassPercentage"]/Value',
		''));
	string codePath := TRIM(CASE(pProfileType, 
		'Scrubs' => 'DynamicProperties/Property[Key="Code"]/Value',
		'ScrubsAlerts' => 'DynamicProperties/Property[Key="Code"]/Value',
		''));
	string severityPath := TRIM(CASE(pProfileType, 
		'Scrubs' => 'DynamicProperties/Property[Key="Severity"]/Value',
		'ScrubsAlerts' => 'DynamicProperties/Property[Key="Severity"]/Value',
		''));

	rRecordRequest := record
		string profileName {xpath('ProfileName')} := pProfileName;
		string profileType {xpath('ProfileTypeName')} := pProfileType;
	end;
	rReceivings := record
		rRecordRequest		RecordRequestGetProfileRules	{xpath('RecordRequestGetProfileRules') };
	end;
	rorbRequest := record
		string 				LoginToken											{xpath('Token'),				maxlength(36)}		:=	Orbit3SOA.GetToken().GetLoginToken();
		rReceivings		OrbRequest											{xpath('Request')};
	end;
	rRequestCapsule	:= record
		rorbRequest		Request													{xpath('request')};
	end;
	
	ProfileRule_Rec := record
		integer4 Id {xpath('Id')};
		integer4 ProfileId {xpath('ProfileId')};
		string Name {xpath('Name')};
		boolean IsEnabled {xpath('IsEnabled')};
		string Description {xpath('Description')};
		string RuleType {xpath('Type')};
		string PassPercentage {xpath(passPercentagePath)};
		string Code {xpath(codePath)};
		string Severity {xpath(severityPath)};
	end;
	
	retval := SOAPCALL(
		Orbit3SOA.EnvironmentVariables.serviceurl,
		'GetProfileRules',
		rRequestCapsule,
		dataset(ProfileRule_Rec),
		XPATH('GetProfileRulesResponse/GetProfileRulesResult/Result/RecordResponseGetProfileRules/Result/ProfileRules/RuleModel'),
		NAMESPACE(Orbit3SOA.EnvironmentVariables.namespace),
		LITERAL,
		SOAPACTION(Orbit3SOA.EnvironmentVariables.soapactionprefixPR + 'GetProfileRules')
	);
	output(toxml(row(rRequestCapsule)));
	
	return retval;

end;