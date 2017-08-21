export File_Lobbyists_TX_2000 := dataset
(Lobbyist_Thor_Cluster + '::in::lobbyists_tx_lobted00.csv',lobbyists.Layout_Lobbyists_TX_1997_2000,
	csv(heading(1),
	separator(','),
	quote('"'),
	terminator(['\r\n','\r','\n'])));