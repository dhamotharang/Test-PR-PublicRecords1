import	doxie;

dIDNorm	:=	GlobalWatchLists.Normalize_IdentificationList;

export	key_GlobalWatchLists_IDNumbers_V4	:=	INDEX(	dIDNorm,
																											{EntityID},
																											{dIDNorm},
																											GlobalWatchLists.constants.Cluster	+	'key::globalwatchlists::'	+	doxie.Version_SuperKey	+	'::id_numbers'
																										);