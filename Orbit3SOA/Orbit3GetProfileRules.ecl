//Sample --> profile type:= 'PublicRecords',pProfileName :='LN_Property_Deeds'

EXPORT Orbit3GetProfileRules (string pProfileType, string pProfileName) := function

	import Orbit3SOA;

	string passPercentagePath := TRIM(CASE(pProfileType, 
		'Scrubs' => 'DynamicProperties/Property[Key="PassPercentage"]/Value',
		'ScrubsAlerts' => 'DynamicProperties/Property[Key="ScrubsAlertsPassPercentage"]/Value',
		''));
	string codePath := TRIM(CASE(pProfileType, 
		'Scrubs' => 'DynamicProperties/Property[Key="Code"]/Value',
		'ScrubsAlerts' => 'DynamicProperties/Property[Key="ScrubsAlertsCode"]/Value',
		''));
	string severityPath := TRIM(CASE(pProfileType, 
		'Scrubs' => 'DynamicProperties/Property[Key="Severity"]/Value',
		'ScrubsAlerts' => 'DynamicProperties/Property[Key="ScrubsAlertsSeverity"]/Value',
		''));

	InputRec := record
		string token {xpath('token')} := Orbit3SOA.GetToken();
		string profileName {xpath('profileName')} := pProfileName;
		string profileType {xpath('profileType')} := pProfileType;
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
		InputRec,
		dataset(ProfileRule_Rec),
		XPATH('GetProfileRulesResponse/GetProfileRulesResult/RuleModel'),
		NAMESPACE(Orbit3SOA.EnvironmentVariables.namespace),
		LITERAL,
		SOAPACTION(Orbit3SOA.EnvironmentVariables.soapactionprefix + 'GetProfileRules')
	);

	return retval;

end;