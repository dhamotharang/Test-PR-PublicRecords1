import STD;
EXPORT Key_ReleaseDates(STRING pVersion	=	(STRING8)Std.Date.Today(),
												Constants().buildType	pBuildType	=	Constants().buildType.Daily)	:=	FUNCTION

	dReleaseTable					:=	Business_Credit.Files().releasedate;
	dPreviousReleaseTable	:=	Business_Credit.Files(Filenames().out.ReleaseDate.Father).releasedate;
	dDeltaReleaseTable		:=	JOIN(
															dReleaseTable,
															dPreviousReleaseTable,
															LEFT.version	=	RIGHT.version and
															LEFT.prod_date = RIGHT.prod_date,
															TRANSFORM(LEFT),
															LEFT ONLY);
		// If this is a daily build then only create a key with today's records
	dKeyResult			:=	IF(	pBuildType	= Constants().buildType.Daily,
													dDeltaReleaseTable,
													dReleaseTable);
	release_dates_key	:=	INDEX(dKeyResult,{version},{dKeyResult},keynames(pVersion).ReleaseDate.QA);

	RETURN release_dates_key;
END;
