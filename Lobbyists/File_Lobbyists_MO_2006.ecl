export File_Lobbyists_MO_2006 := dataset(Lobbyist_Thor_Cluster + '::in::lobbyist_mo_20060323_lobbyist_principal_report_03_23_2006',
                                              Layout_Lobbyists_MO_2006,
											  csv(heading(1),
											  separator(','),
											  quote('"'),
											  terminator(['\r\n','\r','\n'])));