export File_Lobbyists_RI_2006 := dataset
(Lobbyist_Thor_Cluster + '::in::lobbyist_ri_20060323_full_report_by_entity',lobbyists.Layout_Lobbyists_RI_2006,
	csv(heading(2),
	separator(','),
	quote('"'),
	terminator(['\r\n','\r','\n'])));