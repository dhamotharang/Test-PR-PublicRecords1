export File_Lobbyists_ID_2006 := dataset(Lobbyist_Thor_Cluster + '::in::lobbyist_id_20060323_lobbyist_2006',
												Layout_Lobbyists_ID_2006,
												csv(heading(1),
												separator(','),
												quote('"'),
												terminator(['\r\n','\r','\n'])));