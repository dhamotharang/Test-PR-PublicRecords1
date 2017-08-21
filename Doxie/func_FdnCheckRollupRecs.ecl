IMPORT doxie, FraudDefenseNetwork_Services;

// *** A function to check for the did(s), address(es), ssn(s) & phone(s) data (passed in from 
// doxie.HeaderFileRollupService) within the FDN data and then populate 1-6 FDN indicator fields
// when applicable.
EXPORT func_FdnCheckRollupRecs (dataset(doxie.Layout_Rollup.KeyRec) ds_in,
		                            unsigned6 in_gc_id,
																unsigned2 in_ind_type,
																unsigned6 in_product_code,
																boolean FDNContDataPermitted, // new DPM 11
																boolean FDNInqDataPermitted   // new DRM 25 
											         ) := FUNCTION

   // local functions
   func_set_indicator(unsigned3 file_type) := function
	   return FraudDefenseNetwork_Services.Functions.set_indicator(file_type, FDNContDataPermitted, FDNInqDataPermitted); 
   end;

   func_set_waf(unsigned file_type, boolean alreadyWAF =false) := function
   	 return FraudDefenseNetwork_Services.Functions.set_waf(file_type,FDNContDataPermitted,alreadyWAF);
   end;
		
    // Add sequence # on each input record for matching to in multiple places later on.
	  doxie.Layout_Rollup.KeyRec_seq_fdn tf_AddSeq(
		  doxie.Layout_Rollup.KeyRec l, integer c) := transform 
		    self.seq := c;
			  self     := l;
	  end;

		ds_in_seq := project(ds_in, tf_AddSeq(left, counter));

	  // First project the sequenced input to split out the "rollup" parent record(s) "did" field
		// (which will be checked in the FDN data) onto separate records since that is what the new
		// FraudDefenseNetwork_Services function is expecting.
		// Also transforming the data onto the layout needed to be passed into the new FraudDefenseNetwork_Services 
		// function and converting the did field into the type expected by the function.
    ds_in_seq_dids := project(ds_in_seq,
		                          transform(FraudDefenseNetwork_Services.Layouts.batch_search_rec,
													     self.did := (unsigned6) left.did;
															 self.seq := left.seq;
															 self := [];  //to null rest of the addr/ssn/phone10 fields
														  ));

    // Filter/sort/dedup the dids recs to only keep unique did values.
    ds_in_seq_dids_dedup := dedup(sort(ds_in_seq_dids(did !=0),did),did);

    // Second, normalize "n" times (where n = count of number of recs in the "addrRecs" child 
	  // dataset), to split out the "addrRecs" child dataset records into separate records. 
	  // Storing all fields from the child dataset record (for use when denormed later). 
	  doxie.Layout_Rollup.AddrRec_seq  tf_NormAddrs(
      doxie.Layout_Rollup.KeyRec_seq_fdn L, integer C) := transform
			  self.seq         := L.seq, 
		    self.addrrec_seq := C,  // will be used to put addrs back into original order
        self             := L.addrRecs[C], // to assign all "addRecs" child dataset fields
	  end;

		ds_in_seq_addrRecs_children := normalize(ds_in_seq,count(left.addrRecs),
		                                         tf_NormAddrs(left,counter));

    // Sort/dedup the normed "addrRecs" children recs to only keep unique address values.
		// Then project onto the layout needed to be passed into the new FraudDefenseNetwork_Services function.
		ds_in_seq_ac_dedup := project(dedup(sort(ds_in_seq_addrRecs_children(prim_name !='' or 
		                                                    city_name !='' or st !='' or zip !=''),
		                                         prim_range,
		                                         predir,
		                                         prim_name,
		                                         suffix,
		                                         postdir, 
		                                         unit_desig,
																						 sec_range,
																						 city_name, st, zip
																						 ),
		                                    prim_range,
		                                    predir,
		                                    prim_name,
		                                    suffix,
		                                    postdir, 
		                                    unit_desig,
																				sec_range,
																				city_name, st, zip
																			 ),
		                              transform(FraudDefenseNetwork_Services.Layouts.batch_search_rec,
			                              self.addr_suffix := left.suffix;
			                              self.v_city_name := left.city_name;
			                              self.zip5        := left.zip;
																		self := left; // to assign all other address parts fields, since field name is the same
                                    self := [] // null all other unused fields
	   														  ));

    // Third, normalize "n" times (where n = count of number of recs in the "phoneRecs" child dataset),
	  // to split out the "phoneRecs" child dataset records (on the AddrRecs child dataset record layout)
	  // into separate records. 
	  // Storing all fields from the "phoneRecs" child dataset (for use when denormed later). 
	  doxie.Layout_Rollup.PhoneRec_seq  tf_NormPhones(
      doxie.Layout_Rollup.AddrRec_seq L, integer C) := transform
			  self.seq          := L.seq, 
        self.addrrec_seq  := L.addrrec_seq,
				self.phonerec_seq := C, // will be used to put phones back into original order 
        self              := L.phoneRecs[C]; // to assign all "phoneRecs" child dataset fields
		end;

		ds_in_seq_phoneRecs_children := normalize(ds_in_seq_addrRecs_children,
		                                          count(left.phoneRecs),
		                                          tf_NormPhones(left,counter));

    // Sort/dedup the normed "phoneRecs" children recs to only keep unique phone #s.
		// Then project onto the layout needed to be passed into the new FraudDefenseNetwork_Services function.
		ds_in_seq_pc_dedup := project(dedup(sort(ds_in_seq_phoneRecs_children(phone !=''),phone),phone),
		                              transform(FraudDefenseNetwork_Services.Layouts.batch_search_rec,
															      self.phone10 := left.phone, // only keep "phoneRecs" phone field
																    self         := [] // null all other unused fields
	   														  ));

		// Fourth, normalize "n" times (where n = count of number of recs in the "ssnRecs" child dataset),
		// to split out the "ssnRecs" child dataset records into separate records. 
		// Storing all fields from the "ssnRecs" child dataset (for use when denormed later).
    doxie.Layout_Rollup.SsnRec_seq  tf_NormSsns(
      doxie.Layout_Rollup.KeyRec_seq_fdn L, integer C) := transform
			  self.seq        := L.seq, 
				self.ssnrec_seq := C,  // will be used to put ssns back into original order
        self            := L.ssnRecs[C]; // to assign all "ssns" child dataset fields???
		end;

   ds_in_seq_ssnRecs_children := normalize(ds_in_seq,count(left.ssnRecs),
	                                         tf_NormSSNs(left,counter));
		
   // Sort/dedup the normed "ssnRecs" children recs to only keep unique ssn values.
	 // Then project onto the layout needed to be passed into the new FraudDefenseNetwork_Services function.
	 ds_in_seq_sc_dedup := project(dedup(sort(ds_in_seq_ssnRecs_children(ssn != ''),ssn),ssn),
		                             transform(FraudDefenseNetwork_Services.Layouts.batch_search_rec,
															      self.ssn := left.ssn, // only keep "ssnRecs" "ssn" field
																    self     := [] // null all other unused fields
	   														 ));

    // Combine the ds of deduped did recs to be checked and  
		// the ds of deduped recs normed from the "addrRecs" child dataset and  
		// the ds of deduped recs normed from the "phoneRecs" child dataset
		//                             (under the "addrRecs" child dataset) and 
		// the ds of deduped recs normed from the "ssnReCs" child dataset
		ds_in_seq_normed_combined := ds_in_seq_dids_dedup +
		                             ds_in_seq_ac_dedup   + 
																 ds_in_seq_pc_dedup   + 
		                             ds_in_seq_sc_dedup;


		// Then call the new FraudDefenseNetwork_Services function to actually check if any of the 4 passed in 
		// fields exist within the FDN data.
    ds_in_fdn_chkd := FraudDefenseNetwork_Services.func_CheckForFdnData(ds_in_seq_normed_combined, 
		                                                    in_gc_id,in_ind_type,in_product_code);


    // Now set any applicable FDN indicators based upon the FraudDefenseNetwork_Services.func_CheckForFdnData results.
		//
    // First join the ds of sequenced input to the ds above out of the FDN function to set the
		// FDN did indicator and the FDN WAF Contrib data indicator.
    doxie.Layout_Rollup.KeyRec_seq_fdn tf_did_info(
      doxie.Layout_Rollup.KeyRec_seq_fdn l, 
		  FraudDefenseNetwork_Services.Layouts.batch_response_rec r) := transform
	      self.fdn_did_ind := func_set_indicator(r.classification_Permissible_use_access.file_type),
			  self.fdn_waf_contrib_data := func_set_waf(r.classification_Permissible_use_access.file_type),
        self := l
    end;

	  ds_in_seq_with_dInd  := join(ds_in_seq, ds_in_fdn_chkd,
														       (unsigned6) left.did = right.did and right.did != 0,
															   tf_did_info(left,right),
													       LEFT OUTER); //to keep all input(left ds) recs whether they had fdn data or not

    // Transform to rollup the records in the dataset out of join above, preferring records with
		// fdn inds set "on" over those without.  This had to be added because of using left outer
		// join below and the right (ds_in_fdn_chkd) ds could have 1 or more records per join element
		// (did, addr, etc.) with different file_type values.
		// Whereas the original ds_in_seq dataset only has 1 record per sequence #. 
		doxie.Layout_Rollup.KeyRec_seq_fdn tf_rollup_did(
		  doxie.Layout_Rollup.KeyRec_seq_fdn l,
			doxie.Layout_Rollup.KeyRec_seq_fdn r) :=transform
			  // keep left fdn ind if set on, otherwise keep right
 	      self.fdn_did_ind          := if(l.fdn_did_ind != 0, l.fdn_did_ind,r.fdn_did_ind);
			  self.fdn_waf_contrib_data := if(l.fdn_waf_contrib_data,l.fdn_waf_contrib_data,r.fdn_waf_contrib_data);
				self := l;
		end;

    // Sort/rollup to only keep 1 rec per seq#
    ds_in_seq_with_dInd_ru := rollup(sort(ds_in_seq_with_dInd, seq), 
		                                   left.seq = right.seq,
                                     tf_rollup_did(left,right));

    // Second, join the ds of "addrRecs" children (with the addrRec_seq value) to the ds above 
		//out of the FDN function to set the FDN addr indicator (and the FDN WAF indicator) on 
		// the "addrRecs" child dataset layout.
    doxie.Layout_Rollup.addrRec_seq tf_addr_info(
      doxie.Layout_Rollup.addrRec_seq l, 
			FraudDefenseNetwork_Services.Layouts.batch_response_rec  r) := transform  
			   self.fdn_addr_ind  := func_set_indicator(r.classification_Permissible_use_access.file_type),
			   self.fdn_waf_contrib_data := func_set_waf(r.classification_Permissible_use_access.file_type,
																	                 l.fdn_waf_contrib_data),
		     self := l
    end;

	  ds_in_seq_ac_with_fdnind := join(ds_in_seq_addrRecs_children, ds_in_fdn_chkd,
														          left.prim_range = right.prim_range  and
														          left.predir     = right.predir      and
													            left.prim_name  = right.prim_name   and
														          left.suffix     = right.addr_suffix and
														          left.postdir    = right.postdir     and
																		  left.unit_desig = right.unit_desig  and
																		  left.sec_range  = right.sec_range   and
														          left.city_name  = right.v_city_name and
														          left.st         = right.st          and
														          left.zip        = right.zip5
																			and 
																		  (right.prim_name != '' or right.v_city_name != '' or
																		   right.st !=''         or right.zip5 !=''),
																		 tf_addr_info(left,right),
													           LEFT OUTER); //to keep all input recs whether they had fdn data or not

    // Transform to rollup the records in the dataset out of the join above, preferring
		// records with fdn inds set "on" over those without.  This had to be added because of using
		// left outer join above and the right (ds_in_fdn_chkd) ds could have 1 or more records per
		// join element (phone) with different file_type values.  
		// Whereas the original ds_in_seq_phones_chlidren dataset only has 1 record per sequence #. 
		doxie.Layout_Rollup.addrRec_seq tf_rollup_addr(
		  doxie.Layout_Rollup.addrRec_seq l,
			doxie.Layout_Rollup.addrRec_seq r) :=transform
			  // keep left fdn ind if set on, otherwise keep right
 	      self.fdn_addr_ind         := if(l.fdn_addr_ind != 0, l.fdn_addr_ind,r.fdn_addr_ind);
			  self.fdn_waf_contrib_data := if(l.fdn_waf_contrib_data,l.fdn_waf_contrib_data,r.fdn_waf_contrib_data);
				self := l;
		end;

    // Sort/rollup to only keep 1 rec per seq# & addrrec_seq
    ds_in_seq_ac_with_fdnind_ru := rollup(sort(ds_in_seq_ac_with_fdnind, seq, addrrec_seq), 
		                                             left.seq         = right.seq and
																								 left.addrrec_seq = right.addrrec_seq,
                                               tf_rollup_addr(left,right));

    // Third, join the ds of "phoneRecs" children to the ds above out of the FDN function to next 
		// set the FDN phone indicator (and the FDN WAF indicator) on the phoneRecs child dataset layout
    doxie.Layout_Rollup.PhoneRec_seq tf_phone_info(
      doxie.Layout_Rollup.PhoneRec_seq l, 
			FraudDefenseNetwork_Services.Layouts.batch_response_rec   r) := transform  
        self.fdn_phone_ind := func_set_indicator(r.classification_Permissible_use_access.file_type),
			  self.fdn_waf_contrib_data := func_set_waf(r.classification_Permissible_use_access.file_type,
				  													              l.fdn_waf_contrib_data),
        self := l
    end;

	  ds_in_seq_pc_with_fdnind := join(ds_in_seq_phoneRecs_children, ds_in_fdn_chkd,
																       left.phone = right.phone10,
														         tf_phone_info(left,right),
													           LEFT OUTER //to keep all input recs whether they had fdn data or not
												            );

    // Transform to rollup the records in the dataset out of the join above, preferring
		// records with fdn inds set "on" over those without.  This had to be added because of using
		// left outer join above and the right (ds_in_fdn_chkd) ds could have 1 or more records per
		// join element (phone) with different file_type values.  
		// Whereas the original ds_in_seq_phones_chlidren dataset only has 1 record per sequence #. 
		doxie.Layout_Rollup.PhoneRec_seq tf_rollup_phone(
		  doxie.Layout_Rollup.PhoneRec_seq l,
			doxie.Layout_Rollup.PhoneRec_seq r) :=transform
			  // keep left fdn ind if set on, otherwise keep right
 	      self.fdn_phone_ind        := if(l.fdn_phone_ind != 0, l.fdn_phone_ind,r.fdn_phone_ind);
			  self.fdn_waf_contrib_data := if(l.fdn_waf_contrib_data,l.fdn_waf_contrib_data,r.fdn_waf_contrib_data);
				self := l;
		end;

    // Sort/rollup to only keep 1 rec per seq#/addrrec_seq/phonerec_seq
    ds_in_seq_pc_with_fdnind_ru := rollup(sort(ds_in_seq_pc_with_fdnind, seq,addrRec_seq,phonerec_seq),
		                                             left.seq          = right.seq         and
																								 left.addrRec_seq  = right.addrRec_seq and
																								 left.phonerec_seq = right.phonerec_seq,
                                               tf_rollup_phone(left,right));

    // Fourth, join the ds of "ssns" children to the ds above out of the FDN function to next 
		// set the FDN ssn indicator (and the FDN WAF indicator) on the ssns child dataset layout???
    doxie.Layout_Rollup.SsnRec_seq tf_ssn_info(
      doxie.Layout_Rollup.SsnRec_seq          l, 
		  FraudDefenseNetwork_Services.Layouts.batch_response_rec r) := transform  
        self.fdn_ssn_ind := func_set_indicator(r.classification_Permissible_use_access.file_type),
			  self.fdn_waf_contrib_data := func_set_waf(r.classification_Permissible_use_access.file_type,
																	                l.fdn_waf_contrib_data),
        self := l
    end;

	  ds_in_seq_sc_with_fdnind := join(ds_in_seq_ssnRecs_children, ds_in_fdn_chkd,
											                 left.ssn = right.ssn,
														         tf_ssn_info(left,right),
													           LEFT OUTER //to keep all input recs whether they had fdn data or not
												            );

    // Transform to rollup the records in the dataset out of the join above, preferring
		// records with fdn inds set "on" over those without.  This had to be added because of using
		// left outer join above and the right (ds_in_fdn_chkd) ds could have 1 or more records per
		// join element (phone) with different file_type values.  
		// Whereas the original ds_in_seq_phones_chlidren dataset only has 1 record per sequence #. 
		doxie.Layout_Rollup.SsnRec_seq tf_rollup_ssn(
		  doxie.Layout_Rollup.SsnRec_seq l,
			doxie.Layout_Rollup.SsnRec_seq r) :=transform
			  // keep left fdn ind if set on, otherwise keep right
 	      self.fdn_ssn_ind          := if(l.fdn_ssn_ind != 0, l.fdn_ssn_ind,r.fdn_ssn_ind);
			  self.fdn_waf_contrib_data := if(l.fdn_waf_contrib_data,l.fdn_waf_contrib_data,r.fdn_waf_contrib_data);
				self := l;
		end;

    // Sort/rollup to only keep 1 rec per seq#
    ds_in_seq_sc_with_fdnind_ru := rollup(sort(ds_in_seq_sc_with_fdnind, seq, ssnrec_seq), 
		                                             left.seq        = right.seq and
																								 left.ssnrec_seq = right.ssnrec_seq,
                                               tf_rollup_ssn(left,right));


    // First denormalize using the interim ds with the "addrRecs" fdn_addr_ind set and 
		// the interim ds with the "phoneRecs" fdn_phone_ind set to re-create the original
		// "phoneRecs" child dataset records (under the "addrRecs" child dataset records).
		doxie.Layout_Rollup.AddrRec_seq  tf_denorm_phones(
		  doxie.Layout_Rollup.AddrRec_seq l,
		  dataset(doxie.Layout_Rollup.PhoneRec_seq) r) := transform
		    self.phoneRecs := project(dedup(sort(r(phone !=''), //so empty phoneRecs don't get output.  is this needed???
                                             phonerec_seq, -fdn_phone_ind, -fdn_waf_contrib_data),
		                                    phonerec_seq),
																	doxie.Layout_Rollup.PhoneRec); // to re-assign all "phoneRecs" fields & new fdn_phone_ind
        self.fdn_waf_contrib_data := l.fdn_waf_contrib_data or //if fdn waf already on/true, leave it on
				                             // if any phoneRecs child dataset rec had the fdn waf set on 
        														 EXISTS(r(fdn_waf_contrib_data = true)),
        self.fdn_results_found    := l.fdn_results_found or //if fdn results found already on/true, leave it on
				                             // if any phoneRecs child dataset rec had the fdn ind or waf set on 
        														 EXISTS(r(fdn_phone_ind != 0 or fdn_waf_contrib_data = true)),
        self.fdn_indicators_returned := l.fdn_indicators_returned or //if fdn inds returned already on/true, leave it on
				                                // if any phoneRecs child dataset rec had the fdn ind set on 
        														    EXISTS(r(fdn_phone_ind != 0)),
			  self := l;
		end;

		ds_in_seq_denorm_phones := denormalize(ds_in_seq_ac_with_fdnind_ru,
																					 ds_in_seq_pc_with_fdnind_ru,
		                                       left.seq         = right.seq and
																					 left.addrrec_seq = right.addrrec_seq,
																		       group,
																		       tf_denorm_phones(left,rows(right)));

    // Next denormalize using the interim ds with the fdn_did_ind set and the interim ds with 
		// the "addrRecs" (with denormed "phoneRecs") with the fdn_addr_ind set to re-create the 
		// original "addrRecs" child dataset records.
		doxie.Layout_Rollup.KeyRec_seq_fdn  tf_denorm_addrs(
		  doxie.Layout_Rollup.KeyRec_seq_fdn l,
		  dataset(doxie.Layout_Rollup.AddrRec_seq) r) := transform  
		    self.addrRecs := project(dedup(sort(r,addrrec_seq, -fdn_addr_ind, -fdn_waf_contrib_data),
																	 		 addrrec_seq),
																 doxie.Layout_Rollup.AddrRec); // to re-assign all "addr" fields & new fdn_addr_ind
       self.fdn_waf_contrib_data := l.fdn_waf_contrib_data or //if fdn waf already on/true, leave it on
				                            // if any ssns child dataset rec had the fdn waf set on 
        														EXISTS(r(fdn_waf_contrib_data = true)),
       self.fdn_results_found    := l.fdn_results_found or //if fdn results found already on/true, leave it on
				                            // if any addr child dataset rec had the fdn ind or waf set on 
        												    EXISTS(r(fdn_addr_ind != 0 or fdn_waf_contrib_data = true)),
       self.fdn_indicators_returned := l.fdn_indicators_returned or //if fdn inds returned already on/true, leave it on
				                               // if any addr child dataset rec had the fdn ind set on 
        														   EXISTS(r(fdn_addr_ind != 0)),
			  self := l;
		end;

		ds_in_seq_denorm_addrs := denormalize(ds_in_seq_with_dInd_ru,
																					ds_in_seq_denorm_phones,  
		                                      left.seq = right.seq,
																		      group,
																		      tf_denorm_addrs(left,rows(right)));

    // Next denormalize using the interim ds with the "addrRecs" fdn_addr_ind set and 
		// the interim ds with the "ssnRecs" fdn_ssn_ind set to re-create the original "ssnRecs" 
		// child dataset records.
		doxie.Layout_Rollup.KeyRec_seq_fdn    tf_denorm_ssns(
		  doxie.Layout_Rollup.KeyRec_seq_fdn l,
		  dataset(doxie.Layout_Rollup.SsnRec_seq) r) := transform
		    self.ssnRecs := project(dedup(sort(r(ssn !=''), //so empty ssn recs don't get output
		                                       ssnrec_seq, -fdn_ssn_ind, -fdn_waf_contrib_data),
		                                  ssn),
											          doxie.Layout_Rollup.SsnRec); // to re-assign all "ssns" fields & new fdn ssn ind
       self.fdn_waf_contrib_data := l.fdn_waf_contrib_data or //if fdn waf already on/true, leave it on
				                            // if any ssns child dataset rec had the fdn waf set on 
        														EXISTS(r(fdn_waf_contrib_data = true)),
       self.fdn_results_found    := l.fdn_results_found or //if fdn results found already on/true, leave it on
				                            // if any ssns child dataset rec had the fdn ind or waf set on 
        												    EXISTS(r(fdn_ssn_ind != 0 or fdn_waf_contrib_data = true)),
       self.fdn_indicators_returned := l.fdn_indicators_returned or //if fdn inds returned already on/true, leave it on
				                               // if any ssns child dataset rec had the fdn ind set on 
        														   EXISTS(r(fdn_ssn_ind != 0)),
			 self := l;
		end;

		ds_in_seq_denorm_ssns   := denormalize(ds_in_seq_denorm_addrs,
																					 ds_in_seq_sc_with_fdnind_ru,
		                                       left.seq = right.seq,
																		       group,
																		       tf_denorm_ssns(left,rows(right)));

		// Final project to strip off seq and to set fdn_results_found (for web use only) and 
		// set fdn_indicators_found (for ESP billing use only).
    boolean AnyFdnIndorWafWasSet := exists(ds_in_seq_denorm_ssns(fdn_did_ind != 0     or
                                                                 fdn_waf_contrib_data or
																													       fdn_results_found)); 

    boolean AnyFdnIndWasSet := exists(ds_in_seq_denorm_ssns(fdn_did_ind != 0 or
																														fdn_indicators_returned));

		ds_in_with_fdninds := project(ds_in_seq_denorm_ssns,
		                              transform(doxie.Layout_Rollup.KeyRec,
																	  self.fdn_results_found       := AnyFdnIndOrWafWasSet;
																	  self.fdn_indicators_returned := AnyFdnIndWasSet;
																    self                         := left));

    // For debugging, uncomment as needed
     //output(ds_in,                 named('ds_in'));
	   //output(in_gc_id,              named('in_gc_id'));
	   //output(in_ind_type,           named('in_ind_type'));
	   //output(in_product_code,       named('in_product_code'));
	   //output(FDNContDataPermitted,  named('FDNContDataPermitted'));
	   //output(FDNInqDataPermitted,   named('FDNInqDataPermitted'));

     //output(ds_in_seq,                        named('ds_in_seq'));
     //output(ds_in_seq_dids,                   named('ds_in_seq_dids'));
     //output(ds_in_seq_dids_dedup,             named('ds_in_seq_dids_dedup'));
     //output(ds_in_seq_addrRecs_children,      named('ds_in_seq_addrRecs_children'));
		 //output(ds_in_seq_ac_dedup,               named('ds_in_seq_ac_dedup'));
     //output(ds_in_seq_phoneRecs_children,     named('ds_in_seq_phoneRecs_children'));
		 //output(ds_in_seq_pc_dedup,               named('ds_in_seq_pc_dedup'));
     //output(ds_in_seq_ssnRecs_children,       named('ds_in_seq_ssnRecs_children'));
		 //output(ds_in_seq_sc_dedup,               named('ds_in_seq_sc_dedup'));
     //output(ds_in_seq_normed_combined, named('ds_in_seq_normed_combined'));
		 //output(ds_in_fdn_chkd,            named('ds_in_fdn_chkd'));
     //output(ds_in_seq_with_dInd,     named('ds_in_seq_with_dInd'));
     //output(ds_in_seq_with_dInd_ru,  named('ds_in_seq_with_dInd_ru'));
		 //output(ds_in_seq_ac_with_fdnind, named('ds_in_seq_ac_with_fdnind'));
     //output(ds_in_seq_ac_with_fdnInd_ru, named('ds_in_seq_ac_with_fdnind_ru'));
     //output(ds_in_seq_pc_with_fdnind, named('ds_in_seq_pc_with_fdnind'));
     //output(ds_in_seq_pc_with_fdnInd_ru, named('ds_in_seq_pc_with_fdnind_ru'));
		 //output(ds_in_seq_sc_with_fdnind, named('ds_in_seq_sc_with_fdnind'));
     //output(ds_in_seq_sc_with_fdnInd_ru, named('ds_in_seq_sc_with_fdnind_ru'));
     //output(ds_in_seq_denorm_phones,  named('ds_in_seq_denorm_phones'));
     //output(ds_in_seq_denorm_addrs,  named('ds_in_seq_denorm_addrs'));
     //output(ds_in_seq_denorm_ssns,    named('ds_in_seq_denorm_ssns'));
     //output(AnyFdnIndorWafWasSet,        named('AnyFdnIndorWafWasSet'));
     //output(AnyFdnIndWasSet,          named('AnyFdnIndWasSet'));
     //output(ds_in_with_fdnInds,      named('ds_in_with_fdnInds'));
		
		RETURN ds_in_with_fdninds;

END; // end of func_FdnCheckRollupRecs
