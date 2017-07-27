export File_Lobbyists_IA_2002 := dataset(Lobbyist_Thor_Cluster + '::in::lobbyists::ia_2002',
                                         Layout_Lobbyists_IA_2002,
																				 csv(heading(1),
																				     separator(','),
																						 quote('"'),
																						 terminator(['\r\n','\r','\n'])));