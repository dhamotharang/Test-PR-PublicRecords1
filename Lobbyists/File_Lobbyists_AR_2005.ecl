export File_Lobbyists_AR_2005 := dataset
('~thor_200::in::AR_Lobbyist_2005_modified',lobbyists.Layout_Lobbyists_AR_2005,
	csv(heading(0), 
	separator(','),
	quote('"'),
	terminator(['\r\n','\r','\n'])));

