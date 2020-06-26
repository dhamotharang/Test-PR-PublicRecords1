EXPORT Records (DATASET(HomesteadExemptionV2_Services.Layouts.workRecSlim) ds_seq_input,
				HomesteadExemptionV2_Services.IParams.Params in_mod) := FUNCTION

	ds_cln_names  := HomesteadExemptionV2_Services.Functions.clean_Names(ds_seq_input);
	ds_validated  := HomesteadExemptionV2_Services.Functions.validate_Input(ds_cln_names,in_mod);
	ds_with_dids  := HomesteadExemptionV2_Services.Functions.append_Dids(ds_validated,in_mod);
    // If a LexId was not retrieved from Didville, try to retrieve one from Property.
	ds_with_LexIdByProperty  := HomesteadExemptionV2_Services.Functions.append_LexIdsByProperty(
					ds_with_dids(exception_code  <> '' AND
					error_code <> HomesteadExemptionV2_Services.Constants.INSUFFICIENT_INPUT_CODE),
					in_mod);

	ds_with_all_dids := JOIN(ds_with_dids, ds_with_LexIdByProperty,
							LEFT.acctno = RIGHT.acctno,
							TRANSFORM(HomesteadExemptionV2_Services.Layouts.workRecSlim,
								// If a LexID was retrieved from Didville, use it.  
								// If not, use the LexID from Property, even it's 0.
								did := IF(RIGHT.did <> 0, RIGHT.did, LEFT.did);
								// If a LexID was not retrieved from Didville but a LexID
								// was retrieved from Property, force the score to be 100.
								score := IF(RIGHT.did <> 0, RIGHT.score, LEFT.score);
								SELF.did := did,
								SELF.score := score;
								SELF.error_code := IF(LEFT.did <> 0 OR did = 0, LEFT.error_code, 0);
								SELF.exception_code := IF(LEFT.did <> 0 OR did = 0, LEFT.exception_code, '');
								SELF := LEFT), LEFT OUTER);

	ds_with_best  := HomesteadExemptionV2_Services.Functions.append_Best(ds_with_all_dids(error_code = 0),in_mod);
	ds_with_death := HomesteadExemptionV2_Services.Functions.append_Deceased(ds_with_best,in_mod);
	ds_with_prop  := HomesteadExemptionV2_Services.fn_getProperties(ds_with_death,in_mod);

	ds_rejects:=PROJECT(ds_with_all_dids(error_code>0),TRANSFORM(HomesteadExemptionV2_Services.Layouts.workRec,
		SELF.acctno:=LEFT.acctno,
		SELF.clientid:=LEFT.clientid,
		SELF.link_clientid:=LEFT.link_clientid,
		SELF.did:=LEFT.did,
		SELF.score:=LEFT.score,
		SELF.error_code:=LEFT.error_code,
		SELF.exception_code:=LEFT.exception_code,
		SELF.orig_acctno:=LEFT.orig_acctno,
		SELF.orig_clientid:=LEFT.orig_clientid,
		SELF:=[]));

    // OUTPUT(ds_seq_input,NAMED('ds_seq_input'));
	// OUTPUT(ds_cln_names,NAMED('ds_cln_names'));
	// OUTPUT(ds_validated,NAMED('ds_validated'));
	// OUTPUT(ds_with_dids,NAMED('ds_with_dids'));
	// OUTPUT(ds_with_LexIdByProperty,NAMED('ds_with_LexIdByProperty'));
	// OUTPUT(ds_with_all_dids,NAMED('ds_with_all_dids'));
	// OUTPUT(ds_with_best,NAMED('ds_with_best'));
	// OUTPUT(ds_with_death,NAMED('ds_with_death'));
	// OUTPUT(ds_with_prop,NAMED('ds_with_prop'));

	RETURN SORT(ds_with_prop+ds_rejects,acctno);

END;
