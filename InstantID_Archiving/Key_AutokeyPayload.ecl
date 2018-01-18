IMPORT doxie, data_services;

pBase := InstantID_Archiving.Files_Base.Delta + InstantID_Archiving.Files_Base_Batch.key_files;
	
	pNewBase := PROJECT(pBase, TRANSFORM({InstantID_Archiving.Layout_Base, unsigned6 did := 0, unsigned6 bdid := 0},
															SELF.bdid := LEFT.transaction_id_key;
															SELF.did :=LEFT.transaction_id_key;
															SELF := LEFT));
	
	newBase := DEDUP(SORT(DISTRIBUTE(pNewBase, transaction_id_key), transaction_id_key, LOCAL), transaction_id_key, LOCAL);
	
	// pBase := DATASET([], {InstantID_Archiving.Layout_Base, unsigned6 did := 0, unsigned6 bdid := 0});

EXPORT Key_AutokeyPayload := INDEX(newBase, {transaction_id_key}, {newBase}, 
																			data_services.data_location.prefix() + 'thor_data400::key::instantid_archiving::' + doxie.Version_SuperKey + '::autokey_payload');