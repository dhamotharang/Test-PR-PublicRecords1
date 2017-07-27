export File_Lobbyists_NC_1993_2006 := dataset
(Lobbyist_Thor_Cluster + '::in::lobbyists::nc_20050307_initial.csv',lobbyists.Layout_Lobbyists_NC_1993_2006,                                   
	csv(heading(1),
	separator(','),
	quote('"'),
	terminator(['\r\n','\r','\n'])));