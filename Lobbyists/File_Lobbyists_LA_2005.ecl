export File_Lobbyists_LA_2005 := dataset
(lobbyist_thor_cluster+'::in::lobbyists_LA_20050819_alllobs.csv',lobbyists.Layout_Lobbyists_LA_2005,
	csv(heading(1), 
	separator(','),
	quote('"'),
	terminator(['\r\n','\r','\n'])));