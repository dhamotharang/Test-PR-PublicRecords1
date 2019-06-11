IMPORT VersionControl,	ut;

EXPORT Keynames(STRING	pversion							=	'',
								BOOLEAN	pUseOtherEnvironment	=	FALSE,
								BOOLEAN	isFCRA								=	FALSE)	:=	MODULE

	SHARED	lkeyTemplate			:=	_Dataset(pUseOtherEnvironment).thor_cluster_files	+	'key::'	+	_Dataset().name	+	IF(isFCRA,'::fcra','')	+	'::@version@::';

  //list all keys here 
	EXPORT	did		:=	VersionControl.mBuildFilenameVersions(lkeyTemplate+'did',pversion);

	EXPORT	dAll_filenames := did.dAll_filenames;

END;    
