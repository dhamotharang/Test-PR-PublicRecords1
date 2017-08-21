IMPORT tools;

EXPORT Files(STRING  pversion = '',
             BOOLEAN pUseOtherEnvironment = FALSE) := MODULE

	//////////////////////////////////////////////////////////////////
	// -- Input File Versions
	//////////////////////////////////////////////////////////////////
	EXPORT Input := MODULE

		tools.mac_FilesInput(Corp2_Raw_NH.Filenames(pversion, pUseOtherEnvironment).Input.Corporation, Corp2_Raw_NH.Layouts.CorporationLayoutIn, Corporation,
		                        'CSV', , pQuote := '"', pTerminator := ['\r\n', '\n'], pSeparator := ',');

		tools.mac_FilesInput(Corp2_Raw_NH.Filenames(pversion, pUseOtherEnvironment).Input.Address, Corp2_Raw_NH.Layouts.AddressLayoutIn, Address,
		                        'CSV', , pQuote := '"', pTerminator := ['\r\n', '\n'], pSeparator := ',');
														
		tools.mac_FilesInput(Corp2_Raw_NH.Filenames(pversion, pUseOtherEnvironment).Input.Filing, Corp2_Raw_NH.Layouts.FilingLayoutIn, Filing,
		                        'CSV', , pQuote := '"', pTerminator := ['\r\n', '\n'], pSeparator := ',');

		tools.mac_FilesInput(Corp2_Raw_NH.Filenames(pversion, pUseOtherEnvironment).Input.Merger,	Corp2_Raw_NH.Layouts.MergerLayoutIn, Merger,
		                        'CSV', , pQuote := '"', pTerminator := ['\r\n', '\n'], pSeparator := ',');
														
		tools.mac_FilesInput(Corp2_Raw_NH.Filenames(pversion, pUseOtherEnvironment).Input.CorporationName, Corp2_Raw_NH.Layouts.CorporationNameLayoutIn, CorporationName,
		                        'CSV', , pQuote := '"', pTerminator := ['\r\n', '\n'], pSeparator := ',');
		
		tools.mac_FilesInput(Corp2_Raw_NH.Filenames(pversion, pUseOtherEnvironment).Input.Officer, Corp2_Raw_NH.Layouts.OfficerLayoutIn, Officer,
		                        'CSV', , pQuote := '"', pTerminator := ['\r\n', '\n'], pSeparator := ',');
														
		tools.mac_FilesInput(Corp2_Raw_NH.Filenames(pversion, pUseOtherEnvironment).Input.Stock, Corp2_Raw_NH.Layouts.StockLayoutIn, Stock,
		                        'CSV', , pQuote := '"', pTerminator := ['\r\n', '\n'], pSeparator := ',');

		//Note:  AddressTypeTable exists but is not being used.  It is a lookup table of addresstypes with the associated addresstype description.
		//			 This is being included to eliminate confusion about the table's existence.
		EXPORT AddressTypeTable 	:= DATASET(Corp2_Raw_NH._dataset(pUseOtherEnvironment).thor_cluster_Files + 'lookup::' + Corp2_Raw_NH._dataset().name + '::' + pversion + '::addresstype_table::nh', Corp2_Raw_NH.Layouts.TableLayoutIn, 
																				 CSV(SEPARATOR([',']), QUOTE('"'), TERMINATOR(['\r\n', '\n'])));
		EXPORT DocumentIDTable 		:= DATASET(Corp2_Raw_NH._dataset(pUseOtherEnvironment).thor_cluster_Files + 'lookup::' + Corp2_Raw_NH._dataset().name + '::' + pversion + '::documenttypeid_table::nh', Corp2_Raw_NH.Layouts.TableLayoutIn, 
																				 CSV(SEPARATOR([',']), QUOTE('"'), TERMINATOR(['\r\n', '\n'])));
		EXPORT StockClassTable 		:= DATASET(Corp2_Raw_NH._dataset(pUseOtherEnvironment).thor_cluster_Files + 'lookup::' + Corp2_Raw_NH._dataset().name + '::' + pversion + '::stockclass_table::nh', Corp2_Raw_NH.Layouts.TableLayoutIn,
																				 CSV(SEPARATOR([',']), QUOTE('"'), TERMINATOR(['\r\n', '\n'])));
		EXPORT CorpTypeTable 			:= DATASET(Corp2_Raw_NH._dataset(pUseOtherEnvironment).thor_cluster_Files + 'lookup::' + Corp2_Raw_NH._dataset().name + '::' + pversion + '::corptype_table::nh', Corp2_Raw_NH.Layouts.TableLayoutIn,
																				 CSV(SEPARATOR([',']), QUOTE('"'), TERMINATOR(['\r\n', '\n'])));
		EXPORT StatusTable 				:= DATASET(Corp2_Raw_NH._dataset(pUseOtherEnvironment).thor_cluster_Files + 'lookup::' + Corp2_Raw_NH._dataset().name + '::' + pversion + '::statuscode_table::nh', Corp2_Raw_NH.Layouts.TableLayoutIn,
																				 CSV(SEPARATOR([',']), QUOTE('"'), TERMINATOR(['\r\n', '\n'])));
		EXPORT NameTypeTable 			:= DATASET(Corp2_Raw_NH._dataset(pUseOtherEnvironment).thor_cluster_Files + 'lookup::' + Corp2_Raw_NH._dataset().name + '::' + pversion + '::nametype_table::nh', Corp2_Raw_NH.Layouts.TableLayoutIn,
																				 CSV(SEPARATOR([',']), QUOTE('"'), TERMINATOR(['\r\n', '\n'])));
		EXPORT OffPartyTypeTable 	:= DATASET(Corp2_Raw_NH._dataset(pUseOtherEnvironment).thor_cluster_Files + 'lookup::' + Corp2_Raw_NH._dataset().name + '::' + pversion + '::offpartytype_table::nh', Corp2_Raw_NH.Layouts.OffPartyTypeTableLayoutIn,
																				 CSV(SEPARATOR([',']), QUOTE('"'), TERMINATOR(['\r\n', '\n'])));
		EXPORT PartyTypeTable 		:= DATASET(Corp2_Raw_NH._dataset(pUseOtherEnvironment).thor_cluster_Files + 'lookup::' + Corp2_Raw_NH._dataset().name + '::' + pversion + '::partytype_table::nh', Corp2_Raw_NH.Layouts.TableLayoutIn,
																				 CSV(SEPARATOR([',']), QUOTE('"'), TERMINATOR(['\r\n', '\n'])));
														
	END;

	//////////////////////////////////////////////////////////////////
	// -- Base File Versions
	//////////////////////////////////////////////////////////////////
	EXPORT Base := MODULE
		tools.mac_FilesBase(Corp2_Raw_NH.Filenames(pversion, pUseOtherEnvironment).Base.Corporation, 			Corp2_Raw_NH.Layouts.CorporationLayoutBase, Corporation);
		tools.mac_FilesBase(Corp2_Raw_NH.Filenames(pversion, pUseOtherEnvironment).Base.Address, 					Corp2_Raw_NH.Layouts.AddressLayoutBase, Address);
		tools.mac_FilesBase(Corp2_Raw_NH.Filenames(pversion, pUseOtherEnvironment).Base.Filing, 					Corp2_Raw_NH.Layouts.FilingLayoutBase, Filing);
		tools.mac_FilesBase(Corp2_Raw_NH.Filenames(pversion, pUseOtherEnvironment).Base.Merger, 		 			Corp2_Raw_NH.Layouts.MergerLayoutBase, Merger);
		tools.mac_FilesBase(Corp2_Raw_NH.Filenames(pversion, pUseOtherEnvironment).Base.CorporationName, 	Corp2_Raw_NH.Layouts.CorporationNameLayoutBase, CorporationName);	
		tools.mac_FilesBase(Corp2_Raw_NH.Filenames(pversion, pUseOtherEnvironment).Base.Officer, 			 		Corp2_Raw_NH.Layouts.OfficerLayoutBase, Officer);	
		tools.mac_FilesBase(Corp2_Raw_NH.Filenames(pversion, pUseOtherEnvironment).Base.Stock, 			 			Corp2_Raw_NH.Layouts.StockLayoutBase, Stock);	

	END;

END;