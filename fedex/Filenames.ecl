IMPORT	versioncontrol;
EXPORT	Filenames(	STRING		pVersion	=	'',
																		BOOLEAN	pUseProd	=	FALSE)	:=	MODULE

	EXPORT	lInputTemplate	:=	'thor400_20::in::fedex::nohit::@version@';
	EXPORT	lBaseTemplate		:=	'thor_200::base::fedex::nohits::@version@';

	EXPORT	Input	:=	MODULE
		EXPORT	nohit	:=	versioncontrol.mInputFilenameVersions(lInputTemplate,	pVersion);

		EXPORT	dAll_filenames	:=
			raw.dAll_filenames
		;
	END;

	EXPORT	Base		:=	MODULE
		EXPORT	Fedex	:=	versioncontrol.mBuildFilenameVersions(lBaseTemplate,pVersion);

		EXPORT	dAll_filenames	:=
			FirstData.dAll_filenames
		;
	END;
	


	EXPORT	dAll_filenames	:=
			Base.dAll_filenames
		;
END;