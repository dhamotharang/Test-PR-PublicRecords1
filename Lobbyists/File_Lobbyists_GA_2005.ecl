export File_Lobbyists_GA_2005 := dataset
(Lobbyist_Thor_Cluster + '::in::lobbyists::ga_20050307_initial.csv',lobbyists.Layout_Lobbyists_GA_2005,
	csv(heading(1),
	separator(','),
	quote('"'),
	terminator(['\r\n','\r','\n'])));