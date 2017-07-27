import SiteSec_ISMS;

EXPORT Layouts := MODULE
	EXPORT rawrec := RECORD
		SiteSec_ISMS.layouts.base -ISMSScope;
		unsigned2 penalt := 0;
	END;
END;