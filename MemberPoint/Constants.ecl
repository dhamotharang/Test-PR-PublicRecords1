IMPORT MemberPoint;

	export Constants := module
	
		EXPORT PhoneTransactionType:= MODULE
			EXPORT STRING1 Premium:= '1';
			EXPORT STRING1 Ultimate:= '2';
			EXPORT STRING1 WaterfallPhones:= 'W';
		END;
		
		EXPORT PhoneFilterType:= MODULE, VIRTUAL
			EXPORT STRING1 CellPhones:= 'C';
			EXPORT STRING1 Landlines:= 'L';
			EXPORT STRING1 None:= '';
		END;

		// M (minor only)
		// S (adult)
		// D(minor with derived guardian ) 
		// G(minor with input guardian )
		EXPORT LNSearchNameType:= MODULE
			EXPORT STRING1 Minor:= 'M';
			EXPORT STRING1 Derived:= 'D';
			EXPORT STRING1 Guardian:= 'G';
			EXPORT STRING1 Adult:= 'S';
			EXPORT STRING1 None:= '';
		END;
		
		EXPORT WFPhoneType:= MODULE(PhoneFilterType)
			EXPORT STRING1 Landlines:= 'P';
		END;
		
		export Defaults := module
			export string DeceasedMatchCodes := 'S,SC,SZ,SZC,SN,SNC,SNZ,SNZC,SA,SAC,SAZ,SAZC,ANZC,ANS,ANSC,ANSZ,ANSZC,AWSZC, SWZC, AWSC, AWS, SWZC,'+
																					'SWCZ, SWC, SWZ, SW, AVSZC, SVZC, AVSC, AVS, SVZC,SVCZ, SVC, SVZ, SV, AXSZC, SXZC, AXSC, AXS, SXZC,'+
																					'SXCZ, SXC, SXZ, SX, AYSZC, SYZC, AYSC, AYS, SYZC,SYCZ, SYC, SYZ, SY';
			export INTEGER UniqueIdScoreThreshold :=  80;
			export boolean UseDOBDeathMatch := false;
			export boolean IncludeEmail := false;
			export boolean IncludePhone := true;
			export boolean IncludeAddress := true;
			export boolean IncludeDeceased := true;
			export boolean IncludeSSN := true;
			export boolean IncludeGender := true;
			export string25 Phones_Score_Model := 'PHONESCORE_V2';
			export string1	AddressConfidenceThreshold := 'M';
			export string1	PhonesReturnCutoff := 'M';
			
			//MP Enhancements

			EXPORT STRING5 IndustryClass := '';
			EXPORT BOOLEAN ReturnDetailedRoyalties := TRUE;
			EXPORT BOOLEAN AllowNickNames:= FALSE;
			EXPORT BOOLEAN PhoneticMatch:= FALSE;
			EXPORT BOOLEAN Match_City:= TRUE;
			EXPORT BOOLEAN Match_DOB:= FALSE;
			EXPORT BOOLEAN Match_LinkID:= FALSE;
			EXPORT BOOLEAN Match_Name:= FALSE;
			EXPORT BOOLEAN Match_SSN:= FALSE;
			EXPORT BOOLEAN Match_State:= TRUE;
			EXPORT BOOLEAN Match_Street_Address:= TRUE;
			EXPORT BOOLEAN Match_Zip:= TRUE;
			// ADLBest
			EXPORT STRING120 Appends:='VERIFY_ALL,ANY_ALL,BEST_ALL,BEST_EDA';
			EXPORT STRING3 AppendThreshold:= '';
			EXPORT BOOLEAN Deduped:= TRUE;
			EXPORT STRING120 Fuzzies:= '';
			EXPORT BOOLEAN PatriotProcess:= FALSE;
			EXPORT STRING120 Verify:='VERIFY_ALL,ANY_ALL,BEST_ALL';
			//BestAddress
			EXPORT BOOLEAN CalculateV1Scores:= FALSE;
			EXPORT UNSIGNED DateLastSeen:=0;
			EXPORT BOOLEAN DoNOTRollupDateFirstSeen:= FALSE;
			EXPORT BOOLEAN EndWithNextMostCurrent:= FALSE;
			EXPORT BOOLEAN FirstInitialLastNameMatch:= FALSE;
			EXPORT BOOLEAN FirstNameLastNameMatch:= FALSE;
			EXPORT BOOLEAN FirstNameMatch:= FALSE;
			EXPORT BOOLEAN FullNameMatch:= FALSE;
			EXPORT BOOLEAN HistoricMatchCodes:= FALSE;
			EXPORT BOOLEAN Include_Military_Address:= FALSE;
			EXPORT BOOLEAN IncludeBlankDateLastSeen:= FALSE;
			EXPORT BOOLEAN IncludeHistoricRecords:= FALSE;
			EXPORT BOOLEAN InputAddressDedup:= FALSE;
			EXPORT BOOLEAN LastNameMatch:= FALSE;
			EXPORT UNSIGNED1 MaxNameScore:= 255;
			// EXPORT UNSIGNED1 MaxRecordsToReturn:=1;
			EXPORT UNSIGNED1 MinNameScore:=0;
			EXPORT BOOLEAN PartialAddressDedup:= FALSE;
			EXPORT BOOLEAN ReturnAddrPhone:= FALSE;
			EXPORT BOOLEAN ReturnConfidenceFlag:= FALSE;
			EXPORT BOOLEAN ReturnConfirmedMatchCode:= FALSE;
			EXPORT BOOLEAN ReturnCountyName:= TRUE;
			EXPORT BOOLEAN ReturnDedupFlag:= FALSE;
			EXPORT BOOLEAN ReturnFlipFlopIndicator:= FALSE;
			EXPORT BOOLEAN ReturnLatLong:= TRUE;
			EXPORT BOOLEAN ReturnMultiADLIndicator:= FALSE;
			EXPORT BOOLEAN ReturnOverLimitIndicator:= FALSE;
			EXPORT BOOLEAN ReturnSSNLooseMatchIndicator:= FALSE;
			EXPORT BOOLEAN ReturnUnServAddrIndicator:= FALSE;
			EXPORT BOOLEAN StartWithNextMostCurrent:= FALSE;
			EXPORT BOOLEAN UnServAddrDedup:= FALSE;
			EXPORT BOOLEAN UseNameUniqueDID:= FALSE;
			//Deceased
			EXPORT BOOLEAN AddSupplemental:= TRUE;
			EXPORT UNSIGNED2 DaysBack:= 0;
			EXPORT BOOLEAN ExtraMatchCodes:= TRUE;
			EXPORT BOOLEAN IncludeBlankDOD:= FALSE;
			EXPORT BOOLEAN MatchCodeADLAppend:= TRUE;
			EXPORT BOOLEAN NoDIDAppend:= FALSE;
			EXPORT BOOLEAN PartialNameMatchCodes:= TRUE;
			//Email: All common
			//PhoneFinder
			EXPORT UNSIGNED PenaltyThreshold:= 10;
			EXPORT STRING1 PhoneFilter:= PhoneFilterType.None;
			EXPORT STRING1 TransactionType:= PhoneTransactionType.WaterfallPhones;
			//Waterfall
			EXPORT BOOLEAN BlankOutDuplicatePhones:= FALSE;
			EXPORT BOOLEAN DedupInputPhones:= FALSE;
			EXPORT BOOLEAN IncludeLastResort:= FALSE;
			EXPORT UNSIGNED2 MaxNumAssociate:= 50;
			EXPORT UNSIGNED2 MaxNumAssociateOther:= 0;
			EXPORT UNSIGNED2 MaxNumFamilyClose:= 50;
			EXPORT UNSIGNED2 MaxNumFamilyOther:= 0;
			EXPORT UNSIGNED2 MaxNumNeighbor:= 0;
			EXPORT UNSIGNED2 MaxNumParent:= 0;
			EXPORT UNSIGNED2 MaxNumSpouse:= 50;
			EXPORT UNSIGNED2 MaxNumSubject:= 50;
			EXPORT INTEGER MaxPhoneCount:= 3;
			EXPORT BOOLEAN ReturnScore:= TRUE;
			EXPORT BOOLEAN StrictAPSX:= FALSE;
		end;
			
		export unsigned SubjectAdultScore := 100; // between 0-100
		export unsigned InputGuardianAdultScore := 100; // between 0-100
		export unsigned DerivedGuardianAdultScore := 70; // between 0-100
		
		export FillWith := ENUM(BLANK = 0, ADL_BEST = 1 , BEST_ADDRESS = 2 );
		export unsigned AdultAgeStart := 18;
		export unsigned MaxRecordsToReturn := 10;
		export unsigned YearsForCurrentResidency := 0;
		
		export dsForSort := dataset([
				{'ANSZCD',112},{'ANSZC',111},{'ANSZD',110},{'ANSZ',109},{'ANSCD',108},{'ANSC',107},
				{'AVSZCD',106},{'AVSZC',105},{'ANSD',104},{'ANS',103},{'SNZCD',102},{'SNZC',101},
				{'AVSCD',100},{'AVSC',99},{'AXZSCD',98},{'AXSZC',97},{'SNZD',96},{'SNZ',95},{'SNCD',94},
				{'SNC',93},{'AWSZCD',92},{'AWSZC',91},{'SVZCD',90},{'SVZC',89},{'AVSD',88},{'AVS',87},
				{'SVZCD',86},{'SVZC',85},{'SVCZD',84},{'SVCZ',83},{'AXSCD',82},{'AXSC',81},{'AYSZCD',80},
				{'AYSZC',79},{'SND',78},{'SN',77},{'AWSCD',76},{'AWSC',75},{'SVCD',74},{'SVC',73},
				{'SVZD',72},{'SVZ',71},{'SXZCD',70},{'SXZC',69},{'AXSD',68},{'AXS',67},{'AXZCD',66},
				{'SXZC',65},{'SXCZD',64},{'SXCZ',63},{'AYSCD',62},{'AYSC',61},{'SWZCD',60},{'SWZC',59},
				{'AWSD',58},{'AWS',57},{'SWZCD',56},{'SWZC',55},{'SWCZD',54},{'SWCZ',53},{'SVD',52},
				{'SV',51},{'SXCD',50},{'SXC',49},{'SXZD',48},{'SXZ',47},{'SYZCD',46},{'SYZC',45},
				{'AYSD',44},{'AYS',43},{'SYZCD',42},{'SYZC',41},{'SYCZD',40},{'SYCZ',39},{'SWCD',38},
				{'SWC',37},{'SWZD',36},{'SWZ',35},{'SXD',34},{'SX',33},{'SYCD',32},{'SYC',31},{'SYZD',30},
				{'SYZ',29},{'SAZCD',28},{'SAZC',27},{'SWD',26},{'SW',25},{'SYD',24},{'SY',23},
				{'SAZD',22},{'SAZ',21},{'SACD',20},{'SAC',19},{'SZCD',18},{'SZC',17},{'ANZCD',16},{'ANZC',15},
				{'SAD',14},{'SA',13},{'SZD',12},{'SZ',11},{'SCD',10},{'SC',9},{'ANZD',8},{'ANZ',7},{'ANCD',6},
				{'ANC',5},{'SD',4},{'S',3},{'AND',2},{'AN',1}],MemberPoint.Layouts.sortRec);
																				
		export PhoneScore         := ENUM(UNSIGNED, LowMin = 187,LowMax = 310 ,MidMin = 311,MidMax = 579 ,HighMin = 580);
		export AdlBestAddressScore := ENUM(LowMin = 1,LowMax = 59 ,MidMin = 60,MidMax = 79 ,HighMin = 80, HighMax = 100 ,MidAverage = 65);
		export BestAddressScore 	 := ENUM(LowMin = 1,LowMax = 39 ,MidMin = 40,MidMax = 79 ,HighMin = 80, HighMax = 100 );

		//Star rate, intended to replace phones confidence score (High, Middle, Low)
		EXPORT ConfidenceStarRateMod:= MODULE
			EXPORT STRING6 Low:= '3 Star';
			EXPORT STRING6 Mid:= '4 Star';
			EXPORT STRING6 High:= '5 Star';
			EXPORT STRING6 None:= '';
		END;
	end;	