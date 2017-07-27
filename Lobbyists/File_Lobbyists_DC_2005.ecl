export File_Lobbyists_DC_2005 := dataset
(lobbyist_thor_cluster+'::in::lobbyists_DC_20050412_initial.csv',lobbyists.Layout_Lobbyists_DC_2005,
	csv(heading(1),
	separator(','),
	quote('"'),
	terminator(['\r\n','\r','\n'])));