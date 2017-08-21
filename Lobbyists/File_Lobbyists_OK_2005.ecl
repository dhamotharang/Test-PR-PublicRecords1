export File_Lobbyists_OK_2005 := dataset
(lobbyist_thor_cluster+'::in::Lobbyist_OK_20050201_LobList1-31-05.csv',lobbyists.Layout_Lobbyists_OK_2005,
	csv(heading(2), 
	separator(','),
	quote('"'),
	terminator(['\r\n','\r','\n'])));