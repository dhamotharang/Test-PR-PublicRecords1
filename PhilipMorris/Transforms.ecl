import mdr, iesp;

CN := PhilipMorris.Constants;
LT := PhilipMorris.Layouts;
LTB := PhilipMorris.Layouts_Batch;
FN := PhilipMorris.Functions;

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

			_name := FN.fn_getCleanName(L.lname, L.fname, L.mname, '', '', false);

			_prim_name := L.prim_name;

			is_PO := FN.fn_IsPoBox (_prim_name);
			is_RR := FN.fn_RRType (_prim_name);

			self.InternalSeqNo := l.InternalSeqNo;
			self.CandidateName := _name;

			//the address is already cleaned and parsed
			PhilipMorris.Layouts.Clean.Address SetCandidateAddress () := TRANSFORM
				SELF.AddressID     := L.SearchAddress.AddressID;
				SELF.Prim_Range    := L.prim_range;
				SELF.PreDir        := L.predir;
				SELF.Prim_Name     := _prim_name;
				SELF.Addr_Suffix   := L.suffix;
				SELF.PostDir       := L.postdir;
				SELF.Unit_Desig    := L.unit_desig;
				SELF.Sec_Range     := L.sec_range;
				SELF.V_City_Name   := L.city_name;
				SELF.St            := L.ST;
				SELF.Zip5          := L.ZIP;
				SELF.Z5Numeric     := (integer4) TRIM (L.ZIP);
				SELF.Zip4          := L.Zip4;
				SELF.fips_county   := L.county;
				SELF.addr_rec_type := '';
				SELF.err_stat      := '';
				SELF.ISPoBOXType   := is_PO;
				SELF.ISRRType      := is_RR;
				SELF.PrimNameLen   := FN.fn_getLen (L.prim_name);
				SELF.PrimRangeLen  := FN.fn_getLen (L.prim_range);
			END;
			_address := ROW (SetCandidateAddress ());

			self.CandidateAddress	:= _address;
			SELF.DID := L.DID;

			_ssn := FN.fn_CleanSSN(L.SSN);
			SELF.SSN := _ssn;
			Self.IsSearchableSSN  := FN.fn_IsSearchableSSN(_ssn);
			Self.SSN4							:= IF(FN.fn_getLen(_ssn) >=4,
																	FN.fn_CleanSSN4(_ssn[FN.fn_getLen(_ssn)-3..]), '');

			_dob := FN.fn_CleanDOBFromInt(L.DOB);
			SELF.DOB_YYYYMMDD := _dob;
			SELF.DOB_Numeric := L.DOB;

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
															FN.fn_MatchesSSN(L.SearchSSN, _ssn));
			self.MatchesSSN4 := if ( searchpass in [CN.SortSearchPassEnum.INPUT_SSN,
															 							 CN.SortSearchPassEnum.DERIVED,
																						 CN.SortSearchPassEnum.NAMEFLIP_DERIVED,
																						 CN.SortSearchPassEnum.INPUT_SSN_IGNORE_LAST,
																						 CN.SortSearchPassEnum.DERIVED_IGNORE_LAST],
															FN.fn_MatchesSSN(L.SSN4, compareSSN4),
															FN.fn_MatchesSSN(L.SSN4, SELF.SSN4));

			self.MatchesYOB := FN.fn_MatchesYOB(L.DOB_YYYYMMDD, _dob);
			self.MatchesYOBMOB := FN.fn_MatchesYOBMOB(L.DOB_YYYYMMDD, _dob);
			self.MatchesYOBMOBDOB := FN.fn_MatchesYOBMOBDOB(L.DOB_YYYYMMDD, _dob);

			self.MatchesFirstName := FN.fn_MatchesFirstName_Exact(L.SearchName, _name, acceptFirstInitialForFirstName);
			self.MatchesLastName := FN.fn_MatchesLastName_Exact(L.SearchName, _name);
			self.MatchesFirstNameFuzzy := FN.fn_MatchesFirstName_Fuzzy(L.SearchName, _name, CN.FUZZY_MATCHING_LAST_MATCHING_PCTG);
			self.MatchesLastNameFuzzy := FN.fn_MatchesLastName_Fuzzy(L.SearchName, _name, CN.FUZZY_MATCHING_LAST_MATCHING_PCTG);
			self.MatchesFirstLastNameFuzzy_Age4 := FN.fn_MatchesFirstLastName_Fuzzy(L.SearchName, _name, CN.FUZZY_MATCHING_LASTFIRST_DOB4_MATCHING_PCTG);
			self.MatchesFirstLastNameFuzzy_Age6 := FN.fn_MatchesFirstLastName_Fuzzy(L.SearchName, _name, CN.FUZZY_MATCHING_LASTFIRST_DOB68_MATCHING_PCTG);
			self.MatchesFirstLastInstring := FN.fn_MatchesFirstLastInstring(L.SearchName, _name);

			//name matching enhanced is currently removed because we do not want to
			//invoke the cleaner at run time for all header records

			self.MatchesZipCode := FN.fn_MatchesZIP(L.SearchAddress.Z5Numeric, _address.Z5Numeric);

			self.MatchesStreetNameExact :=
				MAP(is_PO => FN.fn_MatchesStreetNameNormal_Exact(L.SearchAddress, _address),
						is_RR => FN.fn_MatchesStreetNameNormal_Exact(L.SearchAddress, _address),
						FN.fn_MatchesStreetNameNormal_Exact(L.SearchAddress, _address));
			self.MatchesHouseNumberExact :=
				MAP(is_PO => FN.fn_MatchesHouseNumberPobBox_Exact(L.SearchAddress, _address),
						is_RR => FN.fn_MatchesHouseNumberRR_Exact(L.SearchAddress, _address),
						FN.fn_MatchesHouseNumberNormal_Exact(L.SearchAddress, _address));
			self.MatchesStreetNameFirst4 :=
				MAP(is_PO => FN.fn_MatchesStreetNameNormal(L.SearchAddress, _address),
						is_RR => FN.fn_MatchesStreetNameNormal(L.SearchAddress, _address),
						FN.fn_MatchesStreetNameNormal(L.SearchAddress, _address));
			self.MatchesHouseNumberFirst3 :=
				MAP(is_PO => FN.fn_MatchesHouseNumberPobBox(L.SearchAddress, _address),
						is_RR => FN.fn_MatchesHouseNumberRR(L.SearchAddress, _address),
						FN.fn_MatchesHouseNumberNormal(L.SearchAddress, _address));

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

			self.AgeMatchType := FN.fn_GetAgeMatchType(L.DOB_YYYYMMDD, _dob);
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
																							 FN.fn_GetUnderAge(_dob, minAgeValue, L.TodayYear, L.TodayYearMonth, L.TodayYearMonthDay),
																							 FN.fn_IsPrimaryHit(FN.fn_GetSourceName(self.SourceNameSort, isDerived)),
																							 self.SourceNameSort);

			SELF.AgeMatchTypeDisplay := MAP(self.AgeVerified and self.AgeMatchType > 0 => (QSTRING2)(self.AgeMatchType), CN.DISPLAY_UNDEFINED_OR_BLANK[1]);
			SELF.SourceName	:=
				IF(~self.AgeVerified and searchpass != CN.SortSearchPassEnum.SSN4EXPANSION, CN.DISPLAY_SOURCENAME_BLANK, FN.fn_GetSourceName(self.SourceNameSort, isDerived));

			SELF.InputMatchCode	:= IF (self.SearchPass = CN.SortSearchPassEnum.SSN4EXPANSION, CN.DISPLAY_INPUTMATCHCODE_ADDRESS_MISS,
					IF ( ~self.AgeVerified, CN.DISPLAY_INPUTMATCHCODE_ADDRESS_MISS, FN.fn_GetInputMatchCode(self.SearchPass, L.SearchAddress.AddressID)));
			SELF.UnderAge := IF ( self.AgeMatchType <= 0, CN.DISPLAY_UNDEFINED_OR_BLANK, FN.fn_GetUnderAge(_dob, minAgeValue, L.TodayYear, L.TodayYearMonth, L.TodayYearMonthDay));

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

END;
