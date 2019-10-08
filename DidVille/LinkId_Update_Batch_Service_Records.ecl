import doxie, dx_Header;

export LinkId_Update_Batch_Service_Records(
	dataset(LinkId_Update_Batch_Service_Layouts.input_layout) in_data
	) := function
	
	// Input record plus a sequence number for uniqueness
	sequenced_input_layout := record
		unsigned seq;
		LinkId_Update_Batch_Service_Layouts.input_layout;
	end;
		
	// Apply a sequence number to every record in order to keep them unique even if acctno isn't.
	sequenced_data := project(in_data,transform(sequenced_input_layout,
		self.seq := counter,
		self := left));
	
	// Output record plus a sequence number for uniqueness
	sequenced_output_layout := record
		unsigned seq;
		LinkId_Update_Batch_Service_Layouts.output_layout;
	end;
		
	// Join to the DID update key
	updated_data := join(sequenced_data,dx_header.Key_Did_Rid(),
										keyed((unsigned)left.did = right.rid),
										transform(sequenced_output_layout,
											self.current_did := intformat(if(right.stable or right.did = 0,right.did,(unsigned)left.did),12,1),
											self := left),
										left outer,
										keep(1));
	
	// Join to the DID split key, The result is not transformed to output layout because 
	// it will be filtered by rid later.
	updatedSplit_data := join(sequenced_data,dx_header.key_did_rid_split(),
													keyed((unsigned)left.did = right.rid), 
													transform({sequenced_data, unsigned6 rid}, 
														self.rid := right.did, self := left),
													left outer);
	
	// Join to the Did update key only the records that did not find splits.
	updatedNoSplit_data := join(updatedSplit_data(rid=0), dx_header.Key_Did_Rid(),
													keyed((unsigned)left.did = right.rid),
													transform(sequenced_output_layout,
														self.current_did := intformat(if(right.stable or right.did = 0,right.did,(unsigned)left.did),12,1),
														self := left),
													left outer,
													keep(1));
		
	boolean trackSplit := false : stored('TrackSplit');
	
	// consolidate splits and DIDs that were not split.
	split_data := sort(updatedNoSplit_data + 										
								project(updatedSplit_data(rid<>0),
										transform(sequenced_output_layout,
												self.current_did := intformat((unsigned)left.rid,12,1);
												self := left)), seq);
		
	return if(TrackSplit, split_data,
									updated_data);
	
end;
