export File_Lobbyists_MT_2003_2004 := dataset
(lobbyist_thor_cluster+'::in::lobbyists_mt_2003_2004_irr_lb_pr1.csv',lobbyists.Layout_Lobbyists_MT_2000_2006,
	csv(heading(3),
	separator(','),
	quote('"'),
	terminator(['\r\n','\r','\n'])));