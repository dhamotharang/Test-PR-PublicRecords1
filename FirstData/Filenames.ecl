IMPORT	versioncontrol;
EXPORT	Filenames(	STRING		pVersion	=	'',
																		BOOLEAN	pUseProd	=	FALSE)	:=	MODULE

	EXPORT	lInputTemplate	:=	_Dataset(pUseProd).thor_cluster_files	+	'in::'	+	_Dataset().pDatasetName	+	'::@version@::';
	EXPORT	lBaseTemplate		:=	_Dataset(pUseProd).thor_cluster_files	+	'base::'	+	_Dataset().pDatasetName	+	'::@version@::';

	EXPORT	Input	:=	MODULE
		EXPORT	raw	:=	versioncontrol.mInputFilenameVersions(lInputTemplate	+	'raw'	,	pVersion);

		EXPORT	dAll_filenames	:=
			raw.dAll_filenames
		;
	END;

	EXPORT	Base		:=	MODULE
		EXPORT	FirstData	:=	versioncontrol.mBuildFilenameVersions(lBaseTemplate	+	'firstdata'		,pVersion);

		EXPORT	dAll_filenames	:=
			FirstData.dAll_filenames
		;
	END;
	


	EXPORT	dAll_filenames	:=
			Base.dAll_filenames
		;
END;