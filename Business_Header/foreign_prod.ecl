import versioncontrol, data_services;

export foreign_prod := if(VersionControl._Flags.IsDataland
													,Data_Services.foreign_prod
													,'~'
												);