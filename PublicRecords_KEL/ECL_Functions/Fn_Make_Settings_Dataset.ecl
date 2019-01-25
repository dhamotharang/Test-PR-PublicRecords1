IMPORT STD;

EXPORT fn_make_settings_dataset(
	STRING AttributeSetName,
	STRING VersionName,
	BOOLEAN isFCRA = FALSE,
	STRING ArchiveDate = '0',
	STRING InputFileName = '',
	STRING PermissiblePurpose = '',
	STRING DataRestrictionMask = '',
	STRING DataPermissionMask = '',
	UNSIGNED GLBA = 0,
	UNSIGNED DPPA = 0,
	BOOLEAN OverrideExperianRestriction = FALSE,
	STRING AllowedSources = '',
	UNSIGNED LexIDThreshold = 0,
	UNSIGNED BusinessLexIDThreshold = 0) := FUNCTION
	
	PermittedSet := ['','0'];
	RestrictedSet := ['','0'];
	
	PermissiblePurpose_output := CASE(STD.Str.ToUpperCase(PermissiblePurpose),
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
		{AttributeSetName + ' - ' + VersionName + ' - ' + IF(isFCRA, 'FCRA', 'NonFCRA')},
		{IF((INTEGER)ArchiveDate = 0, 'Archive Date on file', 'ArchiveDate: ' + ArchiveDate)},
		{'Workunit: ' + STD.System.Job.WUID()},
		{'Input File: ' + InputFileName},
		{'Username: ' + STD.System.Job.User()},
		{'Permissible Purpose: ' + PermissiblePurpose_output},
		{'Data Restriction Mask Settings: ' + DataRestrictionMask},
		{'DRMFares: ' + IF(DataRestrictionMask[1] IN PermittedSet, 'Not Restricted 0', 'Restricted 1')},
		{'DRMExperian: ' + IF(DataRestrictionMask[6] IN PermittedSet, 'Not Restricted 0', 'Restricted 1')},
		{'DRMTransUnion: ' + IF(DataRestrictionMask[10] IN PermittedSet, 'Not Restricted 0', 'Restricted 1')},
		{'DRMAdvo: ' + IF(DataRestrictionMask[12] IN PermittedSet, 'Not Restricted 0', 'Restricted 1')},
		{'DRMExperianFCRA: ' + IF(DataRestrictionMask[14] IN PermittedSet, 'Not Restricted 0', 'Restricted 1')},
		{'DRMCortera: ' + IF(DataRestrictionMask[42] IN PermittedSet, 'Not Restricted 0', 'Restricted 1')},
		{'DRMExperianEBR: ' + IF(DataRestrictionMask[3] IN PermittedSet, 'Not Restricted 0', 'Restricted 1')},
		{'Data Permission Mask Settings: ' + DataPermissionMask},
		{'DPMSSN: ' + IF(DataPermissionMask[10] IN RestrictedSet, 'Not Permitted 0', 'Permitted 1')},
		{'DPMFDN: ' + IF(DataPermissionMask[11] IN RestrictedSet, 'Not Permitted 0', 'Permitted 1')},
		{'DPMDL: ' + IF(DataPermissionMask[13] IN RestrictedSet, 'Not Permitted 0', 'Permitted 1')},
		{'DPMSBFE: ' + IF(DataPermissionMask[12] IN RestrictedSet, 'Not Permitted 0', 'Permitted 1')},
		{'DPMTargus: ' + IF(DataPermissionMask[2] IN RestrictedSet, 'Not Permitted 0', 'Permitted 1')},
		{IF(GLBA = 0, 'GLBA: Not Permitted 0', 'GLBA: Permitted' + (STRING)GLBA)},
		{IF(DPPA = 0, 'DPPA: Not Permitted 0', 'DPPA: Permitted' + (STRING)DPPA)},
		{'Override Experian Restriction: ' + IF(OverrideExperianRestriction, 'TRUE', 'FALSE')},
		{'DNBDMI Allowed: ' + IF(AllowedSources = 'DNBDMI', 'TRUE', 'FALSE')},
		{'LexID Threshold: ' + (STRING)LexIDThreshold},
		{'Business LexID Threshold: ' + (STRING)BusinessLexIDThreshold}
		], {STRING Attributes_Settings});
		
	RETURN Settings_Dataset;
END;