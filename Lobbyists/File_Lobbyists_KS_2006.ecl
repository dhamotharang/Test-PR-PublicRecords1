export File_Lobbyists_KS_2006 := dataset
(Lobbyist_Thor_Cluster + '::in::lobbyist_ks_20060428_lobbyist_directory_april_28',lobbyists.Layout_Lobbyists_KS_2006,
	csv(heading(1),
	separator(','),
	quote('"'),
	terminator(['\r\n','\r','\n'])));