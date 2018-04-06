import FraudShared, FraudGovPlatform_Validation, FraudGovPlatform, _Control, Orbit3, Scrubs_MBS, STD, Scrubs_FraudGov;

#CONSTANT	('Platform','FraudGov');
#workunit('priority','high');
pVersion := '20180405c';

		
build_fraudgov := sequential(
			  #workunit('name','FRAUDGOV DATA BUILD ' + pVersion)
			, FraudGovPlatform.Build_All(pVersion, PSkipMainBase := true).Build_Base_Files;
);		

build_fraudgov;
			

//create_build
//		create_build := Orbit3.proc_Orbit3_CreateBuild_AddItem('FraudGov',pversion);

// Spray MBS
		// spray_mbs := sequential(
		// 	  FraudShared.SprayMBSFiles(pversion := pVersion,pGroupName := if(_Control.ThisEnvironment.Name='Dataland','thor400_dev01_2','thor400_30'), pDirectory := FraudGovPlatform_Validation.Constants.MBSLandingZonePathBase)
		// 	, Scrubs_MBS.BuildSCRUBSReport(pversion)  
		// );

// Spray Inputs
		// spray_inputs := sequential(
		// 	  FraudGovPlatform_Validation.SprayAndQualifyInput(pVersion)
		// 	, FraudGovPlatform_Validation.SprayAndQualifyDeltabase(pVersion)
		// 	, FraudGovPlatform_Validation.SprayAndQualifyNAC(pVersion)
		// );


// Build Keys
		// build_keys := sequential(
		// 	  FraudGovPlatform.Build_All(pVersion).Build_Key_Files
		// 	, FraudShared.Promote().buildfiles.Built2QA
		// 	, FraudShared.Promote().buildfiles.cleanup
		// 	, FraudShared.Promote().Inputfiles.Sprayed2Using
		// 	, FraudShared.Promote().Inputfiles.Using2Used				
		// );

		
