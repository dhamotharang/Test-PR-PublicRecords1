export File_Lobbyists_KY_2005 := dataset
(Lobbyist_Thor_Cluster + '::in::lobbyists::ky_20050202_all_eal_mailing_list.csv',lobbyists.Layout_Lobbyists_KY_2005,
	csv(heading(1),
	separator(','),
	quote('"'),
	terminator(['\r\n','\r','\n'])));