import Address,	AutokeyB2_batch, AutoKeyI, BatchServices, DidVille, doxie, gong_services, 
       LN_PropertyV2, ut, DeathV2_Services, LN_PropertyV2_Services;

layout_in 	:= BatchServices.CapitalGains_BatchService_Layouts.batch_in;
layout_out 	:= BatchServices.CapitalGains_BatchService_Layouts.batch_out;
layout_flat := BatchServices.CapitalGains_BatchService_Layouts.batch_flat_tmp;

export CapitalGains_BatchService_Functions := module

	export cleanInputAddresses(dataset(layout_in) ds_batch_in) := function
		layout_in clean_batch_in(layout_in l) := 
		TRANSFORM
			addr1 			:= if(l.addr <> '', l.addr, Address.Addr1FromComponents(l.prim_range, l.predir, l.prim_name, l.addr_suffix, l.postdir, l.unit_desig, l.sec_range));
			addr2 			:= Address.Addr2FromComponents(l.p_city_name, l.st, l.z5);
			clean_addr 	:= Address.GetCleanAddress(addr1,addr2,Address.Components.Country.US).str_addr;
			ca					:= Address.CleanFields(clean_addr);			
			insufficient_input_addr := (ca.prim_range = '' or ca.prim_name = '' or (ca.zip <> '' and (ca.p_city_name = '' or ca.st = '')));			
			
			s1_fname 		:= if(l.subject1_first<>'', 	l.subject1_first, 	l.name_first); 	// for compatibility with standard batch input
			s1_mname 		:= if(l.subject1_first<>'', 	l.subject1_middle, 	l.name_middle); // for compatibility with standard batch input
			s1_lname 		:= if(l.subject1_last<>'', 		l.subject1_last, 		l.name_last); 	// for compatibility with standard batch input
			s1_name_suf := if(l.subject1_suffix<>'', 	l.subject1_suffix, 	l.name_suffix); // for compatibility with standard batch input
			s1_ssn 			:= if(l.subject1_ssn<>'', 		l.subject1_ssn, 		l.ssn); 				// for compatibility with standard batch input
			s1_dob 			:= if(l.subject1_dob<>'', 		l.subject1_dob, 		l.dob); 				// for compatibility with standard batch input
			insufficient_input1 := s1_lname='' or (s1_fname='' and s1_ssn=''); 
			insufficient_input2 := l.subject2_last='' or (l.subject2_first='' and l.subject2_ssn=''); 
			
			self.prim_range 	:= ca.prim_range;
			self.predir 			:= ca.predir;
			self.prim_name 		:= ca.prim_name;
			self.addr_suffix 	:= ca.addr_suffix;
			self.postdir 			:= ca.postdir;
			self.unit_desig 	:= ca.unit_desig;
			self.sec_range 		:= ca.sec_range;
			self.p_city_name 	:= ca.p_city_name;
			self.st 					:= ca.st;
			self.z5 					:= ca.zip;
			self.zip4 				:= ca.zip4;	
			self.subject1_first  := StringLib.StringToUpperCase(s1_fname),
			self.subject1_middle := StringLib.StringToUpperCase(s1_mname),
			self.subject1_last	 := StringLib.StringToUpperCase(s1_lname),
			self.subject1_suffix := StringLib.StringToUpperCase(s1_name_suf),
			self.subject1_ssn		 := s1_ssn;
			self.subject1_dob		 := s1_dob;
			self.subject2_first  := StringLib.StringToUpperCase(l.subject2_first),
			self.subject2_middle := StringLib.StringToUpperCase(l.subject2_middle),
			self.subject2_last	 := StringLib.StringToUpperCase(l.subject2_last),
			self.subject2_suffix := StringLib.StringToUpperCase(l.subject2_suffix),			
			self.error_code		:= if(insufficient_input_addr or (insufficient_input1 and insufficient_input2), 
															AutoKeyI.errorcodes._codes.INSUFFICIENT_INPUT, 0),
			self.acctno				:= l.acctno,			
			self 							:= l;
		END;		
		batch_in_dedup := dedup(sort(ds_batch_in, acctno), acctno);
		batch_in_clean := project(batch_in_dedup, clean_batch_in(LEFT));
		return batch_in_clean;
	end;	
	
	export normalizeInputFile(dataset(layout_in) ds_batch_in) := function
	
		layout_flat normalizeInput(layout_in l, integer c) := transform		
			insufficient_input1 := l.subject1_last='' or (l.subject1_first='' and l.subject1_ssn=''); 
			insufficient_input2 := l.subject2_last='' or (l.subject2_first='' and l.subject2_ssn=''); 
			self.name_first  := if(c=1, l.subject1_first, l.subject2_first),
			self.name_middle := if(c=1, l.subject1_middle, l.subject2_middle),
			self.name_last   := if(c=1, l.subject1_last, l.subject2_last),
			self.name_suffix := if(c=1, l.subject1_suffix, l.subject2_suffix),
			self.ssn 				 := if(c=1, l.subject1_ssn, l.subject2_ssn),
			self.dob 				 := if(c=1, l.subject1_dob, l.subject2_dob),
			self.subject_id  := c,
			self.error_code := if((c=1 and insufficient_input1) or (c=2 and insufficient_input2), skip, 0),
 			self := l,
			self := []
		end;
		ds_batch_in_norm := normalize(ds_batch_in(acctno<>''), 2, normalizeInput(left, counter));
		ut.MAC_Sequence_Records(ds_batch_in_norm, seq, ds_batch_in_seq)
		return project(ds_batch_in_seq, transform(layout_flat, self.orig_acctno := left.acctno, self.acctno := (string)left.seq, self := left));
	end;	

	export appendDids(dataset(layout_flat) ds_recs) := function	
	
		DidVille.Layout_Did_OutBatch toMACDidAppend(layout_flat l) := transform
			self.seq 	  := (integer) l.acctno; // acctno has been internally assigned through MAC_Sequence_Records, always an integer.
			self.fname  := l.name_first,
			self.mname  := l.name_middle,
			self.lname  := l.name_last,
			self.suffix := l.name_suffix,
			self := l,
			self := []
		end;
		ds_did_in := project(ds_recs, toMacDidAppend(left));
		// using the same options used by address best batch.
		DidVille.MAC_DidAppend(ds_did_in, ds_dids, true, '4N')

		ds_recs_with_dids := join(ds_recs, ds_dids,
															left.acctno = (string) right.seq,
															transform(layout_flat, 
																				self.did := if (right.score >= Constants.CapitalGains.DID_SCORE_THRESHOLD,right.did,0),
																				self := left),
															left outer,	keep(1), limit(0));
															
		return ds_recs_with_dids;
	end;

	export appendDeceased(dataset(layout_flat) ds_recs) := function		
		// will run through deceased process using just dids.
		deathInMod := DeathV2_Services.IParam.getBatchParams();
		ds_batch_in_death := PROJECT(ds_recs(error_code=0), transform(DeathV2_Services.Layouts.BatchIn,
			self.did := left.did, self.acctno := left.acctno, self := []));
		ds_death_recs := DeathV2_Services.BatchRecords(ds_batch_in_death, deathInMod);			
		ds_recs_with_death := join(ds_recs, ds_death_recs, 
															 left.acctno = right.acctno,
															 transform(layout_flat,
																	self.subject_deceased_indicator := if(right.acctno<>'', 'Y', 'N'),
																	self.subject_deceased_first 		:= right.fname,
																	self.subject_deceased_last 			:= right.lname,
																	self.subject_deceased_ssn 			:= right.ssn, 
																	self.subject_deceased_dob 			:= right.dob8,
																	self.subject_dod 								:= right.dod8, 
																	self 														:= left,
																	self 														:= []),
																left outer, keep(1), limit(0));	
    																	
		return ds_recs_with_death;
	end;	
	
	export appendBest(dataset(layout_flat) ds_recs, unsigned1 glbPurpose, unsigned1 dppaPurpose,boolean include_minors=false, boolean getSSNBest=true) := function		
	
    mod_access := MODULE (doxie.functions.GetGlobalDataAccessModuleTranslated (AutoStandardI.GlobalModule()))		
      EXPORT unsigned1 glb := glbPurpose;
      EXPORT unsigned1 dppa := dppaPurpose;
      EXPORT boolean show_minors := include_minors OR (glbPurpose = 2);
    END;

		dids := dedup(sort(project(ds_recs(did>0), doxie.layout_references), did));
		ds_best_recs := doxie.best_records(dids,
																			//  DPPA_override := dppaPurpose,
																			//  GLB_override  := glbPurpose,
																			 include_minors:= include_minors,
																			 getSSNBest    := getSSNBest,
																			 modAccess := mod_access
																			);
		ds_recs_with_best := join(ds_recs, ds_best_recs, left.did = right.did,	
						transform(layout_flat,	
							_validSubj := right.did<>0;
							_addrSubj  := Address.Addr1FromComponents(right.prim_range, right.predir, right.prim_name, right.suffix, right.postdir, right.unit_desig, right.sec_range);						
							self.did 										:= left.did,
							self.subject_did						:= left.did,
							self.subject_best_name			:= if(_validSubj, Address.NameFromComponents(right.fname, right.mname, right.lname, right.name_suffix), ''),							
							self.subject_current_addr 	:= if(_validSubj, _addrSubj, ''),
							self.subject_current_city 	:= if(_validSubj, right.city_name, ''),
							self.subject_current_state 	:= if(_validSubj, right.st, ''),
							self.subject_current_zip  	:= if(_validSubj, right.zip, ''),
							self.subject_dob 						:= if(_validSubj and right.dob>0, (string8) right.dob, ''),
							self.subject_ssn 						:= if(_validSubj, right.ssn, ''),
							self.subject_current_phone  := '',
							self := left), 
					  left outer, keep(1), limit(0));
						
		return ds_recs_with_best;	
		
	end;
	
	export appendPhones(dataset(layout_flat) ds_recs) := function		
	
		dids := dedup(sort(project(ds_recs(did>0), doxie.layout_references), did));
		gong_recs := gong_services.Fetch_Gong_History(dids, SuppressNoncurrent := true);																								
		ds_gong := gong_recs((unsigned)phone10 > 10000000);		
		ds_recs_with_phones := join(ds_recs, ds_gong, left.did = right.did,
																transform(layout_flat, self.subject_current_phone := right.phone10, self := left), 
																left outer, keep(1), limit(0));
																
		return ds_recs_with_phones;		
		
	end;	
	
	export appendProperties(dataset(layout_flat) ds_recs) := function

		// -------------------------------------------------------------------------------
		// Property search:
		//
		// Here's what they want:
		// 	1. If customer provides name, address and ssn, use them all to search. If no properties are found, 
		//     search again using name and address only. 
		//  2. If no ssn is provided, search using provided name and address plus ssn found in best/ADL search (if any).
		//  3. If no SSN is provided and no ssn can be found in best/ADL search, search by name and address only. 
		//
		// Here's what we're doing:
		//	  We'll do the first search using name and address plus any SSN available (either provided from customer or 
		//  found in best/ADL search). Then, for cases where the first search produced no results, we'll run a second
		//  search by name and address only.  
		// 
		// -------------------------------------------------------------------------------
						
		ds_batch_in_for_prop 	:= project(ds_recs, transform(LN_PropertyV2_Services.layouts.batch_in, 
																self.did := 0, self.ssn := if(left.ssn<>'', left.ssn, left.subject_ssn),
																self := left));	
																
		PROP_RECORD_TYPE := ['A', 'D'];
		PROP_PARTY_TYPE	:= LN_PropertyV2.Constants.PARTY_TYPE.PROPERTY +
											 LN_PropertyV2.Constants.PARTY_TYPE.OWNER + 
											 LN_PropertyV2.Constants.PARTY_TYPE.SELLER;
		// first search includes everything, plus ssn from best when ssn has not been provided.									 
		p := BatchServices.Property_BatchService_Records(ds_batch_in_for_prop, PROP_RECORD_TYPE, PROP_PARTY_TYPE);			
		
		ds_batch_in_for_prop_nossn := join(ds_recs(ssn<>''), p.ds_all_fares_ids,
																	left.acctno = right.acctno,
																	transform(LN_PropertyV2_Services.layouts.batch_in, 
																			self.did := 0, self.ssn := '', self := left), 
																	left only);
		// second search being a name and address search only (no ssn), only for cases where first search produced no results. 		
		// NOTE: I'm not convinced that this will add anything to the results, to be honest...
		p_double_dip := BatchServices.Property_BatchService_Records(ds_batch_in_for_prop_nossn, PROP_RECORD_TYPE, PROP_PARTY_TYPE);			
							
		ds_property_recs := 
			JOIN(p.ds_all_fares_ids, p.ds_property_recs, 
					 LEFT.ln_fares_id = RIGHT.ln_fares_id, 
					 transform(BatchServices.Layouts.LN_Property.rec_widest_plus_acctnos, 
										 self := left, self := right),
					 limit(Constants.CapitalGains.JOIN_LIMIT));		
					 
		ds_property_recs_double_dip := 
			JOIN(p_double_dip.ds_all_fares_ids, p_double_dip.ds_property_recs, 
					 LEFT.ln_fares_id = RIGHT.ln_fares_id, 
					 transform(BatchServices.Layouts.LN_Property.rec_widest_plus_acctnos, 
										 self := left, self := right),
					 limit(Constants.CapitalGains.JOIN_LIMIT));																 
		
		ds_property_recs_all := ds_property_recs + ds_property_recs_double_dip;
		
		// -------------------------------------------------------------------------------		
		
		layout_flat appendPropertyInfo(layout_flat l, BatchServices.Layouts.LN_Property.rec_widest_plus_acctnos r) := transform		

			property_party := r.parties( StringLib.StringToLowerCase(party_type_name) = 'property' )[1];
			buyer_party    := r.parties( StringLib.StringToLowerCase(party_type_name) = 'buyer' )[1];
			seller_party   := r.parties( StringLib.StringToLowerCase(party_type_name) = 'seller' )[1];
			owner_party    := r.parties( StringLib.StringToLowerCase(party_type_name) IN ['buyer','assessee'] )[1];
			
			tmp_match_street_address := (property_party.prim_range = l.prim_range AND l.prim_range <> '') AND
																	(property_party.prim_name = l.prim_name AND l.prim_name <> '') AND
																	(property_party.suffix = l.addr_suffix AND l.addr_suffix <> '') AND
																	(property_party.predir = l.predir) AND
																	(property_party.postdir = l.postdir);
			tmp_match_city  := (property_party.p_city_name = l.p_city_name AND l.p_city_name <> '');																						
			tmp_match_state := (property_party.st = l.st AND l.st <> '');
			tmp_match_zip   := (property_party.zip = l.z5 AND l.z5 <> '');			
			tmp_match_address := (tmp_match_street_address and ((tmp_match_city and tmp_match_state) or tmp_match_zip));

			// if property address does not match, drop it.
			self.acctno         := if(tmp_match_address, l.acctno, skip),

			l_row := row(l, LN_PropertyV2_Services.layouts.batch_in);		
			
			// checking name, did and/or ssn for party matching.
			self.isBuyer := batchservices.functions.LN_Property.fn_match_name(buyer_party.entity, l_row) or
					batchservices.functions.LN_Property.fn_match_ssn(buyer_party.entity, l_row) or  			
					batchservices.functions.LN_Property.fn_match_did(buyer_party.entity, l_row); 			
			self.isOwner := batchservices.functions.LN_Property.fn_match_name(owner_party.entity, l_row) or
					batchservices.functions.LN_Property.fn_match_ssn(owner_party.entity, l_row) or  			
					batchservices.functions.LN_Property.fn_match_did(owner_party.entity, l_row); 			
			self.isSeller := batchservices.functions.LN_Property.fn_match_name(seller_party.entity, l_row) or
					batchservices.functions.LN_Property.fn_match_ssn(seller_party.entity, l_row) or  			
					batchservices.functions.LN_Property.fn_match_did(seller_party.entity, l_row); 			
						
			self.error_code     := l.error_code,
			self.sortby_date 		:= r.sortby_date,
			
			self.owner_1_did 					:= (unsigned6) owner_party.entity[1].did,
			self.owner_1_ssn 					:= owner_party.entity[1].app_ssn,
			self.owner_1_first_name 	:= owner_party.entity[1].fname,
			self.owner_1_middle_name 	:= owner_party.entity[1].mname,
			self.owner_1_last_name 		:= owner_party.entity[1].lname,
			self.owner_1_name_suffix 	:= owner_party.entity[1].name_suffix,
			self.owner_2_did 					:= (unsigned6) owner_party.entity[2].did,
			self.owner_2_ssn 					:= owner_party.entity[2].app_ssn,
			self.owner_2_first_name 	:= owner_party.entity[2].fname,
			self.owner_2_middle_name 	:= owner_party.entity[2].mname,
			self.owner_2_last_name 		:= owner_party.entity[2].lname,
			self.owner_2_name_suffix 	:= owner_party.entity[2].name_suffix,		
			
			self.buyer_1_did 					:= (unsigned6) buyer_party.entity[1].did,
			self.buyer_1_ssn 					:= buyer_party.entity[1].app_ssn,
			self.buyer_1_first_name 	:= buyer_party.entity[1].fname,
			self.buyer_1_middle_name 	:= buyer_party.entity[1].mname,
			self.buyer_1_last_name 		:= buyer_party.entity[1].lname,
			self.buyer_1_name_suffix 	:= buyer_party.entity[1].name_suffix,
			self.buyer_2_did 					:= (unsigned6) buyer_party.entity[2].did,
			self.buyer_2_ssn 					:= buyer_party.entity[2].app_ssn,
			self.buyer_2_first_name 	:= buyer_party.entity[2].fname,
			self.buyer_2_middle_name 	:= buyer_party.entity[2].mname,
			self.buyer_2_last_name 		:= buyer_party.entity[2].lname,
			self.buyer_2_name_suffix 	:= buyer_party.entity[2].name_suffix,

			self.seller_1_did 				:= (unsigned6)seller_party.entity[1].did,
			self.seller_1_ssn 				:= seller_party.entity[1].app_ssn,
			self.seller_1_first_name 	:= seller_party.entity[1].fname,
			self.seller_1_middle_name := seller_party.entity[1].mname,
			self.seller_1_last_name 	:= seller_party.entity[1].lname,
			self.seller_1_name_suffix := seller_party.entity[1].name_suffix,
			self.seller_2_did 				:= (unsigned6) seller_party.entity[2].did,
			self.seller_2_ssn 				:= seller_party.entity[2].app_ssn,
			self.seller_2_first_name 	:= seller_party.entity[2].fname,
			self.seller_2_middle_name := seller_party.entity[2].mname,
			self.seller_2_last_name 	:= seller_party.entity[2].lname,
			self.seller_2_name_suffix := seller_party.entity[2].name_suffix,

			self.property_address1    := Address.Addr1FromComponents(property_party.prim_range, 
																															 property_party.predir, 
																															 property_party.prim_name, 
																															 property_party.suffix, 
																															 property_party.postdir, 
																															 '', ''), 
			self.property_address2    := Address.Addr1FromComponents('', '', '', '', '', property_party.unit_desig, property_party.sec_range);
			self.property_city_name 	:= if(property_party.v_city_name<>'', property_party.v_city_name, property_party.p_city_name);    
			self.property_st          := property_party.st;             
			self.property_zip         := property_party.zip;            
			self.property_zip4        := property_party.zip4; 		
			
			_sale_date := map(
				r.fid_type='D' => if(r.deeds[1].contract_date<>'', r.deeds[1].contract_date, r.deeds[1].recording_date),
				r.assessments[1].sale_date 
			);
			_sale_amnt := map(
				r.fid_type='D' => r.deeds[1].sales_price,
				r.assessments[1].sales_price 
			);
			_apn := if(r.fid_type='D', r.deeds[1].apnt_or_pin_number, r.assessments[1].apna_or_pin_number);	
			_unformatted_apn := LN_PropertyV2.fn_strip_pnum(_apn);
			_len := length(trim(_unformatted_apn,all));
			
			self.apn 											:= _apn,
			self.last4APN 								:= _unformatted_apn[_len-3.._len], 
			self.tax_year									:= ((string) r.sortby_date)[1..4],
			self.fid_type 								:= r.fid_type,
			self.vendor_source_flag 			:= r.vendor_source_flag,
			self.ln_fares_id 							:= r.ln_fares_id,
			self.deed_document_type_code 	:= r.deeds[1].document_type_code;
			self.assessment_value 				:= r.assessments[1].assessed_total_value, 
			self.sale_date 								:= _sale_date,
			self.sale_amnt 								:= _sale_amnt,
			self.prior_sale_date 					:= r.assessments[1].prior_recording_date,
			self.sale_days_diff 					:= 0, 
			self.prior_sale_amnt 					:= r.assessments[1].prior_sales_price,
			self.sale_amnt_diff_pct 			:= '',						
			
			self := l			
			
		end;
		
		ds_recs_with_props := join(ds_recs, ds_property_recs_all, 
															 left.acctno = right.acctno, 
															 appendPropertyInfo(left, right),
															 limit(Constants.CapitalGains.JOIN_LIMIT));		
															 
		// Only want assessment records or sale deeds where either owner, buyer or seller match the input suject. 		
		isSaleDateOk 			:= ds_recs_with_props.year='' or (ds_recs_with_props.sale_date<>'' and ((unsigned2)ds_recs_with_props.sale_date[1..4] <= (unsigned2) ds_recs_with_props.year));
		isOwnerOrSeller 	:= ds_recs_with_props.isBuyer or ds_recs_with_props.isOwner or ds_recs_with_props.isSeller;
		isExcluded				:= map(
														ds_recs_with_props.fid_type='A' => // all assessments should be included.
															false,
														ds_recs_with_props.vendor_source_flag='A'=> 
															ds_recs_with_props.deed_document_type_code in BatchServices.Constants.CapitalGains.DOCTYPE_EXCLUSION_SRCA,
														ds_recs_with_props.vendor_source_flag='B'=> 
															ds_recs_with_props.deed_document_type_code in BatchServices.Constants.CapitalGains.DOCTYPE_EXCLUSION_SRCB,
														false);
														
		ds_recs_with_props_filtered := ds_recs_with_props(isOwnerOrSeller, isSaleDateOk, ~isExcluded);		

		ds_too_many_fids 					:= DEDUP(SORT(p.ds_fids(search_status = AutokeyB2_batch.Constants.FAILED_TOO_MANY_MATCHES), acctno), acctno);
	  ds_too_many_property_recs := join(ds_recs, ds_too_many_fids, left.acctno = right.acctno,
																      transform(layout_flat, self.error_code := right.search_status, self := left, self := []));

		// also including cases where we're not returning any property records because we found too many.						
		ds_recs_with_props_ready := ds_recs_with_props_filtered+ds_too_many_property_recs;	
		
		// making sure we return records where no property has been found.
		ds_recs_with_noprops := join(ds_recs, ds_recs_with_props_ready, left.acctno = right.acctno, transform(LEFT), left only);		
		
		return ds_recs_with_props_ready+ds_recs_with_noprops;				
	end;

end;