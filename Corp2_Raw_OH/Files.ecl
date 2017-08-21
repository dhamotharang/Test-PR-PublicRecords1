import ut, tools, Corp2_Mapping;

EXPORT Files(STRING  pversion = '',
             BOOLEAN pUseOtherEnvironment = FALSE) := MODULE

	//////////////////////////////////////////////////////////////////
	// -- Input File Versions
	//////////////////////////////////////////////////////////////////
	EXPORT Input := MODULE
	
		tools.mac_FilesInput(Corp2_Raw_OH.Filenames(pversion, pUseOtherEnvironment ).Input.Business_Address, Corp2_Raw_OH.Layouts.Business_AddressLayoutIn,Business_Address,
												'CSV', ,pQuote := '', pTerminator := ['\r\n', '\n'], pSeparator := '|');
								
		tools.mac_FilesInput(Corp2_Raw_OH.Filenames(pversion, pUseOtherEnvironment ).Input.Agent_Contact,	Corp2_Raw_OH.Layouts.Agent_ContactLayoutIn, Agent_Contact,
												'CSV',, pQuote := '', pTerminator := ['\r\n', '\n'], pSeparator := '|');
														
		tools.mac_FilesInput(Corp2_Raw_OH.Filenames(pversion, pUseOtherEnvironment ).Input.Business_Associate, Corp2_Raw_OH.Layouts.Business_AssociateLayoutIn, Business_Associate,
												'CSV',, pQuote := '', pTerminator := ['\r\n', '\n'], pSeparator := '|');
								
		tools.mac_FilesInput(Corp2_Raw_OH.Filenames(pversion, pUseOtherEnvironment ).Input.Business, Corp2_Raw_OH.Layouts.BusinessLayoutIn, Business,
												'CSV', ,pQuote := '', pTerminator := ['\r\n', '\n'], pSeparator := '|');
									
		tools.mac_FilesInput(Corp2_Raw_OH.Filenames(pversion, pUseOtherEnvironment ).Input.Explanation, Corp2_Raw_OH.Layouts.ExplanationLayoutIn, Explanation,
												'CSV', ,pQuote := '', pTerminator := ['\r\n', '\n'], pSeparator := '|');
									
		tools.mac_FilesInput(Corp2_Raw_OH.Filenames(pversion, pUseOtherEnvironment ).Input.Text_Information, Corp2_Raw_OH.Layouts.Text_InformationLayoutIn, Text_Information,
												'CSV', ,pQuote := '', pTerminator := ['\r\n', '\n'], pSeparator := '|');
									 
		tools.mac_FilesInput(Corp2_Raw_OH.Filenames(pversion, pUseOtherEnvironment ).Input.Authorized_Share, Corp2_Raw_OH.Layouts.Authorized_ShareLayoutIn, Authorized_Share,
												'CSV', ,pQuote := '', pTerminator := ['\r\n', '\n'], pSeparator := '|');
											
		tools.mac_FilesInput(Corp2_Raw_OH.Filenames(pversion, pUseOtherEnvironment ).Input.Old_Name, Corp2_Raw_OH.Layouts.Old_NameLayoutIn, Old_Name,
												'CSV', ,pQuote := '', pTerminator := ['\r\n', '\n'], pSeparator := '|');
											
		tools.mac_FilesInput(Corp2_Raw_OH.Filenames(pversion, pUseOtherEnvironment ).Input.Document_Transaction, Corp2_Raw_OH.Layouts.Document_TransactionLayoutIn, Document_Transaction,
												'CSV', ,pQuote := '', pTerminator := ['\r\n', '\n'], pSeparator := '|');									 
																																										
		EXPORT  StateCodeTable  := dataset(corp2_mapping._dataset(pUseOtherEnvironment).thor_cluster_files + 'lookup::corp2::' + pversion + '::StateCodeType_Table::oh',Corp2_Raw_OH.Layouts.StateCodeLayout,CSV(SEPARATOR(['|']), QUOTE(''), TERMINATOR(['\r\n', '\n'])));

		EXPORT  TranCodeTable   := dataset(corp2_mapping._dataset(pUseOtherEnvironment).thor_cluster_files + 'lookup::corp2::' + pversion + '::TranCodeType_Table::oh',Corp2_Raw_OH.Layouts.TranCodeLayout,CSV(SEPARATOR(['|']), QUOTE(''), TERMINATOR(['\r\n', '\n'])));

		EXPORT  CountyCodeTable := dataset(corp2_mapping._dataset(pUseOtherEnvironment).thor_cluster_files + 'lookup::corp2::' + pversion + '::CountyCodeType_Table::oh',Corp2_Raw_OH.Layouts.CountyCodeLayout,CSV(SEPARATOR(['|']), QUOTE(''), TERMINATOR(['\r\n', '\n'])));

		EXPORT  ShareTypeTable  := dataset(corp2_mapping._dataset(pUseOtherEnvironment).thor_cluster_files + 'lookup::corp2::' + pversion + '::shareType_Table::oh',Corp2_Raw_OH.Layouts.shareTypeLayout,CSV(SEPARATOR(['|']), QUOTE(''), TERMINATOR(['\r\n', '\n'])));

		
	END;
	
	 //////////////////////////////////////////////////////////////////
			// -- Base File Versions
	//////////////////////////////////////////////////////////////////
	EXPORT Base := MODULE

		tools.mac_FilesBase(Corp2_Raw_OH.Filenames(pversion, pUseOtherEnvironment ).Base.Business_Address,     Corp2_Raw_OH.Layouts.Business_AddressLayoutBase, Business_Address);
		tools.mac_FilesBase(Corp2_Raw_OH.Filenames(pversion, pUseOtherEnvironment ).Base.Agent_Contact, 		   Corp2_Raw_OH.Layouts.Agent_ContactLayoutBase, Agent_Contact);
		tools.mac_FilesBase(Corp2_Raw_OH.Filenames(pversion, pUseOtherEnvironment ).Base.Business_Associate, 	 Corp2_Raw_OH.Layouts.Business_AssociateLayoutBase, Business_Associate);
		tools.mac_FilesBase(Corp2_Raw_OH.Filenames(pversion, pUseOtherEnvironment ).Base.Business, 		 				 Corp2_Raw_OH.Layouts.BusinessLayoutBase, Business);
		tools.mac_FilesBase(Corp2_Raw_OH.Filenames(pversion, pUseOtherEnvironment ).Base.Explanation, 			 	 Corp2_Raw_OH.Layouts.ExplanationLayoutBase, Explanation);
		tools.mac_FilesBase(Corp2_Raw_OH.Filenames(pversion, pUseOtherEnvironment ).Base.Text_Information, 		 Corp2_Raw_OH.Layouts.Text_InformationLayoutBase, Text_Information);	
		tools.mac_FilesBase(Corp2_Raw_OH.Filenames(pversion, pUseOtherEnvironment ).Base.Authorized_Share, 	   Corp2_Raw_OH.Layouts.Authorized_ShareLayoutBase, Authorized_Share);
		tools.mac_FilesBase(Corp2_Raw_OH.Filenames(pversion, pUseOtherEnvironment ).Base.Old_Name, 		 				 Corp2_Raw_OH.Layouts.Old_NameLayoutBase, Old_Name);
		tools.mac_FilesBase(Corp2_Raw_OH.Filenames(pversion, pUseOtherEnvironment ).Base.Document_Transaction, Corp2_Raw_OH.Layouts.Document_TransactionLayoutBase, Document_Transaction);

	END;

END;