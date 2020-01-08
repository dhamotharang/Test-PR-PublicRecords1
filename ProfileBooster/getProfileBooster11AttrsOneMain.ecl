IMPORT ProfileBooster.ProfileBoosterV2_KEL, ProfileBooster, STD, Risk_Indicators;
IMPORT KEL11 AS KEL;

EXPORT getProfileBooster11AttrsOneMain(
																STRING8 histDate = (STRING8)STD.Date.Today(), 
																INTEGER Score_threshold = 80,
																INTEGER GLBA = 1,
																INTEGER DPPA = 3,
																STRING  DataRestrictionMask	= '00000000000000000000000000000000000000000000000000',
																STRING  DataPermissionMask	= '11111111111111111111111111111111111111111111111111'
																
																) := FUNCTION
	
	myCFG := MODULE(ProfileBooster.ProfileBoosterV2_KEL.CFG_Compile)
	END;
	
	OptionsRaw := MODULE(ProfileBooster.ProfileBoosterV2_KEL.Interface_Options)
		EXPORT STRING AttributeSetName := 'Development KEL Attributes';
		EXPORT STRING VersionName := 'Version 1.0';
		EXPORT BOOLEAN isFCRA := FALSE;
		EXPORT STRING ArchiveDate := histDate;
		EXPORT STRING InputFileName := '';
		EXPORT STRING Data_Restriction_Mask := DataRestrictionMask;
		EXPORT STRING Data_Permission_Mask := DataPermissionMask;
		EXPORT UNSIGNED GLBAPurpose := GLBA;
		EXPORT UNSIGNED DPPAPurpose := DPPA;
		EXPORT INTEGER ScoreThreshold := Score_threshold;
		EXPORT BOOLEAN OutputMasterResults := FALSE;
		EXPORT BOOLEAN isMarketing := TRUE; // When TRUE enables Marketing Restrictions
	END;
	
	KEL_Settings := ProfileBooster.ProfileBoosterV2_KEL.CFG_Compile;

	Options := ProfileBooster.ProfileBoosterV2_KEL.ECL_Functions.Fn_Set_Interface_Options(OptionsRaw, KEL_Settings);
	
	PInputArchiveDateClean:=(INTEGER)histDate;

	UNSIGNED8 PDPM := ProfileBooster.ProfileBoosterV2_KEL.ECL_Functions.Fn_KEL_DPMBitmap.Generate(Options.Data_Restriction_Mask, 
																																																Options.Data_Permission_Mask, 
																																																Options.GLBAPurpose, 
																																																Options.DPPAPurpose, 
																																																FALSE,//isFCRA
																																																TRUE,//isMarketing 
																																																FALSE,//AllowDNBDMI
																																																FALSE, //OverrideExperianRestriction
																																																'', //PermissiblePurpose, 
																																																'',// IndustryClass ??DRMKT
																																																KEL_Settings, 
																																																FALSE);
	PB11Result := KEL.Clean(ProfileBooster.ProfileBoosterV2_KEL.Q_Non_F_C_R_A_Profile_Booster_V2_All(PInputArchiveDateClean,PDPM).res0, TRUE, TRUE, TRUE);		

	RETURN PB11Result;
END;