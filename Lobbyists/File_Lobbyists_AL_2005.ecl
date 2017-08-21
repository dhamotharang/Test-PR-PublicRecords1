export File_Lobbyists_AL_2005 := dataset
 (lobbyist_thor_cluster+'::in::Lobbyists_AL_5_05_05.csv',lobbyists.Layout_Lobbyists_AL_2005,
	csv(heading(0), 
	separator(','),
	quote('"'),
	terminator(['\r\n','\r','\n'])));




