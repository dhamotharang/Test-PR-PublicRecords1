export File_Lobbyists_UT_2006 := dataset
(lobbyist_thor_cluster+'::in::lobbyist_ut_20051229_lobbyists',lobbyists.Layout_Lobbyists_UT_2006,
	csv(heading(1), 
	separator(','),
	quote('"'),
	terminator(['\r\n','\r','\n'])));