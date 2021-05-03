IMPORT _Control;

EXPORT Constants := MODULE

	EXPORT string EDATA11 := _control.IPAddress.edata11;
	
	string landingPort := _control.PortAddress.esp_html;

	EXPORT thisEnvironmentName := _control.ThisEnvironment.Name;
	EXPORT boolean is_running_in_prod :=  thisEnvironmentName = 'Prod_Thor';	
	
	EXPORT lnpr_IN 			:= '~prte::in::lnpr::relate';
	EXPORT lnpr_DBA_IN 	:= '~prte::in::lnpr::dba';
	
	EXPORT Linkids 			:= '~prte::base::lnpr::relate';
	EXPORT DBA_Linkids 	:= '~prte::base::lnpr::dba';
	
	EXPORT Prefix				:='~prte::';
	
	EXPORT ipaddr_prod					 := '10.173.44.105';  //prod IP
	EXPORT ipaddr_dataland			 := '10.173.14.204';  //dataland IP
	EXPORT ipaddr_roxie_nonfcra  := '10.173.101.101'; //roxie non fcra IP
//	EXPORT ipaddr_roxie_fcra		 := '10.173.235.23';  //roxie fcra IP
	EXPORT ipaddr_roxie_fcra		 := '10.173.162.41';  //roxie fcra IP
															 	
END;