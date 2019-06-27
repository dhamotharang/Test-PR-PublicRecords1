	EXPORT	xxwarningcodes := ENUM(
		W101 = 0x000001,				// Invalid/Missing Race Value, Set to "U"
		W102 = 0x000002,				// Invalid/Missing Gender Value, Set to "U"
		W103 = 0x000004,				// Invalid/Missing Ethnicity Value, Set to "U"
		W104 = 0x000008,				// Invalid/Missing ABAWD Indicator, Set to "U"
		W105 = 0x000010,				// Invalid Character in Name, Changed to "?"
		W106 = 0x000020,				// Invalid Relationship Indicator, Changed to "O"
		W107 = 0x000040,				// Invalid Character in Address, Changed to "?"
		W108 = 0x000080,				// Invalid Address Category, Changed to Blank
		W109 = 0x000100,				// Invalid Monthly Allotment Value
		W110 = 0x000200,				// Invalid Historical Benefit Count
		W111 = 0x000400,				// Missing street in address
		W112 = 0x000800,				// Invalid/Missing Eligibility Effective Date
		W113 = 0x001000,				// Invalid Postal Address
		W114 = 0x002000					// Postal Address cleaned with warnings
	);
