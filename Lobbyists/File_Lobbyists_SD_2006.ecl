export File_Lobbyists_SD_2006 := dataset
(Lobbyist_Thor_Cluster + '::in::lobbyist_sd_20060414_list',lobbyists.Layout_Lobbyists_SD_2006,
	csv(heading(1),
	separator(','),
	quote('"'),
	terminator(['\r\n','\r','\n'])));