//	Needed in file_liens_fcra_main
IMPORT	LiensV2_SrcInfoRpt, LiensV2;
EXPORT	fn_SuppressedFCRALiensMain	:=	FUNCTION

	dSuppressedJurisdictions	:=	LiensV2_SrcInfoRpt.Files().SuppressedJurisdictions;
	dFCRAMain									:=	LiensV2.file_liens_main(
																	tmsid[..2]	IN	['HG']
																);

	rFCRAMainWithCourtID	:=	RECORD
		dFCRAMain,
		STRING7	CourtID;
		STRING2	FILETYPEID;
	END;

	dFCRAMainWithCourtID	:=	PROJECT(dFCRAMain,
															TRANSFORM(
																rFCRAMainWithCourtID,
																SELF.CourtID		:=	LEFT.tmsid[LENGTH(TRIM(LEFT.tmsid,LEFT,RIGHT))-6..];
																SELF.FILETYPEID	:=	LEFT.rmsid[LENGTH(TRIM(LEFT.rmsid,LEFT,RIGHT))-1..];
																SELF						:=	LEFT;
															)
														);

	dSuppressedFCRALiensMain	:=	JOIN(
																DISTRIBUTE(dFCRAMainWithCourtID,HASH(CourtID,FILETYPEID)),
																DISTRIBUTE(dSuppressedJurisdictions,HASH(LNCourtID,FILETYPEID)),
																	LEFT.CourtID		=	RIGHT.LNCourtID	AND
																	LEFT.FILETYPEID	=	RIGHT.FILETYPEID,
																TRANSFORM(LEFT),
																LOCAL
															);

	RETURN dSuppressedFCRALiensMain;
	
END;
