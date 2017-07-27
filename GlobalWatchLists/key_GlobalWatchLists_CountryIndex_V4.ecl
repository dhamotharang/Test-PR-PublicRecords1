import	doxie;

dCountryNamesNorm	:=	Globalwatchlists.Normalize_CountryAKAList;

dCountryNameIndex	:=	project(dCountryNamesNorm,GlobalWatchLists.Layout_GlobalWatchLists_V4.LayoutCountryIndex);

export	key_GlobalWatchLists_CountryIndex_V4	:=	INDEX(	dCountryNameIndex,
																													{Key,ListID},
																													{dCountryNameIndex},
																													GlobalWatchLists.Constants.Cluster	+	'key::globalwatchlists::'	+	doxie.Version_SuperKey	+	'::country_index'
																												);
