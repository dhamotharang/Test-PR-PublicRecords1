IMPORT DOXIE;


File := Score_Logs.Files_index.File_FCRA_Intermediate6;

EXPORT Key_FCRA_ScoreLogs_XMLIntermediatePt6 := INDEX(File, {transaction_id}, {File},
																			'~thor_data400::key::acclogs_scoring::FCRA::'+doxie.Version_SuperKey+'::xml_intermediatept6');
