export svcAppend() := macro
	import BIPV2;
	import BIPV2_Best;
	import Doxie;

	boolean includeBest := false : stored('include_best');
	boolean allBest := false : stored('all_best');
	string fetchLevel := BIPV2.IdConstants.fetch_level_proxid : stored('fetch_level');
	boolean re_append := true : stored('re_append');
	unsigned score_threshold := 75 : stored('score_threshold');
	unsigned weight_threshold := 0 : stored('weight_threshold');
	boolean disable_salt_force := true : stored('disable_salt_force');
	boolean prim_force_post := false : stored('prim_force_post');
	boolean use_fuzzy := true : stored('use_fuzzy');
	boolean do_zip_expansion := true : stored('do_zip_expansion');
	boolean from_thor := false : stored('from_thor');
	boolean includeRecords := false : stored('include_records');
	boolean isMarketing := false : stored('is_marketing');
	boolean dnbFullRemove := false : stored('dnb_full_remove');
	boolean do_segmentation := true : stored('do_segmentation');

	defaultDataAccess := MODULE(doxie.IDataAccess) END;
	typeof(Doxie.IDataAccess.glb) dataAccessGlb := defaultDataAccess.glb : stored('data_access_glb');
	typeof(Doxie.IDataAccess.dppa) dataAccessDppa := defaultDataAccess.dppa : stored('data_access_dppa');
	typeof(Doxie.IDataAccess.lexid_source_optout) dataAccessLexidSourceOptout := defaultDataAccess.lexid_source_optout : stored('data_access_lexid_source_optout');

	modAccess := module(Doxie.IDataAccess)
		export glb := dataAccessGlb;
		// export typeof(Doxie.IDataAccess.glb) glb := dataAccessGlb;
		export typeof(Doxie.IDataAccess.dppa) dppa := dataAccessDppa;
		export typeof(Doxie.IDataAccess.lexid_source_optout) lexid_source_optout := dataAccessLexidSourceOptout;
	end;

	inputDs := dataset([], BIPV2.IdAppendLayouts.AppendInput) : stored('append_input');

	withAppendRoxie := BIPV2.IdAppendRoxieLocal(inputDs
		,scoreThreshold := score_threshold
		,weightThreshold := weight_threshold
		,disableSaltForce := disable_salt_force
		,primForcePost := prim_force_post 
		,useFuzzy := use_fuzzy
		,doZipExpansion := do_zip_expansion
		,reAppend := re_append
		,segmentation := do_segmentation
	);

	// matchset has to be defined outside of macro call so that code will syntax check.
	match_set := ['A','F','P'];

	withAppendThor := BIPV2.IdAppendThorLocal(
		infile := inputDs
		,matchset := match_set
		,company_name_field := company_name
		,prange_field := prim_range
		,pname_field := prim_name
		,zip_field := zip5
		,srange_field := sec_range
		,state_field := state
		,phone_field := phone10
		,fein_field := fein
		,outrec := BIPV2.IdAppendLayouts.IdsOnlyDebug
		,bool_outrec_has_score := true
		,keep_count := '1'
		,score_threshold := score_threshold
		,pURL := url
		,pEmail := email
		,pCity := city
		,pContact_fname := contact_fname
		,pContact_mname := contact_mname
		,pContact_lname := contact_lname
		,pContact_ssn := contact_ssn
		,pSource := source
		,pSource_record_id := source_record_id
		,useFuzzy := use_fuzzy
		,weightThreshold := weight_threshold
		,disableSaltForce := disable_salt_force
		,segmentation := do_segmentation
		,reAppend := re_append
	);

	withAppend := if(from_thor, withAppendThor, withAppendRoxie);

	postAppend := project(withAppend,
		transform(BIPV2.IDAppendLayouts.svcAppendOutv2,
			self := left,
			self := []));

	postBest := BIPV2.IdAppendLocal.AppendBest(withAppend, fetchLevel := fetchLevel
	                                           ,allBest := allBest, isMarketing := isMarketing
											   ,mod_access := modAccess);

	res := if(includeBest, postBest, postAppend);
	resv1 := project(res, transform(BIPV2.IdAppendLayouts.svcAppendOut, self := left));

	emptyHeader := dataset([], BIPV2.IdAppendLayouts.svcAppendRecsOut);

#IF(BIPV2.IdConstants.USE_LOCAL_KEYS)
	postHeader := BIPV2.IdAppendLocal.FetchRecords(withAppend, fetchLevel, dnbFullRemove
	                                               ,mod_access := modAccess);
#ELSE
	postHeader := emptyHeader;
#END

	// Catch failures so roxiepipe won't fail.
	// Return dataset with request ids in case of failure, turning an error into a no hit.
	catchRes := catch(res, onfail(transform(recordof(res), self.error_code := FAILCODE, self.error_msg := FAILMESSAGE, self := [])));
	isError := exists(catchRes(error_code != 0 or error_msg != ''));
	failResultv1 := project(inputDs, transform(BIPV2.IDAppendLayouts.svcAppendOut,
	                      self.request_id := left.request_id, self := []));
	failResult := project(inputDs, transform(BIPV2.IDAppendLayouts.svcAppendOutv2,
	                      self.request_id := left.request_id,
	                      self.error_code := catchRes[1].error_code,
	                      self.error_msg := catchRes[1].error_msg, self := []));
				
	parallel(
		output(if(isError, failResult, res), named('Results_v2'));
		output(if(includeRecords, postHeader, emptyHeader), named('Header'));
		output(if(isError, failResultv1, resv1), named('Results'));

	);

	// parallel(
		// output(preBest, named('preBest'));
		// output(withBest, named('withBest'));
		// output(withAppend, named('withappend'));
		// output(postBest, named('postbest'));
		// output(postAppend, named('postAppend'));
		// output(res, named('Results'));
	// );
endmacro;