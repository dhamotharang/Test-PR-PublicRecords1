IMPORT	versioncontrol;
EXPORT	Filenames(	STRING		pVersion	=	'',
																		BOOLEAN	pUseProd	=	FALSE)	:=	MODULE

	EXPORT	lInputTemplate	:=	'~thor400_20::in::fedex::nohit::@version@';
	EXPORT	lBaseTemplate		:=	'~thor_200::base::fedex::nohits::@version@';

	EXPORT	Input	:=	MODULE
		EXPORT	nohit	:=	versioncontrol.mInputFilenameVersions(lInputTemplate,	pVersion);

		EXPORT	dAll_filenames	:=
			nohit.dAll_filenames
		;
	END;

	EXPORT	Base		:=	MODULE
		EXPORT	Fedex	:=	versioncontrol.mBuildFilenameVersions(lBaseTemplate,pVersion);

		EXPORT	dAll_filenames	:=
			Fedex.dAll_filenames
		;
	END;
	


	EXPORT	dAll_filenames	:=
			Base.dAll_filenames
		;
END;