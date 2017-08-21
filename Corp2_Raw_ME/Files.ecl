import ut, tools;

EXPORT Files(STRING  pversion = '',
             BOOLEAN pUseOtherEnvironment = FALSE) := MODULE

	//////////////////////////////////////////////////////////////////
	// -- Input File Versions
	//////////////////////////////////////////////////////////////////
	EXPORT Input := MODULE
		tools.mac_FilesInput(Corp2_Raw_ME.Filenames(pversion, pUseOtherEnvironment).Input.CorpBulk, Corp2_Raw_ME.Layouts.CorpBulkLayoutIn, CorpBulk);
	END;

	//////////////////////////////////////////////////////////////////
	// -- Base File Versions
	//////////////////////////////////////////////////////////////////
	EXPORT Base := MODULE
		tools.mac_FilesBase(Corp2_Raw_ME.Filenames(pversion, pUseOtherEnvironment).Base.CorpBulk, Corp2_Raw_ME.Layouts.CorpBulkLayoutBase, CorpBulk);
	END;

END;