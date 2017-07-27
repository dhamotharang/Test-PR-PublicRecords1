import ut;


ds_testseed := seed_files.File_identityreport;
ds_slim := project (ds_testseed, layout_identityreport.rec_in_slim);

newrec := record
	// string20 dataset_name := ds_testseed.TABLE_NAME;
	data16 hashvalue := Hash_InstantID (trim (ds_slim.firstname), trim (ds_slim.lastname), trim (ds_slim.ssn),
                                      '', trim (ds_slim.zip5), trim (ds_slim.phone), '');
	ds_slim;
end;

newtable := TABLE (ds_slim, newrec);

export key_identityreport := INDEX (newtable, {hashvalue}, {newtable},
														'~thor_data400::key::testseed::qa::identityreport');