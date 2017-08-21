import ut, tools, Corp2_Raw_WA;

EXPORT Files(STRING  pversion = '',
             BOOLEAN pUseOtherEnvironment = FALSE) := MODULE

	// Input File Versions
	EXPORT Input := MODULE
		tools.mac_FilesInput(Corp2_Raw_WA.Filenames(pversion, pUseOtherEnvironment).Input.Corps, Corp2_Raw_WA.Layouts.CorpsLayoutIn, Corps
												,'Data/Corporations/Corporation'); //XML data
	END;

	// Base File Versions
	EXPORT Base := MODULE
		tools.mac_FilesBase(Corp2_Raw_WA.Filenames(pversion, pUseOtherEnvironment).Base.Corps, Corp2_Raw_WA.Layouts.CorpsLayoutBase, Corps);
	END;

END;