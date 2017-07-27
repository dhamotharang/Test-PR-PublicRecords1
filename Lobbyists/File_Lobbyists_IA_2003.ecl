export File_Lobbyists_IA_2003 := dataset(Lobbyist_Thor_Cluster + '::in::lobbyists::ia_2003',
                                         Layout_Lobbyists_IA_2003,
																				 csv(heading(1),
																				     separator(','),
																						 quote('"'),
																						 terminator(['\r\n','\r','\n'])));