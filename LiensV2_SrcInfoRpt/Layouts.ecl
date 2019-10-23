//	Needed in file_liens_fcra_main
IMPORT	LiensV2;
EXPORT	Layouts	:=	MODULE

	EXPORT	rActionGroups	:=	RECORD
		STRING2	FILETYPEID;
		STRING	filing_type_desc;
		STRING	ActionType;
	END;
	
	EXPORT	rSourceInformationReport	:=	RECORD
		STRING2		StateOfService;
		STRING		AreaOfService;
		STRING7		LNCourtID;
		STRING7		CustCourt;
		STRING		CourtName;
		STRING		Address1;
		STRING		Address2;
		STRING		Address3;
		STRING10	Phone;
		STRING		SourceAccessStatus;
		STRING		ActionGroup;
		STRING9		MatchKey;
		STRING		CollectionCoverage;
		STRING		VisitInterval;
		STRING		CourtLatency;
		STRING		DispositionScore;
		STRING		SevenYrVolume;
		STRING		MaxCollectDate;
		STRING		VisitWithin90;
		BOOLEAN		IsActive;
	END;
	
	EXPORT	rSuppressedJurisdictions	:=	RECORD
		STRING2		StateOfService;
		STRING		AreaOfService;
		STRING7		LNCourtID;
		STRING7		CustCourt;
		STRING		CourtName;
		STRING		Address1;
		STRING		Address2;
		STRING		Address3;
		STRING10	Phone;
		STRING		SourceAccessStatus;
		STRING		ActionGroup;
		STRING9		MatchKey;
		STRING		CollectionCoverage;
		STRING		VisitInterval;
		STRING		CourtLatency;
		STRING		DispositionScore;
		STRING		SevenYrVolume;
		STRING		MaxCollectDate;
		STRING		VisitWithin90;
		BOOLEAN		IsActive;
		STRING2		FileTypeID;
	END;

END;