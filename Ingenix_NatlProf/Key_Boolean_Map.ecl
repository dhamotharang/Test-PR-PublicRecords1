Import Data_Services, Ingenix_NatlProf,text_search;
	
	// Flat record format - from convert function
	Text_Ingenix_flat := record(Text_Search.Layout_Docseg)
		typeof(Ingenix_natlprof.Basefile_Sanctions.sanc_id) sanc_id;
		
	end;

	// Key layout
	string_rec := record
		Text_Ingenix_flat.DocRef;
		Text_Ingenix_flat.sanc_id;
		//unsigned8 __filepos{virtual (fileposition)};
	end;

	// Empty dataset for reading purposes
	read_ret := dataset([],string_rec);
	// read the persist during boolean build to build the key
	ret := dataset(Data_Services.Data_location.Prefix('NONAMEGIVEN')+'thor_data400::persist::Ingenix::sanctions::boolean',text_Ingenix_flat,thor);


	proj_map := project(ret,transform(string_rec,self.src := left.DocRef.src;
								 self.doc := left.DocRef.doc;
								 self := left));
//distribute, sort, dedup - elimiate duplicates in some keys
	dist_map := distribute(proj_map,hash(src,doc,sanc_id));
	sort_map := sort(dist_map,src,doc,local);
	tmsid_map := dedup(sort_map,src,doc,local);
// check if the persist file exists, if it does do the boolean build, if not read the key.
export Key_Boolean_Map := index(if(NOTHOR(fileservices.fileexists(Data_Services.Data_location.Prefix('NONAMEGIVEN')+'thor_data400::persist::Ingenix::sanctions::boolean')),
																		tmsid_map,read_ret),{src,doc},{sanc_id},Data_Services.Data_location.Prefix('NONAMEGIVEN')+'thor_data400::key::Ingenix::qa::docref.sancid');
														