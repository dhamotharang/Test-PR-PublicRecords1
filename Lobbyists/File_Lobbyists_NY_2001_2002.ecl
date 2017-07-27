export File_Lobbyists_NY_2001_2002 := dataset
(Lobbyist_Thor_Cluster + '::in::lobbyists::ny_20050308_initial_mod.csv',lobbyists.Layout_Lobbyists_NY_2001_2002,
	csv(heading(1),
	separator(','),
	quote('"'),
	terminator(['\r\n','\r','\n'])));	