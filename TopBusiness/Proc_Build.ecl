//
// This is the main procedure for building the BIP master files.
//
import TopBusiness_Search as TBS,TopBusiness_External as TBE;

export Proc_Build(
	string version,
	boolean build_linking_from_scratch = false,
	boolean perform_purging_build = false) := function

	// Get the unlinked data
	unlinked_data := All_AsMasters;
	
	// Create linkage files
	linkage_data := Function_Linking(
		unlinked_data.As_Linking_Master,
		if(not build_linking_from_scratch,
			Files().Linking.Linked.QA),
		perform_purging_build);
	
	// Write out the linkage files
	build_linkage := Proc_Build_Files_Linkage(linkage_data,version);
	
	// Create linked files
	linked_data := Function_Link_Masters(
		unlinked_data,
		Files(version).Linking.Linked.Built,
		if(not build_linking_from_scratch,
			Files().LLID12.Linked.QA),
		if(not build_linking_from_scratch,
			Files().LLID9.Linked.QA));
	
	// Write out the linked master files
	build_linked := Proc_Build_Files_Linked(linked_data,version);
	
	// Build the search keys
	build_keys := Proc_Build_Keys(version);
	
	// Do it all in a row
	tasks := sequential(
		Create_Supers,
		build_linkage,
		build_linked,
		build_keys,
		parallel(
			Proc_Build_Statistics(Files(version).Linking.Linked.Built),
			Proc_Output_Diagnostics(Files(version).Linking.Linked.Built)),
		parallel(
			Promote().Buildfiles.Built2QA,
			TBE.Promote().Buildfiles.Built2QA,
			Promote().Keyfiles.Built2QA,
			TBE.Promote().Keyfiles.Built2QA,
			TBS.Promote().Keyfiles.Built2QA),
		fileservices.sendemail(
			'george.lheureux@lexisnexis.com;donald.lingle@lexisnexis.com',
			'BIP Linking Build ' + version + ' Completed',
			'The linking build has successfully completed. Workunit: ' + workunit));
	
	return tasks;

end;
