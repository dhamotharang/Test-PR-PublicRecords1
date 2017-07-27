export File_Lobbyists_TN_2003 := dataset
(Lobbyist_Thor_Cluster + '::in::tn_lobbyists_2003.csv',lobbyists.Layout_Lobbyists_TN_2003,
	csv(heading(1),
	separator(','),
	quote('"'),
	terminator(['\r\n','\r','\n'])));