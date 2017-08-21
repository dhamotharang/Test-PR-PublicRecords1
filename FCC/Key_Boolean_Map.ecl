Import Data_Services, fcc,text_search;
	
	// Empty dataset for reading purposes
	read_ret := dataset([],Text_Search.Layout_Docseg);
	// read the persist during boolean build to build the key
	ret := dataset(Data_Services.Data_location.Prefix('NONAMEGIVEN')+'thor_data400::persist::fcc::boolean',Text_Search.Layout_Docseg,thor);


	proj_map := project(ret,transform(Text_Search.Layout_Docseg,self.docref.src := left.DocRef.src;
								 self.docref.doc := left.DocRef.doc;
								 self := left));

	dist_map := distribute(proj_map,hash(docref.doc));
	sort_map := sort(dist_map,docref.src,docref.doc,local);
	tmsid_map := dedup(sort_map,docref.src,docref.doc,local);
// check if the persist file exists, if it does do the boolean build, if not read the key.
export Key_Boolean_Map := index(if(nothor(fileservices.fileexists(Data_Services.Data_location.Prefix('NONAMEGIVEN')+'thor_data400::persist::fcc::boolean')),
																		tmsid_map,read_ret),{docref.src},{docref.doc},Data_Services.Data_location.Prefix('NONAMEGIVEN')+'thor_data400::key::fcc::qa::docref');
														