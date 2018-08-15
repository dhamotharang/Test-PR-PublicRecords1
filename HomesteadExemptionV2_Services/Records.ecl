EXPORT Records (DATASET(HomesteadExemptionV2_Services.Layouts.workRecSlim) ds_seq_input,
				HomesteadExemptionV2_Services.IParams.Params in_mod) := FUNCTION

	ds_cln_names  := HomesteadExemptionV2_Services.Functions.clean_Names(ds_seq_input);
	ds_validated  := HomesteadExemptionV2_Services.Functions.validate_Input(ds_cln_names,in_mod);
	ds_with_dids  := HomesteadExemptionV2_Services.Functions.append_Dids(ds_validated,in_mod);
	ds_with_best  := HomesteadExemptionV2_Services.Functions.append_Best(ds_with_dids(error_code=0),in_mod);
	ds_with_death := HomesteadExemptionV2_Services.Functions.append_Deceased(ds_with_best,in_mod);
	ds_with_prop  := HomesteadExemptionV2_Services.fn_getProperties(ds_with_death,in_mod);

	ds_rejects:=PROJECT(ds_with_dids(error_code>0),TRANSFORM(HomesteadExemptionV2_Services.Layouts.workRec,
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

	// OUTPUT(ds_cln_names,NAMED('ds_cln_names'));
	// OUTPUT(ds_validated,NAMED('ds_validated'));
	// OUTPUT(ds_with_dids,NAMED('ds_with_dids'));
	// OUTPUT(ds_with_best,NAMED('ds_with_best'));
	// OUTPUT(ds_with_death,NAMED('ds_with_death'));
	// OUTPUT(ds_with_prop,NAMED('ds_with_prop'));

	RETURN SORT(ds_with_prop+ds_rejects,acctno);
END;
