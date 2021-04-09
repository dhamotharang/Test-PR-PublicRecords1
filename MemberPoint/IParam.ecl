 IMPORT BatchShare, MemberPoint, Std, progressive_phone;

	MPD:= MemberPoint.Constants.Defaults;

	export IParam := module
		
		export BatchParams := interface (BatchShare.IParam.BatchParams)			
			export string1 AddressConfidenceThreshold := MPD.AddressConfidenceThreshold ;
			export string	DeceasedMatchCodes := MPD.DeceasedMatchCodes;
			export boolean IncludeAddress := MPD.IncludeAddress;
			export boolean IncludeDeceased := MPD.IncludeDeceased;
			export boolean IncludeEmail := MPD.IncludeEmail;
			export boolean IncludeGender := MPD.IncludeGender;
			export boolean IncludePhone := MPD.IncludePhone;
			export boolean IncludeDOB := MPD.IncludeDOB;
			export boolean IncludeSSN := MPD.IncludeSSN;
			EXPORT STRING5 industry_class := MPD.IndustryClass;
			export string25 Phones_Score_Model := MPD.Phones_Score_Model;
			export string1 PhonesReturnCutoff := MPD.PhonesReturnCutoff;
			EXPORT BOOLEAN ReturnDetailedRoyalties := MPD.ReturnDetailedRoyalties;
			export INTEGER UniqueIdScoreThreshold := MPD.UniqueIdScoreThreshold ;
			export boolean UseDOBDeathMatch := MPD.UseDOBDeathMatch;

			//MP Enhancements
			
			EXPORT BOOLEAN AllowNickNames:= MPD.AllowNickNames;
			EXPORT BOOLEAN Match_City:= MPD.Match_City;
			EXPORT BOOLEAN Match_DOB:= MPD.Match_DOB;
			EXPORT BOOLEAN Match_LinkID:= MPD.Match_LinkID;
			EXPORT BOOLEAN Match_Name:= MPD.Match_Name;
			EXPORT BOOLEAN Match_SSN:= MPD.Match_SSN;
			EXPORT BOOLEAN Match_State:= MPD.Match_State;
			EXPORT BOOLEAN Match_Street_Address:= MPD.Match_Street_Address;
			EXPORT BOOLEAN Match_Zip:= MPD.Match_Zip;
			EXPORT BOOLEAN PhoneticMatch:= MPD.PhoneticMatch;
			// ADLBest
			EXPORT STRING120 Appends:= MPD.Appends;
			EXPORT STRING3 AppendThreshold:= MPD.AppendThreshold;
			EXPORT BOOLEAN Deduped:= MPD.Deduped;
			EXPORT STRING120 Fuzzies:= MPD.Fuzzies;
			EXPORT BOOLEAN PatriotProcess:= MPD.PatriotProcess;
			EXPORT STRING120 Verify:= MPD.Verify;
			//BestAddress
			EXPORT BOOLEAN CalculateV1Scores:= MPD.CalculateV1Scores;
			EXPORT UNSIGNED DateLastSeen:=MPD.DateLastSeen;
			EXPORT BOOLEAN DoNOTRollupDateFirstSeen:= MPD.DoNOTRollupDateFirstSeen;
			EXPORT BOOLEAN EndWithNextMostCurrent:= MPD.EndWithNextMostCurrent;
			EXPORT BOOLEAN FirstInitialLastNameMatch:= MPD.FirstInitialLastNameMatch;
			EXPORT BOOLEAN FirstNameLastNameMatch:= MPD.FirstNameLastNameMatch;
			EXPORT BOOLEAN FirstNameMatch:= MPD.FirstNameMatch;
			EXPORT BOOLEAN FullNameMatch:= MPD.FullNameMatch;
			EXPORT BOOLEAN HistoricMatchCodes:= MPD.HistoricMatchCodes;
			EXPORT BOOLEAN Include_Military_Address:= MPD.Include_Military_Address;
			EXPORT BOOLEAN IncludeBlankDateLastSeen:= MPD.IncludeBlankDateLastSeen;
			EXPORT BOOLEAN IncludeHistoricRecords:= MPD.IncludeHistoricRecords;
			EXPORT BOOLEAN InputAddressDedup:= MPD.InputAddressDedup;
			EXPORT BOOLEAN LastNameMatch:= MPD.LastNameMatch;
			EXPORT UNSIGNED1 MaxNameScore:= MPD.MaxNameScore;
			EXPORT UNSIGNED1 MaxRecordsToReturn:= MemberPoint.Constants.MaxRecordsToReturn;
			EXPORT UNSIGNED1 MinNameScore:= MPD.MinNameScore;
			EXPORT BOOLEAN PartialAddressDedup:= MPD.PartialAddressDedup;
			EXPORT BOOLEAN ReturnAddrPhone:= MPD.ReturnAddrPhone;
			EXPORT BOOLEAN ReturnConfidenceFlag:= MPD.ReturnConfidenceFlag;
			EXPORT BOOLEAN ReturnConfirmedMatchCode:= MPD.ReturnConfirmedMatchCode;
			EXPORT BOOLEAN ReturnCountyName:= MPD.ReturnCountyName;
			EXPORT BOOLEAN ReturnDedupFlag:= MPD.ReturnDedupFlag;
			EXPORT BOOLEAN ReturnFlipFlopIndicator:= MPD.ReturnFlipFlopIndicator;
			EXPORT BOOLEAN ReturnLatLong:= MPD.ReturnLatLong;
			EXPORT BOOLEAN ReturnMultiADLIndicator:= MPD.ReturnMultiADLIndicator;
			EXPORT BOOLEAN ReturnOverLimitIndicator:= MPD.ReturnOverLimitIndicator;
			EXPORT BOOLEAN ReturnSSNLooseMatchIndicator:= MPD.ReturnSSNLooseMatchIndicator;
			EXPORT BOOLEAN ReturnUnServAddrIndicator:= MPD.ReturnUnServAddrIndicator;
			EXPORT BOOLEAN StartWithNextMostCurrent:= MPD.StartWithNextMostCurrent;
			EXPORT BOOLEAN UnServAddrDedup:= MPD.UnServAddrDedup;
			EXPORT BOOLEAN UseNameUniqueDID:= MPD.UseNameUniqueDID;
			//Deceased
			EXPORT BOOLEAN AddSupplemental:= MPD.AddSupplemental;
			EXPORT UNSIGNED2 DaysBack:= MPD.DaysBack;
			EXPORT BOOLEAN ExtraMatchCodes:= MPD.ExtraMatchCodes;
			EXPORT BOOLEAN IncludeBlankDOD:= MPD.IncludeBlankDOD;
			EXPORT BOOLEAN MatchCodeADLAppend:= MPD.MatchCodeADLAppend;
			EXPORT BOOLEAN NoDIDAppend:= MPD.NoDIDAppend;
			EXPORT BOOLEAN PartialNameMatchCodes:= MPD.PartialNameMatchCodes;
			//Email: All common
			EXPORT BOOLEAN useDMEmailSourcesOnly:= MPD.UseDMEmailSourcesOnly;
			//PhoneFinder
			EXPORT STRING1 PhoneFilter:= MPD.PhoneFilter;
			EXPORT STRING1 StrTransactionType:= MPD.TransactionType;
			EXPORT UNSIGNED1 TransactionType:= (UNSIGNED1)MPD.TransactionType;
			//Waterfall
			EXPORT BOOLEAN BlankOutDuplicatePhones:= MPD.BlankOutDuplicatePhones;
			EXPORT BOOLEAN DedupInputPhones:= MPD.DedupInputPhones;
			EXPORT TYPEOF(progressive_phone.waterfall_phones_options.DIDConfidenceThreshold) DIDConfidenceThreshold;
			EXPORT BOOLEAN IncludeLastResort:= MPD.IncludeLastResort;
			EXPORT UNSIGNED2 MaxNumAssociate:= MPD.MaxNumAssociate;
			EXPORT UNSIGNED2 MaxNumAssociateOther:= MPD.MaxNumAssociateOther;
			EXPORT UNSIGNED2 MaxNumFamilyClose:= MPD.MaxNumFamilyClose;
			EXPORT UNSIGNED2 MaxNumFamilyOther:= MPD.MaxNumFamilyOther;
			EXPORT UNSIGNED2 MaxNumNeighbor:= MPD.MaxNumNeighbor;
			EXPORT UNSIGNED2 MaxNumParent:= MPD.MaxNumParent;
			EXPORT UNSIGNED2 MaxNumSpouse:= MPD.MaxNumSpouse;
			EXPORT UNSIGNED2 MaxNumSubject:= MPD.MaxNumSubject;
			EXPORT INTEGER MaxPhoneCount:= MPD.MaxPhoneCount;
			EXPORT BOOLEAN ReturnScore:= MPD.ReturnScore;
			EXPORT BOOLEAN StrictAPSX:= MPD.StrictAPSX;
			EXPORT BOOLEAN UsePremiumSource_A := MPD.UsePremiumSource_A;
      		EXPORT INTEGER PremiumSource_A_limit := MPD.PremiumSource_A_limit;
		end;

		// **************************************************************************************
		//   This is where the service options should be read from #store.
		//	 The module parameter should be passed along to the underlying attributes.
		// **************************************************************************************			
		export getBatchParams():= FUNCTION
			base_params := BatchShare.IParam.getBatchParams();
			// project the base params to read shared parameters from store.
			in_mod := MODULE(project(base_params, BatchParams, opt))
				export string1	AddressConfidenceThreshold := MPD.AddressConfidenceThreshold  : stored('AddressConfidenceThreshold');
				export string	DeceasedMatchCodes := MPD.DeceasedMatchCodes  : stored('DeceasedMatchCodes');
				export boolean IncludeAddress := MPD.IncludeAddress  : stored('IncludeAddress');
				export boolean IncludeDeceased := MPD.IncludeDeceased  : stored('IncludeDeceased');
				export boolean IncludeEmail := MPD.IncludeEmail  : stored('IncludeEmail');
				export boolean IncludeGender := MPD.IncludeGender  : stored('IncludeGender');
				export boolean IncludePhone := MPD.IncludePhone  : stored('IncludePhone');
				export boolean IncludeDOB := MPD.IncludeDOB  : stored('IncludeDOB');
				export boolean IncludeSSN := MPD.IncludeSSN  : stored('IncludeSSN');
				EXPORT STRING5 industry_class := MPD.IndustryClass : STORED('IndustryClass');
				EXPORT STRING25 Phones_Score_Model := MPD.Phones_Score_Model:STORED('Phone_Score_Model');
				export string1 PhonesReturnCutoff := MPD.PhonesReturnCutoff:STORED('PhonesReturnCutoff');
				EXPORT BOOLEAN ReturnDetailedRoyalties := MPD.ReturnDetailedRoyalties:STORED('ReturnDetailedRoyalties');
				export INTEGER UniqueIdScoreThreshold := MPD.UniqueIdScoreThreshold:stored('UniqueIdScoreThreshold');
				export boolean UseDOBDeathMatch := MPD.UseDOBDeathMatch:stored('UseDOBDeathMatch');

				//MP Enhancements
				EXPORT BOOLEAN AllowNickNames:= MPD.AllowNickNames : STORED('AllowNickNames');
				EXPORT BOOLEAN PhoneticMatch:= MPD.PhoneticMatch : STORED('PhoneticMatch');
				EXPORT BOOLEAN Match_City:= progressive_phone.waterfall_phones_options.CityMatch;
				EXPORT BOOLEAN Match_DOB:= MPD.Match_DOB : STORED('Match_DOB');
				EXPORT BOOLEAN Match_LinkID:= progressive_phone.waterfall_phones_options.DIDMatch;
				EXPORT BOOLEAN Match_Name:= progressive_phone.waterfall_phones_options.NameMatch;
				EXPORT BOOLEAN Match_SSN:= progressive_phone.waterfall_phones_options.SSNMatch;
				EXPORT BOOLEAN Match_State:= progressive_phone.waterfall_phones_options.StateMatch;
				EXPORT BOOLEAN Match_Street_Address:= progressive_phone.waterfall_phones_options.StreetAddressMatch;
				EXPORT BOOLEAN Match_Zip:= progressive_phone.waterfall_phones_options.ZipMatch;
				//ADLBest
   			EXPORT STRING120 Appends:= MPD.Appends : STORED('Appends');
   			EXPORT STRING3 AppendThreshold:= MPD.AppendThreshold : STORED('AppendThreshold');
   			EXPORT BOOLEAN Deduped:= MPD.Deduped : STORED('Deduped');
   			EXPORT STRING120 Fuzzies:= MPD.Fuzzies : STORED('Fuzzies');
   			EXPORT BOOLEAN PatriotProcess:= MPD.PatriotProcess : STORED('PatriotProcess');
   			EXPORT STRING120 Verify:= MPD.Verify : STORED('Verify');
				//BestAddress
   			EXPORT BOOLEAN CalculateV1Scores:= MPD.CalculateV1Scores : STORED('CalculateV1Scores');
   			EXPORT UNSIGNED DateLastSeen:= MPD.DateLastSeen : STORED('DateLastSeen');
   			EXPORT BOOLEAN DoNOTRollupDateFirstSeen:= MPD.DoNOTRollupDateFirstSeen : STORED('DoNOTRollupDateFirstSeen');
   			EXPORT BOOLEAN EndWithNextMostCurrent:= MPD.EndWithNextMostCurrent : STORED('EndWithNextMostCurrent');
   			EXPORT BOOLEAN FirstInitialLastNameMatch:= MPD.FirstInitialLastNameMatch : STORED('FirstInitialLastNameMatch');
   			EXPORT BOOLEAN FirstNameLastNameMatch:= MPD.FirstNameLastNameMatch : STORED('FirstNameLastNameMatch');
   			EXPORT BOOLEAN FirstNameMatch:= MPD.FirstNameMatch : STORED('FirstNameMatch');
   			EXPORT BOOLEAN FullNameMatch:= MPD.FullNameMatch : STORED('FullNameMatch');
   			EXPORT BOOLEAN HistoricMatchCodes:= MPD.HistoricMatchCodes : STORED('HistoricMatchCodes');
   			EXPORT BOOLEAN Include_Military_Address:= MPD.Include_Military_Address : STORED('Include_Military_Address');
   			EXPORT BOOLEAN IncludeBlankDateLastSeen:= MPD.IncludeBlankDateLastSeen : STORED('IncludeBlankDateLastSeen');
   			EXPORT BOOLEAN IncludeHistoricRecords:= MPD.IncludeHistoricRecords : STORED('IncludeHistoricRecords');
   			EXPORT BOOLEAN InputAddressDedup:= MPD.InputAddressDedup : STORED('InputAddressDedup');
   			EXPORT BOOLEAN LastNameMatch:= MPD.LastNameMatch : STORED('LastNameMatch');
   			EXPORT UNSIGNED1 MaxNameScore:= MPD.MaxNameScore : STORED('Max_Name_Score');
   			EXPORT UNSIGNED1 MaxRecordsToReturn:= MemberPoint.Constants.MaxRecordsToReturn : STORED('MaxRecordsToReturn');
   			EXPORT UNSIGNED1 MinNameScore:= MPD.MinNameScore : STORED('Min_Name_Score');
   			EXPORT BOOLEAN PartialAddressDedup:= MPD.PartialAddressDedup : STORED('PartialAddressDedup');
   			EXPORT BOOLEAN ReturnAddrPhone:= MPD.ReturnAddrPhone : STORED('ReturnAddrPhone');
   			EXPORT BOOLEAN ReturnConfidenceFlag:= MPD.ReturnConfidenceFlag : STORED('ReturnConfidenceFlag');
   			EXPORT BOOLEAN ReturnConfirmedMatchCode:= MPD.ReturnConfirmedMatchCode : STORED('ReturnConfirmedMatchCode');
   			EXPORT BOOLEAN ReturnCountyName:= MPD.ReturnCountyName : STORED('ReturnCountyName');
   			EXPORT BOOLEAN ReturnDedupFlag:= MPD.ReturnDedupFlag : STORED('ReturnDedupFlag');
   			EXPORT BOOLEAN ReturnFlipFlopIndicator:= MPD.ReturnFlipFlopIndicator : STORED('ReturnFlipFlopIndicator');
   			EXPORT BOOLEAN ReturnLatLong:= MPD.ReturnLatLong : STORED('ReturnLatLong');
   			EXPORT BOOLEAN ReturnMultiADLIndicator:= MPD.ReturnMultiADLIndicator : STORED('ReturnMultiADLIndicator');
   			EXPORT BOOLEAN ReturnOverLimitIndicator:= MPD.ReturnOverLimitIndicator : STORED('ReturnOverLimitIndicator');
   			EXPORT BOOLEAN ReturnSSNLooseMatchIndicator:= MPD.ReturnSSNLooseMatchIndicator : STORED('ReturnSSNLooseMatchIndicator');
   			EXPORT BOOLEAN ReturnUnServAddrIndicator:= MPD.ReturnUnServAddrIndicator : STORED('ReturnUnServAddrIndicator');
   			EXPORT BOOLEAN StartWithNextMostCurrent:= MPD.StartWithNextMostCurrent : STORED('StartWithNextMostCurrent');
   			EXPORT BOOLEAN UnServAddrDedup:= MPD.UnServAddrDedup : STORED('UnServAddrDedup');
   			EXPORT BOOLEAN UseNameUniqueDID:= MPD.UseNameUniqueDID : STORED('UseNameUniqueDID');
				//Deceased
   			EXPORT BOOLEAN AddSupplemental:= MPD.AddSupplemental : STORED('AddSupplemental');
   			EXPORT UNSIGNED2 DaysBack:= MPD.DaysBack : STORED('DaysBack');
   			EXPORT BOOLEAN ExtraMatchCodes:= MPD.ExtraMatchCodes : STORED('ExtraMatchCodes');
   			EXPORT BOOLEAN IncludeBlankDOD:= MPD.IncludeBlankDOD : STORED('IncludeBlankDOD');
   			EXPORT BOOLEAN MatchCodeADLAppend:= MPD.MatchCodeADLAppend : STORED('MatchCode_ADL_Append');
   			EXPORT BOOLEAN NoDIDAppend:= MPD.NoDIDAppend : STORED('NoDIDAppend');
   			EXPORT BOOLEAN PartialNameMatchCodes:= MPD.PartialNameMatchCodes : STORED('PartialNameMatchCodes');
				//Email: All common
			EXPORT boolean useDMEmailSourcesOnly := MPD.UseDMEmailSourcesOnly : STORED('UseDMEmailSourcesOnly');
				//PhoneFinder
   			EXPORT UNSIGNED2 PenaltThreshold:= MPD.PenaltyThreshold : STORED('PenaltThreshold');
   			EXPORT STRING1 PhoneFilter:= MPD.PhoneFilter : STORED('PhoneFilter');

				STRING1 StoredTransactionType:= MPD.TransactionType : STORED('TransactionType');
				EXPORT STRING1 StrTransactionType:= IF(StoredTransactionType='', MPD.TransactionType, StoredTransactionType);

				BOOLEAN IsPhoneFinderOperation:= Std.Str.ToUpperCase(StrTransactionType) <> MemberPoint.Constants.PhoneTransactionType.WaterfallPhones;				
   			EXPORT UNSIGNED1 TransactionType:= IF(IsPhoneFinderOperation,(UNSIGNED1)StrTransactionType, (UNSIGNED1)MPD.TransactionType);
				//Waterfall
				EXPORT BOOLEAN BlankOutDuplicatePhones:= MPD.BlankOutDuplicatePhones : STORED('BlankOutDuplicatePhones');
				EXPORT BOOLEAN DedupInputPhones:= MPD.DedupInputPhones : STORED('DedupAgainstInputPhones');
				EXPORT TYPEOF(progressive_phone.waterfall_phones_options.DIDConfidenceThreshold) DIDConfidenceThreshold:= progressive_phone.waterfall_phones_options.DIDConfidenceThreshold;
				EXPORT BOOLEAN IncludeLastResort:= MPD.IncludeLastResort : STORED('IncludeLastResort');
				EXPORT UNSIGNED2 MaxNumAssociate:= MPD.MaxNumAssociate : STORED('MaxNumAssociate');
				EXPORT UNSIGNED2 MaxNumAssociateOther:= MPD.MaxNumAssociateOther : STORED('MaxNumAssociateOther');
				EXPORT UNSIGNED2 MaxNumFamilyClose:= MPD.MaxNumFamilyClose : STORED('MaxNumFamilyClose');
				EXPORT UNSIGNED2 MaxNumFamilyOther:= MPD.MaxNumFamilyOther : STORED('MaxNumFamilyOther');
				EXPORT UNSIGNED2 MaxNumNeighbor:= MPD.MaxNumNeighbor : STORED('MaxNumNeighbor');
				EXPORT UNSIGNED2 MaxNumParent:= MPD.MaxNumParent : STORED('MaxNumParent');
				EXPORT UNSIGNED2 MaxNumSpouse:= MPD.MaxNumSpouse : STORED('MaxNumSpouse');
				EXPORT UNSIGNED2 MaxNumSubject:= MPD.MaxNumSubject : STORED('MaxNumSubject');
				EXPORT INTEGER MaxPhoneCount:= MPD.MaxPhoneCount : STORED('MaxPhoneCount');
				EXPORT BOOLEAN ReturnScore:= MPD.ReturnScore : STORED('ReturnScore');
				EXPORT BOOLEAN StrictAPSX:= MPD.StrictAPSX : STORED('StrictAPSXMatch');
				Export BOOLEAN KeepUndeliverableEmail := MPD.KeepUndeliverableEmail: STORED('KeepUndeliverableEmail');
			END;
			RETURN in_mod;
		END;
		
	end;