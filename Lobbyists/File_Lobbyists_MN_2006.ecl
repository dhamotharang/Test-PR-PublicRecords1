export File_Lobbyists_MN_2006 := dataset(Lobbyist_Thor_Cluster + '::in::lobbyist_mn_20060328_active_lobbyists_w_address',
                                         Layout_Lobbyists_MN_2006,
										 csv(heading(1),
										 separator(','),
										 quote('"'),
										 terminator(['\r\n','\r','\n'])));