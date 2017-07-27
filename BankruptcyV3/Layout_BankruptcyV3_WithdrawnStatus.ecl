IMPORT	BankruptcyV3;
EXPORT	Layout_BankruptcyV3_WithdrawnStatus	:=	MODULE

	EXPORT	wsLogical	:=	RECORD
		INTEGER		LogID;
		STRING22	LogDate;
		STRING12	CaseID;
		STRING12	DefendantID;
		STRING3		CurrentChapter;
		STRING3		PreviousChapter;
		STRING10	ConversionID;
		STRING22	ConvertDate;
		STRING50	CurrentDisposition;
		STRING2		DCODE;
		STRING22	CurrentDispositionDate;
		STRING12	INTSEED;
		STRING70	PID;
		STRING50	TMSID;
		STRING10	VacateID;
		STRING22	VacateDate;
		STRING50	VacatedDisposition;
		STRING22	VacatedDispositionDate;
		STRING10	WithdrawnID;
		STRING22	WithdrawnDate;
		STRING35	WithdrawnDisposition;
		STRING22	WithdrawnDispositionDate;
		STRING5		FiledInError;
		STRING22	ReopenDate;
		STRING22	LastUpdatedDate;
	END;
	
	EXPORT	wsVirtual	:=	RECORD
		wsLogical;
		STRING	__filename	{ VIRTUAL(logicalfilename)};
	END;
	
	EXPORT	wsBase	:=	RECORD
		INTEGER		LogID;
		STRING22	LogDate;
		STRING12	CaseID;
		STRING12	DefendantID;
		STRING3		CurrentChapter;
		STRING3		PreviousChapter;
		STRING10	ConversionID;
		STRING22	ConvertDate;
		STRING50	CurrentDisposition;
		STRING2		DCODE;
		STRING22	CurrentDispositionDate;
		STRING12	INTSEED;
		STRING70	PID;
		STRING50	TMSID;
		STRING10	VacateID;
		STRING22	VacateDate;
		STRING50	VacatedDisposition;
		STRING22	VacatedDispositionDate;
		STRING10	WithdrawnID;
		STRING22	OriginalWithdrawnDate;
		STRING8		WithdrawnDate;
		STRING35	WithdrawnDisposition;
		STRING8		WithdrawnDispositionDate;
		STRING22	OriginalWithdrawnDispositionDate;
		STRING5		FiledInError;
		STRING22	ReopenDate;
		STRING22	LastUpdatedDate;
		BOOLEAN		isCurrent		:=	TRUE;
		STRING		__filename	:=	'';
	END;
	
	EXPORT	wsKey	:=	RECORD
		STRING50	TMSID;
		STRING12	CaseID;
		STRING12	DefendantID;
		STRING10	WithdrawnID;
		STRING22	OriginalWithdrawnDate;
		STRING8		WithdrawnDate;
		STRING35	WithdrawnDisposition;
		STRING8		WithdrawnDispositionDate;
		STRING22	OriginalWithdrawnDispositionDate;
		UNSIGNED6	did	:=	0;
		BOOLEAN		isCurrent;
	END;
END;