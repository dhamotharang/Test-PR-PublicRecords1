import	doxie;

dCountryNamesNorm	:=	Globalwatchlists.Normalize_CountryAKAList;

dCountryNames	:=	project(dCountryNamesNorm,GlobalWatchLists.Layout_GlobalWatchLists_V4.LayoutCountryName);

export	key_GlobalWatchLists_CountryAKAs_V4	:=	INDEX(	dCountryNames,
																												{CountryID,RecordID},
																												{dCountryNames},
																												GlobalWatchLists.Constants.Cluster	+	'key::globalwatchlists::'	+	doxie.Version_SuperKey	+	'::country_aka'
																											);
