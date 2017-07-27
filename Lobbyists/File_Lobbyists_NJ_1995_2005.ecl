export File_Lobbyists_NJ_1995_2005 := dataset
(Lobbyist_Thor_Cluster + '::in::lobbyists::nj_20050216_request_1999_2005.csv',lobbyists.Layout_Lobbyists_NJ_1995_2005,    
	csv(heading(1),
	separator(','),
	quote('"'),
	terminator(['\r\n','\r','\n'])));