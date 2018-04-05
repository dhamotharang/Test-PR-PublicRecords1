import data_services;

Transaction_rec :=RECORD
string transaction_id;
string datetime; 
END;

File_transaction := dataset(data_services.foreign_prod + 'thor_data400::in::fcra_transaction_to_purge',transaction_rec,csv(heading(single),quote('"'), separator(','), terminator(['\r\n', '\n'])));
EXPORT File_TransactionID_Removals := PROJECT(File_transaction,transform({string transaction_id},SELF.transaction_id:=left.transaction_id));
