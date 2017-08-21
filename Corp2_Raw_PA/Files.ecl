import data_services, tools, Corp2_Raw_PA;

EXPORT Files(STRING  pversion = '',
             BOOLEAN pUseOtherEnvironment = FALSE) := MODULE

	// Input File Versions
	// --------------------
	EXPORT Input := MODULE
	
	  // Vendor Data files
		tools.mac_FilesInput(Corp2_Raw_PA.Filenames(pversion, pUseOtherEnvironment).Input.Corporations, Corp2_Raw_PA.Layouts.BlobRec, Corporation,
		           'CSV', , pTerminator := ['\r\n','\n'], pSeparator := '', pHeading := 1);
		tools.mac_FilesInput(Corp2_Raw_PA.Filenames(pversion, pUseOtherEnvironment).Input.CorpName, Corp2_Raw_PA.Layouts.BlobRec, CorpName,
		           'CSV', , pTerminator := ['\r\n','\n'], pSeparator := '', pHeading := 1);	
		tools.mac_FilesInput(Corp2_Raw_PA.Filenames(pversion, pUseOtherEnvironment).Input.Address,	Corp2_Raw_PA.Layouts.AddressLayoutIn, Address,
		           'CSV', , pQuote := '"', pTerminator := ['\r\n','\n'], pSeparator := ',', pHeading := 1);
		tools.mac_FilesInput(Corp2_Raw_PA.Filenames(pversion, pUseOtherEnvironment).Input.Officer, Corp2_Raw_PA.Layouts.OfficerLayoutIn, Officer,
		           'CSV', , pQuote := '"', pTerminator := ['\r\n','\n'], pSeparator := ',', pHeading := 1);
		tools.mac_FilesInput(Corp2_Raw_PA.Filenames(pversion, pUseOtherEnvironment).Input.Filing, Corp2_Raw_PA.Layouts.FilingLayoutIn, Filing,
		           'CSV', , pQuote := '"', pTerminator := ['\r\n','\n'], pSeparator := ',', pHeading := 1);														
		tools.mac_FilesInput(Corp2_Raw_PA.Filenames(pversion, pUseOtherEnvironment).Input.Merger, Corp2_Raw_PA.Layouts.MergerLayoutIn, Merger,
		           'CSV', , pQuote := '"', pTerminator := ['\r\n','\n'], pSeparator := ',', pHeading := 1);														

		// The Stock file is always empty and will be checked in the mapper to verify that it's still empty
		tools.mac_FilesInput(Corp2_Raw_PA.Filenames(pversion, pUseOtherEnvironment).Input.Stock, Corp2_Raw_PA.Layouts.StockLayoutIn, Stock,
		           'CSV', , pQuote := '"', pTerminator := ['\r\n','\n'], pSeparator := ',', pHeading := 1);
	
	
	// The Corporations file from the vendor doesn't parse properly on every record as a comma-delimited file.
	// The steps below convert it to a pipe-delimited file to be used by the mapper
		Corp2_Raw_PA.Layouts.BlobRec blobTrf(Corp2_Raw_PA.Layouts.BlobRec l):= transform  
			self.blob := regexreplace('"',
										(regexreplace('","',
											(regexreplace('^"|"$',
												(regexreplace('\\|',l.blob,' ')) // first replace '|' (pipe) with blank
																							,'')) 		 // second remove '"' (double-quotes) from beginning and end 
																				 ,'|'))          // third replace '","' with |	(pipe)
																			,'');              // lastly, remove extraneous '"' (double-quotes)    
		end; 
		cleanBlob	:= project(Corporation.Logical, blobTrf(left));
		output(cleanBlob,,'~thor_data400::in::corp2::'+pversion+'::pipedelim::Corporation::pa',csv,overwrite);

		EXPORT CorporationsPipeDelim := dataset('~thor_data400::in::corp2::'+pversion+'::pipedelim::Corporation::pa'
					,Corp2_Raw_PA.Layouts.CorporationsLayoutIn ,CSV(SEPARATOR(['|']), TERMINATOR(['\r\n', '\n'])));
	
	
	// The CorpName file from the vendor doesn't parse properly on every record as a comma-delimited file.
	// The steps below convert it to a pipe-delimited file to be used by the mapper
		Corp2_Raw_PA.Layouts.BlobRec blobTrf2(Corp2_Raw_PA.Layouts.BlobRec l):= transform  
			self.blob := regexreplace('"',
										(regexreplace('","',
											(regexreplace('^"|"$',
												(regexreplace('\\|',l.blob,' ')) // first replace '|' (pipe) with blank
																							,'')) 		 // second remove '"' (double-quotes) from beginning and end 
																				 ,'|'))          // third replace '","' with |	(pipe)
																			,'');              // lastly, remove extraneous '"' (double-quotes)    
		end; 
		cleanBlob2	:= project(CorpName.Logical, blobTrf2(left));
		output(cleanBlob2,,'~thor_data400::in::corp2::'+pversion+'::pipedelim::CorporationName::pa',csv,overwrite);

		EXPORT CorpNamePipeDelim := dataset('~thor_data400::in::corp2::'+pversion+'::pipedelim::CorporationName::pa'
					,Corp2_Raw_PA.Layouts.CorpNameLayoutIn ,CSV(SEPARATOR(['|']), TERMINATOR(['\r\n', '\n'])));
		
		// Vendor Lookup Files
		EXPORT lookup_CorpStatus  := dataset(_Dataset(pUseOtherEnvironment).thor_cluster_Files + 'lookup::corp2::'+pversion+'::CorporationStatus::pa',Corp2_Raw_PA.Layouts.LookupLay_CorpStatus ,csv(heading(0), separator(','), terminator(['\n','\r\n']), quote('"')));		 
		EXPORT lookup_CorpType    := dataset(_Dataset(pUseOtherEnvironment).thor_cluster_Files + 'lookup::corp2::'+pversion+'::CorporationType::pa',Corp2_Raw_PA.Layouts.LookupLay_CorpType ,csv(heading(0), separator(','), terminator(['\n','\r\n']), quote('"')));
		EXPORT lookup_NameType    := dataset(_Dataset(pUseOtherEnvironment).thor_cluster_Files + 'lookup::corp2::'+pversion+'::NameType::pa',Corp2_Raw_PA.Layouts.LookupLay_NameType ,csv(heading(0), separator(','), terminator(['\n','\r\n']), quote('"')));		 
		EXPORT lookup_AddrType    := dataset(_Dataset(pUseOtherEnvironment).thor_cluster_Files + 'lookup::corp2::'+pversion+'::AddressType::pa',Corp2_Raw_PA.Layouts.LookupLay_AddrType ,csv(heading(0), separator(','), terminator(['\n','\r\n']), quote('"')));
		EXPORT lookup_OfficerParty:= dataset(_Dataset(pUseOtherEnvironment).thor_cluster_Files + 'lookup::corp2::'+pversion+'::OfficerPartyType::pa',Corp2_Raw_PA.Layouts.LookupLay_OfficerParty ,csv(heading(0), separator(','), terminator(['\n','\r\n']), quote('"')));
		EXPORT lookup_PartyType   := dataset(_Dataset(pUseOtherEnvironment).thor_cluster_Files + 'lookup::corp2::'+pversion+'::PartyType::pa',Corp2_Raw_PA.Layouts.LookupLay_PartyType ,csv(heading(0), separator(','), terminator(['\n','\r\n']), quote('"')));		 
		EXPORT lookup_DocType     := dataset(_Dataset(pUseOtherEnvironment).thor_cluster_Files + 'lookup::corp2::'+pversion+'::DocumentType::pa',Corp2_Raw_PA.Layouts.LookupLay_DocType ,csv(heading(0), separator(','), terminator(['\n','\r\n']), quote('"')));
         	 
	END;

	// Base File Versions
	// --------------------
	EXPORT Base := MODULE
		tools.mac_FilesBase(Corp2_Raw_PA.Filenames(pversion, pUseOtherEnvironment).Base.CorpName,     Corp2_Raw_PA.Layouts.CorpNameLayoutBase, CorpName);
		tools.mac_FilesBase(Corp2_Raw_PA.Filenames(pversion, pUseOtherEnvironment).Base.Address, 			Corp2_Raw_PA.Layouts.AddressLayoutBase, Address);
		tools.mac_FilesBase(Corp2_Raw_PA.Filenames(pversion, pUseOtherEnvironment).Base.Officer, 		  Corp2_Raw_PA.Layouts.OfficerLayoutBase, Officer);
		tools.mac_FilesBase(Corp2_Raw_PA.Filenames(pversion, pUseOtherEnvironment).Base.Corporations, Corp2_Raw_PA.Layouts.CorporationsLayoutBase, Corporations);	
		tools.mac_FilesBase(Corp2_Raw_PA.Filenames(pversion, pUseOtherEnvironment).Base.Filing, 			Corp2_Raw_PA.Layouts.FilingLayoutBase, Filing);	
		tools.mac_FilesBase(Corp2_Raw_PA.Filenames(pversion, pUseOtherEnvironment).Base.Merger, 			Corp2_Raw_PA.Layouts.MergerLayoutBase, Merger);	
	END;

END;

