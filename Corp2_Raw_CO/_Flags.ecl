IMPORT _Control, tools;
EXPORT _Flags(STRING  pfiledate 					 = '',
						  STRING  ptmfiledate 				 = '',
              BOOLEAN pUseOtherEnvironment = FALSE) := MODULE
	
	EXPORT Input := MODULE
		EXPORT CorpMstr					:= NOTHOR(FileServices.FileExists(Corp2_Raw_CO.Filenames(pfiledate,pUseOtherEnvironment).Input.CorpMstr.Logical));
		EXPORT CorpTrdnm	  		:= NOTHOR(FileServices.FileExists(Corp2_Raw_CO.Filenames(pfiledate,pUseOtherEnvironment).Input.CorpTrdnm.Logical));
		EXPORT CorpHist1  			:= NOTHOR(FileServices.FileExists(Corp2_Raw_CO.Filenames(pfiledate,pUseOtherEnvironment).Input.CorpHist1.Logical));
		EXPORT CorpHist2  			:= NOTHOR(FileServices.FileExists(Corp2_Raw_CO.Filenames(pfiledate,pUseOtherEnvironment).Input.CorpHist2.Logical));
		EXPORT tmChange	  			:= NOTHOR(FileServices.FileExists(Corp2_Raw_CO.Filenames(ptmfiledate,pUseOtherEnvironment).Input.tmChange.Logical));
		EXPORT tmCorrection	  	:= NOTHOR(FileServices.FileExists(Corp2_Raw_CO.Filenames(ptmfiledate,pUseOtherEnvironment).Input.tmCorrection.Logical));
		EXPORT tmExpired	  		:= NOTHOR(FileServices.FileExists(Corp2_Raw_CO.Filenames(ptmfiledate,pUseOtherEnvironment).Input.tmExpired.Logical));
		EXPORT tmRegistration	  := NOTHOR(FileServices.FileExists(Corp2_Raw_CO.Filenames(ptmfiledate,pUseOtherEnvironment).Input.tmRegistration.Logical));
		EXPORT tmRenewal	  		:= NOTHOR(FileServices.FileExists(Corp2_Raw_CO.Filenames(ptmfiledate,pUseOtherEnvironment).Input.tmRenewal.Logical));
		EXPORT tmTransfer	  		:= NOTHOR(FileServices.FileExists(Corp2_Raw_CO.Filenames(ptmfiledate,pUseOtherEnvironment).Input.tmTransfer.Logical));
		EXPORT tmWithdraw				:= NOTHOR(FileServices.FileExists(Corp2_Raw_CO.Filenames(ptmfiledate,pUseOtherEnvironment).Input.tmWithdraw.Logical));
	END;

	EXPORT Base  := MODULE
		EXPORT CorpMstr					:= COUNT(NOTHOR(FileServices.SuperFileContents(Corp2_Raw_CO.Filenames().Base.CorpMstr.QA))) > 0;
		EXPORT CorpTrdnm	  		:= COUNT(NOTHOR(FileServices.SuperFileContents(Corp2_Raw_CO.Filenames().Base.CorpTrdnm.QA))) > 0;
		EXPORT CorpHist	  			:= COUNT(NOTHOR(FileServices.SuperFileContents(Corp2_Raw_CO.Filenames().Base.CorpHist.QA))) > 0;
		EXPORT tmChange	  			:= COUNT(NOTHOR(FileServices.SuperFileContents(Corp2_Raw_CO.Filenames().Base.tmChange.QA))) > 0;
		EXPORT tmCorrection	  	:= COUNT(NOTHOR(FileServices.SuperFileContents(Corp2_Raw_CO.Filenames().Base.tmCorrection.QA))) > 0;
		EXPORT tmExpired	  		:= COUNT(NOTHOR(FileServices.SuperFileContents(Corp2_Raw_CO.Filenames().Base.tmExpired.QA))) > 0;
		EXPORT tmRegistration	  := COUNT(NOTHOR(FileServices.SuperFileContents(Corp2_Raw_CO.Filenames().Base.tmRegistration.QA))) > 0;
		EXPORT tmRenewal	  		:= COUNT(NOTHOR(FileServices.SuperFileContents(Corp2_Raw_CO.Filenames().Base.tmRenewal.QA))) > 0;
		EXPORT tmTransfer	  		:= COUNT(NOTHOR(FileServices.SuperFileContents(Corp2_Raw_CO.Filenames().Base.tmTransfer.QA))) > 0;
		EXPORT tmWithdraw	  		:= COUNT(NOTHOR(FileServices.SuperFileContents(Corp2_Raw_CO.Filenames().Base.tmWithdraw.QA))) > 0;			
		EXPORT tmHistory				:= COUNT(NOTHOR(FileServices.SuperFileContents(Corp2_Raw_CO.Filenames().Base.tmHistory.QA))) > 0;
	END;
END;