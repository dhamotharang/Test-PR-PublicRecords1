import _control;
export	Constants	:=
module
	export	string		LandingZoneServer_prod		:=	_control.IPAddress.bair_batchlz01;
	export	string		LandingZonePathBase_prod	:=	'/data/otto/';

	export	string		LandingZoneServer_dev		:=	_control.IPAddress.bair_batchlz01;
	export	string		LandingZonePathBase_dev		:=	'/data/otto/';

	export	string		LandingZoneFilePathRgx			:=	'^[0-9]+/ready';
	
	export	string		DeltaLandingZonePathBase_dev	:=	'/data/super_credit/fraudgov/in/deltabase/dev/';
	export	string		DeltaLandingZonePathBase_prod	:=	'/data/super_credit/fraudgov/in/deltabase/prod/';

	export	string		VRulesLandingZonePathBase	:=	'/data/otto/velocityrules/';
	
	export	string 		MBSLandingZonePathBase_dev	:='/data/super_credit/fraudgov/in/mbs/dev';
	export	string 		MBSLandingZonePathBase_prod	:='/data/super_credit/fraudgov/in/mbs/prod';
	
	export	string 		FDNMBSLandingZonePathBase_dev		:='/data/super_credit/fdn/in/mbs/prod';
	export	string 		FDNMBSLandingZonePathBase_prod	:='/data/super_credit/fdn/in/mbs/prod';

	export string		ThorName_Dev					:= 'thor400_dev_eclcc';
	export string		ThorName_Prod				:= 'thor400_44_eclcc';
	
	export string		ContributoryDirectory_dev	:= '/data/otto/in/';
	export string		ContributoryDirectory_prod	:= '/data/otto/in/';
	
	export NOC_MSG
		:=
		'** NOC **\n\n'

		+'http://prod_esp:8010/?legacy&inner=../WsWorkunits/WUInfo%3FWuid%3D'+workunit+'\n\n'

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
		+'please contact Oscar.Barrientos@lexisnexis.com and Jose.Bello@lexisnexis.com for assistance.\n'
		;
end;