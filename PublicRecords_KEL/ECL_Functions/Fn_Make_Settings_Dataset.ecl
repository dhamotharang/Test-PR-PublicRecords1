IMPORT PublicRecords_KEL, STD;

EXPORT fn_make_settings_dataset(PublicRecords_KEL.Interface_BWR_Settings Settings)
				:= FUNCTION
	
	PermittedSet := ['','0'];
	RestrictedSet := ['','0'];
	
	PermissiblePurpose_output := CASE(STD.Str.ToUpperCase(Settings.PermissiblePurpose),
		'APPLICATION' 												=> 'A: APPLICATION',
		'CHILD SUPPORT' 											=> 'B: CHILD SUPPORT',
		'COLLECTIONS' 												=> 'C: COLLECTIONS',
		'DEMAND DEPOSIT' 											=> 'D: DEMAND DEPOSIT',
		'DISCLOSURE' 													=> 'E: DISCLOSURE',
		'EMPLOYEE OR VOLUNTEER SCREENING' 		=> 'F: EMPLOYEE OR VOLUNTEER SCREENING',
		'GOVERNMENT' 													=> 'G: GOVERNMENT',
		'HEALTHCARE CREDIT TRANSACTION' 			=> 'H: HEALTHCARE CREDIT TRANSACTION',
		'HEALTHCARE LEGITIMATE BUSINESS NEED' => 'I: HEALTHCARE LEGITIMATE BUSINESS NEED',
		'INSURANCE APPLICATION' 							=> 'J: INSURANCE APPLICATION',
		'INSURANCE PORTFOLIO REVIEW' 					=> 'K: INSURANCE PORTFOLIO REVIEW',
		'PORTFOLIO REVIEW' 										=> 'L: PORTFOLIO REVIEW',
		'PRESCREENING' 												=> 'M: PRESCREENING',
		'RENTAL CAR'	 												=> 'N: RENTAL CAR',
		'RENTAL CAR LOSS DAMAGE WAIVER' 			=> 'O: RENTAL CAR LOSS DAMAGE WAIVER',
		'TENANT SCREENING' 										=> 'P: TENANT SCREENING',
		'WRITTEN CONSENT' 										=> 'Q: WRITTEN CONSENT',
		'WRITTEN CONSENT DIRECT TO CONSUMER' 	=> 'R: WRITTEN CONSENT DIRECT TO CONSUMER',
		'WRITTEN CONSENT PREQUALIFICATION' 		=> 'S: WRITTEN CONSENT PREQUALIFICATION',
																						 '');
		
	Settings_Dataset := DATASET([
		{Settings.AttributeSetName + ' - ' + Settings.VersionName + ' - ' + IF(Settings.isFCRA, 'FCRA', 'NonFCRA')},
		{IF((INTEGER)Settings.ArchiveDate = 0, 'Archive Date on file', 'ArchiveDate: ' + Settings.ArchiveDate)},
		{'Workunit: ' + STD.System.Job.WUID()},
		{'Input File: ' + Settings.InputFileName},
		{'Username: ' + STD.System.Job.User()},
		{'Permissible Purpose: ' + PermissiblePurpose_output},
		{'Data Restriction Mask Settings: ' + Settings.Data_Restriction_Mask},
		{'DRMFares: ' + IF(Settings.Data_Restriction_Mask[1] IN PermittedSet, 'Not Restricted 0', 'Restricted 1')},
		{'DRMExperian: ' + IF(Settings.Data_Restriction_Mask[6] IN PermittedSet, 'Not Restricted 0', 'Restricted 1')},
		{'DRMTransUnion: ' + IF(Settings.Data_Restriction_Mask[10] IN PermittedSet, 'Not Restricted 0', 'Restricted 1')},
		{'DRMAdvo: ' + IF(Settings.Data_Restriction_Mask[12] IN PermittedSet, 'Not Restricted 0', 'Restricted 1')},
		{'DRMExperianFCRA: ' + IF(Settings.Data_Restriction_Mask[14] IN PermittedSet, 'Not Restricted 0', 'Restricted 1')},
		{'DRMCortera: ' + IF(Settings.Data_Restriction_Mask[42] IN PermittedSet, 'Not Restricted 0', 'Restricted 1')},
		{'DRMExperianEBR: ' + IF(Settings.Data_Restriction_Mask[3] IN PermittedSet, 'Not Restricted 0', 'Restricted 1')},
		{'Data Permission Mask Settings: ' + Settings.Data_Permission_Mask},
		{'DPMSSN: ' + IF(Settings.Data_Permission_Mask[10] IN RestrictedSet, 'Not Permitted 0', 'Permitted 1')},
		{'DPMFDN: ' + IF(Settings.Data_Permission_Mask[11] IN RestrictedSet, 'Not Permitted 0', 'Permitted 1')},
		{'DPMDL: ' + IF(Settings.Data_Permission_Mask[13] IN RestrictedSet, 'Not Permitted 0', 'Permitted 1')},
		{'DPMSBFE: ' + IF(Settings.Data_Permission_Mask[12] IN RestrictedSet, 'Not Permitted 0', 'Permitted 1')},
		{'DPMTargus: ' + IF(Settings.Data_Permission_Mask[2] IN RestrictedSet, 'Not Permitted 0', 'Permitted 1')},
		{IF(Settings.GLBAPurpose = 0, 'GLBA: Not Permitted 0', 'GLBA: Permitted ' + (STRING)Settings.GLBAPurpose)},
		{IF(Settings.DPPAPurpose = 0, 'DPPA: Not Permitted 0', 'DPPA: Permitted ' + (STRING)Settings.DPPAPurpose)},
		{'Override Experian Restriction: ' + IF(Settings.Override_Experian_Restriction, 'TRUE', 'FALSE')},
		{'DNBDMI Allowed: ' + IF(Settings.Allowed_Sources = 'DNBDMI', 'TRUE', 'FALSE')},
		{'LexID Threshold: ' + (STRING)Settings.LexIDThreshold},
		{'Business LexID Score Threshold: ' + (STRING)Settings.BusinessLexIDThreshold},
		{'Business LexID Weight Threshold: ' + (STRING)Settings.BusinessLexIDWeightThreshold},
		{'Business LexID Prim Force: ' + IF(Settings.BusinessLexIDPrimForce, 'TRUE', 'FALSE')},
		{'Business LexID ReAppend: ' + IF(Settings.BusinessLexIDReAppend, 'TRUE', 'FALSE')},
		{'Business LexID Include Auth Rep: ' + IF(Settings.BusinessLexIDIncludeAuthRep, 'TRUE', 'FALSE')}
		], {STRING Attributes_Settings});

	RETURN Settings_Dataset;
END;