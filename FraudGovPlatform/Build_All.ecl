
/**************************************************************************************************************************************************/
/* PROJECT: RISK INTELLIGENCE NETWORK - AKA: RIN, OTTO, FraudGov
/* DOCUMENTATION: https://confluence.rsi.lexisnexis.com/display/GTG/OTTO+-+Data+Build
/* AUTHORS: DATA ENGINEERING (JOSE BELLO, SESHA NOOKALA, OSCAR BARRIENTOS)
/**************************************************************************************************************************************************/
import tools, _control, FraudShared, Orbit3, FraudGovPlatform_Validation, STD, FraudGovPlatform_Analytics;

export Build_All(
	 string pversion 	
) :=
module

	// Load Files Once
	shared SkipModules := Files().OutputF.SkipModules;
	shared MBS_File := FraudShared.Files().Input.MBS.sprayed;
	shared Main_Built := FraudShared.Files().Base.Main.Built;
	
	// Vars
	shared Test_Build := Mac_TestBuild(pversion);
	shared Test_RecordID := Mac_TestRecordID(pversion);
	shared Test_RinID := Mac_TestRinID(pversion);	
	shared pBaseMainBuilt := File_keybuild(Main_Built);	
	shared pRunProd := False; // Default to Cert. Refreshs the RIN Analytics Dashboard in CERT/PROD 
	shared pUseProdData := True; // Default to prod data. The data used to refresh the RIN Analytics Dashboard

	// Skip Modules if they are no enabled	
	shared SkipBasePortion := SkipModules[1].SkipBaseBuild;
	shared SkipBaseRollback := SkipModules[1].SkipBaseRollback;
	shared SkipKeysPortion := SkipModules[1].SkipKeysBuild;
	shared SkipPiiBuild := SkipModules[1].SkipPiiBuild;
	shared SkipKelBuild := SkipModules[1].SkipKelBuild;
	shared SkipOrbitBuild := SkipModules[1].SkipOrbitBuild;
	shared SkipDashboardsBuild := SkipModules[1].SkipDashboardsBuild; 

	// Modules
	shared Run_MBS := FraudGovPlatform_Validation.SprayMBSFiles( pversion := pVersion[1..8] );
	shared Run_Scrubs := Build_Scrubs(pversion,SkipModules);
	shared Run_Deltabase := FraudGovPlatform_Validation.SprayAndQualifyDeltabase(pversion);
	shared Run_Inputs := Build_Input(pversion, MBS_File, SkipModules).All;
	shared Add_Demo := if(_Flags.UseDemoData, STD.File.AddSuperFile(FraudShared.Filenames().Base.Main.Built, Filenames().Input.DemoData.Sprayed));
	shared Run_Base := Build_Base(pversion, MBS_File).All;
	shared Run_Rollback := if(SkipBaseRollback=false,Rollback('',Test_Build,Test_RecordID,Test_RinID).All);
	shared Run_Autokeys := FraudShared.Build_AutoKeys(pversion, pBaseMainBuilt);
	shared Run_Keys := sequential(FraudShared.Build_Keys( pversion, pBaseMainBuilt).All, Add_Demo, Run_Autokeys);
	shared Run_SoapAppends := if(SkipPiiBuild=false,FraudGovPlatform.Build_Base_Pii(pversion).All);
	shared Run_Kel := if(SkipKelBuild=false,FraudGovPlatform.Build_Kel(pversion).All);
	shared Run_Orbit := if(SkipOrbitBuild=false, Orbit3.proc_Orbit3_CreateBuild_AddItem('FraudGov',pversion)); //Create Orbit Builds
	shared Run_Dashboards := if(SkipDashboardsBuild=false,FraudGovPlatform_Analytics.GenerateDashboards(pRunProd,pUseProdData));
	shared Set_Version := FraudgovInfo(pversion,'Keys_Completed').SetPreviousVersion;
	
//	export dops_update := RoxieKeyBuild.updateversion('IdentityDataKeys', pversion, _Control.MyInfo.EmailAddressNotify,,'N'); 															
	
	export base_portion := sequential(
		 Create_Supers
		// Spray MBS
		,Run_MBS
		// Spray Deltabase
		,Run_Deltabase
		// Clean Inputs
		,Run_Inputs
		// Promote Input Files
		,Promote(pversion).promote_inputs
		// RUn MBS Scrubs
		,Run_Scrubs	
		// Build Base
		,Run_Base
		// Promote Fraudgov Base
		,Promote(pversion).promote_base

		,notify('Base_Completed','*')		
	);
	
	export keys_portion := sequential(
		// Build FraudGov Keys	
		 Run_Keys
		// Create SOAP appends
		,Run_SoapAppends
		// Build KEL keys & files
		,Run_Kel
		// Promote Keys
		,Promote(pversion).promote_keys
		// Build Orbit
		,Run_Orbit
		// Build Dashboards
		,Run_Dashboards
		// Complete and set version
		,Set_Version	
					
	) : success(Send_Emails(pversion).Roxie), failure(Send_Emails(pversion).BuildFailure);	
		 	
	export Build_FraudGov_Base := 
	if(tools.fun_IsValidVersion(pversion),
		if(SkipBasePortion=false, base_portion),
		output('No Valid version parameter passed, skipping FraudGovPlatform.Build_Base')
	);

	export Build_Fraudgov_Keys :=
	if(tools.fun_IsValidVersion(pversion),
		if( Test_Build = 'Passed' and  Test_RecordID = 'Passed' and Test_RinID = 'Passed',
			// If Base is valid then Build Keys
			if(SkipKeysPortion=false, 
				keys_portion), 
			// else Rollback Base file
			Run_Rollback)
		,output('No Valid version parameter passed, skipping FraudGovPlatform.Build_Keys')
	);
	
	export All :=
	if(tools.fun_IsValidVersion(pversion),
		 sequential(
			if(SkipBasePortion=false, base_portion),
		 	if(SkipKeysPortion=false, keys_portion))
		,output('No Valid version parameter passed, skipping FraudGovPlatform.All')
	);

	//	Scrubs (Which require ORBIT)
	EXPORT	ScrubsReports	:=	
	IF(tools.fun_IsValidVersion(pversion)
		,Scrubs_MBS.BuildSCRUBSReport(pversion, emailList := Email_Notification_Lists().Stats)
		,Scrubs_FraudGov.BuildSCRUBSReport(pversion, emailList := Email_Notification_Lists().Stats)
		,OUTPUT('No Valid version parameter passed, skipping FraudGovPlatform.Build_All().ScrubsReports')
	) : SUCCESS(Send_Emails(pversion,pBuildMessage:='MBS Scrubs are complete').BuildMessage),
			FAILURE(Send_Emails(pversion).BuildFailure);
			
end;