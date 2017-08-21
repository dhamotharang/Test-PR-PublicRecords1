export File_Lobbyists_FL_2005 := dataset
(Lobbyist_Thor_Cluster + '::in::lobbyists_fl_20050412_llob.txt',lobbyists.Layout_Lobbyists_FL_2005_Combined,
	csv(heading(0),
	separator('$#@'),
	quote('"'),
	terminator(['\r\n','\r','\n'])));