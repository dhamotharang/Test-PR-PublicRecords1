﻿import _control;
export	Constants	:=
module
	export	string		LandingZoneServer_prod		:=	_control.IPAddress.bctlpedata10;
	export	string		LandingZonePathBase_prod	:=	'/data/super_credit/fraudgov/in/contributions/';

	export	string		LandingZoneServer_dev		:=	_control.IPAddress.bctlpedata12;
	export	string		LandingZonePathBase_dev		:=	'/data/super_credit/fraudgov/in/contributions/';

	export	string		LandingZoneFilePathRgx			:=	'^[0-9]+/ready';
	
	export	string		DeltaLandingZonePathBase_dev	:=	'/data/super_credit/fraudgov/in/deltabase/prod/';
	export	string		DeltaLandingZonePathBase_prod	:=	'/data/super_credit/fraudgov/in/deltabase/prod/';

	export	string		RDPLandingZonePathBase_dev	:=	'/data/super_credit/fraudgov/in/rdp/prod/';
	export	string		RDPLandingZonePathBase_prod	:=	'/data/super_credit/fraudgov/in/rdp/prod/';

	export	string		DEDILandingZonePathBase_dev	:=	'/data/super_credit/fraudgov/in/dedi/prod/';
	export	string		DEDILandingZonePathBase_prod	:=	'/data/super_credit/fraudgov/in/dedi/prod/';

	export	string		VRulesLandingZonePathBase	:=	'/data/otto/velocityrules/';
	
	export	string 		MBSLandingZonePathBase_dev	:='/data/super_credit/fraudgov/in/mbs/dbexport/prod';
	export	string 		MBSLandingZonePathBase_prod	:='/data/super_credit/fraudgov/in/mbs/dbexport/prod';
	
	export	string 		FDNMBSLandingZonePathBase_dev		:='/data/super_credit/fdn/in';
	export	string 		FDNMBSLandingZonePathBase_prod	:='/data/super_credit/fdn/in';

	export string		ThorName_Dev					:= 'thor400_dev_eclcc';
	export string		ThorName_Prod				:= 'thor400_36_eclcc';

	export string		hthor_Dev						:= 'hthor_dev_eclcc';
	export string		hthor_Prod					:= 'hthor_eclcc';
	
	export string		Shell_ThorName_Dev		:= 'thor50_dev_eclcc';
	export string		Shell_ThorName_Prod		:= 'pound_option_thor_eclcc';
	
	export string		ContributoryDirectory_dev	:= '/data/otto/in/';
	export string		ContributoryDirectory_prod	:= '/data/otto/in/';
	
	export NOC_MSG
		:=
		'** NOC **\n\n'

		+'http://prod_esp.br.seisint.com:8010/?Widget=WUDetailsWidget&Wuid='+workunit+'#/stub/Summary\n\n'

		+'Please investigate cause of failure of workunit '+workunit+' linked\n'
		+'above in Boca Prod.  Then please resubmit it to ensure FraudGov ingest process\n'
		+'is running.\n\n'

		+'If the error message includes mention of "SOAP RPC error" or similar, this has historically\n'
		+'meant one or more Prod Thor ESP services require a bounce.\n\n'

		+'If this failure has occurred during the maintenance window, it is possibly related to network\n'
		+'or other updates/changes. Please resubmit knowing it is possible that it may fail again if\n'
		+'maintenance is ongoing, it may fail again.  In that case, you may delay resubmission temporarily,\n'
		+'but please do not forget.\n\n'

		+'If issues persist/repeat outside the Sunday maintenance window,\n'
		+'please contact Oscar.Barrientos@lexisnexisrisk.com (+13058126820) or Sesha.Nookala@lexisnexisrisk.com for assistance.\n'
		;
end;