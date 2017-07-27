IMPORT VersionControl,	ut;

EXPORT Keynames(STRING		pversion							=	'',
								BOOLEAN		pUseOtherEnvironment	=	FALSE)	:=	MODULE

	SHARED	lkeyTemplate					:=	_Dataset(pUseOtherEnvironment).thor_cluster_files	+	'key::'		+	_Dataset().name	+	'::@version@::';

	EXPORT	lbiclassification			:=	'businessindustryclassification';
	EXPORT	lboinformation				:=	'businessownerinformation';
	EXPORT	lbusinessinformation	:=	'businessinformation';
	EXPORT	lbusinessowner				:=	'businessowner';
	EXPORT	lcollateral						:=	'collateral';
	EXPORT	lindividualowner			:=	'individualowner';
	EXPORT	lioinformation				:=	'individualownerinformation';
	EXPORT	lmasteraccount				:=	'masteraccount';
	EXPORT	lmemberspecific				:=	'memberspecific';
	EXPORT	llinkIDs							:=	'linkIds';
	EXPORT	ltradeline						:=	'tradeline';
	EXPORT	ltradelineguarantor		:=	'tradelineguarantor';
	EXPORT	lhistory							:=	'history';
	EXPORT	lreleasedate					:=	'releasedate';

	EXPORT	BIClassification			:=	VersionControl.mBuildFilenameVersions(lkeyTemplate+lbiclassification,pversion);
	EXPORT	BOInformation					:=	VersionControl.mBuildFilenameVersions(lkeyTemplate+lboinformation,pversion);
	EXPORT	BusinessInformation		:=	VersionControl.mBuildFilenameVersions(lkeyTemplate+lbusinessinformation,pversion);
	EXPORT	BusinessOwner					:=	VersionControl.mBuildFilenameVersions(lkeyTemplate+lbusinessowner,pversion);
	EXPORT	Collateral						:=	VersionControl.mBuildFilenameVersions(lkeyTemplate+lcollateral,pversion);
	EXPORT	IndividualOwner				:=	VersionControl.mBuildFilenameVersions(lkeyTemplate+lindividualowner,pversion);
	EXPORT	IOInformation					:=	VersionControl.mBuildFilenameVersions(lkeyTemplate+lioinformation,pversion);
	EXPORT	MasterAccount					:=	VersionControl.mBuildFilenameVersions(lkeyTemplate+lmasteraccount,pversion);
	EXPORT	MemberSpecific				:=	VersionControl.mBuildFilenameVersions(lkeyTemplate+lmemberspecific,pversion);
	EXPORT	LinkIds								:=	VersionControl.mBuildFilenameVersions(lkeyTemplate+llinkIDs,pversion);
	EXPORT	Tradeline							:=	VersionControl.mBuildFilenameVersions(lkeyTemplate+ltradeline,pversion);
	EXPORT	TradelineGuarantor		:=	VersionControl.mBuildFilenameVersions(lkeyTemplate+ltradelineguarantor,pversion);
	EXPORT	History								:=	VersionControl.mBuildFilenameVersions(lkeyTemplate+lhistory,pversion);
	EXPORT	ReleaseDate						:=	VersionControl.mBuildFilenameVersions(lkeyTemplate+lreleasedate,pversion);

	EXPORT	dAll_filenames				:=
		BIClassification.dAll_filenames
		+	BOInformation.dAll_filenames
		+	BusinessInformation.dAll_filenames
		+	BusinessOwner.dAll_filenames
		+	Collateral.dAll_filenames
		+	IndividualOwner.dAll_filenames
		+	IOInformation.dAll_filenames
		+	MasterAccount.dAll_filenames
		+	MemberSpecific.dAll_filenames
		+	LinkIds.dAll_filenames
		+	Tradeline.dAll_filenames
		+	TradelineGuarantor.dAll_filenames
		+	History.dAll_filenames
		+	ReleaseDate.dAll_filenames
	;

END;