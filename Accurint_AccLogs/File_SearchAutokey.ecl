import standard, ut, doxie; 

export file_SearchAutokey := FUNCTION

base_files := project(accurint_acclogs.File_AccLogs_Base, accurint_acclogs.Layout_AccLogs_Base.main)((unsigned)orig_login_history_id > 0);
tran_files := accurint_acclogs.File_AccLogs_transactions;

//***** Add Original Transaction Information

accurint_acclogs.Layout_Autokey mftra(base_files l, tran_files r) := transform
	self.orig_transaction_id := r.orig_transaction_id;
	self.orig_dateadded := r.orig_dateadded;
	self.record_id := hash64(r.orig_transaction_id);
	self := l;
end;

jnRec := dedup(join(
				distribute(base_files, hash(hash_key)), 
				distribute(tran_files, hash(hash_key)), 
				left.hash_key = right.hash_key, mftra(left, right), local), record, all) : persist('~acc_logs::autokeyds'); // add local 

return jnRec;
end;
