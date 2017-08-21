import ut, tools, Corp2_Raw_IA;

EXPORT Files(STRING  pversion = '',
             BOOLEAN pUseOtherEnvironment = FALSE) := MODULE

	// Input File Versions
	// --------------------
	EXPORT Input := MODULE
	
	  // Vendor Data files
		tools.mac_FilesInput(Corp2_Raw_IA.Filenames(pversion, pUseOtherEnvironment).Input.crpAdd, Corp2_Raw_IA.Layouts.crpAddLayoutIn, crpAdd,
		           'CSV', , pQuote := '', pTerminator := ['\r\n', '\n'], pSeparator := '\t');	
																			  
		tools.mac_FilesInput(Corp2_Raw_IA.Filenames(pversion, pUseOtherEnvironment).Input.crpAgt,	Corp2_Raw_IA.Layouts.crpAgtLayoutIn, crpAgt,
		           'CSV', , pQuote := '', pTerminator := ['\r\n', '\n'], pSeparator := '\t');
														
		tools.mac_FilesInput(Corp2_Raw_IA.Filenames(pversion, pUseOtherEnvironment).Input.crpDes, Corp2_Raw_IA.Layouts.crpDesLayoutIn, crpDes,
		           'CSV', , pQuote := '', pTerminator := ['\r\n', '\n'], pSeparator := '\t');
														
		tools.mac_FilesInput(Corp2_Raw_IA.Filenames(pversion, pUseOtherEnvironment).Input.crpFil, Corp2_Raw_IA.Layouts.crpFilLayoutIn, crpFil,
		           'CSV', , pQuote := '', pTerminator := ['\r\n', '\n'], pSeparator := '\t');														
		
		tools.mac_FilesInput(Corp2_Raw_IA.Filenames(pversion, pUseOtherEnvironment).Input.crpHis, Corp2_Raw_IA.Layouts.crpHisLayoutIn, crpHis,
		           'CSV', , pQuote := '', pTerminator := ['\r\n', '\n'], pSeparator := '\t');														
		
		tools.mac_FilesInput(Corp2_Raw_IA.Filenames(pversion, pUseOtherEnvironment).Input.crpNam, Corp2_Raw_IA.Layouts.crpNamLayoutIn, crpNam,
		           'CSV', , pQuote := '', pTerminator := ['\r\n', '\n'], pSeparator := '\t');														
		
		tools.mac_FilesInput(Corp2_Raw_IA.Filenames(pversion, pUseOtherEnvironment).Input.crpOff, Corp2_Raw_IA.Layouts.crpOffLayoutIn, crpOff,
		           'CSV', , pQuote := '', pTerminator := ['\r\n', '\n'], pSeparator := '\t');														
		
		tools.mac_FilesInput(Corp2_Raw_IA.Filenames(pversion, pUseOtherEnvironment).Input.crpPrt, Corp2_Raw_IA.Layouts.crpPrtLayoutIn, crpPrt,
		           'CSV', , pQuote := '', pTerminator := ['\r\n', '\n'], pSeparator := '\t');														
		
		tools.mac_FilesInput(Corp2_Raw_IA.Filenames(pversion, pUseOtherEnvironment).Input.crpRem, Corp2_Raw_IA.Layouts.crpRemLayoutIn, crpRem,
		           'CSV', , pQuote := '', pTerminator := ['\r\n', '\n'], pSeparator := '\t');														
		
		tools.mac_FilesInput(Corp2_Raw_IA.Filenames(pversion, pUseOtherEnvironment).Input.crpStk, Corp2_Raw_IA.Layouts.crpStkLayoutIn, crpStk,
		           'CSV', , pQuote := '', pTerminator := ['\r\n', '\n'], pSeparator := '\t');														
	  	
																	
																	
	END;

	// Base File Versions
	// --------------------
	EXPORT Base := MODULE
		tools.mac_FilesBase(Corp2_Raw_IA.Filenames(pversion, pUseOtherEnvironment).Base.crpAdd, Corp2_Raw_IA.Layouts.crpAddLayoutBase, crpAdd);
		tools.mac_FilesBase(Corp2_Raw_IA.Filenames(pversion, pUseOtherEnvironment).Base.crpAgt, Corp2_Raw_IA.Layouts.crpAgtLayoutBase, crpAgt);
		tools.mac_FilesBase(Corp2_Raw_IA.Filenames(pversion, pUseOtherEnvironment).Base.crpDes, Corp2_Raw_IA.Layouts.crpDesLayoutBase, crpDes);
		tools.mac_FilesBase(Corp2_Raw_IA.Filenames(pversion, pUseOtherEnvironment).Base.crpFil, Corp2_Raw_IA.Layouts.crpFilLayoutBase, crpFil);	
		tools.mac_FilesBase(Corp2_Raw_IA.Filenames(pversion, pUseOtherEnvironment).Base.crpHis, Corp2_Raw_IA.Layouts.crpHisLayoutBase, crpHis);	
		tools.mac_FilesBase(Corp2_Raw_IA.Filenames(pversion, pUseOtherEnvironment).Base.crpNam, Corp2_Raw_IA.Layouts.crpNamLayoutBase, crpNam);	
		tools.mac_FilesBase(Corp2_Raw_IA.Filenames(pversion, pUseOtherEnvironment).Base.crpOff, Corp2_Raw_IA.Layouts.crpOffLayoutBase, crpOff);
		tools.mac_FilesBase(Corp2_Raw_IA.Filenames(pversion, pUseOtherEnvironment).Base.crpPrt, Corp2_Raw_IA.Layouts.crpPrtLayoutBase, crpPrt);
		tools.mac_FilesBase(Corp2_Raw_IA.Filenames(pversion, pUseOtherEnvironment).Base.crpRem, Corp2_Raw_IA.Layouts.crpRemLayoutBase, crpRem);
		tools.mac_FilesBase(Corp2_Raw_IA.Filenames(pversion, pUseOtherEnvironment).Base.crpStk, Corp2_Raw_IA.Layouts.crpStkLayoutBase, crpStk);
	END;

END;

