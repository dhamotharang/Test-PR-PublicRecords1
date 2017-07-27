export File_Lobbyists_IA_2004 := dataset(Lobbyist_Thor_Cluster + '::in::lobbyists::ia_2004',
                                         Layout_Lobbyists_IA_2004,
																				 csv(heading(1),
																				     separator(','),
																						 quote('"'),
																						 terminator(['\r\n','\r','\n'])));