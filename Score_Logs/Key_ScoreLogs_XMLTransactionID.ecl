IMPORT DOXIE;

File := Score_Logs.Files_index.File_TransactionID; 

File_nonFCRA := File(StringLib.StringToUpperCase(product) NOT IN Score_Logs.FCRA_Transaction_Constants.product);

EXPORT Key_ScoreLogs_XMLTransactionID := INDEX(File_nonFCRA, {transaction_id}, {File_nonFCRA},
																			'~thor_data400::key::acclogs_scoring::'+doxie.Version_SuperKey+'::xml_transactionid');