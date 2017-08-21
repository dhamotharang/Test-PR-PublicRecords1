export File_Lobbyists_IA_2006 := dataset(Lobbyist_Thor_Cluster + '::in::lobbyist_ia_20060323_lobbyist_client_2006',
											Layout_Lobbyists_IA_2006,
											csv(heading(1),
											separator(','),
											quote('"'),
											terminator(['\r\n','\r','\n'])));