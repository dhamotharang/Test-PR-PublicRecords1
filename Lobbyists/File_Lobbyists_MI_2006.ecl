export File_Lobbyists_MI_2006 := dataset
	(Lobbyist_Thor_Cluster + '::in::lobbyist_mi_20060323_lobby',lobbyists.Layout_Lobbyists_MI_2006,
	csv(heading(1),
	separator(','),
	quote('"'),
	terminator(['\r\n','\r','\n'])));
	