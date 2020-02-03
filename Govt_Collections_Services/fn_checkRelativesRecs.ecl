
IMPORT doxie, Govt_Collections_Services, Relationship, ut;

EXPORT fn_checkRelativesRecs(dataset(Layouts.batch_working) ds_batch_in,
                     Govt_Collections_Services.IParams.BatchParams in_mod ) := 
	FUNCTION
		
		// Fulfills new version documentation Req. 4.1.11
		
		layout_rels := RECORD
	   STRING20 acctno;
		 STRING20 first_name := '';
	   STRING20 last_name := '';
	   STRING9  rel_ssn := '';
		 UNSIGNED6 rel_did := 0;
    END;
	 
	 
		// 1. Filter out records for which it is already known that best SSN will not be returned in output 
		//    based on flag indicators set by processing through a list of other services
		ds_batch_in_filt := ds_batch_in(~input_is_best_ssn AND ~best_SSN_is_poss_shared AND best_ssn != '');
		
		// 2. Get the list of relatives based on dids
		// Use relationship proc to retrieve relative dids.
		ds_did := project(ds_batch_in_filt(lex_id != ''),transform(Relationship.Layout_GetRelationship.DIDs_layout,SELF.did := (integer)LEFT.Lex_id,SELF := []));
				
		ds_relative_recs := Relationship.proc_GetRelationshipNeutral(ds_did,
			RelativeFlag:=TRUE,
			AssociateFlag:=TRUE,
			MaxCount:=ut.limits.RELATIVES_PER_PERSON,
			doAtmost:=TRUE,
			HighConfidenceRelatives:=in_mod.relationship_highConfidenceRelatives,
			HighConfidenceAssociates:=in_mod.relationship_highConfidenceAssociates,
			RelLookbackMonths:=in_mod.relationship_relLookbackMonths,
			txflag:=Relationship.Functions.getTransAssocFlgs(in_mod.relationship_transAssocMask)
		).result;
																		
		ds_with_relative_raw := JOIN(ds_batch_in_filt, ds_relative_recs, 
			                            (UNSIGNED6) LEFT.Lex_ID = RIGHT.did1,
				                          TRANSFORM(layout_rels, 
					                                   SELF.rel_did := RIGHT.did2, 
					                                   SELF.acctno := LEFT.acctno,
																						 SELF := []));

		// 3. Find best SSN for each relative's did record.	Output layout - doxie.layout_best	
		rels_dids := dedup(sort(ds_with_relative_raw, rel_did), rel_did);
		doxie.mac_best_records(rels_dids, rel_did, best_rels_recs, in_mod.isValidDPPA(),in_mod.isValidGLB(), , in_mod.DataRestrictionMask);	
		
		// 4. Join back to acctno.
		ds_rels_recs_pre := JOIN(ds_with_relative_raw, best_rels_recs, 
		                             (UNSIGNED)LEFT.rel_did = (UNSIGNED)RIGHT.did,
				                          TRANSFORM(layout_rels, 
					                                   SELF.first_name := RIGHT.fname, 
					                                   SELF.last_name := RIGHT.lname,
																						 SELF.rel_ssn := RIGHT.ssn,
																						 SELF := LEFT
																						)
													   );


		// 5. Filter out blank names:
		ds_rels_recs_valid := 
				GROUP(SORT(ds_rels_recs_pre,acctno),acctno);

    // 6. Process relatives names: 
		//    req.4.1.11: If the Relative and cleaned Input Names do match 100%, then the Best SSN will not be returned in output. 
    Layouts.batch_working	xfm_check_rels (Layouts.batch_working le,layout_rels ri) := 
		  TRANSFORM
				SELF.best_ssn_is_rel_linked := le.best_ssn_is_rel_linked OR le.best_ssn=ri.rel_ssn
				                               OR (le.name_first=ri.first_name AND le.name_last=ri.last_name)
				                               OR (le.best_fname=ri.first_name AND le.best_lname=ri.last_name);
				SELF                        := le;
		  END;
		
		ds_rels_results := DENORMALIZE(ds_batch_in,ds_rels_recs_valid, 
		                               LEFT.acctno=RIGHT.acctno,
				                           xfm_check_rels(LEFT,RIGHT),
																	 LEFT OUTER);
		
		IF( in_mod.ViewDebugs, 
				OUTPUT( ds_rels_recs_valid, NAMED('ds_rels_recs_valid') ) );		
			
		RETURN ds_rels_results;
		
	END;