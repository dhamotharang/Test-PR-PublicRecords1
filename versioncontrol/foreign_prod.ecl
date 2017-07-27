import ut;

export foreign_prod := if(VersionControl._Flags.IsDataland
													,ut.foreign_prod
													,'~'
												);