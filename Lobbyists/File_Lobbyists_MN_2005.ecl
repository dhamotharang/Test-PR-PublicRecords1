export File_Lobbyists_MN_2005 := dataset(Lobbyist_Thor_Cluster + '::in::lobbyists::MN_20050203',
                                         Layout_Lobbyists_MN_2005,
																				 csv(heading(1),
																				     separator(','),
																						 quote('"'),
																						 terminator(['\r\n','\r','\n'])));