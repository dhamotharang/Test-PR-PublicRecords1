import ut, tools, Corp2_Raw_AZ, Corp2_mapping;

EXPORT Files(STRING  pversion = '',
             BOOLEAN pUseOtherEnvironment = FALSE) := MODULE

	// Input Files   
	//-----------------------
	EXPORT Input := MODULE
		tools.mac_FilesInput(Corp2_Raw_AZ.Filenames(pversion, pUseOtherEnvironment).Input.COREXT, Corp2_Raw_AZ.Layouts.COREXT_LayoutIn, COREXT);
		tools.mac_FilesInput(Corp2_Raw_AZ.Filenames(pversion, pUseOtherEnvironment).Input.CHGEXT,	Corp2_Raw_AZ.Layouts.CHGEXT_LayoutIn, CHGEXT);
		tools.mac_FilesInput(Corp2_Raw_AZ.Filenames(pversion, pUseOtherEnvironment).Input.FLMEXT, Corp2_Raw_AZ.Layouts.FLMEXT_LayoutIn, FLMEXT);
		tools.mac_FilesInput(Corp2_Raw_AZ.Filenames(pversion, pUseOtherEnvironment).Input.OFFEXT,	Corp2_Raw_AZ.Layouts.OFFEXT_LayoutIn, OFFEXT);
	END;
		
	// Base Files  
	//-----------------------
	EXPORT Base := MODULE
		tools.mac_FilesBase(Corp2_Raw_AZ.Filenames(pversion, pUseOtherEnvironment).Base.COREXT, Corp2_Raw_AZ.Layouts.COREXT_LayoutBase, COREXT);
		tools.mac_FilesBase(Corp2_Raw_AZ.Filenames(pversion, pUseOtherEnvironment).Base.CHGEXT, Corp2_Raw_AZ.Layouts.CHGEXT_LayoutBase, CHGEXT);
		tools.mac_FilesBase(Corp2_Raw_AZ.Filenames(pversion, pUseOtherEnvironment).Base.FLMEXT, Corp2_Raw_AZ.Layouts.FLMEXT_LayoutBase, FLMEXT);
		tools.mac_FilesBase(Corp2_Raw_AZ.Filenames(pversion, pUseOtherEnvironment).Base.OFFEXT, Corp2_Raw_AZ.Layouts.OFFEXT_LayoutBase, OFFEXT);
	END;

END;
