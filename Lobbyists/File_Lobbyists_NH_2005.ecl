export File_Lobbyists_NH_2005 := dataset
(Lobbyist_Thor_Cluster + '::in::lobbyists::nh_20050324_initial.csv',lobbyists.Layout_Lobbyists_NH_2005,
	csv(heading(1),
	separator(','),
	quote('"'),
	terminator(['\r\n','\r','\n'])));