IMPORT DOXIE;


File := Score_Logs.Files_index.File_nonFCRA_Intermediate6;

EXPORT Key_ScoreLogs_XMLIntermediatePt6 := INDEX(File, {transaction_id}, {File},
																			'~thor_data400::key::acclogs_scoring::'+doxie.Version_SuperKey+'::xml_intermediatept6');
