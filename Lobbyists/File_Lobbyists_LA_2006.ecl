export File_Lobbyists_LA_2006 := dataset
(lobbyist_thor_cluster+'::in::lobbyist_la_20060428_loblist',lobbyists.Layout_Lobbyists_LA_2006,
	csv(heading(1), 
	separator(','),
	quote('"'),
	terminator(['\r\n','\r','\n'])));