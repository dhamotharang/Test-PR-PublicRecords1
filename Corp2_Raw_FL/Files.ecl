import ut, tools, Corp2_Raw_FL;

EXPORT Files(STRING  pversion = '',
             BOOLEAN pUseOtherEnvironment = FALSE) := MODULE

	// Input File Versions
	// --------------------
	EXPORT Input := MODULE
		tools.mac_FilesInput(Corp2_Raw_FL.Filenames(pversion, pUseOtherEnvironment).Input.TMFile, Corp2_Raw_FL.Layouts.TMFileLayoutIn,       TMFile);	
		tools.mac_FilesInput(Corp2_Raw_FL.Filenames(pversion, pUseOtherEnvironment).Input.CorpFile, Corp2_Raw_FL.Layouts.CorpFileLayoutIn,   CorpFile);	
		tools.mac_FilesInput(Corp2_Raw_FL.Filenames(pversion, pUseOtherEnvironment).Input.EventFile, Corp2_Raw_FL.Layouts.EventFileLayoutIn, EventFile);	
	END;

	// Base File Versions
	// --------------------
	EXPORT Base := MODULE
		tools.mac_FilesBase(Corp2_Raw_FL.Filenames(pversion, pUseOtherEnvironment).Base.TMFile,    Corp2_Raw_FL.Layouts.TMFileLayoutBase,    TMFile);
		tools.mac_FilesBase(Corp2_Raw_FL.Filenames(pversion, pUseOtherEnvironment).Base.CorpFile,  Corp2_Raw_FL.Layouts.CorpFileLayoutBase,  CorpFile);
		tools.mac_FilesBase(Corp2_Raw_FL.Filenames(pversion, pUseOtherEnvironment).Base.EventFile, Corp2_Raw_FL.Layouts.EventFileLayoutBase, EventFile);
	END;

END;

