﻿import BIPV2;

export IdAppendThor(
		dataset(BIPV2.IdAppendLayouts.AppendInput) inputDs
		,unsigned scoreThreshold = 75
		,unsigned weightThreshold = IdConstants.APPEND_WEIGHT_THRESHOLD_THOR
		,boolean primForce = false
		,boolean reAppend = true
		,boolean allowInvalidResults = false
		,boolean mimicRoxie = false // This is for ease of testing and can cause slower performance
		                            // on thor appends so should not be used for production.
		,string svcAppendUrl = ''
		,boolean useFuzzy = false
		,boolean doZipExpansion = false
		,boolean segmentation = true
		,unsigned soapTimeout = 300
		,unsigned soapTimeLimit = 0
		,unsigned soapRetries = 0
		,unsigned remoteBatchSize = 100
		,boolean allowHighErrorRate = false
		,unsigned keepCount = 1
	) := module

	#IF(BIPV2.IdConstants.USE_LOCAL_KEYS or BIPV2.IdConstants.USE_LOCAL_THOR_SALT_KEYS)
	shared localAppend := BIPV2.IdAppendThorLocal(
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
		,BIPV2.IdAppendLayouts.IdsOnlyDebug // outrec
		,true // bool_outrec_has_score
		,BDID_Score_field
		,keepCount //keep_count := '1'
		,scoreThreshold //score_threshold := '75'
		,url // pURL = ''
		,email // pEmail = ''
		,city // pCity = ''
		,contact_fname // pContact_fname = ''
		,contact_mname // pContact_mname = ''
		,contact_lname // pContact_lname = ''
		,contact_ssn // pContact_ssn = ''
		,source // pSource = ''
		,source_record_id // pSource_record_id = ''
		,useFuzzy := useFuzzy
		,weightThreshold := weightThreshold
		,disableSaltForce := not primForce
		,segmentation := segmentation
		,reAppend := reAppend
	);
	#END

	shared remoteAppend := BIPV2.IdAppendThorRemote(
			inputDs
			,scoreThreshold := scoreThreshold
			,weightThreshold := weightThreshold
			,disableSaltForce := not primForce
			,useFuzzy := useFuzzy
			,doZipExpansion := doZipExpansion
			,reAppend := reAppend
			,mimicRoxie := mimicRoxie
			,svcAppendUrl := svcAppendUrl
			,segmentation := segmentation
			,soapTimeout := soapTimeout
			,soapTimeLimit := soapTimeLimit
			,soapRetries := soapRetries
			,remoteBatchSize := remoteBatchSize
			,allowHighErrorRate := allowHighErrorRate
			);

	shared remoteNoIds(dataset(BIPV2.IdAppendLayouts.AppendInput) remoteIn) := 
		BIPV2.IdAppendThorRemote(
			remoteIn
			,scoreThreshold := scoreThreshold
			,weightThreshold := weightThreshold
			,disableSaltForce := not primForce
			,useFuzzy := useFuzzy
			,doZipExpansion := doZipExpansion
			,reAppend := false
			,mimicRoxie := mimicRoxie
			,svcAppendUrl := svcAppendUrl
			,segmentation := segmentation
			,soapTimeout := soapTimeout
			,soapTimeLimit := soapTimeLimit
			,soapRetries := soapRetries
			,remoteBatchSize := remoteBatchSize
			,allowHighErrorRate := allowHighErrorRate
			);

	export IdsOnly() := function
		resRemote := project(remoteAppend.IdsOnly(), BIPV2.IdAppendLayouts.IdsOnlyOutput);
		#IF(BIPV2.IdConstants.USE_LOCAL_KEYS or BIPV2.IdConstants.USE_LOCAL_THOR_SALT_KEYS)
			resLocal := project(localAppend, transform(BIPV2.IdAppendLayouts.IdsOnlyOutput, self := left, self := []));
			res := if(mimicRoxie, resRemote, resLocal);
		#ELSE
			res := if(keepCount = 1, resRemote, error(recordof(resRemote), 'keepCount > 1 not implemented for remote BIP append'));
		#END

		return if(scoreThreshold > 50 or allowInvalidResults,
			res,
			error(recordof(res), 'score <= 50 can produce invalid id resolution'));
	end;

	export WithBest(string fetchLevel = BIPV2.IdConstants.fetch_level_proxid, boolean allBest = false) := function
		resRemote := remoteAppend.WithBest(fetchLevel := fetchLevel, allBest := allBest);
		#IF(BIPV2.IdConstants.USE_LOCAL_KEYS or (BIPV2.IdConstants.USE_LOCAL_THOR_BEST_KEYS and BIPV2.IdConstants.USE_LOCAL_THOR_SALT_KEYS))
			res0 := BIPV2.IdAppendLocal.AppendBest(localAppend, fetchLevel := fetchLevel, allBest := allBest);
			resLocal := project(res0, transform(BIPV2.IdAppendLayouts.AppendOutput, self := left, self := []));
			res := if(mimicRoxie, resRemote, resLocal);
		#ELSE
			res := if(keepCount = 1, resRemote, error(recordof(resRemote), 'keepCount > 1 not implemented for remote BIP append'));
		#END

		return if(scoreThreshold > 50 or allowInvalidResults,
			res,
			error(recordof(res), 'score <= 50 can produce invalid id resolution'));
	end;

	export WithRecords(string fetchLevel = BIPV2.IdConstants.fetch_level_proxid) := function
		resRemote := remoteAppend.WithRecords(fetchLevel := fetchLevel);
		#IF(BIPV2.IdConstants.USE_LOCAL_KEYS)
			res0 := BIPV2.IdAppendLocal.FetchRecords(localAppend, fetchLevel);
			resLocal := project(res0, transform(BIPV2.IdAppendLayouts.AppendWithRecsOutput, self := left, self := []));	
			res := resLocal;
		#ELSE
			res := if(keepCount = 1, resRemote, error(recordof(resRemote), 'keepCount > 1 not implemented for remote BIP append'));
		#END

		return if(scoreThreshold > 50 or allowInvalidResults,
			res,
			error(recordof(res), 'score <= 50 can produce invalid id resolution'));
	end;

end;

