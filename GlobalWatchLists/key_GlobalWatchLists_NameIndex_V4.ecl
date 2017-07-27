import doxie;

dNamesNorm	:=	Globalwatchlists.Normalize_AKAList;

dNameIndex	:=	project(dNamesNorm,GlobalWatchLists.Layout_GlobalWatchLists_V4.LayoutNameIndex);

export	key_GlobalWatchLists_NameIndex_V4	:=	INDEX(	dNameIndex,
																											{Key,ListID},
																											{dNameIndex},
																											GlobalWatchLists.constants.Cluster	+	'key::globalwatchlists::'	+	doxie.Version_SuperKey	+	'::name_index'
																										);
