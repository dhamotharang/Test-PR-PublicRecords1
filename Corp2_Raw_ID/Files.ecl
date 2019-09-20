import ut, tools, Corp2_Mapping;

EXPORT Files(STRING  pversion = '',
             BOOLEAN pUseOtherEnvironment = FALSE) := MODULE

	//////////////////////////////////////////////////////////////////
	// -- Input File Versions
	//////////////////////////////////////////////////////////////////
	EXPORT Input := MODULE
	
		tools.mac_FilesInput(Filenames(pversion,pUseOtherEnvironment).Input.Filing,     Corp2_Raw_ID.Layouts.FilingLayoutIn,     Filing,
						'CSV', , pTerminator := ['\r\n', '\n'], pSeparator := '\t', pHeading := 1);
		tools.mac_FilesInput(Filenames(pversion,pUseOtherEnvironment).Input.FilingName, Corp2_Raw_ID.Layouts.FilingNameLayoutIn, FilingName,
						'CSV', , pTerminator := ['\r\n', '\n'], pSeparator := '\t', pHeading := 1);
		tools.mac_FilesInput(Filenames(pversion,pUseOtherEnvironment).Input.Party,      Corp2_Raw_ID.Layouts.PartyLayoutIn,      Party,
						'CSV', , pTerminator := ['\r\n', '\n'], pSeparator := '\t', pHeading := 1);

	END;

END;