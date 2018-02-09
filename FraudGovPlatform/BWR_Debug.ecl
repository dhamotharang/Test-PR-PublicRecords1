import FraudGovPlatform_Validation,_Control,FraudGovPlatform,FraudShared,STD;
IP:=FraudGovPlatform_Validation.Constants.LandingZoneServer;
RootDir := FraudGovPlatform_Validation.Constants.LandingZonePathBase;
destinationGroup := if(_Control.ThisEnvironment.Name='Dataland','thor50_dev02','thor400_30');
pDirectory:= '/data/super_credit/fraudgov/in/mbs/dev';
pVersion := '20171019f';
#CONSTANT	('Platform','FraudGov');
#workunit('priority','high');

// 1.) Create Supers
		//FraudGovPlatform.Create_Supers;

// 2.) Spray Files
		spray_files 		:= sequential(
				FraudGovPlatform_Validation.SprayAndQualifyInput(pVersion,IP,RootDir,destinationGroup)
			// ,	FraudShared.SprayMBSFiles(pversion := pVersion, pGroupName := 'thor50_dev02', pDirectory := pDirectory)
		);

// 3.) Build Inputs
		build_preppeds := sequential(
				FraudGovPlatform.Build_Input_KnownFraud(pVersion).all
			,	FraudGovPlatform.Build_Input_IdentityData(pVersion).all
			,	FraudGovPlatform.Build_Input_InquiryLogs(pVersion).all
		);

// 4.) Build Base
		build_bases := sequential (
				FraudGovPlatform.Build_Base_KnownFraud( pVersion , FraudGovPlatform.Files().Base.KnownFraud.Built , FraudGovPlatform.Files().Input.KnownFraud.Sprayed , FraudGovPlatform._Flags.Update.KnownFraud ).all
			,	FraudGovPlatform.Build_Base_IdentityData( pVersion , FraudGovPlatform.Files().Base.IdentityData.Built , FraudGovPlatform.Files().Input.IdentityData.Sprayed , FraudGovPlatform._Flags.Update.IdentityData ).all
			,	FraudGovPlatform.Build_Base_InquiryLogs( pVersion , FraudGovPlatform.Files().Base.InquiryLogs.Built , FraudGovPlatform.Files().Input.InquiryLogs.Sprayed , FraudGovPlatform._Flags.Update.InquiryLogs ).all
			,	FraudGovPlatform.Promote().buildfiles.Built2QA
		);

// 5.) Build Main Base				
		build_main := FraudGovPlatform.MapToCommon( pversion ,FraudGovPlatform.Files().Base.IdentityData.Built ,FraudGovPlatform.Files().Base.KnownFraud.Built ,FraudGovPlatform.Files().Base.InquiryLogs.Built).Build_Base_Main.All;

// 6.) Build Keys
		build_keys := sequential(
			FraudGovPlatform.Build_All(pVersion).Build_Key_Files,
			FraudShared.Promote().buildfiles.Built2QA
		);
		
// 7.) Build All
		
		build_all := sequential(
					#workunit('name','FRAUDGOV DATA BUILD ' + pVersion)
					, spray_files
					// , spray_mbs_file
					, build_preppeds
					, build_bases
					, build_main
					// , build_keys
					// FraudShared.Promote().buildfiles.Built2QA;
					// FraudShared.Promote().buildfiles.cleanup;
					// FraudShared.Promote().Inputfiles.Sprayed2Using;
					// FraudShared.Promote().Inputfiles.Using2Used;						
		);		
		
		build_all;
			


















