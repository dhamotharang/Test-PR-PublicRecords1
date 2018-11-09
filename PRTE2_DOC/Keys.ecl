IMPORT  doxie,mdr, PRTE2_DOC, hygenics_search;
EXPORT keys := MODULE

EXPORT key_criminal_offenders_did(Boolean IsFCRA) := INDEX(
		if (IsFCRA, FILES.file_offenders_keybuilding((integer)did != 0),
								FILES.file_offenders_keybuilding((integer)did != 0)),
		{unsigned6 sdid := (integer)FILES.file_offenders_keybuilding.did},  
		{FILES.file_offenders_keybuilding}, 
		if (IsFCRA,'~prte::key::criminal_offenders::FCRA::' + doxie.Version_SuperKey + '::did',
							 '~prte::key::corrections_offenders_public_' + doxie.Version_SuperKey )
		);

EXPORT key_offenses_offender_key(Boolean IsFCRA) := INDEX(
		if (IsFCRA,
				FILES.file_offenses_keybuilding,  
				FILES.file_offenses_keybuilding),
		{ok := Files.file_offenses_keybuilding.offender_key},  
		{FILES.file_offenses_keybuilding}, 
		If (IsFCRA, '~prte::key::criminal_offenses::fcra::' + doxie.Version_SuperKey + '::offender_key',
								'~prte::key::corrections_offenses_public_' + doxie.Version_SuperKey ));

EXPORT key_criminal_punishment_type(Boolean IsFCRA) := INDEX(
		if (IsFCRA, 
				Files.file_punishment_keybuilding,
				Files.file_punishment_keybuilding),
		{ok := Files.file_punishment_keybuilding.offender_key, pt := Files.file_punishment_keybuilding.punishment_type},  
		{Files.file_punishment_keybuilding}, 
		If (IsFCRA,
		'~prte::key::criminal_punishment::fcra::' + doxie.Version_SuperKey + '::offender_key.punishment_type',
		'~prte::key::corrections_punishment_public_' + doxie.Version_SuperKey ));
		
EXPORT key_corrections_activity(Boolean IsFCRA) := INDEX(
		If (IsFCRA, 
				Files.corrections_activity,
				Files.corrections_activity),
		{ok := Files.corrections_activity.offender_key},  
		{Files.corrections_activity}, 
		If (IsFCRA, 
				'~prte::key::corrections::fcra::activity_public_' + doxie.Version_SuperKey ,
				'~prte::key::corrections_activity_public_' + doxie.Version_SuperKey )
		);

EXPORT key_correctionsfcracourt_offenses_public(Boolean IsFCRA) := INDEX(
		If (IsFCRA,
				FILES.file_court_offenses,
				FILES.file_court_offenses),
		{ofk := FILES.file_court_offenses.offender_key},  
		{FILES.file_court_offenses}, 
		If (IsFCRA, 
				'~prte::key::corrections::fcra::court_offenses_public_' + doxie.Version_SuperKey ,
				'~prte::key::corrections_court_offenses_public_' + doxie.Version_SuperKey )
		);

EXPORT key_corrections_offenders_offenderkey(Boolean IsFCRA) := INDEX(
		if (IsFCRA, 
				FILES.file_offenders_keybuilding,
				FILES.file_offenders_keybuilding),
		{string60 ofk := FILES.file_offenders_keybuilding.offender_key},  
		{FILES.file_offenders_keybuilding}, 
		if (IsFCRA,
				'~prte::key::corrections::fcra::offenders_offenderkey_public_' + doxie.Version_SuperKey ,
				'~prte::key::corrections_offenders_offenderkey_public_' + doxie.Version_SuperKey )
		);

EXPORT key_corrections_offendersfcrabocashell_did := INDEX(
		FILES.DS_offendersfcrabocashell_did,  
		{did},  
		{FILES.DS_offendersfcrabocashell_did}, 
		'~prte::key::corrections_offenders::fcra::bocashell_did_' + doxie.Version_SuperKey );

EXPORT key_corrections_offenders_riskbocashell_did := INDEX(
		FILES.DS_riskbocashell_did,  
		{did},  
		{Files.DS_riskbocashell_did}, 
		'~prte::key::corrections_offenders_risk::bocashell_did_' + doxie.Version_SuperKey );

EXPORT key_offenders_fdid := index(
		Files.file_offenders_keybuilding_fdid,
		{sdid := (unsigned6)Files.file_offenders_keybuilding_fdid.i_did},
		{offender_key},
		'~prte::key::corrections_fdid_public_' + doxie.Version_SuperKey );

EXPORT key_offenders_casenumber := INDEX(
		FILES.DS_CaseNumber(case_num <> '' and length(trim(case_num)) >=3),  
		{case_num},  
		{Offender_key,file_indicator}, 
		'~prte::key::corrections_offenders_casenumber_public_' + doxie.Version_SuperKey );

EXPORT key_offenders_docnum := INDEX(
		FILES.file_offenders_keybuilding(doc_num != ''),  
		{string10 docnum := FILES.file_offenders_keybuilding.doc_num, string2 state := FILES.file_offenders_keybuilding.st},  
		{Files.file_offenders_keybuilding}, 
		'~prte::key::corrections_offenders_docnum_public_' + doxie.Version_SuperKey );
 
EXPORT key_offenders_risk_did := INDEX(
		Files.File_Offenders_Risk,  
		{unsigned6 sdid := (integer)Files.File_Offenders_Risk.did},  
	  {Files.File_Offenders_Risk}, 
		'~prte::key::corrections_offenders_risk::did_public_' + doxie.Version_SuperKey );

END;
