IMPORT DOXIE,data_services;

File := Score_Logs.Files_index.File_FCRA_Intermediate4;

EXPORT Key_FCRA_ScoreLogs_XMLIntermediatePt4 := INDEX(File, {transaction_id}, {File},
																			data_services.data_location.prefix() + 'thor_data400::key::acclogs_scoring::FCRA::'+doxie.Version_SuperKey+'::xml_intermediatept4');
