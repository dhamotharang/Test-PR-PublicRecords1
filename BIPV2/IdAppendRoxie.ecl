import BIPV2;

export IdAppendRoxie(
		dataset(BIPV2.IdAppendLayouts.AppendInput) inputDs
		,unsigned scoreThreshold = 75
		,unsigned weightThreshold = IdConstants.APPEND_WEIGHT_THRESHOLD_ROXIE
		,boolean primForce = false
		,boolean reAppend = true
		,boolean allowInvalidResults = false
	) := module

	#IF(BIPV2.IdConstants.USE_LOCAL_KEYS)
	shared localAppend :=
		BIPV2.IdAppendRoxieLocal(
			inputDs
			,scoreThreshold := scoreThreshold
			,weightThreshold := weightThreshold
			,disableSaltForce := not primForce
			,reAppend := reAppend);
	#END

	shared remoteAppend := BIPV2.IdAppendRoxieRemote(
			inputDs
			,scoreThreshold := scoreThreshold
			,weightThreshold := weightThreshold
			,disableSaltForce := not primForce
			,reAppend := reAppend);

	export IdsOnly() := function
		#IF(BIPV2.IdConstants.USE_LOCAL_KEYS)
			res := project(localAppend, transform(BIPV2.IdAppendLayouts.IdsOnlyOutput, self := left, self := []));
		#ELSE
			res := project(remoteAppend.IdsOnly(), BIPV2.IdAppendLayouts.IdsOnlyOutput);
		#END
		return if(scoreThreshold > 50 or not reAppend or allowInvalidResults,
			res,
			error(recordof(res), 'score <= 50 can produce invalid id resolution'));
	end;

	export WithBest(string fetchLevel = BIPV2.IdConstants.fetch_level_proxid, boolean allBest = false,
	                boolean isMarketing = false) := function
		#IF(BIPV2.IdConstants.USE_LOCAL_KEYS)
			res0 := BIPV2.IdAppendLocal.AppendBest(localAppend, fetchLevel := fetchLevel, allBest := allBest,
			                                       isMarketing := isMarketing);
			res := project(res0, transform(BIPV2.IdAppendLayouts.AppendOutput, self := left, self := []));
		#ELSE
			res := remoteAppend.WithBest(fetchLevel := fetchLevel, allBest := allBest);
		#END

		return if(scoreThreshold > 50 or not reAppend or allowInvalidResults,
			res,
			error(recordof(res), 'score <= 50 can produce invalid id resolution'));
	end;

	export WithRecords(string fetchLevel = BIPV2.IdConstants.fetch_level_proxid, boolean dnbFullRemove = false) := function
		#IF(BIPV2.IdConstants.USE_LOCAL_KEYS)
			res0 := BIPV2.IdAppendLocal.FetchRecords(localAppend, fetchLevel, dnbFullRemove);
			res := project(res0, transform(BIPV2.IdAppendLayouts.AppendWithRecsOutput, self := left, self := []));	
		#ELSE
			res := remoteAppend.WithRecs(fetchLevel := fetchLevel);
		#END
		return if(scoreThreshold > 50 or not reAppend or allowInvalidResults,
			res,
			error(recordof(res), 'score <= 50 can produce invalid id resolution'));
	end;

end;

