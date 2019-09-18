import standard, ut, doxie, inquiry_acclogs; 

export file_SearchAutokey := FUNCTION

//***** Date cut off for keys

	td := ut.getdate;

	ytd := (string)((unsigned)td[1..4] - 2);

	MinDate := ytd+td[5..8];

base_files := project(accurint_acclogs.File_AccLogs_Base, accurint_acclogs.Layout_AccLogs_Base.main);
													// ((unsigned)orig_login_history_id > 0 or stringlib.stringtouppercase(orig_function_name) = 'DECONCOMPREPORT' or orig_source_code = '3');
tran_files := dedup(sort(accurint_acclogs.File_AccLogs_transactions, hash_key, orig_transaction_id, -length(orig_dateadded)), hash_key, orig_transaction_id);

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
				left.hash_key = right.hash_key, mftra(left, right), local), record, all, Local)(orig_dateadded[1..8] >= MinDate);

Deconfliction := table(accurint_acclogs.File_Deconfliction.Input, {orig_transaction_id := related_transaction_id, permissions , deconfliction_type},related_transaction_id,permissions , deconfliction_type);

jnDeconfliction := join(jnRec, Deconfliction, left.orig_transaction_id = right.orig_transaction_id, 
								transform(accurint_acclogs.Layout_Autokey, 
													self.permissions := right.permissions, 
													self.deconfliction_type := stringlib.stringtouppercase(right.deconfliction_type),
													self := left),left outer);

jnRecFilt := jnDeconfliction(orig_unique_id + orig_ein + orig_charter_nbr + orig_ucc_nbr + orig_did + orig_domain + orig_dl +  
										title + fname + mname + lname + name_suffix + cname + prim_range + predir + prim_name + addr_suffix + postdir + unit_desig + 
										sec_range + p_city_name + v_city_name + st + zip + zip4 + phone + ssn + dob <> '');

accurint_acclogs.macCreateDummies(jnRecFilt, outfile)

persistOutfile := outfile : persist('~accurint_acclogs::file_search');

return persistOutfile;
end;
