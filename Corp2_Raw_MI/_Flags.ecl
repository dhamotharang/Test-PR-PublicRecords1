IMPORT _Control, tools;

EXPORT _Flags := MODULE
	EXPORT Base := MODULE
		EXPORT Master								:= COUNT(NOTHOR(FileServices.SuperFileContents(Corp2_Raw_MI.Filenames().Base.Master.QA))) > 0;
		EXPORT CorpMaster1AFile			:= COUNT(NOTHOR(FileServices.SuperFileContents(Corp2_Raw_MI.Filenames().Base.CorpMaster1AFile.QA))) > 0;
		EXPORT CorpMaster1BFile			:= COUNT(NOTHOR(FileServices.SuperFileContents(Corp2_Raw_MI.Filenames().Base.CorpMaster1BFile.QA))) > 0;
		EXPORT DeleteFile						:= COUNT(NOTHOR(FileServices.SuperFileContents(Corp2_Raw_MI.Filenames().Base.DeleteFile.QA))) > 0;
		EXPORT LP2AFile							:= COUNT(NOTHOR(FileServices.SuperFileContents(Corp2_Raw_MI.Filenames().Base.LP2AFile.QA))) > 0;
		EXPORT LP2BFile							:= COUNT(NOTHOR(FileServices.SuperFileContents(Corp2_Raw_MI.Filenames().Base.LP2BFile.QA))) > 0;
		EXPORT NameRegistrationFile	:= COUNT(NOTHOR(FileServices.SuperFileContents(Corp2_Raw_MI.Filenames().Base.NameRegistrationFile.QA))) > 0;
		EXPORT LLC3AFile						:= COUNT(NOTHOR(FileServices.SuperFileContents(Corp2_Raw_MI.Filenames().Base.LLC3AFile.QA))) > 0;
		EXPORT LLC3BFile						:= COUNT(NOTHOR(FileServices.SuperFileContents(Corp2_Raw_MI.Filenames().Base.LLC3BFile.QA))) > 0;
		EXPORT MailingFile					:= COUNT(NOTHOR(FileServices.SuperFileContents(Corp2_Raw_MI.Filenames().Base.MailingFile.QA))) > 0;
		EXPORT PendingFile					:= COUNT(NOTHOR(FileServices.SuperFileContents(Corp2_Raw_MI.Filenames().Base.PendingFile.QA))) > 0;
		EXPORT HistoryFile					:= COUNT(NOTHOR(FileServices.SuperFileContents(Corp2_Raw_MI.Filenames().Base.HistoryFile.QA))) > 0;
		EXPORT AssumedNameFile			:= COUNT(NOTHOR(FileServices.SuperFileContents(Corp2_Raw_MI.Filenames().Base.AssumedNameFile.QA))) > 0;
		EXPORT GeneralPartnerFile		:= COUNT(NOTHOR(FileServices.SuperFileContents(Corp2_Raw_MI.Filenames().Base.GeneralPartnerFile.QA))) > 0;
	END;
END;