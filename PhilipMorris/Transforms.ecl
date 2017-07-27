import doxie, header, ut, mdr, iesp, didville, AddrBest, DayBatchEDA, NID;

CN := PhilipMorris.Constants;
LT := PhilipMorris.Layouts;
LTB := PhilipMorris.Layouts_Batch;
FN := PhilipMorris.Functions;
LB := AddrBest.Layout_BestAddr;
LBO := DayBatchEDA.Layout_Batch_Out;

export Transforms := MODULE

	EXPORT LT.InRecord.Dirty.FullRecordWithSequence xfm_append_seqno(LT.InRecord.Dirty.FullRecord le, INTEGER C) := transform
		Self.InternalSeqNo := c;
		self.InputEcho := le.InputEcho;
		SELF := le;
	END;
	
	EXPORT LT.InRecord.Dirty.SSN4FullRecordWithSequence xfm_append_seqno_ssn4(LT.InRecord.Dirty.SSN4FullRecord le, INTEGER C) := transform
		Self.InternalSeqNo := c;
		self.InputEcho := le.InputEcho;
		SELF := le;
	END;
		
	shared MAC_SetCleanData() := MACRO
			Self.InternalSeqNo := InputData.InternalSeqNo;
			Self.SearchName  := FN.fn_getCleanName(InputData.NameLast, InputData.NameFirst, InputData.NameMiddle, InputData.NameSuffix, InputData.Title);
			Self.SearchNameNonCleaner := FN.fn_getCleanName(InputData.NameLast, InputData.NameFirst, InputData.NameMiddle, InputData.NameSuffix, InputData.Title, false);
			Self.GIIDAddress := FN.fn_getCleanAddress(InputData.GIIDAddress, CN.AddressTypeEnum.GIID );
			Self.CurrentAddress  := FN.fn_getCleanAddress(InputData.CurrentAddress, CN.AddressTypeEnum.CURRENT );
			Self.PreviousAddress  := FN.fn_getCleanAddress(InputData.PreviousAddress, CN.AddressTypeEnum.PREVIOUS );		
			Self.SSN							:= FN.fn_CleanSSN(InputData.SSN);
			Self.SSN4							:= IF(FN.fn_getLen(Self.SSN) >=4, 
																	FN.fn_CleanSSN4(Self.SSN[FN.fn_getLen(Self.SSN)-3..]), '');
			Self.IsSearchableSSN  := FN.fn_IsSearchableSSN(Self.SSN);
			Self.IsSearchableSSN4  := FN.fn_IsSearchableSSN4(Self.SSN4);
			Self.DOB_YYYYMMDD			:= FN.fn_CleanDOB(InputData.DOB_YYYYMMDD);
			Self.DOB_Numeric := (UNSIGNED4)(SELF.DOB_YYYYMMDD);
			
			Self.TodayYYYYMMDD := StringLib.getdateYYYYMMDD();
			Self.TodayYear := (UNSIGNED2)(Self.TodayYYYYMMDD[1..4]);
			Self.TodayYearMonth := (UNSIGNED4)(Self.TodayYYYYMMDD[1..6]);
			Self.TodayYearMonthDay := (UNSIGNED4)(Self.TodayYYYYMMDD[1..8]);	
	ENDMACRO;
	
	EXPORT LT.Clean.FullRecord xfm_set_clean_data (LT.InRecord.Dirty.FullRecordWithSequence InputData) := TRANSFORM
			MAC_SetCleanData();			
	END;
	
	EXPORT LT.Clean.FullRecord xfm_set_clean_data_ssn4 (LT.InRecord.Dirty.SSN4FullRecordWithSequence InputData) := TRANSFORM					
			MAC_SetCleanData();
	END;
	
	
		//set up the normalized records for searching
	EXPORT LT.Clean.FullRecordNorm xfm_normalize_search_data(LT.Clean.FullRecord le, INTEGER C) := transform
		Self.SearchAddress := MAP(C = CN.AddressTypeEnum.GIID => le.GIIDAddress,
															C = CN.AddressTypeEnum.CURRENT => le.CurrentAddress, 
															C = CN.AddressTypeEnum.PREVIOUS => le.PreviousAddress,
															ROW([], LT.Clean.Address));
		self.SearchSSN := le.SSN;
		self := le;
	END;

	EXPORT LT.OutputRecord.CandidateRecord 
									xfm_process_hdr_records(LT.Search.FullRecordNormWithHeaderData L,																					 
																					 CN.SortSearchPassEnum searchpass,
																					 UNSIGNED2 minAgeValue,
																					 boolean isDerived,
																					 boolean acceptFirstInitialForFirstName,
																					 boolean AllowProbationSources) := TRANSFORM , SKIP (~AllowProbationSources and mdr.SourceTools.SourceIsOnProbation(l.src))
			
			selfCompareName := FN.fn_getCleanName(L.lname, L.fname, L.mname, '', '', false);
			//selfCompareName := FN.fn_getCleanName(L.lname, L.fname, L.mname, '', '');
			//selfCompareNameNoMiddle := if (L.mname <> '', FN.fn_getCleanName(L.lname, L.fname, '', '', ''));
			//selfCompareNoCleaner := FN.fn_getCleanName(L.lname, L.fname, L.mname, '', '', false);
			//selfCompareNoCleanerNoMiddle := if (L.mname <> '', FN.fn_getCleanName(L.lname, L.fname, '', '', '', false));

			self.InternalSeqNo := l.InternalSeqNo;
			self.CandidateName := selfCompareName;
								
			//the address is already cleaned and parsed 			
			self.CandidateAddress.AddressID						:= L.SearchAddress.AddressID;
			self.CandidateAddress.Prim_Range						:= L.prim_range;
			self.CandidateAddress.PreDir							:= L.predir;
			self.CandidateAddress.Prim_Name						:= L.prim_name;
			self.CandidateAddress.Addr_Suffix					:= L.suffix;
			self.CandidateAddress.PostDir							:= L.postdir;
			self.CandidateAddress.Unit_Desig						:= L.unit_desig;
			self.CandidateAddress.Sec_Range						:= L.sec_range;
			self.CandidateAddress.V_City_Name						:= L.city_name;
			self.CandidateAddress.St									:= L.ST;
			self.CandidateAddress.Zip5									:= L.ZIP;
			self.CandidateAddress.Z5Numeric						:= (Integer4)TRIM(L.ZIP);
			self.CandidateAddress.Zip4								:= L.Zip4;
			self.CandidateAddress.fips_county							:= L.county;
			self.CandidateAddress.addr_rec_type						:= '';
			self.CandidateAddress.err_stat					:= '';
			self.CandidateAddress.ISPoBOXType					:= FN.fn_IsPoBox(self.CandidateAddress.Prim_Name);
			self.CandidateAddress.ISRRType						:= FN.fn_RRType(self.CandidateAddress.Prim_Name);
			SELF.DID := L.DID;
			SELF.SSN := FN.fn_CleanSSN(L.SSN);
			Self.IsSearchableSSN  := FN.fn_IsSearchableSSN(Self.SSN);		
			Self.SSN4							:= IF(FN.fn_getLen(Self.SSN) >=4, 
																	FN.fn_CleanSSN4(SELF.SSN[FN.fn_getLen(SELF.SSN)-3..]), '');
			
			SELF.DOB_YYYYMMDD := FN.fn_CleanDOBFromInt(L.DOB);
			SELF.DOB_Numeric := L.DOB;
			SELF.CandidateAddress.PrimNameLen 			:= FN.fn_getLen(L.prim_name);
			SELF.CandidateAddress.PrimRangeLen 			:= FN.fn_getLen(L.prim_range);
			
			/* bugzilla 56745 */
			compareOutputSSN := FN.fn_CleanSSN(L.InternalOnlyOutputSSN);
			compareSSN4 := IF(FN.fn_getLen(compareOutputSSN) >=4, 
												FN.fn_CleanSSN4(compareOutputSSN[FN.fn_getLen(compareOutputSSN)-3..]), '');
			
			//set must be sorted for this operation to work
			self.MatchesSSN := if ( searchpass in [CN.SortSearchPassEnum.INPUT_SSN, 
															 							 CN.SortSearchPassEnum.DERIVED,
																						 CN.SortSearchPassEnum.NAMEFLIP_DERIVED,
																						 CN.SortSearchPassEnum.INPUT_SSN_IGNORE_LAST,
																						 CN.SortSearchPassEnum.DERIVED_IGNORE_LAST], 
															FN.fn_MatchesSSN(L.SearchSSN, compareOutputSSN), 
															FN.fn_MatchesSSN(L.SearchSSN, SELF.SSN));
			self.MatchesSSN4 := if ( searchpass in [CN.SortSearchPassEnum.INPUT_SSN, 
															 							 CN.SortSearchPassEnum.DERIVED,
																						 CN.SortSearchPassEnum.NAMEFLIP_DERIVED,
																						 CN.SortSearchPassEnum.INPUT_SSN_IGNORE_LAST,
																						 CN.SortSearchPassEnum.DERIVED_IGNORE_LAST], 
															FN.fn_MatchesSSN(L.SSN4, compareSSN4), 
															FN.fn_MatchesSSN(L.SSN4, SELF.SSN4));												
			
			self.MatchesYOB := FN.fn_MatchesYOB(L.DOB_YYYYMMDD, SELF.DOB_YYYYMMDD);
			self.MatchesYOBMOB := FN.fn_MatchesYOBMOB(L.DOB_YYYYMMDD, SELF.DOB_YYYYMMDD);
			self.MatchesYOBMOBDOB := FN.fn_MatchesYOBMOBDOB(L.DOB_YYYYMMDD, SELF.DOB_YYYYMMDD);
			
			self.MatchesFirstName := FN.fn_MatchesFirstName_Exact(L.SearchName, self.CandidateName, acceptFirstInitialForFirstName);
			self.MatchesLastName := FN.fn_MatchesLastName_Exact(L.SearchName, self.CandidateName);
			self.MatchesFirstNameFuzzy := FN.fn_MatchesFirstName_Fuzzy(L.SearchName, self.CandidateName, CN.FUZZY_MATCHING_LAST_MATCHING_PCTG);
			self.MatchesLastNameFuzzy := FN.fn_MatchesLastName_Fuzzy(L.SearchName, self.CandidateName, CN.FUZZY_MATCHING_LAST_MATCHING_PCTG);
			self.MatchesFirstLastNameFuzzy_Age4 := FN.fn_MatchesFirstLastName_Fuzzy(L.SearchName, self.CandidateName, CN.FUZZY_MATCHING_LASTFIRST_DOB4_MATCHING_PCTG);
			self.MatchesFirstLastNameFuzzy_Age6 := FN.fn_MatchesFirstLastName_Fuzzy(L.SearchName, self.CandidateName, CN.FUZZY_MATCHING_LASTFIRST_DOB68_MATCHING_PCTG);
			self.MatchesFirstLastInstring := FN.fn_MatchesFirstLastInstring(L.SearchName, self.CandidateName);
			
			//name matching enhanced is currently removed because we do not want to 
			//invoke the cleaner at run time for all header records
			/* 
				to improve name matching, we are doing the following comparisons:
				a) cleaner input to cleaner output (w/ middle name)
				b) cleaner input to cleaner output (w/o middle name)
				c) cleaner input to non_cleaner output (w/ middle name)
				d) cleaner input to non_cleaner output (w/o middle name)
				e) non_cleaner input to cleaner output (w/ middle name)
				f) non_cleaner input to cleaner output (w/o middle name)
				g) non_cleaner input to non_cleaner output (w/ middle name)
				h) non_cleaner input to non_cleaner output (w/o middle name)				
			
			self.MatchesFirstName := FN.fn_MatchesFirstName_Exact(L.SearchName, selfCompareName, acceptFirstInitialForFirstName) or
															 FN.fn_MatchesFirstName_Exact(L.SearchName, selfCompareNameNoMiddle, acceptFirstInitialForFirstName) or
															 FN.fn_MatchesFirstName_Exact(L.SearchName, selfCompareNoCleaner, acceptFirstInitialForFirstName) or
															 FN.fn_MatchesFirstName_Exact(L.SearchName, selfCompareNoCleanerNoMiddle, acceptFirstInitialForFirstName) or
															 FN.fn_MatchesFirstName_Exact(L.SearchNameNonCleaner, selfCompareName, acceptFirstInitialForFirstName) or
															 FN.fn_MatchesFirstName_Exact(L.SearchNameNonCleaner, selfCompareNameNoMiddle, acceptFirstInitialForFirstName) or
															 FN.fn_MatchesFirstName_Exact(L.SearchNameNonCleaner, selfCompareNoCleaner, acceptFirstInitialForFirstName) or
															 FN.fn_MatchesFirstName_Exact(L.SearchNameNonCleaner, selfCompareNoCleanerNoMiddle, acceptFirstInitialForFirstName);
															 
			self.MatchesLastName := FN.fn_MatchesLastName_Exact(L.SearchName, selfCompareName) or
															FN.fn_MatchesLastName_Exact(L.SearchName, selfCompareNameNoMiddle) or
															FN.fn_MatchesLastName_Exact(L.SearchName, selfCompareNoCleaner) or
															FN.fn_MatchesLastName_Exact(L.SearchName, selfCompareNoCleanerNoMiddle) or
															FN.fn_MatchesLastName_Exact(L.SearchNameNonCleaner, selfCompareName) or
															FN.fn_MatchesLastName_Exact(L.SearchNameNonCleaner, selfCompareNameNoMiddle) or
															FN.fn_MatchesLastName_Exact(L.SearchNameNonCleaner, selfCompareNoCleaner) or
															FN.fn_MatchesLastName_Exact(L.SearchNameNonCleaner, selfCompareNoCleanerNoMiddle);
															
			self.MatchesFirstNameFuzzy := (self.MatchesFirstName and ~acceptFirstInitialForFirstName) or
																		FN.fn_MatchesFirstName_Fuzzy(L.SearchName, selfCompareName, CN.FUZZY_MATCHING_FIRST_MATCHING_PCTG) or
																		FN.fn_MatchesFirstName_Fuzzy(L.SearchName, selfCompareNameNoMiddle, CN.FUZZY_MATCHING_FIRST_MATCHING_PCTG) or
																		FN.fn_MatchesFirstName_Fuzzy(L.SearchName, selfCompareNoCleaner, CN.FUZZY_MATCHING_FIRST_MATCHING_PCTG) or
																		FN.fn_MatchesFirstName_Fuzzy(L.SearchName, selfCompareNoCleanerNoMiddle, CN.FUZZY_MATCHING_FIRST_MATCHING_PCTG) or
																		FN.fn_MatchesFirstName_Fuzzy(L.SearchNameNonCleaner, selfCompareName, CN.FUZZY_MATCHING_FIRST_MATCHING_PCTG) or
																		FN.fn_MatchesFirstName_Fuzzy(L.SearchNameNonCleaner, selfCompareNameNoMiddle, CN.FUZZY_MATCHING_FIRST_MATCHING_PCTG) or
																		FN.fn_MatchesFirstName_Fuzzy(L.SearchNameNonCleaner, selfCompareNoCleaner, CN.FUZZY_MATCHING_FIRST_MATCHING_PCTG) or
																		FN.fn_MatchesFirstName_Fuzzy(L.SearchNameNonCleaner, selfCompareNoCleanerNoMiddle, CN.FUZZY_MATCHING_FIRST_MATCHING_PCTG);
																		
			self.MatchesLastNameFuzzy := self.MatchesLastName or
																	 FN.fn_MatchesLastName_Fuzzy(L.SearchName, selfCompareName, CN.FUZZY_MATCHING_LAST_MATCHING_PCTG) or
																	 FN.fn_MatchesLastName_Fuzzy(L.SearchName, selfCompareNameNoMiddle, CN.FUZZY_MATCHING_LAST_MATCHING_PCTG) or
																	 FN.fn_MatchesLastName_Fuzzy(L.SearchName, selfCompareNoCleaner, CN.FUZZY_MATCHING_LAST_MATCHING_PCTG) or
																	 FN.fn_MatchesLastName_Fuzzy(L.SearchName, selfCompareNoCleanerNoMiddle, CN.FUZZY_MATCHING_LAST_MATCHING_PCTG) or
																	 FN.fn_MatchesLastName_Fuzzy(L.SearchNameNonCleaner, selfCompareName, CN.FUZZY_MATCHING_LAST_MATCHING_PCTG) or
																	 FN.fn_MatchesLastName_Fuzzy(L.SearchNameNonCleaner, selfCompareNameNoMiddle, CN.FUZZY_MATCHING_LAST_MATCHING_PCTG) or
																	 FN.fn_MatchesLastName_Fuzzy(L.SearchNameNonCleaner, selfCompareNoCleaner, CN.FUZZY_MATCHING_LAST_MATCHING_PCTG) or
																	 FN.fn_MatchesLastName_Fuzzy(L.SearchNameNonCleaner, selfCompareNoCleanerNoMiddle, CN.FUZZY_MATCHING_LAST_MATCHING_PCTG);
																	 
			self.MatchesFirstLastNameFuzzy_Age4 := (self.MatchesFirstName and ~acceptFirstInitialForFirstName and self.MatchesLastName) or
																						 FN.fn_MatchesFirstLastName_Fuzzy(L.SearchName, selfCompareName, CN.FUZZY_MATCHING_LASTFIRST_DOB4_MATCHING_PCTG) or
																						 FN.fn_MatchesFirstLastName_Fuzzy(L.SearchName, selfCompareNameNoMiddle, CN.FUZZY_MATCHING_LASTFIRST_DOB4_MATCHING_PCTG) or
																						 FN.fn_MatchesFirstLastName_Fuzzy(L.SearchName, selfCompareNoCleaner, CN.FUZZY_MATCHING_LASTFIRST_DOB4_MATCHING_PCTG) or
																						 FN.fn_MatchesFirstLastName_Fuzzy(L.SearchName, selfCompareNoCleanerNoMiddle, CN.FUZZY_MATCHING_LASTFIRST_DOB4_MATCHING_PCTG) or
																						 FN.fn_MatchesFirstLastName_Fuzzy(L.SearchNameNonCleaner, selfCompareName, CN.FUZZY_MATCHING_LASTFIRST_DOB4_MATCHING_PCTG) or
																						 FN.fn_MatchesFirstLastName_Fuzzy(L.SearchNameNonCleaner, selfCompareNameNoMiddle, CN.FUZZY_MATCHING_LASTFIRST_DOB4_MATCHING_PCTG) or
																						 FN.fn_MatchesFirstLastName_Fuzzy(L.SearchNameNonCleaner, selfCompareNoCleaner, CN.FUZZY_MATCHING_LASTFIRST_DOB4_MATCHING_PCTG) or
																						 FN.fn_MatchesFirstLastName_Fuzzy(L.SearchNameNonCleaner, selfCompareNoCleanerNoMiddle, CN.FUZZY_MATCHING_LASTFIRST_DOB4_MATCHING_PCTG);
																						 
			self.MatchesFirstLastNameFuzzy_Age6 := (self.MatchesFirstName and ~acceptFirstInitialForFirstName and self.MatchesLastName) or
																						 FN.fn_MatchesFirstLastName_Fuzzy(L.SearchName, selfCompareName, CN.FUZZY_MATCHING_LASTFIRST_DOB68_MATCHING_PCTG) or
																						 FN.fn_MatchesFirstLastName_Fuzzy(L.SearchName, selfCompareNameNoMiddle, CN.FUZZY_MATCHING_LASTFIRST_DOB68_MATCHING_PCTG) or
																						 FN.fn_MatchesFirstLastName_Fuzzy(L.SearchName, selfCompareNoCleaner, CN.FUZZY_MATCHING_LASTFIRST_DOB68_MATCHING_PCTG) or
																						 FN.fn_MatchesFirstLastName_Fuzzy(L.SearchName, selfCompareNoCleanerNoMiddle, CN.FUZZY_MATCHING_LASTFIRST_DOB68_MATCHING_PCTG) or
																						 FN.fn_MatchesFirstLastName_Fuzzy(L.SearchNameNonCleaner, selfCompareName, CN.FUZZY_MATCHING_LASTFIRST_DOB68_MATCHING_PCTG) or
																						 FN.fn_MatchesFirstLastName_Fuzzy(L.SearchNameNonCleaner, selfCompareNameNoMiddle, CN.FUZZY_MATCHING_LASTFIRST_DOB68_MATCHING_PCTG) or
																						 FN.fn_MatchesFirstLastName_Fuzzy(L.SearchNameNonCleaner, selfCompareNoCleaner, CN.FUZZY_MATCHING_LASTFIRST_DOB68_MATCHING_PCTG) or
																						 FN.fn_MatchesFirstLastName_Fuzzy(L.SearchNameNonCleaner, selfCompareNoCleanerNoMiddle, CN.FUZZY_MATCHING_LASTFIRST_DOB68_MATCHING_PCTG);
			
			self.MatchesFirstLastInstring := (self.MatchesFirstName and ~acceptFirstInitialForFirstName and self.MatchesLastName) or
																			 FN.fn_MatchesFirstLastInstring(L.SearchName, selfCompareName) or
																			 FN.fn_MatchesFirstLastInstring(L.SearchName, selfCompareNameNoMiddle) or
																			 FN.fn_MatchesFirstLastInstring(L.SearchName, selfCompareNoCleaner) or
																			 FN.fn_MatchesFirstLastInstring(L.SearchName, selfCompareNoCleanerNoMiddle) or
																			 FN.fn_MatchesFirstLastInstring(L.SearchNameNonCleaner, selfCompareName) or
																			 FN.fn_MatchesFirstLastInstring(L.SearchNameNonCleaner, selfCompareNameNoMiddle) or
																			 FN.fn_MatchesFirstLastInstring(L.SearchNameNonCleaner, selfCompareNoCleaner) or
																			 FN.fn_MatchesFirstLastInstring(L.SearchNameNonCleaner, selfCompareNoCleanerNoMiddle);
			//end enhanced name comparisons
			*/
			
			self.MatchesZipCode := FN.fn_MatchesZIP(L.SearchAddress.Z5Numeric, self.CandidateAddress.Z5Numeric);															
			
			self.MatchesStreetNameExact := 
				MAP(self.CandidateAddress.ISPoBOXType => FN.fn_MatchesStreetNameNormal_Exact(L.SearchAddress, self.CandidateAddress),
						self.CandidateAddress.ISRRType => FN.fn_MatchesStreetNameNormal_Exact(L.SearchAddress, self.CandidateAddress),																		
						FN.fn_MatchesStreetNameNormal_Exact(L.SearchAddress, self.CandidateAddress));
			self.MatchesHouseNumberExact := 
				MAP(self.CandidateAddress.ISPoBOXType => FN.fn_MatchesHouseNumberPobBox_Exact(L.SearchAddress, self.CandidateAddress),
						self.CandidateAddress.ISRRType => FN.fn_MatchesHouseNumberRR_Exact(L.SearchAddress, self.CandidateAddress),																		
						FN.fn_MatchesHouseNumberNormal_Exact(L.SearchAddress, self.CandidateAddress));
			self.MatchesStreetNameFirst4 := 
				MAP(self.CandidateAddress.ISPoBOXType => FN.fn_MatchesStreetNameNormal(L.SearchAddress, self.CandidateAddress),
						self.CandidateAddress.ISRRType => FN.fn_MatchesStreetNameNormal(L.SearchAddress, self.CandidateAddress),																		
						FN.fn_MatchesStreetNameNormal(L.SearchAddress, self.CandidateAddress));
			self.MatchesHouseNumberFirst3 := 
				MAP(self.CandidateAddress.ISPoBOXType => FN.fn_MatchesHouseNumberPobBox(L.SearchAddress, self.CandidateAddress),
						self.CandidateAddress.ISRRType => FN.fn_MatchesHouseNumberRR(L.SearchAddress, self.CandidateAddress),																		
						FN.fn_MatchesHouseNumberNormal(L.SearchAddress, self.CandidateAddress));
			
			self.DateProcessed_YYYYMMDD := L.TodayYYYYMMDD;				
			self.SourceType := FN.fn_GetSourceType(L.src);
			self.SearchAddressIDHit := L.SearchAddress.AddressID;
			
			self.SearchPass := if (searchpass != CN.SortSearchPassEnum.MISS_DERIVE_FUZZY, 
														 searchpass, 
														 FN.fn_GetBestSearchPassFuzzy(self.MatchesYOB,
																													self.MatchesYOBMOB,
																													self.MatchesYOBMOBDOB,
																													self.MatchesFirstName,																																				
																													self.MatchesLastName,
																													self.MatchesFirstNameFuzzy,
																													self.MatchesLastNameFuzzy,
																													self.MatchesFirstLastNameFuzzy_Age4,
																													self.MatchesFirstLastNameFuzzy_Age6,
																													self.MatchesFirstLastInstring,
																													self.MatchesZipCode,
																													self.MatchesStreetNameExact,
																													self.MatchesHouseNumberExact));																																				
      
			self.AgeMatchType := FN.fn_GetAgeMatchType(L.DOB_YYYYMMDD, SELF.DOB_YYYYMMDD);
		  self.SourceNameSort := FN.fn_GetSourceNameSort(L.src, searchpass);
			
			self.IsValidCandidate := FN.fn_IsValidCandidateForSearchPass(self.MatchesSSN,
																																	self.MatchesSSN4,
																																	self.MatchesYOB,
																																	self.MatchesYOBMOB,
																																	self.MatchesYOBMOBDOB,
																																	self.MatchesFirstName,
																																	self.MatchesLastName,
																																	self.MatchesFirstNameFuzzy,
																																	self.MatchesLastNameFuzzy,
																																	self.MatchesFirstLastNameFuzzy_Age4,
																																	self.MatchesFirstLastNameFuzzy_Age6,
																																	self.MatchesFirstLastInstring,
																																	self.MatchesZipCode,
																																	self.MatchesStreetNameExact,
																																	self.MatchesHouseNumberExact,
																																	self.MatchesStreetNameFirst4,
																																	self.MatchesHouseNumberFirst3,
																																	self.SearchPass,
																																	self.SourceNameSort);
			self.AgeVerified := FN.fn_GetAgeVerified(self.IsValidCandidate,
																							 self.AgeMatchType,
																							 FN.fn_GetUnderAge(SELF.DOB_YYYYMMDD, minAgeValue, L.TodayYear, L.TodayYearMonth, L.TodayYearMonthDay), 
																							 FN.fn_IsPrimaryHit(FN.fn_GetSourceName(self.SourceNameSort, isDerived)),
																							 self.SourceNameSort);			      																												
																													
      SELF.AgeMatchTypeDisplay := MAP(self.AgeVerified and self.AgeMatchType > 0 => (QSTRING2)(self.AgeMatchType), CN.DISPLAY_UNDEFINED_OR_BLANK[1]);
			SELF.SourceName	:= 
				IF(~self.AgeVerified and searchpass != CN.SortSearchPassEnum.SSN4EXPANSION, CN.DISPLAY_SOURCENAME_BLANK, FN.fn_GetSourceName(self.SourceNameSort, isDerived));
				
			SELF.InputMatchCode	:= IF (self.SearchPass = CN.SortSearchPassEnum.SSN4EXPANSION, CN.DISPLAY_INPUTMATCHCODE_ADDRESS_MISS, 
					IF ( ~self.AgeVerified, CN.DISPLAY_INPUTMATCHCODE_ADDRESS_MISS, FN.fn_GetInputMatchCode(self.SearchPass, L.SearchAddress.AddressID)));
			SELF.UnderAge := IF ( self.AgeMatchType <= 0, CN.DISPLAY_UNDEFINED_OR_BLANK, FN.fn_GetUnderAge(SELF.DOB_YYYYMMDD, minAgeValue, L.TodayYear, L.TodayYearMonth, L.TodayYearMonthDay));																															
			
			self.rawRecord := L;
			self := L, 
	
	END;
	
	EXPORT LT.Clean.FullRecordNorm xfm_reversenames(LT.Clean.FullRecordNorm l) := transform
	
		searchName := FN.fn_getCleanName(l.SearchName.FName, l.SearchName.LName, L.SearchName.mname, L.SearchName.Name_Suffix, L.SearchName.Title);
		self.SearchName := searchName;
		self := l;	
	END;
	
	EXPORT LT.InRecord.Dirty.FullRecord xfm_standardize_input_for_batch (LTB.InRecord l) := TRANSFORM
	
			self.acctno := l.acctno;
			self.TransactionNumber := '';
			self.CCN := '';
			self.ContactID := '';
			self.ChannelIdentifier := l.ChannelIdentifier;
			self.Title := l.Title;
			self.NameFirst := l.NameFirst;
			self.NameMiddle := l.NameMiddle;
			self.NameLast := l.NameLast;
			self. NameSuffix := l.NameSuffix;
			self.SSN := l.SSN;
			self.DOB_YYYYMMDD := l.DOB_YYYYMMDD;
			self.GIIDAddress.AddressLine1 := l.GIID_AddressLine1;
			self.GIIDAddress.AddressLine2 := l.GIID_AddressLine2;
			self.GIIDAddress.City := l.GIID_City;
			self.GIIDAddress.State := l.GIID_State;
			self.GIIDAddress.ZipCode := l.GIID_ZipCode;
			self.CurrentAddress.AddressLine1 := l.Current_AddressLine1;
			self.CurrentAddress.AddressLine2 := l.Current_AddressLine2;
			self.CurrentAddress.City := l.Current_City;
			self.CurrentAddress.State := l.Current_State;
			self.CurrentAddress.ZipCode := l.Current_ZipCode;						
			self.PreviousAddress.AddressLine1 := l.Previous_AddressLine1;
			self.PreviousAddress.AddressLine2 := l.Previous_AddressLine2;
			self.PreviousAddress.City := l.Previous_City;
			self.PreviousAddress.State := l.Previous_State;
			self.PreviousAddress.ZipCode := l.Previous_ZipCode;
			
			self.InputEcho := [];
	END;
	
	shared MAC_StandardizeBase() := MACRO
			self.acctno := '';
			self.TransactionNumber := l.SearchBy.TransactionNumber;
			self.CCN := l.SearchBy.CCN;
			self.ContactID := l.SearchBy.ContactID;;
			self.ChannelIdentifier := l.SearchBy.ChannelIdentifier;
			self.Title := l.SearchBy.Name.Prefix;
			self.NameFirst := l.SearchBy.Name.First;
			self.NameMiddle := l.SearchBy.Name.Middle;
			self.NameLast := l.SearchBy.Name.Last;
			self.NameSuffix := l.SearchBy.Name.Suffix;

			self.DOB_YYYYMMDD := FN.fn_BuildBirthDate(l.SearchBy.DOB.Year, l.SearchBy.DOB.Month, l.SearchBy.DOB.Day);
			self.GIIDAddress.AddressLine1 := l.SearchBy.GIIDAddress.StreetAddress1;
			self.GIIDAddress.AddressLine2 := l.SearchBy.GIIDAddress.StreetAddress2;
			self.GIIDAddress.City := l.SearchBy.GIIDAddress.City;
			self.GIIDAddress.State := l.SearchBy.GIIDAddress.State;
			self.GIIDAddress.ZipCode := l.SearchBy.GIIDAddress.Zip5;
			self.CurrentAddress.AddressLine1 := l.SearchBy.CurrentAddress.StreetAddress1;
			self.CurrentAddress.AddressLine2 := l.SearchBy.CurrentAddress.StreetAddress2;
			self.CurrentAddress.City := l.SearchBy.CurrentAddress.City;
			self.CurrentAddress.State := l.SearchBy.CurrentAddress.State;
			self.CurrentAddress.ZipCode := l.SearchBy.CurrentAddress.Zip5;						
			
			
			self.InputEcho := l.SearchBy;
	ENDMACRO;

	
	EXPORT LT.InRecord.Dirty.FullRecord xfm_standardize_input_for_iesp (iesp.ageverification.t_AgeVerificationRequest l) := TRANSFORM
			MAC_StandardizeBase();			
			self.SSN := l.SearchBy.SSN;
			self.PreviousAddress.AddressLine1 := l.SearchBy.PreviousAddress.StreetAddress1;
			self.PreviousAddress.AddressLine2 := l.SearchBy.PreviousAddress.StreetAddress2;
			self.PreviousAddress.City := l.SearchBy.PreviousAddress.City;
			self.PreviousAddress.State := l.SearchBy.PreviousAddress.State;
			self.PreviousAddress.ZipCode := l.SearchBy.PreviousAddress.Zip5;
	END;
	
	
	EXPORT LT.InRecord.Dirty.SSN4FullRecord xfm_standardize_input_for_iesp_ssn4 (iesp.ageverification.t_SSNExpansionRequest l) := TRANSFORM
			MAC_StandardizeBase();
			self.SSN := l.SearchBy.SSNLast4;
			self.PreviousAddress := [];
	END;
	
	
	EXPORT LTB.OutRecord xfm_flatten_output_for_batch (LT.TransactionData l) := TRANSFORM
		
			self.acctno := l.InputData.acctno;
			self.Search_title := l.SearchData.SearchName.title;				
			self.Search_fname := l.SearchData.SearchName.fname;				
			self.Search_mname := l.SearchData.SearchName.mname;				
			self.Search_lname := l.SearchData.SearchName.lname;				
			self.Search_name_suffix := l.SearchData.SearchName.name_suffix;				
			self.Search_PFname := l.SearchData.SearchName.PFname;				
			self.Search_PhoneticLname := l.SearchData.SearchName.PhoneticLname;
			self.Search_SSN := l.SearchData.SSN;
			self.Search_DOB_YYYYMMDD := l.SearchData.DOB_YYYYMMDD;
			self.Search_GIID_AddressID := l.SearchData.GIIDAddress.AddressID;
			self.Search_GIID_prim_range := l.SearchData.GIIDAddress.prim_range;
			self.Search_GIID_prim_name := l.SearchData.GIIDAddress.prim_name;
			self.Search_GIID_sec_range := l.SearchData.GIIDAddress.sec_range;
			self.Search_GIID_v_city_name := l.SearchData.GIIDAddress.v_city_name;
			self.Search_GIID_st := l.SearchData.GIIDAddress.st;
			self.Search_GIID_zip5 := l.SearchData.GIIDAddress.zip5;
			self.Search_GIID_zip4 := l.SearchData.GIIDAddress.zip4;
			self.Search_GIID_fips_county := l.SearchData.GIIDAddress.fips_county;
			self.Search_GIID_err_stat := l.SearchData.GIIDAddress.err_stat;			
			self.Search_Current_AddressID := l.SearchData.CurrentAddress.AddressID;
			self.Search_Current_prim_range := l.SearchData.CurrentAddress.prim_range;
			self.Search_Current_prim_name := l.SearchData.CurrentAddress.prim_name;
			self.Search_Current_sec_range := l.SearchData.CurrentAddress.sec_range;
			self.Search_Current_v_city_name := l.SearchData.CurrentAddress.v_city_name;
			self.Search_Current_st := l.SearchData.CurrentAddress.st;
			self.Search_Current_zip5 := l.SearchData.CurrentAddress.zip5;
			self.Search_Current_zip4 := l.SearchData.CurrentAddress.zip4;
			self.Search_Current_fips_county := l.SearchData.CurrentAddress.fips_county;
			self.Search_Current_err_stat := l.SearchData.CurrentAddress.err_stat;
			self.Search_Previous_AddressID := l.SearchData.PreviousAddress.AddressID;
			self.Search_Previous_prim_range := l.SearchData.PreviousAddress.prim_range;
			self.Search_Previous_prim_name := l.SearchData.PreviousAddress.prim_name;
			self.Search_Previous_sec_range := l.SearchData.PreviousAddress.sec_range;
			self.Search_Previous_v_city_name := l.SearchData.PreviousAddress.v_city_name;
			self.Search_Previous_st := l.SearchData.PreviousAddress.st;
			self.Search_Previous_zip5 := l.SearchData.PreviousAddress.zip5;
			self.Search_Previous_zip4 := l.SearchData.PreviousAddress.zip4;
			self.Search_Previous_fips_county := l.SearchData.PreviousAddress.fips_county;
			self.Search_Previous_err_stat := l.SearchData.PreviousAddress.err_stat;						
			self.Output_Clean_title := l.OutputData.CandidateName.title;
			self.Output_Clean_fname := l.OutputData.CandidateName.fname;
			self.Output_Clean_mname := l.OutputData.CandidateName.mname;
			self.Output_Clean_lname := l.OutputData.CandidateName.lname;
			self.Output_Clean_name_suffix := l.OutputData.CandidateName.name_suffix;
			self.Output_Clean_PFname := l.OutputData.CandidateName.PFname;
			self.Output_Clean_PhoneticLname := l.OutputData.CandidateName.PhoneticLname;					
			self.Output_Clean_prim_range := l.OutputData.CandidateAddress.prim_range;
			self.Output_Clean_prim_name := l.OutputData.CandidateAddress.prim_name;
			self.Output_Clean_sec_range := l.OutputData.CandidateAddress.sec_range;
			self.Output_Clean_v_city_name := l.OutputData.CandidateAddress.v_city_name;
			self.Output_Clean_st := l.OutputData.CandidateAddress.st;
			self.Output_Clean_zip5 := l.OutputData.CandidateAddress.zip5;
			self.Output_Clean_zip4 := l.OutputData.CandidateAddress.zip4;
			self.Output_Clean_fips_county := l.OutputData.CandidateAddress.fips_county ;
			self.Output_Clean_err_stat := l.OutputData.CandidateAddress.err_stat;
			self.Output_Clean_SSN := l.OutputData.SSN;
			self.Output_Clean_DOB_YYYYMMDD := l.OutputData.DOB_YYYYMMDD;
			self.Output_DID := l.OutputData.rawRecord.DID;
			self.Output_raw_rid := l.OutputData.rawRecord.rid;
			self.Output_raw_pflag1 := l.OutputData.rawRecord.pflag1;
			self.Output_raw_pflag2 := l.OutputData.rawRecord.pflag2;
			self.Output_raw_pflag3 := l.OutputData.rawRecord.pflag3;
			self.Output_raw_src := l.OutputData.rawRecord.src;
			self.Output_raw_dt_first_seen := l.OutputData.rawRecord.dt_first_seen;
			self.Output_raw_dt_last_seen := l.OutputData.rawRecord.dt_last_seen;
			self.Output_raw_dt_vendor_last_reported := l.OutputData.rawRecord.dt_vendor_last_reported;
			self.Output_raw_dt_vendor_first_reported := l.OutputData.rawRecord.dt_vendor_first_reported;
			self.Output_raw_dt_nonglb_last_seen := l.OutputData.rawRecord.dt_nonglb_last_seen;
			self.Output_raw_rec_type := l.OutputData.rawRecord.rec_type;
			self.Output_raw_vendor_id := l.OutputData.rawRecord.vendor_id;
			self.Output_raw_phone := l.OutputData.rawRecord.phone;
			self.Output_raw_ssn := l.OutputData.rawRecord.ssn;
			self.Output_raw_dob := l.OutputData.rawRecord.dob;
			self.Output_raw_title := l.OutputData.rawRecord.title;
			self.Output_raw_fname := l.OutputData.rawRecord.fname;
			self.Output_raw_mname := l.OutputData.rawRecord.mname;
			self.Output_raw_lname := l.OutputData.rawRecord.lname;
			self.Output_raw_name_suffix := l.OutputData.rawRecord.name_suffix;
			self.Output_raw_prim_range := l.OutputData.rawRecord.prim_range;
			self.Output_raw_predir := l.OutputData.rawRecord.predir;
			self.Output_raw_prim_name := l.OutputData.rawRecord.prim_name;
			self.Output_raw_suffix := l.OutputData.rawRecord.suffix;
			self.Output_raw_postdir := l.OutputData.rawRecord.postdir;
			self.Output_raw_unit_desig := l.OutputData.rawRecord.unit_desig;
			self.Output_raw_sec_range := l.OutputData.rawRecord.sec_range;
			self.Output_raw_city_name := l.OutputData.rawRecord.city_name;
			self.Output_raw_st := l.OutputData.rawRecord.st;
			self.Output_raw_zip := l.OutputData.rawRecord.zip;
			self.Output_raw_zip4 := l.OutputData.rawRecord.zip4;
			self.Output_raw_county := l.OutputData.rawRecord.county;
			self.Output_raw_geo_blk := l.OutputData.rawRecord.geo_blk;
			self.Output_raw_cbsa := l.OutputData.rawRecord.cbsa;
			self.Output_raw_tnt := l.OutputData.rawRecord.tnt;
			self.Output_raw_valid_SSN := l.OutputData.rawRecord.valid_SSN;
			self.Output_raw_jflag1 := l.OutputData.rawRecord.jflag1;
			self.Output_raw_jflag2 := l.OutputData.rawRecord.jflag2;
			self.Output_raw_jflag3 := l.OutputData.rawRecord.jflag3;
			self.DateProcessed_YYYYMMDD := l.OutputData.DateProcessed_YYYYMMDD;				
			self.AgeVerified		:= if ( l.OutputData.AgeVerified, CN.DISPLAY_YES, CN.DISPLAY_NO);
			self.UnderAge			:= l.OutputData.UnderAge;			
			self.AgeMatchType	:= l.OutputData.AgeMatchType;
			self.AgeMatchTypeDisplay	:= l.OutputData.AgeMatchTypeDisplay;
			self.SourceNameSort := l.OutputData.SourceNameSort;
			self.SourceName := l.OutputData.SourceName;
			self.SourceType := l.OutputData.SourceType;
			self.SearchPass := l.OutputData.SearchPass;
			self.SearchAddressIDHit := l.OutputData.SearchAddressIDHit;			
			self.IsValidCandidate := l.OutputData.IsValidCandidate;
			self.MatchesSSN := l.OutputData.MatchesSSN;
			self.MatchesYOB := l.OutputData.MatchesYOB;
			self.MatchesYOBMOB := l.OutputData.MatchesYOBMOB;
			self.MatchesYOBMOBDOB := l.OutputData.MatchesYOBMOBDOB;
			self.MatchesFirstName := l.OutputData.MatchesFirstName;
			self.MatchesLastName := l.OutputData.MatchesLastName;
			self.MatchesFirstNameFuzzy := l.OutputData.MatchesFirstNameFuzzy;
			self.MatchesLastNameFuzzy := l.OutputData.MatchesLastNameFuzzy;
			self.MatchesFirstLastNameFuzzy_Age4 := l.OutputData.MatchesFirstLastNameFuzzy_Age4;
			self.MatchesFirstLastNameFuzzy_Age6 := l.OutputData.MatchesFirstLastNameFuzzy_Age6;
			self.MatchesFirstLastInstring := l.OutputData.MatchesFirstLastInstring;
			self.MatchesZipCode := l.OutputData.MatchesZipCode;
			self.MatchesStreetNameExact := l.OutputData.MatchesStreetNameExact;
			self.MatchesHouseNumberExact := l.OutputData.MatchesHouseNumberExact;			
			self.MatchesStreetNameFirst4 := l.OutputData.MatchesStreetNameFirst4;
			self.MatchesHouseNumberFirst3 := l.OutputData.MatchesHouseNumberFirst3;			
			self.MatchesSSN4 := l.OutputData.MatchesSSN4;	
			self.FailureCode := l.FailureCode;
		END;

    shared MAC_SetAddress (in_addr, out_addr) := MACRO 
			self.out_addr.StreetName := l.in_addr.prim_name;
			self.out_addr.StreetNumber := l.in_addr.prim_range;
			self.out_addr.StreetPreDirection := l.in_addr.PreDir;
			self.out_addr.StreetPostDirection := l.in_addr.Postdir;
			self.out_addr.StreetSuffix := l.in_addr.Addr_Suffix;
			self.out_addr.UnitDesignation  := l.in_addr.Unit_Desig;
			self.out_addr.UnitNumber := l.in_addr.Sec_Range;
			self.out_addr.State := l.in_addr.St;
			self.out_addr.City  := l.in_addr.V_City_Name;
			self.out_addr.Zip5  := l.in_addr.Zip5;
			self.out_addr.Zip4  := l.in_addr.Zip4;
			self.out_addr.County  := l.in_addr.fips_county;
			self.out_addr.StreetAddress1 := '';
			self.out_addr.StreetAddress2 := '';
			self.out_addr.PostalCode := '';
			self.out_addr.StateCityZip := '';
			self.out_addr.CleaningErrorStatus := l.in_addr.err_stat;
    ENDMACRO;

		EXPORT iesp.ageverification.t_AgeVerificationResponse xfm_xlate_output_for_iesp (LT.TransactionData l) := TRANSFORM
		
			Self._Header := iesp.ECL2ESP.GetHeaderRow ();
		
			self.InputEcho := l.InputData.InputEcho;
			
			self.InputCleaned.Name.Full := '';
			self.InputCleaned.Name.First := l.SearchData.SearchName.fname;
			self.InputCleaned.Name.Middle:= l.SearchData.SearchName.mname;
			self.InputCleaned.Name.Last := l.SearchData.SearchName.lname;
			self.InputCleaned.Name.Suffix := l.SearchData.SearchName.title;	
			self.InputCleaned.Name.Prefix := l.SearchData.SearchName.name_suffix;						
			self.InputCleaned.Name.PreferredFirstName := l.SearchData.SearchName.PFname;				
			self.InputCleaned.Name.PhoneticLastName := l.SearchData.SearchName.PhoneticLname;

			self.InputCleaned.SSN := l.SearchData.SSN;
			self.InputCleaned.IsSearchableSSN := l.SearchData.IsSearchableSSN;

			self.InputCleaned.DOB := iesp.ECL2ESP.toDatestring8 (l.SearchData.DOB_YYYYMMDD);
			
      MAC_SetAddress (SearchData.GIIDAddress, InputCleaned.GIIDAddress);
      MAC_SetAddress (SearchData.CurrentAddress, InputCleaned.CurrentAddress);
      MAC_SetAddress (SearchData.PreviousAddress, InputCleaned.PreviousAddress);
			
			self.InputCleaned.CurrentDate := iesp.ECL2ESP.toDatestring8 (l.SearchData.TodayYYYYMMDD);
	
			self.Result.Name.Full := '';
			self.Result.Name.First := l.OutputData.CandidateName.fname;
			self.Result.Name.Middle:= l.OutputData.CandidateName.mname;
			self.Result.Name.Last := l.OutputData.CandidateName.lname;
			self.Result.Name.Suffix := l.OutputData.CandidateName.name_suffix;	
			self.Result.Name.Prefix := l.OutputData.CandidateName.title;						
			self.Result.Name.PreferredFirstName := l.OutputData.CandidateName.PFname;				
			self.Result.Name.PhoneticLastName := l.OutputData.CandidateName.PhoneticLname;
      MAC_SetAddress (OutputData.CandidateAddress, Result.Address);
			self.Result.SSN := l.OutputData.SSN;
			self.Result.DOB := iesp.ECL2ESP.toDatestring8 (l.OutputData.DOB_YYYYMMDD);
			self.Result.UniqueId := intformat (l.OutputData.rawRecord.DID, 30, 1);
			self.Result.DateProcessed := iesp.ECL2ESP.toDatestring8 (l.OutputData.DateProcessed_YYYYMMDD);
			self.Result.AgeVerified := l.OutputData.AgeVerified;
			self.Result.UnderAge := l.OutputData.UnderAge;	
			self.Result.AgeMatchType := l.OutputData.AgeMatchType;
			self.Result.AgeMatchTypeDesc := l.OutputData.AgeMatchTypeDisplay;
			self.Result.SourceNameSort := l.OutputData.SourceNameSort;
			self.Result.SourceName  := l.OutputData.SourceName;
			self.Result.SourceType  := l.OutputData.SourceType;
			self.Result.SearchPass := l.OutputData.SearchPass;
			self.Result.SearchAddressIdHit := l.OutputData.SearchAddressIDHit;
			self.Result.InputMatchCode := l.OutputData.InputMatchCode;	
			self.Result.RecordId := intformat (l.OutputData.rawRecord.rid, 30, 1);
			self.Result.BaseSource := l.OutputData.rawRecord.src;
	
		END;
		
		EXPORT iesp.ageverification.t_SSNExpansionResponse xfm_xlate_output_for_iesp_SSN4 (LT.Ssn4TransactionData l) := TRANSFORM		
			Self._Header := iesp.ECL2ESP.GetHeaderRow ();		
			self.InputEcho := l.InputData.InputEcho;					
			self.Result.Expanded := PhilipMorris.Functions.fn_getLen(l.OutputData.SSN)=9; 
			self.Result.SSN := IF (PhilipMorris.Functions.fn_getLen(l.OutputData.SSN)=9, l.OutputData.SSN, '');
			self.Result.ErrorDescription := '';
			self.Result.InputMatchCode := l.OutputData.InputMatchCode;	
			self.Result.SourceName := l.OutputData.SourceName;
			self.Result.UniqueId := intformat (l.OutputData.rawRecord.DID, 30, 1);
			self.Result.RECORDID := intformat (l.OutputData.rawRecord.rid, 30, 1);
			self.Result.BaseSource := l.OutputData.rawRecord.src;
		END;	

	EXPORT LTB.InAddrRec assignPreferred(LTB.InAddrRecord L) := TRANSFORM
		SELF.preferredFirst := NID.PreferredFirstNew(L.Name_First);
		SELF := L;
	END;

	EXPORT LTB.processRec normalizeInput(LTB.InAddrRec L, INTEGER C) := TRANSFORM
		STRING10 Prim_Range := CHOOSE(C, L.addr1_Prim_Range, L.addr2_Prim_Range, L.addr3_Prim_Range);
		STRING2  PreDir     := CHOOSE(C, L.addr1_PreDir, L.addr2_PreDir, L.addr3_PreDir);
		STRING28 Prim_Name  := CHOOSE(C, L.addr1_Prim_Name, L.addr2_Prim_Name, L.addr3_Prim_Name);
		STRING4  Suffix     := CHOOSE(C, L.addr1_Suffix, L.addr2_Suffix, L.addr3_Suffix);
		STRING2  PostDir    := CHOOSE(C, L.addr1_PostDir, L.addr2_PostDir, L.addr3_PostDir);
		STRING10 Unit_Desig := CHOOSE(C, L.addr1_Unit_Desig, L.addr2_Unit_Desig, L.addr3_Unit_Desig);
		STRING8  Sec_Range  := CHOOSE(C, L.addr1_Sec_Range, L.addr2_Sec_Range, L.addr3_Sec_Range);
		STRING25 City       := CHOOSE(C, L.addr1_City, L.addr2_City, L.addr3_City);
		STRING2  State      := CHOOSE(C, L.addr1_State, L.addr2_State, L.addr3_State);
		STRING5  Zip5       := CHOOSE(C, L.addr1_Zip5, L.addr2_Zip5, L.addr3_Zip5);
		STRING4  Zip4       := CHOOSE(C, L.addr1_Zip4, L.addr2_Zip4, L.addr3_Zip4);
		BOOLEAN  BlankAddr  := LENGTH(TRIM(Prim_Range+Prim_Name+City+State+Zip5))=0;
		// SKIP blank addresses
		SELF.seq  := IF(not BlankAddr,C,SKIP);
		SELF.Prim_Range := Prim_Range;
		SELF.PreDir     := PreDir;
		SELF.Prim_Name  := Prim_Name;
		SELF.suffix     := Suffix;
		SELF.PostDir    := PostDir;
		SELF.Unit_Desig := Unit_Desig;
		SELF.Sec_Range  := Sec_Range;
		SELF.City       := City;
		SELF.State      := State;
		SELF.Zip5       := Zip5;
		SELF.Zip4       := Zip4;
		SELF := L;
		SELF := [];
	END;

	EXPORT DayBatchEDA.Layout_Batch_In assignDayBatchEDA(LTB.processRec L) := TRANSFORM
		SELF.name_first_init := l.name_first[1];
		SELF.unit_design := L.Unit_Desig;
		SELF.p_city_name := L.City;
		SELF.st          := L.State;
		SELF.z5          := L.Zip5;
		SELF.phone7      := IF(l.PhoneNo[8..10]='',l.PhoneNo[1..7],l.PhoneNo[4..10]);
		SELF.area_code   := IF(l.PhoneNo[8..10]='','',l.PhoneNo[1..3]);
		SELF.ssn         := '';
		SELF.max_results := 99;
		// match level 78 includes name only and address only matches
		SELF.match_level := 78;
		SELF.PhoneticMatch  := FALSE;
		SELF.AllowNickNames := TRUE;
		SELF.includeBus     := TRUE;
		SELF.includeRes     := TRUE;
		SELF.includeGov     := FALSE;
		SELF := L;
	end;
  
	EXPORT LTB.processRec gongMatch(LTB.processRec L, LBO.Layout_Final_Output R) := TRANSFORM
		gongMatchType := FN.fn_gongMatchType(L,R);
		SELF.MatchType := gongMatchType;
		SELF.DateLastSeen := R.FileDate;
		SELF.PhoneNo := IF(gongMatchType IN CN.ValidPhoneMatches,L.PhoneNo,R.Phone10);
		SELF := L;
	END;

	EXPORT didVille.Layout_Did_OutBatch assignDidVille(LTB.processRec L) := TRANSFORM
		SELF.did         := 0;
		SELF.seq         := (integer)L.AcctNo;
		SELF.ssn         := '';
		//SELF.phone10     := L.PhoneNo;		
		SELF.phone10     := '';		
		//SELF.title       := L.Name_Prefix;
		SELF.title       :='';
		SELF.fname       := L.Name_First;
		SELF.mname       := L.Name_Middle;
		SELF.lname       := L.Name_Last;
		SELF.suffix      := '';
		SELF.addr_suffix := L.Suffix;
		SELF.p_city_name := L.City;
		SELF.st          := L.State;
		SELF.z5          := L.Zip5;
		SELF := L;
	end;
	
	EXPORT LB.Batch_in assignBestAddr(didVille.Layout_Did_OutBatch L) := TRANSFORM
		SELF.acctno := (string)L.seq;
		SELF.did := L.did;
		SELF:=[];
	END;

	EXPORT LTB.bestAddrRec assignBooleans(LTB.processRec L,LB.service_Out R) := TRANSFORM
		// First Name Match = first name or alias or first initial
		SELF.matchFirst      := L.Name_First[1]=R.Name_First[1] or NID.mod_PFirstTools.RinPFL(R.Name_First, L.preferredFirst);
		SELF.matchExactFirst := L.Name_First=R.Name_First;
		SELF.matchExactLast  := L.Name_Last=R.Name_Last;
		// Partial Address Match = (a) first 3 numbers of street number and (b) first 4 letters of street name
		boolean isPoBox := FN.fn_IsPoBox(L.Prim_Name) and FN.fn_IsPoBox(R.Prim_Name);
		boolean isRRTyp := FN.fn_RRType(L.Prim_Name) and FN.fn_RRType(R.Prim_Name);
		SELF.matchPartialAddr := (L.Prim_Range[1..3]=R.Prim_Range[1..3] and L.Prim_Name[1..4]=R.Prim_Name[1..4])
			or ((isPoBox or isRRTyp) and L.Prim_Name=R.Prim_Name);
		SELF.matchZip     := L.Zip5=R.Z5;
		SELF.matchPhone10 := length(trim(L.PhoneNo))=10 and L.PhoneNo=R.Phone10;
		SELF.matchDOB4    := length(trim(L.DOB))>=4 and L.DOB[1..4]=R.DOB[1..4];
		SELF.matchDOB8    := length(trim(L.DOB))=8 and L.DOB=R.DOB;
		SELF.srcs := [];
		SELF := R;
	END;

	EXPORT LTB.bestAddrRec rollupRecs(LTB.bestAddrRec L,LTB.bestAddrRec R) := TRANSFORM
		SELF.AcctNo := L.AcctNo;
		SELF.DID := L.DID;
		// any phone better than no phone
		SELF.Phone10 := if(L.Phone10<>'',L.Phone10,R.Phone10);
		// any ssn better than no ssn
		SELF.SSN := if(L.SSN<>'',L.SSN,R.SSN);
		// any DOB, 8 chars better than 6 better than 4
		L_DOB := if(L.DOB[7..8]='00',if(L.DOB[5..6]='00',L.DOB[1..4],L.DOB[1..6]),L.DOB);
		R_DOB := if(R.DOB[7..8]='00',if(R.DOB[5..6]='00',R.DOB[1..4],R.DOB[1..6]),R.DOB);
		SELF.DOB := if(length(trim(L_DOB))>length(trim(R_DOB)),L_DOB,R_DOB);
		// if any true, rolled value = true
		SELF.matchFirst       := L.matchFirst or R.matchFirst;
		SELF.matchExactFirst  := L.matchExactFirst or R.matchExactFirst;
		SELF.matchExactLast   := L.matchExactLast or R.matchExactLast;
		SELF.matchPartialAddr := L.matchPartialAddr or R.matchPartialAddr;
		SELF.matchZip         := L.matchZip or R.matchZip;
		SELF.matchPhone10     := L.matchPhone10 or R.matchPhone10;
		SELF.matchDOB4        := L.matchDOB4 or R.matchDOB4;
		SELF.matchDOB8        := L.matchDOB8 or R.matchDOB8;
		SELF := [];
	END;

	EXPORT LTB.bestAddrRec backFillRecs(LB.service_Out L,LTB.bestAddrRec R) := TRANSFORM
		SELF.Phone10 := if(L.Phone10<>'',L.Phone10,R.Phone10);
		SELF.SSN := if(L.SSN<>'',L.SSN,R.SSN);
		SELF.DOB := if(L.DOB<>'',L.DOB,R.DOB);
		SELF.matchFirst       := R.matchFirst;
		SELF.matchExactFirst  := R.matchExactFirst;
		SELF.matchExactLast   := R.matchExactLast;
		SELF.matchPartialAddr := R.matchPartialAddr;
		SELF.matchPhone10     := R.matchPhone10;
		SELF.matchZip         := R.matchZip;
		SELF.matchDOB4        := R.matchDOB4;
		SELF.matchDOB8        := R.matchDOB8;
		SELF.srcs := [];
		SELF := L;
	END;

	EXPORT LTB.processRec bestAddrMatch(LTB.processRec L,LTB.bestAddrRec R) := TRANSFORM
		boolean validDID := (R.matchFirst and R.matchExactLast and R.matchPartialAddr and R.matchZip and R.matchDOB4)
			or ((R.matchExactFirst or R.matchExactLast) and R.matchPartialAddr and R.matchZip and R.matchDOB8)
			or (R.matchFirst and R.matchExactLast and R.matchPhone10 and R.matchDOB8);
		// SKIP if not valid DID
		SELF.MatchType    := FN.fn_bestAddrMatchType(L,R);
		SELF.DateLastSeen := R.addr_dt_last_seen;
		SELF.did          := if(validDID,R.did,SKIP);
		SELF.Prim_Range   := R.Prim_Range;
		SELF.PreDir       := R.PreDir;
		SELF.Prim_Name    := R.Prim_Name;
		SELF.suffix       := R.Suffix;
		SELF.PostDir      := R.PostDir;
		SELF.Unit_Desig   := R.Unit_Desig;
		SELF.Sec_Range    := R.Sec_Range;
		SELF.City         := R.p_City_Name;
		SELF.State        := R.ST;
		SELF.Zip5         := R.Z5;
		SELF.Zip4         := R.Zip4;
		SELF := L;
	END;

	EXPORT LTB.OutAddrRecord noAddrHits(LTB.processRec L,LTB.InAddrRecord R) := TRANSFORM
		// return only entity info for unmatched records
		boolean match     := L.MatchType<>'';
		SELF.AcctNo       := R.AcctNo;
		SELF.DID          := if(match,L.DID,0);
		SELF.Name_Prefix  := if(match,L.Name_Prefix,R.Name_Prefix);
		SELF.Name_First   := if(match,L.Name_First,R.Name_First);
		SELF.Name_Middle  := if(match,L.Name_Middle,R.Name_Middle);
		SELF.Name_Last    := if(match,L.Name_Last,R.Name_Last);
		SELF.Name_Suffix  := if(match,L.Name_Suffix,R.Name_Suffix);
		SELF.DOB          := if(match,L.DOB,R.DOB);
		SELF.PhoneNo      := if(match,L.PhoneNo,R.PhoneNo);
		// since "match" above is false only when Right record doesn't have join-match
		SELF := L;
	END;

END;