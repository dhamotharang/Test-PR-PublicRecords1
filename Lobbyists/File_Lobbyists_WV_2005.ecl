export File_Lobbyists_WV_2005 := dataset
(Lobbyist_Thor_Cluster + '::in::wv_20050209.lobby_names.csv',lobbyists.Layout_Lobbyists_WV_2005,
	csv(heading(1),
	separator(','),
	quote('"'),
	terminator(['\r\n','\r','\n'])));