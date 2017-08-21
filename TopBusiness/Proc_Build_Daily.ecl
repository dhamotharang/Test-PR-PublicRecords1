//
// This is the main procedure for building the daily delta BIP master files.
//
import TopBusiness_External;

export Proc_Build_Daily(
	string version) := function

	// Get the unlinked data
	unlinked_data := Daily_AsMasters;
	
	// Determine the delta from the last QA run
	incremental_linking := join(
		distribute(project(TopBusiness.Files().Linking.Linked.QA,TopBusiness.Layout_Linking.Unlinked),hash64(source,source_docid,source_party,date_last_seen)),
		distribute(unlinked_data.As_Linking_Master,hash64(source,source_docid,source_party,date_last_seen)),
		left.source = right.source and
		left.source_docid = right.source_docid and
		left.source_party = right.source_party and
		left.date_last_seen = right.date_last_seen,
		transform(right),
		right only,
		local);

	// Externally BID all the incremental linking data
	TopBusiness_External.MAC_External_BID(
		 incremental_linking
		,incremental_linking_out
		,bid
		,''
		,source
		,source_docid
		,source_party
		,company_name
		,zip
		,prim_name
		,prim_range
		,fein
		,phone
		,false
	);
	
	incremental_linking_projected := project(incremental_linking_out,
		transform(TopBusiness.Layout_Linking.Linked,
			self := left,
			self := [])) : independent;

	// Create linked files
	linked_data := Function_Link_Masters(
		unlinked_data,
		incremental_linking_projected);
	
	// Write out the linked master files
	build_linked := Proc_Build_Daily_Files_Linked(linked_data,version);
	
	// Build the search keys
	build_keys := Proc_Build_Daily_Keys(version);
	
	// Do it all in a row
	tasks := sequential(
		Create_Daily_Supers,
		build_linked,
		build_keys,
		parallel(
			PromoteDaily().Buildfiles.Built2QA,
			PromoteDaily().Keyfiles.Built2QA),
		fileservices.sendemail(
			'george.lheureux@lexisnexis.com;donald.lingle@lexisnexis.com',
			'BIP Daily Build ' + version + ' Completed',
			'The daily BIP build has successfully completed. Workunit: ' + workunit));
	
	return tasks;

end;
