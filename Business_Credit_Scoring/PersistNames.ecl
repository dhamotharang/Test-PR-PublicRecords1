IMPORT ut;
EXPORT PersistNames := 
MODULE

	SHARED persistroot	:=	_Dataset().PersistTemplate;

	EXPORT TradelineDBT		:=	persistroot + 'TradelineDBT';
	EXPORT UniqueLinkIDs	:=	persistroot + 'UniqueLinkIDs';

	EXPORT dAll_persistnames := 
	DATASET([
		 (TradelineDBT),
		 (UniqueLinkIDs)
	], ut.Layout_Names);

END;