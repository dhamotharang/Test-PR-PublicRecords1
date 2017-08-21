export File_Lobbyists_TX_2004 := dataset
(Lobbyist_Thor_Cluster + '::in::lobbyists_tx_lobcon04.csv',lobbyists.Layout_Lobbyists_TX_2001_2005,
	csv(heading(1),
	separator(','),
	quote('"'),
	terminator(['\r\n','\r','\n'])));