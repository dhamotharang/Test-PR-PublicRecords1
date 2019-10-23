IMPORT _Control;

EXPORT Constants := MODULE

	EXPORT string EDATA11 := _control.IPAddress.edata11;
	
	string landingPort := _control.PortAddress.esp_html;

	EXPORT thisEnvironmentName := _control.ThisEnvironment.Name;
	EXPORT boolean is_running_in_prod :=  thisEnvironmentName = 'Prod_Thor';	
	
	EXPORT lnpr_IN := '~prte::in::lnpr::relate';
	EXPORT lnpr_DBA_IN := '~prte::in::lnpr::dba';
	
	EXPORT Linkids := '~prte::base::lnpr::relate';
	EXPORT DBA_Linkids := '~prte::base::lnpr::dba';
	
	EXPORT Prefix:='~prte::';
															 	
END;