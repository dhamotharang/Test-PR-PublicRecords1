//	Needed in file_liens_fcra_main
IMPORT	LiensV2_SrcInfoRpt, versioncontrol;
EXPORT	Filenames(STRING	pVersion	=	'',
									BOOLEAN	pUseProd	=	FALSE)	:=	MODULE

	EXPORT	lInputTemplate	:=	LiensV2_SrcInfoRpt._Dataset(pUseProd).thor_cluster_files	+	'in::'		+	_Dataset().name	+	'::@version@::';
	EXPORT	lBaseTemplate		:=	LiensV2_SrcInfoRpt._Dataset(pUseProd).thor_cluster_files	+	'base::'	+	_Dataset().name	+	'::@version@::';
	EXPORT	lOutTemplate			:=	LiensV2_SrcInfoRpt._Dataset(pUseProd).thor_cluster_files	+	'out::'		+	_Dataset().name	+	'::@version@::';

	EXPORT	Input						:=	MODULE
		EXPORT	srcinforpt			:=	versioncontrol.mInputFilenameVersions(lInputTemplate	+	'srcinforpt'	,	pVersion);

		EXPORT	dAll_filenames	:=
			srcinforpt.dAll_filenames
		;
	END;

	EXPORT	Base	:=	MODULE
		EXPORT	suppressedjurisdictions	:=	versioncontrol.mBuildFilenameVersions(lBaseTemplate	+	'suppressedjurisdictions'	,pVersion);

		EXPORT	dAll_filenames	:=
			suppressedjurisdictions.dAll_filenames
		;
	END;

	EXPORT	dAll_filenames	:=
		Base.dAll_filenames
	;
END;
