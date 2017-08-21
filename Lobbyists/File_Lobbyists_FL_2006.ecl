export File_Lobbyists_FL_2006 := dataset
(Lobbyist_Thor_Cluster + '::in::lobbyist_fl_20060322_llob',lobbyists.Layout_Lobbyists_FL_2006_Combined,
	csv(heading(0),
	separator('$#@'),
	quote('"'),
	terminator(['\r\n','\r','\n'])));