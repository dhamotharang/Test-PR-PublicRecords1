import ut, tools, Corp2_Raw_WA; 

EXPORT Files(STRING  pversion = '',
             BOOLEAN pUseOtherEnvironment = FALSE) := MODULE

	// Input File Versions
	EXPORT Input := MODULE
		
		tools.mac_FilesInput(Corp2_Raw_WA.Filenames(pversion, pUseOtherEnvironment).Input.Corporations, Corp2_Raw_WA.Layouts.CorporationsLayoutIn, Corporations
										,'Data/Corporations/Corporation'); //XML data
		tools.mac_FilesInput(Corp2_Raw_WA.Filenames(pversion, pUseOtherEnvironment).Input.GoverningPersons, Corp2_Raw_WA.Layouts.GoverningPersonsLayoutIn, GoverningPersons
										,'Data/Governors/Governor'); //XML data
		tools.mac_FilesInput(Corp2_Raw_WA.Filenames(pversion, pUseOtherEnvironment).Input.DocumentTypes, Corp2_Raw_WA.Layouts.DocumentTypesLayoutIn, DocumentTypes
										,'Data/DocumentTypes/DocumentType'); //XML data
	
	END;

END;

