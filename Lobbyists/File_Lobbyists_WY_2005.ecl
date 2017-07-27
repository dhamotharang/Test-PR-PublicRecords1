export File_Lobbyists_WY_2005 := dataset
(lobbyist_thor_cluster+'::in::lobbyists_wy_20050413_initial.csv',lobbyists.Layout_Lobbyists_WY_2005,
	csv(heading(1),
	separator(','),
	quote('"'),
	terminator(['\r\n','\r','\n'])));