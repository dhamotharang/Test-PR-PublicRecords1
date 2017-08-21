IMPORT doxie, FraudDefenseNetwork_Services, PersonSearch_Services;

// *** A function to check for the did(s), address(es), ssn(s) & phone(s) data (passed in from 
// doxie.HeaderFileSearchService) within the FDN data and then populate 1-7 FDN indicator fields
// when applicable.
EXPORT func_FdnCheckSearchRecs (dataset(doxie.Layout_Search.rec_with_feedback) ds_in, 
		                            unsigned6 in_gc_id,
																unsigned2 in_ind_type,
																unsigned6 in_product_code,
																boolean FDNContDataPermitted, // new DPM 11=1
																boolean FDNInqDataPermitted   // new DRM 25=0 
												       ) := FUNCTION

   // local functions
   func_set_indicator(unsigned3 file_type) := function
	   return FraudDefenseNetwork_Services.Functions.set_indicator(file_type, FDNContDataPermitted, FDNInqDataPermitted); 
   end;

   func_set_waf(unsigned file_type, boolean alreadyWAF =false) := function
   	 return FraudDefenseNetwork_Services.Functions.set_waf(file_type,FDNContDataPermitted,alreadyWAF);
   end;

    // Add sequence # on each input record for use in multiple sorts/dedups later on.
    doxie.Layout_Search.rec_with_Feedback_inseq tf_AddSeq(
		  doxie.Layout_Search.rec_with_Feedback l, integer c) := transform 
		    self.in_seq := c;
			  self        := l;
	  end;

		ds_in_seq := project(ds_in, tf_AddSeq(left, counter));

  // First "Normalize" the sequenced input, 5 times to split out the 5 pieces of data 
		// (to be checked for in the FDN data) onto separate records since that is what the new
		// FraudDefenseNetwork_Services function is expecting.
		// Check the counter: when 1 assign did,  when 2 assign address fields, 
		//                    when 3 assign ssn,  when 4 assign phone, when 5 assign listed_phone
		// Also transforming the data onto the layout needed to be passed into the new FraudDefenseNetwork_Services 
		// function and converting the did field into the type expected by the function.
    FraudDefenseNetwork_Services.Layouts.batch_search_rec  tf_NormAndSlim(
     doxie.Layout_Search.rec_with_Feedback_inseq L, integer C) := transform
		   self.did         := choose(C,(unsigned6)L.did,0,0,0,0);
			 self.prim_range  := choose(C,'',L.prim_range,'','','');
			 self.predir      := choose(C,'',L.predir,'','','');    
			 self.prim_name   := choose(C,'',L.prim_name,'','','');
			 self.addr_suffix := choose(C,'',L.suffix,'','','');
			 self.postdir     := choose(C,'',L.postdir,'','',''); 
			 self.unit_desig  := choose(C,'',L.unit_desig,'','','');
			 self.sec_range   := choose(C,'',L.sec_range,'','',''); 
			 self.v_city_name := choose(C,'',L.city_name,'','','');
			 self.st          := choose(C,'',L.st,'','','');
			 self.zip5        := choose(C,'',L.zip,'','','');
			 self.zip4        := choose(C,'',L.zip4,'','','');      
			 self.ssn         := choose(C,'','',L.ssn,'','');
			 self.phone10     := choose(C,'','','',L.phone,L.listed_phone);
			 self.seq         := L.in_seq; // to store seq# on every record
			 self := []; // Added for FDN Expanded layout
		end;

		ds_in_seq_norm5slim := normalize(ds_in_seq,5,tf_NormAndSlim(left,counter));

		// Next normalize "n" times (where n = count of number of recs in the "phones" child dataset),
		// to split out the "phones" child dataset records into separate records. 
		// Storing all fields from the "phones" child dataset (for use when denormed later). 
		PersonSearch_Services.Layouts.rec_layout_phones_seq tf_NormPhones(
			doxie.Layout_Search.rec_with_Feedback_inseq L, integer C) := transform
			  self.seq          := L.in_seq, 
				self.phonerec_seq := C, // will be used to put phones back into original order 
        self              := L.phones[C]; // to assign all "phones" child dataset fields
		end;

		ds_in_seq_phones_children := normalize(ds_in_seq,count(left.phones),
		                                       tf_NormPhones(left,counter));

    // Sort/dedup the normed phones children recs to only keep unique phone10 values.
		// Then project onto the layout needed to be passed into the new FraudDefenseNetwork_Services function.
		ds_in_seq_pc_dedup := project(dedup(sort(ds_in_seq_phones_children(phone10!=''),
		                                    phone10),phone10),
		                              transform(FraudDefenseNetwork_Services.Layouts.batch_search_rec,
															      self.phone10 := left.phone10, // only keep "phones" phones10
																    self         := [] // null all other unused fields
	   														  ));

    // Combine the ds normed for the 5 data pieces to be checked and  
		// the ds of deduped recs normed from the phones child dataset.
		ds_in_seq_normed_combined := ds_in_seq_norm5slim + ds_in_seq_pc_dedup;

    // Filter out records with no data fields to be checked.  Then sort/dedup the records being 
		// passed into the new FraudDefenseNetwork_Services function to remove duplicates.
    ds_in_seq_nc_dedup := dedup(sort(ds_in_seq_normed_combined
		                                   //filter to only include recs with at least 1 piece of data???
																	     (did !=0 or ssn !='' or phone10 !='' or 
																		    prim_name !='' or v_city_name !='' or st !='' or zip5 !=''),
                                     record,except seq),
																record,except seq);
																
		// Then call new FraudDefenseNetwork_Services function to actually check if any of the 
		// input fields exist in the FDN data.
		ds_in_fdn_chkd := FraudDefenseNetwork_Services.func_CheckForFdnData(ds_in_seq_nc_dedup,
		                                                    in_gc_id,in_ind_type,in_product_code);  


    // Now set any applicable FDN indicators based upon the FraudDefenseNetwork_Services.func_CheckForFdnData results.
		//
    // Transform to rollup the records in the dataset out of multiple joins below, preferring
		// records with fdn inds set "on" over those without.  This had to be added because of using
		// left outer joins below and the right (ds_in_fdn_chkd) ds could have 1 or more records per
		// join element (did, addr, etc.) with different file_type values.  
		// Whereas the original ds_in_seq dataset only has 1 record per sequence #. 
		doxie.Layout_Search.rec_with_Feedback_inseq tf_rollup_fdn(
		  doxie.Layout_Search.rec_with_Feedback_inseq l,
			doxie.Layout_Search.rec_with_Feedback_inseq r) :=transform
			  // keep left fdn ind if set on, otherwise keep right
 	      self.fdn_did_ind          := if(l.fdn_did_ind != 0, l.fdn_did_ind,r.fdn_did_ind);
			  self.fdn_addr_ind         := if(l.fdn_addr_ind != 0, l.fdn_addr_ind,r.fdn_addr_ind);
 	      self.fdn_ssn_ind          := if(l.fdn_ssn_ind != 0, l.fdn_ssn_ind,r.fdn_ssn_ind);
 	      self.fdn_phone_ind        := if(l.fdn_phone_ind != 0, l.fdn_phone_ind,r.fdn_phone_ind);
 	      self.fdn_listed_phone_ind := if(l.fdn_listed_phone_ind != 0, l.fdn_listed_phone_ind,r.fdn_listed_phone_ind);
			  self.fdn_waf_contrib_data := if(l.fdn_waf_contrib_data,l.fdn_waf_contrib_data,r.fdn_waf_contrib_data);
				self := l;
		end;
		
    // First join the ds of sequenced input to the ds above out of the FDN function to set the
		// FDN did indicator and the FDN WAF Contrib data indicator.
    doxie.Layout_Search.rec_with_Feedback_inseq tf_did_info(
		  doxie.Layout_Search.rec_with_Feedback_inseq l, 
			FraudDefenseNetwork_Services.Layouts.batch_response_rec r) := transform
	      self.fdn_did_ind := func_set_indicator(r.classification_Permissible_use_access.file_type),
			  self.fdn_waf_contrib_data := func_set_waf(r.classification_Permissible_use_access.file_type),
        self := l
    end;
		
	  ds_in_seq_with_dInd := join(ds_in_seq, ds_in_fdn_chkd,
														      (unsigned6) left.did = right.did and right.did != 0,
																tf_did_info(left,right),
													      LEFT OUTER); //to keep all input recs whether they had fdn data or not

    // Sort/rollup to only keep 1 rec per seq#
    ds_in_seq_with_dInd_ru := rollup(sort(ds_in_seq_with_dInd, in_seq), 
		                                   left.in_seq = right.in_seq,
                                     tf_rollup_fdn(left,right));

    // Second, join the ds out of first join to the ds above out of the FDN function to next 
		// set the FDN addr indicator or the FDN WAF indicator.
     doxie.Layout_Search.rec_with_Feedback_inseq tf_addr_info(
       doxie.Layout_Search.rec_with_Feedback_inseq l, 
			 FraudDefenseNetwork_Services.Layouts.batch_response_rec  r) := transform  
			   self.fdn_addr_ind  := func_set_indicator(r.classification_Permissible_use_access.file_type),
			   self.fdn_waf_contrib_data := func_set_waf(r.classification_Permissible_use_access.file_type,
																	                 l.fdn_waf_contrib_data),
		     self := l
    end;
		
	  ds_in_seq_with_daInds := join(ds_in_seq_with_dInd_ru, ds_in_fdn_chkd,
														        left.prim_range = right.prim_range  and
														        left.predir     = right.predir      and
													          left.prim_name  = right.prim_name   and
														        left.suffix     = right.addr_suffix and
														        left.postdir    = right.postdir     and
														        left.city_name  = right.v_city_name and
														        left.st         = right.st          and
														        left.zip        = right.zip5
																		and 
																		(right.prim_name != '' or right.v_city_name != '' or
																		 right.st !=''         or right.zip5 !=''),
																	tf_addr_info(left,right),
													        LEFT OUTER); //to keep all input recs whether they had fdn data or not

    // Sort/rollup to only keep 1 rec per seq#
    ds_in_seq_with_daInds_ru := rollup(sort(ds_in_seq_with_daInds, in_seq), 
		                                     left.in_seq = right.in_seq,
                                       tf_rollup_fdn(left,right));

    // Third, join the ds out of second join to the ds above out of the FDN function to next 
		// set the FDN ssn indicator and/or the FDN WAF indicator.
    doxie.Layout_Search.rec_with_Feedback_inseq tf_ssn_info(
      doxie.Layout_Search.rec_with_Feedback_inseq l, 
		  FraudDefenseNetwork_Services.Layouts.batch_response_rec r) := transform
        self.fdn_ssn_ind := func_set_indicator(r.classification_Permissible_use_access.file_type),
			  self.fdn_waf_contrib_data := func_set_waf(r.classification_Permissible_use_access.file_type,
																	                l.fdn_waf_contrib_data),
        self := l
    end;
	
	  ds_in_seq_with_dasInds := join(ds_in_seq_with_daInds_ru, ds_in_fdn_chkd,
											               left.ssn = right.ssn and right.ssn != '',
																	 tf_ssn_info(left,right),
													         LEFT OUTER); //to keep all input recs whether they had fdn data or not

    // Sort/rollup to only keep 1 rec per seq#
    ds_in_seq_with_dasInds_ru := rollup(sort(ds_in_seq_with_dasInds, in_seq), 
		                                     left.in_seq = right.in_seq,
                                        tf_rollup_fdn(left,right));

    // Fourth, join the ds out of third join to the ds above out of the FDN function to next 
		// set the FDN phone indicator and/or the FDN WAF indicator.
    doxie.Layout_Search.rec_with_Feedback_inseq tf_phone_info(
      doxie.Layout_Search.rec_with_Feedback_inseq l, 
			FraudDefenseNetwork_Services.Layouts.batch_response_rec   r) := transform  
        self.fdn_phone_ind := func_set_indicator(r.classification_Permissible_use_access.file_type),
			  self.fdn_waf_contrib_data := func_set_waf(r.classification_Permissible_use_access.file_type,
				  													              l.fdn_waf_contrib_data),
        self := l
    end;
		
    ds_in_seq_with_daspInds := join(ds_in_seq_with_dasInds_ru, ds_in_fdn_chkd,
														          left.phone = right.phone10 and right.phone10 != '',
																	  tf_phone_info(left,right),
													          LEFT OUTER); //to keep all input recs whether they had fdn data or not

    // Sort/rollup to only keep 1 rec per seq#
    ds_in_seq_with_daspInds_ru := rollup(sort(ds_in_seq_with_daspInds, in_seq), 
		                                       left.in_seq = right.in_seq,
                                         tf_rollup_fdn(left,right));

    // Fifth, join the ds out of fourth join to the ds above out of the FDN function to next 
		// set the FDN listed_phone indicator and the FDN WAF indicator.
    doxie.Layout_Search.rec_with_Feedback_inseq tf_listed_phone_info(
      doxie.Layout_Search.rec_with_Feedback_inseq l, 
			FraudDefenseNetwork_Services.Layouts.batch_response_rec   r) := transform  
        self.fdn_listed_phone_ind := func_set_indicator(r.classification_Permissible_use_access.file_type),
			  self.fdn_waf_contrib_data := func_set_waf(r.classification_Permissible_use_access.file_type,
																	                l.fdn_waf_contrib_data),
        self := l
    end;
		
    ds_in_seq_with_dasplInds := join(ds_in_seq_with_daspInds_ru, ds_in_fdn_chkd,
														          left.listed_phone = right.phone10 and right.phone10 != '',
																	   tf_listed_phone_info(left,right),
													           LEFT OUTER); //to keep all input recs whether they had fdn data or not

    // Sort/rollup to only keep 1 rec per seq#
    ds_in_seq_with_dasplInds_ru := rollup(sort(ds_in_seq_with_dasplInds, in_seq), 
		                                        left.in_seq = right.in_seq,
                                          tf_rollup_fdn(left,right));

    // Sixth, join the ds of "phones" children to the ds out of the FDN function to next 
		// set the FDN phone indicator (and FDN Waf indicator) on the "phones" child dataset layout
    PersonSearch_Services.Layouts.rec_layout_phones_seq tf_phone_child_info(
      PersonSearch_Services.Layouts.rec_layout_phones_seq l, 
			FraudDefenseNetwork_Services.Layouts.batch_response_rec   r) := transform  
        self.fdn_phone_ind := func_set_indicator(r.classification_Permissible_use_access.file_type),
			  self.fdn_waf_contrib_data := func_set_waf(r.classification_Permissible_use_access.file_type,
																	                l.fdn_waf_contrib_data),
        self := l
    end;

	  ds_in_seq_pc_with_fdnind := join(ds_in_seq_phones_children, ds_in_fdn_chkd,
																        left.phone10 = right.phone10 and right.phone10 !='',
																		 tf_phone_child_info(left,right),
													           LEFT OUTER); //to keep all input recs whether they had fdn data or not

    // Transform to rollup the records in the dataset out of the join above, preferring
		// records with fdn inds set "on" over those without.  This had to be added because of using
		// left outer join above and the right (ds_in_fdn_chkd) ds could have 1 or more records per
		// join element (phone) with different file_type values.  
		// Whereas the original ds_in_seq_phones_chlidren dataset only has 1 record per sequence #. 
		PersonSearch_Services.Layouts.rec_layout_phones_seq tf_rollup_fdnpc(
		  PersonSearch_Services.Layouts.rec_layout_phones_seq l,
			PersonSearch_Services.Layouts.rec_layout_phones_seq r) :=transform
			  // keep left fdn ind if set on, otherwise keep right
 	      self.fdn_phone_ind        := if(l.fdn_phone_ind != 0, l.fdn_phone_ind,r.fdn_phone_ind);
			  self.fdn_waf_contrib_data := if(l.fdn_waf_contrib_data,l.fdn_waf_contrib_data,r.fdn_waf_contrib_data);
				self := l;
		end;

    // Sort/rollup to only keep 1 rec per seq#/phonerec_seq
    ds_in_seq_pc_with_fdnind_ru := rollup(sort(ds_in_seq_pc_with_fdnind, seq, phonerec_seq), 
		                                        left.seq          = right.seq and
																					  left.phonerec_seq = right.phonerec_seq,
                                          tf_rollup_fdnpc(left,right));

    // Now denormalize using the sequenced input ds and the interim ds with the phones fdn phone
		// indicator set to re-create the original "phones" child dataset records and setting the   
		// fdn phone indicator for the phone10s on the phones child dataset.
    doxie.Layout_Search.rec_with_Feedback_inseq  tf_denorm_phones(
			doxie.Layout_Search.rec_with_Feedback_inseq l,
		  dataset(PersonSearch_Services.Layouts.rec_layout_phones_seq) r) := transform
		    self.phones := project(r(phone10 !=''),doxie.Layout_phones), // to re-assign all "phones" fields & new fdn inds
        self.fdn_waf_contrib_data := l.fdn_waf_contrib_data or //if fdn waf already on/true, leave it on
				                             // or if any phones child dataset rec had the fdn waf set on 
        														 EXISTS(r(fdn_waf_contrib_data = true)),
        self.fdn_results_found    := l.fdn_results_found or //if fdn results found already on/true, leave it on
				                             // or if any phoneRecs child dataset rec had the fdn ind or waf set on 
        														 EXISTS(r(fdn_phone_ind != 0 or fdn_waf_contrib_data = true)),
        self.fdn_indicators_returned := l.fdn_indicators_returned or //if fdn inds returned already on/true, leave it on
				                                // or if any phoneRecs child dataset rec had the fdn ind set on 
        														    EXISTS(r(fdn_phone_ind != 0)),
			  self := l;
		end;

		ds_in_seq_denorm_phones := denormalize(ds_in_seq_with_dasplInds_ru, ds_in_seq_pc_with_fdnind_ru,
		                                          left.in_seq = right.seq,
																		       group,
																		       tf_denorm_phones(left,rows(right)));

		// Final project to strip off seq and to set fdn_results_found (for web use only) and 
		// set fdn_indicators_found (for ESP billing use only).
    boolean AnyFdnIndOrWafWasSet := exists(ds_in_seq_denorm_phones(fdn_did_ind          != 0 or
		                                                               fdn_addr_ind         != 0 or
		                                                               fdn_ssn_ind          != 0 or
	                                                                 fdn_phone_ind        != 0 or
																															     fdn_listed_phone_ind != 0 or
                                                                   fdn_waf_contrib_data      or
																																	 fdn_results_found)); 

    boolean AnyFdnIndWasSet := exists(ds_in_seq_denorm_phones(fdn_did_ind          != 0 or
		                                                          fdn_addr_ind         != 0 or
		                                                          fdn_ssn_ind          != 0 or
	                                                            fdn_phone_ind        != 0 or
																															fdn_listed_phone_ind != 0 or
																															fdn_indicators_returned));

		ds_in_with_fdninds := project(ds_in_seq_denorm_phones,
		                              transform(doxie.Layout_Search.rec_with_Feedback,
																	  self.fdn_results_found       := AnyFdnIndOrWafWasSet;
																	  self.fdn_indicators_returned := AnyFdnIndWasSet;
																	  self                   := left));


    // For debugging, uncomment as needed
     //output(ds_in,                 named('ds_in'));
	   //output(in_gc_id,              named('in_gc_id'));
	   //output(in_ind_type,           named('in_ind_type'));
	   //output(in_product_code,       named('in_product_code'));
	   //output(FDNContDataPermitted,  named('FDNContDataPermitted'));
	   //output(FDNInqDataPermitted,   named('FDNInqDataPermitted'));

     //output(ds_in_seq,                  named('ds_in_seq'));
     //output(ds_in_seq_norm5slim,        named('ds_in_seq_norm5slim'));
     //output(ds_in_seq_phones_children,  named('ds_in_seq_phones_children'));
		 //output(ds_in_seq_pc_dedup,         named('ds_in_seq_pc_dedup'));
     //output(ds_in_seq_normed_combined,  named('ds_in_seq_normed_combined'));
     //output(ds_in_seq_nc_dedup,         named('ds_in_seq_nc_dedup'));
		 //output(ds_in_fdn_chkd,             named('ds_in_fdn_chkd'));
     //output(ds_in_seq_with_dInd,        named('ds_in_seq_with_dInd'));
     //output(ds_in_seq_with_dInd_ru,     named('ds_in_seq_with_dInd_ru'));
		 //output(ds_in_seq_with_daInds,      named('ds_in_seq_with_daInds'));
     //output(ds_in_seq_with_daInds_ru,   named('ds_in_seq_with_daInds_ru'));
     //output(ds_in_seq_with_dasInds,     named('ds_in_seq_with_dasInds'));
     //output(ds_in_seq_with_dasInds_ru,  named('ds_in_seq_with_dasInds_ru'));
     //output(ds_in_seq_with_daspInds,    named('ds_in_seq_with_daspInds'));
     //output(ds_in_seq_with_daspInds_ru,  named('ds_in_seq_with_daspInds_ru'));
     //output(ds_in_seq_with_dasplInds,    named('ds_in_seq_with_dasplInds'));
     //output(ds_in_seq_with_dasplInds_ru, named('ds_in_seq_with_dasplInds_ru'));
     //output(ds_in_seq_pc_with_fdnind,    named('ds_in_seq_pc_with_fdnind'));
     //output(ds_in_seq_pc_with_fdnInd_ru, named('ds_in_seq_pc_with_fdnind_ru'));
     //output(ds_in_seq_denorm_phones,     named('ds_in_seq_denorm_phones'));
     //output(AnyFdnIndorWafWasSet,        named('AnyFdnIndorWafWasSet'));
     //output(AnyFdnIndWasSet,             named('AnyFdnIndWasSet'));
     //output(ds_in_with_fdnInds,          named('ds_in_with_fdnInds'));

		RETURN ds_in_with_fdninds; 

END; // end of func_FdnCheckSearchRecs
