import didville, ut, AutoStandardI, AutoHeaderI, address, doxie, AutoheaderV2;

export ClickData_Enhanced_Search(dataset(didville.layout_did_outbatch) df2,
																		dataset(didville.layout_did_outbatch) hits,
																		zip_radius = 0)
																:= function
		
		global_module := AutoStandardI.GlobalModule();
		/*------Get no hits------*/
		d_nohits := join(hits, df2, left.did = right.did //Only the records with no match from Mac_DidAppend will match with a 0 did from input record
																	and left.lname = right.lname 
																	and left.fname = right.fname
																	and left.seq = right.seq);  
			
		/*-----Go get dids for no hits with address----*/
		rec_did := record
			dataset(doxie.layout_references) DIDs;
			unsigned4 seq;
		end;
		
		rec_did getDIDTransform(recordof(d_nohits) L) := transform
			// search header by zip
			tempdmod := MODULE(project(global_module,AutoHeaderI.LIBIN.FetchI_Hdr_Indv.full,opt))
					EXPORT city               := L.p_city_name;
					EXPORT state              := L.st;
					EXPORT zip								:= L.z5;
					EXPORT useGlobalScope     := TRUE;
					EXPORT BOOLEAN noFail     := true;
					EXPORT mileradius 				:= zip_radius;
					EXPORT zipradius 					:= zip_radius;	
					EXPORT firstname					:= L.fname;
					EXPORT middlename					:= L.mname;
					EXPORT lastname						:= L.lname;
					export dob								:= 0;
					export AllowFuzzyDOBMatch	:= true;
				  // I can blank some specific fields here to ease up a cleaning a little, if needed.
			END;
			ds_search := AutoheaderV2.LIBCALL_conversions.GetPreprocessedInputDataset (tempdmod);
			ds_slim_search := project (ds_search, AutoheaderV2.layouts.lib_search);
			// full cleaning
			ds_search_clean := AutoheaderV2.LIBCALL_conversions.CleanSearchInputDataset (ds_slim_search);
			dids_found := AutoHeaderV2.fetch_zip (ds_search_clean); // by default allowed to fail

			self.seq := L.seq;
			self.dids := limit(dataset(set(dids_found, did), doxie.layout_references), 1000, skip);
		end;
		nohits_did := project(d_nohits, getDIDTransform(left));
		
		rec_did_dataset := record
			unsigned4 seq;
			unsigned8 did;
		end;
		
		rec_did_dataset NormIt(rec_did L, integer C) := transform
			did_set := set(L.dids, did);
			self.did := did_set[C];
			self.seq := L.seq;
		end;
		nohits_did2 := dedup(sort(normalize(nohits_did, left.dids, NormIt(left, counter)), seq, did), record);
		nohits_did_dataset := project(nohits_did2, transform(recordof(hits), 
																											self := left, 
																											self := []));
		
		/*----Fetch Watchdog to get records corresponding to DIDs----*/
		
		dppa_ok := ut.permissionTools.dppa.ok(global_module.DPPAPurpose);
		glb_ok := ut.permissionTools.glb.ok(global_module.GLBPurpose);

		doxie.mac_best_records(nohits_did_dataset,
													 did,
													 outfile,
													 dppa_ok,
													 glb_ok, 
													 ,
													 doxie.DataRestriction.fixed_DRM);

		hits getBest(nohits_did_dataset Le, outfile Ri):= transform
			self.best_addr_Date 			:= Ri.addr_dt_last_seen;
			self.best_fname						:= ri.fname;
			self.best_mname						:= ri.mname;
			self.best_lname						:= ri.lname;
			self.best_name_suffix			:= ri.name_suffix;
			self.best_addr1						:= address.Addr1FromComponents(Ri.prim_range, Ri.predir, Ri.prim_name, Ri.suffix, Ri.postdir, Ri.unit_desig, Ri.sec_range);
			self.best_city						:= Ri.city_name;
			self.best_state						:= Ri.st;
			self.best_zip							:= Ri.zip;
			self.best_zip4						:= Ri.zip4;
			self.ssn 									:= ri.ssn;
			self.dob 									:= (qstring8)ri.dob;
			self 											:= Le;
			self 											:= ri;
		end;
													 
		nohits_recs := join(nohits_did_dataset, outfile,
												left.did = right.did,
										getBest(left, right), limit(0), keep(1));
										
		/*------Filter records that do not match on last name and first name with editDistance of 2 
																														and DOB plus or minus 2 from the year----*/																																																				
		nohits_recs_final := join(nohits_recs, d_nohits, left.seq = right.seq AND
																								left.best_lname = right.lname and
																							(stringlib.editDistance(left.best_fname, right.fname) <= 2) and
																							if(right.dob <> '',
																							((unsigned)left.dob[1..4] between ((unsigned)(right.dob[1..4]) - 2) and 
																																								((unsigned)(right.dob[1..4]) + 2)),
																							true),
																							transform(recordof(nohits_recs), 
																																	self := left));
		/*----Combine nohits_recs with hits----*/
		
				
		//Calculate age high and age low
		currentAge(string dob) := ut.GetAge(dob);
		getAgeHigh(string dob) := currentAge(dob) + 2;
		getAgeLow(string dob)  := currentAge(dob) - 2;
		
		// Function to calculate the penalty on the no hits records based on name and address. 
		// If multiple hits on one no hits record, Lowest penalty score is kept
			penalt_func_calculate(hits l, nohits_recs_final r)  := FUNCTION
			
					tempindvMod := MODULE(PROJECT(global_module, 
																AutoStandardI.LIBIN.PenaltyI_Indv_Name.full, opt))																
										
								// input individual name
								EXPORT lastname       := l.lname;        // the 'input' last name
								EXPORT middlename     := l.mname;       // the 'input' middle name
								EXPORT firstname      := l.fname;      // the 'input' first name
								EXPORT allow_wildcard := FALSE;
								
								//matching rec
								EXPORT lname_field    := r.best_lname;   // the last name in the matching record				                          
								EXPORT mname_field    := r.best_mname;  // the middle name in the matching record
								EXPORT fname_field    := r.best_fname; // the first name in the matching record
																							
						end;
					
					tempDobMod := MODULE(PROJECT(global_module, 
																	AutoStandardI.LIBIN.PenaltyI_DOB.full, opt))
								//input DOB
								EXPORT dob                := (unsigned8)L.dob;
								export ageHigh						:= if(L.dob <> '', getAgeHigh(L.dob), 0);
								export ageLow							:= if(L.dob <> '', getAgeLow(L.dob), 0);
								//matching rec
								export dob_field					:= r.dob;
								export ageHigh_field			:= if(L.dob <> '', getAgeHigh(L.dob), 0);
								export ageLow_field				:= if(L.dob <> '', getAgeLow(L.dob), 0);
					end;
					
					tempAddrMod := MODULE(PROJECT(global_module, 
																 AutoStandardI.LIBIN.PenaltyI_Addr.full, opt))
					//	The 'input' address:
										EXPORT predir         := l.predir;
										EXPORT prim_name      := l.prim_name;
										EXPORT prim_range     := l.prim_range;
										EXPORT postdir        := l.postdir;
										EXPORT addr_suffix    := l.addr_suffix;
										EXPORT sec_range      := l.sec_range;
										EXPORT p_city_name    := l.p_city_name;
										EXPORT st             := l.st;
										EXPORT z5             := l.z5;
						
						//	The address in the matching record:							
										EXPORT allow_wildcard := FALSE;
										EXPORT city_field     := r.p_city_name;
										EXPORT city2_field    := '';
										EXPORT pname_field    := r.prim_name;
										EXPORT postdir_field  := r.postdir;
										EXPORT prange_field   := r.prim_range;
										EXPORT predir_field   := r.predir;
										EXPORT state_field    := r.st;
										EXPORT suffix_field   := r.addr_suffix;
										EXPORT zip_field      := r.z5;								
										EXPORT useGlobalScope := FALSE;
											
										EXPORT mileradius 		:= zip_radius;
										EXPORT zipradius 			:= zip_radius;
							END;				
										
						 return  AutoStandardI.LIBCALL_PenaltyI_Indv_Name.val(tempIndvMod) +
										 AutoStandardI.LIBCALL_PenaltyI_Addr.val(tempAddrMod)+
										 ROUND(AutoStandardI.LIBCALL_PenaltyI_DOB.val(tempDobMod)/2);
														 
							 // represents just one row penalty.
		END;
		
		hits_extended_r := record
			unsigned2 pen_nohits;
			recordof(hits);
		end;
		
		hits_extended_r combineHitsAndNoHits(hits L, nohits_recs_final R) := transform
					penalty_score 							:= penalt_func_calculate(L,R);
					self.fname 									:= L.fname;
					self.lname 			  					:= L.lname;
					self.mname 			 						:= L.mname;
					self.did 	 			 						:= if(L.did <> 0, L.did, if(R.did <> 0 and penalty_score <= 10, R.did, L.did));
					self.dob   			 						:= L.dob;
					self.p_city_name 						:= L.p_city_name;
					self.z5 		      					:= L.z5;
					self.st 		      					:= L.st;
					self.best_fname   					:= '';
					self.best_mname   					:= '';
					self.best_lname   					:= '';
					self.best_addr1  						:= '';
					self.best_city 	  					:= '';
					self.best_zip 	 					 	:= '';
					self.best_zip4 							:= '';
					self.ssn 										:= '';
					self.pen_nohits							:= if(L.did <> 0, 0, penalty_score);
					self.score_any_addr		 			:= if(L.did <> 0, L.score_any_addr, 
																								if(L.z5 <> '' or (L.p_city_name <> '' and L.st <> ''), 85, 0));
					localscore									:= 100 - (self.pen_nohits * 10);
					self.score									:= if(L.score <> 0, L.score, localscore);
					self 			 									:= L;
		end;
		
		outf0_combineda := join(hits, nohits_recs_final, left.seq = right.seq 
																									and left.lname = right.best_lname,
																									combineHitsAndNoHits(left, right),
																									left outer);
		//sort based on penalty score and dedup LEFT to keep lowest penalty score record.
		outf0_combinedb := dedup(sort(outf0_combineda, seq, pen_nohits), seq, LEFT);		
		//project back into hits layout
		outf0_combined := project(outf0_combinedb, recordof(hits));
		
		//FOR DEBUG:
		// output(nohits_recs, named('nohits_recs'));
		// output(nohits_recs_final, named('nohits_recs_final'));
		// output(outf0_combineda, named('outf0_combineda'));
		// output(outf0_combinedb, named('outf0_combinedb'));

		return outf0_combined;
		
	end;