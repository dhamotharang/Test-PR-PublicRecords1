IMPORT DOXIE;

File := Score_Logs.Files_index.File_TransactionID; 

File_FCRA := File(StringLib.StringToUpperCase(product) IN Score_Logs.FCRA_Transaction_Constants.product
and transaction_id not in set(Score_Logs.File_TransactionID_Removals,transaction_id));
EXPORT Key_FCRA_ScoreLogs_XMLTransactionID := INDEX(File_FCRA, {transaction_id}, {File_FCRA},
																			'~thor_data400::key::acclogs_scoring::FCRA::'+doxie.Version_SuperKey+'::xml_transactionid');