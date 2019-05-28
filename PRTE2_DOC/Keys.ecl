IMPORT  doxie,mdr, PRTE2_DOC, hygenics_search, ut;

EXPORT keys := MODULE

EXPORT key_criminal_offenders_did(Boolean IsFCRA) := function

// DF-22705 FCRA Consumer Data Field Depreciation
	ut.MAC_CLEAR_FIELDS(FILES.file_offenders_keybuilding, offenders_cleared, constants.fields_to_clear_offenders );
	dsFiles := if (IsFCRA, offenders_cleared((integer)did != 0),	FILES.file_offenders_keybuilding((integer)did != 0));

return INDEX(dsFiles,	{unsigned6 sdid := (integer)dsFiles.did}, {dsFiles}, 
							if (IsFCRA,'~prte::key::criminal_offenders::FCRA::' + doxie.Version_SuperKey + '::did',
													'~prte::key::corrections_offenders_public_' + doxie.Version_SuperKey )
		);
end;

EXPORT key_offenses_offender_key(Boolean IsFCRA) := function

// DF-22705 FCRA Consumer Data Field Depreciation
	ut.MAC_CLEAR_FIELDS(FILES.file_offenses_keybuilding, offenses_keybuilding_cleared, constants.fields_to_clear_offender_key );
	dsFiles := if (IsFCRA, offenses_keybuilding_cleared,FILES.file_offenses_keybuilding);

return INDEX(dsFiles, {ok := dsFiles.offender_key},{dsFiles},
							If (IsFCRA, '~prte::key::criminal_offenses::fcra::' + doxie.Version_SuperKey + '::offender_key',
													'~prte::key::corrections_offenses_public_' + doxie.Version_SuperKey ));
end;

EXPORT key_criminal_punishment_type(Boolean IsFCRA) := function

// DF-22705 FCRA Consumer Data Field Depreciation
	ut.MAC_CLEAR_FIELDS(Files.file_punishment_keybuilding, punishment_keybuilding_cleared, constants.fields_to_clear_punishment_type);
	dsFiles := if (IsFCRA, punishment_keybuilding_cleared,Files.file_punishment_keybuilding);

return INDEX(dsFiles, {ok := dsFiles.offender_key, pt := dsFiles.punishment_type},  {dsFiles},
						If (IsFCRA,
								'~prte::key::criminal_punishment::fcra::' + doxie.Version_SuperKey + '::offender_key.punishment_type',
								'~prte::key::corrections_punishment_public_' + doxie.Version_SuperKey ));
end;								

//DF-21803 Sunsetting Required Key		
EXPORT key_corrections_activity(Boolean IsFCRA) := function
dsActivity := if(isFCRA, Files.corrections_activity_fcra,	Files.corrections_activity);

return INDEX(dsActivity, {ok := dsActivity.offender_key}, {dsActivity}, 
		If (IsFCRA, 
				'~prte::key::corrections::fcra::activity_public_' + doxie.Version_SuperKey ,
				'~prte::key::corrections_activity_public_' + doxie.Version_SuperKey )
		);
end;

EXPORT key_correctionsfcracourt_offenses_public(Boolean IsFCRA) := function

// DF-22705 FCRA Consumer Data Field Depreciation
	ut.MAC_CLEAR_FIELDS(FILES.file_court_offenses, court_offenses_cleared, constants.fields_to_clear_court_offenses);
	dsFiles :=  if(IsFCRA, court_offenses_cleared, FILES.file_court_offenses);
RETURN INDEX(dsFiles, {ofk := dsFiles.offender_key}, {dsFiles}, 
						If (IsFCRA, 
							'~prte::key::corrections::fcra::court_offenses_public_' + doxie.Version_SuperKey ,
							'~prte::key::corrections_court_offenses_public_' + doxie.Version_SuperKey )
							);
END;


EXPORT key_corrections_offenders_offenderkey(Boolean IsFCRA) := function

// DF-22705 FCRA Consumer Data Field Depreciation
	ut.MAC_CLEAR_FIELDS(FILES.file_offenders_keybuilding, offenders_keybuilding_cleared, constants.fields_to_clear_offenders_offenderkey);
	dsFiles :=  if(IsFCRA, offenders_keybuilding_cleared, FILES.file_offenders_keybuilding);

return INDEX(dsFiles, {string60 ofk := dsFiles.offender_key},{dsFiles}, 
						if (IsFCRA,
								'~prte::key::corrections::fcra::offenders_offenderkey_public_' + doxie.Version_SuperKey ,
								'~prte::key::corrections_offenders_offenderkey_public_' + doxie.Version_SuperKey )
								);
end;								

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
