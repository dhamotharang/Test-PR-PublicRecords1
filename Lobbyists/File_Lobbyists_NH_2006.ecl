export File_Lobbyists_NH_2006 := dataset
(Lobbyist_Thor_Cluster + '::in::lobbyist_nh_20060406_full_file_update',lobbyists.Layout_Lobbyists_NH_2006,
	csv(heading(1),
	separator(','),
	quote('"'),
	terminator(['\r\n','\r','\n'])));