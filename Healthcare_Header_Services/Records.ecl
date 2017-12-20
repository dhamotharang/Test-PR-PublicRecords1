import doxie,iesp,ut,AutoStandardI,Address,Ingenix_NatlProf,Healthcare_Services;
EXPORT Records := module
	Layouts.common_runtime_config buildRunTimeConfig():=transform
		self.cfg_Version := 1;
		//self:=[];DO NOT Uncomment at if you do so you will kill all the default values.
	end;
	Shared RunTimeConfig:=dataset([buildRunTimeConfig()]);
	Shared getRecordsRawByDid (dataset(doxie.layout_references) input,dataset(Layouts.common_runtime_config) cfg = RunTimeConfig) := function
		getLNPIDs := Header_Records_SearchKeys(,cfg,input,true).getHdrLNPids;
		getIndividuals := Header_Records_Data.getRecords(getLNPIDs,cfg);
		//Final Records processing
		mergedRecs := sort(getIndividuals,acctno,lnpid);
		groupedRecs := group(mergedRecs, acctno, lnpid);
		rolledRecs := rollup(groupedRecs, group, Transforms.doFinalRollup(left,rows(left)));			
		finalRecs := rolledRecs;// No penalty needed on did based searches Functions.doPenalty(rolledRecs,input,maxPenalty);
		return finalRecs;
	end;
	Shared getRecordsRawByBDid (dataset(doxie.layout_ref_bdid) input,dataset(Layouts.common_runtime_config) cfg = RunTimeConfig) := function
		getLNPIDs := Header_Records_SearchBusKey(,cfg,input,true).getHdrLNPids;
		getBusiness := Header_Records_Data.getRecords(getLNPIDs,cfg);
		//Final Records processing
		mergedRecs := sort(getBusiness,acctno,lnpid);
		groupedRecs := group(mergedRecs, acctno, lnpid);
		rolledRecs := rollup(groupedRecs, group, Transforms.doFinalRollup(left,rows(left)));			
		finalRecs := rolledRecs;// No penalty needed on did based searches Functions.doPenalty(rolledRecs,input,maxPenalty);
		return finalRecs;
	end;
	Export layouts.CombinedHeaderResults buildFailureRecord (Layouts.searchKeyResults_plus_input l) := transform
			self.acctno:=l.acctno;
			self.isSearchFailed := l.isSearchFailed;
			self.keysfailed_decode := l.keysfailed_decode;
			self.ProcessingMessage := 203;
			self:=l;
			self:=[];
	end;
	Export getRecordsIndividual (dataset(Layouts.autokeyInput) input, dataset(Layouts.common_runtime_config) cfg = RunTimeConfig) := function
		ReEntryRecords := input(ProviderSrc <> '' and ProviderID > 0);//These are records that are coming back into the code from a result list
		SearchInputRecords := join(input,ReEntryRecords,left.acctno = right.acctno,transform(Layouts.autokeyInput,self:=left;),left only);//Contains input criteria
		ReEntryHeaderRecords := ReEntryRecords(ProviderSrc = Constants.SRC_HEADER);//These are records that are coming back into the code from a result list that originated from the header
		ReEntrySanctionRecords := ReEntryRecords(ProviderSrc = Constants.SRC_SANC);//These are records that are coming back into the code from a result list and are from Business Enclarity or Business NPPES
		ReEntryGSASanctionRecords := ReEntryRecords(ProviderSrc = Constants.SRC_GSA_SANC);//These are records that are coming back into the code from a result list and are from GSA -  entered sanctionId
		IndividualRecords := SearchInputRecords+ReEntryHeaderRecords;//The reentry records could be Individual
		getLNPIDs := Header_Records_SearchKeys(IndividualRecords,cfg).getHdrLNPids;
		DidNotReturn := project(join(IndividualRecords,getLNPIDs,left.acctno=right.acctno,transform(left),left only),transform(Layouts.searchKeyResults_plus_input,self.isSearchFailed:=true;self:=left));;
		//Separate Header good hits and failures 
		failedSearches := project(getLNPIDs(isSearchFailed=true)+DidNotReturn,buildFailureRecord(left));  // mainly adds 203 to the ProcessingMessage of the record
		goodSearches := getLNPIDs(isSearchFailed=false);
		
		//Use goodsearchs hits for finalIndividuals merge and rollup
		getIndividuals := Header_Records_Data.getRecords(goodSearches,cfg);
		mergedIndividuals := sort(getIndividuals,acctno,lnpid);
		groupedIndividuals := group(mergedIndividuals, acctno, if(exists(ReEntrySanctionRecords),(integer)acctno,lnpid),(integer)src);
		rolledIndividuals := rollup(groupedIndividuals, group, Transforms.doFinalRollup(left,rows(left)));
		DistinctInputRecsbyAcctno := dedup(sort(input,acctno),acctno);
		finalIndividuals := Functions.doPenalty(rolledIndividuals,DistinctInputRecsbyAcctno,cfg[1].penalty_threshold);
	
		//Look in GSA file as well for sanctions
		getGSASanctionsHits :=  Functions.doPenalty(Healthcare_Header_Services.DataSource_GSA.get_GSA_by_autokeys(IndividualRecords,cfg),DistinctInputRecsbyAcctno,cfg[1].penalty_threshold);
		getGSASanctionsHitsHighConf :=  getGSASanctionsHits(record_penalty<=3);
		
		//Isolate in NoHitsforIndivDeepDive all of the search failed  and low confidence GSA Sanction hits to search for them with deep dive
 		NoHitsforIndivDeepDive :=join (IndividualRecords,finalIndividuals+getGSASanctionsHitsHighConf,left.acctno=right.acctno,transform(left),left only);
    
		//Do Individual DeepDive-  getIndividualsDeepDive is the set result of hits from the Deep Dive.
		getIndividualsDeepDive := Datasource_Boca_Header.get_boca_header_entity(NoHitsforIndivDeepDive(cfg[1].doDeepDive or cfg[1].IncludeAlsoFound));
		
		//Limit GSA to a higher penalty when Header or deep dive records exist
		getGSASanctionsWithoutMatch:=join(getGSASanctionsHits,finalIndividuals+getIndividualsDeepDive,left.acctno=right.acctno,transform(left),left only);
		getGSASanctionsWithMatchMoreBMoreRestrictive:=join(getGSASanctionsHits,finalIndividuals+getIndividualsDeepDive,left.acctno=right.acctno and left.record_penalty<=3,transform(left),keep(Constants.MAX_SEARCH_RECS), limit(0));
		
		//Bring all sets into collectedindividuals for rollup and doPenalty assignment.
		collectedIndividuals := finalIndividuals+getGSASanctionsWithoutMatch+getGSASanctionsWithMatchMoreBMoreRestrictive+getIndividualsDeepDive;
		
		//Get Sanction Records Reentry
		getSanctionReEntryRecs := dedup(sort(Healthcare_Header_Services.Datasource_SelectFile.getSanctionsReentry(ReEntrySanctionRecords,cfg),record),record);
		getGSASanctionReEntryRecs := dedup(sort(Healthcare_Header_Services.DataSource_GSA.getSanctionsReentry(ReEntryGSASanctionRecords),record),record);
		
		//Final Records processing
		mergedRecs := sort(collectedIndividuals+getSanctionReEntryRecs+getGSASanctionReEntryRecs,acctno,lnpid);
		groupedRecs := group(mergedRecs, acctno, if(exists(ReEntrySanctionRecords) or exists(getGSASanctionReEntryRecs),(integer)acctno,lnpid),(integer)src);
		rolledRecs := rollup(groupedRecs, group, Transforms.doFinalRollup(left,rows(left)));
		finalRecsRaw := Functions.doPenalty(rolledRecs,DistinctInputRecsbyAcctno,cfg[1].penalty_threshold);
		
		
		stillfailedRecs := if((not cfg[1].IncludeAlsoFound), join(failedSearches,finalRecsRaw, left.acctno = right.acctno,transform(left),left only)); // records without gsa nor deep dive hit are 203 unless deepdive																	
		
		// sort ascending by penalty with lowest penalty as first record.
		finalRecs := sort(finalRecsRaw+stillfailedRecs,acctno,record_penalty);
		
		// output(ReEntryRecords, Named('getRecordsIndividual_ReEntryRecords'),extend);
		// output(SearchInputRecords, Named('getRecordsIndividual_SearchInputRecords'),extend);
		// output(ReEntryHeaderRecords, Named('getRecordsIndividual_ReEntryHeaderRecords'),extend);
		// output(ReEntrySanctionRecords, Named('getRecordsIndividual_ReEntrySanctionRecords'),extend);
		// output(ReEntryGSASanctionRecords, Named('getRecordsIndividual_ReEntryGSASanctionRecords'),extend);
		// output(IndividualRecords, Named('getRecordsIndividual_IndividualRecords'),extend);
		// output(getLNPIDs, Named('getRecordsIndividual_getLNPIDs'),extend);
		// output(failedSearches, Named('getRecordsIndividual_failedSearches'),extend);
		// output(goodSearches, Named('getRecordsIndividual_goodSearches'),extend);
		// output(getIndividuals, Named('getRecordsIndividual_getIndividuals'),extend);
		// output(mergedIndividuals, Named('getRecordsIndividual_mergedIndividuals'),extend);
		// output(groupedIndividuals, Named('getRecordsIndividual_groupedIndividuals'),extend);
		// output(DistinctInputRecsbyAcctno, Named('DistinctInputRecsbyAcctno'),extend);
		// output(rolledIndividuals, Named('getRecordsIndividual_rolledIndividuals'),extend);
		// output(finalIndividuals, Named('getRecordsIndividual_finalIndividuals'),extend);
		// output(getGSASanctionsHits, Named('getRecordsIndividual_getGSASanctionsHits'),extend);
		// output(getGSASanctionsHitsHighConf, Named('getRecordsIndividual_getGSASanctionsHitsHighConf'), extend);
		// output(NoHitsforIndivDeepDive, Named('getRecordsIndividual_NoHitsforIndivDeepDive'), extend);
		// output(getIndividualsDeepDive, Named('getRecordsIndividual_getIndividualsDeepDive'), extend);
		// output(getGSASanctionsWithoutMatch, Named('getRecordsIndividual_getGSASanctionsWithoutMatch'),extend);
		// output(getGSASanctionsWithMatchMoreBMoreRestrictive, Named('getRecordsIndividual_getGSASanctionsWithMatchMoreBMoreRestrictive'),extend);
		// output(collectedIndividuals, Named('getRecordsIndividual_collectedIndividuals'),extend);
		// output(getSanctionReEntryRecs, Named('getRecordsIndividual_getSanctionReEntryRecs'),extend);
		// output(getGSASanctionReEntryRecs, Named('getRecordsIndividual_getGSASanctionReEntryRecs'),extend);
		// output(getLNPIDs, Named('getRecordsIndividual_getLNPIDs'),extend);
		// output(failedSearches, Named('getRecordsIndividual_failedSearches'),extend);
		// output(mergedRecs, Named('getRecordsIndividual_mergedRecs'),extend);
		// output(groupedRecs, Named('getRecordsIndividual_groupedRecs'),extend);
		// output(rolledRecs, Named('getRecordsIndividual_rolledRecs'),extend);
		// output(finalRecsRaw, Named('getRecordsIndividual_finalRecsRaw'),extend);
		// output(stillfailedRecs, Named('getRecordsIndividual_stillfailedRecs'),extend);
		// output(finalRecs, Named('getRecordsIndividual_finalRecs'),extend);
		return finalRecs;
	end;
	Export getRecordsBusiness (dataset(Layouts.autokeyInput) input, dataset(Layouts.common_runtime_config) cfg = RunTimeConfig) := function
		ReEntryRecords := input(ProviderSrc <> '' and ProviderID > 0);//These are records that are coming back into the code from a result list
		SearchInputRecords := join(input,ReEntryRecords,left.acctno = right.acctno,transform(Layouts.autokeyInput,self:=left),left only);//Contains input criteria
		ReEntryHeaderRecords := ReEntryRecords(ProviderSrc = Constants.SRC_HEADER);//These are records that are coming back into the code from a result list that originated from the header
		//Business sanctions are now implemented int he Business header so it will no longer be an external file so look at the dataconnector for Enclarity
		// ReEntrySanctionRecords := ReEntryRecords(ProviderSrc = Constants.SRC_SANC);//These are records that are coming back into the code from a result list and are from Business Enclarity or Business NPPES
		ReEntryGSASanctionRecords := ReEntryRecords(ProviderSrc = Constants.SRC_GSA_SANC);//These are records that are coming back into the code from a result list and are from Business Enclarity or Business NPPES
		BusinessRecords := SearchInputRecords+ReEntryHeaderRecords;//The reentry records could be Business
		getLNPIDsBusiness := Header_Records_SearchBusKey(BusinessRecords,cfg).gethdrlnpids;
		getRawBusinesses := Header_Records_Data.getBusRecords(getLNPIDsBusiness,cfg);
		DistinctInputRecsbyAcctno := dedup(sort(input,acctno),acctno);
		// output(getRawBusinesses,named('getRawBusinesses'));
		//Rollup and merge results and do penalty to see if there are really hits.
		mergedRawBusinesses := sort(getRawBusinesses,acctno,lnpid);
		groupedRawBusinesses := group(mergedRawBusinesses, acctno, lnpid);
		rolledRawBusinesses := rollup(groupedRawBusinesses, group, Transforms.doFinalRollup(left,rows(left)));
		finalRawBusinesses := Functions.doPenalty(rolledRawBusinesses,DistinctInputRecsbyAcctno,cfg[1].penalty_threshold);
		//Append Business Sanctions to found records.
		// getBusinesses := Healthcare_Header_Services.Datasource_SelectFile.getAppendBusSanctions(finalRawBusinesses,BusinessRecords,cfg);
		//Get no hits for Business Sanctions Search
		// NoHitsforBusSanctions := join (BusinessRecords,if(cfg[1].IncludeSanctionsOnly,getBusinesses(exists(LegacySanctions)),getBusinesses(issearchfailed=false)),left.acctno=right.acctno,transform(Layouts.autokeyInput,self:=left;),left only);
		// getBusSanctionsHits := Healthcare_Header_Services.Datasource_SelectFile.getBusSanctions(project(NoHitsforBusSanctions,transform(Layouts.autokeyInput, self.providersrc:='NH',self:=left)),cfg);
		//Look in GSA file as well for sanctions
		getGSABusSanctionsHits := Healthcare_Header_Services.DataSource_GSA.get_GSA_by_autokeys(BusinessRecords,cfg);	
		//Get no hits for Business Deep dive
		NoHitsforBusDeepDive := join (BusinessRecords,finalRawBusinesses(issearchfailed=false)+getGSABusSanctionsHits,left.acctno=right.acctno,transform(Layouts.autokeyInput,self:=left),left only);
		//Do Business Deep Dive
		getBusinessDeepDive := Datasource_Boca_Bus_Header.get_boca_bus_header_entity(NoHitsforBusDeepDive(cfg[1].doDeepDive or cfg[1].IncludeAlsoFound));
		//Remove Header Failures when deep dive find something
		finalBusinessRemoveFailed:=join(finalRawBusinesses,getBusinessDeepDive,left.acctno=right.acctno and left.issearchfailed=true,transform(left),left only);
		//Final Business Records
		collectedBusiness := finalBusinessRemoveFailed+getGSABusSanctionsHits+getBusinessDeepDive;
		//Get Sanction Records Reentry
		// getSanctionReEntryRecs := dedup(sort(Healthcare_Header_Services.Datasource_SelectFile.getSanctionsReentry(ReEntrySanctionRecords,cfg),record),record);
		getGSASanctionReEntryRecs := dedup(sort(Healthcare_Header_Services.DataSource_GSA.getSanctionsReentry(ReEntryGSASanctionRecords),record),record);
		//Final Records processing
		mergedRecs := sort(collectedBusiness+getGSASanctionReEntryRecs,acctno,lnpid);
		groupedRecs := group(mergedRecs, acctno, if(exists(getGSASanctionReEntryRecs),(integer)acctno,lnpid),(integer)src);
		rolledRecs := rollup(groupedRecs, group, Transforms.doFinalRollup(left,rows(left)));
		finalRecs := Functions.doPenalty(rolledRecs,DistinctInputRecsbyAcctno,cfg[1].penalty_threshold);
    //final_sort:=sort(finalRecs	,-record_penalty);
		//output(cfg,named('cfggetRecordsBusiness'),overwrite);
		//output(ReEntryHeaderRecords,named('ReEntryHeaderRecords'));
		//output(ReEntryGSASanctionRecords,named('ReEntryGSASanctionRecords'));
		//output(BusinessRecords,named('BusinessRecords'));
		//output(getLNPIDsBusiness,named('getLNPIDsBusiness'),extend);
		//output(getRawBusinesses,named('getRawBusinesses'),extend);
		//output(rolledRawBusinesses,named('rolledRawBusinesses'));
		//output(finalRawBusinesses,named('finalRawBusinesses'));
		//output(getGSABusSanctionsHits,named('getGSABusSanctionsHits'));
		//output(NoHitsforBusDeepDive,named('NoHitsforBusDeepDive'));
		//output(getBusinessDeepDive,named('getBusinessDeepDive'));
		//output(rolledRawBusinesses,named('rolledRawBusinesses'));
		//output(finalBusinessRemoveFailed,named('finalBusinessRemoveFailed'));
		//output(collectedBusiness,named('collectedBusiness'));
		//utput(getGSASanctionReEntryRecs,named('getGSASanctionReEntryRecs'));
		//output(mergedRecs,named('mergedRecs'));
		//output(groupedRecs,named('groupedRecs'));
		//output(rolledRecs,named('rolledRecs'));
		//output(mergedRecs,named('mergedRecs'));
		//output(rolledRecs,named('rolledRecs'));
		//output(finalRecs,named('getRecordsBusinessfinalRecs'));
		//output(final_sort,named('getRecordsBusinessfinal_sort'));
		return finalRecs;
	end;
	Export getRecordsBusinessLegacy (dataset(Layouts.autokeyInput) input, dataset(Layouts.common_runtime_config) cfg = RunTimeConfig) := function
		ReEntryRecords := input(ProviderSrc <> '' and ProviderID > 0);//These are records that are coming back into the code from a result list
		SearchInputRecords := join(input,ReEntryRecords,left.acctno = right.acctno,transform(Layouts.autokeyInput,self:=left;),left only);//Contains input criteria
		ReEntrySanctionRecords := ReEntryRecords(ProviderSrc = Constants.SRC_SANC);//These are records that are coming back into the code from a result list and are from Business Enclarity or Business NPPES
		ReEntryNonHeaderRecords := ReEntryRecords(ProviderSrc = Constants.SRC_SELECTFILE or ProviderSrc = Constants.SRC_NPPES);//These are records that are coming back into the code from a result list and are from Business Enclarity or Business NPPES
		BusinessRecords := SearchInputRecords(comp_name <> '');
		getEnclarityNonReEntryBusRecs := Datasource_SelectFile.get_selectfile_byBusAutokeys(BusinessRecords(cfg[1].excludeSourceSelectFile=False));
		getEnclarityReEntryBusRecs := Datasource_SelectFile.get_selectfile_byBusReEntry(ReEntryNonHeaderRecords(cfg[1].excludeSourceSelectFile=False and ProviderSrc=Constants.SRC_SELECTFILE));
		getEnclarityBusRecs := dedup(getEnclarityNonReEntryBusRecs+getEnclarityReEntryBusRecs,acctno,src,vendorid,all,hash);
		//Get NPI records for Enclarity Business hits.  
		normNPIs := NORMALIZE(getEnclarityBusRecs,left.npis,transform(Layouts.searchKeyResults_plus_input,self.lnpid:=left.lnpid;
										self.vendorid:=right.npi;self.src := Constants.SRC_NPPES; self.comp_name := left.names[1].CompanyName ;self.userNPI:= if(left.isexactnpi=true,right.npi,'');self := left;self:=[]));
		CustomerInputforNppes := join (BusinessRecords,getEnclarityBusRecs,left.acctno=right.acctno,transform(Layouts.searchKeyResults_plus_input,
																		// recAlreadyFound := exists(right.npis(npi=left.npi)); 
																		self.vendorid:=left.npi;self:=left;),keep(Constants.MAX_RECS_ON_JOIN), limit(0));
		getAssociatedNPIRecords := dedup(project(Datasource_NPPES.get_nppes_forBusHits(dedup(normNPIs+CustomerInputforNppes,hash,all),cfg),transform(Layouts.CombinedHeaderResults,self.isAutokeysResult:=true;self:=left)),hash,all);
		//Join back to source.... getEnclarityBusRecs
		mergedEnclarityNPIRecs := join(getEnclarityBusRecs,getAssociatedNPIRecords,left.acctno=right.acctno and left.lnpid=right.lnpid, 
																					transform(Layouts.CombinedHeaderResults,
																								name1 := project(right.npiraw,transform(Layouts.layout_nameinfo,
																																									self.nameSeq := 5;
																																									self.CompanyName := left.EntityInformation.CompanyName;
																																									self := [];));
																								name2 := project(right.npiraw,transform(Layouts.layout_nameinfo,
																																									self.nameSeq := 5;
																																									self.CompanyName := left.EntityInformation.CompanyNameAKA;
																																									self := [];));
																								self.names := dedup(sort(left.names+name1+name2(CompanyName<>''),record),record);
																								self.npiraw:=right.npiraw,self.nppesverified:= right.nppesverified;self:=left;),left outer,keep(Constants.MAX_RECS_ON_JOIN), limit(0));
		groupedEnclarityNPIRecs := group(mergedEnclarityNPIRecs, acctno, if(exists(ReEntrySanctionRecords),(integer)acctno,lnpid),(integer)src);
		getEnclarityBusRecs_w_Npi := rollup(groupedEnclarityNPIRecs, group, Transforms.doFinalRollup(left,rows(left)));
		//What is left after hitting Enclarity
		NoHitsforNppes := join (BusinessRecords,getEnclarityBusRecs,left.acctno=right.acctno,transform(Layouts.autokeyInput,self:=left;),left only);
		//Whatever is left try it against NPPES
		getNPPESNonReEntryBusRecs := Datasource_NPPES.get_nppes_byBusAutokeys(NoHitsforNppes,cfg);
		refmtInput := project(ReEntryNonHeaderRecords(ProviderSrc=Constants.SRC_NPPES),transform(Layouts.searchKeyResults_plus_input,self.vendorid:=(string)left.providerid,self.UserUPIN:=(string)left.providerid;self.isAutokeysResult:=true;self:=left;self:=[];));
		CustomerInputforNppesReEntry := join (BusinessRecords,NoHitsforNppes,left.acctno=right.acctno,transform(Layouts.searchKeyResults_plus_input,self.lnpid:=(integer)left.npi;self.vendorid:=left.npi;self:=left;),keep(Constants.MAX_RECS_ON_JOIN), limit(0));
		getNPPESReEntryBusRecs := Datasource_NPPES.get_nppes_forBusHits(refmtInput+CustomerInputforNppesReEntry,cfg);
		getNPPESBusRecs := getNPPESNonReEntryBusRecs+getNPPESReEntryBusRecs;
		mergeBusinesses := getEnclarityBusRecs_w_Npi+getNPPESBusRecs;
		//Append Business Sanctions to found records.
		getBusinesses := Healthcare_Header_Services.Datasource_SelectFile.getAppendBusSanctions(mergeBusinesses,BusinessRecords,cfg);
		//Get no hits for Business Sanctions Search
		NoHitsforBusSanctions := join (BusinessRecords,getBusinesses,left.acctno=right.acctno,transform(Layouts.autokeyInput,self:=left;),left only);
		getBusSanctionsHits := Healthcare_Header_Services.Datasource_SelectFile.getBusSanctions(NoHitsforBusSanctions,cfg);
		//Get no hits for Business Deep dive
		NoHitsforBusDeepDive := join (BusinessRecords,getBusinesses+getBusSanctionsHits,left.acctno=right.acctno,transform(Layouts.autokeyInput,self:=left;),left only);
		//Do Business Deep Dive
		getBusinessDeepDive := Datasource_Boca_Bus_Header.get_boca_bus_header_entity(NoHitsforBusDeepDive);
		//Final Business Records
		collectedBusiness := getBusinesses+getBusSanctionsHits+getBusinessDeepDive;
		//Get Sanction Records Reentry
		getSanctionReEntryRecs := dedup(sort(Healthcare_Header_Services.Datasource_SelectFile.getSanctionsReentry(ReEntrySanctionRecords,cfg),record),record);
		//Final Records processing
		mergedRecs := sort(getSanctionReEntryRecs,acctno,lnpid);
		groupedRecs := group(mergedRecs, acctno, if(exists(ReEntrySanctionRecords),(integer)acctno,lnpid),(integer)src);
		rolledRecs := rollup(groupedRecs, group, Transforms.doFinalRollup(left,rows(left)))+sort(collectedBusiness,acctno,(integer)src);//We do not want to rollup Business records right now until they get to header.			
		finalRecs := Project(Functions.doPenalty(rolledRecs,dedup(sort(input,acctno),acctno),cfg[1].penalty_threshold), transform(layouts.CombinedHeaderResults, 		self.Names         := LEFT.Names(nameSeq>0); self := left;));
		// output(ReEntryRecords,named('ReEntryRecords'));
		// output(ReEntryHeaderRecords,named('ReEntryHeaderRecords'));
		// output(ReEntryNonHeaderRecords,named('ReEntryNonHeaderRecords'));
		// output(ReEntrySanctionRecords,named('ReEntrySanctionRecords'));
		// output(SearchInputRecords,named('SearchInputRecords'));
		// output(getEnclarityBusRecs,named('getEnclarityBusRecs'));
		// output(normNPIs,named('normNPIs'));
		// output(CustomerInputforNppes,named('CustomerInputforNppes'));
		// output(groupedEnclarityNPIRecs,named('groupedEnclarityNPIRecs'));
		// output(getEnclarityBusRecs_w_Npi,named('getEnclarityBusRecs_w_Npi'));
		// output(getEnclarityNonReEntryBusRecs,named('getEnclarityNonReEntryBusRecs'));
		// output(getEnclarityReEntryBusRecs,named('getEnclarityReEntryBusRecs'));
		// output(getEnclarityBusRecs,named('getEnclarityBusRecs'));
		// output(getAssociatedNPIRecords,named('getAssociatedNPIRecords'));
		// output(getEnclarityBusRecs_w_Npi,named('getEnclarityBusRecs_w_Npi'));
		// output(NoHitsforNppes,named('NoHitsforNppes'));
		// output(getNPPESBusRecs,named('getNPPESBusRecs'));
		// output(mergeBusinesses,named('mergeBusinesses'));
		// output(getBusinesses,named('getBusinesses'));
		// output(NoHitsforBusSanctions,named('NoHitsforBusSanctions'));
		// output(getBusSanctionsHits,named('getBusSanctionsHits'));
		// output(NoHitsforBusDeepDive,named('NoHitsforBusDeepDive'));
		// output(collectedBusiness,named('collectedBusiness'));
		// output(splitBusHeader,named('splitBusHeader'));
		// output(getLNPIDsBusiness,named('getLNPIDsBusiness'));
		// output(getBusinessDeepDive,named('getBusinessDeepDive'));
		// output(getSanctionReEntryRecs,named('getSanctionReEntryRecs'));
		// output(mergedRecs,named('mergedRecs'));
		// output(rolledRecs,named('rolledRecs'));
		// output(finalRecs,named('finalRecs'));
		return finalRecs;
	end;
	Export getRecordsRaw (dataset(Layouts.autokeyInput) input, dataset(Layouts.common_runtime_config) cfg = RunTimeConfig) := function
		//If it is an lnpid only search and you did not set a force flag do both.
		forceBusiness := input(IsBusinessSearch or IsUnknownSearchBoth or ProviderID > 0);
		forceIndividual := input(IsIndividualSearch or IsUnknownSearchBoth or ProviderID > 0);
		//if you did not tell me specifically how to process these records, then do a best guess
		searchTypeNotSet := join(input,forceIndividual+forceBusiness,left.acctno=right.acctno,transform(Layouts.autokeyInput, self:=left;),left only);
		//If you did not tell me what to do with these records use business name as indicator
		BusinessRecords := searchTypeNotSet(comp_name <> '');
		//If they are not business records they are individuals
		IndividualRecords := join(searchTypeNotSet,BusinessRecords,left.acctno = right.acctno,transform(Layouts.autokeyInput,self:=left;),left only);
		//Bring together the best guess records and the forced records for both business and individual
		getIndividuals := getRecordsIndividual(IndividualRecords+forceIndividual,cfg);
		getBusinesses := getRecordsBusiness(BusinessRecords+forceBusiness,cfg);
		finalRecs := dedup(sort(getIndividuals(srcid>0 or isSearchFailed)+getBusinesses(srcid>0 or isSearchFailed),acctno,lnpid),acctno,lnpid);
		exactLNPIDMatches := finalRecs(isExactLNPID=true);
		nonExactLNPIDMatchRecs := join(finalRecs,exactLNPIDMatches,left.acctno=right.acctno,transform(left),left only);
		finalRecsFiltered := sort(exactLNPIDMatches+nonExactLNPIDMatchRecs,acctno,record_penalty);
		// output(getIndividuals,named('getRecordsRaw_getIndividuals'),extend);		
		// output(getBusinesses,named('getRecordsRaw_getBusinesses'),extend);		
		// output(finalRecs,named('getRecordsRaw_finalRecsgetRecordsRaw'),extend);		
		// output(exactLNPIDMatches,named('getRecordsRaw_exactLNPIDMatches'),extend);		
		// output(nonExactLNPIDMatchRecs,named('getRecordsRaw_nonExactLNPIDMatchRecs'),extend);		
		// output(finalRecsFiltered,named('getRecordsRaw_finalRecsFiltered'),extend);		
		return finalRecsFiltered;
	end;
	Export getRecordsAppend (dataset(Layouts.autokeyInput) input, dataset(layouts.CombinedHeaderResults) rawRecs, dataset(Layouts.common_runtime_config) cfg = RunTimeConfig) := function
		//Upgrade to full output format
		rawDoxieFmt := project(rawRecs,layouts.CombinedHeaderResultsDoxieLayout);
		//Get slimmed down records to get additional lookup data
		slim := Functions.getSlimHdrRecords(rawRecs,input);
		fmtRec_w_SSN := Functions.appendSSN(slim,rawDoxieFmt, cfg);
		fmtRec_w_Death := Functions.appendDeath(slim,fmtRec_w_SSN);
		Valid_Lic_Company := Healthcare_Services.Customer_License_Search_Records.verify_Company(cfg[1].CustomerID);
		fmtRec_w_CustomerLicense := if(cfg[1].includeCustomerData and Valid_Lic_Company,Datasource_CustomerData.appendCustomerLicenseData(input, fmtRec_w_Death,cfg),fmtRec_w_Death);
		Valid_Death_Company := Healthcare_Services.Customer_Death_Search_Records.verify_Company(cfg[1].CustomerID);
		fmtRec_w_CustomerDeath := if(cfg[1].includeCustomerData and Valid_Death_Company,Datasource_CustomerData.appendCustomerDeathData(input, fmtRec_w_CustomerLicense,cfg),fmtRec_w_CustomerLicense);
		fmtRec_w_ABMS := if(cfg[1].IncludeABMSBoardCertifiedSpecialty or cfg[1].IncludeABMSCareer or cfg[1].IncludeABMSEducation or cfg[1].IncludeABMSProfessionalAssociations,Datasource_ABMS.appendABMSData(input,slim,fmtRec_w_CustomerDeath,cfg),fmtRec_w_CustomerDeath);
		// Get Sanction Records for Collected Records(Header hits that are not Enclarity based)
		// getSanctionsbyLNPID := join(fmtRec_w_ABMS,Ingenix_NatlProf.key_lnpid,left.lnpid=right.lnpid and (integer)right.sanc_id not in set(left.LegacySanctions,(integer)sanc_id),transform(Layouts.sanc_lookup_rec, self.acctno:=left.acctno;self.providerid:=left.lnpid;self.SANC_ID:=(integer)right.sanc_id;self.src:='LN'),keep(Constants.MAX_RECS_ON_JOIN), limit(0))(SANC_ID>0 and SANC_ID<10000000);
		// SanctionsAlreadyInResults := project(fmtRec_w_ABMS.LegacySanctions,transform(Layouts.sanc_lookup_rec, self.acctno:=left.acctno;self.providerid:=left.ProviderID;self.SANC_ID:=(integer)left.sanc_id;self.src:='LN'));
		// SanctionsToGet := Join(getSanctionsbyLNPID,SanctionsAlreadyInResults,left.acctno=right.acctno and left.providerid=right.providerid,transform(Layouts.sanc_lookup_rec, self:=left),left only);
		// getFullLegacySanction := Healthcare_Header_Services.Datasource_SelectFile.getSanctionsCommon(input,getSanctionsbyLNPID,cfg);
		// getFullLegacySanctionTest := Healthcare_Header_Services.Datasource_SelectFile.getSanctionsCommon(input,SanctionsToGet,cfg);
		// fmtRec_Sanctions := join(fmtRec_w_ABMS,getFullLegacySanction,left.acctno=right.acctno and left.lnpid=right.LNPID,transform(layouts.CombinedHeaderResultsDoxieLayout, self.LegacySanctions:=left.LegacySanctions+right.LegacySanctions;self:=left;),left outer, keep(Constants.MAX_RECS_ON_JOIN), limit(0));
		fmtRec_AppendGSA := Healthcare_Header_Services.DataSource_GSA.get_GSA_by_LNPID(project(fmtRec_w_ABMS,transform(layouts.CombinedHeaderResults,self:=left)));
		fmtRec_GSASanctions := join(fmtRec_w_ABMS,fmtRec_AppendGSA,left.acctno=right.acctno and left.lnpid=right.LNPID,transform(layouts.CombinedHeaderResultsDoxieLayout, self.LegacySanctions:=right.LegacySanctions;self:=left;),left outer, keep(Constants.MAX_RECS_ON_JOIN), limit(0));
		recToRemove:=fmtRec_GSASanctions(src=Healthcare_Header_Services.Constants.SRC_GSA_SANC and exists(LegacySanctions(src=Healthcare_Header_Services.Constants.SRC_HEADER)));
		fmtRec_FinalGSA := join(fmtRec_GSASanctions,recToRemove,left.acctno=right.acctno and right.LNPID = left.LNPID,transform(recordof(fmtRec_GSASanctions),self := left),left only);
		fmtRec_Final := join(fmtRec_FinalGSA,input(derivedinputrecord=false),left.acctno=right.acctno,Functions_Validation.processVerifications(left,right,cfg),keep(Constants.MAX_RECS_ON_JOIN), limit(0));
    fmtRec_FinalNew := if(cfg[1].includeAffiliations,functions.AppendAffiliations(fmtRec_Final,cfg),fmtRec_Final);
		// fmtRec_Final := join(fmtRec_w_ABMS,input(derivedinputrecord=false),left.acctno=right.acctno,Functions_Validation.processVerifications(left,right),keep(Constants.MAX_RECS_ON_JOIN), limit(0));
		// output(rawDoxieFmt,named('rawDoxieFmt'),overwrite);
		// output(slim,named('slim'),overwrite);
		// output(fmtRec_w_SSN,named('fmtRec_w_SSN'),overwrite);
		// output(fmtRec_w_Death,named('fmtRec_w_Death'),overwrite);
		// output(fmtRec_w_SSN,named('fmtRec_w_SSN'),overwrite);
		// output(fmtRec_w_CustomerLicense,named('fmtRec_w_CustomerLicense'),overwrite);
		// output(fmtRec_w_CustomerDeath,named('fmtRec_w_CustomerDeath'),overwrite);
		// output(slim(clianumbers[1].clianumber<>''),named('fmtRec_Clia_Input'),overwrite);
		// output(fmtRec_Clia,named('fmtRec_Clia'),overwrite);
		// output(fmtRec_w_Clia,named('fmtRec_w_Clia'),overwrite);
		// output(fmtRec_w_ABMS,named('getRecordsAppend_fmtRec_w_ABMS'),overwrite);
		// output(getSanctionsbyLNPID,named('getRecordsAppend_getSanctionsbyLNPID'),overwrite);
		// output(SanctionsAlreadyInResults,named('getRecordsAppend_SanctionsAlreadyInResults'),overwrite);
		// output(SanctionsToGet,named('getRecordsAppend_SanctionsToGet'),overwrite);
		// output(getFullLegacySanction,named('getRecordsAppend_getFullLegacySanction'),overwrite);
		// output(getFullLegacySanctionTest,named('getRecordsAppend_getFullLegacySanctionTest'),overwrite);
		// output(fmtRec_Sanctions,named('getRecordsAppend_fmtRec_Sanctions'),overwrite);
		// output(fmtRec_AppendGSA,named('getRecordsAppend_fmtRec_AppendGSA'),overwrite);
		// output(fmtRec_GSASanctions,named('getRecordsAppend_fmtRec_GSASanctions'),overwrite);
		// output(recToRemove,named('recToRemove'),overwrite);
		// output(fmtRec_Final,named('getRecordsAppend_fmtRec_Final'),overwrite);
		//return sort(fmtRec_Final,acctno,if(isBestBIPResult,0,1),record_penalty);
		return sort(fmtRec_FinalNew,acctno,if(isBestBIPResult,0,1),record_penalty);
	end;

	Export getRecordsRawDoxiebyDid (dataset(doxie.layout_references) input, dataset(Layouts.common_runtime_config) cfg = RunTimeConfig) := function
		rawRecs := getRecordsRawByDid(input,cfg);
		appendSupplementalData := getRecordsAppend(project(input,transform(Layouts.autokeyInput, self.acctno:='1';self.did:=left.did;self:=[])),rawRecs,cfg);
		// output(rawRecs,named('rawRecs'),overwrite);
		// output(rawDoxieFmt,named('rawDoxieFmt'),overwrite);
		return appendSupplementalData;
	end;

	Export getRecordsRawDoxiebyBDid (dataset(doxie.layout_ref_bdid) input, dataset(Layouts.common_runtime_config) cfg = RunTimeConfig) := function
		rawRecs := getRecordsRawByBDid(input,cfg);
		appendSupplementalData := getRecordsAppend(project(input,transform(Layouts.autokeyInput, self.acctno:='1';self.did:=left.bdid;self:=[])),rawRecs,cfg);
		// output(rawRecs,named('rawRecs'),overwrite);
		// output(rawDoxieFmt,named('rawDoxieFmt'),overwrite);
		return appendSupplementalData;
	end;

	Export getRecordsRawDoxieIndividual (dataset(Layouts.autokeyInput) input, dataset(Layouts.common_runtime_config) cfg = RunTimeConfig) := function
		rawRecs := getRecordsIndividual(input, cfg);
		appendSupplementalData := getRecordsAppend(dedup(sort(input,acctno),acctno),rawRecs,cfg);
		// output(rawRecs,named('rawRecs'),overwrite);
		return appendSupplementalData;
	end;

	Export getRecordsRawDoxieBusiness (dataset(Layouts.autokeyInput) input, dataset(Layouts.common_runtime_config) cfg = RunTimeConfig) := function
		rawRecs := getRecordsBusiness(input, cfg);
		appendSupplementalData := getRecordsAppend(dedup(sort(input,acctno),acctno),rawRecs,cfg);
		return appendSupplementalData;
	end;

	Export getRecordsRawDoxieBusinessLegacy (dataset(Layouts.autokeyInput) input, dataset(Layouts.common_runtime_config) cfg = RunTimeConfig) := function
		rawRecs := getRecordsBusiness(input, cfg);
		appendSupplementalData := getRecordsAppend(dedup(sort(input,acctno),acctno),rawRecs,cfg);
		// output(rawRecs,named('rawRecs'),overwrite);
		return choosen(appendSupplementalData,1);
	end;

	Export getRecordsRawDoxie (dataset(Layouts.autokeyInput) input, dataset(Layouts.common_runtime_config) cfg = RunTimeConfig) := function 
		//Remove Duplicate Entries
		dupFree:=dedup(sort(input,record, except acctno),record, except acctno);
		rawRecs := getRecordsRaw(dupFree, cfg);
		appendSupplementalData := getRecordsAppend(dedup(sort(dupFree,acctno),acctno),rawRecs,cfg);
		// output(rawRecs,named('rawRecs'),overwrite);
		//GetDup Entires and add them back
		findDups := group(sort(input,record, except acctno),record, except acctno);
		Layouts.rawDupRec flagit(Layouts.autokeyInput l, dataset(Layouts.autokeyInput) allRows) := transform
						self.dupAcctno := project(allRows(Acctno<>l.Acctno),transform(Layouts.rawkeyRec,self:=left));
						self:=l;
		End; 
		rolledDups:=rollup(findDups,group,flagit(left,rows(left)));
		normDups:=normalize(rolledDups,left.dupAcctno,transform(Layouts.rawNormRec,self.dupAcctno := right.acctno, self:=left;));
		processDups := join(normDups,appendSupplementalData,left.acctno=right.acctno,transform(recordof(appendSupplementalData),self.acctno:=left.dupAcctno;self:=right),keep(Constants.MAX_RECS_ON_JOIN), limit(0));
		reCombineAndSort:=sort(appendSupplementalData+processDups,Acctno,record_penalty,if(Src=Healthcare_Header_Services.Constants.SRC_GSA_SANC,2,0));
		// output(input,Named('getRecordsRawDoxie_ServiceInput'),extend);
		// output(dupFree,Named('getRecordsRawDoxie_ServiceDupFree'),extend);
		// output(rawRecs,Named('getRecordsRawDoxie_rawRecs'),extend);
		// output(appendSupplementalData,Named('ServiceAppendSupplementalData'));
		// output(findDups,Named('ServiceFindDups'));
		// output(rolledDups,Named('getRecordsRawDoxie_ServiceRolledDups'));
		// output(normDups,Named('getRecordsRawDoxie_ServiceNormDups'),extend);
		// output(processDups,Named('ServiceProcessDups'),extend);
		// output(reCombineAndSort,Named('getRecordsRawDoxieReCombineAndSort'),extend);
		return reCombineAndSort;
	end;
	Export fmtRecordsLegacyReport (dataset(Layouts.CombinedHeaderResultsDoxieLayout) rawRecs,dataset(Layouts.common_runtime_config) cfg = RunTimeConfig) := function
		return project(rawRecs,Transforms.fmtLegacyRpt(left,cfg));
	end;
	Export fmtRecordsLegacyReportWithVerifications (dataset(Layouts.CombinedHeaderResultsDoxieLayout) rawRecs,dataset(Layouts.common_runtime_config) cfg = RunTimeConfig) := function
		return project(rawRecs,Transforms.fmtLegacyRptWithVerifications(left,cfg));
	end;
	Export getRecords (dataset(Layouts.autokeyInput) input, dataset(Layouts.common_runtime_config) cfg = RunTimeConfig) := function
		raw := getRecordsRawDoxie(input, cfg);
		fmtRec := fmtRecordsLegacyReportWithVerifications(raw,cfg);
		return fmtRec;
	end;

	Export convertInputtoDataset(IParams.searchParams inputCriteria,unsigned1 acctno = 1) := function
		layout  := Layouts.autokeyInput;
		//Get clean address if needed  Alway clean to make sure City is right.
		cleanAddr := inputCriteria.addr <> '' and (inputCriteria.prim_range = '' and inputCriteria.prim_name = '');
		testInput:=stringlib.StringFind(inputCriteria.addr,',',1);
		splitRaw1 := if(testInput>0,inputCriteria.addr[1..testInput-1],inputCriteria.addr);
		splitRaw2 := if(testInput>0,inputCriteria.addr[testInput+1..],'');
		tmpCity := If(inputCriteria.city ='' and inputCriteria.zip ='', 'ANYTOWN',inputCriteria.city);
		line2:=if(inputCriteria.City <>'' or inputCriteria.State <>'' or inputCriteria.Zip <>'',tmpCity+' '+inputCriteria.state+' '+inputCriteria.zip,splitRaw2);
		clnAddr := Address.CleanFields(Address.GetCleanAddress(splitRaw1,line2,address.Components.Country.US).str_addr);
		//Check Last Name to see if it is compound and possibly messed up by cleaner.
		cityArray := DATASET(ut.StringSplit(inputCriteria.City, ' '), layouts.BusName_WordRec);
		cityArrayCnt := Count(cityArray(length(word)<4));//If we have a city less than 3 character it has to be an an abbreviation
		lastArray := DATASET(ut.StringSplit(inputCriteria.LastName, ' '), layouts.BusName_WordRec);
		lastArrayCnt := Count(lastArray(length(word)>2));
		middlenameEmpty := inputCriteria.MiddleName = '';
		newlastname := if(middlenameEmpty and lastArrayCnt > 1,lastArray[2].word,inputCriteria.LastName);
		newmiddlename := if(middlenameEmpty and lastArrayCnt > 1,lastArray[1].word,inputCriteria.MiddleName);
		
		layout setinput():=transform
			self.acctno := (string) acctno;
			self.comp_name := stringlib.StringToUpperCase(inputCriteria.CompanyName);
			self.name_first := stringlib.StringToUpperCase(inputCriteria.FirstName);
			self.name_middle := stringlib.StringToUpperCase(inputCriteria.MiddleName);
			self.name_last := stringlib.StringToUpperCase(inputCriteria.LastName);
			self.predir := if(cleanAddr and clnAddr.predir <> '',clnAddr.predir,stringlib.StringToUpperCase(inputCriteria.predir));
			self.prim_range := if(cleanAddr and clnAddr.prim_range <> '',clnAddr.prim_range,stringlib.StringToUpperCase(inputCriteria.prim_range));
			self.prim_name := if(cleanAddr and clnAddr.prim_name <> '',clnAddr.prim_name,stringlib.StringToUpperCase(inputCriteria.prim_name));
			self.addr_suffix := if(cleanAddr and clnAddr.addr_suffix <> '',clnAddr.addr_suffix,stringlib.StringToUpperCase(inputCriteria.suffix));
			self.postdir := if(cleanAddr and clnAddr.postdir <> '',clnAddr.postdir,stringlib.StringToUpperCase(inputCriteria.postdir));
			self.sec_range := if(cleanAddr and clnAddr.sec_range <> '',clnAddr.sec_range,stringlib.StringToUpperCase(inputCriteria.sec_range));
			self.p_city_name := if(cityArrayCnt >= 1 and clnAddr.p_city_name <> '',if(clnAddr.p_city_name='ANYTOWN','',clnAddr.p_city_name),stringlib.StringToUpperCase(inputCriteria.City));
			self.st := if(cleanAddr and clnAddr.st <> '',clnAddr.st,stringlib.StringToUpperCase(inputCriteria.State));
			self.z5 := if(cleanAddr and clnAddr.zip <> '',clnAddr.zip,inputCriteria.Zip);
			self.dob := (String)inputCriteria.dob;
			self.SSN := inputCriteria.SSN;
			self.NPI := inputCriteria.NPI;
			self.UPIN := inputCriteria.UPIN;
			self.DEA := inputCriteria.DEA;
			self.DEA2 := inputCriteria.DEA2;
			self.TAXID := inputCriteria.TaxID;
			self.FEIN := inputCriteria.FEIN;
			self.NCPDPNumber := inputCriteria.NCPDPNumber;
			self.license_number := if(inputCriteria.LicenseNumber<>'',stringlib.StringToUpperCase(inputCriteria.LicenseNumber),stringlib.StringToUpperCase(inputCriteria.StateLicenses[1].LicenseNumber));
			self.license_state := if(inputCriteria.LicenseState<>'',stringlib.StringToUpperCase(inputCriteria.LicenseState),stringlib.StringToUpperCase(inputCriteria.StateLicenses[1].LicenseState));
			self.cliaNumber := inputCriteria.CLIANumber;
			self.did := if(inputCriteria.derivedLexID,0,(integer)inputCriteria.did);
			self.bdid := if(inputCriteria.derivedLexID,0,(integer)inputCriteria.bdid);
			self.ProviderID := (integer)inputCriteria.ProviderId;	
			self.ProviderSrc := stringlib.StringToUpperCase(inputCriteria.ProviderSrc);
			// self.CustomerID := inputCriteria.requestorCompanyID;
			// self.glb_ok :=  ut.glb_ok (inputCriteria.GLBPurpose);
			// self.dppa_ok := ut.dppa_ok(inputCriteria.DPPAPurpose);
			// self.DRM := inputCriteria.DataRestrictionMask;
			// self.OneStepRule := inputCriteria.OneStepRule;
			self.MedicalSchoolNameVerification := inputCriteria.MedicalSchoolName;
			self.GraduationYearVerification := inputCriteria.GraduationYear;
			Self.Taxonomy1Verification := stringlib.StringToUpperCase(inputCriteria.Taxonomy);
			Self.Taxonomy2Verification := stringlib.StringToUpperCase(inputCriteria.Taxonomy2);
			Self.Taxonomy3Verification := stringlib.StringToUpperCase(inputCriteria.Taxonomy3);
			Self.Taxonomy4Verification := stringlib.StringToUpperCase(inputCriteria.Taxonomy4);
			Self.Taxonomy5Verification := stringlib.StringToUpperCase(inputCriteria.Taxonomy5);
			Self.StateLicense1Verification := if(inputCriteria.LicenseNumber<>'',stringlib.StringToUpperCase(inputCriteria.LicenseNumber),stringlib.StringToUpperCase(inputCriteria.StateLicenses[1].LicenseNumber));
			Self.StateLicense1StateVerification := if(inputCriteria.LicenseState<>'',stringlib.StringToUpperCase(inputCriteria.LicenseState),stringlib.StringToUpperCase(inputCriteria.StateLicenses[1].LicenseState));
			Self.StateLicense2Verification := stringlib.StringToUpperCase(inputCriteria.StateLicenses[2].LicenseNumber);
			Self.StateLicense2StateVerification := stringlib.StringToUpperCase(inputCriteria.StateLicenses[2].LicenseState);
			Self.StateLicense3Verification := stringlib.StringToUpperCase(inputCriteria.StateLicenses[3].LicenseNumber);
			Self.StateLicense3StateVerification := stringlib.StringToUpperCase(inputCriteria.StateLicenses[3].LicenseState);
			Self.StateLicense4Verification := stringlib.StringToUpperCase(inputCriteria.StateLicenses[4].LicenseNumber);
			Self.StateLicense4StateVerification := stringlib.StringToUpperCase(inputCriteria.StateLicenses[4].LicenseState);
			Self.StateLicense5Verification := stringlib.StringToUpperCase(inputCriteria.StateLicenses[5].LicenseNumber);
			Self.StateLicense5StateVerification := stringlib.StringToUpperCase(inputCriteria.StateLicenses[5].LicenseState);
			Self.StateLicense6Verification := stringlib.StringToUpperCase(inputCriteria.StateLicenses[6].LicenseNumber);
			Self.StateLicense6StateVerification := stringlib.StringToUpperCase(inputCriteria.StateLicenses[6].LicenseState);
			Self.StateLicense7Verification := stringlib.StringToUpperCase(inputCriteria.StateLicenses[7].LicenseNumber);
			Self.StateLicense7StateVerification := stringlib.StringToUpperCase(inputCriteria.StateLicenses[7].LicenseState);
			Self.StateLicense8Verification := stringlib.StringToUpperCase(inputCriteria.StateLicenses[8].LicenseNumber);
			Self.StateLicense8StateVerification := stringlib.StringToUpperCase(inputCriteria.StateLicenses[8].LicenseState);
			Self.StateLicense9Verification := stringlib.StringToUpperCase(inputCriteria.StateLicenses[9].LicenseNumber);
			Self.StateLicense9StateVerification := stringlib.StringToUpperCase(inputCriteria.StateLicenses[9].LicenseState);
			Self.StateLicense10Verification := stringlib.StringToUpperCase(inputCriteria.StateLicenses[10].LicenseNumber);
			Self.StateLicense10StateVerification := stringlib.StringToUpperCase(inputCriteria.StateLicenses[10].LicenseState);
			self.BoardCertifiedSpecialtyVerification := stringlib.StringToUpperCase(inputCriteria.BoardCertifiedSpecialty);
			self.BoardCertifiedSubSpecialtyVerification := stringlib.StringToUpperCase(inputCriteria.BoardCertifiedSubSpecialty);
			self.BoardCertifiedSpecialty2Verification := stringlib.StringToUpperCase(inputCriteria.BoardCertifiedSpecialty2);
			self.BoardCertifiedSubSpecialty2Verification := stringlib.StringToUpperCase(inputCriteria.BoardCertifiedSubSpecialty2);
			self.BoardCertifiedSpecialty3Verification := stringlib.StringToUpperCase(inputCriteria.BoardCertifiedSpecialty3);
			self.BoardCertifiedSubSpecialty3Verification := stringlib.StringToUpperCase(inputCriteria.BoardCertifiedSubSpecialty3);
			self.BoardCertifiedSpecialty4Verification := stringlib.StringToUpperCase(inputCriteria.BoardCertifiedSpecialty4);
			self.BoardCertifiedSubSpecialty4Verification := stringlib.StringToUpperCase(inputCriteria.BoardCertifiedSubSpecialty4);
			self.BoardCertifiedSpecialty5Verification := stringlib.StringToUpperCase(inputCriteria.BoardCertifiedSpecialty5);
			self.BoardCertifiedSubSpecialty5Verification := stringlib.StringToUpperCase(inputCriteria.BoardCertifiedSubSpecialty5);
			// self.isReport := inputCriteria.isReport;
			// self.IncludeSanctions := inputCriteria.IncludeSanctions;
			// self.includeCustomerData := inputCriteria.includeCustomerData;
			// self.doDeepDive := inputCriteria.IncludeAlsoFound;
			// self.IncludeABMSSpecialty := inputCriteria.IncludeBoardCertifiedSpecialty;
			// self.IncludeABMSCareer := inputCriteria.IncludeCareer;
			// self.IncludeABMSEducation := inputCriteria.IncludeEducation;
			// self.IncludeABMSProfessionalAssociations := inputCriteria.IncludeProfessionalAssociations;
			// self.ExcludeSourceAMS := inputCriteria.ExcludeSourceAMS;
			// self.ExcludeSourceNPPES := inputCriteria.ExcludeSourceNPPES;
			// self.ExcludeSourceDEA := inputCriteria.ExcludeSourceDEA;
			// self.ExcludeSourceProfLic := inputCriteria.ExcludeSourceProfLic;
			// dataRestrictEnclarity := inputCriteria.DataRestrictionMask[19] not in ['0',''];//if there is a value other than blank or Zero Restrict
			// self.ExcludeSourceSelectFile := if(dataRestrictEnclarity,dataRestrictEnclarity,inputCriteria.ExcludeSourceSelectFile);
			// self.ExcludeSourceCLIA := inputCriteria.ExcludeSourceCLIA;
			// self.ExcludeSourceNCPDP := inputCriteria.ExcludeSourceNCPDP;
			// self.excludeLegacySanctions := inputCriteria.ExcludeLegacySanctions;
			self.IsIndividualSearch := inputCriteria.IsIndividualSearch or inputCriteria.IsUnknownSearchBoth or inputCriteria.CompanyName ='';
			self.IsBusinessSearch := inputCriteria.IsBusinessSearch or inputCriteria.IsUnknownSearchBoth or inputCriteria.CompanyName <> '';
			self.IsUnknownSearchBoth := inputCriteria.IsUnknownSearchBoth;
			self:=[];
			end;
		ds:=dataset([setinput()]);
		ds2:=project(ds,transform(layout, 
											self.name_middle := stringlib.StringToUpperCase(newmiddlename);
											self.name_last := stringlib.StringToUpperCase(newlastname);
											self := left));
		dsCombined := if(middlenameEmpty and lastArrayCnt > 1,ds+ds2,ds);
		return dsCombined;
	end;
	Export getReportServiceDidValues (dataset(Layouts.autokeyInput) input, dataset(Layouts.common_runtime_config) cfg = RunTimeConfig) := function
		isBus := input[1].comp_name <> '';
		rawIndividual := getRecordsIndividual(input, cfg);
		rawBusiness := getRecordsBusinessLegacy(input, cfg);
		provRec:=sort(dedup(sort(if(isBus,rawBusiness,rawIndividual),acctno, LNPID),record),record_penalty);
		return provRec;
	end;
	Export getReportServiceRecords (dataset(Layouts.autokeyInput) input, dataset(Layouts.common_runtime_config) cfg = RunTimeConfig) := function
		rawIndividual := getRecordsRawDoxieIndividual(input(IsIndividualSearch=true), cfg);
		rawBusiness := getRecordsRawDoxieBusinessLegacy(input(IsBusinessSearch=true), cfg);
		return rawIndividual+rawBusiness;
	end;
	Export getSearchServiceRecords (dataset(Layouts.autokeyInput) input, dataset(Layouts.common_runtime_config) cfg = RunTimeConfig) := function
		// convertedInput := convertInputtoDataset(aInputData);
		rawRecs:=sort(dedup(sort(getRecordsRawDoxie(input, cfg),acctno, LNPID),acctno, LNPID),acctno,record_penalty,-SRC,if(Src=Healthcare_Header_Services.Constants.SRC_GSA_SANC,2,0));
		filterRecs := if(cfg[1].IncludeSanctionsOnly = True,rawRecs(exists(LegacySanctions)),rawRecs);
		// provRec:=project(filterRecs,Transforms.formatSearchServiceProviderOutput(left,convertedInput,cfg));
		 //output(rawRecs,named('getSearchServiceRecordsRawrecs'));
		 //output(filterRecs,named('getSearchServiceRecordsfilterRecsnamed'));
		return filterRecs;
	end;
	Export fmtRecordsSearch (dataset(Layouts.CombinedHeaderResults) rawRecs) := function
		return project(rawRecs,Transforms.fmtLegacySearch(left));
	end;

End;