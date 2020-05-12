IMPORT ProfileBooster.ProfileBoosterV2_KEL, ProfileBooster, STD, Risk_Indicators;
IMPORT KEL12 AS KEL;

EXPORT getProfileBooster11Attrs(DATASET(ProfileBooster.Layouts.Layout_PB_In) PB_wseq, 
																INTEGER Score_threshold = 80,
																INTEGER GLBA = 1,
																INTEGER DPPA = 3,
																STRING  DataRestrictionMask	= '00000000000000000000000000000000000000000000000000',
																STRING  DataPermissionMask	= '11111111111111111111111111111111111111111111111111'
																
																) := FUNCTION
	
	mod_transforms := ProfileBooster.ProfileBoosterV2_KEL.ECL_Functions.Transforms;
	
	PP1 := PROJECT(PB_wseq, mod_transforms.xfm_Prepare_PB11_Input(LEFT,COUNTER));	
	PP := DISTRIBUTE(PP1, RANDOM());

	Options := MODULE(ProfileBooster.ProfileBoosterV2_KEL.Interface_Options)
		EXPORT STRING AttributeSetName := 'Development KEL Attributes';
		EXPORT STRING VersionName := 'Version 1.0';
		EXPORT BOOLEAN isFCRA := FALSE;
		EXPORT STRING ArchiveDate := '';
		EXPORT STRING InputFileName := '';
		EXPORT STRING Data_Restriction_Mask := DataRestrictionMask;
		EXPORT STRING Data_Permission_Mask := DataPermissionMask;
		EXPORT UNSIGNED GLBAPurpose := GLBA;
		EXPORT UNSIGNED DPPAPurpose := DPPA;
		EXPORT INTEGER ScoreThreshold := Score_threshold;
		EXPORT BOOLEAN OutputMasterResults := FALSE;
		EXPORT BOOLEAN isMarketing := TRUE; // When TRUE enables Marketing Restrictions
	END;

	PB11Result:= ProfileBooster.ProfileBoosterV2_KEL.FnThor_GetAttrsV11(PP, Options);
	
	FinalResult := JOIN(PB_wseq, PB11Result,
											LEFT.AcctNo = RIGHT.P_InpAcct,
											mod_transforms.xfm_PB11_Final(LEFT, RIGHT), LEFT OUTER, local);
	
	//DEBUGGING
	// OUTPUT(CHOOSEN(PB11Result,100),named('PB11_Sample1'));
	
	RETURN FinalResult;
	
END;