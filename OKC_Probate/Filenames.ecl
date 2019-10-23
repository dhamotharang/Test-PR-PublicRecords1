IMPORT	versioncontrol;
EXPORT	Filenames(	STRING		pVersion	=	'',
																		BOOLEAN	pUseProd	=	FALSE)	:=	MODULE

	EXPORT	lInputTemplate	:=	_Dataset(pUseProd).thor_cluster_files	+	'in::'			+	_Dataset().name	+	'::@version@::';
	EXPORT	lBaseTemplate		:=	_Dataset(pUseProd).thor_cluster_files	+	'base::'	+	_Dataset().name	+	'::@version@::';
	EXPORT	lOutTemplate			:=	_Dataset(pUseProd).thor_cluster_files	+	'out::'		+	_Dataset().name	+	'::@version@::';

	EXPORT	Input	:=	MODULE
		EXPORT	raw	:=	versioncontrol.mInputFilenameVersions(lInputTemplate	+	'raw'	,	pVersion);

		EXPORT	dAll_filenames	:=
			raw.dAll_filenames
		;
	END;

	EXPORT	Base		:=	MODULE
		EXPORT	okcprobate	:=	versioncontrol.mBuildFilenameVersions(lBaseTemplate	+	'okcprobate'		,pVersion);

		EXPORT	dAll_filenames	:=
			okcprobate.dAll_filenames
		;
	END;
	
	EXPORT	Out	:=	MODULE
		EXPORT	deathmasterv3	:=	versioncontrol.mBuildFilenameVersions(lOutTemplate	+	'deathmasterv3'					,pversion);
		
		EXPORT	dAll_filenames	:=
			deathmasterv3.dAll_filenames
		;
	END;

	EXPORT	dAll_filenames	:=
			Base.dAll_filenames
			+	Out.dAll_filenames
		;
END;
