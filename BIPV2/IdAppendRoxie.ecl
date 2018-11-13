import BIPV2;

export IdAppendRoxie(
		dataset(BIPV2.IdAppendLayouts.AppendInput) inputDs
		,unsigned scoreThreshold = 75
		,unsigned weightThreshold = 0
		,boolean doAppend = true
		,boolean primForce = false
		,boolean allowInvalidResults = false
	) := module


	shared localAppend :=
		BIPV2.IdAppendRoxieLocal(
			inputDs
			,scoreThreshold := scoreThreshold
			,weightThreshold := weightThreshold
			,disableSaltForce := not primForce
			,doAppend := doAppend
			,fromThor := false);

	shared remoteAppend := BIPV2.IdAppendRoxieRemote(
			inputDs
			,scoreThreshold := scoreThreshold
			,weightThreshold := weightThreshold
			,disableSaltForce := not primForce
			,doAppend := doAppend);

	export IdsOnly() := function
		#IF(BIPV2.IdConstants.USE_LOCAL_KEYS)
			res := project(localAppend, transform(BIPV2.IdAppendLayouts.IdsOnlyOutput, self := left, self := []));
		#ELSE
			res := project(remoteAppend.IdsOnly(), BIPV2.IdAppendLayouts.IdsOnlyOutput);
		#END
		return if(scoreThreshold > 50 or not doAppend or allowInvalidResults,
			res,
			error(recordof(res), 'score <= 50 can produce invalid id resolution'));
	end;

	export WithBest(string fetchLevel = BIPV2.IdConstants.fetch_level_proxid, boolean allBest = false) := function
		#IF(BIPV2.IdConstants.USE_LOCAL_KEYS)
			res0 := BIPV2.IdAppendLocal.AppendBest(localAppend, fetchLevel := fetchLevel, allBest := allBest);
			res := project(res0, transform(BIPV2.IdAppendLayouts.AppendOutput, self := left, self := []));
		#ELSE
			res := remoteAppend.WithBest(fetchLevel := fetchLevel, allBest := allBest);
		#END

		return if(scoreThreshold > 50 or not doAppend or allowInvalidResults,
			res,
			error(recordof(res), 'score <= 50 can produce invalid id resolution'));
	end;

	export WithRecords(string fetchLevel = BIPV2.IdConstants.fetch_level_proxid) := function
		#IF(BIPV2.IdConstants.USE_LOCAL_KEYS)
			res0 := BIPV2.IdAppendLocal.FetchRecords(localAppend, fetchLevel);
			res := project(res0, transform(BIPV2.IdAppendLayouts.AppendWithRecsOutput, self := left, self := []));	
			// return error(recordof(BIPV2.IdAppendLayouts.AppendOutput), 'Id Append WithRecords not implemented');
		#ELSE
			res := remoteAppend.WithRecs(fetchLevel := fetchLevel);
		#END
		return if(scoreThreshold > 50 or not doAppend or allowInvalidResults,
			res,
			error(recordof(res), 'score <= 50 can produce invalid id resolution'));
	end;

end;

