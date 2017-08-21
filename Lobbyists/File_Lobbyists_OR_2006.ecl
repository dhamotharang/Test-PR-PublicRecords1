export File_Lobbyists_OR_2006 := dataset
(lobbyist_thor_cluster+'::in::lobbyist_or_20060710_lobbyist_list',lobbyists.Layout_Lobbyists_OR_2006,
	csv(heading(1),
	separator(','),
	quote('"'),
	terminator(['\r\n','\r','\n'])));