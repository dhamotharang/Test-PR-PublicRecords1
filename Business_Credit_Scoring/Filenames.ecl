IMPORT	versioncontrol;
EXPORT	Filenames(STRING	pversion	=	'',
									BOOLEAN	pUseProd	=	FALSE)	:=	MODULE

	EXPORT	lBaseTemplate		:=	_Dataset(pUseProd).thor_cluster_files	+	'base::'	+	_Dataset().name	+	'::@version@::';
	EXPORT	lOutTemplate		:=	_Dataset(pUseProd).thor_cluster_files	+	'out::'		+	_Dataset().name	+	'::@version@::';

	EXPORT	Base	:=	MODULE
		EXPORT	DBTAverage		:=	versioncontrol.mBuildFilenameVersions(lBaseTemplate	+	'dbtaverage'	,pversion);
		EXPORT	Scores				:=	versioncontrol.mBuildFilenameVersions(lBaseTemplate	+	'scores'			,pversion);

		EXPORT	dAll_filenames	:=
			DBTAverage.dAll_filenames
			+	Scores.dAll_filenames
		;
	END;

	EXPORT	Out	:=	MODULE
		EXPORT	ScoringIndex	:=	versioncontrol.mBuildFilenameVersions(lOutTemplate	+	'scoringindex'	,pversion);
		
		EXPORT	dAll_filenames	:=
			ScoringIndex.dAll_filenames
		;
	END;

	EXPORT	dAll_filenames	:=
		Base.dAll_filenames
		+	Out.dAll_filenames
	;
END;
