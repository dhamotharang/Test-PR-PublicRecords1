EXPORT Interface_Options := INTERFACE
	EXPORT STRING AttributeSetName := '';
	EXPORT STRING VersionName := '';
	EXPORT BOOLEAN isFCRA := FALSE;
	EXPORT STRING ArchiveDate := '0';
	EXPORT STRING InputFileName := '';
	EXPORT STRING PermissiblePurpose := '';
	EXPORT STRING Data_Restriction_Mask := '';
	EXPORT STRING Data_Permission_Mask := '';
	EXPORT UNSIGNED GLBAPurpose := 0;
	EXPORT UNSIGNED DPPAPurpose := 0;
	EXPORT BOOLEAN Override_Experian_Restriction := FALSE;
	EXPORT STRING Allowed_Sources := '';
	EXPORT INTEGER ScoreThreshold := 80;
	EXPORT BOOLEAN ExcludeConsumerAttributes := FALSE;
	EXPORT BOOLEAN isMarketing := TRUE; // When TRUE enables Marketing Restrictions
	EXPORT STRING IndustryClass := ''; // When set to UTILI or DRMKT this restricts Utility data
	EXPORT UNSIGNED8 KEL_Permissions_Mask := 0; // Set by ProfileBooster.ProfileBooster_KEL.ECL_Functions.Fn_KEL_DPMBitmap.Generate()
	EXPORT BOOLEAN OutputMasterResults := FALSE;

	// BIP Append Options
	EXPORT UNSIGNED BIPAppendScoreThreshold := 75;
	EXPORT UNSIGNED BIPAppendWeightThreshold := 0;
	EXPORT BOOLEAN BIPAppendPrimForce := FALSE;
	EXPORT BOOLEAN BIPAppendReAppend := TRUE;
	EXPORT BOOLEAN BIPAppendIncludeAuthRep := FALSE;
	EXPORT BOOLEAN BIPAppendMimicRoxie := FALSE;
END;	