export File_Lobbyists_IN_2006 := dataset
(lobbyist_thor_cluster+'::in::lobbyist_in_20060410_update_2006',lobbyists.Layout_Lobbyists_IN_2006,
	csv(heading(1),
	separator(','),
	quote('"'),
	terminator(['\r\n','\r','\n'])));