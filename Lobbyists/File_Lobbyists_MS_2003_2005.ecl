export File_Lobbyists_MS_2003_2005 := dataset
(Lobbyist_Thor_Cluster +'::in::lobbyists_ms_20050321_initial.csv',lobbyists.Layout_Lobbyists_MS_2003_2005,
	csv(heading(1),
	separator(','),
	quote('"'),
	terminator(['\r\n','\r','\n'])));