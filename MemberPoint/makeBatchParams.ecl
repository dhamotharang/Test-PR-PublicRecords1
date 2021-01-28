IMPORT Gateway, iesp, Std;

	EXPORT makeBatchParams(iesp.keepcontactreport.t_KeepContactReportOption inOpts) := FUNCTION
		optAddressConfidenceThreshold:=(STRING1)MemberPoint.Constants.Defaults.AddressConfidenceThreshold;
		optDeceasedMatchCodes:=IF(inOpts.DeceasedMatchCodes='',MemberPoint.Constants.Defaults.DeceasedMatchCodes,inOpts.DeceasedMatchCodes);
		optPhonesReturnCutoff:=IF(inOpts.PhonesReturnCutoff='',MemberPoint.Constants.Defaults.PhonesReturnCutoff,inOpts.PhonesReturnCutoff);
		optTransactionType:=IF(inOpts.PhoneTransactionType='',MemberPoint.Constants.PhoneTransactionType.WaterfallPhones,inOpts.PhoneTransactionType);
		optUseDMEmailSourcesOnly:=IF(inOpts.EmailTransactionType = MemberPoint.Constants.EmailTransactionType.Premium, MemberPoint.Constants.EmailTransactionType.Premium_UseDMEmailSourcesOnly, MemberPoint.Constants.EmailTransactionType.Basic_UseDMEmailSourcesOnly);
		optUniqueIdScoreThreshold:=(INTEGER) MAP(
											Std.Str.ToUpperCase(TRIM(inOpts.UniqueIdScoreThreshold, left, right)) = 'H' => MemberPoint.Constants.Defaults.UniqueIdScoreThreshold_H,
											Std.Str.ToUpperCase(TRIM(inOpts.UniqueIdScoreThreshold, left, right)) = 'M' => MemberPoint.Constants.Defaults.UniqueIdScoreThreshold_M,
											MemberPoint.Constants.Defaults.UniqueIdScoreThreshold_L);

		base_params := MemberPoint.IParam.getBatchParams();
		// project the base params to read shared parameters from store.
		BatchParams := MODULE(PROJECT(base_params, MemberPoint.IParam.BatchParams, OPT))
		// Specefic to memberpoint
			export string	DeceasedMatchCodes := optDeceasedMatchCodes;
			export boolean UseDOBDeathMatch := MemberPoint.Util.binStrToBool(inOpts.UseDOBDeathMatch, MemberPoint.Constants.Defaults.UseDOBDeathMatch_reportservice);
			export boolean IncludeEmail := MemberPoint.Util.binStrToBool(inOpts.IncludeEmailProcess, MemberPoint.Constants.Defaults.rpt_IncludeEmail);
			export boolean IncludePhone := MemberPoint.Util.binStrToBool(inOpts.IncludePhoneProcess, MemberPoint.Constants.Defaults.rpt_IncludePhone);
			export boolean IncludeAddress := MemberPoint.Util.binStrToBool(inOpts.IncludeAddressProcess, MemberPoint.Constants.Defaults.rpt_IncludeAddress);
			export boolean IncludeDeceased := MemberPoint.Util.binStrToBool(inOpts.IncludeDeceasedProcess, MemberPoint.Constants.Defaults.rpt_IncludeDeceased);
			export boolean IncludeDOB := MemberPoint.Util.binStrToBool(inOpts.IncludeDOB, MemberPoint.Constants.Defaults.rpt_IncludeDOB);
			export boolean IncludeSSN := MemberPoint.Util.binStrToBool(inOpts.IncludeSSN, MemberPoint.Constants.Defaults.rpt_IncludeSSN);
			export boolean IncludeGender := MemberPoint.Util.binStrToBool(inOpts.IncludeGender, MemberPoint.Constants.Defaults.rpt_IncludeGender);
			export string1 PhonesReturnCutoff := optPhonesReturnCutoff; 
			export INTEGER UniqueIdScoreThreshold := optUniqueIdScoreThreshold;
			export string1 AddressConfidenceThreshold :=  optAddressConfidenceThreshold;
			export DATASET(Gateway.Layouts.Config) gateways :=  Gateway.Configuration.Get(); // dataset ([], Gateway.Layouts.Config);
			//MP Enhancements
			EXPORT BOOLEAN AllowNickNames:= inOpts.UseNicknames;
			EXPORT BOOLEAN PhoneticMatch:= inOpts.UsePhonetics;
			//Deceased
			EXPORT BOOLEAN IncludeBlankDOD:= inOpts.IncludeBlankDOD;
			//Email: All covered by inheritance
			EXPORT BOOLEAN UseDMEmailSourcesOnly:= optUseDMEmailSourcesOnly;
			//ADLBest: All covered by inheritance
			//BestAddress
			EXPORT BOOLEAN IncludeBlankDateLastSeen:= inOpts.IncludeBlankDateLastSeen;
			EXPORT BOOLEAN IncludeHistoricRecords:= inOpts.IncludeHistoricRecords;
			//Waterfall: All covered by inheritance
			//PhoneFinder
			EXPORT UNSIGNED2 PenaltThreshold:= (UNSIGNED)inOpts.PenaltyThreshold;
			
			EXPORT STRING1 StrTransactionType:= optTransactionType;
			BOOLEAN IsPhoneFinderOperation:= Std.Str.ToUpperCase(StrTransactionType) <> MemberPoint.Constants.PhoneTransactionType.WaterfallPhones;				
			EXPORT UNSIGNED1 TransactionType:= IF(IsPhoneFinderOperation,(UNSIGNED1)StrTransactionType, (UNSIGNED1)MemberPoint.Constants.Defaults.TransactionType);
			
			EXPORT STRING1 PhoneFilter:= inOpts.PhoneFilter;
		END;
		RETURN BatchParams;
		
	END;
  