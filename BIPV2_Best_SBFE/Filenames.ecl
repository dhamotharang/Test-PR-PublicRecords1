IMPORT	Business_Credit,	versioncontrol;
EXPORT	Filenames(STRING	pversion	=	'',
									BOOLEAN	pUseProd	=	FALSE)	:=	MODULE

	EXPORT	lBaseTemplate		:=	Business_Credit._Dataset(pUseProd).thor_cluster_files	+	'base::'	+	Business_Credit._Dataset().name	+	'::@version@::';

	EXPORT	Base	:=	MODULE
		EXPORT	bipv2_best	:=	versioncontrol.mBuildFilenameVersions(lBaseTemplate	+	'bipv2_best'		,pversion);

		EXPORT	dAll_filenames	:=
			bipv2_best.dAll_filenames
		;
	END;

	EXPORT	dall_filenames	:=	Base.dAll_filenames;
END;