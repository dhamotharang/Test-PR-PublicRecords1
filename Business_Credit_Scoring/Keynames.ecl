IMPORT VersionControl,	ut;

EXPORT Keynames(STRING		pversion							=	'',
								BOOLEAN		pUseOtherEnvironment	=	FALSE)	:=	MODULE

	SHARED	lkeyTemplate		:=	_Dataset(pUseOtherEnvironment).thor_cluster_files	+	'key::'		+	_Dataset().name	+	'::@version@::';

	EXPORT	lscoringindex		:=	'scoringindex';

	EXPORT	ScoringIndex		:=	VersionControl.mBuildFilenameVersions(lkeyTemplate+lscoringindex,pversion);

	EXPORT	dAll_filenames	:=
		ScoringIndex.dAll_filenames
	;

END;