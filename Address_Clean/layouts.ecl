IMPORT ADDRESS, ADDRESS_CLEAN, AID;

EXPORT layouts := MODULE

	EXPORT dRaw	:=	AID.Files.RawCacheProd;
	EXPORT dStd	:=	AID.Files.StdCacheProd;
	EXPORT dACE	:=	AID.Files.ACECacheProd;

	EXPORT rStdACE := RECORD
		TYPEOF(dStd.AID)	Temp_StdAID;
		RECORDOF(dACE)		rACECache;
	END;

	EXPORT rRawStdACE := RECORD
		TYPEOF(dRaw.AID)		RawAID;
		RECORDOF(rStdACE);
	END;

	EXPORT rFinalFile := RECORD
		AID.Layouts.rRawStruct AND NOT [Line2, Line3];
		AID.Layouts.rACEStruct;
	END;
	
	EXPORT rFinalMac := RECORD
		Address.Layout_Clean182;
		QSTRING45 addx1;
		QSTRING45	addx2;
		BOOLEAN cache_hit := FALSE;
		BOOLEAN cleaner_hit := FALSE;
	END;

END;