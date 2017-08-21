export File_Lobbyists_AZ_2005 := dataset
(lobbyist_thor_cluster+'::in::lobbyists_az_lobexport_1.csv',lobbyists.Layout_Lobbyists_AZ_2005,
	csv(heading(1), 
	separator(','),
	quote('"'),
	terminator(['\r\n','\r','\n'])));