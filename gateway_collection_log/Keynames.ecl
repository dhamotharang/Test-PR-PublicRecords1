IMPORT VersionControl,	ut;

EXPORT Keynames(STRING		pversion							=	'',
								BOOLEAN		pUseOtherEnvironment	=	FALSE)	:=	MODULE

	SHARED	lkeyTemplate					:=	_Dataset(pUseOtherEnvironment).thor_cluster_files	+	'key::'		+	_Dataset().name	+	'::@version@::';

	EXPORT	GCDid		              :=	'Did';

	EXPORT	kGatewayCollectionDid :=  VersionControl.mBuildFilenameVersions(lkeyTemplate+GCDid,pversion);

	EXPORT	dAll_filenames				:=	kGatewayCollectionDid.dAll_filenames;

END;