export File_Lobbyists_OH_2005 := dataset
(Lobbyist_Thor_Cluster + '::in::lobbyists::oh_20050202_initial.csv',lobbyists.Layout_Lobbyists_OH_2005,
	csv(heading(1),
	separator(','),
	quote('"'),
	terminator(['\r\n','\r','\n'])));	