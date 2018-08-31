IMPORT ADDRESS_CLEAN, AID, UT;

dRaw	:=	AID.Files.RawCacheProd;
dStd	:=	AID.Files.StdCacheProd;
dACE	:=	AID.Files.ACECacheProd;

dACEDist		:=	DISTRIBUTE(dACE, HASH32(AID));
dStdDistACE	:=	DISTRIBUTE(dStd, HASH32(CleanAID));

layouts.rStdACE tStdACE(dStdDistACE pStd, dACEDist pACE) := TRANSFORM
	SELF.Temp_StdAID				:=	pStd.AID;
	SELF.rACECache.err_stat	:=	pStd.ReturnCode;
	SELF.rACECache					:=	pACE;
END;

dStdACE	:=	JOIN(dStdDistACE, dACEDist,
								 LEFT.CleanAID = RIGHT.AID,
								 tStdACE(LEFT,RIGHT),LOCAL);

dStdACEDist	:=	DISTRIBUTE(dStdACE,HASH32(Temp_StdAID));
dRawDistStd	:=	DISTRIBUTE(dRaw,HASH32(StdAID));

layouts.rFinalFile tRawStdACE(dRawDistStd pRaw, dStdACEDist pStdACE) := TRANSFORM
	SELF				:=	pRaw;
	SELF				:=	pStdACE.rACECache;
END;

dRawStdACE	:=	JOIN(dRawDistStd, dStdACEDist,
										 LEFT.StdAID = RIGHT.Temp_StdAID,
										 tRawStdACE(LEFT,RIGHT),LOCAL);

dJoinedDist			:=	DISTRIBUTE(dRawStdACE(ERR_STAT[1] = 'S'),HASH32(Line1,LineLast));
dJoinedSort			:=	SORT(dJoinedDist,Line1,LineLast,geo_match,LOCAL);
dJoinedDedup		:=	DEDUP(dJoinedSort,Line1,LineLast,LOCAL);

EXPORT file_RawACE := dJoinedDedup;