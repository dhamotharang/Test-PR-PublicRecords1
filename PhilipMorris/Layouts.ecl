import header, standard, doxie, iesp;

CN := PhilipMorris.Constants;

EXPORT Layouts := MODULE

	EXPORT HeaderRec := header.Layout_Header;
	EXPORT HeaderRecFull := recordof (doxie.key_header);

	EXPORT InRecord := MODULE
			EXPORT Dirty := MODULE		
				EXPORT Address := RECORD
					QSTRING65	AddressLine1;
					QSTRING65	AddressLine2;
					QSTRING25	City;
					STRING2	State;
					STRING10	ZipCode;
				END;		
				
				EXPORT FullRecordBase := RECORD
					STRING20  acctno;
					QSTRING50	TransactionNumber;
					QSTRING50	CCN;
					QSTRING100	ContactID;
					QSTRING30	ChannelIdentifier;
					QSTRING5   Title;
					QSTRING30  NameFirst;
					QSTRING30  NameMiddle;
					QSTRING30  NameLast;
					STRING5   NameSuffix;
					STRING11 	SSN;
					STRING10 	DOB_YYYYMMDD;
					Address		GIIDAddress;
					Address		CurrentAddress;
					Address		PreviousAddress;	
					
				END;	
				
				EXPORT FullRecord := RECORD (FullRecordBase)
					iesp.ageverification.t_AgeVerificationSearchBy InputEcho;
				END;
				
				EXPORT SSN4FullRecord := RECORD  (FullRecordBase)					
					iesp.ageverification.t_SSNExpansionSearchBy InputEcho;
				END;
				
				EXPORT SSN4FullRecordWithSequence := RECORD
					UNSIGNED4	InternalSeqNo;
					SSN4FullRecord;
				END;
					
				EXPORT FullRecordWithSequence := RECORD
					UNSIGNED4	InternalSeqNo;
					FullRecord;
				END;	
				
			END;
		END;
		
		EXPORT Clean := MODULE
			EXPORT Address := RECORD					
				Constants.AddressTypeEnum AddressID						:= Constants.AddressTypeEnum.UNK;
				BOOLEAN		ISPoBOXType;
				BOOLEAN		ISRRType;
				UNSIGNED4   PrimNameLen;
				UNSIGNED4   PrimRangeLen;				
				INTEGER4  Z5Numeric;
				Standard.Addr AND NOT [geo_lat, geo_long, cbsa,	geo_blk, geo_match, fips_state];
			END;
			
			EXPORT Name := RECORD
				
				standard.name and not name_score;
				QSTRING20 PFname;
				QSTRING20 PFname2;
				QSTRING20 PhoneticLname;			
				
			END;				
						
			EXPORT FullRecord := RECORD												
				UNSIGNED4		InternalSeqNo;
				Name				SearchNameNonCleaner;	
				Name				SearchName;												
				STRING9 	SSN;
				STRING4 	SSN4;
				boolean   IsSearchableSSN;
				boolean		IsSearchableSSN4;
				STRING10 	DOB_YYYYMMDD;
				UNSIGNED8		DOB_Numeric;
				Address			GIIDAddress;
				Address		CurrentAddress;
				Address		PreviousAddress;	
				STRING8	TodayYYYYMMDD;
				UNSIGNED2 TodayYear;
				UNSIGNED4 TodayYearMonth;
				UNSIGNED4 TodayYearMonthDay;
			END;		
			
			EXPORT FullRecordNorm := RECORD												
				UNSIGNED4		InternalSeqNo;
				Name				SearchNameNonCleaner;	
				Name				SearchName;												
				//STRING9 	SSN;
				STRING9 	SearchSSN;
				STRING4 	SSN4;
				boolean   IsSearchableSSN;
				boolean		IsSearchableSSN4;
				STRING10 	DOB_YYYYMMDD;
				UNSIGNED4		DOB_Numeric;
				Address			SearchAddress;
				STRING8	TodayYYYYMMDD;
				UNSIGNED2 TodayYear;
				UNSIGNED4 TodayYearMonth;
				UNSIGNED4 TodayYearMonthDay;				
			END;		
			
		END;
		
		EXPORT Search := MODULE
			EXPORT FullRecordNormWithHeaderData := RECORD
				Clean.FullRecordNorm;
				HeaderRec;
				/* bugzilla 56745 */
				STRING9 InternalOnlyOutputSSN;
				END;
		END;
				
		EXPORT OutputRecord := MODULE
			
			EXPORT CandidateRecord := RECORD
				UNSIGNED4		InternalSeqNo;
				Clean.Name				CandidateName;
				Clean.Address			CandidateAddress;
				boolean   IsSearchableSSN;
				STRING9 	SSN;
				STRING9 	SSN4;
				STRING10 	DOB_YYYYMMDD;
				UNSIGNED8		DOB_Numeric;
				//header.Layout_Header rawRecord;
				HeaderRec rawRecord;
				UNSIGNED6				DID;	
				boolean			IsValidCandidate;
				boolean			MatchesSSN;
				boolean			MatchesYOB;
				boolean			MatchesYOBMOB;
				boolean			MatchesYOBMOBDOB;
				//includes first initial matching for first inital search pass
				boolean			MatchesFirstName;
				boolean			MatchesLastName;
				boolean			MatchesFirstNameFuzzy;
				boolean			MatchesLastNameFuzzy;
				//these vary.. stricter fuzziness is required based on the age match type
				boolean			MatchesFirstLastNameFuzzy_Age4;
				boolean			MatchesFirstLastNameFuzzy_Age6;
				boolean			MatchesFirstLastInstring;
				boolean 		MatchesZipCode;
				boolean			MatchesStreetNameExact;
				boolean			MatchesHouseNumberExact;			
				boolean			MatchesStreetNameFirst4;
				boolean			MatchesHouseNumberFirst3;			
				boolean			MatchesSSN4;			
				STRING8		DateProcessed_YYYYMMDD := '';				
				boolean AgeVerified		:= false;
				STRING1 				UnderAge			:= Constants.DISPLAY_UNDEFINED_OR_BLANK;			
				Constants.SortAgeMatchTypeEnum				AgeMatchType	:= Constants.SortAgeMatchTypeEnum.NONE;
				String2				AgeMatchTypeDisplay	:= Constants.DISPLAY_UNDEFINED_OR_BLANK;
				Constants.SortSourceEnum	SourceNameSort := Constants.SortSourceEnum.UNK;
				STRING2 				SourceName := Constants.DISPLAY_SOURCENAME_BLANK;
				//INTERNAL ONLY:
				QSTRING20 			SourceType := Constants.SOURCETYPE_NAME_UNKNOWN;
				//
				Constants.SortSearchPassEnum				SearchPass := Constants.SortSearchPassEnum.MISS;
				UNSIGNED2				SearchAddressIDHit := Constants.AddressTypeEnum.UNK;
				QSTRING20			InputMatchCode := Constants.DISPLAY_INPUTMATCHCODE_ADDRESS_MISS;
			END;
			
		END;	
		
		EXPORT TransactionData := RECORD
			InRecord.Dirty.FullRecord	InputData;
			Clean.FullRecord AND NOT InternalSeqno SearchData;
			OutputRecord.CandidateRecord OutputData;
			UNSIGNED2		FailureCode;
		END;
		
		EXPORT Ssn4TransactionData := RECORD
			InRecord.Dirty.SSN4FullRecord  InputData;
			Clean.FullRecord AND NOT InternalSeqno SearchData;
			OutputRecord.CandidateRecord OutputData;
			UNSIGNED2 		FailureCode;
		END;

END;
		
		