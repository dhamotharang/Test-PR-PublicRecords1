export File_Lobbyists_NJ_2006 := dataset
(Lobbyist_Thor_Cluster + '::in::lobbyist_nj_20060323_request_ferris_robin',lobbyists.Layout_Lobbyists_NJ_2006,    
	csv(heading(1),
	separator(','),
	quote('"'),
	terminator(['\r\n','\r','\n'])));