import CourtLink, BatchServices, Autokey_batch, AutokeyB2,ut, autostandardI, suppress;

    fn_apply_penalty(Autokey_batch.Layouts.rec_inBatchMaster l,                                     
										 BatchServices.Layouts.PLD.rec_results_raw r)  := FUNCTION  
		     persons_1 := 
					MODULE(PROJECT(AutoStandardI.GlobalModule(), AutoStandardI.LIBIN.PenaltyI_Indv_Name.full, opt))
					    EXPORT lastname       := l.name_last;       // the 'input' last name
							EXPORT middlename     := l.name_middle;     // the 'input' middle name
							EXPORT firstname      := l.name_first;      // the 'input' first name
	            // matching record
							EXPORT allow_wildcard := FALSE;
							EXPORT lname_field    := r.debtor_lname; // matching record.						                           
							EXPORT mname_field    := r.debtor_mname;
							EXPORT fname_field    := r.debtor_fname;
							EXPORT useGlobalScope := FALSE;											
					 end;				
					person_penalt := AutoStandardI.LIBCALL_PenaltyI_Indv_Name.val(persons_1);
					
		return person_penalt;			

end;		

BatchServices.Layouts.PLD.rec_batch_PLD_input file_inPLDBatchMaster(BOOLEAN forceSeq = FALSE) := function 
		//
		// generic layout with Possible Litigious debtor information added
		// see BatchServices.Layouts.PLD.rec_batch_pld_input
		//
		rec := BatchServices.Layouts.PLD.rec_batch_PLD_input;

		raw1 := DATASET([], rec) : STORED('batch_in', FEW);
		raw0 := raw1 : GLOBAL;

		rec tra(rec l) := TRANSFORM
			SELF.max_results := if( (UNSIGNED8) l.max_results > 0, l.max_results, (string4) BatchServices.Constants.PLD.SEQ_MAX_LIMIT);
			SELF := l;
		end;

		raw := PROJECT(raw0, tra(LEFT));

		ut.MAC_Sequence_Records(raw, seq, raw_seq)

		PLD_file := IF(NOT forceSeq AND EXISTS(raw(seq > 0)), raw, raw_seq);				
		
		return PLD_file;
	
end;		

