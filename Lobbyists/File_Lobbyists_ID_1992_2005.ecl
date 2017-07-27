export File_Lobbyists_ID_1992_2005 := dataset(Lobbyist_Thor_Cluster + '::in::lobbyists::id_1992_2005_lobbyist',
                                              Layout_Lobbyists_ID_1992_2005,
																							csv(heading(1),
																							    separator(','),
																									quote('"'),
																									terminator(['\r\n','\r','\n'])));