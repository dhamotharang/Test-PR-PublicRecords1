import data_services;

export foreign_prod := if(VersionControl._Flags.IsDataland
													,data_services.foreign_prod
													,'~'
												);