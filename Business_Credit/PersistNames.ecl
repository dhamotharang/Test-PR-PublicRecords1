IMPORT ut;
EXPORT PersistNames := 
MODULE

	SHARED persistroot				:=	_Dataset().PersistTemplate;

	EXPORT fnProcessSBFEFile	:=	persistroot + 'fnProcessSBFEFile';
	EXPORT tradelines					:=	persistroot + 'tradelines';
	EXPORT cleannames					:=	persistroot + 'cleannames';
	EXPORT cleanaddresses			:=	persistroot + 'cleanaddresses';
	EXPORT AsBusHeader				:=	persistroot + 'As_Business_Header';
	EXPORT AsBusLinking				:=	persistroot + 'As_Business_Linking';
	EXPORT fnStatsReport	:=	persistroot + 'fnStatsReport';

	EXPORT dAll_persistnames := 
	DATASET([
		 (fnProcessSBFEFile)
		 ,(tradelines)
		 ,(cleannames)
		 ,(cleanaddresses)
		 ,(AsBusHeader)
		 ,(AsBusLinking)
		 ,(fnStatsReport)
	], ut.Layout_Names);

END;