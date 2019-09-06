import ut, tools, Corp2_Mapping; 

EXPORT Files(STRING  pversion = '',
             BOOLEAN pUseOtherEnvironment = FALSE) := MODULE

	//////////////////////////////////////////////////////////////////
	// -- Input File Versions
	//////////////////////////////////////////////////////////////////
	EXPORT Input := MODULE
	
		tools.mac_FilesInput(Filenames(pversion,pUseOtherEnvironment).Input.Filing,    Corp2_Raw_ND.Layouts.FilingLayoutIn, Filing,
			'CSV', , pTerminator := ['\r\n', '\n'], pSeparator := ',', pHeading := 1, pQuote := '"');
		tools.mac_FilesInput(Filenames(pversion,pUseOtherEnvironment).Input.Owner,     Corp2_Raw_ND.Layouts.OwnerLayoutIn,  Owner,
			'CSV', , pTerminator := ['\r\n', '\n'], pSeparator := ',', pHeading := 1, pQuote := '"');
		tools.mac_FilesInput(Filenames(pversion,pUseOtherEnvironment).Input.Trademark, Corp2_Raw_ND.Layouts.TMLayoutIn,     Trademark,
			'CSV', , pTerminator := ['\r\n', '\n'], pSeparator := ',', pHeading := 1, pQuote := '"');
		
		// TrademarkClass file needs to be read in to keep the virtual fileposition due to needing the records to 
		//    remain in the original order the vendor sends them.  The original first 6 records per sos_control_id are 
		//    needed for mapping.  Those first 6 are considered the primary records.
    EXPORT TrademarkClass := dataset('~thor_data400::in::corp2::'+pversion+'::trademark_class::nd',
								 {Corp2_Raw_ND.Layouts.TMClassLayoutIn, UNSIGNED8 RecPos{virtual(fileposition)}},
								 CSV(HEADING(1),SEPARATOR([',']), TERMINATOR(['\r\n', '\n']), QUOTE('"')));
				
	END;

END;

