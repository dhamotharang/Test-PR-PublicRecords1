IMPORT iesp;

EXPORT func_CheckForFdnData(
   dataset(FDN_Services.Layouts.batch_search_rec) ds_input,
   unsigned6 gc_id_in,
   unsigned2 ind_type_in,
   unsigned6 product_code_in,
   dataset(iesp.frauddefensenetwork.t_FDNIndType) ds_excl_ind_types_in = // optional input ds
	         dataset([],iesp.frauddefensenetwork.t_FDNIndType),             
   dataset(iesp.frauddefensenetwork.t_FDNFileType) ds_file_types_in =   // optional input ds
		       dataset([],iesp.frauddefensenetwork.t_FDNFileType) 
   ) := FUNCTION

  // Add sequence # on each input record in case they don't already have one
  FDN_Services.Layouts.batch_search_rec tf_AddSeq(
    FDN_Services.Layouts.batch_search_rec l, integer c) := transform 
		  self.seq := c;
			self     := l;
	end;

	ds_input_seq := project(ds_input,tf_AddSeq(left, counter));
	
  // Use Search_records to get the fdn id key records for the input dataset non-blank field values.
	ds_search_recs_out := FDN_Services.Search_Records(ds_input_seq,
	                                                  gc_id_in,ind_type_in,product_code_in,
																             				ds_excl_ind_types_in,ds_file_types_in);

  // Set shorter alias names to use in the join conditions below.
	string25 ET_ADDRESS := FDN_Services.Constants.Entity_Types.ADDRESS;
	string25 ET_PERSON  := FDN_Services.Constants.Entity_Types.PERSON;
	string25 ET_PHONE   := FDN_Services.Constants.Entity_Types.PHONE;
	string25 ET_SSN     := FDN_Services.Constants.Entity_Types.SSN;
	
  //NOTE: FDN_Services.Layouts.batch_response_rec layout is made up of both the 
	// 		  FDN_Services.Layouts.batch_search_rec & frauddefensenetwork.Layouts_Key.Main
	//      layouts, which both have a did & ssn field on them.
	//      Since only the ones from the FDN_Services.Layouts.batch_search_rec are kept due to the 
	//      self := l below, added 2 fdn_idkey_* fields to preserve the fdn id key rec data.
	FDN_Services.Layouts.batch_response_rec tf_dojoin(FDN_Services.Layouts.batch_search_rec l,
	                                                  FDN_Services.Layouts.raw_rec r) := transform
    // preserve/rename 2 fields from the right fdn id key due to field name duplication
    self.fdn_idkey_ssn := r.ssn;
    self.fdn_idkey_did := r.did;
		self               := l; // input ds fields
		self               := r; // fdn id key record fields
	end;

  // Join the input dataset to the search_recs output ds, joining on seq#/acctno to only return 
	// input records that had data found in the fdn keys.
	// Also filter to only include records where the input "search by" field type corresponds 
	// to the appropriate fdn id key entity_type field data value.
  ds_results := join(ds_input_seq, ds_search_recs_out,
	                   left.seq = (integer) right.acctno
										 // v--- additional "entity_type" filtering added on 09/25/15 for bug 186612
										 and
										 (
										  (left.prim_name != '' 
											                and right.classification_entity.entity_type = ET_ADDRESS) or
											(left.did != 0  and right.classification_entity.entity_type = ET_PERSON)  or
											(left.phone10 != '' and right.classification_entity.entity_type = ET_PHONE) or
											(left.ssn != ''     and right.classification_entity.entity_type = ET_SSN)
										 )
										 , tf_dojoin(left,right));	

											 
  //Debugging outputs
  //output(ds_input,           named('ds_input'));
  //output(ds_input_seq,       named('ds_input_seq'));
  //output(ds_search_recs_out, named('ds_search_recs_out'));
  //output(ds_results,         named('ds_results'));

  RETURN ds_results;
END;
