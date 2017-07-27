export File_Lobbyists_ME_2005 := dataset
	(Lobbyist_Thor_Cluster + '::in::lobbyists::me_20050307_initial.csv',lobbyists.Layout_Lobbyists_ME_2005,
	csv(heading(1),
	separator(','),
	quote('"'),
	terminator(['\r\n','\r','\n'])));
	