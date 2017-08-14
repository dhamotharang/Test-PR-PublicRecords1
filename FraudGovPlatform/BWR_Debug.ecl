import FraudGovPlatform_Validation,_Control,FraudGovPlatform,FraudShared,STD;
IP:=FraudGovPlatform_Validation.Constants.LandingZoneServer;
RootDir := FraudGovPlatform_Validation.Constants.LandingZonePathBase;
destinationGroup := if(_Control.ThisEnvironment.Name='Dataland','thor50_dev','thor400_30');
pVersion := '20170613';
#CONSTANT	('Platform','FraudGov');

// 1.) Create Supers
		// FraudGovPlatform.Create_Supers;

// 2.) Spray Files
		// FraudGovPlatform_Validation.SprayAndQualifyInput(pVersion,IP,RootDir,destinationGroup);
		
		// Spray MBS Files
		//FraudShared.SprayMBSFiles(pversion := pVersion);

// 3.) Build Inputs
		// FraudGovPlatform.Build_Input_IdentityData(pVersion).all;

// 4.) Build Base
		// FraudGovPlatform.Build_Base_IdentityData( pVersion , FraudGovPlatform.Files().Base.IdentityData.Built , FraudGovPlatform.Files().Input.IdentityData.Sprayed , FraudGovPlatform._Flags.Update.IdentityData ).all;
		// FraudGovPlatform.Promote().buildfiles.Built2QA;
		
// 5.) Build Main Base		
		FraudGovPlatform.MapToCommon( pversion ,FraudGovPlatform.Files().Base.IdentityData.Built ,FraudGovPlatform.Files().Base.KnownFraud.Built ).Build_Base_Main.All;

// 6.) Build Keys
		// FraudGovPlatform.Build_All(pVersion).Build_Key_Files
		
// 7.) Finalize
		// FraudShared.Promote().buildfiles.Built2QA;
		// FraudShared.Promote().buildfiles.cleanup;
		// FraudShared.Promote().Inputfiles.Sprayed2Using;
		// FraudShared.Promote().Inputfiles.Using2Used;				


// 8.) Reset All
		// STD.File.ClearSuperFile('~thor_data400::in::fraudgov::passed::IdentityData', true);
		// STD.File.ClearSuperFile('~thor_data400::in::fraudgov::rejected::identitydata', true);
		// STD.File.ClearSuperFile('~thor_data400::base::fraudgov::built::IdentityData', true);
		// STD.File.ClearSuperFile('~thor_data400::base::fraudgov::qa::IdentityData', true);
		// STD.File.ClearSuperFile('~thor_data400::in::fraudgov::used::IdentityData', true);
		// STD.File.ClearSuperFile('~thor_data400::in::fraudgov::IdentityData', true);
		// STD.File.ClearSuperFile('~thor_data400::in::fraudgov::sprayed::IdentityData', true);	
		// STD.File.ClearSuperFile('~thor_data400::base::fraudgov::father::IdentityData', true);	
		// STD.File.ClearSuperFile('~thor_data400::base::fraudgov::delete::IdentityData', true);	
		// STD.File.ClearSuperFile('~thor_data400::in::fraudgov::sprayed::bypassed_identitydata', true);	
		// output(dataset([],FraudGovPlatform.Layouts.base.IdentityData),,'~thor_data400::base::fraudgov::20170501::IdentityData', compressed, OVERWRITE);
		// STD.File.AddSuperFile('~thor_data400::base::fraudgov::built::IdentityData','~thor_data400::base::fraudgov::20170501::IdentityData');

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
