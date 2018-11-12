export svcAppend := function
	import BIPV2;
	import BIPV2_Best;

	boolean includeBest := false : stored('include_best');
	boolean allBest := false : stored('all_best');
	string fetchLevel := BIPV2.IdConstants.fetch_level_proxid : stored('fetch_level');
	boolean do_append := true : stored('do_append');
	unsigned score_threshold := 75 : stored('score_threshold');
	unsigned weight_threshold := 0 : stored('weight_threshold');
	boolean disable_salt_force := true : stored('disable_salt_force');
	boolean prim_force_post := false : stored('prim_force_post');
	boolean use_fuzzy := true : stored('use_fuzzy');
	boolean do_zip_expansion := true : stored('do_zip_expansion');
	boolean from_thor := false : stored('from_thor');
	boolean includeRecords := false : stored('include_records');

	inputDs := dataset([], BIPV2.IdAppendLayouts.AppendInput) : stored('append_input');

	postAppendLayout := {
		inputDs.request_id,
		BIPV2.IDlayouts.l_xlink_ids
	};

	withAppendRoxie := BIPV2.IdAppendRoxieLocal(inputDs
		,scoreThreshold := score_threshold
		,weightThreshold := weight_threshold
		,disableSaltForce := disable_salt_force
		,primForcePost := prim_force_post 
		,useFuzzy := use_fuzzy
		,doZipExpansion := do_zip_expansion
		,doAppend := do_append
		,fromThor := from_thor
	);

	withAppendThor := BIPV2.IdAppendThorLocal(
		inputDs
		,['A','F','P'] // matchset
		,company_name // company_name_field
		,prim_range // prange_field
		,prim_name // pname_field
		,zip5 // zip_field
		,sec_range // srange_field
		,state // state_field
		,phone10 // phone_field
		,fein // fein_field
		,BDID_field
		,BIPV2.IdAppendLayouts.IdsOnly // outrec
		,true // bool_outrec_has_score
		,BDID_Score_field
		,//keep_count := '1'
		,score_threshold //score_threshold := '75'
		,url // pURL = ''
		,email // pEmail = ''
		,city // pCity = ''
		,contact_fname // pContact_fname = ''
		,contact_mname // pContact_mname = ''
		,contact_lname // pContact_lname = ''
		,contact_ssn // pContact_ssn = ''
		,source // pSource = ''
		,source_record_id // pSource_record_id = ''
	);

	withAppend := if(from_thor, withAppendThor, withAppendRoxie);

	postAppend := project(withAppend,
		transform(BIPV2.IDAppendLayouts.svcAppendOut,
			self := left,
			self := []));

	postBest := BIPV2.IdAppendLocal.AppendBest(withAppend, fetchLevel := fetchLevel, allBest := allBest);

	res := if(includeBest, postBest, postAppend);

	postHeader := BIPV2.IdAppendLocal.FetchRecords(withAppend, fetchLevel);

	emptyHeader := dataset([], BIPV2.IdAppendLayouts.svcAppendRecsOut);
				
	return parallel(
		output(res, named('Results'));
		output(if(includeRecords, postHeader, emptyHeader), named('Header'));
	);

	// return parallel(
		// output(preBest, named('preBest'));
		// output(withBest, named('withBest'));
		// output(withAppend, named('withappend'));
		// output(postBest, named('postbest'));
		// output(postAppend, named('postAppend'));
		// output(res, named('Results'));
	// );
end;