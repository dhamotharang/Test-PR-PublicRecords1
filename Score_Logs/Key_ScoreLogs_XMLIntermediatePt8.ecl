IMPORT DOXIE,data_services;

File := Score_Logs.Files_index.File_nonFCRA_Intermediate8;
												
EXPORT Key_ScoreLogs_XMLIntermediatePt8 := INDEX(File, {transaction_id}, {File},
																			data_services.data_location.prefix() +'thor_data400::key::acclogs_scoring::'+doxie.Version_SuperKey+'::xml_intermediatept8');
