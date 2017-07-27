export File_Lobbyists_MO_2000_2005 := dataset(Lobbyist_Thor_Cluster + '::in::lobbyists::MO_2000_2005',
                                              Layout_Lobbyists_MO_2000_2005,
																							csv(heading(1),
																							    separator(','),
																									quote('"'),
																									terminator(['\r\n','\r','\n'])));