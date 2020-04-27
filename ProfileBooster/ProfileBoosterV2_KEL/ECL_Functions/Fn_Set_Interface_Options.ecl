IMPORT Business_Risk_BIP, ProfileBooster.ProfileBoosterV2_KEL;

EXPORT Fn_Set_Interface_Options(ProfileBoosterV2_KEL.Interface_Options OptionsRaw, ProfileBoosterV2_KEL.CFG_Compile KEL_Settings = ProfileBoosterV2_KEL.CFG_Compile) := MODULE(ProfileBoosterV2_KEL.Interface_Options)
		EXPORT UNSIGNED8 KEL_Permissions_Mask := ProfileBoosterV2_KEL.ECL_Functions.Fn_KEL_DPMBitmap.Generate(
			OptionsRaw.Data_Restriction_Mask, 
			OptionsRaw.Data_Permission_Mask, 
			OptionsRaw.GLBAPurpose, 
			OptionsRaw.DPPAPurpose, 
			OptionsRaw.isFCRA, 
			OptionsRaw.isMarketing, 
			OptionsRaw.Allowed_Sources = Business_Risk_BIP.Constants.AllowDNBDMI,
			OptionsRaw.Override_Experian_Restriction,
			OptionsRaw.PermissiblePurpose,
			OptionsRaw.IndustryClass,
			KEL_Settings);
		
		// Since ECL doesn't provide an elegant way to simply override a single option (KEL_Permissions_Mask), need to remap everything in the interface here
		EXPORT STRING AttributeSetName := OptionsRaw.AttributeSetName;
		EXPORT STRING VersionName := OptionsRaw.VersionName;
		EXPORT BOOLEAN isFCRA := OptionsRaw.isFCRA;
		EXPORT STRING ArchiveDate := OptionsRaw.ArchiveDate;
		EXPORT STRING InputFileName := OptionsRaw.InputFileName;
		EXPORT STRING PermissiblePurpose := OptionsRaw.PermissiblePurpose;
		EXPORT STRING Data_Restriction_Mask := OptionsRaw.Data_Restriction_Mask;
		EXPORT STRING Data_Permission_Mask := OptionsRaw.Data_Permission_Mask;
		EXPORT UNSIGNED GLBAPurpose := OptionsRaw.GLBAPurpose;
		EXPORT UNSIGNED DPPAPurpose := OptionsRaw.DPPAPurpose;
		EXPORT BOOLEAN Override_Experian_Restriction := OptionsRaw.Override_Experian_Restriction;
		EXPORT STRING Allowed_Sources := OptionsRaw.Allowed_Sources;
		EXPORT INTEGER ScoreThreshold := OptionsRaw.ScoreThreshold;
		EXPORT BOOLEAN ExcludeConsumerAttributes := OptionsRaw.ExcludeConsumerAttributes;
		EXPORT BOOLEAN isMarketing := OptionsRaw.isMarketing;
		EXPORT STRING IndustryClass := OptionsRaw.IndustryClass;
		EXPORT BOOLEAN OutputMasterResults := OptionsRaw.OutputMasterResults;
		EXPORT UNSIGNED BIPAppendScoreThreshold := OptionsRaw.BIPAppendScoreThreshold;
		EXPORT UNSIGNED BIPAppendWeightThreshold := OptionsRaw.BIPAppendWeightThreshold;
		EXPORT BOOLEAN BIPAppendPrimForce := OptionsRaw.BIPAppendPrimForce;
		EXPORT BOOLEAN BIPAppendReAppend := OptionsRaw.BIPAppendReAppend;
		EXPORT BOOLEAN BIPAppendIncludeAuthRep := OptionsRaw.BIPAppendIncludeAuthRep;
		EXPORT BOOLEAN BIPAppendMimicRoxie := OptionsRaw.BIPAppendMimicRoxie;

END;