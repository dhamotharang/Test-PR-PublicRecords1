export File_Lobbyists_MA_2006 := dataset
(lobbyist_thor_cluster+'::in::lobbyist_ma_20060427_lobbyist_division_extract',lobbyists.Layout_Lobbyists_MA_2006,
	csv(heading(1), 
	separator(','),
	quote('"'),
	terminator(['\r\n','\r','\n'])));