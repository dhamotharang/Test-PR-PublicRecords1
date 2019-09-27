Layout_id :=
RECORD
	unsigned6 id;
END;

export Layout_SearchFile :=
RECORD
	STRING20 tkn;
	STRING1 etype;
	DATASET(Layout_id) ids {MAXCOUNT(1000000)};
END;