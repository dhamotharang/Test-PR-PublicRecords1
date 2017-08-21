IMPORT	Score_Logs,	ut;

EXPORT	SAO	:=	MODULE

	SHARED	lSubDirName					:=	'';
	SHARED	lCSVVersion					:=	ut.GetDate;
	SHARED	lCSVFileNamePrefix	:=	PRTE_CSV.Constants.CSVFilesBaseName + lSubDirName;
	
	EXPORT rthor_data400__key__scorelogs__xmlintermediatept1	:= RECORD
		RECORDOF(Score_Logs.Key_ScoreLogs_XMLIntermediatePt1);
	END;

	EXPORT rthor_data400__key__scorelogs__xmlintermediatept2	:= RECORD
		RECORDOF(Score_Logs.Key_ScoreLogs_XMLIntermediatePt2);
	END;

	EXPORT rthor_data400__key__scorelogs__xmlintermediatept3	:= RECORD
		RECORDOF(Score_Logs.Key_ScoreLogs_XMLIntermediatePt3);
	END;

	EXPORT rthor_data400__key__scorelogs__xmlintermediatept4	:= RECORD
		RECORDOF(Score_Logs.Key_ScoreLogs_XMLIntermediatePt4);
	END;

	EXPORT rthor_data400__key__scorelogs__xmlintermediatept5	:= RECORD
		RECORDOF(Score_Logs.Key_ScoreLogs_XMLIntermediatePt5);
	END;

	EXPORT rthor_data400__key__scorelogs__xmlintermediatept6	:= RECORD
		RECORDOF(Score_Logs.Key_ScoreLogs_XMLIntermediatePt6);
	END;

	EXPORT rthor_data400__key__scorelogs__xmlintermediatept7	:= RECORD
		RECORDOF(Score_Logs.Key_ScoreLogs_XMLIntermediatePt7);
	END;

	EXPORT rthor_data400__key__scorelogs__xmlintermediatept8	:= RECORD
		RECORDOF(Score_Logs.Key_ScoreLogs_XMLIntermediatePt8);
	END;

	EXPORT rthor_data400__key__scorelogs__xmlintermediatept9	:= RECORD
		RECORDOF(Score_Logs.Key_ScoreLogs_XMLIntermediatePt9);
	END;

	EXPORT rthor_data400__key__scoreLogs__xmltransactionid	:= RECORD
		RECORDOF(Score_Logs.Key_ScoreLogs_XMLTransactionID);
	END;

	EXPORT	dthor_data400__key__scorelogs__xmlintermediatept1	:=	DATASET([], rthor_data400__key__scorelogs__xmlintermediatept1);
	EXPORT	dthor_data400__key__scorelogs__xmlintermediatept2	:=	DATASET([], rthor_data400__key__scorelogs__xmlintermediatept2);
	EXPORT	dthor_data400__key__scorelogs__xmlintermediatept3	:=	DATASET([], rthor_data400__key__scorelogs__xmlintermediatept3);
	EXPORT	dthor_data400__key__scorelogs__xmlintermediatept4	:=	DATASET([], rthor_data400__key__scorelogs__xmlintermediatept4);
	EXPORT	dthor_data400__key__scorelogs__xmlintermediatept5	:=	DATASET([], rthor_data400__key__scorelogs__xmlintermediatept5);
	EXPORT	dthor_data400__key__scorelogs__xmlintermediatept6	:=	DATASET([], rthor_data400__key__scorelogs__xmlintermediatept6);
	EXPORT	dthor_data400__key__scorelogs__xmlintermediatept7	:=	DATASET([], rthor_data400__key__scorelogs__xmlintermediatept7);
	EXPORT	dthor_data400__key__scorelogs__xmlintermediatept8	:=	DATASET([], rthor_data400__key__scorelogs__xmlintermediatept8);
	EXPORT	dthor_data400__key__scorelogs__xmlintermediatept9	:=	DATASET([], rthor_data400__key__scorelogs__xmlintermediatept9);
	EXPORT	dthor_data400__key__scoreLogs__xmltransactionid		:=	DATASET([], rthor_data400__key__scoreLogs__xmltransactionid);

END;
