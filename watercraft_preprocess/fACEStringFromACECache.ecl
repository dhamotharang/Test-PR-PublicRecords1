import AID ; 
export STRING182	fACEStringFromACECache(AID.Layouts.rACECache pACECache)	:=
FUNCTION
	rACEStruct	:=
	RECORD
		AID.Layouts.rACEStruct;
	END;
	rACEStruct	tACECacheToACEStruct(AID.Layouts.rACECache pInput)	:=
	TRANSFORM
		SELF	:=	pInput;
	END;
	RETURN	TRANSFER(row(tACECacheToACEStruct(pACECache)), STRING182);
END;
