IMPORT SiteSec_ISMS;

EXPORT Layouts := MODULE

	SHARED max_size := _Dataset().max_record_size;

	EXPORT Input := RECORD,MAXLENGTH(40000)
			STRING    DartID;
			UNSIGNED8 DateAdded;
			UNSIGNED8 DateUpdated;
			STRING    Website;
			STRING    State;
			STRING    BusinessName;
			STRING    BusinessLocation;
			STRING    BusinessDBA;
			STRING    Country;
			STRING    CertificateNumber;
			STRING    CertificationBody;
			STRING    CertificationType;
			STRING    ISMSScope;
	END;

	EXPORT Base := RECORD,MAXLENGTH(40000)
			UNSIGNED8 Date_FirstSeen;
			UNSIGNED8 Date_LastSeen;
			STRING70	CertificationBodyDescrip;
			STRING6   DartID;
			UNSIGNED8 DateAdded;
			UNSIGNED8 DateUpdated;
			STRING40  Website;
			STRING4   State;
			STRING250 BusinessName;
			STRING250 BusinessLocation;
			STRING150 BusinessDBA;
			STRING40  Country;
			STRING70  CertificateNumber;
			STRING70  CertificationBody;
			STRING20  CertificationType;
			STRING8300 ISMSScope;
	END;
		
END;