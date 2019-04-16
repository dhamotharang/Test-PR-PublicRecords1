
/**************************************************************************************************************************************************/
/* PROJECT: RISK INTELLIGENCE NETWORK - AKA: RIN, OTTO, FraudGov
/* DOCUMENTATION: https://confluence.rsi.lexisnexis.com/display/GTG/OTTO+-+Data+Build
/* AUTHORS: DATA ENGINEERING (SESHA NOOKALA, OSCAR BARRIENTOS)
/**************************************************************************************************************************************************/
import tools, _control, FraudShared, Orbit3, FraudGovPlatform_Validation, STD, FraudGovPlatform_Analytics;

export Build_All(
	 string pversion 	
) :=
module

	// Load Files Once
	shared SkipModules := Files().Flags.SkipModules;
	shared MBS_File := FraudShared.Files().Input.MBS.sprayed;
	shared Main_Built := FraudShared.Files().Base.Main.Built;
	
	// Vars
	shared pBaseMainBuilt := File_keybuild(Main_Built);	
	shared pRunProd := False; // Default to Cert. Refreshs the RIN Analytics Dashboard in CERT/PROD 
	shared pUseProdData := True; // Default to prod data. The data used to refresh the RIN Analytics Dashboard

	// Skip Modules if they are no enabled	
	shared SkipInputBuild := SkipModules[1].SkipInputBuild;
	shared SkipBaseBuild := SkipModules[1].SkipBaseBuild;
	shared SkipMainBuild := SkipModules[1].SkipMainBuild;	
	shared SkipKeysBuild := SkipModules[1].SkipKeysBuild;
	shared SkipNACBuild := SkipModules[1].SkipNACBuild;
	shared SkipInquiryLogsBuild := SkipModules[1].SkipInquiryLogsBuild;
	shared SkipPiiBuild := SkipModules[1].SkipPiiBuild;
	shared SkipKelBuild := SkipModules[1].SkipKelBuild;
	shared SkipOrbitBuild := SkipModules[1].SkipOrbitBuild;
	shared SkipDashboardsBuild := SkipModules[1].SkipDashboardsBuild;
	shared SkipMBS := SkipModules[1].SkipMBS;
	shared SkipDeltabase := SkipModules[1].SkipDeltabase;
	shared SkipScrubs := SkipModules[1].SkipScrubs;
	shared SkipRefreshHeader := SkipModules[1].SkipRefreshHeader;
	shared SkipRefreshAddresses := SkipModules[1].SkipRefreshAddresses;
	shared SkipGarbageCollector := SkipModules[1].SkipGarbageCollector;
	shared SkipBaseRollback := SkipModules[1].SkipBaseRollback;

	// Modules
	export Run_MBS			:= if(SkipMBS = false,FraudGovPlatform_Validation.SprayMBSFiles( pversion := pVersion[1..8] ));
	export Run_Scrubs		:= if(SkipScrubs = false,Build_Scrubs(pversion,SkipModules));
	export Run_Deltabase 	:= if(SkipDeltabase = false, FraudGovPlatform_Validation.SprayAndQualifyDeltabase(pversion));
	export Run_NAC 			:= if(SkipNACBuild = false, FraudGovPlatform_Validation.SprayAndQualifyNAC(pversion));
	export Run_InquiryLogs	:= if(SkipInquiryLogsBuild = false, FraudGovPlatform_Validation.SprayAndQualifyInquiryLogs(pversion));

	export Run_Inputs 	:= if(SkipInputBuild = false,Build_Input(pversion, MBS_File).All);	
	export Run_Base 	:= if(SkipBaseBuild = false,Build_Base(pversion, MBS_File).All);
	export Run_Main		:= if(SkipMainBuild = false,Build_Main(pversion).All);

	// Test and promote Main
	export Test_Build := Mac_TestBuild(pversion):independent;
	export Test_RecordID := Mac_TestRecordID(pversion):independent;
	export Test_RinID := Mac_TestRinID(pversion):independent;

	export Promote_Base := Promote(pversion).promote_base;
	export promote_sprayed_files := promote(pversion).promote_sprayed_files;
	export postNewStatus := FraudgovInfo(pversion,'Base_Completed').postNewStatus;
	//export notify_Base_Completed := notify('Base_Completed','*');
	export Run_Rollback := if(SkipBaseRollback = false, Rollback('',Test_Build,Test_RecordID,Test_RinID).All);

	export Publish_Base 
	:= if( 
		Test_Build = 'Passed' and Test_RecordID = 'Passed' and 	Test_RinID = 'Passed', 
			sequential(
				Promote_Base,
				promote_sprayed_files,
				postNewStatus,
				//notify_Base_Completed
				),
			Run_Rollback);


	// --
	export Run_GarbageCollector := if(SkipGarbageCollector = false,Garbage_Collector.Run);
	// --
	export Run_Autokeys := FraudShared.Build_AutoKeys(pversion, pBaseMainBuilt);
	export Add_Demo := if(_Flags.UseDemoData,Append_DemoData(pversion));
	export Run_Keys := if(SkipKeysBuild = false, sequential(FraudShared.Build_Keys( pversion, pBaseMainBuilt).All, Add_Demo, Run_Autokeys));
	export Run_SoapAppends := if(SkipPiiBuild=false,FraudGovPlatform.Build_Base_Pii(pversion).All);
	export Run_Kel := if(SkipKelBuild=false,FraudGovPlatform.Build_Kel(pversion).All);
	export Run_Orbit := if(SkipOrbitBuild=false, Orbit3.proc_Orbit3_CreateBuild_AddItem('FraudGov',pversion)); //Create Orbit Builds
	export Run_Dashboards := if(SkipDashboardsBuild=false,FraudGovPlatform_Analytics.GenerateDashboards(pRunProd,pUseProdData));
	export Set_Version := FraudgovInfo(pversion,'Keys_Completed').SetPreviousVersion;

//	export dops_update := RoxieKeyBuild.updateversion('IdentityDataKeys', pversion, _Control.MyInfo.EmailAddressNotify,,'N'); 															
	
	export base_portion := sequential(
		 Create_Supers
		,Run_Inputs
		,Run_Base
		,Run_Main
		,Publish_Base
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
		// Delete / Archive temp & unused files.
		,Run_GarbageCollector		
		// Complete and set version
		,Set_Version	
					
	) : success(Send_Emails(pversion).Roxie), failure(Send_Emails(pversion).BuildFailure);	
		 	
	export Build_FraudGov_Base := 
	if(tools.fun_IsValidVersion(pversion),
		base_portion,
		output('No Valid version parameter passed, skipping FraudGovPlatform.Build_Base'));

	export Build_Fraudgov_Keys :=
	if(tools.fun_IsValidVersion(pversion)  
		and SkipMainBuild = false 
		and Test_Build = 'Passed' 
		and Test_RecordID = 'Passed' 
		and Test_RinID = 'Passed',
		keys_portion,
		output('No Valid version parameter passed, skipping FraudGovPlatform.Build_Keys'));
	
	
	export All :=
	if(tools.fun_IsValidVersion(pversion),
		 sequential(
			Build_FraudGov_Base,
		 	Build_Fraudgov_Keys )
		,output('No Valid version parameter passed, skipping FraudGovPlatform.All'));
		
end;