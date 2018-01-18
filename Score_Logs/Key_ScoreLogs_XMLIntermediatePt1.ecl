IMPORT DOXIE,data_services;

File := Score_Logs.Files_index.File_nonFCRA_Intermediate1;
												
EXPORT Key_ScoreLogs_XMLIntermediatePt1 := INDEX(File, {transaction_id}, {File},
																			data_services.data_location.prefix() + 'thor_data400::key::acclogs_scoring::'+doxie.Version_SuperKey+'::xml_intermediatept1');
