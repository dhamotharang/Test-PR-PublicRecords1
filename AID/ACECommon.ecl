export ACECommon
 :=
  module
		/**************************************************************************************/
		export	eErrStat
		 :=
			module
				/*
				A ACE had to truncate the address line to make it fit into your field.
				B ACE truncated both the address line and the city name.
				C ACE had to truncate the city name to make it fit into your field.
				S ACE didn’t truncate anything.
				E ACE encountered an error
				*/
				export	string4		LastLineMissingOrBad		:=	'E101';
				export	string4		NoCity_BadZip						:=	'E212';
				export	string4		BadCity_GoodState_NoZip	:=	'E213';
				export	string4		BadCity_BadZip					:=	'E214';
				export	string4		BadZip_NoMatchCity			:=	'E216'; // Bad ZIP, can’t determine which city match to select
				export	string4		NoLine1									:=	'E302'; // No primary address line parsed 
				export	string4		NoFindStreet						:=	'E412'; // Street name not found in directory 
				export	string4		NoMatchStreet						:=	'E413'; // Possible street-name matches too close to choose one
				export	string4		NoPrimRange							:=	'E420'; // Primary range is missing 
				export	string4		BadPrimRange						:=	'E421'; // Primary range is invalid for the street/route/building
				export	string4		BadOrMissingPreDir			:=	'E422'; // Predirectional needed, input is wrong or missing
				export	string4		BadOrMissingSuffix			:=	'E423'; // Suffix needed, input is wrong or missing
				export	string4		BadOrMissingSuffixDir		:=	'E425'; // Suffix and directional needed, input is wrong or missing
				export	string4		BadOrMissingDir					:=	'E427'; // [Post] Directional needed, input is wrong or missing
				export	string4		BadZip_NoAddrMatch			:=	'E428'; // Bad ZIP, can’t select an address match 
				export	string4		BadCity_NoAddrMatch			:=	'E429'; // Bad city, can’t select an address match 
				export	string4		NoMatchAddrLine					:=	'E430'; // Possible address-line matches too close to choose one
				export	string4		BadOrMissingUrbanization:=	'E431'; // Urbanization needed, input is wrong or missing
				export	string4		ExactMatchInEWSDir			:=	'E439'; // Exact match made in EWS directory
				export	string4		OtherError							:=	'E500'; // Other error
				export	string4		ForeignAddress					:=	'E501'; // Foreign address
				export	string4		InputEmpty							:=	'E502'; // Input record entirely blank
				export	string4		ZipNotInZip4Directory		:=	'E503'; // ZIP not in area covered by partial ZIP+4 directory
				export	string4		OverlappingZip4Ranges		:=	'E504'; // Overlapping ranges in ZIP+4 directory
				export	string4		UndeliverableNotInUSPS	:=	'E505'; // Address does not exist in the USPS directories, undeliverable address.
				export	string4		USPSMarkedUnsuitable		:=	'E600'; // Marked by USPS as unsuitable for delivery of mail
			end
		 ;

		/**************************************************************************************/
		export	eErrorSource	:=	enum(unsigned4,
																	 LineLast				=	00000000000000010000000000000000b,
																	 City						=	00000000000000100000000000000000b | LineLast,
																	 Zip						=	00000000000001000000000000000000b | LineLast,
                              
																	 Line1					=	00000000000000000000000000000001b,
																	 Street					=	00000000000000000000000000000010b | Line1,
																	 PrimRange			=	00000000000000000000000000000100b | Line1,
																	 PreDir					=	00000000000000000000000000001000b | Line1,
																	 Suffix					=	00000000000000000000000000010000b | Line1,
																	 PostDir				=	00000000000000000000000000100000b | Line1,
																	 Urbanization		=	00000000000000000000000001000000b | Line1,
																	 EWSMatched			=	00000000000000000000000010000000b | Line1,
                              
																	 Other					=	00000001000000000000000000000000b,
																	 Foreign				=	00000010000000000000000000000000b | Other,
																	 Undeliverable	=	00000100000000000000000000000000b | Other,
																	 Unsuitable			=	00001000000000000000000000000000b | Other,		// Note that this is a valid address, but USPS doesn't deliver there
																	 Empty					=	00000000000000000000000000000000b | LineLast | Line1 | Other
																	)
													;

		/**************************************************************************************/
		export	ErrorSource(string pErrStat)
		 :=
			module
				export	unsigned4	LastLineMissingOrBad		:=	eErrorSource.LineLast;
				export	unsigned4	NoCity_BadZip						:=	eErrorSource.City | eErrorSource.Zip;
				export	unsigned4	BadCity_GoodState_NoZip	:=	eErrorSource.City | eErrorSource.Zip;
				export	unsigned4	BadCity_BadZip					:=	eErrorSource.City | eErrorSource.Zip;
				export	unsigned4	BadZip_NoMatchCity			:=	eErrorSource.City | eErrorSource.Zip;
				export	unsigned4	NoLine1									:=	eErrorSource.Line1;
				export	unsigned4	NoFindStreet						:=	eErrorSource.Street;
				export	unsigned4	NoMatchStreet						:=	eErrorSource.Street;
				export	unsigned4	NoPrimRange							:=	eErrorSource.PrimRange;
				export	unsigned4	BadPrimRange						:=	eErrorSource.PrimRange;
				export	unsigned4	BadOrMissingPreDir			:=	eErrorSource.PreDir;
				export	unsigned4	BadOrMissingSuffix			:=	eErrorSource.Suffix;
				export	unsigned4	BadOrMissingSuffixDir		:=	eErrorSource.Suffix | eErrorSource.PostDir;
				export	unsigned4	BadOrMissingPostDir			:=	eErrorSource.PostDir;
				export	unsigned4	BadZip_NoAddrMatch			:=	eErrorSource.Zip | eErrorSource.Line1;
				export	unsigned4	BadCity_NoAddrMatch			:=	eErrorSource.City | eErrorSource.Line1;
				export	unsigned4	NoMatchAddrLine					:=	eErrorSource.Line1;
				export	unsigned4	BadOrMissingUrbanization:=	eErrorSource.Urbanization;
				export	unsigned4	ExactMatchInEWSDir			:=	eErrorSource.EWSMatched;
				export	unsigned4	OtherError							:=	eErrorSource.Other;
				export	unsigned4	ForeignAddress					:=	eErrorSource.Foreign;
				export	unsigned4	InputEmpty							:=	eErrorSource.Empty;
				export	unsigned4	ZipNotInZip4Directory		:=	eErrorSource.Zip;
				export	unsigned4	OverlappingZip4Ranges		:=	eErrorSource.Zip;
				export	unsigned4	UndeliverableNotInUSPS	:=	eErrorSource.Undeliverable;
				export	unsigned4	USPSMarkedUnsuitable		:=	eErrorSource.Unsuitable;
			end
		 ;

		/**************************************************************************************/
		export	ChangeSource(string pErrStat)
		 :=
			module
				shared	string1		lErrStatByte1	:=	pErrStat[1];
				shared	unsigned1	lErrStatByte2	:=	if(lErrStatByte1 <> 'E',(unsigned1)pErrStat[2],0);
				shared	unsigned1	lErrStatByte3	:=	if(lErrStatByte1 <> 'E',(unsigned1)pErrStat[3],0);
				shared	unsigned1	lErrStatByte4	:=	if(lErrStatByte1 <> 'E',(unsigned1)pErrStat[4],0);

				shared	Byte2Flags	:=	enum(unsigned1,
																		 ChangedNone		=	00000000b,
																		 ChangedZip5		=	00000001b,
																		 ChangedCity		=	00000010b,
																		 ChangedState		=	00000100b,
																		 ChangedZip4		=	00001000b
																		)
														;
				export	boolean		IsChangedZip5			:=	lErrStatByte2 & Byte2Flags.ChangedZip5		= Byte2Flags.ChangedZip5;
				export	boolean		IsChangedCity			:=	lErrStatByte2 & Byte2Flags.ChangedCity		= Byte2Flags.ChangedCity;
				export	boolean		IsChangedState		:=	lErrStatByte2 & Byte2Flags.ChangedState		= Byte2Flags.ChangedState;
				export	boolean		IsChangedZip4			:=	lErrStatByte2 & Byte2Flags.ChangedZip4		= Byte2Flags.ChangedZip4;

				shared	Byte3Flags	:=	enum(unsigned1,
																		 ChangedNone			=	00000000b,
																		 ChangedSuffix		=	00000001b,
																		 ChangedPreDir		=	00000010b,
																		 ChangedPostDir		=	00000100b,
																		 ChangedPrimName	=	00001000b
																		)
														;   
				export	boolean		IsChangedSuffix			:=	lErrStatByte3 & Byte3Flags.ChangedSuffix	= Byte3Flags.ChangedSuffix;
				export	boolean		IsChangedPreDir			:=	lErrStatByte3 & Byte3Flags.ChangedPreDir	= Byte3Flags.ChangedPreDir;
				export	boolean		IsChangedPostDir		:=	lErrStatByte3 & Byte3Flags.ChangedPostDir	= Byte3Flags.ChangedPostDir;
				export	boolean		IsChangedPrimName		:=	lErrStatByte3 & Byte3Flags.ChangedPrimName	= Byte3Flags.ChangedPrimName;

				shared	Byte4Flags	:=	enum(unsigned1,
																		 ChangedNone			=	00000000b,
																		 ChangedUnitDesig	=	00000001b,
																		 ChangedDPBC			=	00000010b,
																		 ChangedCART			=	00000100b,
																		 ChangedCountyNum	=	00001000b
																		)
														;
				export	boolean		IsChangedUnitDesig		:=	lErrStatByte4 & Byte4Flags.ChangedUnitDesig	= Byte4Flags.ChangedUnitDesig;
				export	boolean		IsChangedDPBC					:=	lErrStatByte4 & Byte4Flags.ChangedDPBC		= Byte4Flags.ChangedDPBC;
				export	boolean		IsChangedCART					:=	lErrStatByte4 & Byte4Flags.ChangedCART		= Byte4Flags.ChangedCART;
				export	boolean		IsChangedCountyNum		:=	lErrStatByte4 & Byte4Flags.ChangedCountyNum	= Byte4Flags.ChangedCountyNum;

				export	boolean		IsForeignAddress			:=	pErrStat = 'E501';
			end
		 ;
  end
 ;
