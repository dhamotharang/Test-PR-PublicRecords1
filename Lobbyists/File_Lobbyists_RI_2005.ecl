export File_Lobbyists_RI_2005 := dataset
(Lobbyist_Thor_Cluster + '::in::lobbyists::ri_20050217_full_report_entity.csv',lobbyists.Layout_Lobbyists_RI_2005,
	csv(heading(2),
	separator(','),
	quote('"'),
	terminator(['\r\n','\r','\n'])));