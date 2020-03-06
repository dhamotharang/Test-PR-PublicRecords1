import _Control;
import Doxie;

EXPORT IdAppendThorRemote(
		dataset(BIPV2.IdAppendLayouts.AppendInput) inputDs
		,unsigned scoreThreshold = 75
		,unsigned weightThreshold = 0
		,boolean disableSaltForce = true
		,boolean primForcePost = false // not being used
		,boolean useFuzzy = true
		,boolean doZipExpansion = true
		,boolean reAppend = true
		,boolean mimicRoxie = false // This is for ease of testing and can cause slower performance
		                            // on thor appends so should not be used for production.
		,string svcAppendUrl = ''
		,boolean segmentation = true
		,string svcName = ''
		,unsigned soapTimeout = 300
		,unsigned soapTimeLimit = 0
		,unsigned soapRetries = 0
		,unsigned remoteBatchSize = 100
		,unsigned retryBatchSize = 1
		,boolean allowHighErrorRate = false
	) := module

	shared defaultDataAccess := MODULE(doxie.IDataAccess) END;

	prodUrl := 'http://' + IdConstants.URL_ROXIETHOR_PROD;
	inputUrl := if(svcAppendUrl[1..4] = 'http', svcAppendUrl, 'http://' + svcAppendUrl);
	shared urlBipAppend := if(svcAppendUrl = '', prodUrl, inputUrl);

	shared serviceName := if(svcName = '', 'bizlinkfull.svcappend', svcName);

	shared soapInput(dataset(recordof(inputDs)) preSoapDs
			,unsigned soapBatchSize
			,boolean includeBest = false
			,string fetchLevel = ''
			,boolean allBest = false
			,boolean includeRecords = false
			,boolean isMarketing = false
			,boolean dnbFullRemove = false
			,Doxie.IDataAccess mod_access = defaultDataAccess) := function
		
		defaultPermissions := row({''}, IdAppendLayouts.permissions);

		input1Rec := project(preSoapDs, transform({IdAppendLayouts.SoapRequest, unsigned8 _soapcall_id},
			self._soapcall_id := counter div soapBatchSize;
			self.append_input := dataset(row(transform(left)));
			self.re_append := reAppend,
			self.score_threshold := scoreThreshold,
			self.weight_threshold := weightThreshold,
			self.disable_salt_force := disableSaltForce,
			self.prim_force_post := primForcePost,
			self.use_fuzzy := useFuzzy,
			self.do_zip_expansion := doZipExpansion,
			self.from_thor := not mimicRoxie,
			self.include_best := includeBest,
			self.fetch_level := fetchLevel,
			self.all_best := allBest,
			self.include_records := includeRecords,
			self.is_marketing := isMarketing,
			self.dnb_full_remove := dnbFullRemove,
			self.data_access_glb := mod_access.glb,
			self.data_access_dppa := mod_access.dppa,
			self.data_access_lexid_source_optout := mod_access.lexid_source_optout,
			self.do_segmentation := segmentation,
			self := defaultPermissions),
			LOCAL);

		inputBatch := rollup(input1Rec, left._soapcall_id = right._soapcall_id, transform(recordof(left),
			self.append_input := left.append_input + right.append_input,
			self := left),
			LOCAL);

		soapDs := project(inputBatch, IdAppendLayouts.SoapRequest);

		return soapDs;
	end;

	shared BIPV2.IDAppendLayouts.AppendOutput setError(IdAppendLayouts.SoapRequest l) := transform
		self.error_code := FAILCODE;
		self.error_msg := FAILMESSAGE;
		self := L;
		self := [];
	end;


	shared IdsAndBest(boolean includeBest, string fetchLevel = BIPV2.IdConstants.fetch_level_proxid
	                  ,boolean allBest = false, boolean isMarketing = false
					  ,Doxie.IDataAccess mod_access = defaultDataAccess) := function

		// ratio of 20 equates to 5%; 1000 => 0.1%
		RETRY_ERROR_RATIO := 20; // if more than 1 out of RETRY_ERROR_RATIO have errors,
		                         // then don't retry and just throw an error.
		OVERALL_ERROR_RATIO := 1000; // if more than 1 out of OVERALL_ERROR_RATIO have errors
		                             // even after retry, then throw an error.

		soapInputDs := soapInput(inputDs, soapBatchSize := remoteBatchSize
								 ,includeBest := includeBest, fetchLevel := fetchLevel
		                         ,allBest := allBest, includeRecords := false
								 ,mod_access := mod_access);

		soapAppend(dataset(recordof(soapInputDs)) soapIn) := soapcall(
			soapIn
			,urlBipAppend, servicename, {soapIn}
			,dataset(BIPV2.IDAppendLayouts.AppendOutput)
			,xpath(servicename + 'Response/Results/Result/Dataset[1]/Row')
			,onfail(setError(left)), parallel(1)
			,merge(1), timeout(soapTimeout), timelimit(soapTimeLimit), retry(soapRetries)
		);

		soapResult := soapAppend(soapInputDs);

		// Only using first error code/message. This isn't 100% correct, but should be good enough.
		soapSuccess := soapResult(error_code = 0);
		inputErrors := 
			join(inputDs, soapSuccess,
			left.request_id = right.request_id,
			transform(left), left only);

		// if small input, do retry even if errors exceed the retry threshold
		doRetry := exists(inputErrors) // avoid divide by zero issues
		           AND (allowHighErrorRate
		             OR ( (count(inputDs) / remoteBatchSize) < RETRY_ERROR_RATIO ) // small input
		             OR ( (count(inputDs) / count(inputErrors) ) > RETRY_ERROR_RATIO )); // not too many errors

		// distributing to spread out the soapcalls b/c the soapInput function keeps all 
		// records on the same nodes
		retrySoapIn := soapInput(distribute(inputErrors, random()), soapBatchSize := retryBatchSize
								 ,includeBest := includeBest, fetchLevel := fetchLevel
		                         ,allBest := allBest, includeRecords := false
								 ,mod_access := mod_access);

		retryResults := iff(doRetry, soapAppend(retrySoapIn), dataset([], recordof(soapResult)));
		retrySuccess := retryResults(error_code = 0);

		// This will be set properly even if retry doesn't run b/c retrySuccess would be empty in that case.
		inputRetryErrors := 
			join(inputErrors, retrySuccess,
			left.request_id = right.request_id,
			transform(left), left only);

		soapError :=
			if(exists(retryResults),
				retryResults(error_code != 0),
				soapResult(error_code != 0));

		withError := project(inputRetryErrors, transform(recordof(soapResult),
			self.request_id := left.request_id,
			self := soapError[1]
		));

		noError :=
			allowHighErrorRate
				OR  not exists(withError)
				OR (count(inputDs) / count(withError)) > OVERALL_ERROR_RATIO;

		// Throw error if failure rate is too high.
		return if(noError,
		          soapSuccess + retrySuccess + withError,
		          error(recordof(soapResult), 'BIP Append: too many errors: ' + soapError[1].error_msg));
	end;

	export IdsOnly() := IdsAndBest(includeBest := false);
	export WithBest(string fetchLevel = BIPV2.IdConstants.fetch_level_proxid
	                ,boolean allBest = false, boolean isMarketing = false
					,Doxie.IDataAccess mod_access = defaultDataAccess)
		:= IdsAndBest(includeBest := true, fetchLevel := fetchLevel, allBest := allBest
		              ,isMarketing := isMarketing, mod_access := mod_access);

	shared BIPV2.IDAppendLayouts.AppendWithRecsOutput setErrorRecs(IdAppendLayouts.SoapRequest l) := transform
		self.error_code := FAILCODE;
		self.error_msg := FAILMESSAGE;
		self := L;
		self := [];
	end;

	export WithRecords(string fetchLevel = BIPV2.IdConstants.fetch_level_proxid
	                   ,boolean dnbFullRemove = false
					   ,Doxie.IDataAccess mod_access = defaultDataAccess) := function
		soapInputDs := soapInput(inputDs, soapBatchSize := remoteBatchSize
								 ,includeBest := false, includeRecords := true
		                         ,fetchLevel := fetchLevel, dnbFullRemove := dnbFullRemove
								 ,mod_access := mod_access);
		soapResult := soapcall(
			soapInputDs
			,urlBipAppend, servicename, {soapInputDs}
			,dataset(BIPV2.IDAppendLayouts.AppendWithRecsOutput)
			,xpath(servicename + 'Response/Results/Result/Dataset[2]/Row')
			,onfail(setErrorRecs(left)), parallel(1)
			,merge(1), timeout(soapTimeout), timelimit(soapTimeLimit), retry(soapRetries)
		);

		// Only using first error code/message. This isn't 100% correct, but should be good enough.
		soapSuccess := soapResult(error_code = 0);
		inputErrors := 
			join(inputDs, soapSuccess,
			left.request_id = right.request_id,
			transform(left), left only);
		soapError := soapResult(error_code != 0);
		withError := project(inputErrors, transform(recordof(soapResult),
			self.request_id := left.request_id,
			self := soapError[1]
		));

		return soapSuccess + withError;

	end;

end;
