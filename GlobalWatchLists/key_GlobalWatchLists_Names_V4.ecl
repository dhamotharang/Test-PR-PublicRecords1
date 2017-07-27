import	doxie;

dNamesNorm	:=	globalwatchlists.Normalize_AKAList;

dNames	:=	project(dNamesNorm,GlobalWatchLists.Layout_GlobalWatchLists_V4.LayoutName);

export	key_GlobalWatchLists_Names_V4	:=	INDEX(	dNames,
																									{EntityID,RecordID},
																									{dNames},
																									GlobalWatchLists.constants.Cluster	+	'key::globalwatchlists::'	+	doxie.Version_SuperKey	+	'::names'
																								);