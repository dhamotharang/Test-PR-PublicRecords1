IMPORT	versioncontrol;
EXPORT	Filenames(STRING	pversion	=	'',
									BOOLEAN	pUseProd	=	FALSE)	:=	MODULE

	EXPORT	lInputTemplate	:=	_Dataset(pUseProd).thor_cluster_files	+	'in::'		+	_Dataset().name	+	'::@version@::data';
	EXPORT	lBaseTemplate		:=	_Dataset(pUseProd).thor_cluster_files	+	'base::'	+	_Dataset().name	+	'::@version@::';
	EXPORT	lOutTemplate		:=	_Dataset(pUseProd).thor_cluster_files	+	'out::'		+	_Dataset().name	+	'::@version@::';

	EXPORT	SBFEIDCache			:=	'~thor::base::sbfe::sbfeid::cache';
	EXPORT	AddressCache		:=	'~thor::base::sbfe::address::cache';

	EXPORT	Input						:=	versioncontrol.mInputFilenameVersions(lInputTemplate);

	EXPORT	Base	:=	MODULE
		EXPORT	denormalized	:=	versioncontrol.mBuildFilenameVersions(lBaseTemplate	+	'denormalized'		,pversion);

		EXPORT	dAll_filenames	:=
			denormalized.dAll_filenames
		;
	END;

	EXPORT	Out	:=	MODULE
		EXPORT	active						:=	versioncontrol.mBuildFilenameVersions(lOutTemplate	+	'active'					,pversion);
		EXPORT	BIClassification	:=	versioncontrol.mBuildFilenameVersions(lOutTemplate	+	'businessIndustryClassification'	,pversion);
		EXPORT	businessowner			:=	versioncontrol.mBuildFilenameVersions(lOutTemplate	+	'businessowner'		,pversion);
		EXPORT	collateral				:=	versioncontrol.mBuildFilenameVersions(lOutTemplate	+	'collateral'			,pversion);
		EXPORT	history						:=	versioncontrol.mBuildFilenameVersions(lOutTemplate	+	'history'					,pversion);
		EXPORT	individualowner		:=	versioncontrol.mBuildFilenameVersions(lOutTemplate	+	'individualowner'	,pversion);
		EXPORT	linkids						:=	versioncontrol.mBuildFilenameVersions(lOutTemplate	+	'linkids'					,pversion);
		EXPORT	masterAccount			:=	versioncontrol.mBuildFilenameVersions(lOutTemplate	+	'masterAccount'		,pversion);
		EXPORT	memberSpecific		:=	versioncontrol.mBuildFilenameVersions(lOutTemplate	+	'memberSpecific'	,pversion);
		EXPORT	releasedate				:=	versioncontrol.mBuildFilenameVersions(lOutTemplate	+	'releasedate'	,pversion);
		EXPORT	digitalfootprint				:=	versioncontrol.mBuildFilenameVersions(lOutTemplate	+	'digitalfootprint'	,pversion);
		EXPORT	merchantprocessing				:=	versioncontrol.mBuildFilenameVersions(lOutTemplate	+	'merchantprocessing'	,pversion);
		
		EXPORT	dAll_filenames	:=
			active.dAll_filenames
			+	BIClassification.dAll_filenames
			+	businessowner.dAll_filenames
			+	collateral.dAll_filenames
			+	history.dAll_filenames
			+	individualowner.dAll_filenames
			+	linkids.dAll_filenames
			+	masterAccount.dAll_filenames
			+	memberSpecific.dAll_filenames
			+ releasedate.dAll_filenames
			+ digitalfootprint.dAll_filenames
			+ merchantprocessing.dAll_filenames
		;
	END;

	EXPORT	dAll_filenames	:=
		Base.dAll_filenames
		+	Out.dAll_filenames
	;
END;
