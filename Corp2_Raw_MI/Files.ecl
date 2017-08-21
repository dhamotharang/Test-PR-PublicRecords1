import corp2_mapping, corp2_raw_mi, tools, ut;

EXPORT Files(STRING  pversion = '',
             BOOLEAN pUseOtherEnvironment = FALSE) := MODULE

	//////////////////////////////////////////////////////////////////
	// -- Input File Versions
	//////////////////////////////////////////////////////////////////
	EXPORT Input := MODULE

		tools.mac_FilesInput(Corp2_Raw_MI.Filenames(pversion, pUseOtherEnvironment).Input.Master, Corp2_Raw_MI.Layouts.MasterStringLayoutIn, Master,
												'CSV', ,pQuote := '"', pTerminator := ['\n','\r\n','\n\r'], pSeparator := '', pHeading := 0);
			
 		EXPORT CorpMaster1AFile   		:= Corp2_Raw_MI.FileCorpMaster1AFile(Master.Logical);
 		EXPORT CorpMaster1BFile    		:= Corp2_Raw_MI.FileCorpMaster1BFile(Master.Logical);
		//The DeleteFile is not being used in the current mapper.  See "_ReadMe" file for more information.		
 		EXPORT DeleteFile			    		:= Corp2_Raw_MI.FileDeleteFile(Master.Logical);
 		EXPORT LP2AFile      					:= Corp2_Raw_MI.FileLP2AFile(Master.Logical);
 		EXPORT LP2BFile  							:= Corp2_Raw_MI.FileLP2BFile(Master.Logical);
 		EXPORT NameRegistrationFile		:= Corp2_Raw_MI.FileNameRegistrationFile(Master.Logical);
 		EXPORT LLC3AFile    					:= Corp2_Raw_MI.FileLLC3AFile(Master.Logical);
 		EXPORT LLC3BFile  						:= Corp2_Raw_MI.FileLLC3BFile(Master.Logical);
 		EXPORT MailingFile 						:= Corp2_Raw_MI.FileMailingFile(Master.Logical);
		//The PendingFile is not being used in the current mapper.  See "_ReadMe" file for more information.
		EXPORT PendingFile   					:= Corp2_Raw_MI.FilePendingFile(Master.Logical);
 		EXPORT HistoryFile   					:= Corp2_Raw_MI.FileHistoryFile(Master.Logical);
		EXPORT AssumedNameFile				:= Corp2_Raw_MI.FileAssumedNameFile(Master.Logical);
 		EXPORT GeneralPartnerFile			:= Corp2_Raw_MI.FileGeneralPartnerFile(Master.Logical);
	END;

	//////////////////////////////////////////////////////////////////
	// -- Base File Versions
	/////////////////////////////////////////////////////////////////
	EXPORT Base := MODULE
		tools.mac_FilesBase(Corp2_Raw_MI.Filenames(pversion, pUseOtherEnvironment).Base.Master, Corp2_Raw_MI.Layouts.MasterStringLayoutBase, Master);
		tools.mac_FilesBase(Corp2_Raw_MI.Filenames(pversion, pUseOtherEnvironment).Base.CorpMaster1AFile, Corp2_Raw_MI.Layouts.CorpMaster1ALayoutBase, CorpMaster1AFile);
		tools.mac_FilesBase(Corp2_Raw_MI.Filenames(pversion, pUseOtherEnvironment).Base.CorpMaster1BFile, Corp2_Raw_MI.Layouts.CorpMaster1BLayoutBase, CorpMaster1BFile);
		tools.mac_FilesBase(Corp2_Raw_MI.Filenames(pversion, pUseOtherEnvironment).Base.DeleteFile, Corp2_Raw_MI.Layouts.DeleteLayoutBase, DeleteFile);
		tools.mac_FilesBase(Corp2_Raw_MI.Filenames(pversion, pUseOtherEnvironment).Base.LP2AFile, Corp2_Raw_MI.Layouts.LP2ALayoutBase, LP2AFile);
		tools.mac_FilesBase(Corp2_Raw_MI.Filenames(pversion, pUseOtherEnvironment).Base.LP2BFile, Corp2_Raw_MI.Layouts.LP2BLayoutBase, LP2BFile);
		tools.mac_FilesBase(Corp2_Raw_MI.Filenames(pversion, pUseOtherEnvironment).Base.NameRegistrationFile, Corp2_Raw_MI.Layouts.NameRegistrationLayoutBase, NameRegistrationFile);
		tools.mac_FilesBase(Corp2_Raw_MI.Filenames(pversion, pUseOtherEnvironment).Base.LLC3AFile, Corp2_Raw_MI.Layouts.LLC3ALayoutBase, LLC3AFile);
		tools.mac_FilesBase(Corp2_Raw_MI.Filenames(pversion, pUseOtherEnvironment).Base.LLC3BFile, Corp2_Raw_MI.Layouts.LLC3BLayoutBase, LLC3BFile);
		tools.mac_FilesBase(Corp2_Raw_MI.Filenames(pversion, pUseOtherEnvironment).Base.MailingFile, Corp2_Raw_MI.Layouts.MailingLayoutBase, MailingFile);
		tools.mac_FilesBase(Corp2_Raw_MI.Filenames(pversion, pUseOtherEnvironment).Base.PendingFile, Corp2_Raw_MI.Layouts.PendingLayoutBase, PendingFile);
		tools.mac_FilesBase(Corp2_Raw_MI.Filenames(pversion, pUseOtherEnvironment).Base.HistoryFile, Corp2_Raw_MI.Layouts.HistoryLayoutBase, HistoryFile);
		tools.mac_FilesBase(Corp2_Raw_MI.Filenames(pversion, pUseOtherEnvironment).Base.AssumedNameFile, Corp2_Raw_MI.Layouts.AssumedNameLayoutBase, AssumedNameFile);
		tools.mac_FilesBase(Corp2_Raw_MI.Filenames(pversion, pUseOtherEnvironment).Base.GeneralPartnerFile, Corp2_Raw_MI.Layouts.GeneralPartnerLayoutBase, GeneralPartnerFile);
	END;

END;