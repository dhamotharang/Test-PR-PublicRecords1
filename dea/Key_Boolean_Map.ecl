import dea,text_search, data_services;
	
	// Flat record format - from convert function
	Text_dea_flat := record(Text_Search.Layout_Docseg)
		typeof(dea.File_DEA.dea_registration_number) dea_registration_number;
		
	end;

	// Key layout
	string_rec := record
		Text_dea_flat.DocRef;
		Text_dea_flat.dea_registration_number;
		//unsigned8 __filepos{virtual (fileposition)};
	end;

	// Empty dataset for reading purposes
	read_ret := dataset([],string_rec);
	// read the persist during boolean build to build the key
	ret := dataset('~thor_data400::persist::dea::boolean',text_dea_flat,thor);


	proj_map := project(ret,transform(string_rec,self.src := left.DocRef.src;
								 self.doc := left.DocRef.doc;
								 self := left));

	dist_map := distribute(proj_map,hash(doc));
	sort_map := sort(dist_map,src,doc,local);
	tmsid_map := dedup(sort_map,src,doc,local);
	
	// check if the persist file exists, if it does do the boolean build, if not read the key.
	export Key_Boolean_Map := index(if(fileservices.fileexists('~thor_data400::persist::dea::boolean'), tmsid_map, read_ret),
	                                {src,doc},
	                                {dea_registration_number},
	                                data_services.data_location.prefix() + 'thor_data400::key::dea::qa::docref.regnumber');
														