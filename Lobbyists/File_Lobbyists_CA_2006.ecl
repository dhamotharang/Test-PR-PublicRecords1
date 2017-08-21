export File_Lobbyists_CA_2006 := dataset
(lobbyist_thor_cluster+'::in::lobbyist_ca_20060914_lobbyist',lobbyists.Layout_Lobbyists_CA_2006,
	csv(heading(1), 
	separator(','),
	quote('"'),
	terminator(['\r\n','\r','\n'])));