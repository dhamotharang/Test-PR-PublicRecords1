export File_Lobbyists_WV_2006 := dataset
(Lobbyist_Thor_Cluster + '::in::lobbyist_wv_20060328_lobby',lobbyists.Layout_Lobbyists_WV_2006,
	csv(heading(1),
	separator(','),
	quote('"'),
	terminator(['\r\n','\r','\n'])));