import doxie, GlobalWatchLists, ut;

recs := GlobalWatchLists.Build_TokenFile_Country_V4;

recs_n := PROJECT(recs, GlobalWatchLists.Layout_GlobalWatchLists_V4.LayoutToken);

export key_GlobalWatchLists_CountryTokens_V4 := INDEX(recs_n, {tkn}, {recs_n},
																									GlobalWatchLists.constants.Cluster	+	'key::globalwatchlists::'	+	doxie.Version_SuperKey	+	'::country_tokens');
