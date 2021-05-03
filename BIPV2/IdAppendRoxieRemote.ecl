import _Control;
import BIPV2;
import Doxie;

export IdAppendRoxieRemote(
		dataset(BIPV2.IdAppendLayouts.AppendInput) inputDs
		,unsigned scoreThreshold = 75
		,unsigned weightThreshold = IdConstants.APPEND_WEIGHT_THRESHOLD_ROXIE
		,boolean primForce = false
		,boolean reAppend = true
		,boolean primForcePost = false 
		,boolean useFuzzy = true
		,boolean doZipExpansion = false
		,string svcAppendUrl = ''
		,string svcName = ''
        ,unsigned soapTimeout = 30
        ,unsigned soapTimeLimit = 0
        ,unsigned soapRetries = 3
		,boolean segmentation = true
	) := module

	shared disableSaltForce := not primForce;
	shared defaultDataAccess := MODULE(doxie.IDataAccess) END;

	prodUrl := 'http://' + IdConstants.URL_ROXIE_PROD;
	inputUrl := if(svcAppendUrl[1..4] = 'http', svcAppendUrl, 'http://' + svcAppendUrl);
	shared urlBipAppend := if(svcAppendUrl = '', prodUrl, inputUrl);

	shared serviceName := if(svcName = '', 'bizlinkfull.svcappend', svcName);

	shared soapInput(boolean includeBest = false
			,string fetchLevel = ''
			,boolean allBest = false
			,boolean includeRecords = false
			,boolean isMarketing = false
			,boolean dnbFullRemove = false
			,Doxie.IDataAccess mod_access = defaultDataAccess) := function
		
		defaultPermissions := row({''}, IdAppendLayouts.permissions);

		soapDs := dataset(row(
			transform(IdAppendLayouts.SoapRequest,
				self.append_input := inputDs,
				self.re_append := reAppend,
				self.score_threshold := scoreThreshold,
				self.weight_threshold := weightThreshold,
				self.disable_salt_force := disableSaltForce,
				self.prim_force_post := primForcePost,
				self.use_fuzzy := useFuzzy,
				self.do_zip_expansion := doZipExpansion,
				self.from_thor := false,
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
				self := defaultPermissions,
			))
		);
		return soapDs;
	end;

	shared BIPV2.IDAppendLayouts.AppendOutputDebug setError(IdAppendLayouts.SoapRequest l) := transform
		self.error_code := FAILCODE;
		self.error_msg := FAILMESSAGE;
		self := L;
		self := [];
	end;


	shared IdsAndBest(boolean includeBest, string fetchLevel = BIPV2.IdConstants.fetch_level_proxid
	                  ,boolean allBest = false, boolean isMarketing = false
					  ,Doxie.IDataAccess mod_access = defaultDataAccess) := function
		soapInputDs := soapInput(includeBest := includeBest, fetchLevel := fetchLevel
		                         ,allBest := allBest, includeRecords := false
								 ,mod_access := mod_access);
		soapResult := soapcall(
			soapInputDs
			,urlBipAppend, servicename, {soapInputDs}
			,dataset(BIPV2.IDAppendLayouts.AppendOutputDebug)
			,xpath(servicename + 'Response/Results/Result/Dataset[1]/Row')
			,onfail(setError(left)), parallel(1)
			,merge(1), timeout(soapTimeout), timelimit(soapTimeLimit), retry(soapRetries)
		);

		// If soapcall fails, there will only be 1 record in soapresult so need to add error info to all records.
		soapError := soapResult(error_code != 0);
		withError := project(inputDs, transform(recordof(soapResult),
			self.request_id := left.request_id,
			self := soapError[1]
		));

		return if(exists(soapError), withError, soapResult);
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
		soapInputDs := soapInput(includeBest := false, includeRecords := true
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

		// If soapcall fails, there will only be 1 record in soapresult so need to add error info to all records.
		soapError := soapResult(error_code != 0);
		withError := project(inputDs, transform(recordof(soapResult),
			self.request_id := left.request_id,
			self := soapError[1],
		));

		return if(exists(soapError), withError, soapResult);
	end;

end;
