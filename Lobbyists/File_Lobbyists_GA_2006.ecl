export File_Lobbyists_GA_2006 := dataset
	(Lobbyist_Thor_Cluster + '::in::lobbyist_ga_20060323_lobbyist_2006',lobbyists.Layout_Lobbyists_GA_2006,
	csv(heading(1),
	separator(','),
	quote('"'),
	terminator(['\r\n','\r','\n'])));