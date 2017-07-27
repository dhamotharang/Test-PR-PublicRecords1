export File_Lobbyists_TN_2001 := dataset
(Lobbyist_Thor_Cluster + '::in::tn_lobbyists_2001.csv',lobbyists.Layout_Lobbyists_TN_2001,
	csv(heading(1),
	separator(','),
	quote('"'),
	terminator(['\r\n','\r','\n'])));