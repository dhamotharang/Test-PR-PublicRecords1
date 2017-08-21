import data_services;

Transaction_rec :=RECORD
string transaction_id;
string datetime; 
END;

File_transaction := dataset(data_services.foreign_FCRA_logs +'thor10_231::in::first_purge_transaction_id_removal',transaction_rec,csv(heading(single),quote('"'), separator(','), terminator(['\r\n', '\n'])));
EXPORT File_TransactionID_Removals := PROJECT(File_transaction,transform({string transaction_id},SELF.transaction_id:=left.transaction_id));
