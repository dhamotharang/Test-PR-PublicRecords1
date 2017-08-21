export File_Lobbyists_ND_2006 := dataset
(Lobbyist_Thor_Cluster + '::in::lobbyist_nd_20060118_lobbyist_2003-2005',lobbyists.Layout_Lobbyists_ND_2006,
	csv(heading(1),
	separator(','),
	quote('"'),
	terminator(['\r\n','\r','\n'])));