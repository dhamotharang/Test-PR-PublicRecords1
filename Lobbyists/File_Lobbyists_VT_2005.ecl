export File_Lobbyists_VT_2005 := dataset
(lobbyist_thor_cluster+'::in::Lobbyist_VT_Employer_Listing_3_30_2005_csv',lobbyists.Layout_Lobbyists_VT_2005,
	csv(heading(2), 
	separator(','),
	quote('"'),
	terminator(['\r\n','\r','\n'])));