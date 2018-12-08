

// IMPORT	versioncontrol;
// EXPORT	Filenames(STRING	pVersion	=	'',
									// BOOLEAN	pUseProd	=	FALSE)	:=	MODULE

	// EXPORT	lInputTemplate	:=	_Dataset(pUseProd).thor_cluster_files	+	'in::'	 +	_Dataset().name	+	'::@version@::data';
	// EXPORT	lBaseTemplate	  :=	_Dataset(pUseProd).thor_cluster_files	+	'base::' +	_Dataset().name	+	'::@version@::data';

	// EXPORT	Input						:=	versioncontrol.mInputFilenameVersions(lInputTemplate,	pVersion);
	// EXPORT	Base						:=	versioncontrol.mBuildFilenameVersions(lBaseTemplate,	pVersion);

// END;



IMPORT	versioncontrol;
EXPORT	Filenames(STRING	pVersion	=	'',
									BOOLEAN	pUseProd	=	FALSE)	:=	MODULE

	EXPORT	lInputTemplate	:=	_Dataset(pUseProd).thor_cluster_files	+	'in::'		+	_Dataset().name	+	'::@version@::data';
	EXPORT	lBaseTemplate		:=	_Dataset(pUseProd).thor_cluster_files	+	'base::'	+	_Dataset().name	+	'::@version@::data';
	EXPORT	lOutTemplate		:=	_Dataset(pUseProd).thor_cluster_files	+	'out::'		+	_Dataset().name	+	'::@version@::data';

	EXPORT	Input						:=	MODULE
		//EXPORT	withdrawnstatus	:=	versioncontrol.mInputFilenameVersions(lInputTemplate	+	'withdrawnstatus'	,	pVersion);
    EXPORT	withdrawnstatus	:=	versioncontrol.mInputFilenameVersions(lInputTemplate,	pVersion);     
		
		EXPORT	dAll_filenames	:=
			withdrawnstatus.dAll_filenames
		;
	END;

	EXPORT	Base	:=	MODULE
		//EXPORT	withdrawnstatus	:=	versioncontrol.mBuildFilenameVersions(lBaseTemplate	+	'withdrawnstatus'		,pVersion);
    EXPORT	withdrawnstatus	:=	versioncontrol.mBuildFilenameVersions(lBaseTemplate	,pVersion);

		EXPORT	dAll_filenames	:=
			withdrawnstatus.dAll_filenames
		;
	END;

	EXPORT	dAll_filenames	:=
		Base.dAll_filenames
	;
END;
