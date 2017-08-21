import ut, tools;

EXPORT Files(STRING  pversion = '',
             BOOLEAN pUseOtherEnvironment = FALSE) := MODULE

	//////////////////////////////////////////////////////////////////
	// -- Input File Versions
	//////////////////////////////////////////////////////////////////
	EXPORT Input := MODULE
		tools.mac_FilesInput(Corp2_Raw_OR.Filenames(pversion, pUseOtherEnvironment).Input.CountyDBExtract, Corp2_Raw_OR.Layouts.CountyDBExtractLayoutIn, CountyDBExtract,
		                        'CSV', , pQuote := '"', pTerminator := ['\n','\r\n','\n\r'], pSeparator := '\t', pHeading := 1);
		
		tools.mac_FilesInput(Corp2_Raw_OR.Filenames(pversion, pUseOtherEnvironment).Input.EntityDBExtract, Corp2_Raw_OR.Layouts.EntityDBExtractLayoutIn, EntityDBExtract,
		                        'CSV', , pQuote := '"', pTerminator := ['\n','\r\n','\n\r'], pSeparator := '\t', pHeading := 1);
														
		tools.mac_FilesInput(Corp2_Raw_OR.Filenames(pversion, pUseOtherEnvironment).Input.MergerShareDBExtract, Corp2_Raw_OR.Layouts.MergerShareDBExtractLayoutIn, MergerShareDBExtract,
		                        'CSV', , pQuote := '"', pTerminator := ['\n','\r\n','\n\r'], pSeparator := '\t', pHeading := 1);

		tools.mac_FilesInput(Corp2_Raw_OR.Filenames(pversion, pUseOtherEnvironment).Input.NameDBExtract,	Corp2_Raw_OR.Layouts.NameDBExtractLayoutIn, NameDBExtract,
		                        'CSV', , pQuote := '"', pTerminator := ['\n','\r\n','\n\r'], pSeparator := '\t', pHeading := 1);
														
		tools.mac_FilesInput(Corp2_Raw_OR.Filenames(pversion, pUseOtherEnvironment).Input.RelAssocNameDBExtract, Corp2_Raw_OR.Layouts.RelAssocNameDBExtractLayoutIn, RelAssocNameDBExtract,
		                        'CSV', , pQuote := '"', pTerminator := ['\n','\r\n','\n\r'], pSeparator := '\t', pHeading := 1);
		
		tools.mac_FilesInput(Corp2_Raw_OR.Filenames(pversion, pUseOtherEnvironment).Input.TranDBExtract, Corp2_Raw_OR.Layouts.TranDBExtractLayoutIn, TranDBExtract,
		                        'CSV', , pQuote := '"', pTerminator := ['\n','\r\n','\n\r'], pSeparator := '\t', pHeading := 1);	
	END;

	//////////////////////////////////////////////////////////////////
	// -- Base File Versions
	//////////////////////////////////////////////////////////////////
	EXPORT Base := MODULE
		tools.mac_FilesBase(Corp2_Raw_OR.Filenames(pversion, pUseOtherEnvironment).Base.CountyDBExtract, 				Corp2_Raw_OR.Layouts.CountyDBExtractLayoutBase, CountyDBExtract);
		tools.mac_FilesBase(Corp2_Raw_OR.Filenames(pversion, pUseOtherEnvironment).Base.EntityDBExtract, 				Corp2_Raw_OR.Layouts.EntityDBExtractLayoutBase, EntityDBExtract);
		tools.mac_FilesBase(Corp2_Raw_OR.Filenames(pversion, pUseOtherEnvironment).Base.MergerShareDBExtract, 	Corp2_Raw_OR.Layouts.MergerShareDBExtractLayoutBase, MergerShareDBExtract);
		tools.mac_FilesBase(Corp2_Raw_OR.Filenames(pversion, pUseOtherEnvironment).Base.NameDBExtract, 		 			Corp2_Raw_OR.Layouts.NameDBExtractLayoutBase, NameDBExtract);
		tools.mac_FilesBase(Corp2_Raw_OR.Filenames(pversion, pUseOtherEnvironment).Base.RelAssocNameDBExtract, 	Corp2_Raw_OR.Layouts.RelAssocNameDBExtractLayoutBase, RelAssocNameDBExtract);	
		tools.mac_FilesBase(Corp2_Raw_OR.Filenames(pversion, pUseOtherEnvironment).Base.TranDBExtract, 			 		Corp2_Raw_OR.Layouts.TranDBExtractLayoutBase, TranDBExtract);	
		
	END;

END;