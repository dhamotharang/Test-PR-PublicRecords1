import corp2_mapping, Corp2_Raw_VT, tools, ut;

EXPORT Files(STRING  pversion = '',
             BOOLEAN pUseOtherEnvironment = FALSE) := MODULE

	//////////////////////////////////////////////////////////////////
	// -- Input File Versions
	//////////////////////////////////////////////////////////////////
	EXPORT Input := MODULE		 

		tools.mac_FilesInput(Corp2_Raw_VT.Filenames(pversion, pUseOtherEnvironment).Input.DomLLCBus, Corp2_Raw_VT.Layouts.BusLayoutIn, DomLLCBus,
												 'CSV', , pQuote := '"', pTerminator := ['\n','\r\n'], pSeparator := ',', pHeading := 1);
		tools.mac_FilesInput(Corp2_Raw_VT.Filenames(pversion, pUseOtherEnvironment).Input.DomMBEBus, Corp2_Raw_VT.Layouts.BusLayoutIn,DomMBEBus,
		                     'CSV', , pQuote := '"', pTerminator := ['\n','\r\n'], pSeparator := ',', pHeading := 1);
		tools.mac_FilesInput(Corp2_Raw_VT.Filenames(pversion, pUseOtherEnvironment).Input.DomNPCBus, Corp2_Raw_VT.Layouts.BusLayoutIn,DomNPCBus,
		                     'CSV', , pQuote := '"', pTerminator := ['\n','\r\n'], pSeparator := ',', pHeading := 1);
		tools.mac_FilesInput(Corp2_Raw_VT.Filenames(pversion, pUseOtherEnvironment).Input.DomProfBus, Corp2_Raw_VT.Layouts.BusLayoutIn, DomProfBus,
		                     'CSV', , pQuote := '"', pTerminator := ['\n','\r\n'], pSeparator := ',', pHeading := 1);
		tools.mac_FilesInput(Corp2_Raw_VT.Filenames(pversion, pUseOtherEnvironment).Input.ForLLCBus, Corp2_Raw_VT.Layouts.BusLayoutIn,ForLLCBus,
		                     'CSV', , pQuote := '"', pTerminator := ['\n','\r\n'], pSeparator := ',', pHeading := 1);
		tools.mac_FilesInput(Corp2_Raw_VT.Filenames(pversion, pUseOtherEnvironment).Input.ForNPCBus, Corp2_Raw_VT.Layouts.BusLayoutIn, ForNPCBus,
		                     'CSV', , pQuote := '"', pTerminator := ['\n','\r\n'], pSeparator := ',', pHeading := 1);
		tools.mac_FilesInput(Corp2_Raw_VT.Filenames(pversion, pUseOtherEnvironment).Input.ForProfBus, Corp2_Raw_VT.Layouts.BusLayoutIn,ForProfBus,
		                     'CSV', , pQuote := '"', pTerminator := ['\n','\r\n'], pSeparator := ',', pHeading := 1);
		tools.mac_FilesInput(Corp2_Raw_VT.Filenames(pversion, pUseOtherEnvironment).Input.PshipsBus, Corp2_Raw_VT.Layouts.BusLayoutIn, PshipsBus,
		                     'CSV', , pQuote := '"', pTerminator := ['\n','\r\n'], pSeparator := ',', pHeading := 1);
		tools.mac_FilesInput(Corp2_Raw_VT.Filenames(pversion, pUseOtherEnvironment).Input.TrdNamesBus, Corp2_Raw_VT.Layouts.BusLayoutIn,TrdNamesBus,
		                     'CSV', , pQuote := '"', pTerminator := ['\n','\r\n'], pSeparator := ',', pHeading := 1);
												 
		tools.mac_FilesInput(Corp2_Raw_VT.Filenames(pversion, pUseOtherEnvironment).Input.DomLLCPrn, Corp2_Raw_VT.Layouts.PrnLayoutIn,DomLLCPrn,
		                     'CSV', , pQuote := '"', pTerminator := ['\n','\r\n'], pSeparator := ',', pHeading := 1);
		tools.mac_FilesInput(Corp2_Raw_VT.Filenames(pversion, pUseOtherEnvironment).Input.DomMBEPrn, Corp2_Raw_VT.Layouts.PrnLayoutIn,DomMBEPrn,
		                     'CSV', , pQuote := '"', pTerminator := ['\n','\r\n'], pSeparator := ',', pHeading := 1);
		tools.mac_FilesInput(Corp2_Raw_VT.Filenames(pversion, pUseOtherEnvironment).Input.DomNPCPrn, Corp2_Raw_VT.Layouts.PrnLayoutIn,DomNPCPrn,
		                     'CSV', , pQuote := '"', pTerminator := ['\n','\r\n'], pSeparator := ',', pHeading := 1);
		tools.mac_FilesInput(Corp2_Raw_VT.Filenames(pversion, pUseOtherEnvironment).Input.DomProfPrn, Corp2_Raw_VT.Layouts.PrnLayoutIn,DomProfPrn,
		                     'CSV', , pQuote := '"', pTerminator := ['\n','\r\n'], pSeparator := ',', pHeading := 1);
		tools.mac_FilesInput(Corp2_Raw_VT.Filenames(pversion, pUseOtherEnvironment).Input.PshipsPrn, Corp2_Raw_VT.Layouts.PrnLayoutIn, PshipsPrn,
		                     'CSV', , pQuote := '"', pTerminator := ['\n','\r\n'], pSeparator := ',', pHeading := 1);	
		tools.mac_FilesInput(Corp2_Raw_VT.Filenames(pversion, pUseOtherEnvironment).Input.ForLLCPrn, Corp2_Raw_VT.Layouts.PrnLayoutIn,ForLLCPrn,
		                     'CSV', , pQuote := '"', pTerminator := ['\n','\r\n'], pSeparator := ',', pHeading := 1);
		tools.mac_FilesInput(Corp2_Raw_VT.Filenames(pversion, pUseOtherEnvironment).Input.ForNPCPrn, Corp2_Raw_VT.Layouts.PrnLayoutIn,ForNPCPrn,
		                     'CSV', , pQuote := '"', pTerminator := ['\n','\r\n'], pSeparator := ',', pHeading := 1);
		tools.mac_FilesInput(Corp2_Raw_VT.Filenames(pversion, pUseOtherEnvironment).Input.ForProfPrn, Corp2_Raw_VT.Layouts.PrnLayoutIn,ForProfPrn,
		                     'CSV', , pQuote := '"', pTerminator := ['\n','\r\n'], pSeparator := ',', pHeading := 1);
		tools.mac_FilesInput(Corp2_Raw_VT.Filenames(pversion, pUseOtherEnvironment).Input.TrdNamesPrn, Corp2_Raw_VT.Layouts.PrnLayoutIn,TrdNamesPrn,
		                     'CSV', , pQuote := '"', pTerminator := ['\n','\r\n'], pSeparator := ',', pHeading := 1);
												 
		tools.mac_FilesInput(Corp2_Raw_VT.Filenames(pversion, pUseOtherEnvironment).Input.TrdNamesOwn, Corp2_Raw_VT.Layouts.TrdNamesOwnLayoutIn,TrdNamesOwn,
		                     'CSV', , pQuote := '"', pTerminator := ['\n','\r\n'], pSeparator := ',', pHeading := 1);
				
   /*All Business files!
		 DomLLCBus-Domestic Limited Liability Company, DomMBEBus-Domestic Mutual Benefit Enterprise, 
		 DomNPCBus-Domestic Non-Profit Corporation,DomProfBus-Domestic Profit Corporation, PshipsBus-Partnerships Business(Domestic and Foreign),
		 ForLLCBus-Foreign Limited Liability Company, ForNPCBus-Foreign Non-Profit Corporation, 
		 ForProfBus-Foreign Profit Corporation & TrdNamesBus-TradeNames */
		EXPORT Business   := DomLLCBus.logical + DomMbebus.logical + DomNpcbus.logical + DomProfbus.logical  +
												 ForLLCBus.logical + ForNpcbus.logical + ForProfbus.logical + TrdNamesBus.logical +
												 PShipsBus.logical; 
		
   	/*All Principal files!
			DomLLCPrn-Domestic Limited Liability Company, DomMBEPrn-Domestic Mutual Benefit Enterprise, 
			DomNPCPrn-Domestic Non-Profit Corporation,DomProfPrn-Domestic Profit Corporation, PshipsPrn-Partnerships Prniness(Domestic and Foreign),
			ForLLCPrn-Foreign Limited Liability Company, ForNPCPrn-Foreign Non-Profit Corporation, 
			ForProfPrn-Foreign Profit Corporation & TrdNamesPrn-TradeNames */
    EXPORT Principals := project(DomLLCPrn.logical + DomMbeprn.logical + DomNpcprn.logical + DomProfprn.logical  +      
																 ForLLCPrn.logical + ForNpcprn.logical + ForProfprn.logical+ PShipsPrn.logical ,
																 Transform(Corp2_Raw_VT.Layouts.Temp_Prn_ContType,self:=left;self:=[];)
															   )	+ 
													project(TrdNamesPrn.logical,
																  Transform(Corp2_Raw_VT.Layouts.Temp_Prn_ContType,self.cont_type:='M';self:=left;)
																  );
   	//Trade Owners
   	EXPORT Owners 		:= TrdNamesOwn.logical; 		 
	 
	END;

	//////////////////////////////////////////////////////////////////
	// -- Base File Versions
	/////////////////////////////////////////////////////////////////
	EXPORT Base := MODULE

		tools.mac_FilesBase(Corp2_Raw_VT.Filenames(pversion, pUseOtherEnvironment).Base.DomLLCBus, 		Corp2_Raw_VT.Layouts.BusLayoutBase, 	 	 DomLLCBus);
		tools.mac_FilesBase(Corp2_Raw_VT.Filenames(pversion, pUseOtherEnvironment).Base.DomMBEBus, 		Corp2_Raw_VT.Layouts.BusLayoutBase, 	 	 DomMBEBus);
		tools.mac_FilesBase(Corp2_Raw_VT.Filenames(pversion, pUseOtherEnvironment).Base.DomNPCBus, 		Corp2_Raw_VT.Layouts.BusLayoutBase, 	 	 DomNPCBus);
		tools.mac_FilesBase(Corp2_Raw_VT.Filenames(pversion, pUseOtherEnvironment).Base.DomProfBus, 	Corp2_Raw_VT.Layouts.BusLayoutBase, 	 	 DomProfBus);
		tools.mac_FilesBase(Corp2_Raw_VT.Filenames(pversion, pUseOtherEnvironment).Base.ForLLCBus, 		Corp2_Raw_VT.Layouts.BusLayoutBase, 		 ForLLCBus);
		tools.mac_FilesBase(Corp2_Raw_VT.Filenames(pversion, pUseOtherEnvironment).Base.ForNPCBus, 		Corp2_Raw_VT.Layouts.BusLayoutBase, 	 	 ForNPCBus);
		tools.mac_FilesBase(Corp2_Raw_VT.Filenames(pversion, pUseOtherEnvironment).Base.ForProfBus, 	Corp2_Raw_VT.Layouts.BusLayoutBase, 	 	 ForProfBus);
		tools.mac_FilesBase(Corp2_Raw_VT.Filenames(pversion, pUseOtherEnvironment).Base.PshipsBus,    Corp2_Raw_VT.Layouts.BusLayoutBase, 	   PshipsBus);
		tools.mac_FilesBase(Corp2_Raw_VT.Filenames(pversion, pUseOtherEnvironment).Base.TrdNamesBus, 	Corp2_Raw_VT.Layouts.BusLayoutBase,  	   TrdNamesBus);
		
		tools.mac_FilesBase(Corp2_Raw_VT.Filenames(pversion, pUseOtherEnvironment).Base.DomLLCPrn, 		Corp2_Raw_VT.Layouts.PrnLayoutBase,  	 	 DomLLCPrn);
		tools.mac_FilesBase(Corp2_Raw_VT.Filenames(pversion, pUseOtherEnvironment).Base.DomMBEPrn, 		Corp2_Raw_VT.Layouts.PrnLayoutBase, 	 	 DomMBEPrn);
		tools.mac_FilesBase(Corp2_Raw_VT.Filenames(pversion, pUseOtherEnvironment).Base.DomNPCPrn, 		Corp2_Raw_VT.Layouts.PrnLayoutBase, 		 DomNPCPrn);
		tools.mac_FilesBase(Corp2_Raw_VT.Filenames(pversion, pUseOtherEnvironment).Base.DomProfPrn, 	Corp2_Raw_VT.Layouts.PrnLayoutBase, 	 	 DomProfPrn);
		tools.mac_FilesBase(Corp2_Raw_VT.Filenames(pversion, pUseOtherEnvironment).Base.ForLLCPrn, 		Corp2_Raw_VT.Layouts.PrnLayoutBase, 		 ForLLCPrn);
		tools.mac_FilesBase(Corp2_Raw_VT.Filenames(pversion, pUseOtherEnvironment).Base.ForNPCPrn, 		Corp2_Raw_VT.Layouts.PrnLayoutBase, 	 	 ForNPCPrn);
		tools.mac_FilesBase(Corp2_Raw_VT.Filenames(pversion, pUseOtherEnvironment).Base.ForProfPrn, 	Corp2_Raw_VT.Layouts.PrnLayoutBase, 	 	 ForProfPrn);
		tools.mac_FilesBase(Corp2_Raw_VT.Filenames(pversion, pUseOtherEnvironment).Base.PshipsPrn,    Corp2_Raw_VT.Layouts.PrnLayoutBase, 	   PshipsPrn);
		tools.mac_FilesBase(Corp2_Raw_VT.Filenames(pversion, pUseOtherEnvironment).Base.TrdNamesPrn, 	Corp2_Raw_VT.Layouts.PrnLayoutBase,  	   TrdNamesPrn);
		
		tools.mac_FilesBase(Corp2_Raw_VT.Filenames(pversion, pUseOtherEnvironment).Base.TrdNamesOwn, 	Corp2_Raw_VT.Layouts.TrdNamesOwnLayoutBase,  	 TrdNamesOwn);

	END;

END;