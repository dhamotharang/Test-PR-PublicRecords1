IMPORT STD, dops, Orbit3;

EXPORT ProcBuildFiles(
	STRING pVersion,
	STRING pContacts
) := FUNCTION
	vCurrDevVerLogical := '~thor_data400::civil_court::current_development_version';
	vDevVerSuper := '~thor_data400::civil_court::development_version';

	fUpdateCurrDevVerLogical := OUTPUT(
		DATASET([{pVersion}],{STRING version}),,
		vCurrDevVerLogical,
		OVERWRITE
	);
	
	fCreateDevVerSuper := IF (
		NOT STD.File.SuperFileExists(vDevVerSuper),
		STD.File.CreateSuperFile(vDevVerSuper)
	);

	fPlaceInDevVerSuper := IF(
		STD.File.GetSuperFileSubName(vDevVerSuper, 1, TRUE) != vCurrDevVerLogical,
		SEQUENTIAL(
			STD.File.StartSuperFileTransaction(),
			STD.File.AddSuperFile(vDevVerSuper, vCurrDevVerLogical),
			STD.File.FinishSuperFileTransaction()
		)
	);

	fSendMail(STRING pSubject, STRING pBody) := STD.System.Email.SendEmail(pContacts, pSubject, pBody);

	civil_court.Out_Population_Stats(
		civil_court.File_Moxie_Party_Dev,
		civil_court.File_Moxie_Matter_Dev,
		civil_court.File_Moxie_Case_Activity_Dev,
		pVersion,
		DoPopulationStats
	);

	RETURN SEQUENTIAL(
		fUpdateCurrDevVerLogical,
		fCreateDevVerSuper,
		fPlaceInDevVerSuper
		/*
		PARALLEL(
			civil_court.Out_Moxie_Party,
			civil_court.Out_Moxie_Matter,
			civil_court.Out_Moxie_Case_Activity
		),
		fSendMail('Civil Court 1 of 2','Civil Court Moxie files complete'),
		PARALLEL(
			civil_court.Out_Moxie_Party_Dev_Stats,
			civil_court.Out_Moxie_Matter_Dev_Stats,
			civil_court.Out_Moxie_Case_Activity_Dev_Stats,
			civil_court.proc_build_key(pVersion),
			civil_court.filterCivilBase_MarriageDivorces,
			DoPopulationStats
		),
		dops.updateversion(
			'CivilCourtKeys',
			pVersion,
			pContacts,,
			'N'
		),
		Orbit3.proc_Orbit3_CreateBuild('Civil Court',pVersion,'N'),
		fSendMail('Civil Court 2 of 2','Civil Court job complete')
		*/
	);
END; 