// 8.) Reset All
		// STD.File.ClearSuperFile('~thor_data400::in::fraudgov::passed::IdentityData', true);
		// STD.File.ClearSuperFile('~thor_data400::in::fraudgov::rejected::IdentityData', true);
		// STD.File.ClearSuperFile('~thor_data400::base::fraudgov::built::IdentityData', true);
		// STD.File.ClearSuperFile('~thor_data400::base::fraudgov::qa::IdentityData', true);
		// STD.File.ClearSuperFile('~thor_data400::in::fraudgov::used::IdentityData', true);
		// STD.File.ClearSuperFile('~thor_data400::in::fraudgov::IdentityData', true);
		// STD.File.ClearSuperFile('~thor_data400::in::fraudgov::sprayed::IdentityData', true);	
		// STD.File.ClearSuperFile('~thor_data400::base::fraudgov::father::IdentityData', true);	
		// STD.File.ClearSuperFile('~thor_data400::base::fraudgov::delete::IdentityData', true);	
		// STD.File.ClearSuperFile('~thor_data400::in::fraudgov::sprayed::IdentityData', true);	
		// output(dataset([],FraudGovPlatform.Layouts.base.InquiryLogs),,'~thor_data400::base::fraudgov::20170501::InquiryLogs', compressed, OVERWRITE);
		// STD.File.AddSuperFile('~thor_data400::base::fraudgov::built::InquiryLogs','~thor_data400::base::fraudgov::20170501::InquiryLogs');

// 9.) Rollback MBS
		// STD.File.AddSuperFile('~thor_data400::in::fraudgov::sprayed::mbs', '~thor_data400::in::fraudgov::used::mbs', addcontents := true);
		// STD.File.AddSuperFile('~thor_data400::in::fraudgov::sprayed::mbsnewgcidexclusion', '~thor_data400::in::fraudgov::used::mbsnewgcidexclusion', addcontents := true);
		// STD.File.AddSuperFile('~thor_data400::in::fraudgov::sprayed::mbsindtypeexclusion', '~thor_data400::in::fraudgov::used::mbsindtypeexclusion', addcontents := true);
		// STD.File.AddSuperFile('~thor_data400::in::fraudgov::sprayed::mbsproductinclude', '~thor_data400::in::fraudgov::used::mbsproductinclude', addcontents := true);
		// STD.File.AddSuperFile('~thor_data400::in::fraudgov::sprayed::mbssourcegcexclusion', '~thor_data400::in::fraudgov::used::mbssourcegcexclusion', addcontents := true);
		// STD.File.AddSuperFile('~thor_data400::in::fraudgov::sprayed::mbsfdnindtype', '~thor_data400::in::fraudgov::used::mbsfdnindtype', addcontents := true);
		// STD.File.AddSuperFile('~thor_data400::in::fraudgov::sprayed::mbstablecol', '~thor_data400::in::fraudgov::used::mbstablecol', addcontents := true);
		// STD.File.AddSuperFile('~thor_data400::in::fraudgov::sprayed::mbscolvaldesc', '~thor_data400::in::fraudgov::used::mbscolvaldesc', addcontents := true);
		// STD.File.AddSuperFile('~thor_data400::in::fraudgov::sprayed::mbsfdnmasteridindtypeinclusion', '~thor_data400::in::fraudgov::used::mbsfdnmasteridindtypeinclusion', addcontents := true);

		// STD.File.ClearSuperFile('~thor_data400::in::fraudgov::used::mbs', false);
		// STD.File.ClearSuperFile('~thor_data400::in::fraudgov::used::mbsnewgcidexclusion', false);
		// STD.File.ClearSuperFile('~thor_data400::in::fraudgov::used::mbsindtypeexclusion', false);
		// STD.File.ClearSuperFile('~thor_data400::in::fraudgov::used::mbsproductinclude', false);
		// STD.File.ClearSuperFile('~thor_data400::in::fraudgov::used::mbssourcegcexclusion', false);
		// STD.File.ClearSuperFile('~thor_data400::in::fraudgov::used::mbsfdnindtype', false);
		// STD.File.ClearSuperFile('~thor_data400::in::fraudgov::used::mbstablecol', false);
		// STD.File.ClearSuperFile('~thor_data400::in::fraudgov::used::mbscolvaldesc', false);
		// STD.File.ClearSuperFile('~thor_data400::in::fraudgov::used::mbsfdnmasteridindtypeinclusion', false);
