Import Health_Provider_Services, Health_Facility_Services, doxie;
EXPORT getCandidateRecords := Module
	Healthcare_Shared.Layouts.common_runtime_config buildRunTimeConfig():=transform
		self.cfg_Version := 1;
		// self:=[];DO NOT Uncomment at if you do so you will kill all the default values.
	end;
	Export RunTimeConfig:=dataset([buildRunTimeConfig()]);
	Export getCommonizedInput (dataset(Healthcare_Shared.Layouts.autokeyInput) inputbyAutokey = dataset([],Healthcare_Shared.Layouts.autokeyInput),
															 dataset(doxie.layout_references) inputbyDid = dataset([],doxie.layout_references), 
															 dataset(doxie.layout_ref_bdid) inputbyBDid = dataset([],doxie.layout_ref_bdid), 
															 dataset(Healthcare_Shared.Layouts.common_runtime_config) cfg = RunTimeConfig) := function
		ConvertDid := Project(inputbyDid,Healthcare_Shared.Transform_Commonized.convertDidtoAutokey(left,counter));
		ConvertBDid := Project(inputbyBDid,Healthcare_Shared.Transform_Commonized.convertBdidtoAutokey(left,counter));
		BackupRaw := dedup(sort(project(inputbyAutokey,Healthcare_Shared.Transform_Commonized.backupRaw(left)),record),record);
		CleanAutokey := Healthcare_Shared.Functions_Commonized.getCleanNameAddr(BackupRaw);
		StandardizeInputRecs := project(CleanAutokey,Healthcare_Shared.Transform_Commonized.setStandardizedInput(left,cfg));
		CheckMinimumInputRequirements := Healthcare_Shared.InputRequirementsManager.CheckMinimumInput(StandardizeInputRecs,cfg);
		CombinedRec := CheckMinimumInputRequirements+ConvertDid+ConvertBDid;
		// Output(inputbyAutokey,named('inputbyAutokey'),extend);
		// Output(BackupRaw,named('BackupRaw'),extend);
		// Output(CleanAutokey,named('CleanAutokey'),extend);
		// Output(StandardizeInputRecs,named('StandardizeInputRecs'),extend);
		// Output(CheckMinimumInputRequirements,named('CheckMinimumInputRequirements'),extend);
		// Output(CombinedRec,named('CombinedRec'),extend);
		return sort(CombinedRec,acctno);
	end;
	Export getProviderRecords(dataset(Healthcare_Shared.Layouts.userInputCleanMatch) input) := function
		//If it is an lnpid only search and you did not set a force flag do both.
		forceIndividual := project(input(IsIndividualSearch or IsUnknownSearchBoth or lnpid > 0), transform(Healthcare_Shared.Layouts.userInputCleanMatch,self.IsIndividualSearch:=true;self:=left;));;
		//Specifically Business
		BusinessRecords := input(isBusinesssearch or lnfid > 0 or comp_name <> '');
		//If they are not business records they are individuals
		IndividualRecords := join(input,BusinessRecords,left.acctno = right.acctno,transform(Healthcare_Shared.Layouts.userInputCleanMatch,self.IsIndividualSearch:=true;self:=left;),left only);
		return dedup(sort(IndividualRecords+forceIndividual,acctno),acctno);
	end;
	Export getFacilitiesRecords(dataset(Healthcare_Shared.Layouts.userInputCleanMatch) input) := function
		//If it is an lnpid only search and you did not set a force flag do both.
		forceBusiness := project(input(IsBusinessSearch or IsUnknownSearchBoth or lnfid > 0 or comp_name <> ''),transform(Healthcare_Shared.Layouts.userInputCleanMatch,self.IsBusinessSearch:=true;self:=left;));
		//Specifically Individual
		IndividualRecords := input(IsIndividualSearch or lnpid > 0 or comp_name = '');
		//If you did not tell me what to do with these records use business name as indicator
		BusinessRecords := join(input,IndividualRecords,left.acctno = right.acctno,transform(Healthcare_Shared.Layouts.userInputCleanMatch,self.IsBusinessSearch:=true;self:=left;),left only);
		return dedup(sort(BusinessRecords+forceBusiness,acctno),acctno);
	end;
	Export getProviderCandidates (dataset(Healthcare_Shared.Layouts.userInputCleanMatch) input, dataset(Healthcare_Shared.Layouts.common_runtime_config) cfg = RunTimeConfig) := function
		IndividualRecords := getProviderRecords(input);
		getLNPIDs := Healthcare_Shared.Fn_search_Ind_Header.getHdrLNPids(IndividualRecords,cfg);
		getLNPIDs_w_Flags := Healthcare_Shared.Fn_search_Ind_Header.getFlags(IndividualRecords,getLNPIDs);
		idsFound := dedup(sort(getLNPIDs,acctno,lnpid),acctno,lnpid);
		NoHits := join(IndividualRecords,idsFound,left.acctno=right.acctno,
										transform(Healthcare_Shared.Layouts_Header.CandidateRecords,
															self.acctno:=left.acctno;
															self.keysfailed :=0;
															self.keysfailed_decode :='NoHit';
															self.isSearchFailed := true;
															self.returnThresholdExceeded := false;
															self.srcIndividualHeader := true;
															self.srcBusinessHeader := false;
															self:=[];),left only);
		// output(IndividualRecords,named('IndividualRecords'),extend);
		return getLNPIDs_w_Flags+NoHits;
	end;
	Export getFacilitiesCandidates (dataset(Healthcare_Shared.Layouts.userInputCleanMatch) input, dataset(Healthcare_Shared.Layouts.common_runtime_config) cfg = RunTimeConfig) := function
		FacilityRecords := getFacilitiesRecords(input);
		getLNFIDs := Healthcare_Shared.Fn_search_Bus_Header.getHdrLNFids(FacilityRecords,cfg);
		getLNFIDs_w_Flags := Healthcare_Shared.Fn_search_Bus_Header.getFlags(FacilityRecords,getLNFIDs);
		idsFound := dedup(sort(getLNFIDs,acctno,lnpid),acctno,lnpid);
		NoHits := join(FacilityRecords,idsFound,left.acctno=right.acctno,
										transform(Healthcare_Shared.Layouts_Header.CandidateRecords,
															self.acctno:=left.acctno;
															self.keysfailed :=0;
															self.keysfailed_decode :='NoHit';
															self.isSearchFailed := true;
															self.returnThresholdExceeded := false;
															self.srcIndividualHeader := false;
															self.srcBusinessHeader := true;
															self:=[];),left only);
		// output(FacilityRecords,named('FacilityRecords'),extend);
		return getLNFIDs_w_Flags+NoHits;
	end;
	Export getCandidatesbyCommonized (dataset(Healthcare_Shared.Layouts.userInputCleanMatch) input, dataset(Healthcare_Shared.Layouts.common_runtime_config) cfg = RunTimeConfig) := function
		indv := getProviderCandidates(input,cfg);
		indvHits := indv(keysfailed_decode <> 'NoHit');
		indvNoHits := indv(isSearchFailed and keysfailed_decode = 'NoHit');
		bus := getFacilitiesCandidates(input,cfg);
		busHits := bus(keysfailed_decode <> 'NoHit');
		busNoHits := bus(isSearchFailed and keysfailed_decode = 'NoHit');
		CombinedHits := indvHits+busHits;
		CombinedNoHits := indvNoHits+busNoHits;
		//Remove NoHits if Both are run
		validNoHits := dedup(sort(join(CombinedHits,CombinedNoHits,left.acctno=right.acctno,transform(right),right only),acctno),acctno);
		// output(indv,named('indv'),extend);
		// output(indvHits,named('indvHits'),extend);
		// output(indvNoHits,named('indvNoHits'),extend);
		// output(bus,named('bus'),extend);
		// output(busHits,named('busHits'),extend);
		// output(busNoHits,named('busNoHits'),extend);
		// output(CombinedHits,named('CombinedHits'),extend);
		// output(CombinedNoHits,named('CombinedNoHits'),extend);
		// output(validNoHits,named('validNoHits'),extend);
		return sort(CombinedHits+validNoHits,acctno);
	end;
	Export fullProviders (dataset(Healthcare_Shared.Layouts.common_runtime_config) cfg = RunTimeConfig) := function
		key:=Health_Provider_Services.Process_xLNPID_Layouts.Key;
		// key:=HCPExternalLinking.Process_xLNPID_Layouts.Key;
		srt:=dedup(sort(key,lnpid,src,vendor_id),lnpid,src,vendor_id);
		ProviderRecords:=Project(srt,transform(Healthcare_Shared.Layouts_Header.CandidateRecords,
			keepRecord := map (cfg[1].allowMergeAuthoritySrc and left.src in [Healthcare_Shared.Constants.SRC_NPPES,Healthcare_Shared.Constants.SRC_DEA,Healthcare_Shared.Constants.SRC_CLIA,Healthcare_Shared.Constants.SRC_NCPDP] => true,
												 left.src = Healthcare_Shared.Constants.SRC_AMS and cfg[1].excludeSourceAMS => false,																					
												 left.src = Healthcare_Shared.Constants.SRC_NPPES and cfg[1].excludeSourceNPPES => false,																					
												 left.src = Healthcare_Shared.Constants.SRC_DEA and cfg[1].excludeSourceDEA => false,																					
												 left.src = Healthcare_Shared.Constants.SRC_PROFLIC and cfg[1].excludeSourceProfLic => false,																					
												 left.src = Healthcare_Shared.Constants.SRC_SELECTFILE and cfg[1].excludeSourceSelectFile => false,																					
												 left.src = Healthcare_Shared.Constants.SRC_CLIA and cfg[1].excludeSourceCLIA => false,																					
												 left.src = Healthcare_Shared.Constants.SRC_NCPDP and cfg[1].excludeSourceNCPDP => false,
												 true);
			self.uniqueid := if(keepRecord,left.rid,skip);
			self.acctno := (string)left.rid;
			self.lnpid := left.lnpid;
			self.lnfid := 0;
			self.srcIndividualHeader := true;
			self.srcBusinessHeader := false;
			self.ambiguous := false;
			self:=left;
			self:=[];));
		return ProviderRecords;
	end;
	Export fullFacilities (dataset(Healthcare_Shared.Layouts.common_runtime_config) cfg = RunTimeConfig) := function
		key:=Health_Facility_Services.Process_xLNPID_Layouts.Key;
		// key:=HCFExternalLinking.Process_xLNFID_Layouts.Key;
		srt:=dedup(sort(key,lnpid,src,vendor_id),lnpid,src,vendor_id);
		FacilityRecords:=Project(srt,transform(Healthcare_Shared.Layouts_Header.CandidateRecords,
			keepRecord := map (cfg[1].allowMergeAuthoritySrc and left.src in [Healthcare_Shared.Constants.SRC_NPPES,Healthcare_Shared.Constants.SRC_DEA,Healthcare_Shared.Constants.SRC_CLIA,Healthcare_Shared.Constants.SRC_NCPDP] => true,
												 left.src = Healthcare_Shared.Constants.SRC_AMS and cfg[1].excludeSourceAMS => false,																					
												 left.src = Healthcare_Shared.Constants.SRC_NPPES and cfg[1].excludeSourceNPPES => false,																					
												 left.src = Healthcare_Shared.Constants.SRC_DEA and cfg[1].excludeSourceDEA => false,																					
												 left.src = Healthcare_Shared.Constants.SRC_PROFLIC and cfg[1].excludeSourceProfLic => false,																					
												 left.src = Healthcare_Shared.Constants.SRC_SELECTFILE and cfg[1].excludeSourceSelectFile => false,																					
												 left.src = Healthcare_Shared.Constants.SRC_CLIA and cfg[1].excludeSourceCLIA => false,																					
												 left.src = Healthcare_Shared.Constants.SRC_NCPDP and cfg[1].excludeSourceNCPDP => false,
												 true);
			self.uniqueid := if(keepRecord,left.rid,skip);
			self.acctno := (string)left.rid;
			self.lnpid := 0;
			self.lnfid := left.lnpid;
			self.srcIndividualHeader := false;
			self.srcBusinessHeader := true;
			self.ambiguous := false;
			self:=left;
			self:=[];));
		return FacilityRecords;
	end;
End;