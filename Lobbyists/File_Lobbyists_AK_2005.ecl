export File_Lobbyists_AK_2005 := dataset
(lobbyist_thor_cluster+'::in::lobbyists_ak_2005_lobdir.csv',lobbyists.Layout_Lobbyists_AK_2005,
	csv(heading(1), 
	separator(','),
	quote('"'),
	terminator(['\r\n','\r','\n'])));