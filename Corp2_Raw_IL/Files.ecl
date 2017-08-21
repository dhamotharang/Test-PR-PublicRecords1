IMPORT corp2_mapping, corp2_raw_il, tools, ut;

EXPORT Files(STRING  pversion = '',
             BOOLEAN pUseOtherEnvironment = FALSE) := MODULE

	//////////////////////////////////////////////////////////////////
	// -- Input File Versions
	//////////////////////////////////////////////////////////////////
	EXPORT Input := MODULE

		//////////////////////////////////////////////////////////////////
		// -- DAILY Files
		//    Note: There are three different record types in the DAILY
		//					file and they are as follows: Assumed Names, Master,
		//					& Stock.
		//    Note: A logical record is made up of multiple physical
		//					records.  A record of 80-"$" separates the records.
		//////////////////////////////////////////////////////////////////
		EXPORT Daily := MODULE
			tools.mac_FilesInput(Corp2_Raw_IL.Filenames(pversion, pUseOtherEnvironment).Input.Daily.Master, Corp2_Raw_IL.Layouts.StringLayoutIn, MasterString,
													'CSV', ,pQuote := '"', pTerminator := ['\n','\r\n'], pSeparator := '', pHeading := 0, pMaxLength := 8192,
													 pNoTrim := true);
			EXPORT MasterRaw								:= MasterString.Logical;
			EXPORT MasterFixedString				:= Corp2_Raw_IL.FileDMMasterRawDaily(MasterRaw);
			EXPORT Master										:= Corp2_Raw_IL.FileDMMaster(MasterFixedString(recordtype in ['1','2','3']));
			EXPORT AssumedNames							:= Corp2_Raw_IL.FileDMAssumedOldNames(MasterFixedString(recordtype = '5'));
			EXPORT AssumedNamesFixedString	:= MasterFixedString(recordtype = '5');			
			EXPORT Stock										:= Corp2_Raw_IL.FileDMStock(MasterFixedString(recordtype = '4'));
			EXPORT StockFixedString					:= MasterFixedString(recordtype = '4');			
			
		END;
		
		//////////////////////////////////////////////////////////////////
		// -- MONTHLY Files
		//    Note: Unlike the DAILY file, there are three separate MONTHLY  
		//					files and a logical record is made up of one physical	
		//					record.		
		//////////////////////////////////////////////////////////////////
		EXPORT Monthly := MODULE
			tools.mac_FilesInput(Corp2_Raw_IL.Filenames(pversion, pUseOtherEnvironment).Input.Monthly.AssumedNames, Corp2_Raw_IL.Layouts.StringLayoutIn, AssumedNamesString,
													'CSV', ,pQuote := '"', pTerminator := ['\n','\r\n'], pSeparator := '', pHeading := 0, pMaxLength := 8192);
			tools.mac_FilesInput(Corp2_Raw_IL.Filenames(pversion, pUseOtherEnvironment).Input.Monthly.Master, Corp2_Raw_IL.Layouts.StringLayoutIn, MasterString,
													'CSV', ,pQuote := '"', pTerminator := ['\n','\r\n'], pSeparator := '', pHeading := 0, pMaxLength := 8192);
			tools.mac_FilesInput(Corp2_Raw_IL.Filenames(pversion, pUseOtherEnvironment).Input.Monthly.Stock, Corp2_Raw_IL.Layouts.StringLayoutIn, StockString,
													'CSV', ,pQuote := '"', pTerminator := ['\n','\r\n'], pSeparator := '', pHeading := 0, pMaxLength := 8192);
			EXPORT MasterRaw								:= MasterString.Logical;
			EXPORT MasterFixedString				:= Corp2_Raw_IL.FileDMMasterRawMonthly(MasterRaw);
			EXPORT Master										:= Corp2_Raw_IL.FileDMMaster(MasterFixedString(recordtype = 'M'));
			
			EXPORT AssumedNamesRaw					:= AssumedNamesString.Logical;
			EXPORT AssumedNamesFixedString	:= Corp2_Raw_IL.FileDMMasterRawMonthly(AssumedNamesRaw);		
			EXPORT AssumedNames							:= Corp2_Raw_IL.FileDMAssumedOldNames(AssumedNamesFixedString);
			
			EXPORT StockRaw									:= StockString.Logical;
			EXPORT StockFixedString					:= Corp2_Raw_IL.FileDMMasterRawMonthly(StockRaw);
			EXPORT Stock										:= Corp2_Raw_IL.FileDMStock(StockFixedString);													
		END;

		//////////////////////////////////////////////////////////////////
		// -- LLC File
		//////////////////////////////////////////////////////////////////
		EXPORT LLC := MODULE
			tools.mac_FilesInput(Corp2_Raw_IL.Filenames(pversion, pUseOtherEnvironment).Input.LLC.Master, Corp2_Raw_IL.Layouts.StringLayoutIn, MasterString,
													'CSV', ,pQuote := '"', pTerminator := ['\n','\r\n'], pSeparator := '', pHeading := 0, pMaxLength := 8192);
			EXPORT MasterRaw							:= MasterString.Logical;
			EXPORT Master   							:= Corp2_Raw_IL.FileLLCMaster(MasterRaw);
			EXPORT AssumedNames						:= Corp2_Raw_IL.FileLLCAssumedNames(MasterRaw);
			EXPORT DeletedFromSOS					:= Corp2_Raw_IL.FileLLCDeletedFromSOS(MasterRaw);		//currently not being used	
			EXPORT InitialRecord					:= Corp2_Raw_IL.FileLLCInitialRecord(MasterRaw);		//currently not being used	
			EXPORT ManagerMember					:= Corp2_Raw_IL.FileLLCManagerMember(MasterRaw);
			EXPORT OldNames								:= Corp2_Raw_IL.FileLLCOldNames(MasterRaw);													
		END;
		
		//////////////////////////////////////////////////////////////////
		// -- LP File
		//////////////////////////////////////////////////////////////////		
		EXPORT LP := MODULE
			tools.mac_FilesInput(Corp2_Raw_IL.Filenames(pversion, pUseOtherEnvironment).Input.LP.Master, Corp2_Raw_IL.Layouts.StringLayoutIn,	MasterString,
													'CSV', ,pQuote := '"', pTerminator := ['\n','\r\n'], pSeparator := '', pHeading := 0, pMaxLength := 8192);
			EXPORT MasterRaw							:= MasterString.Logical;
			EXPORT Master  								:= Corp2_Raw_IL.FileLPMaster(MasterRaw);		
			EXPORT AdmittingNames					:= Corp2_Raw_IL.FileLPAdmittingNames(MasterRaw);
			EXPORT AssumedNames						:= Corp2_Raw_IL.FileLPAssumedNames(MasterRaw);

			EXPORT DeletedFromSOS					:= Corp2_Raw_IL.FileLPDeletedFromSOS(MasterRaw);	//currently not being used	
			EXPORT GeneraLPartner					:= Corp2_Raw_IL.FileLPGeneraLPartner(MasterRaw);
			EXPORT InitialRecord					:= Corp2_Raw_IL.FileLPInitialRecord(MasterRaw);		//currently not being used	
			EXPORT OldNames		    				:= Corp2_Raw_IL.FileLPOldNames(MasterRaw);														
		END;	

	END; //end Input

	//////////////////////////////////////////////////////////////////
	// -- Base File Versions
	//////////////////////////////////////////////////////////////////
	EXPORT Base := MODULE
		
		EXPORT Daily := MODULE
			tools.mac_FilesBase(Corp2_Raw_IL.Filenames(pversion, pUseOtherEnvironment).Base.Daily.MasterRaw, Corp2_Raw_IL.Layouts.StringLayoutBase, MasterRaw);
			tools.mac_FilesBase(Corp2_Raw_IL.Filenames(pversion, pUseOtherEnvironment).Base.Daily.AssumedNames, Corp2_Raw_IL.Layouts.AssumedOldNamesLayoutBase, AssumedNames);	
			tools.mac_FilesBase(Corp2_Raw_IL.Filenames(pversion, pUseOtherEnvironment).Base.Daily.Master, Corp2_Raw_IL.Layouts.MasterLayoutBase, Master);
			tools.mac_FilesBase(Corp2_Raw_IL.Filenames(pversion, pUseOtherEnvironment).Base.Daily.Stock, 	Corp2_Raw_IL.Layouts.StockLayoutBase, Stock);	
		END;
		
		EXPORT Monthly := MODULE
			tools.mac_FilesBase(Corp2_Raw_IL.Filenames(pversion, pUseOtherEnvironment).Base.Monthly.AssumedNames, Corp2_Raw_IL.Layouts.StringLayoutBase, AssumedNames);	
			tools.mac_FilesBase(Corp2_Raw_IL.Filenames(pversion, pUseOtherEnvironment).Base.Monthly.Master, Corp2_Raw_IL.Layouts.StringLayoutBase, Master);
			tools.mac_FilesBase(Corp2_Raw_IL.Filenames(pversion, pUseOtherEnvironment).Base.Monthly.Stock, Corp2_Raw_IL.Layouts.StringLayoutBase, Stock);		
		END;	
		
		EXPORT LLC := MODULE
			tools.mac_FilesBase(Corp2_Raw_IL.Filenames(pversion, pUseOtherEnvironment).Base.LLC.Master, Corp2_Raw_IL.Layouts.StringLayoutBase, Master);		
		END;	
		
		EXPORT LP := MODULE
			tools.mac_FilesBase(Corp2_Raw_IL.Filenames(pversion, pUseOtherEnvironment).Base.LP.Master, Corp2_Raw_IL.Layouts.StringLayoutBase, Master);		
		END;	

	END; //end Base

	//////////////////////////////////////////////////////////////////
	// -- InputBase File Versions
	//    Note: These definitions give access to the "raw base" files
	//					that is a "backup" of the raw input data. These
	//					backup files are being kept for reprocessing purposes
	//          (in case the need arises).	
	//////////////////////////////////////////////////////////////////
	EXPORT InputBase := MODULE

		EXPORT Daily := MODULE
			tools.mac_FilesInput(Corp2_Raw_IL.Filenames(pversion, pUseOtherEnvironment).InputBase.Daily.MasterRaw, Corp2_Raw_IL.Layouts.StringLayoutBase, MasterRaw);
			tools.mac_FilesInput(Corp2_Raw_IL.Filenames(pversion, pUseOtherEnvironment).InputBase.Daily.AssumedNames, Corp2_Raw_IL.Layouts.AssumedOldNamesLayoutBase, AssumedNames);
			tools.mac_FilesInput(Corp2_Raw_IL.Filenames(pversion, pUseOtherEnvironment).InputBase.Daily.Master, Corp2_Raw_IL.Layouts.MasterLayoutBase, Master);
			tools.mac_FilesInput(Corp2_Raw_IL.Filenames(pversion, pUseOtherEnvironment).InputBase.Daily.Stock, Corp2_Raw_IL.Layouts.StockLayoutBase, Stock);
		END;
		
		EXPORT Monthly := MODULE
			tools.mac_FilesInput(Corp2_Raw_IL.Filenames(pversion, pUseOtherEnvironment).InputBase.Monthly.AssumedNames, Corp2_Raw_IL.Layouts.StringLayoutBase, AssumedNames);
			tools.mac_FilesInput(Corp2_Raw_IL.Filenames(pversion, pUseOtherEnvironment).InputBase.Monthly.Master, Corp2_Raw_IL.Layouts.StringLayoutBase, Master);
			tools.mac_FilesInput(Corp2_Raw_IL.Filenames(pversion, pUseOtherEnvironment).InputBase.Monthly.Stock, Corp2_Raw_IL.Layouts.StringLayoutBase, Stock);
		END;	

		EXPORT LLC := MODULE
			tools.mac_FilesInput(Corp2_Raw_IL.Filenames(pversion, pUseOtherEnvironment).InputBase.LLC.Master, Corp2_Raw_IL.Layouts.StringLayoutBase, Master);		
		END;	
		
		EXPORT LP := MODULE
			tools.mac_FilesInput(Corp2_Raw_IL.Filenames(pversion, pUseOtherEnvironment).InputBase.LP.Master, Corp2_Raw_IL.Layouts.StringLayoutBase, Master);		
		END;		
	
	END; //end InputBase
		
END; //end Files