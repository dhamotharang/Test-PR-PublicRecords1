export File_Lobbyists_SD_1998_2005 := dataset
(Lobbyist_Thor_Cluster + '::in::lobbyists::sd_20050308_initial.csv',lobbyists.Layout_Lobbyists_SD_1998_2005,
	csv(heading(1),
	separator(','),
	quote('"'),
	terminator(['\r\n','\r','\n'])));