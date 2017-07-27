Import Healthcare_CustomerLicense,Healthcare_CustomerDeath,Healthcare_Rules_PP_SF,Healthcare_Rules_DES_MF;
EXPORT getGoldenRecord := Module
	Healthcare_Shared.Layouts.common_runtime_config buildRunTimeConfig():=transform
		self.cfg_Version := 1;
		//self:=[];DO NOT Uncomment at if you do so you will kill all the default values.
	end;
	Shared RunTimeConfig:=dataset([buildRunTimeConfig()]);
		Export Healthcare_Shared.Layouts.CombinedHeaderResultsDoxieLayout buildFailureRecord (Healthcare_Shared.Layouts_Header.CandidateRecords l) := transform
			self.acctno:=l.acctno;
			self.isSearchFailed := l.isSearchFailed;
			self.keysfailed_decode := l.keysfailed_decode;
			self.ProcessingMessage := if(l.isSearchFailed and l.keysfailed_decode = 'NoHit',10,203);
			self:=l;
			self:=[];
	end;
	Shared doProcessGoldenRecords (Dataset(Healthcare_Shared.Layouts.CombinedHeaderResults) rawRecs,Dataset(Healthcare_Shared.Layouts_Header.CandidateRecords) candidates, dataset(Healthcare_Shared.Layouts.userInputCleanMatch) input, dataset(Healthcare_Shared.Layouts.common_runtime_config) cfg = RunTimeConfig) := function
		failedSearchesShell := project(candidates(isSearchFailed=true),buildFailureRecord(left));
		failedSearches := join(input,failedSearchesShell,left.acctno=right.acctno,transform(Healthcare_Shared.Layouts.CombinedHeaderResultsDoxieLayout,self.userinput:=left;self:=right),keep(Healthcare_Shared.Constants.MAX_RECS_ON_JOIN), limit(0));
		//Rollup across Data Sources
		groupedRecs := group(rawRecs, acctno,internalID,lnpid,lnfid);
		rolledRecs := rollup(groupedRecs, group, Healthcare_Shared.Transforms.doMergeSourcesRollup(left,rows(left),cfg));
		//Score Records
		scoredRecs := if(cfg[1].SkipScoring,rolledRecs,Healthcare_Shared.Functions_Score_Record.ScoreRec(rolledRecs));
		//Update Verification Flags with Header Results
		scoredRecs_W_Flags := project(scoredRecs, transform(Healthcare_Shared.Layouts.CombinedHeaderResults,
							filterCandidates := candidates(acctno=left.acctno and lnpid=left.lnpid and lnfid=left.lnfid);
							filterTable := dedup(sort(filterCandidates,acctno),acctno);
							Verif := project(filterTable, transform(Healthcare_Shared.Layouts.Verifications,
																self.NPISuppliedExists := filterTable[1].IndivFlags.NPIUserSuppliedExists;
																self.NPISuppliedExistsAuth := filterTable[1].IndivFlags.NPIUserSuppliedExistsAuth;
																self.NPIFlags := filterTable[1].IndivFlags.NPIHeaderFlag;
																self.DEASuppliedExists := filterTable[1].IndivFlags.DEA1UserSuppliedExists;
																self.DEASuppliedExistsAuth := filterTable[1].IndivFlags.DEA1UserSuppliedExistsAuth;
																self.DEAFlags := filterTable[1].IndivFlags.DEA1HeaderFlag;
																self.DEA2SuppliedExists := filterTable[1].IndivFlags.DEA2UserSuppliedExists;
																self.DEA2SuppliedExistsAuth := filterTable[1].IndivFlags.DEA2UserSuppliedExistsAuth;
																self.DEA2Flags := filterTable[1].IndivFlags.DEA2HeaderFlag;
																self.UPINSuppliedExists := filterTable[1].IndivFlags.UPINUserSuppliedExists;
																self.UPINSuppliedExistsAuth := filterTable[1].IndivFlags.UPINUserSuppliedExistsAuth;
																self.UPINFlags := filterTable[1].IndivFlags.UPINHeaderFlag;
																self.License1SuppliedExists := filterTable[1].IndivFlags.StLic1UserSuppliedExists;
																self.License1SuppliedExistsAuth := filterTable[1].IndivFlags.StLic1UserSuppliedExistsAuth;
																self.License1Flags := filterTable[1].IndivFlags.StLic1HeaderFlag;
																self.CLIASuppliedExists := filterTable[1].BusFlags.CLIAUserSuppliedExists;
																self.CLIASuppliedExistsAuth := filterTable[1].BusFlags.CLIAUserSuppliedExistsAuth;
																self.CLIAFlags := filterTable[1].BusFlags.CLIAHeaderFlag;
																self.NCPDPSuppliedExists := filterTable[1].BusFlags.NCPDPUserSuppliedExists;
																self.NCPDPSuppliedExistsAuth := filterTable[1].BusFlags.NCPDPUserSuppliedExistsAuth;
																self.NCPDPFlags := filterTable[1].BusFlags.NCPDPHeaderFlag;
																self := left;));
									self.VerificationInfo := Verif;
									self:=left;));
		//Run Rules Manager to populate Child datasets with Best data and set Correction data
		applyRules := map(cfg[1].ProductRules in [Healthcare_Shared.Constants.ProductRules_ProviderPoint,Healthcare_Shared.Constants.ProductRules_SelectFile,Healthcare_Shared.Constants.ProductRules_ClaimsCleanse] => Healthcare_Rules_PP_SF.RulesManager.processRules(scoredRecs_W_Flags,cfg),
											cfg[1].ProductRules in [Healthcare_Shared.Constants.ProductRules_DES,Healthcare_Shared.Constants.ProductRules_MasterFile] => Healthcare_Rules_DES_MF.RulesManager.processRules(scoredRecs_W_Flags,cfg),
											Healthcare_Rules_PP_SF.RulesManager.processRules(scoredRecs_W_Flags,cfg));
		//Do Penalty
		applyPenalty := Healthcare_Shared.Functions.doPenalty(applyRules,dedup(sort(input,acctno),acctno),cfg[1]);
		//Get Additional Append Data for customer data
		refmtResults := project(applyPenalty, transform(Healthcare_Shared.Layouts.CombinedHeaderResultsDoxieLayout,self:=left;self:=[];));
		refmtInput := project(input, transform(Healthcare_Shared.Layouts.autokeyInput, self:=left;self:=[]));
		Valid_Lic_Company := Healthcare_CustomerLicense.Raw.verify_Company(cfg[1].CustomerID);
		fmtRec_w_CustomerLicense := if(cfg[1].includeCustomerData and Valid_Lic_Company,Healthcare_Shared.Fn_get_CustomerData.appendCustomerLicenseData(refmtInput, refmtResults,cfg),refmtResults);
		Valid_Death_Company := Healthcare_CustomerDeath.Raw.verify_Company(cfg[1].CustomerID);
		fmtRec_w_CustomerDeath := if(cfg[1].includeCustomerData and Valid_Death_Company,Healthcare_Shared.Fn_get_CustomerData.appendCustomerDeathData(refmtInput, fmtRec_w_CustomerLicense,cfg),fmtRec_w_CustomerLicense);
		//Populate Validations  Reveiw CIC's for Exists fields that are not getting populate yet.
		fmtRec_Final := Healthcare_Shared.Fn_do_Validation.processVerifications(fmtRec_w_CustomerDeath,cfg);
		//Return everything + Failed records
		// output (scoredRecs,Named('doPGoldenRecs_scoredrecs'),extend);
		// output (scoredRecs_W_Flags,Named('doPGoldenRecs_scoredRecs_W_Flags'),extend);
		// output (applyRules,Named('doPGoldenRecs_applyRules'),extend);
		// output (applyPenalty,Named('doPGoldenRecs_applyPenalty'),extend);
		// output (failedSearches,Named('doPGoldenRecs_failedSearches'),extend);
		// output (fmtRec_Final,Named('doPGoldenRecs_fmtRec_Final'),extend);
		return sort(fmtRec_Final+failedSearches,acctno);
	end;
	Export getProviderRecordsOnly (Dataset(Healthcare_Shared.Layouts_Header.CandidateRecords) candidates, dataset(Healthcare_Shared.Layouts.userInputCleanMatch) input, dataset(Healthcare_Shared.Layouts.common_runtime_config) cfg = RunTimeConfig) := function
		rawRecs:=Healthcare_Shared.Fn_get_RawRecords.getProviderRecords(Candidates,input,cfg);
		finalRecs := doProcessGoldenRecords(rawRecs,Candidates,input,cfg);
		return finalRecs;
	end;
	Export getFacilityRecordsOnly (Dataset(Healthcare_Shared.Layouts_Header.CandidateRecords) candidates, dataset(Healthcare_Shared.Layouts.userInputCleanMatch) input, dataset(Healthcare_Shared.Layouts.common_runtime_config) cfg = RunTimeConfig) := function
		rawRecs:=Healthcare_Shared.Fn_get_RawRecords.getFacilityRecords(Candidates,input,cfg);
		finalRecs := doProcessGoldenRecords(rawRecs,Candidates,input,cfg);
		return finalRecs;
	end;
	Export getRecords (Dataset(Healthcare_Shared.Layouts_Header.CandidateRecords) candidates, dataset(Healthcare_Shared.Layouts.userInputCleanMatch) input, dataset(Healthcare_Shared.Layouts.common_runtime_config) cfg = RunTimeConfig) := function
		rawRecs:=Healthcare_Shared.Fn_get_RawRecords.getRecords(Candidates,input,cfg);
		finalRecs := doProcessGoldenRecords(rawRecs,Candidates,input,cfg);
		return finalRecs;
	end;
End;