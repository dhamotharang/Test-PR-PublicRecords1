import doxie,doxie_cbrs;
export Provider_Records (IParams.reportParams inputData, boolean skipDeepDive = false,boolean isHeaderSearch = false) := module
	//Validate input
	export hasCityStateZip := (length(trim(inputdata.city,all))>0 and length(trim(inputdata.state,all))>0) or length(trim(inputdata.zip,all))>0;
	export hasLastCompany := length(trim(inputdata.lastname,all))>0 or length(trim(inputdata.companyName,all))>0;
	export hasCompany := length(trim(inputdata.companyName,all))>0;
	
	//Get dids by autokeys using header for deep dive
	// shared didsbyDeepDive := if(false and hasCityStateZip and hasLastCompany and inputdata.IncludeAlsoFound and not skipDeepDive,raw.getReportDids(inputData)(did<>0));
	//Get dids by user input now handled by consolidated
	// shared didfromuser := project(dataset ([(unsigned6) inputData.did],doxie.layout_references),transform(layouts.deepDids,self:=left))(did>0); 	//User provided DID
	// shared nodeepDids := dedup(sort(didsbyDeepDive(isdeepdive=false),record),record);
	// shared searchByDids  := map(exists(didfromuser) => didfromuser,//we found a user supplied did use if
											 // count(nodeepDids)=1 => nodeepDids,//we found a non deep dive did use it
											 // dedup(sort(didsbyDeepDive,record),record));
	
	//Get provider records
	// export providerRaw := Raw.ProvidersReportRecords(inputData, searchByDids);
	export tmpMod:= MODULE(PROJECT(inputData, Healthcare_Provider_Services.IParams.searchParams,opt)) END;
	Export searchByCriteria := Provider_Records_Consolidated.convertInputtoDataset(tmpMod);
	// Export searchByDeepDiveDids := Project(didsbyDeepDive,transform(Healthcare_Provider_Services.Layouts.autokeyInput,self:=left;self:=[]));
	Export providerRawNoDeepDive := Provider_Records_Consolidated.getRecordsRawDoxie(searchByCriteria,inputData.penalty_threshold,true,isHeaderSearch);
	// Export providerRawDeepDive := Provider_Records_Consolidated.getRecords(searchByDeepDiveDids,inputData.penalty_threshold);
	// Export providerRaw := if(exists(providerRawNoDeepDive),
															// Provider_Records_Consolidated.fmtRecordsLegacyReportWithVerifications(choosen(sort(providerRawNoDeepDive,record_penalty),1),tmpMod),
															// choosen(providerRawDeepDive,1));
	Export providerRaw := Provider_Records_Consolidated.fmtRecordsLegacyReportWithVerifications(choosen(sort(providerRawNoDeepDive,record_penalty),1),tmpMod);

  // The following count (countProviderRaw) is used when calculating: noProvRecordsFound.
  // If there are only AMS records, we need this count included in the calculation.
  shared countProviderRaw := COUNT( providerRaw );
	shared derivedDids := dedup(project(providerRaw.providerdid,transform(layouts.deepDids,self.did:=(integer)left.did)));
	// shared deepDidPenalty := Functions.apply_penalty_dids(didsbyDeepDive(did>0),inputData);
	// shared selectDids := map(exists(providerRawNoDeepDive)=>project(providerRawNoDeepDive[1].dids,transform(layouts.deepDids,self:=left;self:=[])),
																// count(deepDidPenalty)=1=>deepDidPenalty,
																// derivedDids);
	shared selectDids := project(providerRawNoDeepDive[1].dids,transform(layouts.deepDids,self:=left;self:=[]));
	export bestDid := project(selectDids,transform(layouts.deepDids, self:=left))(did>0);

	shared provCountByID := count(dedup(sort(providerRaw,providerid),providerid));
	shared normProviderDids := project(providerRaw.providerdid,transform(layouts.layout_denormDid,self := left));
	shared provCountByDid := count(dedup(sort(normProviderDids,did),did));
	// shared countDeepDids := count(searchByDeepDiveDids);

	export didFound := exists(providerRaw);
	// export tooManyDidsFound := provCountByID > 1 or countDeepDids > 1 or count(providerRawNoDeepDive)>2;
	export tooManyDidsFound := provCountByID > 1 or count(providerRawNoDeepDive)>2;

	//Get bdids by autokeys
	shared bdidsbyak := choosen(if(hasCompany and hasCityStateZip and not skipDeepDive,raw.getReportBDids(inputData)(bdid<>0)),100);
	//Get bdids by user input
	shared bdidfromuser := project(dataset ([(unsigned6) inputData.bdid],doxie_cbrs.layout_references),transform(layouts.deepBDids,self:=left))(bdid>0); 	//User provided BDID
	//In case we got a business via the NPI/NPPES go get the BDID
	shared Nppes_Data := if(hasCityStateZip and hasLastCompany,raw.getNPPESdata(inputData,project(providerRaw,doxie.ingenix_provider_module.layout_ingenix_provider_report))(BDID<>0));
	shared all_bdids := dedup(sort(bdidsbyak+project(Nppes_Data,layouts.deepBDids),record),record);
	shared nodeepBDids := dedup(sort(bdidsbyak(isdeepdive=false),record),record);
	shared searchByBDids := map(exists(bdidfromuser) => bdidfromuser,//we found a user supplied bdid use it
											 exists(providerRawNoDeepDive)=>project(providerRawNoDeepDive[1].bdids,transform(layouts.deepBDids,self:=left;self:=[])),
											 count(nodeepBDids)=1 => nodeepBDids,//we found a non deep dive bdid use it
											 dedup(sort(bdidsbyak,record),record));
	shared deepBDidPenalty := Functions.apply_penalty_bdids(bdidsbyak(bdid>0),inputData);
	export bestBDid := project(if(count(searchByBDids)=1,searchByBDids,deepBDidPenalty),transform(layouts.deepBDids, self := left))(bdid>0);

	shared countDeepBDids := count(searchByBDids(isdeepdive=true));

	export bdidFound := exists(Nppes_Data);
	export tooManyBDidsFound := countDeepBDids > 1;
	// EXPORT noProvRecordsFound := countDeepDids = 0 AND countDeepBDids = 0 AND provCountByID = 0 AND provCountByDid = 0 AND countProviderRaw = 0;
	EXPORT noProvRecordsFound := countDeepBDids = 0 AND provCountByID = 0 AND provCountByDid = 0 AND countProviderRaw = 0;

end;
