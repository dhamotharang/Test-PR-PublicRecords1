IMPORT doxie, doxie_crs, FraudDefenseNetwork_Services, FraudShared_Services;

EXPORT Append_FDN_Inds(dataset(doxie_crs.layout_best_information) ds_in_besr,   //best_information_children 
                       dataset(doxie_crs.layout_ssn_records) ds_in_ssnr,        //ssn_children 
	                     dataset(doxie_crs.layout_HRI_SSN) ds_in_shrr,            //hri_ssn_children
	                     dataset(doxie_crs.layout_deathfile_records) ds_in_dear,  //deathfile_children
							         dataset(doxie.Layout_Comp_Addr_Utility_Recs) ds_in_addr, //addresses_children
	                     dataset(doxie_crs.layout_comp_names) ds_in_namr,         //names_children
	                     dataset(doxie_crs.layout_phone_records) ds_in_phor,      //phones_children
	                     dataset(doxie_crs.Layout_Phones_Old) ds_in_phold,        //phones_old_children
	                     dataset(doxie_crs.layout_SSN_Lookups) ds_in_sslr,        //ssn_lookups_children
	                     dataset(doxie_crs.layout_relative_summary) ds_in_relr,   //relative_summary_children
	                     dataset(doxie_crs.layout_relative_summary) ds_in_assr,   //associate_summary_children
	                     dataset(doxie.layout_nbr_records_slim) ds_in_nbrr2,      //nbrs_summary2_children
                       boolean IncludeSubject,
                       boolean IncludeAssociates,
                       unsigned6 in_FDN_gcid,
                       unsigned2 in_FDN_indtype,
                       unsigned6 in_FDN_prodcode,
                       boolean FDNContDataPermitted,
                       boolean FDNInqDataPermitted
                      ) := MODULE

    // local functions
    shared func_set_indicator(unsigned3 file_type) := function
	    return FraudDefenseNetwork_Services.Functions.set_indicator(file_type, FDNContDataPermitted, FDNInqDataPermitted); 
    end; 

    shared func_set_waf(unsigned file_type, boolean alreadyWAF =false) := function
    	 return FraudDefenseNetwork_Services.Functions.set_waf(file_type,FDNContDataPermitted,alreadyWAF);
    end;

    // ***************************************************************************************
	  // SPLIT OUT FIELDS (TO BE CHECKED IN FDN DATA) FROM ALL OF THE INPUT DATASETS. 
    // Sequence, then normalize/project each input dataset one at a time to split  out fields.
	  // ***************************************************************************************
	  //
	  // ===============================================================
    // First, handle the besr/best_information_children input dataset.
	  // ===============================================================

    // Save off the "best" info/subject did, ssn & phone for matching to later on in some joins below.
    shared unsigned6 SUBJECT_DID   := ds_in_besr[1].did;
		shared string9   SUBJECT_SSN   := ds_in_besr[1].ssn; 
		shared string10  SUBJECT_PHONE := ds_in_besr[1].phone; 

    // Add sequence # on each input record for sort/dedup later on.
    shared rec_layout_best_information_seq := record
	    unsigned2 seq; 
	 	  doxie_crs.layout_best_information;
	  end;

    rec_layout_best_information_seq tf_SeqBesr(
		  doxie_crs.layout_best_information l, integer c) := transform 
		    self.seq := c;
			  self     := l;
	  end;

	  shared ds_in_besr_seq := if(IncludeSubject,
		                            project(ds_in_besr, tf_SeqBesr(left, counter))
														    // otherwise default to an empty dataset so don't have to 
																// conditonally check the associated joins further below
																);

    // "Normalize" the sequenced besr input, 4 times to split out the 4 pieces of data 
	  // (to be checked for in the FDN data) onto separate records since that is what the new
	  // FraudDefenseNetwork_Services function is expecting.
	  // Check the counter: when 1 assign did,  when 2 assign address fields, 
	  //                    when 3 assign ssn,  when 4 assign phone
	  // Also transforming the data onto the layout needed to be passed into the new FraudDefenseNetwork_Services 
	  // function and converting the did field into the type expected by the function.
    FraudDefenseNetwork_Services.Layouts.batch_search_rec  tf_NormBesr(
	    rec_layout_best_information_seq L, integer C) := transform
		    self.did         := choose(C,(unsigned6)L.did,0,0,0);
			  self.prim_range  := choose(C,'',L.prim_range,'','');
			  self.predir      := choose(C,'',L.predir,'','');
			  self.prim_name   := choose(C,'',L.prim_name,'','');
			  self.addr_suffix := choose(C,'',L.suffix,'','');
			  self.postdir     := choose(C,'',L.postdir,'','');
			  self.unit_desig  := choose(C,'',L.unit_desig,'','');
			  self.sec_range   := choose(C,'',L.sec_range,'',''); 
			  self.v_city_name := choose(C,'',L.city_name,'','');
			  self.st          := choose(C,'',L.st,'','');
			  self.zip5        := choose(C,'',L.zip,'','');
			  self.zip4        := choose(C,'',L.zip4,'','');
			  self.ssn         := choose(C,'','',L.ssn_unmasked,''); //use this in case 'ssn' field is masked
			  self.phone10     := choose(C,'','','',L.phone);
			  self.seq         := L.seq; // to store seq# on every record
				self := [];  // Added for FDN Expanded layout
		end;

		shared ds_in_besr_seq_normed := normalize(ds_in_besr_seq,4,tf_NormBesr(left,counter));

    // Add sequence # on each besr "phones" child dataset record for sort/dedup later on.
    shared rec_layout_best_phones_seq := record
	    unsigned2 seq; 
			unsigned2 phonerec_seq; // will be used to put phones back into original order 
      doxie_crs.layout_best_phones;
	  end;

		// Next normalize "n" times (where n = count of number of recs in the "phones" child dataset),
		// to split out the "phones" child dataset records into separate records. 
		// Storing all fields from the "phones" child dataset (for use when denormed later). 
		rec_layout_best_phones_seq tf_NormBesrPhones(
      rec_layout_best_information_seq L, integer C) := transform
			  self.seq          := L.seq, 
				self.phonerec_seq := C, // will be used to put phones back into original order 
        self              := L.phones[C]; // to assign all "phones" child dataset fields
		end;

		shared ds_in_besr_seq_phones_children := normalize(ds_in_besr_seq,count(left.phones),
		                                                   tf_NormBesrPhones(left,counter));

    // Sort/dedup the normed phones children recs to only keep unique phone10 values.
		// Then project onto the layout needed to be passed into the new FraudDefenseNetwork_Services function.
		shared ds_in_besr_seq_pc_dedup := project(dedup(sort(ds_in_besr_seq_phones_children(listed_phone!=''),
		                                                     listed_phone),listed_phone),
		                                          transform(FraudDefenseNetwork_Services.Layouts.batch_search_rec,
															                  self.phone10 := left.listed_phone, // only keep "phones" listed_phones
																                self         := [] // null all other unused fields
	   														              ));

	  // =================================================
    // Next, handle the ssnr/ssn_children input dataset.
	  // =================================================
    shared rec_layout_ssn_records_seq := record
	    unsigned2 seq; 
		  doxie_crs.layout_ssn_records;
	  end;

    // Add sequence # on each input record for sort/dedup later on.
    rec_layout_ssn_records_seq tf_SeqSsnr(
		  doxie_crs.layout_ssn_records l, integer c) := transform 
		    self.seq := c;
			  self     := l;
	  end;

	  shared ds_in_ssnr_seq := if(IncludeSubject or IncludeAssociates,
														    project(ds_in_ssnr, tf_SeqSsnr(left, counter))
														    // otherwise default to an empty dataset so don't have to 
																// conditonally check the associated joins further below
																);

    // "Normalize" the sequenced ssnr input, 2 times to split out the ssn & did pieces of data 
	  // (to be checked for in the FDN data) onto separate records since that is what the new
	  // FraudDefenseNetwork_Services function is expecting.
		// Only transform did & ssn for the subject only when the subject was asked to be included
		// and/or for the non-subjects/associates only when they were asked to be included.
	  // Check the counter: when 1 assign did,  when 2 assign ssn
	  // Also transforming the data onto the layout needed to be passed into the new FraudDefenseNetwork_Services 
	  // function and converting the did field into the type expected by the function.
    FraudDefenseNetwork_Services.Layouts.batch_search_rec  tf_NormSSnr(
	    rec_layout_ssn_records_seq L, integer C) := transform
			  boolean USE_DATA := (IncludeSubject and L.did = SUBJECT_DID)
                            or	
									          (IncludeAssociates and L.did != SUBJECT_DID);
													 
		    self.did := if(USE_DATA, choose(C,L.did,0),0);
			  self.ssn := if(USE_DATA, choose(C,'',L.ssn_unmasked),'');
			  self.seq := L.seq;
				self     := [];    //null addr & phone10 fields
		end;

		shared ds_in_ssnr_seq_normed := normalize(ds_in_ssnr_seq,2,tf_NormSsnr(left,counter));

 	  // =====================================================
    // Next, handle the shrr/hri_ssn_children input dataset.
	  // =====================================================
    shared rec_layout_hri_ssn_seq := record
	    unsigned2 seq; 
		  doxie_crs.layout_HRI_SSN;
	  end;

    // Add sequence # on each input record for sort/dedup later on.
    rec_layout_hri_ssn_seq tf_SeqShrr(
		  doxie_crs.layout_HRI_SSN l, integer c) := transform 
		    self.seq := c;
			  self     := l;
	  end;

	  shared ds_in_shrr_seq := if(IncludeSubject or IncludeAssociates,
														    project(ds_in_shrr, tf_SeqShrr(left, counter))
														    // otherwise default to an empty dataset so don't have to 
																// conditonally check the associated joins further below
                               );

    // "Normalize" the sequenced shrr input, 2 times to split out the did & ssn_unmasked pieces
		// of data (to be checked for in the FDN data) onto separate records since that is what the
		// new FraudDefenseNetwork_Services function is expecting.
	  // Check the counter: when 1 assign did,  when 2 assign ssn
	  // Also transforming the data onto the layout needed to be passed into the new FraudDefenseNetwork_Services 
	  // function and converting the did field into the type expected by the function.
    FraudDefenseNetwork_Services.Layouts.batch_search_rec  tf_NormShrr(
	    rec_layout_hri_ssn_seq L, integer C) := transform
			  boolean USE_DATA := (IncludeSubject and L.did = SUBJECT_DID)
                            or	
											      (IncludeAssociates and L.did != SUBJECT_DID);
		    self.did := if(USE_DATA, choose(C,L.did,0),0);
			  self.ssn := if(USE_DATA, choose(C,'',L.ssn_unmasked),'');
			  self.seq := L.seq;
				self     := [];  //null addr & phone10 fields
		end;

		shared ds_in_shrr_seq_normed := normalize(ds_in_shrr_seq,2,tf_NormShrr(left,counter));

 	  // =======================================================
    // Next, handle the dear/deathfile_children input dataset.
	  // =======================================================
    shared rec_layout_deathfile_records_seq := record
	    unsigned2 seq; 
		 doxie_crs.layout_deathfile_records;
	  end;

    // Add sequence # on each input record for sort/dedup later on.
    rec_layout_deathfile_records_seq tf_SeqDear(
		  doxie_crs.layout_deathfile_records l, integer c) := transform 
		    self.seq := c;
			  self     := l;
	  end;

	  shared ds_in_dear_seq := if(IncludeSubject or IncludeAssociates,
														    project(ds_in_dear, tf_SeqDear(left, counter))
														    // otherwise default to an empty dataset so don't have to 
																// conditonally check the associated joins further below
														    );

    // "Normalize" the sequenced dear input, 2 times to split out the did & ssn_unmasked pieces
		// of data (to be checked for in the FDN data) onto separate records since that is what the
		// new FraudDefenseNetwork_Services function is expecting.
	  // Check the counter: when 1 assign did,  when 2 assign ssn
	  // Also transforming the data onto the layout needed to be passed into the new FraudDefenseNetwork_Services 
	  // function and converting the did field into the type expected by the function.
    FraudDefenseNetwork_Services.Layouts.batch_search_rec  tf_NormDear(
	    rec_layout_deathfile_records_seq L, integer C) := transform
			  boolean USE_DATA := (IncludeSubject and (unsigned6) L.did = SUBJECT_DID)
                            or	
											      (IncludeAssociates and (unsigned6) L.did != SUBJECT_DID);
		    self.did := if(USE_DATA, choose(C,(unsigned6)L.did,0),0);
			  self.ssn := if(USE_DATA, choose(C,'',L.ssn_unmasked),'');
			  self.seq := L.seq;
				self     := [];  //null addr & phone10 fields
		end;

		shared ds_in_dear_seq_normed := normalize(ds_in_dear_seq,2,tf_NormDear(left,counter));
		
	  // =======================================================
    // Next, handle the addr/addresses_children input dataset.
	  // =======================================================
    shared rec_layout_comp_addr_utilrecs_seq := record
	    unsigned2 seq; 
	 	  doxie.Layout_Comp_Addr_Utility_Recs;
	  end;

    // Add sequence # on each input record for sort/dedup later on.
    rec_layout_comp_addr_utilrecs_seq tf_SeqAddr(
		  doxie.Layout_Comp_Addr_Utility_Recs l, integer c) := transform 
		    self.seq := c;
			  self     := l;
	  end;

	  shared ds_in_addr_seq := if(IncludeSubject or IncludeAssociates,
														    project(ds_in_addr, tf_SeqAddr(left, counter))
														    // otherwise default to an empty dataset so don't have to 
																// conditonally check the associated joins further below
														   );

    // "Normalize" the sequenced addr input, 4 times to split out the pieces of data 
	  // (to be checked for in the FDN data) onto separate records since that is what the new
	  // FraudDefenseNetwork_Services function is expecting.
	  // Check the counter: when 1 assign did,   when 2 assign address fields, 
	  //                    when 3 assign phone, when 4 assign listed_phone
	  // Also transforming the data onto the layout needed to be passed into the new FraudDefenseNetwork_Services 
	  // function and converting the did field into the type expected by the function.
    FraudDefenseNetwork_Services.Layouts.batch_search_rec  tf_NormAddr(
	    rec_layout_comp_addr_utilrecs_seq L, integer C) := transform
			  boolean USE_DATA := (IncludeSubject and L.isSubject)
                            or	
											      (IncludeAssociates and not L.isSubject);
				
		    self.did         := if(USE_DATA,choose(C,L.did,0,0,0),0);
			  self.prim_range  := if(USE_DATA,choose(C,'',L.prim_range,'',''),'');
			  self.predir      := if(USE_DATA,choose(C,'',L.predir,'', ''),'');
			  self.prim_name   := if(USE_DATA,choose(C,'',L.prim_name,'',''),'');
			  self.addr_suffix := if(USE_DATA,choose(C,'',L.suffix,'',''),'');
			  self.postdir     := if(USE_DATA,choose(C,'',L.postdir,'',''),'');
			  self.unit_desig  := if(USE_DATA,choose(C,'',L.unit_desig,'',''),'');
			  self.sec_range   := if(USE_DATA,choose(C,'',L.sec_range,'',''),'');
			  self.v_city_name := if(USE_DATA,choose(C,'',L.city_name,'',''),'');
			  self.st          := if(USE_DATA,choose(C,'',L.st,'',''),'');
			  self.zip5        := if(USE_DATA,choose(C,'',L.zip,'',''),'');
			  self.zip4        := if(USE_DATA,choose(C,'',L.zip4,'',''),'');
			  self.phone10     := if(USE_DATA,choose(C,'','',L.phone, L.listed_phone),'');
			  self.seq         := L.seq; // to store seq# on every record
				self             := [];  //null ssn
		end;

		shared ds_in_addr_seq_normed := normalize(ds_in_addr_seq,4,tf_NormAddr(left,counter));

	  // =================================================
    // Next, handle the namr/names_children input dataset.
	  // =================================================
    shared rec_layout_comp_names_seq := record
	    unsigned2 seq; 
		  doxie_crs.layout_comp_names;
	  end;

    // Add sequence # on each input record for sort/dedup later on.
    rec_layout_comp_names_seq tf_SeqNamr(
		  doxie_crs.layout_comp_names l, integer c) := transform 
		    self.seq := c;
			  self     := l;
	  end;

	  shared ds_in_namr_seq := if(IncludeSubject or IncludeAssociates,
														    project(ds_in_namr, tf_SeqNamr(left, counter))
														    // otherwise default to an empty dataset so don't have to 
																// conditonally check the associated joins further below
														   );

    // "Normalize" the sequenced namr input, 2 times to split out the ssn & did pieces of data 
	  // (to be checked for in the FDN data) onto separate records since that is what the new
	  // FraudDefenseNetwork_Services function is expecting.
	  // Check the counter: when 1 assign did,  when 2 assign ssn
	  // Also transforming the data onto the layout needed to be passed into the new FraudDefenseNetwork_Services 
	  // function and converting the did field into the type expected by the function.
    FraudDefenseNetwork_Services.Layouts.batch_search_rec  tf_NormNamr(
	    rec_layout_comp_names_seq L, integer C) := transform
			  boolean USE_DATA := (IncludeSubject and L.did = SUBJECT_DID)
                            or	
											      (IncludeAssociates and L.did != SUBJECT_DID);
		    self.did := if(USE_DATA, choose(C,L.did,0),0);
			  self.ssn := if(USE_DATA, choose(C,'',L.ssn_unmasked),'');
			  self.seq := L.seq; 
				self     := [];  //null addr & phone10 fields
		end;

		shared ds_in_namr_seq_normed := normalize(ds_in_namr_seq,2,tf_NormNamr(left,counter));

	  // =======================================================
    // Next, handle the phor/phones_children input dataset.
	  // =======================================================
    shared rec_layout_phone_records_seq := record
	    unsigned2 seq; 
	 	  doxie_crs.layout_phone_records;
	  end;

    // Add sequence # on each input record for sort/dedup later on.
    rec_layout_phone_records_seq tf_SeqPhor(
		  doxie_crs.layout_phone_records l, integer c) := transform 
		    self.seq := c;
			  self     := l;
	  end;

	  shared ds_in_phor_seq := if(IncludeSubject or IncludeAssociates
																,project(ds_in_phor, tf_SeqPhor(left, counter))
														    // otherwise default to an empty dataset so don't have to 
																// conditonally check the associated joins further below
														    );

    // Project the sequenced phor input, to split out the phone (to be checked for in the FDN data)
		// onto the record layout that the new FraudDefenseNetwork_Services function is expecting.
    FraudDefenseNetwork_Services.Layouts.batch_search_rec  tf_Phor(
	    rec_layout_phone_records_seq L) := transform
			  // May not be the best way to determine the phone for the subject vs others, but there is 
				// no "did" on the doxie_crs.layout_phone_records that can be used to determine if the 
				// phone# is for the subject or someone else.  Maybe could use address fields, but they
				// would have to match the subjects current (best?) address.
			  boolean USE_PHONE := (IncludeSubject and L.phone = SUBJECT_PHONE)
                             or	
											       (IncludeAssociates and L.phone != SUBJECT_PHONE);
			  self.phone10 := if(USE_PHONE,L.phone,'');
			  self.seq     := L.seq;
				self         := [];  //null did, addr & ssn fields
		end;

		shared ds_in_phor_seq_prjted := project(ds_in_phor_seq,tf_Phor(left));
		

	  // =========================================================
    // Next, handle the phold/phones_old_children input dataset.
	  // =========================================================
    shared rec_layout_phones_old_seq := record
	    unsigned2 seq; 
	 	  doxie_crs.Layout_Phones_Old;
	  end;

    // Add sequence # on each input record for sort/dedup later on.
    rec_layout_phones_old_seq tf_SeqPhold(
		  doxie_crs.Layout_Phones_Old l, integer c) := transform 
		    self.seq := c;
			  self     := l;
	  end;

	  shared ds_in_phold_seq := if(IncludeSubject or IncludeAssociates,
														    project(ds_in_phold, tf_SeqPhold(left, counter))
														    // otherwise default to an empty dataset so don't have to 
																// conditonally check the associated joins further below
														   );

    // "Normalize" the sequenced phold input, 2 times to split out the pieces of data 
	  // (to be checked for in the FDN data) onto separate records since that is what the new
	  // FraudDefenseNetwork_Services function is expecting.
	  // Check the counter: when 1 assign did,  when 2 assign phone
	  // Also transforming the data onto the layout needed to be passed into the new FraudDefenseNetwork_Services 
	  // function and converting the did field into the type expected by the function.
    FraudDefenseNetwork_Services.Layouts.batch_search_rec  tf_NormPhold(
	    rec_layout_phones_old_seq L, integer C) := transform
			  boolean USE_DATA := (IncludeSubject and L.did = SUBJECT_DID)
                            or	
											      (IncludeAssociates and L.did != SUBJECT_DID);
		    self.did     := if(USE_DATA,choose(C,L.did,0),0);
			  self.phone10 := if(USE_DATA,choose(C,'',L.phone),'');
			  self.seq     := L.seq;
				self         := [];  //null address & ssn fields
		end;

		shared ds_in_phold_seq_normed := normalize(ds_in_phold_seq,2,tf_NormPhold(left,counter));

	  // =========================================================
    // Next, handle the sslr/ssn_lookups_children input dataset.
	  // =========================================================
    shared rec_layout_ssn_lookups_seq := record
	    unsigned2 seq; 
		  doxie_crs.layout_SSN_Lookups;
	  end;

    // Add sequence # on each input record for sort/dedup later on.
    rec_layout_ssn_lookups_seq tf_SeqSslr(
		  doxie_crs.layout_SSN_Lookups l, integer c) := transform 
		    self.seq := c;
			  self     := l;
	  end;

	  shared ds_in_sslr_seq := if(IncludeSubject or IncludeAssociates,
														    project(ds_in_sslr, tf_SeqSslr(left, counter))
														    // otherwise default to an empty dataset so don't have to 
																// conditonally check the associated joins further below
														   );

    // Project the sequenced sslr input, to split out the ssn (to be checked for in the FDN data)
		// onto the record layout that the new FraudDefenseNetwork_Services function is expecting.
    FraudDefenseNetwork_Services.Layouts.batch_search_rec  tf_Sslr(
	    rec_layout_ssn_lookups_seq L) := transform
			  // v--- may not be the best way to check for subject, but the doxie_crs.layout_SSN_Lookups
				// does not have a did field on it.
			  USE_SSN := (IncludeSubject and L.ssn_unmasked = SUBJECT_SSN)
                    or	
									 (IncludeAssociates and L.ssn_unmasked != SUBJECT_SSN);
			  self.ssn := if(USE_SSN,L.ssn_unmasked,'');
			  self.seq := L.seq;
				self     := [];  //null did, addr & phone10 fields
		end;

		shared ds_in_sslr_seq_prjted := project(ds_in_sslr_seq,tf_Sslr(left));

	  // ==============================================================
    // Next, handle the relr/relative_summary_children input dataset.
	  // ==============================================================
    shared rec_layout_relative_summary_seq := record
	    unsigned2 seq; 
		  doxie_crs.layout_relative_summary;
	  end;

    // Add sequence # on each input record for sort/dedup later on.
    rec_layout_relative_summary_seq tf_SeqRelr(
		  doxie_crs.layout_relative_summary l, integer c) := transform 
		    self.seq := c;
			  self     := l;
	  end;

	  shared ds_in_relr_seq := if(IncludeAssociates,
														    project(ds_in_relr, tf_SeqRelr(left, counter))
														    // otherwise default to an empty dataset so don't have to 
																// conditonally check the associated joins further below
														   );

    // Project the sequenced relr input, to split out the did (to be checked for in the FDN data)
		// onto the record layout that the new FraudDefenseNetwork_Services function is expecting.
    FraudDefenseNetwork_Services.Layouts.batch_search_rec  tf_Relr(
	    rec_layout_relative_summary_seq L) := transform
		    self.did := L.person2;
			  self.seq := L.seq; // to store seq# on every record
				self     := [];  //null addr, ssn & phone10 fields
		end;

		shared ds_in_relr_seq_prjted := project(ds_in_relr_seq,tf_Relr(left));

	  // ===============================================================
    // Next, handle the assr/associate_summary_children input dataset.
	  // ===============================================================

		// NOTE: Uses same shared rec_layout_relative_summary_seq as above
    // Add sequence # on each input record for sort/dedup later on.
    rec_layout_relative_summary_seq tf_SeqAssr(
		  doxie_crs.layout_relative_summary l, integer c) := transform 
		    self.seq := c;
			  self     := l;
	  end;

	  shared ds_in_assr_seq := if(IncludeAssociates,
														    project(ds_in_assr, tf_SeqAssr(left, counter))
														    // otherwise default to an empty dataset so don't have to 
																// conditonally check the associated joins further below
														   );

    // Project the sequenced assr input, to split out the did (to be checked for in the FDN data)
		// onto the record layout that the new FraudDefenseNetwork_Services function is expecting.
    FraudDefenseNetwork_Services.Layouts.batch_search_rec  tf_Assr(
	    rec_layout_relative_summary_seq L) := transform
		    self.did := L.person2;
			  self.seq := L.seq; // to store seq# on every record
				self     := [];  //null addr, ssn & phone10 fields
		end;

		shared ds_in_assr_seq_prjted := project(ds_in_assr_seq,tf_Assr(left));

	  // ============================================================
    // Next, handle the nbrr2/nbrs_summary2_children input dataset.
	  // ============================================================
     shared rec_layout_nbr_records_slim_seq := record
	     unsigned2 seq; 
		   doxie.layout_nbr_records_slim;
	   end;

    // Add sequence # on each input record for sort/dedup later on.
    rec_layout_nbr_records_slim_seq tf_SeqNbrr2(
		  doxie.layout_nbr_records_slim l, integer c) := transform 
		    self.seq := c;
			  self     := l;
	  end;

	  shared ds_in_nbrr2_seq := if(IncludeAssociates,
														     project(ds_in_nbrr2, tf_SeqNbrr2(left, counter))
														     // otherwise default to an empty dataset so don't have to 
																 // conditonally check the aqssociated joins further below
														    );

    // Project the sequenced nbrr2 input, to split out the did (to be checked for in the FDN data)
		// onto the record layout that the new FraudDefenseNetwork_Services function is expecting.
    FraudDefenseNetwork_Services.Layouts.batch_search_rec  tf_Nbrr2(
	    rec_layout_nbr_records_slim_seq L) := transform
		    self.did := L.did;
			  self.seq := L.seq; // to store seq# on every record
				self     := [];  //null address, ssn & phone10 fields
		end;

		shared ds_in_nbrr2_seq_prjted := project(ds_in_nbrr2_seq,tf_Nbrr2(left));


    // ******************************************************************************
    // Combine all the input datasets normed or just projected for the 4 data pieces
		// to be checked and any other datasets of recs normed from child datasets.
		// ******************************************************************************
		shared ds_in_all_normed_combined :=   ds_in_besr_seq_normed 
		                                    + ds_in_besr_seq_pc_dedup
		                                    + ds_in_ssnr_seq_normed 
																				+ ds_in_shrr_seq_normed
																				+ ds_in_dear_seq_normed
																				+ ds_in_addr_seq_normed
																				+ ds_in_namr_seq_normed
		                                    + ds_in_phor_seq_prjted 
																				+ ds_in_phold_seq_normed
		                                    + ds_in_sslr_seq_prjted 
		                                    + ds_in_relr_seq_prjted 
		                                    + ds_in_assr_seq_prjted 
		                                    + ds_in_nbrr2_seq_prjted;

    // Filter out any records with no data fields to be checked.  Then sort/dedup the records 
		// being passed into the new FraudDefenseNetwork_Services function to remove duplicates.
    shared ds_in_all_nc_dedup := dedup(sort(ds_in_all_normed_combined
		                                        //filter to only include recs with at least 1 piece of data
																	          (did !=0 or ssn !='' or phone10 !='' or 
																		         prim_name !='' or v_city_name !='' or 
																						 st !='' or zip5 !=''), 
                                            record,except seq),
                                       record,except seq);


    // ====================================================================
		// Then call new FraudDefenseNetwork_Services function to actually check if any of the 
		// input fields (did, ssn, address or phone) exist in the FDN keys.
		// ====================================================================
		shared ds_in_all_fdn_chkd_raw := FraudDefenseNetwork_Services.func_CheckForFdnData(
																			 ds_in_all_nc_dedup,
		                                   in_FDN_gcid,in_FDN_indtype,in_FDN_prodcode);

    // Set shorter alias names to be used in all the joins below.
    // See FraudShared_Services.Constants for more info.
    shared unsigned3 ContribData := //1 = FDN Event Outcomes (AKA Contributory) data
	                                  FraudShared_Services.Constants.FileTypeCodes.CONTRIBUTORY;
	  shared set of unsigned3 InquiryData := // 2,3,4 = FDN Market Activity (AKA Inquiry) data
	  	                                     [FraudShared_Services.Constants.FileTypeCodes.PUBLIC_RECORD, 
	 	                                        FraudShared_Services.Constants.FileTypeCodes.TRANSACTION, 
	 	                                        FraudShared_Services.Constants.FileTypeCodes.RELATIONSHIP_ANALYTICS];

    // To reduce the number of records in the right side of the joins in the section below, 
		// sort/dedup the records out of the new FraudDefenseNetwork_Services function to remove duplicates with the 
		// same input criteria & the same FDN classification_Permissible_use_access.file_type value.
		// Some input fields data values are found more than once in the fdn id key with 2 (or more) 
		// different fdn id key record_id values(which we aren't using), but that have the same 
		// file_type value.
    shared ds_in_all_fdn_chkd := dedup(sort(ds_in_all_fdn_chkd_raw,
		                                        did, ssn, phone10,
																	          st, v_city_name, zip5,
		                                        prim_range, prim_name, addr_suffix,
		                                        unit_desig, sec_range,
																						// needed because file_type 2, 3 & 4 are all inquiry data,
																						// but we only need 1 of those types of recs, not all 3.
																	          if(classification_Permissible_use_access.file_type = 
																						   ContribData,0,1)
																	),
			                        did, ssn, phone10, 
															st, v_city_name, zip5,
		                          prim_range, prim_name, addr_suffix, 
                              unit_desig, sec_range,
										          if(classification_Permissible_use_access.file_type = 
					 										   ContribData,0,1)
															);

															
    // *******************************************************************
    // Once all candidate data fields are checked for in the FDN data, 
		// then set on the appropriate fdn indicators when matches were found.
	  // *******************************************************************
    //
    // =========================================================== 
    // Set on any fdn indicators in the input besr records.
	  // ===========================================================
	  //
    // First, join the ds of sequenced input to the ds above out of the FDN function to set the
	  // FDN did indicator.
    rec_layout_best_information_seq tf_besr_did_info(
		  rec_layout_best_information_seq l, 
			FraudDefenseNetwork_Services.Layouts.batch_response_rec r) := transform
				self.fdn_did_ind := func_set_indicator(r.classification_Permissible_use_access.file_type),
        self := l
    end;

	  shared ds_in_besr_seq_with_dInd := join(ds_in_besr_seq, ds_in_all_fdn_chkd,
			                                        (unsigned6) left.did = right.did and right.did !=0,
									                          tf_besr_did_info(left,right),
                                            LEFT OUTER); //to keep all input recs whether they had fdn data or not

    // Sort/dedup to only keep 1 rec per seq#, preferring ones with fdn ind set on. 
		shared ds_in_besr_seq_with_dInd_dd := dedup(sort(ds_in_besr_seq_with_dInd,
		                                                 seq, -fdn_did_ind), seq);

    // Second, join the ds out of first join to the ds above out of the FDN function to next 
		// set the FDN addr indicator.
     rec_layout_best_information_seq tf_besr_addr_info(
       rec_layout_best_information_seq l, 
			 FraudDefenseNetwork_Services.Layouts.batch_response_rec  r) := transform  
         self.fdn_addr_ind  := func_set_indicator(r.classification_Permissible_use_access.file_type),
		     self := l
    end;
		
	  ds_in_besr_seq_with_daInds := join(ds_in_besr_seq_with_dInd_dd, ds_in_all_fdn_chkd,
														             left.prim_range = right.prim_range  and 
																				 left.predir     = right.predir      and
													               left.prim_name  = right.prim_name   and 
																				 left.postdir    = right.postdir     and
														             left.suffix     = right.addr_suffix and
														             left.city_name  = right.v_city_name and 
														             left.st         = right.st          and 
														             left.zip        = right.zip5 
																				 and 
																				 (right.prim_name   !='' or right.v_city_name !='' or
				 												          right.st          !='' or right.zip5        !=''), 
                                       tf_besr_addr_info(left,right),																			 
													             LEFT OUTER); //to keep all input recs whether they had fdn data or not

    // Sort/dedup to only keep 1 rec per seq#, preferring ones with fdn ind set on. 
		shared ds_in_besr_seq_with_daInds_dd := dedup(sort(ds_in_besr_seq_with_daInds,
		                                                   seq, -fdn_addr_ind), seq);
													 
    // Third, join the ds out of second join to the ds above out of the FDN function to next 
		// set the FDN ssn indicator.
	  rec_layout_best_information_seq tf_besr_ssn_info(
      rec_layout_best_information_seq l, 
		  FraudDefenseNetwork_Services.Layouts.batch_response_rec r) := transform
        self.fdn_ssn_ind := func_set_indicator(r.classification_Permissible_use_access.file_type),
        self := l
    end;
	
	  ds_in_besr_seq_with_dasInds := join(ds_in_besr_seq_with_daInds_dd, ds_in_all_fdn_chkd,
											                    left.ssn = right.ssn and right.ssn != '', 
																	      tf_besr_ssn_info(left,right),
													              LEFT OUTER); //to keep all input recs whether they had fdn data or not

    // Sort/dedup to only keep 1 rec per seq#, preferring ones with fdn ind set on. 
		shared ds_in_besr_seq_with_dasInds_dd := dedup(sort(ds_in_besr_seq_with_dasInds,
		                                                    seq, -fdn_ssn_ind), seq);
													 
    // Fourth, join the ds out of third join to the ds above out of the FDN function to next 
		// set the FDN phone indicator.
    rec_layout_best_information_seq tf_besr_phone_info(
      rec_layout_best_information_seq l, 
			FraudDefenseNetwork_Services.Layouts.batch_response_rec   r) := transform  
				self.fdn_phone_ind := func_set_indicator(r.classification_Permissible_use_access.file_type),
        self := l
    end;
		
	  ds_in_besr_seq_with_daspInds := join(ds_in_besr_seq_with_dasInds_dd, ds_in_all_fdn_chkd,
														               left.phone = right.phone10 and right.phone10 != '',
																	       tf_besr_phone_info(left,right),
													               LEFT OUTER); //to keep all input recs whether they had fdn data or not

    // Sort/dedup to only keep 1 rec per seq#, preferring ones with fdn ind set on. 
		shared ds_in_besr_seq_with_daspInds_dd := dedup(sort(ds_in_besr_seq_with_daspInds,
		                                                     seq, -fdn_phone_ind), seq);

    // Fifth, join the ds of besr "phones" children to the ds above out of the FDN function to 
		// next set the FDN phone indicator on the temp "phones" child dataset layout.
    rec_layout_best_phones_seq tf_besr_child_phone_info(
      rec_layout_best_phones_seq l, 
			FraudDefenseNetwork_Services.Layouts.batch_response_rec   r) := transform
        self.fdn_phone_ind := func_set_indicator(r.classification_Permissible_use_access.file_type),
        self := l
    end;
		
	  shared ds_in_besr_seq_pc_with_fdnind := join(ds_in_besr_seq_phones_children, ds_in_all_fdn_chkd,
														                       left.listed_phone = right.phone10 
																									 and right.phone10 !='',
																	        tf_besr_child_phone_info(left,right),
	  										                  LEFT OUTER); //to keep all input recs whether they had fdn data or not

    // Now denormalize using the sequenced besr ds with fdn inds and the interim ds with the
		// "phones" fdn phone indicator set to re-create the original "phones" child dataset records, 
		// but now with the fdn_phone_ind set on.
		rec_layout_best_information_seq   tf_besr_denorm_phones(
		 rec_layout_best_information_seq L,
		 dataset(rec_layout_best_phones_seq) R) := transform
		   self.phones := project(dedup(sort(R(listed_phone !=''), //so empty phone recs don't get output 
                                         phonerec_seq, -fdn_phone_ind),
		                                phonerec_seq),
											        doxie_crs.layout_best_phones); // to re-assign all "phones" fields & new fdn_phone_ind
			  self := L;
		end;

		shared ds_in_besr_seq_denorm_phones := denormalize(sort(ds_in_besr_seq_with_daspInds_dd,seq),
																					             sort(ds_in_besr_seq_pc_with_fdnind,seq),
		                                                     left.seq = right.seq,
																		                   group,
																		                   tf_besr_denorm_phones(left,rows(right)));

		// Finally project back to original layout to strip off seq field so it can be used 
		// at the end before exporting the final datasets.
		 shared ds_in_besr_with_fdn_inds := project(ds_in_besr_seq_denorm_phones,
		                                            doxie_crs.layout_best_information);

    // ============================================================ 
    // Set on any fdn indicators in the input ssnr dataset records.
	  // ============================================================
	  //
    // First, join the ds of sequenced input to the ds above out of the FDN function to set the
	  // FDN did indicator.
    rec_layout_ssn_records_seq tf_ssnr_did_info(
		  rec_layout_ssn_records_seq l, 
			FraudDefenseNetwork_Services.Layouts.batch_response_rec r) := transform
				self.fdn_did_ind := func_set_indicator(r.classification_Permissible_use_access.file_type),
        self := l
    end;

	  shared ds_in_ssnr_seq_with_dInd := join(ds_in_ssnr_seq, ds_in_all_fdn_chkd,
			                                        (unsigned6) left.did = right.did and 
																							right.did !=0                    and
																							((IncludeSubject and right.did = SUBJECT_DID) or	
			                                         (IncludeAssociates and right.did != SUBJECT_DID)),
									                          tf_ssnr_did_info(left,right),
													                  LEFT OUTER); 

    // Sort/dedup to only keep 1 rec per seq#, preferring ones with fdn ind set on. 
		shared ds_in_ssnr_seq_with_dInd_dd := dedup(sort(ds_in_ssnr_seq_with_dInd,
		                                                 seq, -fdn_did_ind), seq);

    // Second, join the ds out of first join to the ds above out of the FDN function to next 
		// set the FDN ssn indicator.
	  rec_layout_ssn_records_seq tf_shrr_ssn_info(
      rec_layout_ssn_records_seq l, 
		  FraudDefenseNetwork_Services.Layouts.batch_response_rec r) := transform
        self.fdn_ssn_ind := func_set_indicator(r.classification_Permissible_use_access.file_type),
        self := l
    end;
		
	  ds_in_ssnr_seq_with_dsInds := join(ds_in_ssnr_seq_with_dInd_dd, ds_in_all_fdn_chkd,
										                     left.ssn_unmasked = right.ssn and 
																				 right.ssn != ''               and
																			   ((IncludeSubject and right.did = SUBJECT_DID) or	
			                                    (IncludeAssociates and right.did != SUBJECT_DID)), 
																	      tf_shrr_ssn_info(left,right),
													             LEFT OUTER);

    // Sort/dedup to only keep 1 rec per seq#, preferring ones with fdn ind set on. 
		shared ds_in_ssnr_seq_with_dsInds_dd := dedup(sort(ds_in_ssnr_seq_with_dsInds,
		                                                   seq, -fdn_ssn_ind), seq);

    // ============================================================ 
    // Set on any fdn indicators in the input shrr dataset records.
	  // ============================================================
	  //
    // First, join the ds of sequenced input to the ds above out of the FDN function to set the
	  // FDN did indicator.
    rec_layout_hri_ssn_seq tf_shrr_did_info(
		  rec_layout_hri_ssn_seq l, 
			FraudDefenseNetwork_Services.Layouts.batch_response_rec r) := transform
				self.fdn_did_ind := func_set_indicator(r.classification_Permissible_use_access.file_type),
        self := l
    end;

	  shared ds_in_shrr_seq_with_dInd := join(ds_in_shrr_seq, ds_in_all_fdn_chkd,
			                                        (unsigned6) left.did = right.did and 
																							right.did !=0                    and 
																							((IncludeSubject and right.did = SUBJECT_DID)or	
			                                         (IncludeAssociates and right.did != SUBJECT_DID)), 
									                          tf_shrr_did_info(left,right),
													                  LEFT OUTER);

    // Sort/dedup to only keep 1 rec per seq#, preferring ones with fdn ind set on. 
		shared ds_in_shrr_seq_with_dInd_dd := dedup(sort(ds_in_shrr_seq_with_dInd,
		                                                 seq, -fdn_did_ind), seq);

    // Second, join the ds out of first join to the ds above out of the FDN function to next 
		// set the FDN ssn indicator.
    rec_layout_hri_ssn_seq tf_shrr_ssn_info(
		  rec_layout_hri_ssn_seq l, 
			FraudDefenseNetwork_Services.Layouts.batch_response_rec r) := transform
				self.fdn_ssn_ind := func_set_indicator(r.classification_Permissible_use_access.file_type),
        self := l
    end;

	  ds_in_shrr_seq_with_dsInds := join(ds_in_shrr_seq_with_dInd_dd, ds_in_all_fdn_chkd,
										                     left.ssn_unmasked = right.ssn and 
																				 right.ssn != ''               and
																			   ((IncludeSubject and right.did = SUBJECT_DID) or	
			                                     (IncludeAssociates and right.did != SUBJECT_DID)), 
						                           tf_shrr_ssn_info(left,right),
													             LEFT OUTER);

    // Sort/dedup to only keep 1 rec per seq#, preferring ones with fdn ind set on. 
		shared ds_in_shrr_seq_with_dsInds_dd := dedup(sort(ds_in_shrr_seq_with_dsInds,
		                                                   seq, -fdn_ssn_ind), seq);
													 
    // ==================================================== 
    // Set on any fdn indicators in the input dear records.
	  // ====================================================
		//
    // First, join the ds of sequenced input to the ds above out of the FDN function to set the
	  // FDN did indicator.
    rec_layout_deathfile_records_seq tf_dear_did_info(
		  rec_layout_deathfile_records_seq l, 
			FraudDefenseNetwork_Services.Layouts.batch_response_rec r) := transform
				self.fdn_did_ind := func_set_indicator(r.classification_Permissible_use_access.file_type),
        self := l
    end;

	  shared ds_in_dear_seq_with_dInd := join(ds_in_dear_seq, ds_in_all_fdn_chkd,
			                                        (unsigned6) left.did = right.did and 
																							right.did !=0                    and 
																							((IncludeSubject and right.did = SUBJECT_DID) or	
			                                         (IncludeAssociates and right.did != SUBJECT_DID)), 
			                                      tf_dear_did_info(left,right),
													                  LEFT OUTER);

    // Sort/dedup to only keep 1 rec per seq#, preferring ones with fdn ind set on. 
		shared ds_in_dear_seq_with_dInd_dd := dedup(sort(ds_in_dear_seq_with_dInd,
		                                                 seq, -fdn_did_ind), seq);

    // Second, join the ds out of first join to the ds above out of the FDN function to next 
		// set the FDN ssn indicator.
    rec_layout_deathfile_records_seq tf_dear_ssn_info(
		  rec_layout_deathfile_records_seq l, 
			FraudDefenseNetwork_Services.Layouts.batch_response_rec r) := transform
				self.fdn_ssn_ind := func_set_indicator(r.classification_Permissible_use_access.file_type),
        self := l
    end;

	  ds_in_dear_seq_with_dsInds := join(ds_in_dear_seq_with_dInd_dd, ds_in_all_fdn_chkd,
										                     left.ssn_unmasked = right.ssn and 
																				 right.ssn != ''               and
																			   ((IncludeSubject and right.did = SUBJECT_DID) or	
			                                     (IncludeAssociates and right.did != SUBJECT_DID)), 
						                           tf_dear_ssn_info(left,right),
													             LEFT OUTER);

    // Sort/dedup to only keep 1 rec per seq#, preferring ones with fdn ind set on. 
		shared ds_in_dear_seq_with_dsInds_dd := dedup(sort(ds_in_dear_seq_with_dsInds,
		                                                   seq, -fdn_ssn_ind), seq);
													 
    // =========================================================== 
    // Set on any fdn indicators in the input addr records.
	  // ===========================================================
	  //
    // First, join the ds of sequenced input to the ds above out of the FDN function to set the
	  // FDN did indicator.
    rec_layout_comp_addr_utilrecs_seq tf_addr_did_info(
		  rec_layout_comp_addr_utilrecs_seq l, 
			FraudDefenseNetwork_Services.Layouts.batch_response_rec r) := transform
				self.fdn_did_ind := func_set_indicator(r.classification_Permissible_use_access.file_type),
        self := l
    end;

	  shared ds_in_addr_seq_with_dInd := join(ds_in_addr_seq, ds_in_all_fdn_chkd,
			                                        (unsigned6) left.did = right.did and 
																							right.did !=0                    and 
																							((IncludeSubject and left.isSubject) or	
			                                         (IncludeAssociates and NOT left.isSubject)), 
			                                      tf_addr_did_info(left,right),
													                  LEFT OUTER);

    // Sort/dedup to only keep 1 rec per seq#, preferring ones with fdn ind set on. 
		shared ds_in_addr_seq_with_dInd_dd := dedup(sort(ds_in_addr_seq_with_dInd,
		                                                 seq, -fdn_did_ind), seq);

    // Second, join the ds out of first join to the ds above out of the FDN function to next 
		// set the FDN addr indicator.
    rec_layout_comp_addr_utilrecs_seq tf_addr_addr_info(
      rec_layout_comp_addr_utilrecs_seq l, 
			FraudDefenseNetwork_Services.Layouts.batch_response_rec  r) := transform  
        self.fdn_addr_ind  := func_set_indicator(r.classification_Permissible_use_access.file_type),
		    self := l
    end;
		
	  ds_in_addr_seq_with_daInds := join(ds_in_addr_seq_with_dInd_dd, ds_in_all_fdn_chkd,
														             left.prim_range = right.prim_range  and
																				 left.predir     = right.predir      and
													               left.prim_name  = right.prim_name   and 
																				 left.postdir    = right.postdir     and
														             left.suffix     = right.addr_suffix and
														             left.city_name  = right.v_city_name and
														             left.st         = right.st          and
														             left.zip        = right.zip5           
																				 and 
																				 (right.prim_name   !='' or right.v_city_name !='' or
				 												          right.st          !='' or right.zip5        !='') 
																				 and
																				 ((IncludeSubject         and left.isSubject) or
																	        (IncludeAssociates and NOT left.isSubject)), 
                                       tf_addr_addr_info(left,right),																			 
													             LEFT OUTER);

    // Sort/dedup to only keep 1 rec per seq#, preferring ones with fdn ind set on. 
		shared ds_in_addr_seq_with_daInds_dd := dedup(sort(ds_in_addr_seq_with_daInds,
		                                                   seq, -fdn_addr_ind), seq);
													 
    // Third, join the ds out of second join to the ds above out of the FDN function to next 
		// set the FDN phone indicator.
    rec_layout_comp_addr_utilrecs_seq tf_addr_phone_info(
      rec_layout_comp_addr_utilrecs_seq l, 
			FraudDefenseNetwork_Services.Layouts.batch_response_rec   r) := transform  
				self.fdn_phone_ind := func_set_indicator(r.classification_Permissible_use_access.file_type),
        self := l
    end;

	  ds_in_addr_seq_with_dapInds := join(ds_in_addr_seq_with_daInds_dd, ds_in_all_fdn_chkd,
														              left.phone = right.phone10 and 
																					right.phone10 != ''        and 
																	        ((IncludeSubject and left.isSubject) or
					                                  (IncludeAssociates and NOT left.isSubject)), 
																        tf_addr_phone_info(left,right),
			                                  LEFT OUTER);

    // Sort/dedup to only keep 1 rec per seq#, preferring ones with fdn ind set on. 
		shared ds_in_addr_seq_with_dapInds_dd := dedup(sort(ds_in_addr_seq_with_dapInds,
		                                                    seq, -fdn_phone_ind), seq);

    // Fourth, join the ds out of third join to the ds above out of the FDN function to next 
		// set the FDN listed phone indicator.
    rec_layout_comp_addr_utilrecs_seq tf_addr_listed_phone_info(
      rec_layout_comp_addr_utilrecs_seq l, 
			FraudDefenseNetwork_Services.Layouts.batch_response_rec   r) := transform  
        self.fdn_listed_phone_ind := func_set_indicator(r.classification_Permissible_use_access.file_type),
        self := l
    end;
		
    ds_in_addr_seq_with_daplInds := join(ds_in_addr_seq_with_dapInds_dd, ds_in_all_fdn_chkd,
														                left.listed_phone = right.phone10 and 
																						right.phone10 != ''               and 
																	          ((IncludeSubject and left.isSubject) or
					                                   (IncludeAssociates and NOT left.isSubject)),
																	          tf_addr_listed_phone_info(left,right),
			                                    LEFT OUTER);

    // Sort/dedup to only keep 1 rec per seq#, preferring ones with fdn ind set on. 
		shared ds_in_addr_seq_with_daplInds_dd := dedup(sort(ds_in_addr_seq_with_daplInds,
		                                                    seq, -fdn_listed_phone_ind), seq);

    // ============================================================ 
    // Set on any fdn indicators in the input namr dataset records.
	  // ============================================================
	  //
    // First, join the ds of sequenced input to the ds above out of the FDN function to set the
	  // FDN did indicator.
    rec_layout_comp_names_seq tf_namr_did_info(
		  rec_layout_comp_names_seq l, 
			FraudDefenseNetwork_Services.Layouts.batch_response_rec r) := transform
				self.fdn_did_ind := func_set_indicator(r.classification_Permissible_use_access.file_type),
        self := l
    end;

	  shared ds_in_namr_seq_with_dInd := join(ds_in_namr_seq, ds_in_all_fdn_chkd,
														                  (unsigned6) left.did = right.did and
																							right.did !=0                    and 
																							((IncludeSubject and right.did = SUBJECT_DID) or
																	             (IncludeAssociates and right.did != SUBJECT_DID)), 
		                                        tf_namr_did_info(left,right),
												                    LEFT OUTER);

    // Sort/dedup to only keep 1 rec per seq#, preferring ones with fdn ind set on. 
		shared ds_in_namr_seq_with_dInd_dd := dedup(sort(ds_in_namr_seq_with_dInd,
		                                                 seq, -fdn_did_ind), seq);

    // Second, join the ds out of first join to the ds above out of the FDN function to next 
		// set the FDN ssn indicator.
    rec_layout_comp_names_seq tf_namr_ssn_info(
		  rec_layout_comp_names_seq l, 
			FraudDefenseNetwork_Services.Layouts.batch_response_rec r) := transform
				self.fdn_ssn_ind := func_set_indicator(r.classification_Permissible_use_access.file_type),
        self := l
    end;

	  ds_in_namr_seq_with_dsInds := join(ds_in_namr_seq_with_dInd_dd, ds_in_all_fdn_chkd,
										                     left.ssn_unmasked = right.ssn and 
																				 right.ssn != ''               and
																			   ((IncludeSubject and right.did = SUBJECT_DID) or	
			                                     (IncludeAssociates and right.did != SUBJECT_DID)), 
						                           tf_namr_ssn_info(left,right),
													             LEFT OUTER);

    // Sort/dedup to only keep 1 rec per seq#, preferring ones with fdn ind set on. 
		shared ds_in_namr_seq_with_dsInds_dd := dedup(sort(ds_in_namr_seq_with_dsInds,
		                                                   seq, -fdn_ssn_ind), seq);
													 
    // =========================================================== 
    // Set on any fdn indicators in the input phor records.
	  // ===========================================================
	  //
    // First, join the ds of sequenced input to the ds above out of the FDN function to set the
	  // FDN phone indicator.
    rec_layout_phone_records_seq tf_phor_phone_info(
      rec_layout_phone_records_seq l, 
			FraudDefenseNetwork_Services.Layouts.batch_response_rec r) := transform  
				self.fdn_phone_ind := func_set_indicator(r.classification_Permissible_use_access.file_type),
        self := l
    end;

		shared ds_in_phor_seq_with_pInd := join(ds_in_phor_seq, ds_in_all_fdn_chkd,
														                  left.phone = right.phone10 and 
																					    right.phone10 != ''        and 
																	            ((IncludeSubject and right.phone10 = SUBJECT_PHONE)
																							 or
					                                     (IncludeAssociates and 
																							                   right.phone10 != SUBJECT_PHONE)), 
																            tf_phor_phone_info(left,right),
													                  LEFT OUTER);

    // Sort/dedup to only keep 1 rec per seq#, preferring ones with fdn ind set on. 
		shared ds_in_phor_seq_with_pInd_dd := dedup(sort(ds_in_phor_seq_with_pInd,
		                                                    seq,-fdn_phone_ind), seq);

    // =========================================================== 
    // Set on any fdn indicators in the input phold records.
	  // ===========================================================
	  //
    // First, join the ds of sequenced input to the ds above out of the FDN function to set the
	  // FDN did indicator.
    rec_layout_phones_old_seq tf_phold_did_info(
		  rec_layout_phones_old_seq l, 
			FraudDefenseNetwork_Services.Layouts.batch_response_rec r) := transform
				self.fdn_did_ind := func_set_indicator(r.classification_Permissible_use_access.file_type),
        self := l
    end;

	  shared ds_in_phold_seq_with_dInd := join(ds_in_phold_seq, ds_in_all_fdn_chkd,
														                   (unsigned6) left.did = right.did and
																							 right.did !=0                    and 
																							 ((IncludeSubject and right.did = SUBJECT_DID) or
																	              (IncludeAssociates and right.did != SUBJECT_DID)), 
																             tf_phold_did_info(left,right),
													                   LEFT OUTER);

    // Sort/dedup to only keep 1 rec per seq#, preferring ones with fdn ind set on. 
		shared ds_in_phold_seq_with_dInd_dd := dedup(sort(ds_in_phold_seq_with_dInd,
		                                                  seq, -fdn_did_ind), seq);

    // Second, join the ds out of first join to the ds above out of the FDN function to next 
		// set the FDN phone indicator.
    rec_layout_phones_old_seq tf_phold_phone_info(
      rec_layout_phones_old_seq l, 
			FraudDefenseNetwork_Services.Layouts.batch_response_rec r) := transform  
				self.fdn_phone_ind := func_set_indicator(r.classification_Permissible_use_access.file_type),
        self := l
    end;

	  ds_in_phold_seq_with_dpInds := join(ds_in_phold_seq_with_dInd_dd, ds_in_all_fdn_chkd,
														              left.phone = right.phone10 and 
																					right.phone10 != ''        and 
																							 ((IncludeSubject and right.did = SUBJECT_DID) or
																	              (IncludeAssociates and right.did != SUBJECT_DID)), 
																        tf_phold_phone_info(left,right),
												                LEFT OUTER);

    // Sort/dedup to only keep 1 rec per seq#, preferring ones with fdn ind set on. 
		shared ds_in_phold_seq_with_dpInds_dd := dedup(sort(ds_in_phold_seq_with_dpInds,
		                                                    seq, -fdn_phone_ind), seq);

    // ============================================================ 
    // Set on any fdn indicators in the input sslr dataset records.
	  // ============================================================
	  //
    // First, join the ds of sequenced input to the ds above out of the FDN function to set the
	  // FDN ssn indicator.
    rec_layout_ssn_lookups_seq tf_dear_ssn_info(
		  rec_layout_ssn_lookups_seq l, 
			FraudDefenseNetwork_Services.Layouts.batch_response_rec r) := transform
				self.fdn_ssn_ind := func_set_indicator(r.classification_Permissible_use_access.file_type),
        self := l
    end;

	  ds_in_sslr_seq_with_sInd := join(ds_in_sslr_seq, ds_in_all_fdn_chkd,
										                   left.ssn_unmasked = right.ssn and 
																			 right.ssn != ''               and
																			 ((IncludeSubject and right.did = SUBJECT_DID) or	
			                                  (IncludeAssociates and right.did != SUBJECT_DID)), 
						                         tf_dear_ssn_info(left,right),
													           LEFT OUTER);

    // Sort/dedup to only keep 1 rec per seq#, preferring ones with fdn ind set on. 
		shared ds_in_sslr_seq_with_sInd_dd := dedup(sort(ds_in_sslr_seq_with_sInd,
		                                                 seq, -fdn_ssn_ind), seq);
													 
    // ============================================================ 
    // Set on any fdn indicators in the input relr dataset records.
	  // ============================================================
	  //
    // First, join the ds of sequenced input to the ds above out of the FDN function to set the
	  // FDN did indicator.
    shared rec_layout_relative_summary_seq tf_relr_did_info(
		  rec_layout_relative_summary_seq l, 
			FraudDefenseNetwork_Services.Layouts.batch_response_rec r) := transform
				self.fdn_did_ind := func_set_indicator(r.classification_Permissible_use_access.file_type),
        self := l
    end;

	  ds_in_relr_seq_with_dInd := join(ds_in_relr_seq, ds_in_all_fdn_chkd,
														           left.person2 = right.did and //left.person2 field is the did
																			 right.did !=0            and 
																		   IncludeAssociates,
																	   tf_relr_did_info(left,right),
													           LEFT OUTER);

    // Sort/dedup to only keep 1 rec per seq#, preferring ones with fdn ind set on. 
		shared ds_in_relr_seq_with_dInd_dd := dedup(sort(ds_in_relr_seq_with_dInd,
		                                                 seq, -fdn_did_ind), seq);
													 
    // ============================================================ 
    // Set on any fdn indicators in the input assr dataset records.
		// NOTE: assr ds has the same layotu as the relr ds above.
	  // ============================================================
	  //
    // First, join the ds of sequenced input to the ds above out of the FDN function to set the
	  // FDN did indicator.
	  ds_in_assr_seq_with_dInd := join(ds_in_assr_seq, ds_in_all_fdn_chkd, 
														           left.person2 = right.did and //left.person2 field is the did
																			 right.did !=0            and 
																		   IncludeAssociates,
																	    tf_relr_did_info(left,right),
													           LEFT OUTER);

    // Sort/dedup to only keep 1 rec per seq#, preferring ones with fdn ind set on. 
		shared ds_in_assr_seq_with_dInd_dd := dedup(sort(ds_in_assr_seq_with_dInd,
		                                                 seq, -fdn_did_ind), seq);
													 
    // ============================================================ 
    // Set on any fdn indicators in the input nbrr2 dataset records.
	  // ============================================================
	  //
    // First, join the ds of sequenced input to the ds above out of the FDN function to set the
	  // FDN did indicator.
    rec_layout_nbr_records_slim_seq tf_nbrr2_did_info(
		 rec_layout_nbr_records_slim_seq l, 
			FraudDefenseNetwork_Services.Layouts.batch_response_rec r) := transform
				self.fdn_did_ind := func_set_indicator(r.classification_Permissible_use_access.file_type),
        self := l
    end;
		
	  ds_in_nbrr2_seq_with_dInd := join(ds_in_nbrr2_seq, ds_in_all_fdn_chkd,
														           left.did = right.did and 
																			 right.did !=0        and 
																		   IncludeAssociates, 
																	   tf_nbrr2_did_info(left,right),
													         LEFT OUTER //to keep all input recs whether they had fdn data or not
												          );

    // Sort/dedup to only keep 1 rec per seq#, preferring ones with fdn ind set on.
		shared ds_in_nbrr2_seq_with_dInd_dd := dedup(sort(ds_in_nbrr2_seq_with_dInd,
		                                                  seq, -fdn_did_ind), seq);
													 
	
    //Debugging outputs	(these need to be before final exports!!!)
		// May have to add "shared " on the front of some dataset above to output them here!!!
    //output(IncludeSubject,         named('IncludeSubject'));
    //output(IncludeAssociates, named('IncludeAssociates'));
 	  //output(in_gc_id,                  named('in_gc_id'));
	  //output(in_ind_type,               named('in_ind_type'));
	  //output(in_product_code,           named('in_product_code'));
    //output(FDNContDataPermitted,      named('FDNContDataPermitted'));
	  //output(FDNInqDataPermitted,       named('FDNInqDataPermitted'));
    //output(ds_in_besr,                     named('ds_in_besr'));
	  //output(SUBJECT_DID,                    named('SUBJECT_DID'));
	  //output(SUBJECT_SSN,                    named('SUBJECT_SSN'));
	  //output(SUBJECT_PHONE,                  named('SUBJECT_PHONE'));
	  //output(ds_in_besr_seq,                 named('ds_in_besr_seq'));
	  //output(ds_in_besr_seq_normed,          named('ds_in_besr_seq_normed'));
		//output(ds_in_besr_seq_phones_children, named('ds_in_besr_seq_phones_children'));
		//output(ds_in_besr_seq_pc_dedup,        named('ds_in_besr_seq_pc_dedup'));
    //output(ds_in_ssnr,                named('ds_in_ssnr'));
	  //output(ds_in_ssnr_seq,            named('ds_in_ssnr_seq'));
	  //output(ds_in_ssnr_seq_normed,     named('ds_in_ssnr_seq_normed'));
    //output(ds_in_shrr,                named('ds_in_shrr'));
	  //output(ds_in_shrr_seq,            named('ds_in_shrr_seq'));
	  //output(ds_in_shrr_seq_normed,     named('ds_in_shrr_seq_normed'));
    //output(ds_in_dear,                named('ds_in_dear'));
	  //output(ds_in_dear_seq,            named('ds_in_dear_seq'));
	  //output(ds_in_dear_seq_normed,     named('ds_in_dear_seq_normed'));
    //output(ds_in_addr,                named('ds_in_addr'));
	  //output(ds_in_addr_seq,            named('ds_in_addr_seq'));
	  //output(ds_in_addr_seq_normed,     named('ds_in_addr_seq_normed'));
    //output(ds_in_namr,                named('ds_in_namr'));
	  //output(ds_in_namr_seq,            named('ds_in_namr_seq'));
	  //output(ds_in_namr_seq_normed,     named('ds_in_namr_seq_normed'));
    //output(ds_in_phor,                named('ds_in_phor'));
	  //output(ds_in_phor_seq,            named('ds_in_phor_seq'));
	  //output(ds_in_phor_seq_normed,     named('ds_in_phor_seq_normed'));
		//output(ds_in_phor_seq_prjted,     named('ds_in_phor_seq_prjted'));
    //output(ds_in_phold,               named('ds_in_phold'));
	  //output(ds_in_phold_seq,           named('ds_in_phold_seq'));
	  //output(ds_in_phold_seq_normed,    named('ds_in_phold_seq_normed'));
    //output(ds_in_sslr,                named('ds_in_sslr'));
	  //output(ds_in_sslr_seq,            named('ds_in_sslr_seq'));
	  //output(ds_in_sslr_seq_prjted,     named('ds_in_sslr_seq_prjted'));
    //output(ds_in_relr,                named('ds_in_relr'));
	  //output(ds_in_relr_seq,            named('ds_in_relr_seq'));
	  //output(ds_in_relr_seq_prjted,     named('ds_in_relr_seq_prjted'));
    //output(ds_in_assr,                named('ds_in_assr'));
	  //output(ds_in_assr_seq,            named('ds_in_assr_seq'));
	  //output(ds_in_assr_seq_prjted,     named('ds_in_assr_seq_prjted'));
    //output(ds_in_nbrr2,               named('ds_in_nbrr2'));
	  //output(ds_in_nbrr2_seq,           named('ds_in_nbrr2_seq'));
	  //output(ds_in_nbrr2_seq_prjted,    named('ds_in_nbrr2_seq_prjted'));

	  //output(ds_in_all_normed_combined, named('ds_in_all_normed_combined'));
    //output(ds_in_all_nc_dedup,        named('ds_in_all_nc_dedup'));
	  //output(ds_in_all_fdn_chkd_raw,    named('ds_in_all_fdn_chkd_raw'));
	  //output(ds_in_all_fdn_chkd,        named('ds_in_all_fdn_chkd'));
	  //if needed, move to below after waf is set //output(fdn_waf_ind, named('fdn_waf_ind'));

	  //output(ds_in_besr_seq_with_dInd,        named('ds_in_besr_seq_with_dInd'));
	  //output(ds_in_besr_seq_with_dInd_dd,     named('ds_in_besr_seq_with_dInd_dd'));
    //output(ds_in_besr_seq_with_daInds,      named('ds_in_besr_seq_with_daInds'));
    //output(ds_in_besr_seq_with_daInds_dd,   named('ds_in_besr_seq_with_daInds_dd'));
    //output(ds_in_besr_seq_with_dasInds,     named('ds_in_besr_seq_with_dasInds'));
    //output(ds_in_besr_seq_with_dasInds_dd,  named('ds_in_besr_seq_with_dasInds_dd'));
    //output(ds_in_besr_seq_with_daspInds,    named('ds_in_besr_seq_with_daspInds'));
    //output(ds_in_besr_seq_with_daspInds_dd, named('ds_in_besr_seq_with_daspInds_dd'));
    //output(ds_in_besr_seq_pc_with_fdnind,   named('ds_in_besr_seq_pc_with_fdnind'));
    //output(ds_in_besr_seq_denorm_phones,    named('ds_in_besr_seq_denorm_phones'));
	  //output(ds_in_ssnr_seq_with_dInd,        named('ds_in_ssnr_seq_with_dInd'));
	  //output(ds_in_ssnr_seq_with_dInd_dd,     named('ds_in_ssnr_seq_with_dInd_dd'));
    //output(ds_in_ssnr_seq_with_dsInds,      named('ds_in_ssnr_seq_with_dsInds'));
    //output(ds_in_ssnr_seq_with_dsInds_dd,   named('ds_in_ssnr_seq_with_dsInds_dd'));
	  //output(ds_in_shrr_seq_with_dInd,        named('ds_in_shrr_seq_with_dInd'));
	  //output(ds_in_shrr_seq_with_dInd_dd,     named('ds_in_shrr_seq_with_dInd_dd'));
    //output(ds_in_shrr_seq_with_dsInds,      named('ds_in_shrr_seq_with_dsInds'));
    //output(ds_in_shrr_seq_with_dsInds_dd,   named('ds_in_shrr_seq_with_dsInds_dd'));
	  //output(ds_in_dear_seq_with_dInd,        named('ds_in_dear_seq_with_dInd'));
	  //output(ds_in_dear_seq_with_dInd_dd,     named('ds_in_dear_seq_with_dInd_dd'));
    //output(ds_in_dear_seq_with_dsInds,      named('ds_in_dear_seq_with_dsInds'));
    //output(ds_in_dear_seq_with_dsInds_dd,   named('ds_in_dear_seq_with_dsInds_dd'));
	  //output(ds_in_addr_seq_with_dInd,        named('ds_in_addr_seq_with_dInd'));
	  //output(ds_in_addr_seq_with_dInd_dd,     named('ds_in_addr_seq_with_dInd_dd'));
    //output(ds_in_addr_seq_with_daInds,      named('ds_in_addr_seq_with_daInds'));
    //output(ds_in_addr_seq_with_daInds_dd,   named('ds_in_addr_seq_with_daInds_dd'));
    //output(ds_in_addr_seq_with_dapInds,     named('ds_in_addr_seq_with_dapInds'));
    //output(ds_in_addr_seq_with_dapInds_dd,  named('ds_in_addr_seq_with_dapInds_dd'));
    //output(ds_in_addr_seq_with_daplInds,    named('ds_in_addr_seq_with_daplInds'));
    //output(ds_in_addr_seq_with_daplInds_dd, named('ds_in_addr_seq_with_daplInds_dd'));
 	  //output(ds_in_namr_seq_with_dInd,        named('ds_in_namr_seq_with_dInd'));
	  //output(ds_in_namr_seq_with_dInd_dd,     named('ds_in_namr_seq_with_dInd_dd'));
    //output(ds_in_namr_seq_with_dsInds,      named('ds_in_namr_seq_with_dsInds'));
    //output(ds_in_namr_seq_with_dsInds_dd,   named('ds_in_namr_seq_with_dsInds_dd'));
    //output(ds_in_phor_seq_with_pInd,          named('ds_in_phor_seq_with_pInd'));
    //output(ds_in_phor_seq_with_pInd_dd,       named('ds_in_phor_seq_with_pInd_dd'));
	  //output(ds_in_phold_seq_with_dInd,        named('ds_in_phold_seq_with_dInd'));
	  //output(ds_in_phold_seq_with_dInd_dd,     named('ds_in_phold_seq_with_dInd_dd'));
    //output(ds_in_phold_seq_with_dpInds,      named('ds_in_phold_seq_with_dpInds'));
    //output(ds_in_phold_seq_with_dpInds_dd,   named('ds_in_phold_seq_with_dpInds_dd'));
	  //output(ds_in_sslr_seq_with_sInd,        named('ds_in_sslr_seq_with_sInd'));
	  //output(ds_in_sslr_seq_with_sInd_dd,     named('ds_in_sslr_seq_with_sInd_dd'));
	  //output(ds_in_relr_seq_with_dInd,        named('ds_in_relr_seq_with_dInd'));
	  //output(ds_in_relr_seq_with_dInd_dd,     named('ds_in_relr_seq_with_dInd_dd'));
	  //output(ds_in_assr_seq_with_dInd,        named('ds_in_assr_seq_with_dInd'));
	  //output(ds_in_assr_seq_with_dInd_dd,     named('ds_in_assr_seq_with_dInd_dd'));
	  //output(ds_in_nbrr2_seq_with_dInd,        named('ds_in_nbrr2_seq_with_dInd'));
	  //output(ds_in_nbrr2_seq_with_dInd_dd,     named('ds_in_nbrr2_seq_with_dInd_dd'));

  
		// *******************************************************************************
		// Exports for all the input datasets with the FDN indicators set on or just the 
    // original input dataset with empty fdn inds, depending upon what was requested.
		// *******************************************************************************

    // Before exporting, do a project to append the FDN Waf Contrib Data indicator to the besr 
		// dataset with fdn inds first checking if any of the records out of FraudDefenseNetwork_Services function
		// were contributory data and contributory data is not permitted.  If so, we need to return 
		// a "FDN We Also Found Contributory Data" indicator that this condition existed when either 
		// Include Subject or Include All was requested.
		boolean fdn_waf_ind := EXISTS(ds_in_all_fdn_chkd_raw(
                                  classification_Permissible_use_access.file_type = ContribData)) 
		                              and NOT FDNContDataPermitted;

		export ds_besr_fdn_checked := project(if(IncludeSubject,
		                                         ds_in_besr_with_fdn_inds, ds_in_besr),
                                          transform(doxie_crs.layout_best_information, 
																		        // even if IncludeSubject not requested, fdn waf 
																				    // might need set on if IncludeFDNAllAssoc was requested 
			                                      self.fdn_waf_contrib_data := (IncludeSubject or 
										                                                      IncludeAssociates)
																							  												 and fdn_waf_ind,
                                            self := left));

    export ds_ssnr_fdn_checked  := if(IncludeSubject or IncludeAssociates,
																			project(ds_in_ssnr_seq_with_dsInds_dd,doxie_crs.layout_ssn_records),
																			ds_in_ssnr);
	
	  export ds_shrr_fdn_checked  := if(IncludeSubject or IncludeAssociates, 
																			project(ds_in_shrr_seq_with_dsInds_dd,doxie_crs.layout_HRI_SSN),
																			ds_in_shrr);
		
		export ds_dear_fdn_checked  := if(IncludeSubject or IncludeAssociates,
																		 project(ds_in_dear_seq_with_dsInds_dd,doxie_crs.layout_deathfile_records),
																		 ds_in_dear);

    export ds_addr_fdn_checked  := if(IncludeSubject or IncludeAssociates,
																			project(ds_in_addr_seq_with_daplInds_dd,doxie.Layout_Comp_Addr_Utility_Recs),
																			ds_in_addr);

    export ds_namr_fdn_checked  := if(IncludeSubject or IncludeAssociates,
																			project(ds_in_namr_seq_with_dsInds_dd,doxie_crs.layout_comp_names),
																			ds_in_namr);

    export ds_phor_fdn_checked  := if(IncludeSubject or IncludeAssociates,
																			project(ds_in_phor_seq_with_pInd_dd,doxie_crs.layout_phone_records),
																			ds_in_phor);

    export ds_phold_fdn_checked := if(IncludeSubject or IncludeAssociates,
																			project(ds_in_phold_seq_with_dpInds_dd,doxie_crs.Layout_Phones_Old),
																			ds_in_phold);

    export ds_sslr_fdn_checked  := if(IncludeSubject or IncludeAssociates,
																			project(ds_in_sslr_seq_with_sInd_dd,doxie_crs.layout_ssn_lookups),
																			ds_in_sslr);

    export ds_relr_fdn_checked  := if(IncludeAssociates,
																			project(ds_in_relr_seq_with_dInd_dd,doxie_crs.layout_relative_summary),
																			ds_in_relr);

    export ds_assr_fdn_checked  := if(IncludeAssociates,
																			project(ds_in_assr_seq_with_dInd_dd,doxie_crs.layout_relative_summary),
																			ds_in_assr);

    export ds_nbrr2_fdn_checked := if(IncludeAssociates,
																			project(ds_in_nbrr2_seq_with_dInd_dd,doxie.layout_nbr_records_slim),
																			ds_in_nbrr2);

    // ************************************************************************************
    // Finally export the dataset of fdn id key records out the FDN function that checked 
		// for the desired fields in the FDN keys. Filter, project, sort & dedup the ds to drop 
		// contributory data recs if not permitted, and to only keep recs with unique fdn 
		// record_id values.
    // *****************************************************************************
    export ds_fdnidkey_recs_matched := dedup(sort(project(
		   ds_in_all_fdn_chkd_raw
				// first filter to keep inquiry data or contributory data (but only if permitted)
	      (classification_Permissible_use_access.file_type <> ContribData //if not contrib, it's inquiry data
				 OR 
				 (classification_Permissible_use_access.file_type = ContribData //contributory data
					and FDNContDataPermitted)), //and contributory data permitted
		                                                      transform(FraudShared_Services.Layouts.Raw_Payload_rec,
																									          self.acctno := (string) left.seq,
																							              self := left)),
																								  record_id),
																					   record_id);
																					
END;
