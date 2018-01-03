import Driversv2,Text_Search, data_services;

	// Key layout
	string_rec := record
		text_search.layout_document.DocRef;
		//unsigned8 __filepos{virtual (fileposition)};
	end;

	// Empty dataset for reading purposes
	read_ret := dataset([],string_rec);
	// read the persist during boolean build to build the key
	ret := dataset('~thor_data400::persist::dlv2::boolean',Text_Search.Layout_DocSeg,thor);


	proj_map := project(ret,transform(string_rec,self.src := left.DocRef.src;
								 self.doc := left.DocRef.doc;
								 self := left));

	dist_map := distribute(proj_map,hash(doc));
	sort_map := sort(dist_map,src,doc,local);
	tmsid_map := dedup(sort_map,src,doc,local);

// check if the persist file exists, if it does do the boolean build, if not read the key.
export Key_Boolean_Map :=  index(if(fileservices.fileexists('~thor_data400::persist::dlv2::boolean'),
																		tmsid_map, read_ret),
															  {src,doc},
															  data_services.data_location.prefix() + 'thor_data400::key::dlv2::qa::docref.dlseq');