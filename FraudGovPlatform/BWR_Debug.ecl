import FraudShared, FraudGovPlatform_Validation, FraudGovPlatform, _Control, Orbit3, Scrubs_MBS, STD, Scrubs_FraudGov;

#CONSTANT	('Platform','FraudGov');
#workunit('priority','high');
pVersion := '20180306';

//create_build
		create_build := Orbit3.proc_Orbit3_CreateBuild_AddItem('FraudGov',pversion);

// Spray MBS
		spray_mbs := sequential(
			  FraudShared.SprayMBSFiles(pversion := pVersion,pGroupName := if(_Control.ThisEnvironment.Name='Dataland','thor400_dev01_2','thor400_30'), pDirectory := FraudGovPlatform_Validation.Constants.MBSLandingZonePathBase)
			, Scrubs_MBS.BuildSCRUBSReport(pversion)  
		);

// Spray Inputs
		spray_inputs := sequential(
			  FraudGovPlatform_Validation.SprayAndQualifyInput(pVersion)
			, FraudGovPlatform_Validation.SprayAndQualifyDeltabase(pVersion)
			, FraudGovPlatform_Validation.SprayAndQualifyNAC(pVersion)
		);

// Build Inputs
		build_inputs := sequential(
			  FraudGovPlatform.Build_Input_KnownFraud(pVersion).all
			, FraudGovPlatform.Build_Input_IdentityData(pVersion).all
			, STD.File.ClearSuperFile(FraudGovPlatform.Filenames().Sprayed._NACPassed, TRUE)
			, STD.File.ClearSuperFile(FraudGovPlatform.Filenames().Sprayed._NACRejected, TRUE)				
			, Scrubs_FraudGov.BuildSCRUBSReport(pversion)
		);

// Build Base
		build_bases := sequential (
			  FraudGovPlatform.Build_Base_KnownFraud(pVersion).all
			, FraudGovPlatform.Build_Base_IdentityData(pVersion).all
			, FraudGovPlatform.Build_Base_AddressCache(pVersion).all
			, FraudGovPlatform.Promote().buildfiles.Built2QA
		);

// Build Main Base				
		build_main := FraudGovPlatform.MapToCommon( pversion ,FraudGovPlatform.Files().Base.IdentityData.Built ,FraudGovPlatform.Files().Base.KnownFraud.Built).Build_Base_Main.All;

// Build Keys
		build_keys := sequential(
			  FraudGovPlatform.Build_All(pVersion).Build_Key_Files
			, FraudShared.Promote().buildfiles.Built2QA
			, FraudShared.Promote().buildfiles.cleanup
			, FraudShared.Promote().Inputfiles.Sprayed2Using
			, FraudShared.Promote().Inputfiles.Using2Used				
		);

		
// Build All
		
		build_fraudgov := sequential(
					  #workunit('name','FRAUDGOV DATA BUILD ' + pVersion)
					, FraudGovPlatform.Create_Supers
					, create_build
					, spray_mbs
					, spray_inputs
					, build_inputs
					, build_bases
					, build_main
					, build_keys			
		);		
		
		build_fraudgov;
			
