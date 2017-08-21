import Data_Services, versioncontrol;

export foreign_prod := if(VersionControl._Flags.IsDataland
													,Data_Services.foreign_prod
													,'~'
												);