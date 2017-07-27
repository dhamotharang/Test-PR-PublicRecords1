import	doxie;

dNormAddlInfo	:=	GlobalWatchLists.Normalize_AdditionalInfoList;

export	key_GlobalWatchLists_AddlInfo_V4	:=	INDEX(	dNormAddlInfo,
																									{EntityID},
																									{dNormAddlInfo},
																									GlobalWatchLists.constants.Cluster	+	'key::globalWatchLists::'	+	doxie.Version_SuperKey	+	'::addlinfo'
																								);
