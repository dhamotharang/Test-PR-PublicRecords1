export QA_Key_Pull := function

//cng 20070416 - dataland W20070418-163126 - stats and qa pull added as seperate BWR b/c of issues with STRATA stat naming convention

//#workunit('name','Official Records New Key List and Stats');

new_file_document := distribute(dataset('~thor_200::base::official_records_document', official_records.Layout_Moxie_Document, flat),hash32(official_record_key));
old_file_document := distribute(dataset('~thor_200::base::official_records_document_father', official_records.Layout_Moxie_Document, flat),hash32(official_record_key));
new_file_party := distribute(dataset('~thor_200::base::official_records_party', official_records.Layout_Moxie_Party, flat),hash32(official_record_key));
old_file_party := distribute(dataset('~thor_200::base::official_records_party_father', official_records.Layout_Moxie_Party, flat),hash32(official_record_key));

//DF-28176 dedup on official_record_key to avoid many to many join 
old_file_document_dedup := dedup(sort(old_file_document,official_record_key,local),official_record_key,local); 
old_file_party_dedup := dedup(sort(old_file_party,official_record_key,local),official_record_key,local); 

new_keys_layout :=
record
    string9		record_source;
	string2		state_origin;
	string30	county_name;
	string60	official_record_key;
end;

new_keys_layout join_files_doc(official_records.Layout_Moxie_Document l, official_records.Layout_Moxie_Document r) :=
	transform
		self.record_source := 'DOCUMENT';
		self := l;
	end;

new_document_keys := join(new_file_document, old_file_document_dedup, left.official_record_key = right.official_record_key,
							join_files_doc(left, right), left only, local) : persist('~thor_200::persist::official_records_document_qa_keys');

new_keys_layout join_files_par(official_records.Layout_Moxie_Party l, official_records.Layout_Moxie_Party r) :=
	transform
		self.record_source := 'PARTY';
		self := l;
	end;
							
new_party_keys := join(new_file_party, old_file_party_dedup, left.official_record_key = right.official_record_key,
							join_files_par(left, right), left only, local) : persist('~thor_200::persist::official_records_party_qa_keys');

keyout := output(choosesets(new_document_keys, 
							state_origin = 'CA' and county_name = 'EL DORADO' => 25,
							state_origin = 'CA' and county_name = 'RIVERSIDE' => 25,
							state_origin = 'FL' and county_name = 'ALACHUA' => 25,
							state_origin = 'FL' and county_name = 'BAKER' => 25,
							state_origin = 'FL' and county_name = 'BREVARD' => 25,
							state_origin = 'FL' and county_name = 'BROWARD' => 25,
							state_origin = 'FL' and county_name = 'CHARLOTTE' => 25,
							state_origin = 'FL' and county_name = 'CITRUS' => 25,
							state_origin = 'FL' and county_name = 'FLAGLER' => 25,
							state_origin = 'FL' and county_name = 'HERNANDO' => 25,
							state_origin = 'FL' and county_name = 'HILLSBOROUGH' => 25,
							state_origin = 'FL' and county_name = 'INDIAN RIVER' => 25,
							state_origin = 'FL' and county_name = 'LAKE' => 25,
							state_origin = 'FL' and county_name = 'MARION' => 25,
							state_origin = 'FL' and county_name = 'MARTIN' => 25,
							state_origin = 'FL' and county_name = 'MIAMI-DADE' => 25,
							state_origin = 'FL' and county_name = 'MONROE' => 25,
							state_origin = 'FL' and county_name = 'ORANGE' => 25,
							state_origin = 'FL' and county_name = 'POLK' => 25,
							state_origin = 'FL' and county_name = 'SARASOTA' => 25,
							state_origin = 'FL' and county_name = 'ST LUCIE' => 25,
							state_origin = 'FL' and county_name = 'VOLUSIA' => 25) +
		choosesets(new_party_keys, 
							state_origin = 'CA' and county_name = 'EL DORADO' => 25,
							state_origin = 'CA' and county_name = 'RIVERSIDE' => 25,
							state_origin = 'FL' and county_name = 'ALACHUA' => 25,
							state_origin = 'FL' and county_name = 'BAKER' => 25,
							state_origin = 'FL' and county_name = 'BREVARD' => 25,
							state_origin = 'FL' and county_name = 'BROWARD' => 25,
							state_origin = 'FL' and county_name = 'CHARLOTTE' => 25,
							state_origin = 'FL' and county_name = 'CITRUS' => 25,
							state_origin = 'FL' and county_name = 'FLAGLER' => 25,
							state_origin = 'FL' and county_name = 'HERNANDO' => 25,
							state_origin = 'FL' and county_name = 'HILLSBOROUGH' => 25,
							state_origin = 'FL' and county_name = 'INDIAN RIVER' => 25,
							state_origin = 'FL' and county_name = 'LAKE' => 25,
							state_origin = 'FL' and county_name = 'MARION' => 25,
							state_origin = 'FL' and county_name = 'MARTIN' => 25,
							state_origin = 'FL' and county_name = 'MIAMI-DADE' => 25,
							state_origin = 'FL' and county_name = 'MONROE' => 25,
							state_origin = 'FL' and county_name = 'ORANGE' => 25,
							state_origin = 'FL' and county_name = 'POLK' => 25,
							state_origin = 'FL' and county_name = 'SARASOTA' => 25,
							state_origin = 'FL' and county_name = 'ST LUCIE' => 25,
							state_origin = 'FL' and county_name = 'VOLUSIA' => 25), all,named('QA_Samples')) ;
							
offstats := parallel(official_records.official_records_document_stats, official_records.official_records_party_stats);

offmail := FileServices.SendEmail('Prasanna.Kolli@lexisnexis.com; Sudhir.Kasavajjala@lexisnexis.com','Official Records - QA Key Pull and Stats - V'+official_records.Version_Development, 
						'Official Records Document Stats, Party Stats, and New Key Update list are now available\r\nPlease view Production WU-ID: ' + Thorlib.WUID( ));
return sequential(keyout,offstats,offmail);
end;
//tested WU dataland W20070418-180305 production W20070418-185043