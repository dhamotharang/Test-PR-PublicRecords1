IMPORT tools;

EXPORT Build_Roxie_Keys(STRING pversion = '',
	                      DATASET(Layouts.Base) pBase = Files(pversion).Base.Main.Built,
												BOOLEAN								pOverwrite = FALSE) := MODULE

	SHARED TheKeys := Keys(pversion, pBase);

	SHARED clear_keys := SEQUENTIAL(FileServices.StartSuperFileTransaction();
																  FileServices.ClearSuperFile(Keynames().SSNCustID.Built, FALSE);
																  FileServices.ClearSuperFile(Keynames().SSNCustID.QA, FALSE);
																  FileServices.ClearSuperFile(Keynames().DIDCustID.Built, FALSE);
																  FileServices.ClearSuperFile(Keynames().DIDCustID.QA, FALSE);
																  FileServices.FinishSuperFileTransaction();
																 );

	tools.mac_WriteIndex('TheKeys.SSNCustID.New', BuildSSNCustIDKey_overwrite, 'true');
	tools.mac_WriteIndex('TheKeys.SSNCustID.New', BuildSSNCustIDKey, 'false');
	tools.mac_WriteIndex('TheKeys.DIDCustID.New', BuildDIDCustIDKey_overwrite, 'true');
	tools.mac_WriteIndex('TheKeys.DIDCustID.New', BuildDIDCustIDKey, 'false');

	EXPORT full_build := SEQUENTIAL(IF(pOverwrite, clear_keys),
	                                PARALLEL(IF(pOverwrite, BuildSSNCustIDKey_overwrite, BuildSSNCustIDKey),
			                                     IF(pOverwrite, BuildDIDCustIDKey_overwrite, BuildDIDCustIDKey)),
		                              Promote(pversion).buildfiles.New2Built);
		
	EXPORT All := IF(tools.fun_IsValidVersion(pversion),
		               full_build,
		               OUTPUT('No Valid version parameter passed, skipping Death_MI.Build_Roxie_Keys atribute'));

END;