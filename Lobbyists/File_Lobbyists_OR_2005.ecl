export File_Lobbyists_OR_2005 := dataset
(lobbyist_thor_cluster+'::in::lobbyists_or_20050207_lobbyist_mod.csv',lobbyists.Layout_Lobbyists_OR_2005,
	csv(heading(1),
	separator(','),
	quote('"'),
	terminator(['\r\n','\r','\n'])));