EXPORT PossibleLitigiousDebtor_BatchService_Records(BOOLEAN useCannedRecs = FALSE) := FUNCTION
		
		// 1. Define values for obtaining autokeys and payloads.	
				
		c				:= CourtLink.Constants('');
		ak_keyname    := c.ak_qa_keyname;
		ak_dataset    := c.ak_dataset;
	
		ak_skipSet		:= c.ak_skipSet;
		ak_typeStr		:= c.ak_typeStr;

		appType := AutoStandardI.InterfaceTranslator.application_type_val.val(project(AutoStandardI.GlobalModule(),AutoStandardI.InterfaceTranslator.application_type_val.params));
		
		// 2. Configure the autokey search.		
		ak_config_data := MODULE(BatchServices.Interfaces.i_AK_Config)
			export workHard        := TRUE; // for Autokey_batch.Fetch_Address_Batch to run at all.  (addresses are not input just name info
			                                 // and CourtJurisdiction).  
			export useAllLookups   := TRUE; // for Autokey_batch.Fetch_SSN_Batch to run SSN2 key. SSN key is empty.
			export PenaltThreshold := 2;  // done so that rules for middle name matching apply.  See bug # 59230
			                              // for additional information and test cases.
			export skip_set        := ak_skipset;
		END;
   	 
		sample_PLD_set := BatchServices._Sample_inBatchMaster('POSSIBLELITIGIOUSDEBTOR');
		
		// just use other inputs for testing.
	   test_PLD_recs := PROJECT(sample_PLD_set, TRANSFORM(
		                                         BatchServices.Layouts.PLD.rec_batch_PLD_input,	
																						        self.acctno := left.acctno;
																						        SELF.name_first := left.name_first;
																										Self.name_last  := left.name_last;																						        
																										SELF.CourtJurisdiction :=  left.st;		
																										self.CaseTypeSearch_FDCPA := left.sic_code;
																										self.CaseTypeSearch_FCRA  := left.fein;
																										self.CaseTypeSearch_TCPA  := left.ssn;
																										SELF := []
		                                                ));
																																																																									
    // 3. Grab the input XML and throw into a dataset.	
		ds_batch_in_pld := 
		                IF( NOT useCannedRecs, 		                         
															file_inPLDBatchMaster(forceSeq := FALSE),
		                          test_PLD_recs 
                             );		        

    // 4 move raw input into layout to pass to autokeys.
		ds_batch_in := PROJECT(ds_batch_in_pld, Autokey_batch.Layouts.rec_inBatchMaster);														 
											
		// 5. Get fake ids from the autokeys based on batch input.
		ds_fids := Autokey_batch.get_fids(ds_batch_in, ak_keyname, ak_config_data);
				
		// 6. Get autokey payload data (outPLfat) using the fake ids.
		AutokeyB2.mac_get_payload( UNGROUP(ds_fids), ak_keyname, ak_dataset, outPLfat, did, bdid, ak_typeStr );
		
		//outPLfat := project(ds_batch_in, layout_acct_mname);
		
		
		// 7. project payload into layout for output 
		ds_acctnos_PLD_CourtID_from_ak_payload := PROJECT( outPLfat, BatchServices.Layouts.PLD.rec_results_autokey_plus);
						
		// reduce payload just by input condition -- use acctno to join back set
		// use 1st 2 letters of courtJurisdiction as 'state of court filed in' to match instead
		// of using autokey state field cause no autokey state key file built cause state of court
		// not in the autokeys.
		//
		// relies on the fact that 1st 2 chars of courtid are always a 2 letter State Abbrev and represent
		// the state of court where case filed.
		//
		// Also setup the 3 caseTypeSearch_* fields with numbers to represent particular values 1,2,3
		// which will be used for filtering later.
		//
		ds_acctnos_PLD_deduped := dedup(sort(ds_acctnos_PLD_CourtID_from_ak_payload, acctno, courtid, docketnumber),
		                                 acctno, courtid, docketnumber);
																		 
		ds_filter_payload := join(ds_batch_in_pld, ds_acctnos_PLD_deduped,
		                           left.acctno = right.acctno AND
															 (left.CourtJurisdiction = '' OR left.CourtJurisdiction = right.courtid[1..2]),
															 transform(BatchServices.Layouts.PLD.rec_results_autokey_plusExtra, 
																		SELF.CaseTypeSearch_FDCPA := if (stringlib.stringToUpperCase(LEFT.CaseTypeSearch_FDCPA) = 'N', '1', '0'),
																		SELF.CaseTypeSearch_FCRA  := if (stringlib.stringToUpperCase(LEFT.CaseTypeSearch_FCRA) = 'N', '2', '0'),
																		SELF.CaseTypeSearch_TCPA	:= if (stringlib.stringToUpperCase(LEFT.CaseTypeSearch_TCPA) = 'N', '3', '0'),
													          SELF.LitigiousDebtor_Flag := 0;
																		self.penalt := 0;
																		self := right)
															 , LIMIT(BatchServices.Constants.PLD.JOIN_LIMIT, SKIP));		                                										
    			
    //8. join against payload key.
    ds_payload := JOIN( ds_filter_payload,
			                     CourtLink.key_CourtID_Docket,
			                     KEYED(LEFT.courtid = RIGHT.courtid) AND
													 KEYED(left.docketNumber = right.Docketnumber), 													 
														 TRANSFORM(
														  BatchServices.Layouts.PLD.rec_results_raw,
															  SELF.acctno := LEFT.acctno,
															  SELF.did := LEFT.did,			
																self.CaseTypeSearch_FDCPA := left.CaseTypeSearch_FDCPA;
																self.CaseTypeSearch_FCRA := left.CaseTypeSearch_FCRA;
																self.CaseTypeSearch_TCPA := left.CaseTypeSearch_TCPA;
																self.LitigiousDebtor_Flag := 0;
															  SELF := RIGHT,
																self := []; // to not have to fill in other fields in transform
															  ), KEEP(1000)); //BatchServices.Constants.PLD.JOIN_LIMIT));																
		
		
     
		 		 
		 recs_penalt := JOIN(ds_batch_in, ds_payload, 
		                       LEFT.acctno = RIGHT.acctno,
													 TRANSFORM(BatchServices.Layouts.PLD.rec_results_raw,
													           SELF.penalt := fn_apply_penalty(LEFT,RIGHT),																		
		                                 SELF        := RIGHT));      
     		 
		 ds_filter_payload_plus_slim := 
			DEDUP(
				SORT(
					recs_penalt(penalt <= ak_config_data.penaltThreshold),
					acctno, did, courtid, docketNumber
				),
				acctno, did, courtid, docketNumber
			);	
		 
		 // now take all recs which represent cases which you want and grab the case other information from all those particular
		 // cases by going back against payload key again
		 fullCase_payload_plus := join(ds_filter_payload_plus_slim, CourtLink.key_CourtID_Docket,
		                                        KEYED(LEFT.courtid = RIGHT.courtid) AND
																						KEYED(left.docketNumber = right.Docketnumber), 
																					 transform(BatchServices.Layouts.PLD.rec_results_raw,
																					 self.acctno := left.acctno,
																					 self.did := left.did,
																					 self.CaseTypeSearch_FDCPA := left.CaseTypeSearch_FDCPA;
																					 self.CaseTypeSearch_FCRA := left.CaseTypeSearch_FCRA;
																					 self.CaseTypeSearch_TCPA := left.CaseTypeSearch_TCPA;
																				   self.LitigiousDebtor_Flag := 0;
																					 self := RIGHT,
																					 self := []),LIMIT(BatchServices.Constants.PLD.JOIN_LIMIT, SKIP));		 		 				 
		 // pull dids.
		 Suppress.MAC_Suppress(fullCase_payload_plus,fullCase_payload_plus_pulled,appType,Suppress.Constants.LinkTypes.DID,did);
		 		 															    		 
     ds_slim := fullCase_payload_plus_pulled(causecode <> CaseTypeSearch_FDCPA AND 
		                                          causecode <> caseTypeSearch_FCRA AND
		                                                causecode <> CaseTypeSearch_TCPA); 			
				
     // this sort/dedup is used to remove like recs and to put the most recent asofdate recs to the top
		 // so other recs with same info except different asofdate can be eliminated in the rollup
																								
			tmp_ds_slim := dedup(sort(ds_slim, acctno, courtid, docketnumber, causecode, litigantLabel, litigantName, attorneyName , -asofdate, record),
			                                   acctno, courtid, docketnumber, causecode, litigantLabel, litigantName, attorneyName);
      // have to resort it here with -asofdate in front of attorney name in order to get correct dates in final output																		 
      tmp_ds_slim_resorted := sort(tmp_ds_slim, acctno, courtid, docketnumber, causecode, -asofdate, litigantLabel, litigantName, attorneyName, record);																				 
																				 																				
      // separate litigantNames into plaintiff/defendant columns so that they can be combined per
			// acctno/courtid/docketnumber within the rollup following this project.
			
			// idea here is to check input name match against any plaintiff
			// before adding in these various rows into final result rec
			// this eliminates any plaintiffs that don't match the input.
			// if nicknnames/phonetic options were able to match return recs could get more results here but currently these options turned off in batch for performance reasons.
			 BatchServices.Layouts.PLD.rec_results_raw filterLitigantName(BatchServices.Layouts.PLD.rec_results_raw r,
																																	 BatchServices.Layouts.PLD.rec_batch_PLD_input in_rec) := transform
       trimResultLitigantName := trim(r.litigantName, left, right);
			 trimInputFirstName := trim(in_rec.name_first, left, right);
			 trimInputLastName := trim(in_rec.name_last, left, right);
			 trimInputCompName := trim(in_rec.comp_name, left, right);
			 trimResultLastName := trim(r.debtor_lname, left, right);
			 trimResultFirstName := trim(r.debtor_fname, left, right);
			 			              // note to rework this logic
				self.match :=  if (
				                    ((r.litigantLabel=BatchServices.Constants.PLD.DEFENDANT)
				                       OR		
															 (r.litigantLabel <> BatchServices.Constants.PLD.DEFENDANT)
															 OR
				                        (r.litigantLabel=BatchServices.Constants.PLD.PLAINTIFF AND r.business_person=BatchServices.Constants.PLD.PERSON_CHAR AND 
													      ((trimResultFirstName = trimInputFirstName) 
																            // OR (resultNickFirst = inputNickFirst)
																						) AND
								                ((trimInputLastName = trimResultLastName) 
															  // OR (metaphonelib.DMetaPhone1(trimInputLastName[1..6]) =	metaphonelib.DMetaPhone1(trimResultLastName[1..6])
																	//)
																	)
													      )
											        OR
												        (
													       (r.business_person=BatchServices.Constants.PLD.COMPANY_CHAR) AND
													       (Stringlib.stringFind(trimResultLitigantName, trimInputCompName, 1) > 0)
														    )
												     ),
										   0,
										   BatchServices.Constants.PLD.FILTERVALUE);
				self := r;
      end;			
						
			filtered_recs := join (tmp_ds_slim_resorted, ds_batch_in_pld,
			                           left.acctno = right.acctno,
			                           filterLitigantName(left, right), LEFT OUTER,LIMIT(BatchServices.Constants.PLD.JOIN_LIMIT, SKIP));
            
      filtered_recs_slim := filtered_recs(match=0);															 
																
		  tmp_ds_slim2 := project(filtered_recs_slim,transform( BatchServices.Layouts.PLD.rec_results_raw,		 
			                 self.plaintiff := if (left.litigantLabel=BatchServices.Constants.PLD.PLAINTIFF, left.litigantName,'');
			                 self.defendant := if (left.litigantLabel=BatchServices.Constants.PLD.DEFENDANT, left.litigantName, '');																						
											 self.DattorneyName := if (left.litigantLabel=BatchServices.Constants.PLD.DEFENDANT and left.attorneyName <> '', left.AttorneyName + ' ' + left.attorneyLabel + '; ' + Left.firmname + '; ' +
						                                     left.address + '; ' + left.city + ', ' + left.state + ', ' + left.country + ' ' + 
																                 left.zipCode + '; ' + left.addtlinfo, '');
											 self.PattorneyName := if (left.litigantLabel=BatchServices.Constants.PLD.PLAINTIFF and left.attorneyName <> '', left.AttorneyName + ' ' + left.attorneyLabel + '; '+ Left.firmname + '; ' +
						                                     left.address + '; ' + left.city + ', ' + left.state + ', ' + left.country + ' ' + 
																                 left.zipCode + '; ' + left.addtlinfo, '');
                       self.AdditionalAttorneyname :=
																						 if ((left.litigantLabel <> BatchServices.Constants.PLD.DEFENDANT and
                                                  left.litigantLabel <> BatchServices.Constants.PLD.PLAINTIFF and 
																									left.attorneyName <> ''),
																								  '(FOR THE '+left.litigantLabel + ') ' + left.AttorneyName + ' ' + left.attorneyLabel + '; '+ left.firmname + '; ' +
						                                      left.address + '; ' + left.city + ', ' + left.state + ', ' + left.country + ' ' + 
																                  left.zipCode + '; ' + left.addtlinfo, '');
																						self := left;
																						));

			BatchServices.Layouts.PLD.rec_results_raw
			   rollrecs(
							BatchServices.Layouts.PLD.rec_results_raw L,
							BatchServices.Layouts.PLD.rec_results_raw R						
					) := transform				
					  
					   self.tmpAsOfDate := if (L.tmpAsOfDate = 0, (unsigned8) L.AsOfDate, if ((unsigned8) R.asOfDate > L.tmpAsOfDate, (unsigned8) R.asOfDate, L.tmpAsOfDate));             
            // temp attrs to check for dups within rollup and determine whether to add/delete names to previous rows as
						// list of rolled up.
            pAttorneyDup := ~(Stringlib.stringFind(L.PAttorneyName, R.PattorneyName, 1) > 0);
						dAttorneyDup := ~(Stringlib.stringFind(L.DAttorneyName, R.DattorneyName, 1) > 0);
						aAttorneyDup := ~(Stringlib.stringFind(L.AdditionalAttorneyName, R.AdditionalAttorneyName, 1) > 0);
						plaintiffDup := ~(Stringlib.stringFind(l.plaintiff, R.plaintiff, 1) > 0);
						defendantDup := ~(Stringlib.stringfind(l.defendant, R.defendant, 1) > 0);
						
						 self.PAttorneyName := L.PattorneyName +						                      
																   if (L.PattorneyName <> '' AND R.PattorneyName <> '' AND																	 
																			pAttorneyDup, ' **','') // logic for separator																	 
																	 + if (pAttorneyDup, R.PattorneyName, '');
																 													  																	 
             self.DAttorneyName := L.DattorneyName + 						                       
																	 if (L.DattorneyName <> '' and R.DattorneyName <> '' AND																	
																	 dAttorneyDup, ' **','')   // logic for separator..																	
																	 + if (dAttorneyDup, R.DattorneyName, '');
																	  																	            																	 
						 self.AdditionalAttorneyName := if (L.litigantLabel <> BatchServices.Constants.PLD.DEFENDANT and
                                                L.litigantLabel <> BatchServices.Constants.PLD.PLAINTIFF,																							
																							  L.AdditionalAttorneyName,'') +  
																	   if (L.AdditionalAttorneyName <> '' and R.additionalAttorneyName <> '' and																		      
                                            aAttorneyDup, ' **', '')																					
																	    + if (R.litigantLabel <> BatchServices.Constants.PLD.DEFENDANT and
                                            R.litigantLabel <> BatchServices.Constants.PLD.PLAINTIFF and																																								
																						aAttorneyDup,
																						R.AdditionalAttorneyName, '');
																						         																	
             tmp_litigantName  := if (R.litigantName = '', '',L.litigantName);
             self.litigantName := tmp_litigantName + if (R.litigantName <> '' and L.LitigantName <> '' and
						                                             L.litigantName <> R.LitigantName, R.litigantName, '');
              // use this model to avoid putting duplicate string (e.g attorney names) values into each field that is combined together.																												                                         
              self.plaintiff := L.plaintiff +
							                     if (L.plaintiff <> '' and R.plaintiff <> '' and plaintiffDup , ' ; ', '')  +						                           																
																	   if (plaintiffDup, R.plaintiff,'');
																	             
             self.defendant := L.defendant +
						                      if (L.defendant <> '' and R.defendant <> '' and defendantDup , ' ; ', '')  +
						                       if (defendantDup,R.defendant,'');																										
						self := L;														 
				 end;
       				 
			ds_slim_rolledup := rollup(tmp_ds_slim2,
			                           LEFT.acctno = right.acctno AND
																 LEFT.courtid = right.courtid AND
																 left.docketnumber = right.docketnumber,																															 
																  rollrecs(LEFT, RIGHT));		 
																	// put ** in front of all attorney lists if any exist
      ds_slim_rolledup_added := project(ds_slim_rolledup, transform(BatchServices.Layouts.PLD.rec_results_raw,
			                                  self.PAttorneyName := if (left.pAttorneyName <> '', '** ' + left.PattorneyName, 
																				                          left.PattorneyName);
																				self.DattorneyName := if (left.dAttorneyName <> '', '** ' + left.DattorneyName, 
																				                          left.DattorneyName);
																				self.AdditionalAttorneyName := if (left.AdditionalAttorneyName <> '',
																				     '**' + left.AdditionalAttorneyName, left.AdditionalAttorneyName);
                                        self.tmpAsOfDate := if (left.tmpAsOfDate > (unsigned8) left.asOfDate, left.tmpAsOfDate, (unsigned8) left.AsOfDate);
																				self := left;
																				));
     ds_slim_rolledup_filter := ds_slim_rolledup_added(plaintiff <> '' OR additionalAttorneyName <> '');																	
			   
   	 // FEW used here as opposed to MANY as long as we have fewer
		 // than 10,000 distinct groups.  UNSORTED is for optimization
			ds_cnt := table(ds_slim_rolledup_filter,
		               {acctno, causecode, unsigned2 cnt:=count(group);}, acctno, causecode, FEW, UNSORTED);
		 		 		 
		 ds_slim_joined := join(ds_slim_rolledup_filter, ds_cnt,
		                     left.acctno = right.acctno AND
												 left.causecode = right.causecode,
												 transform(
														BatchServices.Layouts.PLD.rec_results_raw,
														 self.LitigiousDebtor_Flag := if (right.cnt >= 2, 2, right.cnt); 																		                       
														 self := left;
													),LIMIT(BatchServices.Constants.PLD.JOIN_LIMIT, SKIP));						
																								
		 // split into different groups
     ds_separate_groups1 := ds_slim_joined(causecode = '1');
		 ds_separate_groups2 := ds_slim_joined(causecode = '2');
		 ds_separate_groups3 := ds_slim_joined(causecode = '3');
		 		 
		 // sort by acctno in each group
		 ds_separate_sorted_g1 := sort(ds_separate_groups1, acctno, -dateFiled, record);
		 ds_separate_sorted_g2 := sort(ds_separate_groups2, acctno, -dateFiled, record);
		 ds_separate_sorted_g3 := sort(ds_separate_groups3, acctno, -dateFiled, record);
		 
		 PLD_layoutCount := BatchServices.Layouts.PLD.rec_results_rawCount;
		 
		 count_ds_separate_sorted_g1 := project(ds_separate_sorted_g1, transform(pld_layoutCount,		                                             
																									 self.caseCount := 0;
																									 self := left;
		                                               ));
     count_ds_separate_sorted_g2 := project(ds_separate_sorted_g2, transform(pld_layoutCount,		                                             
																									 self.caseCount := 0;
																									 self := left;
		                                               ));
     count_ds_separate_sorted_g3 := project(ds_separate_sorted_g3, transform(pld_layoutCount,		                                             
																									 self.caseCount := 0;
																									 self := left;
		                                               ));																									 
    
		 // now interate through the dataset and count for each acctno the number of recs			
		        pld_layoutCount  T(pld_layoutCount Le, pld_layoutCount R) := TRANSFORM
						          self.caseCount := if (R.acctno = Le.acctno, Le.caseCount+1, 1);
											self := R;
            END;											
											
      group1counted := iterate(count_ds_separate_sorted_g1, T(LEFT, RIGHT));  			  					
			group2counted := iterate(count_ds_separate_sorted_g2, T(LEFT, RIGHT));			
			group3counted := iterate(count_ds_separate_sorted_g3, T(LEFT, RIGHT));

		 // in this dedup object is to keep only top 2 recs for each case type
		 // that have sequence numbers of 2 or less based on the previous sort of -DateFiled.
		 //  (i.e. 1 or 2).   It will keep at most 2 and if there are additional recs
		 // per acctno and casetype then it keep these recs as well.
		 // the "if (casecount <=2, 0, 1)," part acts as an intermediate sort
		 // thus allowing the top most 2 recs for each casetype to bubble to the top
		 // since they were already sorted by -dateFiled before the sequence number (counter)
		 // was added to the dataset ensuring that the top 2 would have 1 and 2 values 
		 // populated in the casecount field.
		 
		 ds_results := sort(dedup(sort(group1counted + group2counted + group3counted,
		                               acctno, 
																	 if (casecount <=2, 0, 1), 
																	 -dateFiled, record),
												acctno, keep(6)),
										acctno, -dateFiled, record);
     ds_results_grouped := group(ds_results, acctno);										
			 		    																				
    // 10. At this point, 'flatten' the resultant records into the specified output layout using ostensibly															
		 ds_results_rolled_flat := ROLLUP(ds_results_grouped, GROUP, xfm_PLD_make_flat(LEFT, ROWS(LEFT)));		
		 
		  // output(ds_acctnos_PLD_CourtID_from_ak_payload, named('ds_acctnos_PLD_CourtID_from_ak_payload'));
		 // output(ds_filter_payload, named('ds_filter_payload'));
		 

		// DEBUG	
		        // output(ds_payload, named('ds_payload'));
						// output(recs_penalt, named('recs_penalt'));
					  // output(ds_slim, named('ds_slim'));
			// output(tmp_ds_slim, named('tmp_ds_slim'));
		 
		  // output(tmp_ds_slim_resorted, named('tmp_ds_slim_resorted'));
		  // output(filtered_recs, named('filtered_recs'));
			// output(filtered_recs_slim, named('filtered_recs_slim'));
		  
		 // output(tmp_ds_slim2, named('tmp_ds_slim2'));
		   // output(ds_slim_rolledup, named('ds_slim_rolledup'));
			 // output(ds_slim_joined, named('ds_slim_joined'));
			 //DEBUG
		   // output(count_ds_separate_sorted_g1, named('count_ds_separate_sorted_g1'));
			 // output(count_ds_separate_sorted_g2, named('count_ds_separate_sorted_g2'));
			// output(count_ds_separate_sorted_g3, named('count_ds_separate_sorted_g3'));
			 // output(group1Counted, named('group1Counted'));			 
			// output(group2Counted, named('group2Counted'));
			// output(group3Counted, named('group3Counted'));
				 // output(group1Counted, named('group1Counted'));			 
			// output(group2Counted, named('group2Counted'));
			// output(group3Counted, named('group3Counted'));
			 // output(ds_results, named('ds_results'));
			 // output(ds_results_grouped, named('ds_results_grouped'));
			 
			 // OUTPUT( ds_filter_payload_plus_slim, NAMED('ds_filter_payload_plus_slim') );
						 
		 RETURN ds_results_rolled_flat;
		
END;