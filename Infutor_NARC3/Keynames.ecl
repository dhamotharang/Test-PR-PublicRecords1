IMPORT VersionControl,	ut;

EXPORT Keynames(STRING	pversion							=	'',
								BOOLEAN	pUseOtherEnvironment	=	FALSE,
								BOOLEAN	isFCRA								=	FALSE)	:=	MODULE

	SHARED	lkeyTemplate			:=	_Dataset(pUseOtherEnvironment).thor_cluster_files	+	'key::'	+	_Dataset().name	+	IF(isFCRA,'::fcra','')	+	'::@version@::';

	EXPORT	lstatus						:=	'status';
	EXPORT	lwithdrawnstatus	:=	'withdrawnstatus';

	EXPORT	Status						:=	VersionControl.mBuildFilenameVersions(lkeyTemplate+lstatus,pversion);
	EXPORT	WithdrawnStatus		:=	VersionControl.mBuildFilenameVersions(lkeyTemplate+lwithdrawnstatus,pversion);

	EXPORT	dAll_filenames		:=
		Status.dAll_filenames						+
		WithdrawnStatus.dAll_filenames
	;

END;
