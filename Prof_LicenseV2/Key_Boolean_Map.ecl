Import Data_Services, Prof_Licensev2,text_search;
	
	// Flat record format - from convert function
	string_rec := record
		text_search.Layout_DocSeg.DocRef;
	//unsigned8 __filepos{virtual (fileposition)};
	end;

	// Empty dataset for reading purposes
	read_ret := dataset([],string_rec);
	// read the persist during boolean build to build the key
	ret := dataset(Data_Services.Data_location.Prefix('NONAMEGIVEN')+'thor_data400::persist::prolic::boolean',text_search.Layout_DocSeg,thor);


	proj_map := project(ret,transform(string_rec,self.src := left.DocRef.src;
								 self.doc := left.DocRef.doc;
								 self := left));

	dist_map := distribute(proj_map,hash(doc));
	sort_map := sort(dist_map,src,doc,local);
	tmsid_map := dedup(sort_map,src,doc,local);
// check if the persist file exists, if it does do the boolean build, if not read the key.
export Key_Boolean_Map := index(if(nothor(fileservices.fileexists(Data_Services.Data_location.Prefix('NONAMEGIVEN')+'thor_data400::persist::prolic::boolean')),
																		tmsid_map,read_ret),{src},{doc},Data_Services.Data_location.Prefix('NONAMEGIVEN')+'thor_data400::key::prolic::qa::docref.seq');
														