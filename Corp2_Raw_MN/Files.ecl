import corp2, corp2_mapping, corp2_raw_mn, tools;

EXPORT Files(STRING  pversion = '',
             BOOLEAN pUseOtherEnvironment = FALSE) := MODULE

	//////////////////////////////////////////////////////////////////
	// -- Input File Versions
	//////////////////////////////////////////////////////////////////
	EXPORT Input := MODULE
		//Fullfile 				- using a blank separator in order to pull in all data for Build_Bases attribute
		tools.mac_FilesInput(Corp2_Raw_MN.Filenames(pversion, pUseOtherEnvironment).Input.FullFile, Corp2_Raw_MN.Layouts.FullFileLayoutIn, FullFile,
												'CSV', , pQuote := '"', pTerminator := ['\r\n'], pSeparator := '');
		//MasterFile			- using a comma separator since fullfile is comma delimited
		tools.mac_FilesInput(Corp2_Raw_MN.Filenames(pversion, pUseOtherEnvironment).Input.FullFile, Corp2_Raw_MN.Layouts.MasterLayoutIn, MasterFile,
												'CSV', , pQuote := '"', pTerminator := ['\r\n'], pSeparator := ',');
		//FilingHistFile	- using a comma separator since fullfile is comma delimited
		tools.mac_FilesInput(Corp2_Raw_MN.Filenames(pversion, pUseOtherEnvironment).Input.FullFile, Corp2_Raw_MN.Layouts.FilingHistLayoutIn, FilingHistFile,
		                    'CSV', , pQuote := '"', pTerminator := ['\r\n'], pSeparator := ',');
		//NameAddrFile		- using a comma separator since fullfile is comma delimited
		tools.mac_FilesInput(Corp2_Raw_MN.Filenames(pversion, pUseOtherEnvironment).Input.FullFile, Corp2_Raw_MN.Layouts.NameAddrLayoutIn, NameAddrFile,
		                    'CSV', , pQuote := '"', pTerminator := ['\r\n'], pSeparator := ',');
												
		EXPORT Master 			:= MasterFile.Logical(corp2.t2u(Record_Type)			='01');
		EXPORT FilingHist 	:= FilingHistFile.Logical(corp2.t2u(Record_Type)	='02');
		EXPORT NameAddr 		:= NameAddrFile.Logical(corp2.t2u(Record_Type)		='03');

	END;

	//////////////////////////////////////////////////////////////////
	// -- Base File Versions
	//////////////////////////////////////////////////////////////////
	EXPORT Base := MODULE
			tools.mac_FilesBase(Corp2_Raw_MN.Filenames(pversion, pUseOtherEnvironment).Base.FullFile, Corp2_Raw_MN.Layouts.FullFileLayoutBase, FullFile);
			tools.mac_FilesBase(Corp2_Raw_MN.Filenames(pversion, pUseOtherEnvironment).Base.Master, Corp2_Raw_MN.Layouts.MasterLayoutBase, Master);
			tools.mac_FilesBase(Corp2_Raw_MN.Filenames(pversion, pUseOtherEnvironment).Base.FilingHist, Corp2_Raw_MN.Layouts.FilingHistLayoutBase, FilingHist);
			tools.mac_FilesBase(Corp2_Raw_MN.Filenames(pversion, pUseOtherEnvironment).Base.NameAddr, Corp2_Raw_MN.Layouts.NameAddrLayoutBase, NameAddr);
			
	END;

END;