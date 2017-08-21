import ut, tools, Corp2_Mapping;

EXPORT Files(STRING  pversion = '',
             BOOLEAN pUseOtherEnvironment = FALSE) := MODULE

	//////////////////////////////////////////////////////////////////
	// -- Input File Versions
	//////////////////////////////////////////////////////////////////
	EXPORT Input := MODULE
	
		tools.mac_FilesInput(Filenames(pversion,pUseOtherEnvironment).Input.vendorRaw, Corp2_Raw_ID.Layouts.vendorRawLayoutIn, vendorRaw);
		
	END;

	//////////////////////////////////////////////////////////////////
	// -- Base File Versions
	//////////////////////////////////////////////////////////////////
	EXPORT Base := MODULE
	
		tools.mac_FilesBase(Filenames(pversion,pUseOtherEnvironment).Base.vendorRaw, Corp2_Raw_ID.Layouts.vendorRawLayoutBase, vendorRaw);
		
	END;

END;