export File_Lobbyists_MA_2005 := dataset
	(Lobbyist_Thor_Cluster + '::in::Lobbyists_MA_20050411_Initial_csv',lobbyists.Layout_Lobbyists_MA_2005,
	csv(heading(1),
	separator(','),
	quote('"'),
	terminator(['\r\n','\r','\n'])));
