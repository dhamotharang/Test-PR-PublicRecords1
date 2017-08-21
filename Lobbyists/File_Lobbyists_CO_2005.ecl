export File_Lobbyists_CO_2005 := dataset
(lobbyist_thor_cluster+'::in::lobbyists_CO_curr_lobby.csv',lobbyists.Layout_Lobbyists_CO_2005,
	csv(heading(0), 
	separator('|'),
	quote('"'),
	terminator(['\r\n','\r','\n'])));