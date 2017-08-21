import ut, tools;

EXPORT Files(STRING  pversion = '', 
						 BOOLEAN pUseOtherEnvironment = FALSE) := MODULE

	EXPORT Input := MODULE
	
		tools.mac_FilesInput(Filenames(pversion, pUseOtherEnvironment).Input.Comfichex, Corp2_Raw_WI.Layouts.ReportLineLayoutIn, Comfichex,
												 'CSV', , pTerminator := ['\r\n'],pSeparator:='' , pHeading := 1, pNoTrim := true);
												 
		EXPORT ComfichexRaw						:= Comfichex.logical;	
		EXPORT ComfichexFixedString		:= Corp2_Raw_WI.FileComfichexRaw(ComfichexRaw);		
		EXPORT ComfichexFixed					:= Corp2_Raw_WI.FileComfichex(ComfichexFixedString);

	END;

	EXPORT Base := MODULE
	
		tools.mac_FilesBase(Filenames(pversion, pUseOtherEnvironment).Base.Comfichex, Corp2_Raw_WI.Layouts.fullLine_Raw_Base, Comfichex);
		
	END;

end;