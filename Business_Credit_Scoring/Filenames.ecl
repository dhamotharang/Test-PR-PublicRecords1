IMPORT	versioncontrol;
EXPORT	Filenames(STRING	pversion	=	'',
									BOOLEAN	pUseProd	=	FALSE)	:=	MODULE

	EXPORT	lBaseTemplate		:=	_Dataset(pUseProd).thor_cluster_files	+	'base::'	+	_Dataset().name	+	'::@version@::';
	EXPORT	lOutTemplate		:=	_Dataset(pUseProd).thor_cluster_files	+	'out::'		+	_Dataset().name	+	'::@version@::';

	EXPORT	Base	:=	MODULE
		EXPORT	UniqueLinkIDs	:=	versioncontrol.mBuildFilenameVersions(lBaseTemplate	+	'uniquelinkids'	,pversion);
		EXPORT	Scores				:=	versioncontrol.mBuildFilenameVersions(lBaseTemplate	+	'scores'				,pversion);
		EXPORT	Scores1				:=	versioncontrol.mBuildFilenameVersions(lBaseTemplate	+	'scores1'				,pversion);
		EXPORT	Scores2				:=	versioncontrol.mBuildFilenameVersions(lBaseTemplate	+	'scores2'				,pversion);
		EXPORT	Scores3				:=	versioncontrol.mBuildFilenameVersions(lBaseTemplate	+	'scores3'				,pversion);
		EXPORT	Scores4				:=	versioncontrol.mBuildFilenameVersions(lBaseTemplate	+	'scores4'				,pversion);
		EXPORT	Scores5				:=	versioncontrol.mBuildFilenameVersions(lBaseTemplate	+	'scores5'				,pversion);
		EXPORT	Scores6				:=	versioncontrol.mBuildFilenameVersions(lBaseTemplate	+	'scores6'				,pversion);
		EXPORT	Scores7				:=	versioncontrol.mBuildFilenameVersions(lBaseTemplate	+	'scores7'				,pversion);
		EXPORT	DBTAverage		:=	versioncontrol.mBuildFilenameVersions(lBaseTemplate	+	'dbtaverage'		,pversion);

		EXPORT	dAll_filenames	:=
			UniqueLinkIDs.dAll_filenames
			+	Scores.dAll_filenames
			+	Scores1.dAll_filenames
			+	Scores2.dAll_filenames
			+	Scores3.dAll_filenames
			+	Scores4.dAll_filenames
			+	Scores5.dAll_filenames
			+	Scores6.dAll_filenames
			+	Scores7.dAll_filenames
			+	DBTAverage.dAll_filenames
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
