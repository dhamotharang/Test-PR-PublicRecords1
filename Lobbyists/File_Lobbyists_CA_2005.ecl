export File_Lobbyists_CA_2005 := dataset
(lobbyist_thor_cluster+'::in::lobbyists_ca_20050624_lobbyists.csv',lobbyists.Layout_Lobbyists_CA_2005,
	csv(heading(1), 
	separator(','),
	quote('"'),
	terminator(['\r\n','\r','\n'])));