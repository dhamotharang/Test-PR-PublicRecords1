IMPORT VersionControl,	ut;

EXPORT Keynames(STRING	pversion							=	'',
								BOOLEAN	pUseOtherEnvironment	=	FALSE,
								BOOLEAN	isFCRA								=	FALSE)	:=	MODULE

	SHARED	lkeyTemplate			:=	_Dataset(pUseOtherEnvironment).thor_cluster_files	+	'key::'	+	_Dataset().name	+	IF(isFCRA,'::fcra','')	+	'::@version@::';

	EXPORT	laddrline1_addrlinelast	:=	'addrline1_addrlinelast';

	EXPORT	Addrline1_Addrlinelast	:=	VersionControl.mBuildFilenameVersions(lkeyTemplate+laddrline1_addrlinelast,pversion);

	EXPORT	dAll_filenames					:=
		Addrline1_Addrlinelast.dAll_filenames
	;

END;