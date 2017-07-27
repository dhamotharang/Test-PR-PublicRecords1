/*2016-01-25T10:42:44Z (Mark Rhodes_prod)
Code refactoring for HMS integration
*/
import doxie,iesp,Healthcare_Shared,Gateway;
EXPORT Raw := module
	Healthcare_Shared.Layouts.common_runtime_config buildRunTimeConfig():=transform
		self.cfg_Version := 1;
		//self:=[];DO NOT Uncomment at if you do so you will kill all the default values.
	end;
	Export RunTimeConfig:=dataset([buildRunTimeConfig()]);
	Export Gateways := Gateway.Configuration.Get();
	
	Export getRecordsIndividualCommon (dataset(Healthcare_Shared.Layouts.userInputCleanMatch) CommonizedInput, dataset(Healthcare_Shared.Layouts.common_runtime_config) cfg = RunTimeConfig) := function
		// getFailedInputRecs = Isolate records from header with a failed error message Id.
		providerRecords := Healthcare_Shared.getCandidateRecords.getProviderRecords(CommonizedInput);
		getFailedInputRecs := Project(providerRecords(ValidInputs.hasValidationError),transform(Healthcare_Shared.Layouts.CombinedHeaderResultsDoxieLayout,
																	self.acctno := left.acctno;
																	self.ProcessingMessage := left.ValidInputs.ErrorID;
																	self.userinput := left;
																	self:=[];));
		getCandidates := Healthcare_Shared.getCandidateRecords.getCandidatesbyCommonized(providerRecords(Not ValidInputs.hasValidationError),cfg);
		// getGoldenRecords = Commonized grouped and filtered header candidates and ran through the RulesManager processes & threshold filtered?
		getGoldenRecords := Healthcare_Shared.getGoldenRecord.getProviderRecordsOnly(getCandidates(srcIndividualHeader),providerRecords,cfg);
		// filteredGoldenRecs = record penalty > 3 filtered to detect too many records found in header for select criteria
		filteredGoldenRecs := Project(getGoldenRecords,transform(Healthcare_Shared.Layouts.CombinedHeaderResultsDoxieLayout,
														beMoreRestrictiveFailedSearch := left.ProcessingMessage = 203 and left.record_penalty>3;//Too many Records Found
														self.acctno := if(beMoreRestrictiveFailedSearch,skip,left.acctno);
														self := left;));
		// RemovedHits = Left only - Records that are in filteredGoldRecs but had too many hits - processingMessage = 203 
		RemovedHits := Join(getGoldenRecords,filteredGoldenRecs,left.acctno=right.acctno,transform(Healthcare_Shared.Layouts.CombinedHeaderResultsDoxieLayout,
											self.acctno := left.acctno;
											self.ProcessingMessage := 203;//Too many Records Found none that were nearly an exact match
											self.userinput := left.userinput;
											self:=[];),left only);
		// In finalGoldenRecs the order is established -  1st records with a legit number of hits + those recs with too many hits + failed error hit records									
		finalGoldenRecs := filteredGoldenRecs+RemovedHits+getFailedInputRecs;
		//Do Individual DeepDive =  Only Deep Dive for records that have no input errors and no error message id and not too many hits.
		NoHitsforIndivDeepDive := join(providerRecords(Not ValidInputs.hasValidationError),getCandidates(not issearchfailed and not returnThresholdExceeded),
																		left.acctno=right.acctno,transform(left), left only);

		serviceURL := gateways(Gateway.Configuration.IsNeutralRoxie(Gateway.Constants.ServiceName.NeutralRoxie))[1].URL;
		serviceURL194 := 'http://10.239.194.100:9876/';
		integer waittime := 300;  // 0 is wait forever, default if ommitted is 300 (s)
		integer retries	:= 0;     // 0 DEFAULT
		doSoapCall := (cfg[1].doDeepDive or cfg[1].IncludeAlsoFound) and exists(NoHitsforIndivDeepDive);  //includeAlso found or deep dive on and there are no hit records
		getIndividualsDeepDive := if(doSoapCall,soapcall(NoHitsforIndivDeepDive, 
					if(serviceURL<>'',serviceURL,serviceURL194),
					Healthcare_Shared.Constants.IndvDeepDiveServiceName, 
					{NoHitsforIndivDeepDive},
					dataset(Healthcare_Shared.Layouts.CombinedHeaderResultsDoxieLayout),
					Heading('<individualpublicrecordssearch><row>','</row></individualpublicrecordssearch>'),
					timeout(waittime),retry(retries)),dataset([],Healthcare_Shared.Layouts.CombinedHeaderResultsDoxieLayout));
		// keepGoldenRecordsWithoutDeepDiveHits = left only  - records that do not match, records from Header in FinalGoldenRecs not matching Deep Dive results
		keepGoldenRecordsWithoutDeepDiveHits := join(finalGoldenRecs,getIndividualsDeepDive,left.acctno=right.acctno,transform(left),left only);
				
		NoHitsforDeath := join(providerRecords(Not ValidInputs.hasValidationError),keepGoldenRecordsWithoutDeepDiveHits,
																		left.acctno=right.acctno,transform(left),left only);
		NoHitDeath:= project(NoHitsforDeath,transform(Healthcare_Shared.Layouts.layout_death,
				                   self.acctno:=left.acctno;
													 self.ui_fname:=left.name_first;
                           self.ui_mname:=left.name_middle;
                           self.ui_lname:=left.name_last;
													 self.ui_SSN:=if(left.SSN<>'',left.SSN,skip);
													 self.ui_TaxID:=left.TAXID;));
    NoHit4Death := project(NoHitsforDeath, transform(Healthcare_Shared.Layouts.CombinedHeaderResults, self.userinput:=left;self:=left;self:=[]));
		
		// If there is a records in NoHit4Death then it will look in DMF - otherwise the appendDeath just falls through.
		
		NoHitsAppendDeath := Healthcare_Shared.Functions_Death.appendDeath(NoHitDeath,NoHit4Death,cfg);
		
		// NoHitDeathandFlags =  If it ran through appendDeath a DMF match for ssn is found , it has the D status.
    NoHitWDeathandFlags := Join(NoHitsAppendDeath,getIndividualsDeepDive,left.acctno=right.acctno,transform(Healthcare_Shared.Layouts.CombinedHeaderResultsDoxieLayout,
																						self.acctno := left.acctno;
																						self.Status := if(exists(left.dods),'D','N');
                                            self.UStat.provider_ustat := if(exists(left.dods),HealthCare_Shared.Constants.ustat_Provider_Confirm_Deceased,0);
                                            self.UStat.dos_ustat := if(exists(left.dods),HealthCare_Shared.Constants.stat_Deceased_BridgedToDeathMasterViaSSN,0);
                                            self.UStat.death_provider_ustat := if(exists(left.dods),HealthCare_Shared.Constants.ustat_Provider_Confirm_Deceased,0);
																						self.userinput:=left.userinput;
																						self.dods:=left.dods;
                                            self.CIC.provider_cic := if(exists(left.dods),'D','');
																						self:=right;
																						self:=left),left outer,keep(Healthcare_Shared.Constants.MAX_RECS_ON_JOIN), limit(0));
		// If records in Deep Dive and a DMF match for a no hit is found - get only records excluding (left only) those from the DMF search.																	
		deepDiveRecWithoutDeath := Join(getIndividualsDeepDive,NoHitWDeathandFlags,left.acctno=right.acctno,transform(left),left only);
		
		// All records from Header (no deep dive)  +  any DMF search records + deepDive records not matching DMF search records found.
		collectedIndividuals := keepGoldenRecordsWithoutDeepDiveHits+NoHitWDeathandFlags+deepDiveRecWithoutDeath;
				
		NoHitsStill := join(NoHit4Death,collectedIndividuals,left.acctno=right.acctno,
																		transform(Healthcare_Shared.Layouts.CombinedHeaderResultsDoxieLayout,self:=left;self:=[]),
																		left only);
		// Force DMF hit (processingMessage = 0) to the top over the NoHits record (processingMessage = 203)
		// record_penalty_enhaced = match_confidence
		FinalRecs := sort(dedup(sort(collectedIndividuals,record),record)+NoHitsStill,acctno,-record_penalty_enhanced, record_penalty);
		// output(CommonizedInput,Named('getRecordsIndividualCommon_CommonizedInput'),extend);
		// output(providerRecords,Named('getRecordsIndividualCommon_providerRecords'),extend);
		// output(getFailedInputRecs,Named('getRecordsIndividualCommon_getFailedInputRecs'),extend);
		// output(getGoldenRecords,Named('getRecordsIndividualCommon_getGoldenRecords'),extend);
		// output(filteredGoldenRecs,Named('getRecordsIndividualCommon_filteredGoldenRecs'),extend);
		// output(RemovedHits,Named('getRecordsIndividualCommon_RemovedHits'),extend);
		// output(getCandidates(not issearchfailed and not returnThresholdExceeded),Named('getRecordsIndividualCommon_getCandidates'),extend);
		// output(finalGoldenRecs,Named('getRecordsIndividualCommon_finalGoldenRecs'),extend);
		// output(CommonizedInput(Not ValidInputs.hasValidationError),Named('getRecordsIndividualCommon_CommonizedInput'),extend);
		// output(NoHitsforIndivDeepDive,Named('getRecordsIndividualCommon_NoHitsforIndivDeepDive'),extend);
		// output(doSoapCall,Named('getRecordsIndividualCommon_doSoapCall'),overwrite);
		// output(getIndividualsDeepDive,Named('getRecordsIndividualCommon_getIndividualsDeepDive'),extend);
		// output(keepGoldenRecordsWithoutDeepDiveHits,Named('getRecordsIndividualCommon_keepGoldenRecordsWithoutDeepDiveHits'),extend);
		// output(NoHitsforDeath,Named('getRecordsIndividualCommon_NoHitsforDeath'),extend);
		// output(NoHitDeath,Named('getRecordsIndividualCommon_NoHitDeath'),extend);
		// output(NoHit4Death,Named('getRecordsIndividualCommon_NoHit4Death'),extend);
		// output(NoHitsAppendDeath,Named('getRecordsIndividualCommon_NoHitsAppendDeath'),extend);
		// output(NoHitWDeathandFlags,Named('getRecordsIndividualCommon_NoHitWDeathandFlags'),extend);
		// output(deepDiveRecWithoutDeath,Named('getRecordsIndividualCommon_deepDiveRecWithoutDeath'),extend);
		// output(collectedIndividuals,Named('getRecordsIndividualCommon_collectedIndividuals'),extend);
		// output(NoHitsStill,Named('getRecordsIndividualCommon_NoHitsStill'),extend);
		// output(FinalRecs,Named('getRecordsIndividualCommon_getRecordsIndividualCommon_FinalRecs'),extend);
		return finalRecs;
	end;
	Export getRecordsIndividual (dataset(Healthcare_Shared.Layouts.autokeyInput) inputraw, dataset(Healthcare_Shared.Layouts.common_runtime_config) cfg = RunTimeConfig) := function
		getCommonInput := Healthcare_Shared.getCandidateRecords.getCommonizedInput(inputraw,,,cfg);
		finalRecs := getRecordsIndividualCommon(getCommonInput,cfg);
		// output(getCommonInput, Named('getRecordsIndividual_getCommonInput'),extend);
		// output(finalRecs, Named('getRecordsIndividual_finalRecs'),extend);
		return finalRecs;
	end;
	Export getRecordsBusinessCommon (dataset(Healthcare_Shared.Layouts.userInputCleanMatch) CommonizedInput, dataset(Healthcare_Shared.Layouts.common_runtime_config) cfg = RunTimeConfig) := function
		facilityRecords := Healthcare_Shared.getCandidateRecords.getFacilitiesRecords(CommonizedInput);
		getFailedInputRecs := Project(facilityRecords(ValidInputs.hasValidationError),transform(Healthcare_Shared.Layouts.CombinedHeaderResultsDoxieLayout,
																	self.acctno := left.acctno;
																	self.ProcessingMessage := left.ValidInputs.ErrorID;
																	self.userinput := left;
																	self:=[];));
		getCandidates := Healthcare_Shared.getCandidateRecords.getCandidatesbyCommonized(facilityRecords(Not ValidInputs.hasValidationError),cfg);
		getGoldenRecords := Healthcare_Shared.getGoldenRecord.getFacilityRecordsOnly(getCandidates(srcBusinessHeader),facilityRecords,cfg);
		filteredGoldenRecs := Project(getGoldenRecords,transform(Healthcare_Shared.Layouts.CombinedHeaderResultsDoxieLayout,
														beMoreRestrictiveFailedSearch := left.ProcessingMessage = 203 and left.record_penalty>3;//Too many Records Found
														self.acctno := if(beMoreRestrictiveFailedSearch,skip,left.acctno);
														self := left;));
		RemovedHits := Join(getGoldenRecords,filteredGoldenRecs,left.acctno=right.acctno,transform(Healthcare_Shared.Layouts.CombinedHeaderResultsDoxieLayout,
											self.acctno := left.acctno;
											self.ProcessingMessage := 203;//Too many Records Found none that were nearly an exact match
											self.userinput := left.userinput;
											self:=[];),left only);
		finalGoldenRecs := filteredGoldenRecs+RemovedHits+getFailedInputRecs;
		//Do Business DeepDive
		NoHitsforBusDeepDive := join(facilityRecords(Not ValidInputs.hasValidationError),getCandidates(issearchfailed and not returnThresholdExceeded),
																		left.acctno=right.acctno,transform(left),keep(Healthcare_Shared.Constants.MAX_RECS_ON_JOIN), limit(0));
		serviceURL := gateways(Gateway.Configuration.IsNeutralRoxie(Gateway.Constants.ServiceName.NeutralRoxie))[1].URL;
		serviceURL194 := 'http://10.239.194.100:9876/';
		integer waittime := 300;  // 0 is wait forever, default if ommitted is 300 (s)
		integer retries	:= 0;     // 0 DEFAULT
		doSoapCall := (cfg[1].doDeepDive or cfg[1].IncludeAlsoFound) and exists(NoHitsforBusDeepDive);
		getBusinessDeepDive := if(doSoapCall,soapcall(NoHitsforBusDeepDive, 
					if(serviceURL<>'',serviceURL,serviceURL194),
					Healthcare_Shared.Constants.BusDeepDiveServiceName, 
					{NoHitsforBusDeepDive},
					dataset(Healthcare_Shared.Layouts.CombinedHeaderResultsDoxieLayout),
					Heading('<facilitypublicrecordssearch><row>','</row></facilitypublicrecordssearch>'),
					timeout(waittime),retry(retries)),dataset([],Healthcare_Shared.Layouts.CombinedHeaderResultsDoxieLayout));
		collectedBusinesses := finalGoldenRecs+getBusinessDeepDive;
		NoHits := Join(NoHitsforBusDeepDive,collectedBusinesses,left.acctno=right.acctno,transform(Healthcare_Shared.Layouts.CombinedHeaderResultsDoxieLayout,
											self.acctno := left.acctno;
											self.ProcessingMessage := 10;//'No records found'
											self.userinput := left;
											self:=[];),left only);
		CombinedRecords := collectedBusinesses+NoHits;
		FinalRecs := sort(CombinedRecords,acctno,record_penalty);
		// output(getGoldenRecords,named('getGoldenRecords'),extend);
		// output(finalGoldenRecs,named('finalGoldenRecs'),extend);
		// output(collectedBusinesses,named('collectedBusinesses'),extend);
		// output(CombinedRecords,named('CombinedRecords'),extend);
		// output(FinalRecs,named('FinalRecs'),extend);
		return finalRecs;
	end;
	Export getRecordsBusiness (dataset(Healthcare_Shared.Layouts.autokeyInput) inputraw, dataset(Healthcare_Shared.Layouts.common_runtime_config) cfg = RunTimeConfig) := function
		getCommonInput := Healthcare_Shared.getCandidateRecords.getCommonizedInput(inputraw);
		FinalRecs := getRecordsBusinessCommon(getCommonInput,cfg);
		return finalRecs;
	end;
	Export getRecordsRaw (dataset(Healthcare_Shared.Layouts.autokeyInput) input, dataset(Healthcare_Shared.Layouts.common_runtime_config) cfg = RunTimeConfig) := function
		indiv := getRecordsIndividual(input,cfg);
		bus := getRecordsBusiness(input,cfg);
		finalRecs := sort(indiv+bus,acctno,record_penalty);
		// output (indiv,Named('indiv'),extend);
		// output (bus,Named('bus'),extend);
		// output (finalRecs,Named('raw_finalRecs'),extend);
		return finalRecs;
	end;
	Export getRecordsRawDoxiebyDid (dataset(doxie.layout_references) input, dataset(Healthcare_Shared.Layouts.common_runtime_config) cfg = RunTimeConfig) := function
		getCommonInput := Healthcare_Shared.getCandidateRecords.getCommonizedInput(,input);
		finalRecs := getRecordsIndividualCommon(getCommonInput,cfg);
		return finalRecs;
	end;

	Export getRecordsRawDoxiebyBDid (dataset(doxie.layout_ref_bdid) input, dataset(Healthcare_Shared.Layouts.common_runtime_config) cfg = RunTimeConfig) := function
		getCommonInput := Healthcare_Shared.getCandidateRecords.getCommonizedInput(,,input);
		finalRecs := getRecordsBusinessCommon(getCommonInput,cfg);
		return finalRecs;
	end;

	Export getRecordsRawDoxieIndividual (dataset(Healthcare_Shared.Layouts.autokeyInput) input, dataset(Healthcare_Shared.Layouts.common_runtime_config) cfg = RunTimeConfig) := function
		finalRecs := getRecordsIndividual(input,cfg);
		return finalRecs;
	end;

	Export getRecordsRawDoxieBusiness (dataset(Healthcare_Shared.Layouts.autokeyInput) input, dataset(Healthcare_Shared.Layouts.common_runtime_config) cfg = RunTimeConfig) := function
		finalRecs := getRecordsBusiness(input,cfg);
		return finalRecs;
	end;

	Export getRecordsRawDoxieBusinessLegacy (dataset(Healthcare_Shared.Layouts.autokeyInput) input, dataset(Healthcare_Shared.Layouts.common_runtime_config) cfg = RunTimeConfig) := function
		finalRecs := getRecordsBusiness(input,cfg);
		return finalRecs;
	end;

	Export getRecordsRawDoxie (dataset(Healthcare_Shared.Layouts.autokeyInput) input, dataset(Healthcare_Shared.Layouts.common_runtime_config) cfg = RunTimeConfig) := function 
		dupFree:=dedup(sort(input,record, except acctno),record, except acctno);
		rawRecs := getRecordsRaw(dupFree, cfg);
		// output(rawRecs,named('rawRecs'),overwrite);
		//GetDup Entires and add them back
		findDups := group(sort(input,record, except acctno),record, except acctno);
		Healthcare_Shared.Layouts.rawDupRec flagit(Healthcare_Shared.Layouts.autokeyInput l, dataset(Healthcare_Shared.Layouts.autokeyInput) allRows) := transform
						self.dupAcctno := project(allRows(Acctno<>l.Acctno),transform(Healthcare_Shared.Layouts.rawkeyRec,self:=left));
						self:=l;
		End; 
		rolledDups:=rollup(findDups,group,flagit(left,rows(left)));
		normDups:=normalize(rolledDups,left.dupAcctno,transform(Healthcare_Shared.Layouts.rawNormRec,self.dupAcctno := right.acctno, self:=left;));
		processDups := join(normDups,rawRecs,left.acctno=right.acctno,transform(Healthcare_Shared.Layouts.CombinedHeaderResultsDoxieLayout,self.acctno:=left.dupAcctno;self:=right),keep(Healthcare_Shared.Constants.MAX_RECS_ON_JOIN), limit(0));
		reCombineAndSort:=sort(rawRecs+processDups,Acctno,record_penalty);
		// output(input,Named('getRecordsRawDoxie'),extend);
		// output(rawRecs,Named('ServicerawRecs'),extend);
		// output(dupFree,Named('ServiceDupFree'),extend);
		// output(findDups,Named('ServiceFindDups'),extend);
		// output(rolledDups,Named('ServiceRolledDups'),extend);
		// output(normDups,Named('ServiceNormDups'),extend);
		// output(processDups,Named('ServiceProcessDups'),extend);
		// output(reCombineAndSort,Named('ServiceReCombineAndSort'),extend);
		return reCombineAndSort;
	end;
	Export fmtRecordsLegacyReport (dataset(Healthcare_Shared.Layouts.CombinedHeaderResultsDoxieLayout) rawRecs,dataset(Healthcare_Shared.Layouts.common_runtime_config) cfg = RunTimeConfig) := function
		return project(rawRecs,Healthcare_Shared.Transforms.fmtLegacyRpt(left,cfg));
	end;
	// Export fmtRecordsLegacyReportWithVerifications (dataset(Healthcare_Shared.Layouts.CombinedHeaderResultsDoxieLayout) rawRecs,dataset(Healthcare_Shared.Layouts.common_runtime_config) cfg = RunTimeConfig) := function
		// return project(rawRecs,Healthcare_Shared.Transforms.fmtLegacyRptWithVerifications(left,cfg));
	// end;
	// Export getRecords (dataset(Healthcare_Shared.Layouts.autokeyInput) input, dataset(Healthcare_Shared.Layouts.common_runtime_config) cfg = RunTimeConfig) := function
		// raw := getRecordsRawDoxie(input, cfg);
		// fmtRec := fmtRecordsLegacyReportWithVerifications(raw,cfg);
		// return fmtRec;
	// end;
	Export getReportServiceDidValues (dataset(Healthcare_Shared.Layouts.autokeyInput) input, dataset(Healthcare_Shared.Layouts.common_runtime_config) cfg = RunTimeConfig) := function
		provRec:=sort(dedup(sort(getRecordsRaw(input, cfg),acctno, LNPID),record),record_penalty);
		return provRec;
	end;
	Export getReportServiceRecords (dataset(Healthcare_Shared.Layouts.autokeyInput) input, dataset(Healthcare_Shared.Layouts.common_runtime_config) cfg = RunTimeConfig) := function
		return getRecordsRaw(input, cfg);
	end;
	Export fmtRecordsSearch (dataset(Healthcare_Shared.Layouts.CombinedHeaderResults) rawRecs) := function
		return project(rawRecs,Healthcare_Shared.Transforms.fmtLegacySearch(left));
	end;

End;