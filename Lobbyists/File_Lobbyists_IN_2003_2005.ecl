export File_Lobbyists_IN_2003_2005 := dataset
(lobbyist_thor_cluster+'::in::lobbyists_in_20050408_initial_mod.csv',lobbyists.Layout_Lobbyists_IN_2003_2005,
	csv(heading(1),
	separator(','),
	quote('"'),
	terminator(['\r\n','\r','\n'])));