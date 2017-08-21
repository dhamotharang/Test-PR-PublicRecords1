export File_Lobbyists_AR_2005 := dataset
(lobbyist_thor_cluster+'::in::lobbyists_ar_20050131_sep13.csv',lobbyists.Layout_Lobbyists_AR_2005,
	csv(heading(1), 
	separator(','),
	quote('"'),
	terminator(['\r\n','\r','\n'])));

