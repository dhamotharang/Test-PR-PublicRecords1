import ut, tools, Corp2_Raw_CA;

EXPORT Files(STRING  pversion = '',
             BOOLEAN pUseOtherEnvironment = FALSE) := MODULE

	// Input File Versions
	// --------------------
	EXPORT Input := MODULE
	
	  // Vendor Data files
		tools.mac_FilesInput(Corp2_Raw_CA.Filenames(pversion, pUseOtherEnvironment).Input.Mast, Corp2_Raw_CA.Layouts.MastLayoutIn, Mast);	
		tools.mac_FilesInput(Corp2_Raw_CA.Filenames(pversion, pUseOtherEnvironment).Input.Hist, Corp2_Raw_CA.Layouts.HistLayoutIn, Hist);
		tools.mac_FilesInput(Corp2_Raw_CA.Filenames(pversion, pUseOtherEnvironment).Input.LP,   Corp2_Raw_CA.Layouts.LPLayoutIn, LP);
	END;

	// Base File Versions
	// --------------------
	EXPORT Base := MODULE
		tools.mac_FilesBase(Corp2_Raw_CA.Filenames(pversion, pUseOtherEnvironment).Base.Mast, Corp2_Raw_CA.Layouts.MastLayoutBase, Mast);
		tools.mac_FilesBase(Corp2_Raw_CA.Filenames(pversion, pUseOtherEnvironment).Base.Hist, Corp2_Raw_CA.Layouts.HistLayoutBase, Hist);
		tools.mac_FilesBase(Corp2_Raw_CA.Filenames(pversion, pUseOtherEnvironment).Base.LP,   Corp2_Raw_CA.Layouts.LPLayoutBase, LP);	
	END;

END;

