IMPORT SSNBest_Services,doxie,Risk_Indicators,doxie_crs;
EXPORT Functions := MODULE

	//returns the 'best ssn' with input layout - currently called from ADL_Best - DidVille.MAC_BestAppend & doxie.best_records
	EXPORT fetchSSNs_generic(in_ds, in_SSNBestParams, pSSN = 'best_ssn', pDID = 'did', fromADL=false) := FUNCTIONMACRO
	IMPORT SSNBest_Services;
		Subj_SSNs := SSNBest_Services.Raw.Get_Subj_Best(in_ds,in_SSNBestParams,pSSN,pDID,fromADL);

		//At this point there are multiple records per DID for each SRC. So since we are done applying restrictions per the sources,
		//we can now rollup the dataset down to 1 ssn record per DID.
		srcNorm_duped := DEDUP(SORT(Subj_SSNs,did,-score,confidence),did);	

		bestSSNs := JOIN(in_ds, srcNorm_duped
													 ,LEFT.pDID = RIGHT.did
													 ,TRANSFORM(RECORDOF(in_ds)
														,SELF.pSSN := RIGHT.ssn, SELF := LEFT)
													 ,LEFT OUTER
													 ,LIMIT(SSNBest_Services.Constants.JOIN_LIMIT, SKIP));

		// output(Subj_SSNs,named('Subj_SSNs'));
		// output(bestSSNs,named('bestSSNs'));												 
												 								 
		RETURN bestSSNs;
	ENDMACRO;

  //returns the SSNBest_Services.Layouts.Batch_out and appends the best ssn.
	//This function abides to the best ssn project rules. It can however be used by
	//others to make use of any field returned in SSNBest_Services.Layouts.Batch_out
	//note that passing in_mod.Display_HRI = TRUE will always return an SSN.
	EXPORT fetchSSNs(in_ds, in_mod, pSSN = 'ssn',pDID = 'did') := FUNCTIONMACRO
	IMPORT SSNBest_Services,MDR,AutoKeyI;

    mod_ssn := SSNBest_Services.IParams.setFromBatch (in_mod);
		Subj_SSNs := SSNBest_Services.Raw.Get_Subj_Best(in_ds,mod_ssn,pSSN,pDID);

		rollupRec := RECORD(SSNBest_Services.Layouts.KEY_subjSrcNorm)
     string1 bureau_only_ssn := '';
    END;

		readyForRollup := PROJECT(Subj_SSNs,rollupRec);

		isCB(string2 src) := src IN MDR.sourceTools.set_credit_header_bureau;

		rollupRec rollem(rollupRec L,rollupRec R) := TRANSFORM
			SELF.dt_first_seen   := ut.min2(L.dt_first_seen,R.dt_first_seen);
			SELF.dt_last_seen    := max(L.dt_last_seen ,R.dt_last_seen );
			//this checks if ALL sources per did are credit bureau only sources
			SELF.bureau_only_ssn := IF(L.bureau_only_ssn<>'N' AND (isCB(L.src) AND isCB(R.src)),'Y','N');
			SELF := L;
		END;

		//At this point there are multiple records per DID for each SRC. So since we are done applying restrictions per the sources,
		//we can now rollup the dataset down to 1 ssn record per DID.
		//In the rollup, we get the correct dates and populate the bureau_only_ssn field per the requirements.
		rolled := ROLLUP(readyForRollup,LEFT.did=RIGHT.did, rollem(LEFT,RIGHT));

    //PSS - possible shared ssn. OC - other count (i.e. others with the same SSN)
		PSS(unsigned4 oc) := MAP(oc >= SSNBest_Services.Constants.Max_OtherCount_Threshold => 'Y'
		                        // else if there are between 1 and 3 people with the same SSN
														,oc >= SSNBest_Services.Constants.Single_OtherCount_withSSN => 'P'
														,           'N'); // if its 0

		IF_No_Errors(string9 ssn_, string1 out) :=IF(ssn_<>'',out,'');

		SSNBest_Services.Layouts.Batch_out BestSSNQueryOut(RECORDOF(in_ds) L, readyForRollup R) := TRANSFORM
			SELF.acctno          := L.acctno;
			SELF.error_code      := IF(R.ssn='',AutoKeyI.errorcodes._codes.NO_RECORDS,0);
			SELF.out_did         := R.did;
			SELF.best_ssn        := IF(R.other_cnt < SSNBest_Services.Constants.Max_OtherCount_Threshold OR in_mod.Display_HRI, R.ssn, '');
			SELF.dt_first_seen   := R.dt_first_seen;
			SELF.dt_last_seen    := R.dt_last_seen;
			SELF.poss_shared_ssn := IF_No_Errors(R.ssn, PSS(R.other_cnt));
			SELF.other_cnt       := R.other_cnt;
			SELF.bureau_only_ssn := IF_No_Errors(R.ssn, IF(R.bureau_only_ssn='',IF(isCB(R.src),'Y','N'),R.bureau_only_ssn)); //this will handle single records that didn't get populated in the rollup
		END;

		bestSSNQuery := JOIN(in_ds, rolled
										     ,LEFT.pDID = RIGHT.did
												 ,BestSSNQueryOut(LEFT,RIGHT)
										     ,LEFT OUTER
												 ,LIMIT(SSNBest_Services.Constants.JOIN_LIMIT, SKIP));

		final_o := IF(in_mod.Display_HRI, SSNBest_Services.Functions.PopulateHRI(bestSSNQuery), bestSSNQuery);

		// output(readyForRollup,named('readyForRollup'));
		// output(rolled,named('rolled'));
		// output(in_ds,named('in_ds'));
		// output(final_o,named('final_o'));

		RETURN final_o;
	ENDMACRO;

	EXPORT PopulateHRI(DATASET(SSNBest_Services.Layouts.Batch_out) ds_in) := FUNCTION

		forhri := PROJECT(ds_in, TRANSFORM(doxie_crs.layout_HRI_SSN
														 ,SELF.hri_ssn := DATASET([],Risk_Indicators.Layout_Desc)
														 ,SELF.did := LEFT.out_did
														 ,SELF.ssn := LEFT.best_ssn
														 ,SELF:=LEFT,SELF:=[]));
														 
		//per the requirements, we populate a max of 6 HRI fields												 
		maxHriPer_value := 6;
		doxie.mac_addhrissn(forhri, whri, false);

		SSNBest_Services.Layouts.Batch_out populateHRI(SSNBest_Services.Layouts.Batch_out L, doxie_crs.layout_HRI_SSN R) := TRANSFORM
		  hri_recs:= R.hri_ssn(hri IN SSNBest_Services.Constants.ACCEPTABLE_HRI_CODES);
			SELF.hri_code_1 := hri_recs[1].hri;
			SELF.hri_desc_1 := hri_recs[1].desc;
			SELF.hri_code_2 := hri_recs[2].hri;
			SELF.hri_desc_2 := hri_recs[2].desc;
			SELF.hri_code_3 := hri_recs[3].hri;
			SELF.hri_desc_3 := hri_recs[3].desc;
			SELF.hri_code_4 := hri_recs[4].hri;
			SELF.hri_desc_4 := hri_recs[4].desc;
			SELF.hri_code_5 := hri_recs[5].hri;
			SELF.hri_desc_5 := hri_recs[5].desc;
			SELF.hri_code_6 := hri_recs[6].hri;
			SELF.hri_desc_6 := hri_recs[6].desc;
			SELF:=L;
		END;

		with_hri := JOIN(ds_in, whri
								,LEFT.out_did = RIGHT.did
								,populateHRI(LEFT,RIGHT)
								,LEFT OUTER
								,LIMIT(SSNBest_Services.Constants.JOIN_LIMIT, SKIP));

		RETURN with_hri;
	END;

END;