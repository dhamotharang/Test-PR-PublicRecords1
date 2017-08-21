export File_Lobbyists_MT_2000_2002 := dataset
(lobbyist_thor_cluster+'::in::lobbyists_mt_2000_2002_irr_lb_pr1.csv',lobbyists.Layout_Lobbyists_MT_2000_2006,
	csv(heading(3),
	separator(','),
	quote('"'),
	terminator(['\r\n','\r','\n'])));