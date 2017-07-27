export File_Lobbyists_HI_2005_2006 := dataset(Lobbyist_Thor_Cluster + '::in::lobbyists::hi_20050405_initial',
                                              Layout_Lobbyists_HI_2005_2006,
																							csv(heading(1),
																							    separator(','),
																									quote('"'),
																									terminator(['\r\n','\r','\n'])));