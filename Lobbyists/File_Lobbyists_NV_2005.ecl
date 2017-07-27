export File_Lobbyists_NV_2005 := dataset
(Lobbyist_Thor_Cluster + '::in::lobbyists::nv_20050413_initial_mod.csv',lobbyists.Layout_Lobbyists_NV_2005,
	csv(heading(1),
	separator(','),
	quote('"'),
	terminator(['\r\n','\r','\n'])));	