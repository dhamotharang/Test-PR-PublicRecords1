import corp2_mapping, ut, tools;

EXPORT Files(STRING  pversion = '',
             BOOLEAN pUseOtherEnvironment = FALSE) := MODULE

	//////////////////////////////////////////////////////////////////
	// -- Input File Versions
	//////////////////////////////////////////////////////////////////
	EXPORT Input := MODULE
	
		tools.mac_FilesInput(Corp2_Raw_NM.Filenames(pversion, pUseOtherEnvironment).Input.ImportMaster, Corp2_Raw_NM.Layouts.ImportMasterLayoutIn, ImportMaster,
		                        'CSV', , pQuote := '"', pTerminator := ['\n','\r\n','\n\r'], pSeparator := ',', pHeading := 1);
		                        
	//Vendor changed separator value from \t to comma on 11/7/2016 -> keeping for documentation purposes													
	//												'CSV', , pQuote := '"', pTerminator := ['\n','\r\n','\n\r'], pSeparator := '\t|',',', pHeading := 2);															
														
	END;

	//////////////////////////////////////////////////////////////////
	// -- Base File Versions
	//////////////////////////////////////////////////////////////////
	EXPORT Base := MODULE
		tools.mac_FilesBase(Corp2_Raw_NM.Filenames(pversion, pUseOtherEnvironment).Base.ImportMaster, Corp2_Raw_NM.Layouts.ImportMasterLayoutBase, ImportMaster);	
	END;

end;