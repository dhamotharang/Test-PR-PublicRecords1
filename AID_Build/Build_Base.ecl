import aid,ut;

dRaw	:=	AID.Files.RawCacheProd;
dStd	:=	AID.Files.StdCacheProd;
dACE	:=	AID.Files.ACECacheProd;

dACEDist		:=	DISTRIBUTE(dACE, HASH32(AID));
dStdDistACE	:=	DISTRIBUTE(dStd, HASH32(CleanAID));

layouts.rStdACE tStdACE(dStdDistACE pStd, dACEDist pACE) :=
TRANSFORM
	SELF.Temp_StdAID				:=	pStd.AID;
	SELF.rACECache.err_stat	:=	pStd.ReturnCode;
	SELF.rACECache					:=	pACE;
END;

dStdACE	:=	JOIN(dStdDistACE, dACEDist,
								 LEFT.CleanAID = RIGHT.AID,
								 tStdACE(LEFT,RIGHT),
								 LOCAL
								);

dStdACEDist	:=	DISTRIBUTE(dStdACE,HASH32(Temp_StdAID));
dRawDistStd	:=	DISTRIBUTE(dRaw,HASH32(StdAID));

layouts.rRawStdACE tRawStdACE(dRawDistStd pRaw, dStdACEDist pStdACE) :=
TRANSFORM
	SELF.RawAID	:=	pRaw.AID;
	SELF				:=	pStdACE;
END;

dRawStdACE	:=	JOIN(dRawDistStd, dStdACEDist,
										 LEFT.StdAID = RIGHT.Temp_StdAID,
										 tRawStdACE(LEFT,RIGHT),
										 LOCAL
										);

dJoinedDist			:=	DISTRIBUTE(dRawStdACE,HASH32(RawAID));
dJoinedSort			:=	SORT(dJoinedDist,RawAID,rACECache.geo_match,-rACECache.err_stat[1],LOCAL);
dJoinedDedup		:=	DEDUP(dJoinedSort,RawAID,LOCAL);

layouts.rFinal	tFinal(dJoinedDedup pInput) :=
TRANSFORM
	SELF.RawAID	:=	pInput.RawAID;
	SELF.ACEAID	:=	pInput.rACECache.AID;
	SELF				:=	pInput.rACECache;
END;
dFinal	:=	PROJECT(dJoinedDedup,tFinal(LEFT));

export Build_Base := dFinal;