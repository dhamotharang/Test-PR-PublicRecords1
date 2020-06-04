EXPORT	Layouts	:=	MODULE

	EXPORT	rCourtlookupIn	:=	RECORD
		STRING		LNCourtCode; 
		STRING    County;
		STRING		RMSCourtCode;
		STRING		CourtName;
		STRING		Address1;
		STRING		Address2;
		STRING		City;
		STRING		State;
		STRING		ZipCode;
		STRING10	Phone;
	END;
	
	EXPORT	rBaseCourtLookup	:=	RECORD
		STRING		LNCourtCode;
		STRING    County;
		STRING		RMSCourtCode;
		STRING		CourtName;
		STRING		Address1;
		STRING		Address2;
		STRING		City;
		STRING		State;
		STRING		ZipCode;
		STRING10	Phone;
		STRING10  Date_first_seen;
		STRING10  Date_last_seen;
		STRING1   Current_rec;
		
	END;

END;