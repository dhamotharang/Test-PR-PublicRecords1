Import Data_Services, vehiclev2,text_search;
	
	// Flat record format - from convert function
	Text_vehicle_flat := record(Text_Search.Layout_Docseg)
		typeof(vehiclev2.file_vehicleV2_party.vehicle_key) vehicle_key;
		typeof(vehiclev2.file_vehicleV2_party.Iteration_key) Iteration_key;
		typeof(vehiclev2.file_vehicleV2_party.sequence_key) sequence_key;
	end;

	// Key layout
	string_rec := record
		Text_vehicle_flat.DocRef;
		Text_vehicle_flat.vehicle_key;
		Text_vehicle_flat.iteration_key;
		Text_vehicle_flat.sequence_key;
		//unsigned8 __filepos{virtual (fileposition)};
	end;

	// Empty dataset for reading purposes
	read_ret := dataset([],string_rec);
	// read the persist during boolean build to build the key
	ret := dataset(Data_Services.Data_location.Prefix('NONAMEGIVEN')+'thor_data400::persist::vehiclev2::boolean',text_vehicle_flat,thor);


	proj_map := project(ret,transform(string_rec,self.src := left.DocRef.src;
								 self.doc := left.DocRef.doc;
								 self.Sequence_Key := trim(left.Sequence_Key,left,right);
								 self := left));

	dist_map := distribute(proj_map,hash(doc));
	sort_map := sort(dist_map,src,doc,local);
	tmsid_map := dedup(sort_map,src,doc,local);
// check if the persist file exists, if it does do the boolean build, if not read the key.
export Key_Boolean_Map := index(if(nothor(fileservices.fileexists(Data_Services.Data_location.Prefix('NONAMEGIVEN')+'thor_data400::persist::vehiclev2::boolean')),
																		tmsid_map,read_ret),{src,doc},{vehicle_key,iteration_key,sequence_key},Data_Services.Data_location.Prefix('NONAMEGIVEN')+'thor_data400::key::vehiclev2::qa::docref.vehkey');
														