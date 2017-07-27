export File_Lobbyists_IA_2001 := dataset(Lobbyist_Thor_Cluster + '::in::lobbyists::ia_2001',
                                         Layout_Lobbyists_IA_2001,
																				 csv(heading(1),
																				     separator(','),
																						 quote('"'),
																						 terminator(['\r\n','\r','\n'])));