import	doxie;

dCountryBase	:=	GlobalWatchLists.File_GlobalWatchLists_V4.Base.Country;

dCountrySlim	:=	project(dCountryBase,GlobalWatchLists.Layout_GlobalWatchLists_V4.LayoutCountry);

export	key_GlobalWatchLists_Country_V4	:=	INDEX(	dCountrySlim,
																										{CountryID},
																										{dCountrySlim},
																										GlobalWatchLists.Constants.Cluster	+	'key::globalwatchlists::'	+	doxie.Version_SuperKey	+	'::countries'
																									);
