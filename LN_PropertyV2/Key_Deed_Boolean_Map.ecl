import LN_Propertyv2,text_search,Data_Services;
	
	// Flat record format - from convert function
	Text_assess_flat := record(Text_Search.Layout_Docseg)
		typeof(LN_Propertyv2.File_Deed.ln_fares_id) ln_fares_id;
	end;

	// Key layout
	string_rec := record
		Text_assess_flat.DocRef;
		Text_assess_flat.ln_fares_id;
		//unsigned8 __filepos{virtual (fileposition)};
	end;

	// Empty dataset for reading purposes
	read_ret := dataset([],string_rec);
	// read the persist during boolean build to build the key
	ret := dataset('~thor_data400::persist::ln_propertyv2::deeds::boolean',text_assess_flat,thor);


	proj_map := project(ret,transform(string_rec,self.src := left.DocRef.src;
								 self.doc := left.DocRef.doc;
								 self := left));

	dist_map := distribute(proj_map,hash(doc));
	sort_map := sort(dist_map,src,doc,local);
	tmsid_map := dedup(sort_map,src,doc,local);
// check if the persist file exists, if it does do the boolean build, if not read the key.
export Key_Deed_Boolean_Map := index(if(fileservices.fileexists('~thor_data400::persist::ln_propertyv2::deeds::boolean'),
																		tmsid_map,read_ret),{src,doc},{ln_fares_id},Data_Services.Data_location.Prefix('Property')+'thor_data400::key::ln_propertyv2::deeds::qa::doc.fares_id');
														