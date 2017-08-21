import ut;
export File_Qsent_Master := module

	export file_20051231 := dataset('~thor_data400::in::qsent::20051231::master',Layout_Qsent_Master, CSV(HEADING(0), SEPARATOR(['\t']), TERMINATOR(['\r\n', '\n'])));
	
	export file_20060604 := dataset('~thor_data400::in::qsent::20060604::master',Layout_Qsent_Master, CSV(HEADING(0), SEPARATOR(['\t']), TERMINATOR(['\r\n', '\n'])));
	
	export file_20060622 := dataset('~thor_data400::in::qsent::20060622::master',Layout_Qsent_Master, CSV(HEADING(0), SEPARATOR(['\t']), TERMINATOR(['\r\n', '\n'])));
	
	export file_20060804 := dataset('~thor_data400::in::qsent::20060804::master',Layout_Qsent_Master, CSV(HEADING(0), SEPARATOR(['\t']), TERMINATOR(['\r\n', '\n'])));


	prfile_20051231 := project(file_20051231, transform({string8 file_date, Layout_Qsent_Master, string hkey_20051231 := '', string hkey_20060604 := '', string hkey_20060622 := '', string hkey_20060804 := ''},
															self.file_date := '20051231';
															self.hkey_20051231 := left.hash_key;
															self := left));

	prfile_20060604 := project(file_20060604, transform({string8 file_date, Layout_Qsent_Master, string hkey_20051231 := '', string hkey_20060604 := '', string hkey_20060622 := '', string hkey_20060804 := ''},
															self.file_date := '20060604';
															self.hkey_20060604 := left.hash_key;
															self := left));

	prfile_20060622 := project(file_20060622, transform({string8 file_date, Layout_Qsent_Master, string hkey_20051231 := '', string hkey_20060604 := '', string hkey_20060622 := '', string hkey_20060804 := ''},
															self.file_date := '20060622';
															self.hkey_20060622 := left.hash_key;
															self := left));

	prfile_20060804 := project(file_20060804, transform({string8 file_date, Layout_Qsent_Master, string hkey_20051231 := '', string hkey_20060604 := '', string hkey_20060622 := '', string hkey_20060804 := ''},
															self.file_date := '20060804';
															self.hkey_20060804 := left.hash_key;
															self := left));
															
	recordof(prfile_20060804) jnFiles(recordof(prfile_20051231) le, recordof(prfile_20051231) ri) := transform
		
		fnAssignHashKey(string prev_hash_key, string hkey_20051231, string hkey_20060604, string hkey_20060622, string hkey_20060804) := function
			outkey := map(prev_hash_key = hkey_20051231 => hkey_20051231,
								prev_hash_key = hkey_20060604 => hkey_20060604,
								prev_hash_key = hkey_20060622 => hkey_20060622,
								prev_hash_key = hkey_20060804 => hkey_20060804,'');
			outdt := map(prev_hash_key = hkey_20051231 => '20051231',
								prev_hash_key = hkey_20060604 => '20060604',
								prev_hash_key = hkey_20060622 => '20060622',
								prev_hash_key = hkey_20060804 => '20060804','');
			return outdt+outkey; end;
	
	self.hkey_20051231 :=	fnAssignHashKey(le.prev_hash_key, le.hkey_20051231, le.hkey_20060604, le.hkey_20060622, le.hkey_20060804);
	self.hkey_20060604 :=	fnAssignHashKey(le.prev_hash_key, le.hkey_20051231, le.hkey_20060604, le.hkey_20060622, le.hkey_20060804);
	self.hkey_20060622 :=	fnAssignHashKey(le.prev_hash_key, le.hkey_20051231, le.hkey_20060604, le.hkey_20060622, le.hkey_20060804);
	self.hkey_20060804 :=	fnAssignHashKey(le.prev_hash_key, le.hkey_20051231, le.hkey_20060604, le.hkey_20060622, le.hkey_20060804);
	self := le;
	end;
	
	dstrPrev := distribute((prfile_20051231 + prfile_20060604 + prfile_20060622 + prfile_20060804)(prev_hash_key <> ''), hash(prev_hash_key))  +
				distribute((prfile_20051231 + prfile_20060604 + prfile_20060622 + prfile_20060804)(prev_hash_key = ''), random());
				
	dstrHash := distribute(prfile_20051231 + prfile_20060604 + prfile_20060622 + prfile_20060804, hash(hash_key));
	
	AssignHashes := dedup(sort(join(dstrPrev, dstrHash,
											left.prev_hash_key = right.hash_key,
											left outer, local), record, local), record, local);
															
	recordof(prfile_20060804) rlupFiles(recordof(prfile_20060804) le, recordof(prfile_20060804) ri) := transform
		self.hkey_20051231 := if(le.hkey_20051231 = '', ri.hkey_20051231, le.hkey_20051231);
		self.hkey_20060604 := if(le.hkey_20060604 = '', ri.hkey_20060604, le.hkey_20060604);
		self.hkey_20060622 := if(le.hkey_20060622 = '', ri.hkey_20060622, le.hkey_20060622);
		self.hkey_20060804 := if(le.hkey_20060804 = '', ri.hkey_20060804, le.hkey_20060804);
		self := le;
	end;
	
	export jnMasters :=	sort(rollup(AssignHashes, rlupFiles(left, right), record, except hkey_20051231, hkey_20060604, hkey_20060622, hkey_20060804), record) : persist('~thor_data400::persist::qsent::masterjn');
	
end;
