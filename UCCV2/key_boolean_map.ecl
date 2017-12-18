import uccv2,text_search,data_services;
	
	// Flat record format - from convert function
	Text_ucc_flat := record(Text_Search.Layout_Docseg)
		typeof(uccv2.File_UCC_Main_Base.tmsid) tmsid;
		typeof(uccv2.File_UCC_Main_Base.rmsid) rmsid;
	end;

	// Key layout
	string_rec := record
		Text_ucc_flat.DocRef;
		Text_ucc_flat.tmsid;
		//unsigned8 __filepos{virtual (fileposition)};
	end;

	// Empty dataset for reading purposes
	read_ret := dataset([],string_rec);
	// read the persist during boolean build to build the key
	ret := dataset(data_services.data_location.prefix() + 'thor_data400::persist::uccv2::boolean',text_ucc_flat,thor);


	proj_map := project(ret,transform(string_rec,self.src := left.DocRef.src;
								 self.doc := left.DocRef.doc;
								 self := left));

	dist_map := distribute(proj_map,hash(doc));
	sort_map := sort(dist_map,src,doc,local);
	tmsid_map := dedup(sort_map,src,doc,local);
// check if the persist file exists, if it does do the boolean build, if not read the key.
export Key_Boolean_Map := index(if(fileservices.fileexists(data_services.data_location.prefix() + 'thor_data400::persist::uccv2::boolean'),
																		tmsid_map,read_ret),{src,doc},{tmsid},data_services.data_location.prefix() + 'thor_data400::key::uccv2::qa::docref.tmsid');
														