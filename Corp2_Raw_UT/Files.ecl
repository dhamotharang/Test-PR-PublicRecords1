import ut, tools;

EXPORT Files(STRING  pversion = '',
             BOOLEAN pUseOtherEnvironment = FALSE) := MODULE

	//////////////////////////////////////////////////////////////////
	// -- Input File Versions
	//////////////////////////////////////////////////////////////////
	EXPORT Input := MODULE
	
		tools.mac_FilesInput(Corp2_Raw_UT.Filenames(pversion, pUseOtherEnvironment).Input.Busentity, Corp2_Raw_UT.Layouts.BusentityLayoutIn, Busentity,
		                     'CSV', , pQuote := '"', pTerminator := ['\n','\r\n'], pSeparator := ',', pHeading := 1);	
														
		tools.mac_FilesInput(Corp2_Raw_UT.Filenames(pversion, pUseOtherEnvironment).Input.Principals,	Corp2_Raw_UT.Layouts.PrincipalsLayoutIn, Principals,
		                     'CSV', , pQuote := '"', pTerminator := ['\n','\r\n'], pSeparator := ',', pHeading := 1);
														
		tools.mac_FilesInput(Corp2_Raw_UT.Filenames(pversion, pUseOtherEnvironment).Input.Businfo, Corp2_Raw_UT.Layouts.BusinfoLayoutIn, Businfo,
		                     'CSV', , pQuote := '"', pTerminator := ['\n','\r\n'], pSeparator := ',', pHeading := 1);

	END;
	//////////////////////////////////////////////////////////////////
	// -- Base File Versions
	//////////////////////////////////////////////////////////////////
	EXPORT Base := MODULE
	
		tools.mac_FilesBase(Corp2_Raw_UT.Filenames(pversion, pUseOtherEnvironment).Base.Busentity, 	Corp2_Raw_UT.Layouts.BusentityLayoutBase, Busentity);
		tools.mac_FilesBase(Corp2_Raw_UT.Filenames(pversion, pUseOtherEnvironment).Base.Principals, Corp2_Raw_UT.Layouts.PrincipalsLayoutBase, Principals);
		tools.mac_FilesBase(Corp2_Raw_UT.Filenames(pversion, pUseOtherEnvironment).Base.Businfo, 	  Corp2_Raw_UT.Layouts.BusinfoLayoutBase, Businfo);
		
	END;

END;