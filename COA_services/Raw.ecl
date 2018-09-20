import doxie,doxie_cbrs,Doxie_Raw,COA_services, iesp, 
      AutoStandardI, header_quick, utilfile, ut, census_data, Address, header, suppress, Relationship;

export Raw := module
export params := interface(AutoStandardI.InterfaceTranslator.application_type_val.params)
	
	    export string120 unparsedfullname := '';
		  export string30 firstname := '';
			export string30 middlename := '';
			export string30 lastname := '';
			export string10 prim_range := '';
			export string28 prim_name := '';
			export string25 city := '';
			export string2 state := '';
			export string6 zip := '';
			export string2 predir := '';
		  export string2 postdir := '';
			export string4 suffix := '';
			export string8 sec_range := '';
			export string200 addr := '';
			export unsigned1 dppaPurpose;
		  export unsigned1 glbPurpose;					
			export boolean AllowAll;
			export boolean AllowGLB;
			export boolean AllowDPPA;
			export boolean includeMinors;
			export boolean probationoverride;
			export string5 industryclass;
			export boolean raw;
			export boolean donotfillblanks;
			
	end;

		  export header_quick.layout_records byDids(Dataset (doxie.layout_references) in_dids, unsigned1 dppaPurpose,
		                                                          unsigned1 glbpurpose)  := function
		
				// get quick header records.
				new_did_set := project(in_dids, 
							transform(doxie.layout_references_hh, 
							        self.did := left.did, 
											self.includedByHHID := false));
											
				raw_recs := doxie_raw.QuickHeader_raw(new_did_set,0,dppaPurpose,glbpurpose,'NONE',false,false,'',TRUE);				
												
				return (raw_recs);
				
	   	end;
			
    	export  COA_services.Layouts.rawrec getMasterRec(Dataset (header.layout_header) in_recs, params in_mod, 
																												Address.ICleanAddress clean_addr) := function
				mod_access := MODULE (doxie.functions.GetGlobalDataAccessModuleTranslated (AutoStandardI.GlobalModule ()))
					EXPORT unsigned1 glb := in_mod.glbPurpose;
					EXPORT unsigned1 dppa := in_mod.dppapurpose;
					EXPORT string DataPermissionMask := in_mod.DataPermissionMask;
					EXPORT boolean probation_override := in_mod.probationoverride;
					EXPORT string5 industry_class := in_mod.industryclass;
					EXPORT string32 application_type := in_mod.ApplicationType;
				END;

				glb_ok := mod_access.isValidGLB ();
				dppa_ok := mod_access.isValidDPPA ();

								// determine if unparsedfullname field was filled out or not and populate correct fields.
				
			  fullName := Address.CleanNameFields(Address.CleanPerson73(in_mod.unparsedFullName));
		
				unparsedFullNameNotFilled := if (trim(in_mod.unparsedFullName, left,right) = '', true, false);
	
				trim_firstname := if (unparsedFullNameNotFilled, StringLib.StringToUpperCase(trim(in_mod.firstname,left,right)), 
		                                              StringLib.StringToUpperCase(trim(fullName.fname, left, right)));
				trim_lastname := if (unparsedFullNameNotFilled, StringLib.StringToUpperCase(trim(in_mod.lastname,left,right)),
		                                              StringLib.StringToUpperCase(trim(fullName.lname, left, right)));
		                                 
		    in_dids_slim := project(in_recs, 
					  transform (doxie.layout_references, 
						self.did := left.did));
						
				// take dids from header match and do quick header look with them.		
				quick_recs := byDids(in_dids_slim, mod_access.dppa, mod_access.glb);
				
				//project to layout header to be cleaned.
				quick_recs_header_format := project(quick_recs, transform(header.Layout_header,
				                     self := left));
														 
				
				in_recs_header_format_cleaned_sorted := sort(in_recs(ssn != ''), -dt_last_seen);
				
				inputDATELASTSEEN := in_recs_header_format_cleaned_sorted[1].dt_last_seen;
				inputDATEFIRSTSEEN := in_recs_header_format_cleaned_sorted[1].dt_first_seen;
														          														
				// clean quick header recs.
				
				header.MAC_GlbClean_Header(quick_recs_header_format,quick_recs_header_format_cleaned, , , mod_access);
				
				// put cleaned quick headers into a common layout.
				quick_recs_header_layout := project(quick_recs_header_format_cleaned, header.layout_header);
												
        // add header recs and quick headers together.												 
				header_and_quick_recs_cleaned_plus := project (in_recs + quick_recs_header_layout, 
									transform(COA_services.layouts.rawrec,
									            self.latestDate := if (left.dt_last_seen > left.dt_first_seen, left.dt_last_seen,
																				                       left.dt_first_seen),
															self := left
															));
				 							 
				// grab the latestDate record from this combo cause a very high % of time (90% or more)
				// this is the rec with latest date and normally the return value in this function
											
        raw_recs_deep_keep1_cleaned := choosen(sort(header_and_quick_recs_cleaned_plus, -latestDate), 1);							

				useAddr1 := (in_mod.prim_range = '') AND (in_mod.prim_name = '') AND (in_mod.suffix = '');
							
			  in_prim_range := if (useAddr1, clean_addr.prim_range, in_mod.prim_range);
				in_prim_name := if (useAddr1, clean_addr.prim_name, in_mod.prim_name);
				in_suffix := if (useAddr1, clean_addr.suffix, in_mod.suffix);
																	
        // filter the records returned from header records lookup and
			  // keep just ones which match input criteria
					
        raw_recs_deep_matched_cleaned := header_and_quick_recs_cleaned_plus(lname = trim_lastname, 
											        prim_range = stringlib.StringToUpperCase(in_prim_range),
											        prim_name = stringlib.StringToUpperCase(in_prim_name),
				                      city_name = stringlib.StringToUpperCase(in_mod.city), 
															st = stringlib.StringToUpperCase(in_mod.state), 
															zip = stringlib.StringToUpperCase(in_mod.zip),
															suffix = stringlib.StringToUpperCase(in_suffix)
															);
        																																										
        // combine all the COA records found so far.  
				// 1.  Those matched against deep dive and matched against input criteria
				// 2.  Those pulled from deep dive and having the most recent dt_last_seen 
				//     Note:  this rec (raw_recs_deep_keep1_cleaned) combo of header recs and quick headers
				// is usually the correct end result rec to be returned at end of COA service.
																																																														        	
				// match on input criteria.
				raw_recs_deep_matched_COMBINED_INPUT_MATCH := 
				                raw_recs_deep_matched_cleaned(lname = trim_lastname, 
											        prim_range = stringlib.StringToUpperCase(in_prim_range),
											        prim_name = stringlib.StringToUpperCase(in_prim_name),
				                      city_name = stringlib.StringToUpperCase(in_mod.city), 
															st = stringlib.StringToUpperCase(in_mod.state), 
															zip = stringlib.StringToUpperCase(in_mod.zip),
															suffix = stringlib.StringToUpperCase(in_suffix)
															);
        // sort on dateLastSeen within raw_recs_deep_matched_Combined_input_match															
				// snag dateFirstSeen/DateLastSeen for output in final result.
																			
        raw_recs_deep_matched2 :=  project(raw_recs_deep_matched_cleaned +  raw_recs_deep_keep1_cleaned,
																			transform(COA_services.layouts.rawrec,
																				self.lastSeenDate := left.dt_last_seen,
																				self.firstSeenDate := left.dt_first_seen,
																				self.latestDate := left.latestDate,																		
																				self := left));

        score_raw_recs_deep_matched2 := sort(raw_recs_deep_matched2, -latestDate);																				
					 
				//
				// use either matches from header recs call or more probably use the latest attribute set.				
				//
        raw_recs_deep_matched3 := if (count(raw_recs_deep_matched_cleaned) = 0, 
				                      sort(header_and_quick_recs_cleaned_plus, -latestDate),
				                          score_raw_recs_deep_matched2);
														 										 
        raw_recs_deep_matched3_latest_date := raw_recs_deep_matched3[1].latestDate;														 
				 
				raw_recs_deep_matched4 := if (raw_recs_deep_matched3_latest_date != 0, 
												raw_recs_deep_matched3(latestDate = raw_recs_deep_matched3_latest_date),
												raw_recs_deep_matched3);
				 
			  raw_recs_master_deep := project(raw_recs_deep_matched4, 
				     transform(COA_services.Layouts.rawrec,
						   self.penalt := 0,
							 self.isDeepDive := false,							
							 self.lastSeenDate := 0,
							 self.firstSeenDate := 0,
							 self.latestDate := if (left.dt_last_seen > left.dt_first_seen, left.dt_last_seen,
																				                       left.dt_first_seen),              										
							 self.inputFirstSeenDate := inputDATEFIRSTSEEN,
							 self.inputLastSeenDate := inputDATELASTSEEN,
							 self := left
							));		
							       											
			  raw_recs_sorted := sort(raw_recs_master_deep,-latestDate);

				Suppress.MAC_Suppress(raw_recs_sorted,pull_tmp,mod_access.application_type,Suppress.Constants.LinkTypes.DID,DID);
				Suppress.MAC_Suppress(pull_tmp,recs_ssn_pulled,mod_access.application_type,Suppress.Constants.LinkTypes.SSN,ssn);
			
				raw_recs_sorted2 := sort(recs_ssn_pulled,-latestDate);
													
			  coa_master := choosen(raw_recs_sorted2, 1);
       
			  // DEBUG
			  // output(in_recs,named('raw_in_recs'));
				// output(inputDataInfo,named('raw_inputDataInfo'));
			  // output(quick_recs_header_layout,named('quick_recs_header_layout'));
			  // output(quick_recs_header_format_cleaned,named('RAW_quick_recs_header_format_cleaned'));
			   //output(raw_recs_deep_matched_cleaned,named('Raw_raw_recs_deep_matched_cleaned'));
				
			  
			  // output(raw_recs_deep_matched_COMBINED_INPUT_MATCH,
						// named('raw_recs_deep_matched_COMBINED_INPUT_MATCH'));
					
			 
			  // output(raw_recs_deep_matched2,named('Raw_raw_recs_deep_matched2'));
			  
			  // output(raw_recs_deep_matched4,named('Raw_raw_recs_deep_matched4'));
			 
			  // output(raw_recs_master_deep,named('raw_recs_master_deep'));
				 // output(header_and_quick_recs_cleaned_plus, named('header_and_quick_recs_cleaned_plus'));
				 // output(raw_recs_deep_matched3,named('Raw_raw_recs_deep_matched3'));
				// output(raw_recs_sorted2, named('raw_recs_sorted2'));
			   // output(coa_master, named('coa_master'));
				
				// output(in_recs, named('in_recs'));
				// output(quick_recs_header_layout, named('quick_recs_header_layout'));
				// output(inputDataInfo, named('inputDataInfo'));
				// output(in_recs_header_format_cleaned_sorted, named('in_recs_header_format_cleaned_sorted'));
				// output(inputDATEFIRSTSEEN, named('inputDATEFIRSTSEEN'));
				// output(inputDATELASTSEEN, named('inputDATELASTSEEN'));
				
				
		return(coa_master);
		 
		end;
		
		export  getLeadRecs(Dataset (COA_services.Layouts.rawrec) in_recs2, params in_mod, 
												Address.ICleanAddress clean_addr) := function
				
					fullName := Address.CleanNameFields(Address.CleanPerson73(in_mod.unparsedFullName));	
					unparsedFullNameNotFilled := if (trim(in_mod.unparsedFullName, left,right) = '', true, false);	
					trim_firstname := if (unparsedFullNameNotFilled, StringLib.StringToUpperCase(trim(in_mod.firstname,left,right)), 
		                                              StringLib.StringToUpperCase(trim(fullName.fname, left, right)));
					trim_lastname := if (unparsedFullNameNotFilled, StringLib.StringToUpperCase(trim(in_mod.lastname,left,right)),
		                                              StringLib.StringToUpperCase(trim(fullName.lname, left, right)));

				useAddr1 := (in_mod.prim_range = '') AND (in_mod.prim_name = '') AND (in_mod.suffix = '');
							                     
			  in_prim_range := if (useAddr1, clean_addr.prim_range, in_mod.prim_range);
				in_prim_name := if (useAddr1, clean_addr.prim_name, stringlib.StringToUpperCase(in_mod.prim_name));
				

        // NB: in_mod has mostly untranslated values (industryclass, for instance); this can cause complience issues
				mod_access := MODULE (doxie.functions.GetGlobalDataAccessModuleTranslated (AutoStandardI.GlobalModule ()))
					EXPORT unsigned1 glb := in_mod.glbPurpose;
					EXPORT unsigned1 dppa := in_mod.dppapurpose;
					EXPORT string DataPermissionMask := in_mod.DataPermissionMask;
					EXPORT boolean probation_override := in_mod.probationoverride;
					EXPORT string5 industry_class := in_mod.industryclass;
					EXPORT string32 application_type := in_mod.ApplicationType;
				END;

				glb_ok := mod_access.isValidGLB ();
				dppa_ok := mod_access.isValidDPPA ();

        // get did from master COA rec				
		    doxie_ref_did_set2  := project(in_recs2, 
						 transform(doxie.layout_references, 
							         self.did := (unsigned6) left.did));
																					
        // join this will utility file.        
		    util_recs := JOIN(doxie_ref_did_set2,utilfile.key_util_daily_did,
						    keyed(LEFT.did=RIGHT.s_did),
								transform(doxie.layout_references,
								self.did := (unsigned6) right.did),
								limit(coa_services.constants.max_recs_on_coa_util_join,skip));
								
        // sort/dedup out dups.								
		    util_final := dedup(sort(util_recs,did),did);     								 
				
				// Use relationship proc to retrieve relative dids.
				rdid_ds := project(in_recs2,transform(Relationship.Layout_GetRelationship.DIDs_layout,SELF:=LEFT,SELF := []));
				
				raw_recs_relative_match := project(Relationship.proc_GetRelationship(rdid_ds,TRUE,TRUE,,,coa_services.constants.max_recs_on_coa_relative_join,,TRUE).result,
																		transform (doxie.layout_references,self.did := left.did2));												  					
								
				dids_together  := raw_recs_relative_match +	util_final;		
			  coa_dids_final := dedup(sort(dids_together,did),did); 
			
        header_recs_coa := join (coa_dids_final, doxie.key_header, 
									keyed (left.did = right.s_did),
									transform(header.Layout_Header,						
									self := right)							
									, limit(coa_services.constants.max_recs_on_coa_util_join, skip)
									);

        header.MAC_GlbClean_Header(header_recs_coa, header_recs_coa_cleaned_pre, , , mod_access);				

				header_recs_coa_slim_latestDate := max (header_recs_coa_cleaned_pre, 
						if (dt_last_seen > dt_first_seen, dt_last_seen, dt_first_seen));
										
			  header_recs_coa_cleaned :=  header_recs_coa_cleaned_pre(
																											(dt_last_seen = header_recs_coa_slim_latestDate) or 																										
																											(dt_first_seen = header_recs_coa_slim_latestDate) 																										
																										 );
			 
			  // use either prim_name/prim_range or use parsed address pieces determined above
				// thus in_prim_range and in_prim_name used instead.
			  header_recs_coa_slim := join(header_recs_coa_cleaned, doxie.key_header_address,
			                        keyed(in_prim_name = right.prim_name) AND
			                        keyed(in_mod.zip = right.zip) AND
			                        keyed(in_prim_range = right.prim_range),
															      
															transform(COA_services.Layouts.rawRec,
															self.latestDate := if (left.dt_last_seen > left.dt_first_seen, left.dt_last_seen,
																				                       left.dt_first_seen), // not used anymore, actually
															self.inputFirstSeenDate := right.dt_first_seen,
															self.inputLastSeenDate := right.dt_last_seen,
															self := left), limit(coa_services.constants.max_recs_on_coa_header_join, skip));
			
			
			  header_recs_coa_slim_not_last_name := 
			                  header_recs_coa_slim(lname != trim_lastname);
			
			  header_recs_coa_slim_extra := header_recs_coa_slim(
			                           lname = trim_lastname AND
			                           fname != trim_firstname);
																	
        header_recs_coa_slim_final := header_recs_coa_slim_not_last_name + header_recs_coa_slim_extra;
						
        // this removes duplicates of people who have the same address																												
			  coa_lead_temp := dedup(sort(header_recs_coa_slim_final, st, city_name, zip, fname), st, city_name, zip,fname);
					
		    //fname mname lname name suffix prim range predir prim name suffix postdir unit desig sec range city name st zip zip4 
		 												
		    coa_result_temp := sort(coa_lead_temp, -dt_first_seen);
		 		 
			
		  ///////////////// DEBUG

			// output(relResultMac,named('relResultMac'));
		  // output(raw_recs_relative_match, named('RAW_raw_recs_relative_match'));
			// output(util_final,named('util_final'));
			// output(header_recs_coa, named('RAW_header_recs_coa'));
			// output(header_recs_coa_cleaned,named('RAW_header_recs_coa_cleaned'));
			// output(header_recs_coa_cleaned_plus,named('RAW_header_recs_coa_cleaned_plus'));
			// output(header_recs_coa_slim_tmp,named('raw_header_recs_coa_slim_tmp'));
						
			// output(header_recs_coa_slim, named('RAW_header_recs_coa_slim'));
			// output(header_recs_coa_slim_extra,named('RAW_header_recs_coa_slim_extra'));
			// output(header_recs_coa_slim_not_last_name,named('RAW_header_recs_coa_slim_not_last_name'));
			// output(header_recs_coa_slim_final,named('header_recs_coa_slim_final'));
			// output(coa_lead_temp,named('coa_lead_temp'));	
			// output(coa_result_temp,named('coa_result_temp'));

		
	return(coa_result_temp);
	
  end;
end;
