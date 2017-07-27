IMPORT VersionControl,	Business_Credit,	ut;

EXPORT Keynames(STRING		pversion							=	'',
								BOOLEAN		pUseOtherEnvironment	=	FALSE)	:=	MODULE

	SHARED	lkeyTemplate			:=	Business_Credit._Dataset(pUseOtherEnvironment).thor_cluster_files	+	'key::'		+	Business_Credit._Dataset().name	+	'::@version@::';

	EXPORT	lbipv2bestlinkids	:=	'bipv2_best::linkIds';

	EXPORT	LinkIds						:=	VersionControl.mBuildFilenameVersions(lkeyTemplate+lbipv2bestlinkids,pversion);

	EXPORT	dAll_filenames				:=
		LinkIds.dAll_filenames
	;

END;