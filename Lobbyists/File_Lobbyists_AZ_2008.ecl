export File_Lobbyists_AZ_2008 := 
dataset(lobbyist_thor_cluster+'::in::lobbyists_az_lobexport_2.csv',
        lobbyists.Layout_Lobbyists_AZ_2008,
	    csv(heading(1), 
	    separator(','),
	    //quote('"'),
	    terminator(['\r\n'])));