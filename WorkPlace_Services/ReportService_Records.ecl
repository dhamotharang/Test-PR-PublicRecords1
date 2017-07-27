import BatchServices,DCA,doxie,doxie_cbrs,iesp,MDR,POE,PSS,Prof_LicenseV2,risk_indicators,spoke,ut,suppress,AutoStandardI;

export ReportService_Records := module

	export params := interface(AutoStandardI.InterfaceTranslator.application_type_val.params,
														 AutoStandardI.InterfaceTranslator.glb_purpose.params)
	  // Fields passed in from ReportService via in_mod and used throughout this attribute.
    export string12 unique_id  := '';  // same as did
		export boolean include_sos	:= false;
		export boolean is_spouse	  := false;
    export string excluded_sources := '';     // default to null (no excluded sources)
	end;

	export val(params in_mod) := function

    // ***** Main processing

	  // 1. Store passed in field & options into internal booleans/string
		unsigned6 in_did_int        := (unsigned6) in_mod.unique_id;
    boolean IncludeSosInfo      := in_mod.include_sos;
	  boolean IsSpouse            := in_mod.is_spouse;
	  string1 in_spouse_indicator := if(IsSpouse,'Y','N');
    string in_excluded_sources  := in_mod.excluded_sources;

		// Edit the input ExcludedSources string as needed for processing below.
    in_excluded_sources_edited := TRIM(Stringlib.StringToUpperCase(in_excluded_sources),
	                                     LEFT,RIGHT,ALL);

    // Next if not empty, parse the input "ExcludedSources" comma de-limited list
	  // string to create a dataset of any 2 character source codes to be excluded.
    layout_source := record
	    string2 source;
	  end;
	
    ds_excluded_sources := 
	     if(in_excluded_sources_edited = '',
	        dataset([], layout_source),
			    dataset(ut.Stringsplit(in_excluded_sources_edited, ','), layout_source));

    // 2. Use the input to create a dataset of 1 record in the layout needed by the  
	  //    getPoeRecs function.
    BatchServices.WorkPlace_Layouts.POE_lookup xfm_make_single_record() := transform
      self.acctno           := 'acctno1';
      self.lookupDid        := in_did_int;
		  self.subjectDid       := if(IsSpouse,0,in_did_int);
		  self.spouseDid        := if(IsSpouse,in_did_int,0);
      self.spouse_indicator := in_spouse_indicator;
      self                  := [];
    end;

    ds_did_in := dataset([xfm_make_single_record()]);

	  //  3. Get all the POE and PSS recs for the passed in did.
    ds_poe_recs_slimmed := WorkPlace_Services.Functions.getPoeRecs(
		                         ds_did_in,
														 dataset([],BatchServices.WorkPlace_Layouts.POE_lookup));

		ds_pss_recs_slimmed	:=	WorkPlace_Services.Functions.getPSSRecs(ds_did_in,dataset([],BatchServices.WorkPlace_Layouts.POE_lookup));
		
    // 5. Combine POE & PSS slimmed recs into 1 dataset here and 
	  //    join to POE source_hierarchy key file to assign the source_order.
	  ds_all_recs_slimmed := join(ds_poe_recs_slimmed	+	ds_pss_recs_slimmed,
	                              POE.Keys().source_hierarchy.qa,
			  												keyed(left.source = right.source),
	                              transform(WorkPlace_Services.Layouts.poe_didkey_plus,
					  										  // get source_order from the right key file
						  						        self.source_order := right.source_order,
							  									// keep the rest of fields from left
                                  self              := left),
									  			      LEFT OUTER); // keep left record in case no match to right key file

    // 6. Filter to only include records for sources that are not restricted;
	  //    based upon the DataRestrictionMask positions associated with those sources.
    ds_all_recs_not_restricted := ds_all_recs_slimmed(
	       // Include the record if the source is not restricted.
			   // NOTE1: As of 01/14/2011, Teletrack is the only source that might be 
			   //                          restricted via the DataRestrictionMask.
		     (MDR.sourceTools.SourceIsTeletrack(source) and ~doxie.DataRestriction.TT) OR
         // OR include the record if the source is not Teletrack.
			   ~MDR.sourceTools.SourceIsTeletrack(source));

		// 7.1 Applying GLB restrictions to utility records.
		ds_all_recs_glb_ok := ds_all_recs_not_restricted(ut.PermissionTools.glb.SrcOk(in_mod.GLBPurpose, source, dt_first_seen, 0));

    // 7. Next do a "left only" join to the excluded_sources dataset to pass through         ??? 
    //    all sources that are not excluded.
    ds_all_recs_included := join(ds_all_recs_glb_ok, ds_excluded_sources,
	                                 left.source = right.source,
															   transform(left),
	                               left only //only include left recs with no match in right ds ???
															  );

    // 8. pull recs by ssn & did.
		Suppress.MAC_Suppress(ds_all_recs_included,ds_dids_pulled,in_mod.applicationtype,Suppress.Constants.LinkTypes.DID,did);
		Suppress.MAC_Suppress(ds_dids_pulled,ds_ssns_pulled,in_mod.applicationtype,Suppress.Constants.LinkTypes.SSN,subject_ssn);
	  doxie.MAC_PruneOldSSNs(ds_ssns_pulled, ds_all_recs_pulled, subject_ssn, did);

    // 9.  Get "best" company name/address/phone if missing and then clean the data.
		//
	  // 9.1 First try to add any missing company info using the business-header best file. 
	  ds_all_recs_bhbest_added := 
		   BatchServices.WorkPlace_Functions.AddBestInfo(ds_all_recs_pulled);
		
	  // 9.2 Remove invalid/disconnected/residential numbers in the company_phone1/2 fields.
	  ds_all_recs_phones_cleaned := 
		   BatchServices.WorkPlace_Functions.CleanPhones(ds_all_recs_bhbest_added);

	  // 9.3 Remove company_names with only invalid terms.
	  ds_all_recs_cname_cleaned := 
		   BatchServices.WorkPlace_Functions.CleanCompName(ds_all_recs_phones_cleaned);

    // 10.  Try to fill in phone1/2 and any company info still missing.
		//
    // 10.1 Get any missing company name/address info from gong history phone# key.
    ds_all_recs_gongcomp := 
     	 WorkPlace_Services.Functions.getCompInfoFromGong(ds_all_recs_cname_cleaned);
					
	  // 10.2 Get phone1/2 for bdid from the gong history bdid key.
    ds_all_recs_gongphone := 
     	 WorkPlace_Services.Functions.getPhoneFromGong(ds_all_recs_gongcomp);

    // 10.3 Get phone1/2 for the bdid from the yellow pages bdid key.
    ds_all_recs_ypphone :=	 
	     WorkPlace_Services.Functions.getPhoneFromYP(ds_all_recs_gongphone);

		// 10.4 Show only phone numbers which do not exist in PSS or that match the criteria of phone status = A and is in the 30 day window
		ds_suppress_badphones	:=	Workplace_Services.Functions.SuppressPhones(ds_all_recs_ypphone);

	  // 11. Identify the 1 most complete/"best candidate" record
	  //
	  // 11.1 First filter to only use "complete" info recs, which according to the 
	  //      product specs are those records with a non-blank company_name and a 
	  //      non-blank company phone1.
    ds_most_complete_all := ds_suppress_badphones(	company_name<>'' and  // need a comp name
																										company_phone1<>'');  // need a phone

	  // 11.2 Sort all complete recs by: 
	  //      1. did (puts all recs for the subject together)
	  //      2. descending dt_last_seen (puts most recent first) and 
	  //      3. source_code order (in case multiple recs have the same most recent date)
	  ds_most_complete_srtd := sort(ds_most_complete_all,
	                                did, -dt_last_seen, source_order, record); 

    // 11.3 Then dedup by did to identify the 1 most current record for the did.
    ds_most_current1 := dedup(ds_most_complete_srtd, did);

    // 11.4 Match all complete recs for a did to the most current one for a did to keep 
	  //      any recs for the did that have the same bdid/company name & phone1 as the 
	  //      most current one and are within 14 days of the most current dt_last_seen.
    ds_best_recs_for_did := join(ds_most_complete_srtd,ds_most_current1,
	                               left.did = right.did                            and 
	                               // check for bdids the same in case company names are slightly different
	                               ((left.bdid !=0 and left.bdid = right.bdid) or
													        left.company_name = right.company_name)        and
													       // phone1 values have to be the same
	                               left.company_phone1 = right.company_phone1      and
													       // dt_last_seen values have to be within 14 days
	                               ut.DaysApart((string8) left.dt_last_seen, (string8) right.dt_last_seen)
													          <= BatchServices.WorkPlace_Constants.DAYS_WINDOW,
													       transform(WorkPlace_Services.Layouts.poe_didkey_plus,
															     self := left),
													       inner, // only keep recs from left that match right on join conditions
												         limit(BatchServices.WorkPlace_Constants.Limits.JOIN_LIMIT));

    // 11.5 Sort the best recs for a did in order by:
		//        1. ascending source_order 
		//        2. descending dt_last_seen
		//      Then dedup to only keep the 1 "best candidate" (lowest source_order) record 
		//      for the did.
	  ds_best_candidate := dedup(sort(ds_best_recs_for_did,
	                                  did, source_order, -dt_last_seen, record),
													     did); 

    // 16. For the main WP company, get the corporation status and 
		//     the optional (if requested) extra Secretary Of State Info.
	  //
	  // 16.1 Project a record with a non-zero bdid onto the appropriate layout and 
	  //      then call a function to get the corp/SOS info.
    ds_best_cand_bdid_corpstat := BatchServices.WorkPlace_Functions.getCorpStatus(
													          project(ds_best_candidate(bdid!=0), 
												                    doxie_cbrs.layout_references), 
																		IncludeSosInfo);
  
    // 16.2 Join the bdid with a corp status back to the ds of most_current record 
	  //      to attach the corp status to it.
    ds_best_cand_wcorpstat := join(ds_best_candidate, ds_best_cand_bdid_corpstat,
				                             left.bdid=right.bdid,
                                   transform(WorkPlace_Services.Layouts.poe_didkey_plus,
													           // take corp/sos info from right
												             self.company_status        := right.corp_status_desc,
																	   self.sos_comp_name         := right.sos_comp_name,
 		                                 self.sos_name_as_of_date   := right.sos_name_as_of_date,
                                     self.sos_name_type         := right.sos_name_type,
																		 self.sos_comp_prim_range  := right.sos_comp_prim_range,
                                     self.sos_comp_predir      := right.sos_comp_predir,
                                     self.sos_comp_prim_name   := right.sos_comp_prim_name,
                                     self.sos_comp_addr_suffix := right.sos_comp_addr_suffix,
                                     self.sos_comp_postdir     := right.sos_comp_postdir,
                                     self.sos_comp_unit_desig  := right.sos_comp_unit_desig,
																		 self.sos_comp_sec_range   := right.sos_comp_sec_range,
                                     self.sos_comp_city        := right.sos_comp_city,
                                     self.sos_comp_state       := right.sos_comp_state,
                                     self.sos_comp_zip         := right.sos_comp_zip, 
																		 self.sos_comp_zip4        := right.sos_comp_zip4,
  	                                 self.sos_address_type     := right.sos_address_type,
                                     self.sos_status           := right.sos_status,
		                                 self.sos_business_type    := right.sos_business_type,
		                                 self.sos_purpose          := right.sos_purpose,
		                                 self.sos_filing_date      := right.sos_filing_date,
		                                 self.sos_for_incorp_date  := right.sos_for_incorp_date,
		                                 self.sos_term             := right.sos_term,
		                                 self.sos_igs              := right.sos_igs,
		                                 self.sos_reg_agent_name    := right.sos_reg_agent_name,
														         self.sos_reg_agent_prim_range  := right.sos_reg_agent_prim_range,
                                     self.sos_reg_agent_predir      := right.sos_reg_agent_predir,
																		 self.sos_reg_agent_prim_name   := right.sos_reg_agent_prim_name,
                                     self.sos_reg_agent_addr_suffix := right.sos_reg_agent_addr_suffix,
                                     self.sos_reg_agent_postdir     := right.sos_reg_agent_postdir,
                                     self.sos_reg_agent_unit_desig  := right.sos_reg_agent_unit_desig,
                                     self.sos_reg_agent_sec_range   := right.sos_reg_agent_sec_range,
																		 self.sos_reg_agent_city    := right.sos_reg_agent_city,
                                     self.sos_reg_agent_state   := right.sos_reg_agent_state,
                                     self.sos_reg_agent_zip     := right.sos_reg_agent_zip,
																		 self.sos_reg_agent_zip4    := right.sos_reg_agent_zip4,
		                                 self.sos_place_incorp      := right.sos_place_incorp,
                                     // Rest of the fields, keep the ones from the left ds
                                     self := left),
											             left outer,  // keep the record from the left ds
												           atmost(BatchServices.WorkPlace_Constants.Limits.JOIN_LIMIT));

	  // 17. Get additional (history) company info
	  //
    // 17.1 First filter the most complete recs to only include any non-royalty sources, 
		//      because royalty sources are not to be used for additional data.
    ds_most_complete_fltrd := ds_most_complete_srtd(
                                source not in BatchServices.WorkPlace_Constants.WP_ROYALTY_SOURCE_SET);

    // 17.2 Next sort/dedup the filtered recs to only keep the recs with a  
	  //      unique company_name.
    ds_most_complete_unique_compname := dedup(sort(ds_most_complete_fltrd,
		                                               company_name, -dt_last_seen, source_order, record),
	                                            company_name);

    // 17.3 Next sort/dedup again to only keep 1 rec for each unique bdid.
    ds_most_complete_unique_bdid := dedup(sort(ds_most_complete_unique_compname,
		                                           bdid, -dt_last_seen, source_order, record),
	                                        bdid);		
	
    // 17.4 Next do a left only join to remove the current rec from the 
	  //      ds with all the potential additional/history recs.
    ds_most_complete_addl := join(ds_most_complete_unique_bdid,ds_best_candidate,		
	                                  left.did          = right.did and 
															      left.dt_last_seen = right.dt_last_seen and 
															      left.source_order = right.source_order,
															    transform(WorkPlace_Services.Layouts.poe_didkey_plus,
															      self := left),
															    left only, // keep left recs with no match in right ds
															    atmost(BatchServices.WorkPlace_Constants.Limits.JOIN_LIMIT));

    // 17.5 Next sort/dedup the remaining recs to keep the 2 next most current recs.
    ds_addl_2recs := dedup(sort(ds_most_complete_addl,
		                            did, -dt_last_seen, source_order, record),
	                         did, dt_last_seen, source_order,
	                         KEEP(BatchServices.WorkPlace_Constants.Limits.KEEP_HIST));

    // 17.6 Get optional corp status info for the additional(history) recs.
	  //
	  // 17.6.1 Sort/dedup on non-zero bdids (to reduce the number of lookups), then 
	  //        project onto appropriate layout and call a function to get the status.
    ds_addl_2recs_bdids_corpstat := BatchServices.WorkPlace_Functions.getCorpStatus(
																	    dedup(sort(project(ds_addl_2recs(bdid!=0), 
																			                   doxie_cbrs.layout_references), 
																								 bdid), bdid));

    // 17.6.2 Join the bdids with a corp status back to the ds of addl/hist records 
	  //        to attach the corp status to them.
	  ds_addl_2recs_wcorpstat := join(ds_addl_2recs, ds_addl_2recs_bdids_corpstat,
				                              left.bdid=right.bdid,
                                    transform(WorkPlace_Services.Layouts.poe_didkey_plus,
													            // only take status from right
													            self.company_status := right.corp_status_desc,
                                      // Rest of the fields, keep the ones from the left ds
                                      self             := left),
											              left outer,  // keep all the recs from the left ds
												            atmost(BatchServices.WorkPlace_Constants.Limits.JOIN_LIMIT));

 	  // 17.6.3 Combine up to 2 addl/hist recs for the did into a single layout to assist
	  //        in joining later.
    WorkPlace_Services.Layouts.poe_didkey_plus 
	    xform_roll_addl(WorkPlace_Services.Layouts.poe_didkey_plus L,
			                dataset(WorkPlace_Services.Layouts.poe_didkey_plus) RL) := transform
		  self.did                       := L.did;
	    self.addl_wpl_bdid_1           := (string) L.bdid; 
      self.addl_wpl_comp_name_1      := L.company_name;
		  self.addl_wpl_comp_address1_1  := L.company_address;
      self.addl_wpl_comp_prim_range1_1  := L.company_prim_range;
      self.addl_wpl_comp_predir1_1      := L.company_predir;		
      self.addl_wpl_comp_prim_name1_1   := L.company_prim_name;
      self.addl_wpl_comp_addr_suffix1_1 := L.company_addr_suffix;		
      self.addl_wpl_comp_postdir1_1     := L.company_postdir;		
      self.addl_wpl_comp_unit_desig1_1  := L.company_unit_desig;
      self.addl_wpl_comp_sec_range1_1   := L.company_sec_range;
      self.addl_wpl_comp_city_1      := L.company_city;
      self.addl_wpl_comp_state_1     := L.company_state;
      self.addl_wpl_comp_zip_1       := L.company_zip;
      self.addl_wpl_comp_zip4_1      := L.company_zip4;
      self.addl_wpl_phone1_1         := L.company_phone1; 
      self.addl_wpl_phone2_1         := L.company_phone2; 
		  self.addl_wpl_status_1         := L.company_status; 
      self.addl_wpl_last_seen_date_1 := (string) L.dt_last_seen;
	    self.addl_wpl_bdid_2           := (string) RL[2].bdid; 
      self.addl_wpl_comp_name_2      := RL[2].company_name;
		  self.addl_wpl_comp_address1_2  := RL[2].company_address;
      self.addl_wpl_comp_prim_range1_2  := RL[2].company_prim_range;
      self.addl_wpl_comp_predir1_2      := RL[2].company_predir;		
      self.addl_wpl_comp_prim_name1_2   := RL[2].company_prim_name;
      self.addl_wpl_comp_addr_suffix1_2 := RL[2].company_addr_suffix;		
      self.addl_wpl_comp_postdir1_2     := RL[2].company_postdir;		
      self.addl_wpl_comp_unit_desig1_2  := RL[2].company_unit_desig;
      self.addl_wpl_comp_sec_range1_2   := RL[2].company_sec_range;
      self.addl_wpl_comp_city_2      := RL[2].company_city;
      self.addl_wpl_comp_state_2     := RL[2].company_state;
      self.addl_wpl_comp_zip_2       := RL[2].company_zip;
      self.addl_wpl_comp_zip4_2      := RL[2].company_zip4;
      self.addl_wpl_phone1_2         := RL[2].company_phone1; 
      self.addl_wpl_phone2_2         := RL[2].company_phone2;
      self.addl_wpl_status_2         := RL[2].company_status;
      self.addl_wpl_last_seen_date_2 := (string) RL[2].dt_last_seen;
	  end;
	
    ds_addl_combined := rollup(group(sort(ds_addl_2recs_wcorpstat,
	                                        did,-dt_last_seen, source_order, record),
																	   did),
														   group,
														   xform_roll_addl(left,rows(left)));

    // 17.7 Join the additional(history) recs to the most current rec on did.
	  ds_best_cand_waddl := join(ds_best_cand_wcorpstat,ds_addl_combined,
														     left.did = right.did,
															 transform(WorkPlace_Services.Layouts.poe_didkey_plus,
																 // assign additional wpl fields from right
	                               self.addl_wpl_bdid_1              := right.addl_wpl_bdid_1,
                                 self.addl_wpl_comp_name_1         := right.addl_wpl_comp_name_1,
		                             self.addl_wpl_comp_address1_1     := right.addl_wpl_comp_address1_1,
                                 self.addl_wpl_comp_prim_range1_1  := right.addl_wpl_comp_prim_range1_1;
                                 self.addl_wpl_comp_predir1_1      := right.addl_wpl_comp_predir1_1;		
                                 self.addl_wpl_comp_prim_name1_1   := right.addl_wpl_comp_prim_name1_1;
                                 self.addl_wpl_comp_addr_suffix1_1 := right.addl_wpl_comp_addr_suffix1_1;		
                                 self.addl_wpl_comp_postdir1_1     := right.addl_wpl_comp_postdir1_1;		
                                 self.addl_wpl_comp_unit_desig1_1  := right.addl_wpl_comp_unit_desig1_1;
                                 self.addl_wpl_comp_sec_range1_1   := right.addl_wpl_comp_sec_range1_1;
                                 self.addl_wpl_comp_city_1         := right.addl_wpl_comp_city_1, 
                                 self.addl_wpl_comp_state_1        := right.addl_wpl_comp_state_1, 
                                 self.addl_wpl_comp_zip_1          := right.addl_wpl_comp_zip_1, 
                                 self.addl_wpl_comp_zip4_1         := right.addl_wpl_comp_zip4_1, 
                                 self.addl_wpl_phone1_1            := right.addl_wpl_phone1_1, 
                                 self.addl_wpl_phone2_1            := right.addl_wpl_phone2_1, 
		                             self.addl_wpl_status_1            := right.addl_wpl_status_1,
                                 self.addl_wpl_last_seen_date_1    := right.addl_wpl_last_seen_date_1,
	                               self.addl_wpl_bdid_2              := right.addl_wpl_bdid_2,
                                 self.addl_wpl_comp_name_2         := right.addl_wpl_comp_name_2, 
		                             self.addl_wpl_comp_address1_2     := right.addl_wpl_comp_address1_2, 
                                 self.addl_wpl_comp_prim_range1_2  := right.addl_wpl_comp_prim_range1_2;
                                 self.addl_wpl_comp_predir1_2      := right.addl_wpl_comp_predir1_2;		
                                 self.addl_wpl_comp_prim_name1_2   := right.addl_wpl_comp_prim_name1_2;
                                 self.addl_wpl_comp_addr_suffix1_2 := right.addl_wpl_comp_addr_suffix1_2;		
                                 self.addl_wpl_comp_postdir1_2     := right.addl_wpl_comp_postdir1_2;		
                                 self.addl_wpl_comp_unit_desig1_2  := right.addl_wpl_comp_unit_desig1_2;
                                 self.addl_wpl_comp_sec_range1_2   := right.addl_wpl_comp_sec_range1_2;
                                 self.addl_wpl_comp_city_2         := right.addl_wpl_comp_city_2, 
                                 self.addl_wpl_comp_state_2        := right.addl_wpl_comp_state_2, 
                                 self.addl_wpl_comp_zip_2          := right.addl_wpl_comp_zip_2, 
                                 self.addl_wpl_comp_zip4_2         := right.addl_wpl_comp_zip4_2, 
                                 self.addl_wpl_phone1_2            := right.addl_wpl_phone1_2, 
                                 self.addl_wpl_phone2_2            := right.addl_wpl_phone2_2, 
		                             self.addl_wpl_status_2            := right.addl_wpl_status_2,
                                 self.addl_wpl_last_seen_date_2    := right.addl_wpl_last_seen_date_2,
																 // assign rest of fields from left
																 self := left),
															 left outer, // keep all recs from left whether they have hist or not
															 limit(BatchServices.WorkPlace_Constants.Limits.JOIN_LIMIT));

    // 18. Get some additional detailed POE data for specific sources from the 
		//     individual sources' did key file.
	  //     As of 01/04/11, we only need to get:
		//     1. the company_description from spoke

    //NOTE: For the individual source did key file joins below, we can't
	  //      additionally match on bdid because of the delay between the individual
	  //      product update and business header update when assigning a new bdid.
		//
	  // 18.1 Get the company_description field from the Spoke key did file.
	  ds_best_cand_wspoke := join(ds_best_cand_waddl,spoke.keys().did.qa,	
                                  keyed(left.did = right.did) and 
	                                MDR.sourceTools.SourceIsSpoke(left.source) and
													        // Match on additional field in case multiple recs for the did
													        left.dt_last_seen = right.dt_last_seen,
	                              transform(WorkPlace_Services.Layouts.poe_didkey_plus,
														      // only need 1 field from right spoke did key file, see spoke.layouts.keybuild
														      self.company_description := right.rawfields.Company_Business_Description,
											            // rest of the fields from the left 
                                  self              := left), 
												        left outer, // keep recs from left even if no match to right
													      keep(BatchServices.WorkPlace_Constants.Limits.KEEP_LIMIT),
													      limit(batchServices.WorkPlace_Constants.Limits.KEYED_JOIN_UNLIMITED));

	  ds_best_cand_walldetail := ds_best_cand_wspoke;
		
    // 19. Get parent company info.
    // NOTE: In DCA, the root-sub expression is a compound value: 
	  // the root (nine digits), followed by a dash, followed by the sub(sidiary) value
	  // (four digits). e.g. 123456789-1234. 
	  // The root denotes the top-level company at the head of a conglomerate or set of 
	  // subsidiaries. e.g. LexisNexis RiskSolution's root is Reed-Elsevier. 
	  // The sub is simply a surrogate identifier denoting a particular subsidiary in the 
	  // root's tree. 
	  // Therefore in the code below you'll see the expression:
    //     left.parent_number[1..9]  = right.root AND
    //     left.parent_number[11..14] = right.sub
    // Where [1..9] refers to the root portion of the parent_number and [11..14] refers 
	  // to the sub portion of the parent_number. We omit [10] of course, which is a dash.
    //
    // 19.1 First for the bdid; get the level, root, sub & parent_number info
	  // from the DCA bdid key file.
	  ds_bdid_dca_added := join(ds_best_cand_walldetail,DCA.Key_DCA_BDID,
			                          keyed(left.bdid = right.bdid),
			                         transform(Batchservices.WorkPlace_Layouts.dca_info,
														     // take certain DCA fields from right dca key bdid file
                                 self.bdid          := right.bdid, 
				                         self.level         := right.level,
												         self.root          := right.root,
												         self.sub           := right.sub,
												         self.parent_number := right.parent_number),
			                         inner, // only keep left recs that match to the right dca key
														   keep(Batchservices.WorkPlace_Constants.Limits.KEEP_LIMIT),
														   limit(Batchservices.WorkPlace_Constants.Limits.JOIN_LIMIT,skip));

    // 19.2 Next get parent company info for the bdid if it has a non-blank DCA root value.
    ds_bdid_parents := doxie_cbrs.get_DCA_records(project(ds_bdid_dca_added(root != ''),
		                                                      doxie_cbrs.layout_references), 
																									BatchServices.WorkPlace_Constants.DCA_RETREIVE_PARENT);

    // 19.3 Next attach the parent company info to the bdid with DCA data.
	  ds_bdid_wparent  := join(ds_bdid_dca_added, ds_bdid_parents,
		                          left.parent_number[1..9]  = right.root AND
													     // NOTE: position 7 = '-'; so it is skipped
		                           left.parent_number[11..14] = right.sub,
													   transform(Batchservices.WorkPlace_Layouts.dca_info,
														   // Get parent company fields from right file
														   self.parent_company_bdid    := if(right.bdid<>0,(string) right.bdid,'');
		                           self.parent_company_name    := StringLib.StringToUpperCase(right.Name),
															 self.parent_company_prim_range  := right.prim_range,
                               self.parent_company_predir      := right.predir,
                               self.parent_company_prim_name   := right.prim_name,
                               self.parent_company_addr_suffix := right.addr_suffix,
                               self.parent_company_postdir     := right.postdir,
                               self.parent_company_unit_desig  := right.unit_desig,
                               self.parent_company_sec_range   := right.sec_range,															 
															 self.parent_company_city        := right.p_city_name,
                               self.parent_company_state       := right.st,
                               self.parent_company_zip         := right.z5, 
															 self.parent_company_zip4        := right.zip4,
			                         self.parent_company_phone       := right.phone,
													     // Keep rest of data from left file
			                         self                     := left),
													   inner, 
													   limit(Batchservices.WorkPlace_Constants.Limits.JOIN_LIMIT,skip));
														 
    // 19.4 Join the most current with spoke file with the file containing DCA parent 
		//      company info matching on bdid. 
	  ds_best_cand_wparent := join(ds_best_cand_walldetail,ds_bdid_wparent,
		                               left.bdid = right.bdid,
													       transform(WorkPlace_Services.Layouts.poe_didkey_plus,
													         // Copy parent comp info from right bdid_wparent ds
 														       self.parent_company_bdid        := (string) right.parent_company_bdid,
														       self.parent_company_name        := right.parent_company_name,
																	 self.parent_company_prim_range  := right.parent_company_prim_range,
                                   self.parent_company_predir      := right.parent_company_predir,
                                   self.parent_company_prim_name   := right.parent_company_prim_name,
                                   self.parent_company_addr_suffix := right.parent_company_addr_suffix,
                                   self.parent_company_postdir     := right.parent_company_postdir,
                                   self.parent_company_unit_desig  := right.parent_company_unit_desig,
                                   self.parent_company_sec_range   := right.parent_company_sec_range,															 
                                   self.parent_company_city        := right.parent_company_city,
                                   self.parent_company_state       := right.parent_company_state,
                                   self.parent_company_zip         := right.parent_company_zip,
                                   self.parent_company_zip4        := right.parent_company_zip4,
                                   self.parent_company_phone       := right.parent_company_phone,
	 			                           // keep rest of info from left
														       self := left),
													       left outer, // keep the rec from the left ds
													       atmost(Batchservices.WorkPlace_Constants.Limits.JOIN_LIMIT));

    // 19.5 Get corp status info for the parent company.
	  //
	  // 19.5.1 Project record with a non-blank bdid onto the appropriate layout and 
	  //        then call a function to get the corp status for that bdid.
    ds_parent_bdid_corpstat := Batchservices.WorkPlace_Functions.getCorpStatus(
															   project(ds_best_cand_wparent(parent_company_bdid<>''), 
																			   transform(doxie_cbrs.layout_references,
																				  self.bdid :=(unsigned6) left.parent_company_bdid)));
  
    // 19.5.2 Join the parent co bdid with a corp status back to the ds of most current
	  //        with parent co info to attach the corp status for the parent co.
	  ds_best_cand_wpar_corpstat := join(ds_best_cand_wparent, ds_parent_bdid_corpstat,
				                                 (unsigned6) left.parent_company_bdid = right.bdid,
                                       transform(WorkPlace_Services.Layouts.poe_didkey_plus,
													               // only take status from right
 														             self.parent_company_status := right.corp_status_desc,
                                         // Rest of the fields, keep the ones from the left ds
                                         self             := left),
											                 left outer, // keep the rec from the left ds
												               atmost(Batchservices.WorkPlace_Constants.Limits.JOIN_LIMIT));
		
    // 20. Get any Professional License data.
	  //
	  // 20.1 First get all the prof lic recs (if any exist) for each did.
	  ds_prolic_data := join(ds_best_cand_wpar_corpstat,Prof_LicenseV2.Key_Proflic_Did(),
                             keyed(left.did = right.did),
	                         transform(Batchservices.WorkPlace_Layouts.prolic,
													   // take 4 fields from right ProfLic key did file, 
														 // converting 1 of them (did)
														 self.did := (string) right.did,
                             self     := right),
													 inner, // only keep rec if it matches to the right key ds
												   atmost(Batchservices.WorkPlace_Constants.Limits.JOIN_LIMIT));

    // 20.2 Then sort pl data by descending dt_last_seen (puts most current first).
    //      Then dedup by the did to identify the most current record.
    ds_prolic_deduped := dedup(sort(ds_prolic_data,-date_last_seen),did);

	  // 20.3 Finally join the ds of detail recs to the deduped pl data recs.
	  ds_best_cand_wprolic := join(ds_best_cand_wpar_corpstat,ds_prolic_deduped,
                                   left.did = (unsigned6) right.did,
	                               transform(WorkPlace_Services.Layouts.poe_didkey_plus,
															     // take 2 prof lic fields in output layout from right
                                   self.prof_license        := right.license_type,
                                   self.prof_license_status := right.status,
														       // keep the rest of the fields from the left
                                   self                     := left), 
												         left outer,  // keep all the recs from the left ds
													       atmost(Batchservices.WorkPlace_Constants.Limits.JOIN_LIMIT));

	  // 21. Project interim poe_didkey_plus layout onto the ReportService output layout.
		ds_rs_final := project(ds_best_cand_wprolic,
	                         transform(iesp.workplace.t_WPReportRecord,
													   // Main info for the reportby uniqueid (did)
														 self.SourceCode      := left.source,
		                         self.Name.Prefix     := left.name_title,
														 self.Name.First      := left.subject_first_name,
		                         self.Name.Middle     := left.middle_name, 
														 self.Name.Last       := left.subject_last_name,
		                         self.Name.Suffix     := left.name_suffix,
														 self.IsSpouse        := left.spouse_indicator,
														 self.Company.CompanyName                 := stringlib.StringToUpperCase(left.company_name),
													   self.Company.Address.StreetName          := left.company_prim_name,
													   self.Company.Address.StreetNumber        := left.company_prim_range,
													   self.Company.Address.StreetPreDirection  := left.company_predir,
													   self.Company.Address.StreetPostDirection := left.company_postdir,
													   self.Company.Address.StreetSuffix        := left.company_addr_suffix,
													   self.Company.Address.UnitDesignation     := left.company_unit_desig,
													   self.Company.Address.UnitNumber          := left.company_sec_range,
													   self.Company.Address.City  := left.company_city,
														 self.Company.Address.State := left.company_state,
														 self.Company.Address.Zip5  := left.company_zip, 
														 self.Company.Address.Zip4  := left.company_zip4,
														 self.Company.Phone1        := left.company_phone1,
														 self.Company.Phone2        := left.company_phone2,
														 self.Company.Status        := left.company_status,
														 self.Company.DateLastSeen  := iesp.ECL2ESP.toDate (left.dt_last_seen),
														 self.CompanyDescription    := left.company_description,
														 // Parent company info
													   self.ParentCompany.CompanyName := stringlib.StringToUpperCase(left.parent_company_name),
													   self.ParentCompany.Address.StreetName          := left.parent_company_prim_name,
													   self.ParentCompany.Address.StreetNumber        := left.parent_company_prim_range,
													   self.ParentCompany.Address.StreetPreDirection  := left.parent_company_predir,
													   self.ParentCompany.Address.StreetPostDirection := left.parent_company_postdir,
													   self.ParentCompany.Address.StreetSuffix        := left.parent_company_addr_suffix,
													   self.ParentCompany.Address.UnitDesignation     := left.parent_company_unit_desig,
													   self.ParentCompany.Address.UnitNumber          := left.parent_company_sec_range,
													   self.ParentCompany.Address.City  := left.parent_company_city,
														 self.ParentCompany.Address.State := left.parent_company_state,
														 self.ParentCompany.Address.Zip5  := left.parent_company_zip, 
														 self.ParentCompany.Address.Zip4  := left.parent_company_zip4,
														 self.ParentCompany.Phone1        := left.parent_company_phone,
														 self.ParentCompany.Status        := left.parent_company_status,
														 self.ProfLic                     := left.prof_license,
														 self.ProfLicStatus               := left.prof_license_status,
														 // Additional WP Company 1&2
 												     self.AdditionalWPCompany1.CompanyName := stringlib.StringToUpperCase(left.addl_wpl_comp_name_1),
														 self.AdditionalWPCompany1.Address.StreetName          := left.addl_wpl_comp_prim_name1_1,
 													   self.AdditionalWPCompany1.Address.StreetNumber        := left.addl_wpl_comp_prim_range1_1,
													   self.AdditionalWPCompany1.Address.StreetPreDirection  := left.addl_wpl_comp_predir1_1,
													   self.AdditionalWPCompany1.Address.StreetPostDirection := left.addl_wpl_comp_postdir1_1,
													   self.AdditionalWPCompany1.Address.StreetSuffix        := left.addl_wpl_comp_addr_suffix1_1,
													   self.AdditionalWPCompany1.Address.UnitDesignation     := left.addl_wpl_comp_unit_desig1_1,
													   self.AdditionalWPCompany1.Address.UnitNumber          := left.addl_wpl_comp_sec_range1_1,
                             self.AdditionalWPCompany1.Address.City  := left.addl_wpl_comp_city_1,
														 self.AdditionalWPCompany1.Address.State := left.addl_wpl_comp_state_1,
														 self.AdditionalWPCompany1.Address.Zip5  := left.addl_wpl_comp_zip_1, 
														 self.AdditionalWPCompany1.Address.Zip4  := left.addl_wpl_comp_zip4_1,
														 self.AdditionalWPCompany1.Phone1        := left.addl_wpl_phone1_1,
														 self.AdditionalWPCompany1.Status        := left.addl_wpl_status_1,
														 //
													   self.AdditionalWPCompany2.CompanyName   := stringlib.StringToUpperCase(left.addl_wpl_comp_name_2),
														 self.AdditionalWPCompany2.Address.StreetName          := left.addl_wpl_comp_prim_name1_2,
 													   self.AdditionalWPCompany2.Address.StreetNumber        := left.addl_wpl_comp_prim_range1_2,
													   self.AdditionalWPCompany2.Address.StreetPreDirection  := left.addl_wpl_comp_predir1_2,
													   self.AdditionalWPCompany2.Address.StreetPostDirection := left.addl_wpl_comp_postdir1_2,
													   self.AdditionalWPCompany2.Address.StreetSuffix        := left.addl_wpl_comp_addr_suffix1_2,
													   self.AdditionalWPCompany2.Address.UnitDesignation     := left.addl_wpl_comp_unit_desig1_2,
													   self.AdditionalWPCompany2.Address.UnitNumber          := left.addl_wpl_comp_sec_range1_2,
														 self.AdditionalWPCompany2.Address.City  := left.addl_wpl_comp_city_2,
														 self.AdditionalWPCompany2.Address.State := left.addl_wpl_comp_state_2,
														 self.AdditionalWPCompany2.Address.Zip5  := left.addl_wpl_comp_zip_2, 
														 self.AdditionalWPCompany2.Address.Zip4  := left.addl_wpl_comp_zip4_2,
														 self.AdditionalWPCompany2.Phone1        := left.addl_wpl_phone1_2,
														 self.AdditionalWPCompany2.Status        := left.addl_wpl_status_2,
                             // Optional extra Secretary of State info
														 self.WPSecretaryOfStateinfo.CompanyName     := stringlib.StringToUpperCase(left.sos_comp_name),
	                           self.WPSecretaryOfStateinfo.AsOfDate        := iesp.ECL2ESP.toDate ((integer)left.sos_name_as_of_date),
	                           self.WPSecretaryOfStateinfo.CompanyNameType := left.sos_name_type,
													   self.WPSecretaryOfStateinfo.CompanyAddress.StreetName          := left.sos_comp_prim_name,
													   self.WPSecretaryOfStateinfo.CompanyAddress.StreetNumber        := left.sos_comp_prim_range,
													   self.WPSecretaryOfStateinfo.CompanyAddress.StreetPreDirection  := left.sos_comp_predir,
													   self.WPSecretaryOfStateinfo.CompanyAddress.StreetPostDirection := left.sos_comp_postdir,
													   self.WPSecretaryOfStateinfo.CompanyAddress.StreetSuffix        := left.sos_comp_addr_suffix,
													   self.WPSecretaryOfStateinfo.CompanyAddress.UnitDesignation     := left.sos_comp_unit_desig,
													   self.WPSecretaryOfStateinfo.CompanyAddress.UnitNumber          := left.sos_comp_sec_range,
														 self.WPSecretaryOfStateinfo.CompanyAddress.City       := left.sos_comp_city,
														 self.WPSecretaryOfStateinfo.CompanyAddress.State      := left.sos_comp_state,
														 self.WPSecretaryOfStateinfo.CompanyAddress.Zip5       := left.sos_comp_zip,
														 self.WPSecretaryOfStateinfo.CompanyAddress.Zip4       := left.sos_comp_zip4,
	                           self.WPSecretaryOfStateinfo.CompanyAddressType        := left.sos_address_type,
	                           self.WPSecretaryOfStateinfo.CorporateStatus           := left.sos_status,
	                           self.WPSecretaryOfStateinfo.BusinessType              := left.sos_business_type,
	                           self.WPSecretaryOfStateinfo.Purpose                   := left.sos_purpose,
	                           self.WPSecretaryOfStateinfo.FilingDate                := iesp.ECL2ESP.toDate ((integer)left.sos_filing_date),
	                           self.WPSecretaryOfStateinfo.ForeignIncorporationDate  := iesp.ECL2ESP.toDate ((integer)left.sos_for_incorp_date),
	                           self.WPSecretaryOfStateinfo.Term                      := left.sos_term,
	                           self.WPSecretaryOfStateinfo.InGoodStanding            := left.sos_igs,
	                           self.WPSecretaryOfStateinfo.RegisteredAgent           := stringlib.StringToUpperCase(left.sos_reg_agent_name),
													   self.WPSecretaryOfStateinfo.RegisteredAgentAddress.StreetName          := left.sos_reg_agent_prim_name,
													   self.WPSecretaryOfStateinfo.RegisteredAgentAddress.StreetNumber        := left.sos_reg_agent_prim_range,
													   self.WPSecretaryOfStateinfo.RegisteredAgentAddress.StreetPreDirection  := left.sos_reg_agent_predir,
													   self.WPSecretaryOfStateinfo.RegisteredAgentAddress.StreetPostDirection := left.sos_reg_agent_postdir,
													   self.WPSecretaryOfStateinfo.RegisteredAgentAddress.StreetSuffix        := left.sos_reg_agent_addr_suffix,
													   self.WPSecretaryOfStateinfo.RegisteredAgentAddress.UnitDesignation     := left.sos_reg_agent_unit_desig,
													   self.WPSecretaryOfStateinfo.RegisteredAgentAddress.UnitNumber          := left.sos_reg_agent_sec_range,
														 self.WPSecretaryOfStateinfo.RegisteredAgentAddress.City  := left.sos_reg_agent_city,
														 self.WPSecretaryOfStateinfo.RegisteredAgentAddress.State := left.sos_reg_agent_state,
														 self.WPSecretaryOfStateinfo.RegisteredAgentAddress.Zip5  := left.sos_reg_agent_zip,
														 self.WPSecretaryOfStateinfo.RegisteredAgentAddress.Zip4  := left.sos_reg_agent_zip4,
	                           self.WPSecretaryOfStateinfo.PlaceIncorporation           := left.sos_place_incorp,
	                           self.WPSecretaryOfStateinfo.FEIN                         := (string) left.company_fein,
														 self := [] // set all other fields not assigned above to null
                           ));

	  // Uncomment lines below as needed for debugging
    //OUTPUT(in_did_int,                 NAMED('in_did_int'));
	  //OUTPUT(IncludeSosInfo,             NAMED('IncludeSosInfo'));
	  //OUTPUT(IsSpouse,                   NAMED('IncludeSpouse'));
    //OUTPUT(in_spouse_indicator,        NAMED('in_spouse_indicator'));
 	  //OUTPUT(in_excluded_sources,        NAMED('in_excluded_sources'));
 	  //OUTPUT(in_excluded_sources_edited, NAMED('in_excluded_sources_edited'));
    //OUTPUT(ds_excluded_sources,        NAMED('ds_excluded_sources'));
	  //OUTPUT(ds_did_in,                  NAMED('ds_did_in'));
    //OUTPUT(ds_poe_recs_slimmed,        NAMED('ds_poe_recs_slimmed'));
    //OUTPUT(dPSSRecsSlimmed,        		 NAMED('dPSSRecsSlimmed'));
    //OUTPUT(ds_clarity_recs_slimmed,    NAMED('ds_clarity_recs_slimmed'));
    // OUTPUT(ds_all_recs_not_restricted, NAMED('ds_all_recs_not_restricted'));
    // OUTPUT(ds_all_recs_glb_ok, NAMED('ds_all_recs_glb_ok'));
    //OUTPUT(ds_all_recs_included,       NAMED('ds_all_recs_included'));
    //OUTPUT(ds_dids_pulled,             NAMED('ds_dids_pulled'));
    //OUTPUT(ds_ssns_pulled,             NAMED('ds_ssns_pulled'));
    //OUTPUT(ds_all_recs_pulled,         NAMED('ds_all_recs_pulled'));
    //OUTPUT(ds_all_recs_pulled,         NAMED('ds_all_recs_pulled'));
    //OUTPUT(ds_all_recs_bhbest_added,   NAMED('ds_all_recs_bhbest_added'));
	  //OUTPUT(ds_all_recs_phones_cleaned, NAMED('ds_all_recs_phones_cleaned'));
    //OUTPUT(ds_all_recs_cname_cleaned,  NAMED('ds_all_recs_cname_cleaned'));
	  //OUTPUT(ds_all_recs_gongcomp,       NAMED('ds_all_recs_gongcomp'));
	  //OUTPUT(ds_all_recs_gongphone,      NAMED('ds_all_recs_gongphone'));
    //OUTPUT(ds_all_recs_ypphone,        NAMED('ds_all_recs_ypphone'));
    //OUTPUT(dSuppressBadPhone1,         NAMED('dSuppressBadPhone1'));
    //OUTPUT(dSuppressBadPhone2,         NAMED('dSuppressBadPhone2'));
    //OUTPUT(dSuppressBadPhones,         NAMED('dSuppressBadPhones'));
	  //OUTPUT(ds_most_complete_all,       NAMED('ds_most_complete_all'));
	  //OUTPUT(ds_most_complete_srtd,      NAMED('ds_most_complete_srtd'));
	  //OUTPUT(ds_most_current1,           NAMED('ds_most_current1'));
	  //OUTPUT(ds_best_recs_for_did,       NAMED('ds_best_recs_for_did'));
	  //OUTPUT(ds_best_candidate,          NAMED('ds_best_candidate'));
    //OUTPUT(ds_best_cand_bdid_corpstat, NAMED('ds_best_cand_bdid_corpstat'));
	  //OUTPUT(ds_best_cand_wcorpstat,     NAMED('ds_best_cand_wcorpstat'));
    //OUTPUT(ds_most_complete_fltrd,     NAMED('ds_most_complete_filtrd'));
    //OUTPUT(ds_most_complete_unique_compname, NAMED('ds_most_complete_unqiue_compname'));
    //OUTPUT(ds_most_complete_unique_bdid,     NAMED('ds_most_complete_unqiue_bdid'));
    //OUTPUT(ds_most_complete_addl,      NAMED('ds_most_complete_addl'));
    //OUTPUT(ds_addl_2recs,              NAMED('ds_addl_2recs'));
    //OUTPUT(ds_addl_2recs_bdids_corpstat, NAMED('ds_addl_2recs_bdids_corpstat'));
	  //OUTPUT(ds_addl_2recs_wcorpstat,    NAMED('ds_addl_2recs_wcorpstat'));
	  //OUTPUT(ds_addl_combined,           NAMED('ds_addl_combined'));
	  //OUTPUT(ds_best_cand_waddl,         NAMED('ds_best_cand_waddl'));
    //OUTPUT(ds_best_cand_wspoke,        NAMED('ds_best_cand_wspoke'));
    //OUTPUT(ds_best_cand_walldetail,    NAMED('ds_best_cand_walldetail'));
    //OUTPUT(ds_bdid_dca_added,          NAMED('ds_bdid_dca_added'));
    //OUTPUT(ds_bdid_parents,            NAMED('ds_bdid_parents'));
    //OUTPUT(ds_bdid_wparent,            NAMED('ds_bdid_wparent'));
    //OUTPUT(ds_best_cand_wparent,       NAMED('ds_best_cand_wparent'));
    //OUTPUT(ds_parent_bdid_corpstat,    NAMED('ds_parent_bdid_corpstat'));
	  //OUTPUT(ds_best_cand_wpar_corpstat, NAMED('ds_best_cand_wpar_corpstat'));
    //OUTPUT(ds_prolic_data,             NAMED('ds_prolic_data'));
    //OUTPUT(ds_prolic_deduped,          NAMED('ds_prolic_deduped'));
    //OUTPUT(ds_best_cand_wprolic,       NAMED('ds_best_cand_wprolic'));
	  //OUTPUT(ds_rs_final,                NAMED('ds_ss_final'));

    //return ds_all_recs_included;
    return ds_rs_final;
		
  end;  // end of val function

end; // end of ReportService_Records module
