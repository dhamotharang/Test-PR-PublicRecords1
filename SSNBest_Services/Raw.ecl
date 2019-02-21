EXPORT Raw := MODULE

  //This function macro returns ALL raw data in the Best SSN Key per the input DIDs
	EXPORT Get_All(in_ds, pSSN = 'best_ssn', pDID = 'did', fromADL=false) := FUNCTIONMACRO										
	IMPORT SSNBest_Services,Header;
		in_ds_duped:= DEDUP(in_ds,pDID,pSSN);

		full_ssn_rec := JOIN(in_ds_duped, Header.key_AllPossibleSSNs
										 ,KEYED(LEFT.pDID = RIGHT.did)
										 ,TRANSFORM(SSNBest_Services.Layouts.KEY_full
	      #IF(fromADL) ,SELF.SSN_Already_found := LEFT.pSSN = RIGHT.subject(confidence=1)[1].ssn #END				 
										 ,SELF := RIGHT)
										 ,LIMIT(0),KEEP(SSNBest_Services.Constants.MaxResults));
		RETURN full_ssn_rec;
	ENDMACRO;

	// This Function Macro returns the Best SSN of confidence = 1 for the input DID subjects, If confidence = 1 is not Allowable after restrictions 
	// it returns the best SSN with confidence = 2 or 3 and so on.. 
	EXPORT Get_Subj_Best(in_ds, SSNBestParams, pSSN = 'best_ssn', pDID = 'did', fromADL=false) := FUNCTIONMACRO			
	IMPORT SSNBest_Services,BatchShare;

		all_recs_raw := SSNBest_Services.Raw.Get_All(in_ds,pSSN,pDID,fromADL);
										 
		subjNorm := NORMALIZE(all_recs_raw,LEFT.subject, 
													TRANSFORM(SSNBest_Services.Layouts.KEY_subjNorm
																	 ,SELF.ssn_ind:=RIGHT._ssndata.ssn_ind
																	 ,SELF.srcs:=RIGHT._ssndata.srcs
																	 ,SELF:=RIGHT,SELF:=LEFT));

		subjSrcNorm  := SORT(NORMALIZE(subjNorm,LEFT.srcs, 
															TRANSFORM(SSNBest_Services.Layouts.KEY_subjSrcNorm
		                                   ,SELF:=RIGHT,SELF:=LEFT)), did, confidence, -score);
		
		//if comming from ADL Best, only restrict SSN's from the BestSSN KEY that are different
		//than the ones returned from ADL_Best since they are already restricted
		recs_to_restrict := subjSrcNorm(~SSN_Already_found); 
		restriction_safe_ds := BatchShare.MAC_ApplyRestrictions(recs_to_restrict,SSNBestParams);
		restrictions_applied_ADL_ds := subjSrcNorm(SSN_Already_found) + restriction_safe_ds;
		
		//if not comming from ADL best, we restrict all
		restrictions_applied_ds := BatchShare.MAC_ApplyRestrictions(subjSrcNorm,SSNBestParams);
		
		restricted_ds := IF(fromADL,restrictions_applied_ADL_ds,restrictions_applied_ds);

		// output(in_ds,named('BestSSN_Raw_IN_ds'));
		// output(all_recs_raw,named('all_recs_raw'));
		// output(subjNorm,named('subjNorm'));
		// output(subjSrcNorm,named('subjSrcNorm'));
		// output(recs_to_restrict,named('recs_to_restrict'));
		// output(recs_to_restrict - restriction_safe_ds,named('restricted_records_suppressed'));
		// output(restrictions_applied_ADL_ds,named('restrictions_applied_ADL_ds'));
		// output(restrictions_applied_ds,named('restrictions_applied_ds'));
		// output(restricted_ds,named('restricted_ds'));
		
		RETURN restricted_ds;
	ENDMACRO;
	
	/* **************  FUTURE USE //TO DO - similar to how Get_Subj_Best is done, now get the others records via NORMALIZE ************\

	//This Function Macro returns the Best SSN of confidence of 1 for others that have the same SSN as the input DID subject.
	EXPORT Get_Others_With_Subj_Best(in_ds, SSNBestParams, pSSN = 'best_ssn', pDID = 'did', fromADL=false) := FUNCTIONMACRO										
	IMPORT SSNBest_Services,BatchShare;
		all_recs_raw := SSNBest_Services.Raw.Get_All(in_ds,SSNBestParams,pSSN,pDID,fromADL);					 
		RETURN all_recs_raw;
	ENDMACRO;
	
	//This Macro returns the Best SSN of confidence of 1 for the input DID subjects as well as others that have the same SSN.
	EXPORT MAC_Subj_Others(in_ds, subj_out, others_out, SSNBestParams, pSSN = 'best_ssn', pDID = 'did', fromADL=false) := MACRO										
		subj_out   := Get_Subj_Best(in_ds,SSNBestParams,pSSN,pDID,fromADL);
		others_out := Get_Others_With_Subj_Best(in_ds,SSNBestParams,pSSN,pDID,fromADL);
	ENDMACRO;
*/
	
END;