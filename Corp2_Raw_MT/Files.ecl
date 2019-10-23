import ut, tools, corp2, Corp2_Raw_MT;

EXPORT Files(STRING  pversion = '',
             BOOLEAN pUseOtherEnvironment = FALSE) := MODULE

	//-----------------------------------------------------------------------------------------
	// Input Files
	// NOTE:  All files are contained within the Vendor Raw file.  
	//        The first field of each record is the record type.
	//-----------------------------------------------------------------------------------------
	EXPORT Input := MODULE
	
	  tools.mac_FilesInput(Corp2_Raw_MT.Filenames(pversion, pUseOtherEnvironment).Input.VendorRaw, Corp2_Raw_MT.Layouts.VendorRawLayoutIn, VendorRaw,
		                     'CSV',,pTerminator := ['\n','\r\n','\n\r'], pSeparator := [','], pHeading := 0, pMaxLength := 8192);
												 
		tools.mac_FilesInput(Corp2_Raw_MT.Filenames(pversion, pUseOtherEnvironment).Input.VendorRaw, Corp2_Raw_MT.Layouts.FileABNLayoutIn, ABNRaw,
		                     'CSV',, pTerminator := ['\n','\r\n','\n\r'], pSeparator := [','], pHeading := 0, pMaxLength := 8192);
		
		tools.mac_FilesInput(Corp2_Raw_MT.Filenames(pversion, pUseOtherEnvironment).Input.VendorRaw, Corp2_Raw_MT.Layouts.FileBECORPLayoutIn, BECORPRaw,
												 'CSV',, pTerminator := ['\n','\r\n','\n\r'], pSeparator := [','], pHeading := 0, pMaxLength := 8192);
												
		tools.mac_FilesInput(Corp2_Raw_MT.Filenames(pversion, pUseOtherEnvironment).Input.VendorRaw, Corp2_Raw_MT.Layouts.FileBELLCLayoutIn, BELLCRaw,
												 'CSV',, pTerminator := ['\n','\r\n','\n\r'], pSeparator := [','], pHeading := 0, pMaxLength := 8192);
												
		tools.mac_FilesInput(Corp2_Raw_MT.Filenames(pversion, pUseOtherEnvironment).Input.VendorRaw, Corp2_Raw_MT.Layouts.FileBELLPLayoutIn, BELLPRaw,
												 'CSV',, pTerminator := ['\n','\r\n','\n\r'], pSeparator := [','], pHeading := 0, pMaxLength := 8192);										
												
		tools.mac_FilesInput(Corp2_Raw_MT.Filenames(pversion, pUseOtherEnvironment).Input.VendorRaw, Corp2_Raw_MT.Layouts.FileBELPLayoutIn, BELPRaw,
												 'CSV',, pTerminator := ['\n','\r\n','\n\r'], pSeparator := [','], pHeading := 0, pMaxLength := 8192);
												
		tools.mac_FilesInput(Corp2_Raw_MT.Filenames(pversion, pUseOtherEnvironment).Input.VendorRaw, Corp2_Raw_MT.Layouts.FileFBNLayoutIn, FBNRaw,
												 'CSV',, pTerminator := ['\n','\r\n','\n\r'], pSeparator := [','], pHeading := 0, pMaxLength := 8192);
												
		tools.mac_FilesInput(Corp2_Raw_MT.Filenames(pversion, pUseOtherEnvironment).Input.VendorRaw, Corp2_Raw_MT.Layouts.FileTMLayoutIn, TMRaw,
												 'CSV',, pTerminator := ['\n','\r\n','\n\r'], pSeparator := [','], pHeading := 0, pMaxLength := 8192);
												
		tools.mac_FilesInput(Corp2_Raw_MT.Filenames(pversion, pUseOtherEnvironment).Input.VendorRaw, Corp2_Raw_MT.Layouts.FileOwnerLayoutIn, OWNERRaw,
												 'CSV',, pTerminator := ['\n','\r\n','\n\r'], pSeparator := [','], pHeading := 0, pMaxLength := 8192);
												
		tools.mac_FilesInput(Corp2_Raw_MT.Filenames(pversion, pUseOtherEnvironment).Input.VendorRaw, Corp2_Raw_MT.Layouts.FilePartnerLayoutIn, PARTNERRaw,
												 'CSV',, pTerminator := ['\n','\r\n','\n\r'], pSeparator := [','], pHeading := 0, pMaxLength := 8192);
												
		tools.mac_FilesInput(Corp2_Raw_MT.Filenames(pversion, pUseOtherEnvironment).Input.VendorRaw, Corp2_Raw_MT.Layouts.FileMemberLayoutIn, MEMBERRaw,
												 'CSV',, pTerminator := ['\n','\r\n','\n\r'], pSeparator := [','], pHeading := 0, pMaxLength := 8192);
												
		tools.mac_FilesInput(Corp2_Raw_MT.Filenames(pversion, pUseOtherEnvironment).Input.VendorRaw, Corp2_Raw_MT.Layouts.FileSharesLayoutIn, SHARESRaw,
												 'CSV',, pTerminator := ['\n','\r\n','\n\r'], pSeparator := [','], pHeading := 0, pMaxLength := 8192);
																																										
		tools.mac_FilesInput(Corp2_Raw_MT.Filenames(pversion, pUseOtherEnvironment).Input.VendorRaw, Corp2_Raw_MT.Layouts.FileAgentLayoutIn, AGENTRaw,
												 'CSV',, pTerminator := ['\n','\r\n','\n\r'], pSeparator := [','], pHeading := 0, pMaxLength := 8192);
												
		tools.mac_FilesInput(Corp2_Raw_MT.Filenames(pversion, pUseOtherEnvironment).Input.VendorRaw, Corp2_Raw_MT.Layouts.FilePrincipalLayoutIn, PRINCIPALRaw,
												 'CSV',, pTerminator := ['\n','\r\n','\n\r'], pSeparator := [','], pHeading := 0, pMaxLength := 8192);
												
		tools.mac_FilesInput(Corp2_Raw_MT.Filenames(pversion, pUseOtherEnvironment).Input.VendorRaw, Corp2_Raw_MT.Layouts.FileRelatedABNLayoutIn, RELATEDABNRaw,
												 'CSV',, pTerminator := ['\n','\r\n','\n\r'], pSeparator := [','], pHeading := 0, pMaxLength := 8192);
												
		tools.mac_FilesInput(Corp2_Raw_MT.Filenames(pversion, pUseOtherEnvironment).Input.VendorRaw, Corp2_Raw_MT.Layouts.FileRelatedTrademarkLayoutIn, RELATEDTMRaw,
												 'CSV',, pTerminator := ['\n','\r\n','\n\r'], pSeparator := [','], pHeading := 0, pMaxLength := 8192);
																																																				
												
		// Extract by record type into separate files
		EXPORT ABN_Entity     := ABNRaw.Logical(corp2.t2u(EntityRole) = 'ABN');
		EXPORT BECORP_Entity  := BECORPRaw.Logical(corp2.t2u(EntityRole) = 'BE-CORP');
		EXPORT BELLC_Entity   := BELLCRaw.Logical(corp2.t2u(EntityRole) = 'BE-LLC');
		EXPORT BELLP_Entity   := BELLPRaw.Logical(corp2.t2u(EntityRole) = 'BE-LLP');
		EXPORT BELP_Entity    := BELPRaw.Logical(corp2.t2u(EntityRole) = 'BE-LP');
		EXPORT FBN_Entity     := FBNRaw.Logical(corp2.t2u(EntityRole) = 'FBN');
		EXPORT TM_Entity      := TMRaw.Logical(corp2.t2u(EntityRole) = 'TM');
		EXPORT Owner          := OwnerRaw.Logical(corp2.t2u(EntityRole) = 'OWNER');						
		EXPORT Partner        := PartnerRaw.Logical(corp2.t2u(EntityRole) = 'PARTNER');
		EXPORT Member         := MemberRaw.Logical(corp2.t2u(EntityRole) = 'MEMBER');																														 
		EXPORT Shares         := SharesRaw.Logical(corp2.t2u(EntityRole) = 'SHARES');
		EXPORT Agent          := AgentRaw.Logical(corp2.t2u(EntityRole) = 'AGENT');
		EXPORT Principal      := PrincipalRaw.Logical(corp2.t2u(EntityRole) = 'PRINCIPAL');
		EXPORT RelatedABN     := RelatedABNRaw.Logical(corp2.t2u(EntityRole) = 'RELATED_ABN');
		EXPORT RelatedTM      := RelatedTMRaw.Logical(corp2.t2u(EntityRole) = 'RELATED_TRADEMARK');
	END;	
	
END;