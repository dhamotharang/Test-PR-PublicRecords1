IMPORT didville, Doxie, Doxie_Raw, header, NID, STD, address;

EXPORT RAN_BestInfo_Batch_Service_Records(DATASET(DidVille.Layout_RAN_BestInfo_BatchIn) f_in_raw = DATASET([],DidVille.Layout_RAN_BestInfo_BatchIn),
                                          boolean CompareInputAddrWithRel = false,
																					boolean CompareInputAddrNameWithRel = false,
																					boolean UseBlankPhoneNumberRecords = false) := FUNCTION

	//get input
	doxie.MAC_Header_Field_Declare()
	doxie.MAC_Selection_Declare()

	boolean exclude_relatives := false	: stored('ExcludeRelatives');
	boolean exclude_associates := false : stored('ExcludeAssociates');
	boolean exclude_input_nbrs := false : stored('ExcludeInputAddrNeighbors');
	boolean exclude_update_nbrs := false : stored('ExcludeUpdateAddrNeighbors');
	boolean suppress_same_address := false : stored('SuppressSameAddress');
	boolean suppress_same_phone := false : stored('SuppressSamePhone');
	boolean dedup_with_same_phone := false : stored('DedupRelativesAssociatesOnPhone');
	unsigned relatives_depth := 2 : stored('RelativesDepth');

	checkRNA := header.constants.checkRNA;
	
	//convert to standard input layout
	in_seq_rec := record
		STRING20 acctno;
		DidVille.Layout_Did_InBatch;
		STRING14 driver_license;
		String10 phoneno_1;
		String10 phoneno_2;
		String10 phoneno_3;
		String10 phoneno_4;
		String10 phoneno_5;
		String10 phoneno_6;
		String10 phoneno_7;
		String10 phoneno_8;
		String10 phoneno_9;
		String10 phoneno_10;
		String10 phoneno_11;
	end;

	in_seq_rec get_seq(f_in_raw l, unsigned cnt) := transform
		self.seq := cnt;
		self.ssn := STD.Str.FilterOut(l.ssn, '-');
		self.phone10 := l.phoneno;
		self.title := '';
		self.fname := l.name_first;
		self.mname := l.name_middle;
		self.lname := l.name_last;
		self.suffix := l.name_suffix;
		self.addr_suffix := l.suffix;
		self.zip4 := l.z4;
		self := l;
	end;

	f_in_seq := project(f_in_raw, get_seq(left, counter));
	f_in_ready := project(f_in_seq, didville.Layout_Did_OutBatch);

	/* Use the data provided by the customer to first find a DID for each record. Exclude any dids
		 whose score is less than 75.
	*/
	//append did to the input subjs
	didville.MAC_DidAppend(f_in_ready, f_with_did_raw, true, 'true');

	f_with_did := project(f_with_did_raw, transform({f_with_did_raw}, self.did:=if(left.score>=75, left.did, 0), self:=left));
	
	/* Get the subject Best Address by did. Join against Watchdog GLB and non-GLB keys. If the 
		 customer has sufficient GLB permissions, retain the records from the Watchdog GLB key. If
		 not, retain those from the non-GLB key.
	*/
	//find nbrs - get subj best address
	subj_best_rec := record
		unsigned4 seq;
		doxie.layout_best;
	end;

	dppaOk := ut.dppa_ok(DPPA_Purpose,checkRNA);
  glbOk := ut.glb_ok(GLB_Purpose,checkRNA);
	
	doxie.mac_best_records(f_with_did,	
												 did,
												 outfile,
												 dppaOk,
												 glbOk,
												 ,
												 doxie.DataRestriction.fixed_DRM,
												 include_dod := true);

	subj_best_rec get_subj_best(f_with_did l, outfile r) := transform
		self.seq := l.seq;
		self.did := l.did;
		self := r;
		self := [];
	end;
	
	f_subj_best := join(f_with_did, outfile,
											left.did = right.did,
										get_subj_best(left, right), left outer, keep(1));	  			   
	
	/* Find Neighbors for the search subject based on the input address (not on the Best address
		 information!). Return the top 3 Neighbors, i.e. closest addresses by distance.
	*/
	//find nbrs - for input address, init 	
	doxie.layout_nbr_targets  get_nbr_in_init(f_with_did l) := transform
		self.seqTarget := l.seq;
		self.zip := l.z5;
		self.suffix := l.addr_suffix;
		self := l;
		self := [];
	end;		
		
	f_in_nbr_init := group(project(f_with_did, get_nbr_in_init(left)));

	//find nbrs - for input address, pick top 3		
	f_in_nbrs_raw := doxie.nbr_records(f_in_nbr_init,
								'C',
								Max_Neighborhoods,
								Neighbors_PerAddress,
								Neighbors_Per_NA,
								Neighbor_Recency,
								industry_class_value,
								GLB_Purpose,
								DPPA_Purpose,
								probation_override_value,
								no_scrub,
								glb_ok,
								dppa_ok,
								ssn_mask_value, false, false);
								
	nbr_with_rank_rec := record
		doxie.layout_nbr_records;
		unsigned nbr_rank;
	end;

	nbr_with_rank_rec get_nbr_in_rank(f_in_nbrs_raw l, unsigned cnt) := transform
		self.nbr_rank := cnt;
		self := l;
	end;

	f_in_nbrs_rank := project(f_in_nbrs_raw, get_nbr_in_rank(left, counter));
	fixed_DRM := doxie.DataRestriction.fixed_DRM;

	/* Append phone numbers to each Neighbor.
	*/
	didville.Mac_RAN_phone_append(f_in_nbrs_rank, f_in_nbrs_app, fixed_DRM,GLB_Purpose, industry_class_value, checkRNA, DPPA_Purpose)

	f_in_nbrs_dep := dedup(sort(f_in_nbrs_app(phone<>''),
															seqTarget, prim_name, prim_range, zip, sec_range, nbr_rank),
						 seqTarget, prim_name, prim_range, zip, sec_range);

	f_in_nbrs_ready := group(sort(f_in_nbrs_dep, seqTarget, nbr_rank),seqTarget);

	f_in_nbrs := TopN(f_in_nbrs_ready, 3, nbr_rank);

	/* Find Neighbors for the search subject based on the Best address information. Return 
		 the top 3 Neighbors, i.e. closest addresses by distance.
	*/
	//find nbrs - for best address, init 	
	doxie.layout_nbr_targets  get_nbr_best_init(f_subj_best l) := transform
		self.seqTarget := l.seq;
		self.dt_last_seen := l.addr_dt_last_seen;
		self := l;
		self := [];
	end;		
			
	f_best_nbr_init := group(project(f_subj_best, get_nbr_best_init(left)));	

	//find nbrs - for best address, pick top 3		
	f_best_nbrs_raw := doxie.nbr_records(f_best_nbr_init,
								'C',
								Max_Neighborhoods,
								Neighbors_PerAddress,
								Neighbors_Per_NA,
								Neighbor_Recency,
								industry_class_value,
								GLB_Purpose,
								DPPA_Purpose,
								probation_override_value,
								no_scrub,
								glb_ok,
								dppa_ok,
								ssn_mask_value, false, false);
															
	nbr_with_rank_rec get_nbr_best_rank(f_best_nbrs_raw l, unsigned cnt) := transform
		self.nbr_rank := cnt;
		self := l;
	end;

	f_best_nbrs_rank := project(f_best_nbrs_raw, get_nbr_best_rank(left, counter));

	/* Append phone numbers to each Neighbor.
	*/
	didville.Mac_RAN_phone_append(f_best_nbrs_rank, f_best_nbrs_app,fixed_DRM,GLB_Purpose, industry_class_value, checkRNA, DPPA_Purpose)

	f_best_nbrs_dep := dedup(sort(f_best_nbrs_app(phone<>''),
																seqTarget, prim_name, prim_range, zip, sec_range, nbr_rank),
							 seqTarget, prim_name, prim_range, zip, sec_range);

	f_best_nbrs_ready := group(sort(f_best_nbrs_dep, seqTarget, nbr_rank),seqTarget);

	f_best_nbrs := TopN(f_best_nbrs_ready, 3, nbr_rank);

	/* Get Relatives and Roommates (Associates). That is, get the identities of everyone who 
		 lives in the same dwelling as the search subject. A Roommate differs from a Relative  
		 only in that a Relative is related in some way to the search subject. Describe a 
		 Relative's relationship to the search subject by his/her relationship title.
	*/
	//get relatives and roomies - init
	doxie_Raw.Layout_RelativeRawBatchInput get_rel(f_with_did l, unsigned cnt) := transform
		self.input.seq := l.seq;
		self.input.did := l.did;
		self.input.glb_purpose := GLB_Purpose;
		self.input.dppa_purpose := DPPA_Purpose;
		self.input.ln_branded_value := true;
		self.input.include_relatives_val := true;
		self.input.include_associates_val := true;
		self.input.relative_depth := relatives_depth;
		self.seq := cnt;
		self := [];
	end;

	f_rel_ready := group(project(f_with_did, get_rel(left, counter)),seq);

  // we'd need just up to 10 relatives and associates each, but it's safer to pre-fetch some more
  // to allow choosing the "best" ten later. 100 is arbitrary number; almost always it will cover
  // all 1st degree relatives (assuming 1st degree is "better" than other degrees by definition)
	f_rel_out_init := sort(group(doxie_raw.relative_raw_batch(f_rel_ready,,100,200)),
												 input.seq, depth, p2_sort, p3_sort, p4_sort);

	//get relatives and roomies - rank as well as translate titleNo to text
	rel_with_rank_rec := record
		doxie_Raw.Layout_RelativeRawBatchInput;
		unsigned4 rel_rank;	
		string40 relationship;
	end;

	rel_with_rank_rec get_rel_rank(f_rel_out_init l, unsigned cnt) := transform
		self.rel_rank := cnt;
		self.relationship := 
					IF( l.titleNo <> 0, STD.Str.CleanSpaces(Header.relative_titles.fn_get_str_title(l.TitleNo) 
							                                    + IF(l.TitleNo = Header.relative_titles.num_associate,' '+Header.translateRelativePrimrange(l.rel_prim_range),'')),
							                IF(l.isRelative = FALSE, STD.Str.CleanSpaces(Header.relative_titles.fn_get_str_title(Header.relative_titles.num_associate) + ' ' + Header.translateRelativePrimrange(l.rel_prim_range)),
																				              Header.relative_titles.fn_get_str_title(Header.relative_titles.num_relative))
					);
		self := l;
		self := [];
	end;

	f_rel_out := project(f_rel_out_init, get_rel_rank(left, counter)); // *** HAS REL_PRIM_RANGE ***

	/* Although we do a better job of identifying relationships among household members--by
		 specifying whether they are a spouse, child, sibling, parent or grandparent 
     --at this point we still use a very 
		 simple rule that requires someone to have the same last name to be considered a Relative.
	*/
	IsRel := f_rel_out.isRelative and f_rel_out.rel_prim_range  <> -1;	//keep out rels by ssn
	IsRoommie := not f_rel_out.isRelative;

	f_rel_for_best := (f_rel_out(IsRel))(person2<>0);

	rel_with_rank_rec get_non_rel(f_rel_out l) := transform
		self := l;
	end;

	f_roommie_for_best := join(f_rel_out(IsRoommie), f_rel_for_best,
														 left.person2 = right.person2, get_non_rel(left), left only)(person2<>0);
	
	/* Pick top ten Relatives. Retrieve Best Address and Phones information for each of them.
	*/
	//get relatives - pick top 10
	doxie.mac_best_records(f_rel_for_best,
													person2,
													f_rel_best,
													ut.dppa_ok(DPPA_Purpose,checkRNA),
													ut.glb_ok(GLB_Purpose,checkRNA),
													,
													doxie.DataRestriction.fixed_DRM,
													include_dod :=true);
													
	f_rel_best_valid := f_rel_best(prim_name <> '' or phone<>'');
	f_rel_best_valid_to_use := if(UseBlankPhoneNumberRecords, f_rel_best(prim_name <> ''), f_rel_best_valid);
	f_rel_best_dep := dedup(sort(f_rel_best_valid_to_use, NID.PreferredFirstNew(fname), lname, prim_name, -sec_range, zip, phone),
															 NID.PreferredFirstNew(fname), lname, prim_name, zip, phone);
																 
	best_with_rank_rec := record
		doxie.layout_best;
		unsigned1 depth;
		unsigned4 rel_rank;
		string40 relationship;
		string15 relationship_type;
		string10 relationship_confidence;
		unsigned4 seqTarget;
	end;

	best_with_rank_rec get_back_rel_rank(f_rel_out l, f_rel_best_dep r) := transform
		self.rel_rank := l.rel_rank;
		self.seqTarget := l.input.seq;
		self.depth := l.depth;
		self.relationship := l.relationship;
		self.relationship_type := l.type;
		self.relationship_confidence := l.confidence;
		self := r;
	end;

	f_rel_best_final_ready := join(f_rel_for_best, f_rel_best_dep,
																 left.person2 = right.did,
																 get_back_rel_rank(left, right), left outer, keep(1))(lname<>'' and prim_name<>'');

	didville.Mac_RAN_phone_append(f_rel_best_final_ready, f_rel_best_final_app_raw,fixed_DRM, GLB_Purpose, industry_class_value, checkRNA, DPPA_Purpose)
	f_rel_best_final_app_flted := f_rel_best_final_app_raw(phone<>'');
	f_rel_best_final_app_to_use := if(UseBlankPhoneNumberRecords, f_rel_best_final_app_raw, f_rel_best_final_app_flted);
	f_rel_best_final_app := if(dedup_with_same_phone, 
														 dedup(sort(f_rel_best_final_app_to_use, seqTarget, phone, rel_rank), seqTarget, phone),
														 f_rel_best_final_app_to_use);

	//check against input address, phones
	best_with_rank_rec check_input(f_rel_best_final_app l) := transform
		self := l;
	end;
				
	f_rel_best_final_addr_ckd := if(suppress_same_address,
																	join(f_rel_best_final_app, f_in_seq,
																			left.seqTarget = right.seq and 
										left.prim_name = right.prim_name and 
										left.prim_range = right.prim_range and
										left.zip = right.z5, 
										check_input(left), left only),
								f_rel_best_final_app);
								
	f_rel_best_final_phone_ckd := if(suppress_same_phone,
																	 join(f_rel_best_final_addr_ckd, f_in_seq,
																				left.seqTarget = right.seq and 
											left.phone in [right.phone10,  right.phoneno_1,
																	right.phoneno_2, right.phoneno_3,
												 right.phoneno_4, right.phoneno_5,
												 right.phoneno_6, right.phoneno_7,
												 right.phoneno_8, right.phoneno_9,
												 right.phoneno_10, right.phoneno_11],
									 check_input(left), left only),
								 f_rel_best_final_addr_ckd);						  
	
	f_rel_best_final_phone_ckd_toUse := if(UseBlankPhoneNumberRecords, f_rel_best_final_phone_ckd, f_rel_best_final_phone_ckd(phone<>''));
	f_rel_best_final_grp := group(sort(f_rel_best_final_phone_ckd_toUse, seqTarget, rel_rank), seqTarget);					

	f_rel_best_final :=	topN(f_rel_best_final_grp, 10, rel_rank);

	/* Pick top ten Roommates. Retrieve Best Address and Phones information for each of them.
	*/
	//get roomies - pick top 10

	doxie.mac_best_records(f_roommie_for_best,
												  person2,
													f_roommie_best,
													ut.dppa_ok(DPPA_Purpose,checkRNA),
													ut.glb_ok(GLB_Purpose,checkRNA),
													,
													doxie.DataRestriction.fixed_DRM,	
													include_dod := true);
													
	f_roommie_best_valid := f_roommie_best(prim_name <> '' or phone<>'');
	f_roommie_best_dep := dedup(sort(f_roommie_best_valid, NID.PreferredFirstNew(fname), lname, prim_name, -sec_range, zip, phone),
								              NID.PreferredFirstNew(fname), lname, prim_name, zip, phone);

	f_roomie_best_final_ready := join(f_roommie_for_best, f_roommie_best_dep,
																		left.person2 = right.did,
																		get_back_rel_rank(left, right), left outer, keep(1))(lname<>'' and prim_name<>'');

	didville.Mac_RAN_phone_append(f_roomie_best_final_ready, f_roomie_best_final_app_raw,fixed_DRM,GLB_Purpose, industry_class_value, checkRNA, DPPA_Purpose)
	f_roomie_best_final_app_flted := f_roomie_best_final_app_raw(phone<>'');
	f_roomie_best_final_app := if(dedup_with_same_phone, 
																dedup(sort(f_roomie_best_final_app_flted, seqTarget, phone, rel_rank), seqTarget, phone),
																f_roomie_best_final_app_flted);
							
	//check against input address, phones
	f_roomie_best_final_addr_ckd := if(suppress_same_address,
																		 join(f_roomie_best_final_app, f_in_seq,
																					left.seqTarget = right.seq and 
												left.prim_name = right.prim_name and 
												left.prim_range = right.prim_range and
												left.zip = right.z5, 
												check_input(left), left only),
									 f_roomie_best_final_app);
								
	f_roomie_best_final_phone_ckd := if(suppress_same_phone,
																			join(f_roomie_best_final_addr_ckd, f_in_seq,
																					 left.seqTarget = right.seq and 
												 left.phone in [right.phone10,  right.phoneno_1,
																		 right.phoneno_2, right.phoneno_3,
														right.phoneno_4, right.phoneno_5,
														right.phoneno_6, right.phoneno_7,
														right.phoneno_8, right.phoneno_9,
														right.phoneno_10, right.phoneno_11],
									 check_input(left), left only),
										f_roomie_best_final_addr_ckd);						  

	f_roomie_best_final_grp := group(sort(f_roomie_best_final_phone_ckd(phone<>''), seqTarget, rel_rank), seqTarget);					

	f_roomie_best_final :=	topN(f_roomie_best_final_grp, 10, rel_rank);
									
	//generate output - initialize 
	out_with_seq_rec := record
		unsigned4 seq;
		didville.Layout_RAN_BestInfo_BatchIn;
		didville.Layout_RAN_BestInfo_BatchOut;
	  boolean input_addr_matched_rel;
		boolean input_addr_name_matched_rel;
	end;					   

	out_with_seq_rec init_out(f_in_seq l) := transform
		self.phoneno := l.phone10;
		self.name_first := l.fname;
		self.name_middle := l.mname;
		self.name_last := l.lname;
		self.name_suffix := l.suffix;
		self.suffix := l.addr_suffix;
		self.z4 := l.zip4;
		self.RelAssocNeigh_Flag :='N';
		self := l;
		self := [];
	end;

	f_out_init := project(f_in_seq, init_out(left));

	//generate output - get relatives
	out_with_seq_rec get_out_rel(f_out_init l, f_rel_best_final r, unsigned cnt) := transform
		self.rel_depth_1 := if(cnt=1, (string)r.depth, l.rel_depth_1);
		self.rel_first_name_1 := if(cnt=1, r.fname, l.rel_first_name_1);
		self.rel_middle_name_1 := if(cnt=1, r.mname, l.rel_middle_name_1);
		self.rel_last_name_1 := if(cnt=1, r.lname, l.rel_last_name_1);
		self.rel_address_1 := if(cnt=1, address.Addr1FromComponents(r.prim_range, r.predir, r.prim_name,
																																	 r.suffix, r.postdir, r.unit_desig, r.sec_range),
									                  l.rel_address_1);
		self.rel_city_1 := if(cnt=1, r.city_name, l.rel_city_1);
		self.rel_state_1 := if(cnt=1, r.st, l.rel_state_1);
		self.rel_zipcode_1 := if(cnt=1, r.zip + r.zip4, l.rel_zipcode_1);
		self.rel_phone_1 := if(cnt=1, r.phone, l.rel_phone_1);
		
		self.rel_ssn_1   := if(cnt=1, r.ssn, l.rel_ssn_1);
		self.rel_dob_1   := if(cnt=1, if(r.dob=0, '',(string) r.dob),
													        l.rel_dob_1);
		self.rel_dod_1   := if(cnt=1, r.dod, l.rel_dod_1);
		self.rel_relationship_1 := if(cnt=1, r.relationship, l.rel_relationship_1);
		self.rel_relationship_type_1 := if(cnt=1, r.relationship_type, l.rel_relationship_type_1);
		self.rel_relationship_confidence_1 := if(cnt=1, r.relationship_confidence, l.rel_relationship_confidence_1);
		
		self.rel_depth_2 := if(cnt=2, (string)r.depth, l.rel_depth_2);
		self.rel_first_name_2 := if(cnt=2, r.fname, l.rel_first_name_2);
		self.rel_middle_name_2 := if(cnt=2, r.mname, l.rel_middle_name_2);
		self.rel_last_name_2 := if(cnt=2, r.lname, l.rel_last_name_2);
		self.rel_address_2 := if(cnt=2, address.Addr1FromComponents(r.prim_range, r.predir, r.prim_name,
																																	 r.suffix, r.postdir, r.unit_desig, r.sec_range),
									                  l.rel_address_2);
		self.rel_city_2 := if(cnt=2, r.city_name, l.rel_city_2);
		self.rel_state_2 := if(cnt=2, r.st, l.rel_state_2);
		self.rel_zipcode_2 := if(cnt=2, r.zip + r.zip4, l.rel_zipcode_2);
		self.rel_phone_2 := if(cnt=2, r.phone, l.rel_phone_2);
		self.rel_ssn_2   := if(cnt=2, r.ssn, l.rel_ssn_2);
		self.rel_dob_2   := if(cnt=2, if(r.dob=0, '',(string) r.dob),
													        l.rel_dob_2);
		self.rel_dod_2   := if(cnt=2, r.dod, l.rel_dod_2);
		self.rel_relationship_2 := if(cnt=2, r.relationship, l.rel_relationship_2);
		self.rel_relationship_type_2 := if(cnt=2, r.relationship_type, l.rel_relationship_type_2);
		self.rel_relationship_confidence_2 := if(cnt=2, r.relationship_confidence, l.rel_relationship_confidence_2);
		
		self.rel_depth_3 := if(cnt=3, (string)r.depth, l.rel_depth_3);
		self.rel_first_name_3 := if(cnt=3, r.fname, l.rel_first_name_3);
		self.rel_middle_name_3 := if(cnt=3, r.mname, l.rel_middle_name_3);
		self.rel_last_name_3 := if(cnt=3, r.lname, l.rel_last_name_3);
		self.rel_address_3 := if(cnt=3, address.Addr1FromComponents(r.prim_range, r.predir, r.prim_name,
																																	 r.suffix, r.postdir, r.unit_desig, r.sec_range),
									                  l.rel_address_3);
		self.rel_city_3 := if(cnt=3, r.city_name, l.rel_city_3);
		self.rel_state_3 := if(cnt=3, r.st, l.rel_state_3);
		self.rel_zipcode_3 := if(cnt=3, r.zip + r.zip4, l.rel_zipcode_3);
		self.rel_phone_3 := if(cnt=3, r.phone, l.rel_phone_3);
		self.rel_ssn_3   := if(cnt=3, r.ssn, l.rel_ssn_3);
		self.rel_dob_3   := if(cnt=3, if(r.dob=0, '',(string) r.dob),
													        l.rel_dob_3);
		self.rel_dod_3   := if(cnt=3, r.dod, l.rel_dod_3);
		self.rel_relationship_3 := if(cnt=3, r.relationship, l.rel_relationship_3);
		self.rel_relationship_type_3 := if(cnt=3, r.relationship_type, l.rel_relationship_type_3);
		self.rel_relationship_confidence_3 := if(cnt=3, r.relationship_confidence, l.rel_relationship_confidence_3);
		
		self.rel_depth_4 := if(cnt=4, (string)r.depth, l.rel_depth_4);
		self.rel_first_name_4 := if(cnt=4, r.fname, l.rel_first_name_4);
		self.rel_middle_name_4 := if(cnt=4, r.mname, l.rel_middle_name_4);
		self.rel_last_name_4 := if(cnt=4, r.lname, l.rel_last_name_4);
		self.rel_address_4 := if(cnt=4, address.Addr1FromComponents(r.prim_range, r.predir, r.prim_name,
																																	 r.suffix, r.postdir, r.unit_desig, r.sec_range),
									                  l.rel_address_4);
		self.rel_city_4 := if(cnt=4, r.city_name, l.rel_city_4);
		self.rel_state_4 := if(cnt=4, r.st, l.rel_state_4);
		self.rel_zipcode_4 := if(cnt=4, r.zip + r.zip4, l.rel_zipcode_4);
		self.rel_phone_4 := if(cnt=4, r.phone, l.rel_phone_4);
		self.rel_ssn_4   := if(cnt=4, r.ssn, l.rel_ssn_4);
		self.rel_dob_4   := if(cnt=4, if(r.dob=0, '',(string) r.dob),
													        l.rel_dob_4);
		self.rel_dod_4   := if(cnt=4, r.dod, l.rel_dod_4);
		self.rel_relationship_4 := if(cnt=4, r.relationship, l.rel_relationship_4);
		self.rel_relationship_type_4 := if(cnt=4, r.relationship_type, l.rel_relationship_type_4);
		self.rel_relationship_confidence_4 := if(cnt=4, r.relationship_confidence, l.rel_relationship_confidence_4);
			 
		self.rel_depth_5 := if(cnt=5, (string)r.depth, l.rel_depth_5);
		self.rel_first_name_5 := if(cnt=5, r.fname, l.rel_first_name_5);
		self.rel_middle_name_5 := if(cnt=5, r.mname, l.rel_middle_name_5);
		self.rel_last_name_5 := if(cnt=5, r.lname, l.rel_last_name_5);
		self.rel_address_5 := if(cnt=5, address.Addr1FromComponents(r.prim_range, r.predir, r.prim_name,
																																	 r.suffix, r.postdir, r.unit_desig, r.sec_range),
									                  l.rel_address_5);
		self.rel_city_5 := if(cnt=5, r.city_name, l.rel_city_5);
		self.rel_state_5 := if(cnt=5, r.st, l.rel_state_5);
		self.rel_zipcode_5 := if(cnt=5, r.zip + r.zip4, l.rel_zipcode_5);
		self.rel_phone_5 := if(cnt=5, r.phone, l.rel_phone_5);
		self.rel_ssn_5   := if(cnt=5, r.ssn, l.rel_ssn_5);
		self.rel_dob_5   := if(cnt=5, if(r.dob=0, '',(string) r.dob),
													        l.rel_dob_5);
		self.rel_dod_5   := if(cnt=5, r.dod, l.rel_dod_5);
		self.rel_relationship_5 := if(cnt=5, r.relationship, l.rel_relationship_5);
		self.rel_relationship_type_5 := if(cnt=5, r.relationship_type, l.rel_relationship_type_5);
		self.rel_relationship_confidence_5 := if(cnt=5, r.relationship_confidence, l.rel_relationship_confidence_5);
		
		self.rel_depth_6 := if(cnt=6, (string)r.depth, l.rel_depth_6);
		self.rel_first_name_6 := if(cnt=6, r.fname, l.rel_first_name_6);
		self.rel_middle_name_6 := if(cnt=6, r.mname, l.rel_middle_name_6);
		self.rel_last_name_6 := if(cnt=6, r.lname, l.rel_last_name_6);
		self.rel_address_6 := if(cnt=6, address.Addr1FromComponents(r.prim_range, r.predir, r.prim_name,
																																	 r.suffix, r.postdir, r.unit_desig, r.sec_range),
									                  l.rel_address_6);
		self.rel_city_6 := if(cnt=6, r.city_name, l.rel_city_6);
		self.rel_state_6 := if(cnt=6, r.st, l.rel_state_6);
		self.rel_zipcode_6 := if(cnt=6, r.zip + r.zip4, l.rel_zipcode_6);
		self.rel_phone_6 := if(cnt=6, r.phone, l.rel_phone_6);
		self.rel_ssn_6   := if(cnt=6, r.ssn, l.rel_ssn_6);
		self.rel_dob_6   := if(cnt=6, if(r.dob=0, '',(string) r.dob),
													        l.rel_dob_6);
		self.rel_dod_6   := if(cnt=6, r.dod, l.rel_dod_6);
		self.rel_relationship_6 := if(cnt=6, r.relationship, l.rel_relationship_6);
		self.rel_relationship_type_6 := if(cnt=6, r.relationship_type, l.rel_relationship_type_6);
		self.rel_relationship_confidence_6 := if(cnt=6, r.relationship_confidence, l.rel_relationship_confidence_6);
		
		self.rel_depth_7 := if(cnt=7, (string)r.depth, l.rel_depth_7);
		self.rel_first_name_7 := if(cnt=7, r.fname, l.rel_first_name_7);
		self.rel_middle_name_7 := if(cnt=7, r.mname, l.rel_middle_name_7);
		self.rel_last_name_7 := if(cnt=7, r.lname, l.rel_last_name_7);
		self.rel_address_7 := if(cnt=7, address.Addr1FromComponents(r.prim_range, r.predir, r.prim_name,
																																	 r.suffix, r.postdir, r.unit_desig, r.sec_range),
									                  l.rel_address_7);
		self.rel_city_7 := if(cnt=7, r.city_name, l.rel_city_7);
		self.rel_state_7 := if(cnt=7, r.st, l.rel_state_7);
		self.rel_zipcode_7 := if(cnt=7, r.zip + r.zip4, l.rel_zipcode_7);
		self.rel_phone_7 := if(cnt=7, r.phone, l.rel_phone_7);
		self.rel_ssn_7   := if(cnt=7, r.ssn, l.rel_ssn_7);
		self.rel_dob_7   := if(cnt=7, if(r.dob=0, '',(string) r.dob),
													        l.rel_dob_7);
		self.rel_dod_7   := if(cnt=7, r.dod, l.rel_dod_7);
		self.rel_relationship_7 := if(cnt=7, r.relationship, l.rel_relationship_7);
		self.rel_relationship_type_7 := if(cnt=7, r.relationship_type, l.rel_relationship_type_7);
		self.rel_relationship_confidence_7 := if(cnt=7, r.relationship_confidence, l.rel_relationship_confidence_7);
		
		self.rel_depth_8 := if(cnt=8, (string)r.depth, l.rel_depth_8);
		self.rel_first_name_8 := if(cnt=8, r.fname, l.rel_first_name_8);
		self.rel_middle_name_8 := if(cnt=8, r.mname, l.rel_middle_name_8);
		self.rel_last_name_8 := if(cnt=8, r.lname, l.rel_last_name_8);
		self.rel_address_8 := if(cnt=8, address.Addr1FromComponents(r.prim_range, r.predir, r.prim_name,
																																	 r.suffix, r.postdir, r.unit_desig, r.sec_range),
									                  l.rel_address_8);
		self.rel_city_8 := if(cnt=8, r.city_name, l.rel_city_8);
		self.rel_state_8 := if(cnt=8, r.st, l.rel_state_8);
		self.rel_zipcode_8 := if(cnt=8, r.zip + r.zip4, l.rel_zipcode_8);
		self.rel_phone_8 := if(cnt=8, r.phone, l.rel_phone_8);
		self.rel_ssn_8   := if(cnt=8, r.ssn, l.rel_ssn_8);
		self.rel_dob_8   := if(cnt=8, if(r.dob=0, '',(string) r.dob),
													        l.rel_dob_8);
		self.rel_dod_8   := if(cnt=8, r.dod, l.rel_dod_8);
		self.rel_relationship_8 := if(cnt=8, r.relationship, l.rel_relationship_8);
		self.rel_relationship_type_8 := if(cnt=8, r.relationship_type, l.rel_relationship_type_8);
		self.rel_relationship_confidence_8 := if(cnt=8, r.relationship_confidence, l.rel_relationship_confidence_8);
		
		self.rel_depth_9 := if(cnt=9, (string)r.depth, l.rel_depth_9);
		self.rel_first_name_9 := if(cnt=9, r.fname, l.rel_first_name_9);
		self.rel_middle_name_9 := if(cnt=9, r.mname, l.rel_middle_name_9);
		self.rel_last_name_9 := if(cnt=9, r.lname, l.rel_last_name_9);
		self.rel_address_9 := if(cnt=9, address.Addr1FromComponents(r.prim_range, r.predir, r.prim_name,
																																	 r.suffix, r.postdir, r.unit_desig, r.sec_range),
									                  l.rel_address_9);
		self.rel_city_9 := if(cnt=9, r.city_name, l.rel_city_9);
		self.rel_state_9 := if(cnt=9, r.st, l.rel_state_9);
		self.rel_zipcode_9 := if(cnt=9, r.zip + r.zip4, l.rel_zipcode_9);
		self.rel_phone_9 := if(cnt=9, r.phone, l.rel_phone_9);
		self.rel_ssn_9   := if(cnt=9, r.ssn, l.rel_ssn_9);
		self.rel_dob_9   := if(cnt=9, if(r.dob=0, '',(string) r.dob),
													        l.rel_dob_9);
		self.rel_dod_9   := if(cnt=9, r.dod, l.rel_dod_9);
		self.rel_relationship_9 := if(cnt=9, r.relationship, l.rel_relationship_9);
		self.rel_relationship_type_9 := if(cnt=9, r.relationship_type, l.rel_relationship_type_9);
		self.rel_relationship_confidence_9 := if(cnt=9, r.relationship_confidence, l.rel_relationship_confidence_9);
		
		self.rel_depth_10 := if(cnt=10, (string)r.depth, l.rel_depth_10);
		self.rel_first_name_10 := if(cnt=10, r.fname, l.rel_first_name_10);
		self.rel_middle_name_10 := if(cnt=10, r.mname, l.rel_middle_name_10);
		self.rel_last_name_10 := if(cnt=10, r.lname, l.rel_last_name_10);
		self.rel_address_10 := if(cnt=10, address.Addr1FromComponents(r.prim_range, r.predir, r.prim_name,
																																	 r.suffix, r.postdir, r.unit_desig, r.sec_range),
									                  l.rel_address_10);
		self.rel_city_10 := if(cnt=10, r.city_name, l.rel_city_10);
		self.rel_state_10 := if(cnt=10, r.st, l.rel_state_10);
		self.rel_zipcode_10 := if(cnt=10, r.zip + r.zip4, l.rel_zipcode_10);
		self.rel_phone_10 := if(cnt=10, r.phone, l.rel_phone_10);
		self.rel_ssn_10   := if(cnt=10, r.ssn, l.rel_ssn_10);
		self.rel_dob_10   := if(cnt=10, if(r.dob=0, '',(string) r.dob),
													        l.rel_dob_10);
		self.rel_dod_10   := if(cnt=10, r.dod, l.rel_dod_10);
		self.rel_relationship_10 := if(cnt=10, r.relationship, l.rel_relationship_10);
		self.rel_relationship_type_10 := if(cnt=10, r.relationship_type, l.rel_relationship_type_10);
		self.rel_relationship_confidence_10 := if(cnt=10, r.relationship_confidence, l.rel_relationship_confidence_10);

		self.RelAssocNeigh_Flag:='Y';

		rel_addr1_match := if (cnt=1,r.prim_range = l.prim_range and r.prim_name =l.prim_name and r.zip = l.z5, false) ; 
		rel_addr2_match := if (cnt=2,r.prim_range = l.prim_range and r.prim_name =l.prim_name and r.zip = l.z5, false) ; 
		rel_addr3_match := if (cnt=3,r.prim_range = l.prim_range and r.prim_name =l.prim_name and r.zip = l.z5, false) ; 
		rel_addr4_match := if (cnt=4,r.prim_range = l.prim_range and r.prim_name =l.prim_name and r.zip = l.z5, false) ; 
		rel_addr5_match := if (cnt=5,r.prim_range = l.prim_range and r.prim_name =l.prim_name and r.zip = l.z5, false) ; 
		rel_addr6_match := if (cnt=6,r.prim_range = l.prim_range and r.prim_name =l.prim_name and r.zip = l.z5, false) ; 
		rel_addr7_match := if (cnt=7,r.prim_range = l.prim_range and r.prim_name =l.prim_name and r.zip = l.z5, false) ; 
		rel_addr8_match := if (cnt=8,r.prim_range = l.prim_range and r.prim_name =l.prim_name and r.zip = l.z5, false) ; 
		rel_addr9_match := if (cnt=9,r.prim_range = l.prim_range and r.prim_name =l.prim_name and r.zip = l.z5, false) ; 
		rel_addr10_match := if (cnt=10,r.prim_range = l.prim_range and r.prim_name =l.prim_name and r.zip = l.z5, false) ; 
		self.input_addr_matched_rel := CompareInputAddrWithRel and 
		             (l.input_addr_matched_rel OR
		             (rel_addr1_match or rel_addr2_match or rel_addr3_match or rel_addr4_match or rel_addr5_match or rel_addr6_match or rel_addr7_match or rel_addr8_match or rel_addr9_match or rel_addr10_match));
		
		rel_addr1_name_match := if (cnt=1,r.prim_range = l.prim_range and r.prim_name =l.prim_name and r.zip = l.z5 and r.lname = l.name_last, false) ; 
		rel_addr2_name_match := if (cnt=2,r.prim_range = l.prim_range and r.prim_name =l.prim_name and r.zip = l.z5 and r.lname = l.name_last, false) ; 
		rel_addr3_name_match := if (cnt=3,r.prim_range = l.prim_range and r.prim_name =l.prim_name and r.zip = l.z5 and r.lname = l.name_last, false) ; 
		rel_addr4_name_match := if (cnt=4,r.prim_range = l.prim_range and r.prim_name =l.prim_name and r.zip = l.z5 and r.lname = l.name_last, false) ; 
		rel_addr5_name_match := if (cnt=5,r.prim_range = l.prim_range and r.prim_name =l.prim_name and r.zip = l.z5 and r.lname = l.name_last, false) ; 
		rel_addr6_name_match := if (cnt=6,r.prim_range = l.prim_range and r.prim_name =l.prim_name and r.zip = l.z5 and r.lname = l.name_last, false) ; 
		rel_addr7_name_match := if (cnt=7,r.prim_range = l.prim_range and r.prim_name =l.prim_name and r.zip = l.z5 and r.lname = l.name_last, false) ; 
		rel_addr8_name_match := if (cnt=8,r.prim_range = l.prim_range and r.prim_name =l.prim_name and r.zip = l.z5 and r.lname = l.name_last, false) ; 
		rel_addr9_name_match := if (cnt=9,r.prim_range = l.prim_range and r.prim_name =l.prim_name and r.zip = l.z5 and r.lname = l.name_last, false) ; 
		rel_addr10_name_match := if (cnt=10,r.prim_range = l.prim_range and r.prim_name =l.prim_name and r.zip = l.z5 and r.lname = l.name_last, false) ; 
		self.input_addr_name_matched_rel := CompareInputAddrNameWithRel and 
		             (l.input_addr_name_matched_rel OR
		             (rel_addr1_name_match or rel_addr2_name_match or rel_addr3_name_match or rel_addr4_name_match or rel_addr5_name_match or rel_addr6_name_match or rel_addr7_name_match or rel_addr8_name_match or rel_addr9_name_match or rel_addr10_name_match));

		
		self.rel_title_1 := if(cnt=1, r.title, l.rel_title_1);
		self.rel_title_2 := if(cnt=2, r.title, l.rel_title_2);
		self.rel_title_3 := if(cnt=3, r.title, l.rel_title_3);
		self.rel_title_4 := if(cnt=4, r.title, l.rel_title_4);
		self.rel_title_5 := if(cnt=5, r.title, l.rel_title_5);
		self.rel_title_6 := if(cnt=6, r.title, l.rel_title_6);
		self.rel_title_7 := if(cnt=7, r.title, l.rel_title_7);
		self.rel_title_8 := if(cnt=8, r.title, l.rel_title_8);
		self.rel_title_9 := if(cnt=9, r.title, l.rel_title_9);
		self.rel_title_10 := if(cnt=10, r.title, l.rel_title_10);
		
		self.rel_name_suffix_1 := if(cnt=1, r.name_suffix, l.rel_name_suffix_1);
		self.rel_name_suffix_2 := if(cnt=2, r.name_suffix, l.rel_name_suffix_2);
		self.rel_name_suffix_3 := if(cnt=3, r.name_suffix, l.rel_name_suffix_3);
		self.rel_name_suffix_4 := if(cnt=4, r.name_suffix, l.rel_name_suffix_4);
		self.rel_name_suffix_5 := if(cnt=5, r.name_suffix, l.rel_name_suffix_5);
		self.rel_name_suffix_6 := if(cnt=6, r.name_suffix, l.rel_name_suffix_6);
		self.rel_name_suffix_7 := if(cnt=7, r.name_suffix, l.rel_name_suffix_7);
		self.rel_name_suffix_8 := if(cnt=8, r.name_suffix, l.rel_name_suffix_8);
		self.rel_name_suffix_9 := if(cnt=9, r.name_suffix, l.rel_name_suffix_9);
		self.rel_name_suffix_10 := if(cnt=10, r.name_suffix, l.rel_name_suffix_10);
		
		self := l;
	end;

	f_out_with_rel := if(exclude_relatives, f_out_init,
											 denormalize(f_out_init, f_rel_best_final,
																left.seq = right.seqTarget,
																get_out_rel(left, right,counter)));
							
	//generate output - get roomies
	out_with_seq_rec get_out_roomie(f_out_with_rel l, f_roomie_best_final r, unsigned cnt) := transform
		self.asso_first_name_1 := if(cnt=1, r.fname, l.asso_first_name_1);
		self.asso_middle_name_1 := if(cnt=1, r.mname, l.asso_middle_name_1);
		self.asso_last_name_1 := if(cnt=1, r.lname, l.asso_last_name_1);
		self.asso_address_1 := if(cnt=1, address.Addr1FromComponents(r.prim_range, r.predir, r.prim_name,
																																	 r.suffix, r.postdir, r.unit_desig, r.sec_range),
									l.asso_address_1);
		self.asso_city_1 := if(cnt=1, r.city_name, l.asso_city_1);
		self.asso_state_1 := if(cnt=1, r.st, l.asso_state_1);
		self.asso_zipcode_1 := if(cnt=1, r.zip + r.zip4, l.asso_zipcode_1);
		self.asso_phone_1 := if(cnt=1, r.phone, l.asso_phone_1);
		self.asso_ssn_1   := if(cnt=1, r.ssn, l.asso_ssn_1);
		self.asso_dob_1   := if(cnt=1, if(r.dob=0, '',(string) r.dob),
													         l.asso_dob_1);
		self.asso_dod_1   := if(cnt=1, r.dod, l.asso_dod_1);
		self.asso_relationship_1 := if(cnt=1, r.relationship, l.asso_relationship_1);
		self.asso_relationship_type_1 := if(cnt=1, r.relationship_type, l.asso_relationship_type_1);
		self.asso_relationship_confidence_1 := if(cnt=1, r.relationship_confidence, l.asso_relationship_confidence_1);

		self.asso_first_name_2 := if(cnt=2, r.fname, l.asso_first_name_2);
		self.asso_middle_name_2 := if(cnt=2, r.mname, l.asso_middle_name_2);
		self.asso_last_name_2 := if(cnt=2, r.lname, l.asso_last_name_2);
		self.asso_address_2 := if(cnt=2, address.Addr1FromComponents(r.prim_range, r.predir, r.prim_name,
																																	 r.suffix, r.postdir, r.unit_desig, r.sec_range),
									l.asso_address_2);
		self.asso_city_2 := if(cnt=2, r.city_name, l.asso_city_2);
		self.asso_state_2 := if(cnt=2, r.st, l.asso_state_2);
		self.asso_zipcode_2 := if(cnt=2, r.zip + r.zip4, l.asso_zipcode_2);
		self.asso_phone_2 := if(cnt=2, r.phone, l.asso_phone_2);
		self.asso_ssn_2   := if(cnt=2, r.ssn, l.asso_ssn_2);
		self.asso_dob_2   := if(cnt=2, if(r.dob=0, '',(string) r.dob),
													         l.asso_dob_2);
		self.asso_dod_2   := if(cnt=2, r.dod, l.asso_dod_2);
		self.asso_relationship_2 := if(cnt=2, r.relationship, l.asso_relationship_2);
		self.asso_relationship_type_2 := if(cnt=2, r.relationship_type, l.asso_relationship_type_2);
		self.asso_relationship_confidence_2 := if(cnt=2, r.relationship_confidence, l.asso_relationship_confidence_2);

		self.asso_first_name_3 := if(cnt=3, r.fname, l.asso_first_name_3);
		self.asso_middle_name_3 := if(cnt=3, r.mname, l.asso_middle_name_3);
		self.asso_last_name_3 := if(cnt=3, r.lname, l.asso_last_name_3);
		self.asso_address_3 := if(cnt=3, address.Addr1FromComponents(r.prim_range, r.predir, r.prim_name,
																																	 r.suffix, r.postdir, r.unit_desig, r.sec_range),
									l.asso_address_3);
		self.asso_city_3 := if(cnt=3, r.city_name, l.asso_city_3);
		self.asso_state_3 := if(cnt=3, r.st, l.asso_state_3);
		self.asso_zipcode_3 := if(cnt=3, r.zip + r.zip4, l.asso_zipcode_3);
		self.asso_phone_3 := if(cnt=3, r.phone, l.asso_phone_3);
		self.asso_ssn_3   := if(cnt=3, r.ssn, l.asso_ssn_3);
		self.asso_dob_3   := if(cnt=3, if(r.dob=0, '',(string) r.dob),
													         l.asso_dob_3);
		self.asso_dod_3   := if(cnt=3, r.dod, l.asso_dod_3);
		self.asso_relationship_3 := if(cnt=3, r.relationship, l.asso_relationship_3);
		self.asso_relationship_type_3 := if(cnt=3, r.relationship_type, l.asso_relationship_type_3);
		self.asso_relationship_confidence_3 := if(cnt=3, r.relationship_confidence, l.asso_relationship_confidence_3);
		
		self.asso_first_name_4 := if(cnt=4, r.fname, l.asso_first_name_4);
		self.asso_middle_name_4 := if(cnt=4, r.mname, l.asso_middle_name_4);
		self.asso_last_name_4 := if(cnt=4, r.lname, l.asso_last_name_4);
		self.asso_address_4 := if(cnt=4, address.Addr1FromComponents(r.prim_range, r.predir, r.prim_name,
																																	 r.suffix, r.postdir, r.unit_desig, r.sec_range),
									l.asso_address_4);
		self.asso_city_4 := if(cnt=4, r.city_name, l.asso_city_4);
		self.asso_state_4 := if(cnt=4, r.st, l.asso_state_4);
		self.asso_zipcode_4 := if(cnt=4, r.zip + r.zip4, l.asso_zipcode_4);
		self.asso_phone_4 := if(cnt=4, r.phone, l.asso_phone_4);
		self.asso_ssn_4   := if(cnt=4, r.ssn, l.asso_ssn_4);
		self.asso_dob_4   := if(cnt=4, if(r.dob=0, '',(string) r.dob),
													         l.asso_dob_4);
		self.asso_dod_4   := if(cnt=4, r.dod, l.asso_dod_4);
		self.asso_relationship_4 := if(cnt=4, r.relationship, l.asso_relationship_4);
		self.asso_relationship_type_4 := if(cnt=4, r.relationship_type, l.asso_relationship_type_4);
		self.asso_relationship_confidence_4 := if(cnt=4, r.relationship_confidence, l.asso_relationship_confidence_4);
		
		self.asso_first_name_5 := if(cnt=5, r.fname, l.asso_first_name_5);
		self.asso_middle_name_5 := if(cnt=5, r.mname, l.asso_middle_name_5);
		self.asso_last_name_5 := if(cnt=5, r.lname, l.asso_last_name_5);
		self.asso_address_5 := if(cnt=5, address.Addr1FromComponents(r.prim_range, r.predir, r.prim_name,
																																	 r.suffix, r.postdir, r.unit_desig, r.sec_range),
									l.asso_address_5);
		self.asso_city_5 := if(cnt=5, r.city_name, l.asso_city_5);
		self.asso_state_5 := if(cnt=5, r.st, l.asso_state_5);
		self.asso_zipcode_5 := if(cnt=5, r.zip + r.zip4, l.asso_zipcode_5);
		self.asso_phone_5 := if(cnt=5, r.phone, l.asso_phone_5);
		self.asso_ssn_5   := if(cnt=5, r.ssn, l.asso_ssn_5);
		self.asso_dob_5   := if(cnt=5, if(r.dob=0, '',(string) r.dob),
													         l.asso_dob_5);
		self.asso_dod_5   := if(cnt=5, r.dod, l.asso_dod_5);
		self.asso_relationship_5 := if(cnt=5, r.relationship, l.asso_relationship_5);
		self.asso_relationship_type_5 := if(cnt=5, r.relationship_type, l.asso_relationship_type_5);
		self.asso_relationship_confidence_5 := if(cnt=5, r.relationship_confidence, l.asso_relationship_confidence_5);

		self.asso_first_name_6 := if(cnt=6, r.fname, l.asso_first_name_6);
		self.asso_middle_name_6 := if(cnt=6, r.mname, l.asso_middle_name_6);
		self.asso_last_name_6 := if(cnt=6, r.lname, l.asso_last_name_6);
		self.asso_address_6 := if(cnt=6, address.Addr1FromComponents(r.prim_range, r.predir, r.prim_name,
																																	 r.suffix, r.postdir, r.unit_desig, r.sec_range),
									l.asso_address_6);
		self.asso_city_6 := if(cnt=6, r.city_name, l.asso_city_6);
		self.asso_state_6 := if(cnt=6, r.st, l.asso_state_6);
		self.asso_zipcode_6 := if(cnt=6, r.zip + r.zip4, l.asso_zipcode_6);
		self.asso_phone_6 := if(cnt=6, r.phone, l.asso_phone_6);
		self.asso_ssn_6   := if(cnt=6, r.ssn, l.asso_ssn_6);
		self.asso_dob_6   := if(cnt=6, if(r.dob=0, '',(string) r.dob),
													         l.asso_dob_6);
		self.asso_dod_6   := if(cnt=6, r.dod, l.asso_dod_6);
		self.asso_relationship_6 := if(cnt=6, r.relationship, l.asso_relationship_6);
		self.asso_relationship_type_6 := if(cnt=6, r.relationship_type, l.asso_relationship_type_6);
		self.asso_relationship_confidence_6 := if(cnt=6, r.relationship_confidence, l.asso_relationship_confidence_6);
		
		self.asso_first_name_7 := if(cnt=7, r.fname, l.asso_first_name_7);
		self.asso_middle_name_7 := if(cnt=7, r.mname, l.asso_middle_name_7);
		self.asso_last_name_7 := if(cnt=7, r.lname, l.asso_last_name_7);
		self.asso_address_7 := if(cnt=7, address.Addr1FromComponents(r.prim_range, r.predir, r.prim_name,
																																	 r.suffix, r.postdir, r.unit_desig, r.sec_range),
									l.asso_address_7);
		self.asso_city_7 := if(cnt=7, r.city_name, l.asso_city_7);
		self.asso_state_7 := if(cnt=7, r.st, l.asso_state_7);
		self.asso_zipcode_7 := if(cnt=7, r.zip + r.zip4, l.asso_zipcode_7);
		self.asso_phone_7 := if(cnt=7, r.phone, l.asso_phone_7);
		self.asso_ssn_7   := if(cnt=7, r.ssn, l.asso_ssn_7);
		self.asso_dob_7   := if(cnt=7, if(r.dob=0, '',(string) r.dob),
													         l.asso_dob_7);
		self.asso_dod_7   := if(cnt=7, r.dod, l.asso_dod_7);
		self.asso_relationship_7 := if(cnt=7, r.relationship, l.asso_relationship_7);
		self.asso_relationship_type_7 := if(cnt=7, r.relationship_type, l.asso_relationship_type_7);
		self.asso_relationship_confidence_7 := if(cnt=7, r.relationship_confidence, l.asso_relationship_confidence_7);
		
		self.asso_first_name_8 := if(cnt=8, r.fname, l.asso_first_name_8);
		self.asso_middle_name_8 := if(cnt=8, r.mname, l.asso_middle_name_8);
		self.asso_last_name_8 := if(cnt=8, r.lname, l.asso_last_name_8);
		self.asso_address_8 := if(cnt=8, address.Addr1FromComponents(r.prim_range, r.predir, r.prim_name,
																																	 r.suffix, r.postdir, r.unit_desig, r.sec_range),
									l.asso_address_8);
		self.asso_city_8 := if(cnt=8, r.city_name, l.asso_city_8);
		self.asso_state_8 := if(cnt=8, r.st, l.asso_state_8);
		self.asso_zipcode_8 := if(cnt=8, r.zip + r.zip4, l.asso_zipcode_8);
		self.asso_phone_8 := if(cnt=8, r.phone, l.asso_phone_8);
		self.asso_ssn_8   := if(cnt=8, r.ssn, l.asso_ssn_8);
		self.asso_dob_8   := if(cnt=8, if(r.dob=0, '',(string) r.dob),
													         l.asso_dob_8);
		self.asso_dod_8   := if(cnt=8, r.dod, l.asso_dod_8);
		self.asso_relationship_8 := if(cnt=8, r.relationship, l.asso_relationship_8);
		self.asso_relationship_type_8 := if(cnt=8, r.relationship_type, l.asso_relationship_type_8);
		self.asso_relationship_confidence_8 := if(cnt=8, r.relationship_confidence, l.asso_relationship_confidence_8);
		
		self.asso_first_name_9 := if(cnt=9, r.fname, l.asso_first_name_9);
		self.asso_middle_name_9 := if(cnt=9, r.mname, l.asso_middle_name_9);
		self.asso_last_name_9 := if(cnt=9, r.lname, l.asso_last_name_9);
		self.asso_address_9 := if(cnt=9, address.Addr1FromComponents(r.prim_range, r.predir, r.prim_name,
																																	 r.suffix, r.postdir, r.unit_desig, r.sec_range),
									l.asso_address_9);
		self.asso_city_9 := if(cnt=9, r.city_name, l.asso_city_9);
		self.asso_state_9 := if(cnt=9, r.st, l.asso_state_9);
		self.asso_zipcode_9 := if(cnt=9, r.zip + r.zip4, l.asso_zipcode_9);
		self.asso_phone_9 := if(cnt=9, r.phone, l.asso_phone_9);
		self.asso_ssn_9   := if(cnt=9, r.ssn, l.asso_ssn_9);
		self.asso_dob_9   := if(cnt=9, if(r.dob=0, '',(string) r.dob),
													         l.asso_dob_9);
		self.asso_dod_9   := if(cnt=9, r.dod, l.asso_dod_9);
		self.asso_relationship_9 := if(cnt=9, r.relationship, l.asso_relationship_9);
		self.asso_relationship_type_9 := if(cnt=9, r.relationship_type, l.asso_relationship_type_9);
		self.asso_relationship_confidence_9 := if(cnt=9, r.relationship_confidence, l.asso_relationship_confidence_9);
		
		self.asso_first_name_10 := if(cnt=10, r.fname, l.asso_first_name_10);
		self.asso_middle_name_10 := if(cnt=10, r.mname, l.asso_middle_name_10);
		self.asso_last_name_10 := if(cnt=10, r.lname, l.asso_last_name_10);
		self.asso_address_10 := if(cnt=10, address.Addr1FromComponents(r.prim_range, r.predir, r.prim_name,
																																	 r.suffix, r.postdir, r.unit_desig, r.sec_range),
									l.asso_address_10);
		self.asso_city_10 := if(cnt=10, r.city_name, l.asso_city_10);
		self.asso_state_10 := if(cnt=10, r.st, l.asso_state_10);
		self.asso_zipcode_10 := if(cnt=10, r.zip + r.zip4, l.asso_zipcode_10);
		self.asso_phone_10 := if(cnt=10, r.phone, l.asso_phone_10);
		self.asso_ssn_10   := if(cnt=10, r.ssn, l.asso_ssn_10);
		self.asso_dob_10   := if(cnt=10, if(r.dob=0, '',(string) r.dob),
													         l.asso_dob_10);
		self.asso_dod_10   := if(cnt=10, r.dod, l.asso_dod_10);
		self.asso_relationship_10 := if(cnt=10, r.relationship, l.asso_relationship_10);
		self.asso_relationship_type_10 := if(cnt=10, r.relationship_type, l.asso_relationship_type_10);
		self.asso_relationship_confidence_10 := if(cnt=10, r.relationship_confidence, l.asso_relationship_confidence_10);
		
		self.RelAssocNeigh_Flag:='Y';
		
		self.asso_title_1 := if(cnt=1, r.title, l.asso_title_1);
		self.asso_title_2 := if(cnt=2, r.title, l.asso_title_2);
		self.asso_title_3 := if(cnt=3, r.title, l.asso_title_3);
		self.asso_title_4 := if(cnt=4, r.title, l.asso_title_4);
		self.asso_title_5 := if(cnt=5, r.title, l.asso_title_5);
		self.asso_title_6 := if(cnt=6, r.title, l.asso_title_6);
		self.asso_title_7 := if(cnt=7, r.title, l.asso_title_7);
		self.asso_title_8 := if(cnt=8, r.title, l.asso_title_8);
		self.asso_title_9 := if(cnt=9, r.title, l.asso_title_9);
		self.asso_title_10 := if(cnt=10, r.title, l.asso_title_10);
		
		self.asso_name_suffix_1 := if(cnt=1, r.name_suffix, l.asso_name_suffix_1);
		self.asso_name_suffix_2 := if(cnt=2, r.name_suffix, l.asso_name_suffix_2);
		self.asso_name_suffix_3 := if(cnt=3, r.name_suffix, l.asso_name_suffix_3);
		self.asso_name_suffix_4 := if(cnt=4, r.name_suffix, l.asso_name_suffix_4);
		self.asso_name_suffix_5 := if(cnt=5, r.name_suffix, l.asso_name_suffix_5);
		self.asso_name_suffix_6 := if(cnt=6, r.name_suffix, l.asso_name_suffix_6);
		self.asso_name_suffix_7 := if(cnt=7, r.name_suffix, l.asso_name_suffix_7);
		self.asso_name_suffix_8 := if(cnt=8, r.name_suffix, l.asso_name_suffix_8);
		self.asso_name_suffix_9 := if(cnt=9, r.name_suffix, l.asso_name_suffix_9);
		self.asso_name_suffix_10 := if(cnt=10, r.name_suffix, l.asso_name_suffix_10);
		
		self := l;
	end;

	f_out_with_roomie := if(exclude_associates, f_out_with_rel,
													denormalize(f_out_with_rel, f_roomie_best_final,
																			left.seq = right.seqTarget,
																			get_out_roomie(left, right,counter)));

	//generate output - get input address nbrs
	out_with_seq_rec get_out_nbr_in(f_out_with_roomie l, f_in_nbrs r, unsigned cnt) := transform
		self.nbr_first_name_input_1 := if(cnt=1, r.fname, l.nbr_first_name_input_1);
		self.nbr_last_name_input_1 := if(cnt=1, r.lname, l.nbr_last_name_input_1);
		self.nbr_address_input_1 := if(cnt=1, address.Addr1FromComponents(r.prim_range, r.predir, r.prim_name,
																																	 r.suffix, r.postdir, r.unit_desig, r.sec_range),
									l.nbr_address_input_1);
		self.nbr_city_input_1 := if(cnt=1, r.city_name, l.nbr_city_input_1);
		self.nbr_state_input_1 := if(cnt=1, r.st, l.nbr_state_input_1);
		self.nbr_zipcode_input_1 := if(cnt=1, r.zip + r.zip4, l.nbr_zipcode_input_1);
		self.nbr_phone_input_1 := if(cnt=1, r.phone, l.nbr_phone_input_1);

		self.nbr_first_name_input_2 := if(cnt=2, r.fname, l.nbr_first_name_input_2);
		self.nbr_last_name_input_2 := if(cnt=2, r.lname, l.nbr_last_name_input_2);
		self.nbr_address_input_2 := if(cnt=2, address.Addr1FromComponents(r.prim_range, r.predir, r.prim_name,
																																	 r.suffix, r.postdir, r.unit_desig, r.sec_range),
									l.nbr_address_input_2);
		self.nbr_city_input_2 := if(cnt=2, r.city_name, l.nbr_city_input_2);
		self.nbr_state_input_2 := if(cnt=2, r.st, l.nbr_state_input_2);
		self.nbr_zipcode_input_2 := if(cnt=2, r.zip + r.zip4, l.nbr_zipcode_input_2);
		self.nbr_phone_input_2 := if(cnt=2, r.phone, l.nbr_phone_input_2);

		self.nbr_first_name_input_3 := if(cnt=3, r.fname, l.nbr_first_name_input_3);
		self.nbr_last_name_input_3 := if(cnt=3, r.lname, l.nbr_last_name_input_3);
		self.nbr_address_input_3 := if(cnt=3, address.Addr1FromComponents(r.prim_range, r.predir, r.prim_name,
																																	 r.suffix, r.postdir, r.unit_desig, r.sec_range),
									l.nbr_address_input_3);
		self.nbr_city_input_3 := if(cnt=3, r.city_name, l.nbr_city_input_3);
		self.nbr_state_input_3 := if(cnt=3, r.st, l.nbr_state_input_3);
		self.nbr_zipcode_input_3 := if(cnt=3, r.zip + r.zip4, l.nbr_zipcode_input_3);
		self.nbr_phone_input_3 := if(cnt=3, r.phone, l.nbr_phone_input_3);
		self.RelAssocNeigh_Flag:='Y';
		
		self.nbr_title_1 := if(cnt=1, r.title, l.nbr_title_1);
		self.nbr_title_2 := if(cnt=2, r.title, l.nbr_title_2);
		self.nbr_title_3 := if(cnt=3, r.title, l.nbr_title_3);
		
		self.nbr_middle_name_input_1 := if(cnt=1, r.mname, l.nbr_middle_name_input_1);
		self.nbr_middle_name_input_2 := if(cnt=2, r.mname, l.nbr_middle_name_input_2);
		self.nbr_middle_name_input_3 := if(cnt=3, r.mname, l.nbr_middle_name_input_3);
		
		self.nbr_name_suffix_1 := if(cnt=1, r.name_suffix, l.nbr_name_suffix_1);
		self.nbr_name_suffix_2 := if(cnt=2, r.name_suffix, l.nbr_name_suffix_2);
		self.nbr_name_suffix_3 := if(cnt=3, r.name_suffix, l.nbr_name_suffix_3);
		
	  self := l;
	end;

	f_out_with_nbr_in := if(exclude_input_nbrs,f_out_with_roomie,
													denormalize(f_out_with_roomie, f_in_nbrs,
																			left.seq = right.seqTarget,
																			get_out_nbr_in(left, right,counter)));

	//generate output - get input address nbrs
	out_with_seq_rec get_out_nbr_best(f_out_with_nbr_in l, f_best_nbrs r, unsigned cnt) := transform
		self.nbr_first_name_Updated_1 := if(cnt=1, r.fname, l.nbr_first_name_Updated_1);
		self.nbr_last_name_Updated_1 := if(cnt=1, r.lname, l.nbr_last_name_Updated_1);
		self.nbr_address_Updated_1 := if(cnt=1, address.Addr1FromComponents(r.prim_range, r.predir, r.prim_name,
																																	 r.suffix, r.postdir, r.unit_desig, r.sec_range),
									l.nbr_address_Updated_1);
		self.nbr_city_Updated_1 := if(cnt=1, r.city_name, l.nbr_city_Updated_1);
		self.nbr_state_Updated_1 := if(cnt=1, r.st, l.nbr_state_Updated_1);
		self.nbr_zipcode_Updated_1 := if(cnt=1, r.zip + r.zip4, l.nbr_zipcode_Updated_1);
		self.nbr_phone_Updated_1 := if(cnt=1, r.phone, l.nbr_phone_Updated_1);
		
		self.nbr_first_name_Updated_2 := if(cnt=2, r.fname, l.nbr_first_name_Updated_2);
		self.nbr_last_name_Updated_2 := if(cnt=2, r.lname, l.nbr_last_name_Updated_2);
		self.nbr_address_Updated_2 := if(cnt=2, address.Addr1FromComponents(r.prim_range, r.predir, r.prim_name,
																																	 r.suffix, r.postdir, r.unit_desig, r.sec_range),
									l.nbr_address_Updated_2);
		self.nbr_city_Updated_2 := if(cnt=2, r.city_name, l.nbr_city_Updated_2);
		self.nbr_state_Updated_2 := if(cnt=2, r.st, l.nbr_state_Updated_2);
		self.nbr_zipcode_Updated_2 := if(cnt=2, r.zip + r.zip4, l.nbr_zipcode_Updated_2);
		self.nbr_phone_Updated_2 := if(cnt=2, r.phone, l.nbr_phone_Updated_2);

		self.nbr_first_name_Updated_3 := if(cnt=3, r.fname, l.nbr_first_name_Updated_3);
		self.nbr_last_name_Updated_3 := if(cnt=3, r.lname, l.nbr_last_name_Updated_3);
		self.nbr_address_Updated_3 := if(cnt=3, address.Addr1FromComponents(r.prim_range, r.predir, r.prim_name,
																																	 r.suffix, r.postdir, r.unit_desig, r.sec_range),
									l.nbr_address_Updated_3);
		self.nbr_city_Updated_3 := if(cnt=3, r.city_name, l.nbr_city_Updated_3);
		self.nbr_state_Updated_3 := if(cnt=3, r.st, l.nbr_state_Updated_3);
		self.nbr_zipcode_Updated_3 := if(cnt=3, r.zip + r.zip4, l.nbr_zipcode_Updated_3);
		self.nbr_phone_Updated_3 := if(cnt=3, r.phone, l.nbr_phone_Updated_3);
		self.RelAssocNeigh_Flag:='Y';
		
		self.nbr_title_Updated_1 := if(cnt=1, r.title, l.nbr_title_Updated_1);
		self.nbr_title_Updated_2 := if(cnt=2, r.title, l.nbr_title_Updated_2);
		self.nbr_title_Updated_3 := if(cnt=3, r.title, l.nbr_title_Updated_3);
		
		self.nbr_middle_name_Updated_1 := if(cnt=1, r.mname, l.nbr_middle_name_Updated_1);
		self.nbr_middle_name_Updated_2 := if(cnt=2, r.mname, l.nbr_middle_name_Updated_2);
		self.nbr_middle_name_Updated_3 := if(cnt=3, r.mname, l.nbr_middle_name_Updated_3);
		
		self.nbr_name_suffix_Updated_1 := if(cnt=1, r.name_suffix, l.nbr_name_suffix_Updated_1);
		self.nbr_name_suffix_Updated_2 := if(cnt=2, r.name_suffix, l.nbr_name_suffix_Updated_2);
		self.nbr_name_suffix_Updated_3 := if(cnt=3, r.name_suffix, l.nbr_name_suffix_Updated_3);
		
		self := l;
	end;

	f_out_final := if(exclude_update_nbrs,f_out_with_nbr_in,
										denormalize(f_out_with_nbr_in, f_best_nbrs,
																left.seq = right.seqTarget,
																get_out_nbr_best(left, right,counter)));
  RETURN f_out_final;

END;