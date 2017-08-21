export File_Lobbyists_OH_2006 := dataset
(Lobbyist_Thor_Cluster + '::in::lobbyist_oh_20060327_agents_march_2006',lobbyists.Layout_Lobbyists_OH_2006,
	csv(heading(1),
	separator(','),
	quote('"'),
	terminator(['\r\n','\r','\n'])));	